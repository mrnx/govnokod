<?php
/**
 * $URL: https://govnokod.googlecode.com/svn/trunk/govnoquoter/app/modules/comments/controllers/commentsFolderListController.php $
 *
 * MZZ Content Management System (c) 2006
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id: commentsFolderListController.php 345 2010-09-08 12:04:53Z wiistriker $
*/

/**
 * commentsUserCommentsController: контроллер для метода userComments модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.0.1
 */
class commentsUserCommentsController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');

        $userMapper = $this->toolkit->getMapper('user', 'user');
        $user = $userMapper->searchByKey($id);

        if (!$user) {
            return $this->forward404($user);
        }

        $commentsMapper = $this->toolkit->getMapper('comments', 'comments');
        $this->setPager($commentsMapper, 10, true, 4);

        $comments = $commentsMapper->searchUserCommentsForType($user->getId(), 'quote');

        $this->view->assign('user', $user);
        $this->view->assign('comments', $comments);

        return $this->view->render('comments/userComments.tpl', 'native');
    }
}

?>