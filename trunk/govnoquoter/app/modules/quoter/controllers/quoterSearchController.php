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
        $criteria->where('active', 1);

        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
        $categories = $categoryMapper->searchAll();
        $this->smarty->assign('categories', $categories);

        $name = $this->request->getString('language', SC_GET);

        $category = null;
        $categorySelect = array();
        foreach ($categories as $cat) {
            $categorySelect[$cat->getName()] = $cat->getTitle();
            if ($cat->getName() == $name) {
                $category = $cat;
            }
        }

        if ($category) {
            $criteria->where('category_id', $category->getId());
        }

        $this->view->assign('category', $category);

        $quotes = array();

        $mode = $this->request->getString('mode');
        switch ($mode) {
            default:
                $this->setPager($quoteMapper, 10, true, 4);
                $mode = 'word';

                $word = trim($this->request->getString('search', SC_GET));
                $word = mb_substr($word, 0, 50);
                if ($word) {
                    //$criteria->add('active', 1)->setOrderByFieldDesc('created');

                    $criterion = new criterion('text', '%' . $word . '%', criteria::LIKE);
                    $criterion->addOr(new criterion('description', '%' . $word . '%', criteria::LIKE));

                    $criteria->where($criterion);

                    $quotes = $quoteMapper->searchAllByCriteria($criteria);
                }

                $this->view->assign('word', $word);
                break;
        }

        $this->view->assign('quotes', $quotes);
        $this->view->assign('categorySelect', $categorySelect);
        $this->view->assign('mode', $mode);
        return $this->view->render('quoter/search.tpl', 'native');
    }
}

?>