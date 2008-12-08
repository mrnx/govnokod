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
 * quoterExportCommentsController: контроллер для метода exportComments модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterExportCommentsController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();
        $exportAll = ($action == 'exportAllComments');

        $criteria = new criteria;
        $criteria->setOrderByFieldDesc('time')->setLimit(50);

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $commentsMapper = $this->toolkit->getMapper('comments', 'comments', 'comments');
        $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder', 'comments');

        if (!$exportAll) {
            $id = $this->request->getInteger('id');

            $quote = $quoteMapper->searchById($id);
            if (!$quote) {
                return $quoteMapper->get404()->run();
            }

            $this->smarty->assign('quote', $quote);
            $criteria->add('folder_id.parent_id', $quote->getObjId());
        } else {
            $criteria->setDistinct();
            $criteria->addJoin($quoteMapper->getTable(), new criterion('folder_id.parent_id', $quoteMapper->getTable() . '.obj_id', criteria::EQUAL, true), null, criteria::JOIN_INNER);
        }

        $comments = $commentsMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('exportAll', $exportAll);
        $this->smarty->assign('comments', array_reverse($comments));
        $this->response->setHeader('Content-type', 'text/xml; charset=utf-8;');
        return $this->smarty->fetch('quoter/exportCommentsRss.tpl');
    }
}

?>