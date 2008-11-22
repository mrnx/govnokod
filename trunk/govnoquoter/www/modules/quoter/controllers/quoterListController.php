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

        $criteria = new criteria;
        $criteria->setOrderByFieldDesc('created');

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
                return $categoryMapper->get404()->run();
            }

            $criteria->add('category_id', $category->getId());
            $this->smarty->assign('category', $category);
        }

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('quotes', $quotes);
        $this->smarty->assign('listAll', $listAll);
        return $this->smarty->fetch('quoter/list.tpl');
    }
}

?>