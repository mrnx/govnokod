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

            case 'user':
                $id = $this->request->getInteger('id');

                $userMapper = $this->toolkit->getMapper('user', 'user');
                $user = $userMapper->searchByKey($id);

                if (!$user) {
                    return $this->forward404($user);
                }

                $params['user_id'] = $user->getId();
                $params['order'] = 'created desc';

                $pager = $this->setPager($quoteMapper, 10, true, 4);
                $quotes = $quoteMapper->searchAllByParams($params);

                if ($user->getQuotesCount() != $pager->getItemsCount()) {
                    $user->setQuotesCount($pager->getItemsCount());
                    $userMapper->save($user);
                }

                $this->view->assign('list_user', $user);

                break;

            case 'paper':
                $params['order'] = 'created desc';
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