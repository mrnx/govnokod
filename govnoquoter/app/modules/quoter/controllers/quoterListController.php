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
 * @version 0.2
 */
class quoterListController extends simpleController
{
    protected function getView()
    {
        //$action = $this->request->getAction();
        //$listAll = ($action == 'listAll');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quoteCategoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        $params = array();

        $type = $this->request->getString('type');
        switch ($type) {
            case 'all':
                $user = $this->toolkit->getUser();
                if ($user->getPreferredLangs()) {
                    $params['category_id'] = $user->getPreferredLangs();
                } else {
                    $params['not_category_id'] = quoteCategoryMapper::TRASH_CATEGORY_ID;
                }

                $params['order'] = array(
                    'last_comment_id desc',
                    'created desc'
                );

                break;

            case 'category':
                $name = $this->request->getString('name');

                $category = $quoteCategoryMapper->searchByName($name);

                if (!$category) {
                    return $this->forward404($categoryMapper);
                }

                $params['category_id'] = $category->getId();
                $this->view->assign('list_category', $category);

                $params['order'] = 'created desc';

                break;

            case 'paper':
                $params['order'] = 'created desc';
                break;
        }

        $pager = $this->setPager($quoteMapper, 10, true, 4);
        $quotes = $quoteMapper->searchAllByParams($params);

        /*
        $criteria = new criteria;
        $criteria->where('active', 1);

        if (!$listAll) {
            $name = $this->request->getString('name');

            $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
            $category = $categoryMapper->searchByName($name);

            if (!$category) {
                return $this->forward404($categoryMapper);
            }

            $criteria->where('category_id', $category->getId());
            $this->view->assign('list_category', $category);
        } else {
            $user = $this->toolkit->getUser();
            if ($user->getPreferredLangs()) {
                $criteria->where('category_id', $user->getPreferredLangs(), criteria::IN);
            }
        }

        $criteria->orderByDesc('last_comment_id')->orderByDesc('created');

        $pager = $this->setPager($quoteMapper, 10, true, 4);
        $quotes = $quoteMapper->searchAllByCriteria($criteria);



        //если получаем список конкретной категории, то есть шанс пересчитать количество элементов в категории
        if (!$listAll) {
            if ($category->getQuoteCounts() != $pager->getItemsCount()) {
                $category->setQuoteCounts($pager->getItemsCount());
                $categoryMapper->save($category);
            }
        }

        $this->view->assign('quotes', $quotes);
        $this->view->assign('listAll', $listAll);

        */

        $this->view->assign('quotes', $quotes);
        $this->view->assign('type', $type);
        return $this->view->render('quoter/list.tpl', 'native');
    }
}

?>