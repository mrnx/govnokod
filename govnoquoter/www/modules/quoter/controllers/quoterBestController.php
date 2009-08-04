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
        $criteria->add('active', 1);

        $category = null;
        $name = $this->request->getString('name');
        if ($name) {
            $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
            $category = $categoryMapper->searchByName($name);

            if (!$category) {
                return $this->forward404($categoryMapper);
            }

            $criteria->add('category_id', $category->getId());
        }

        $this->smarty->assign('category', $category);

        $nowTime = time();

        $time = $this->request->getString('time', SC_GET);
        switch ($time) {
            case 'month':
                $lastMonthTime = strtotime('-1 month', $nowTime);

                $criteria->add('created', array($lastMonthTime, $nowTime), criteria::BETWEEN);
                break;

            case 'week':
                $lastWeekTime = strtotime('-1 week', $nowTime);

                $criteria->add('created', array($lastWeekTime, $nowTime), criteria::BETWEEN);
                break;

            case 'ever':
                $time = 'ever';
                break;

            case 'day':
            default:
                $time = 'day';
                $lastDayTime = strtotime('-1 day', $nowTime);
                $criteria->add('created', array($lastDayTime, $nowTime), criteria::BETWEEN);
                break;
        }

        $this->smarty->assign('time', $time);

        $nomination = $this->request->getString('nomination');
        switch ($nomination) {
            case 'comments':
                $criteria->add('comments_count', 0, criteria::GREATER)->setOrderByFieldDesc('comments_count')->setLimit(10);
                break;

            case 'rating':
            default:
                $nomination = 'rating';
                $criteria->add('rating', 0, criteria::GREATER)->setOrderByFieldDesc('rating')->setLimit(10);
                break;
        }

        $this->smarty->assign('nomination', $nomination);

        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('quotes', $quotes);
        return $this->smarty->fetch('quoter/best.tpl');
    }
}

?>