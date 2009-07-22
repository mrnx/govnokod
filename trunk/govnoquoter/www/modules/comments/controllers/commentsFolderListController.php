<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2006
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
*/

/**
 * commentsFolderListController: контроллер для метода list модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1.1
 */

class commentsFolderListController extends simpleController
{
    protected function getView()
    {
        $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder');

        $object = $this->request->getRaw('object');
        if (!$object instanceof entity) {
            throw new mzzInvalidParameterException('Invalid object for comments');
        }

        $objectModule = $object->module();
        $objectType = get_class($object);

        $objectMapper = $this->toolkit->getMapper($objectModule, $objectType);

        if ($objectMapper->isAttached('comments')) {
            //Если у комментируемого маппера приаттачен плагин comments, то берем поле из плагина
            $byField = $objectMapper->plugin('comments')->getByField();
        } elseif ($objectMapper->isAttached('obj_id')) {
            //Если нет плагина comments, но есть плагин obj_id, то связь будет по полю obj_id
            $byField = $objectMapper->plugin('obj_id')->getObjIdField();
        } else {
            //иначе пробуем связаться по первичному ключу
            $byField = $objectMapper->pk();
        }

        $map = $objectMapper->map();
        if (!isset($map[$byField])) {
            throw new mzzInvalidParameterException('Invalid byField value for comments');
        }

        $objectId = $object->$map[$byField]['accessor']();

        if (!is_numeric($objectId)) {
            throw new mzzInvalidParameterException('Invalid objectId for comments');
        }

        $commentsFolder = $commentsFolderMapper->searchFolder($objectType, $objectId);

        if (!$commentsFolder) {
            $commentsFolder = $commentsFolderMapper->create();
            $commentsFolder->setModule($objectModule);
            $commentsFolder->setType($objectType);
            $commentsFolder->setByField($byField);
            $commentsFolder->setParentId($objectId);
            $commentsFolderMapper->save($commentsFolder);
        }

        $comments = $commentsFolder->getComments();

        //lazy проверка на количество камментов
        if ($objectMapper->isAttached('comments')) {
            $commentsCount = $comments->count();
            if ($object->getCommentsCount() != $commentsCount) {
                $object->setCommentsCount($commentsCount);
                $objectMapper->save($object);
            }
        }

        $this->smarty->assign('commentsFolder', $commentsFolder);
        $this->smarty->assign('comments', $comments);
        return $this->fetch('comments/list.tpl');
    }
}

?>