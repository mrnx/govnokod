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
 * quoterExportController: контроллер для метода rss модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterExportController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();

        $criteria = new criteria;
        $criteria->add('active', 1)->setOrderByFieldDesc('created')->setLimit(50);

        $name = $this->request->getString('name');
        if ($name) {
            $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
            $category = $categoryMapper->searchByName($name);
            if ($category) {
                $criteria->add('category_id', $category->getId());
                $this->smarty->assign('category', $category);
            }
        }

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('quotes', $quotes);

        $this->smarty->assign('withCategory', (isset($category)));

        if ($action == 'rss') {
            $this->response->setHeader('Content-type', 'text/xml; charset=utf-8;');
            return $this->smarty->fetch('quoter/rss.tpl');
        }
    }
}

?>