<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2008
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('forms/validators/formValidator');

/**
 * ratingsViewController: контроллер для метода view модуля ratings
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */

class ratingsViewController extends simpleController
{
    protected function getView()
    {
        $ratingsFolderMapper = $this->toolkit->getMapper('ratings', 'ratingsFolder');

        $object = $this->request->getRaw('object');
        if (!$object instanceof entity) {
            throw new mzzInvalidParameterException('Invalid object for ratings');
        }

        $objectModule = $object->module();
        $objectType = get_class($object);

        $objectMapper = $this->toolkit->getMapper($objectModule, $objectType);

        if ($objectMapper->isAttached('ratings')) {
            $byField = $objectMapper->plugin('ratings')->getByField();
        } else {
            throw new mzzInvalidParameterException('Attach a ratingsPlugin for rate object');
        }

        $ratingsFolder = $object->getRatingsFolder();

        if (!$ratingsFolder) {
            $map = $objectMapper->map();
            if (!isset($map[$byField])) {
                throw new mzzInvalidParameterException('Invalid byField value for ratings');
            }

            $objectId = $object->$map[$byField]['accessor']();

            if (!is_numeric($objectId)) {
                throw new mzzInvalidParameterException('Invalid objectId for ratings');
            }

            //$ratingsFolder = $ratingsFolderMapper->searchFolder($objectType, $objectId);

            $ratingsFolder = $ratingsFolderMapper->create();
            $ratingsFolder->setModule($objectModule);
            $ratingsFolder->setType($objectType);
            $ratingsFolder->setByField($byField);
            $ratingsFolder->setParentId($objectId);
            $ratingsFolderMapper->save($ratingsFolder);
        }

        $this->smarty->assign('ratingsFolder', $ratingsFolder);
        return $this->fetch('ratings/view.tpl');
    }
}

?>