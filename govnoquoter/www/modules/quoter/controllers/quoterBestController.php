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
 * quoterBestController: контроллер для метода best модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterBestController extends simpleController
{
    protected function getView()
    {
        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $criteria = new criteria;

        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
        $categories = $categoryMapper->searchAll();
        $this->smarty->assign('categories', $categories);

        $name = $this->request->getString('name');

        $category = null;
        foreach ($categories as $cat) {
            if ($cat->getName() == $name) {
                $category = $cat;
                break;
            }
        }

        if ($category) {
            $criteria->add('category_id', $category->getId());
        }

        $this->smarty->assign('category', $category);

        $time = $this->request->getString('time', SC_GET);
        switch ($time) {
            case 'month':
                $nowTime = time();
                $lastMonthTime = strtotime('-1 month', $nowTime);

                $criteria->add('created', $nowTime, criteria::LESS_EQUAL)->add('created', $lastMonthTime, criteria::GREATER_EQUAL);
                break;

            case 'week':
                $nowTime = time();
                $lastWeekTime = strtotime('-1 week', $nowTime);

                $criteria->add('created', $nowTime, criteria::LESS_EQUAL)->add('created', $lastWeekTime, criteria::GREATER_EQUAL);
                break;

            case 'ever':
            default:
                $time = 'ever';
                break;
        }

        $this->smarty->assign('time', $time);
        $criteria->setOrderByFieldDesc('rating')->setLimit(10);

        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('quotes', $quotes);
        return $this->smarty->fetch('quoter/best.tpl');
    }
}

?>