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
        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quoteCategoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        $params = array();

        $type = $this->request->getString('type');
        switch ($type) {
            case 'all':
                $user = $this->toolkit->getUser();
                if ($user->getPreferredLangs()) {
                    $params['category_id'] = $user->getPreferredLangs();
                }

                $params['order'] = 'last_comment_id desc';

                break;

            case 'category':
                $name = $this->request->getString('name');

                $category = $quoteCategoryMapper->searchByName($name);

                if (!$category) {
                    return $this->forward404($categoryMapper);
                }

                $params['category_id'] = $category->getId();
                $this->view->assign('list_category', $category);

                break;

            case 'user':
                $login = $this->request->getString('login');

                $userMapper = $this->toolkit->getMapper('user', 'user');
                $user = $userMapper->searchByLogin($login);

                if (!$user) {
                    return $this->forward404($user);
                }

                $params['user_id'] = $user->getId();

                $pager = $this->setPager($quoteMapper, 10, true, 4);
                $quotes = $quoteMapper->searchAllByParams($params);

                if ($user->getQuotesCount() != $pager->getItemsCount()) {
                    $user->setQuotesCount($pager->getItemsCount());
                    $userMapper->save($user);
                }

                $this->view->assign('list_user', $user);

                break;

            case 'search':
                $keyword = trim($this->request->getString('keyword', SC_GET));

                if ($keyword) {
                    $params['keyword'] = $keyword;
                }

                $search_categories = $quoteCategoryMapper->searchAll();

                $search_categories_select = array();
                foreach ($search_categories as $search_category) {
                    $search_categories_select[$search_category->getId()] = $search_category->getTitle();
                }

                $language_id = $this->request->getString('language', SC_GET);
                if ($language_id && isset($search_categories_select[$language_id])) {
                    $params['category_id'] = $language_id;
                }

                $this->view->assign('search_categories_select', $search_categories_select);
                $this->view->assign('keyword', $keyword);
                break;

            case 'best':
                $best_type = $this->request->getString('best_type');
                $period = $this->request->getString('period');

                $this->view->assign('best_type', $best_type);
                $this->view->assign('period', $period);

                $params['order'] = 'rating desc';
                break;

            case 'paper':
                break;
        }

        if (!isset($quotes)) {
            $pager = $this->setPager($quoteMapper, 10, true, 4);
            $quotes = $quoteMapper->searchAllByParams($params);
        }

        $this->view->assign('quotes', $quotes);
        $this->view->assign('type', $type);

        $format = $this->request->getString('format');
        if ($format == 'rss') {
            $this->view->disableMain();
            return $this->view->render('quoter/service/listRss.tpl', 'native');
        }

        return $this->view->render('quoter/list.tpl', 'native');
    }
}

?>