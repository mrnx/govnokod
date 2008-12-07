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

/**
 * commentsExportController: контроллер для метода rss модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */

class commentsExportController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');

        $commentsMapper = $this->toolkit->getMapper('comments', 'comments', 'comments');
        $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder', 'comments');

        $criteria = new criteria;
        if ($id != -1) {
            $folder = $commentsFolderMapper->searchOneByField('parent_id', $id);
            if (!$folder) {
                return $commentsFolderMapper->get404()->run();
            }

            $criteria->add('folder_id', $id);
        }

        $criteria->setOrderByFieldDesc('time')->setLimit(50);
        $comments = $commentsMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('folder', $folder);
        $this->smarty->assign('comments', $comments);
        return $this->smarty->fetch('comments/rss.tpl');
    }
}

?>