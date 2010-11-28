<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2009
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

/**
 * commentsExportController
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */
class commentsExportController extends simpleController
{
    protected function getView()
    {
        $exportType = $this->getExportType();
        if ($exportType == 'rss') {
            $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder');
            $id = $this->request->getInteger('id');
            $commentsFolder = $commentsFolderMapper->searchById($id);

            if (!$commentsFolderMapper) {
                return $this->forward404($commentsFolderMapper);
            }

            if ($commentsFolder->getModule() == 'quoter' && $commentsFolder->getType() == 'quote') {
                $this->response->setHeader('Content-type', 'application/rss+xml; charset=utf-8;');

                $comments = $commentsFolder->getComments();

                $this->view->assign('commentsFolder', $commentsFolder);
                $this->view->assign('comments', $comments);
                return $this->view->render('comments/service/export_quote_rss.tpl', 'native');
            }
        }

        return;
    }

    protected function getExportType()
    {
        //$action = $this->request->getAction();
        return 'rss';
    }
}
?>