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
 * quoterSearchController: контроллер для метода searchAll модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterSearchController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();

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

        $mode = $this->request->getString('mode');
        switch ($mode) {
            case 'dabest':
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
                break;

            default:
                $mode = 'word';

                $word = trim($this->request->getString('search', SC_GET));
                $word = mb_substr($word, 0, 50);
                if ($word) {
                    $criteria->add('text', '%' . $word . '%', criteria::LIKE);
                }
                $this->smarty->assign('word', $word);
                $this->setPager($quoteMapper, 10, true);
                break;
        }

        $quotes = $quoteMapper->searchAllByCriteria($criteria);

        $this->smarty->assign('quotes', $quotes);
        $this->smarty->assign('mode', $mode);
        return $this->smarty->fetch('quoter/search.tpl');
    }
}

?>