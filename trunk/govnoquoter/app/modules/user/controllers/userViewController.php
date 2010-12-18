<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2009
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

/**
 * userViewController
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */
class userViewController extends simpleController
{
    protected function getView()
    {
        $userMapper = $this->toolkit->getMapper('user', 'user');
        $user = $this->toolkit->getUser();

        $viewuser = null;

        $id = $this->request->getString('id');
        $login = $this->request->getString('login');
        if ($login) {
            $viewuser = $userMapper->searchByLogin($login);
        } else if ($id) {
            $viewuser = $userMapper->searchByKey($id);
        }

        if (!$viewuser) {
            return $this->forward404($userMapper);
        }

        $this->view->assign('viewuser', $viewuser);

        if ($viewuser->getId() == $user->getId()) {
            return $this->view->render('user/profile/me.tpl', 'native');
        } else {
            return $this->view->render('user/profile/user.tpl', 'native');
        }
    }
}

?>