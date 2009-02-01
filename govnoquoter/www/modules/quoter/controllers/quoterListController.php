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
 * quoterListController: контроллер для метода list модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterListController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();
        $listAll = ($action == 'listAll');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quoteMapper->clearSuxx();

        $criteria = new criteria;
        $criteria->add('active', 1)->setOrderByFieldDesc('created');

        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
        $categories = $categoryMapper->searchAll();
        $this->smarty->assign('categories', $categories);

        if (!$listAll) {
            $name = $this->request->getString('name');

            $category = null;
            foreach ($categories as $cat) {
                if ($cat->getName() == $name) {
                    $category = $cat;
                    break;
                }
            }

            if (!$category) {
                return $this->forward404($categoryMapper);
            }

            $criteria->add('category_id', $category->getId());
            $this->smarty->assign('category', $category);
        }

        $pager = $this->setPager($quoteMapper, 10, true, 4);
        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        //если получаем список конкретной категории, то есть шанс пересчитать количество элементов в категории
        if (!$listAll) {
            if ($category->getQuoteCounts() != $pager->getItemsCount()) {
                $category->setQuoteCounts($pager->getItemsCount());
                $categoryMapper->save($category);
            }
        }

        $this->smarty->assign('quotes', $quotes);
        $this->smarty->assign('listAll', $listAll);
        return $this->smarty->fetch('quoter/list.tpl');
    }
}

?>