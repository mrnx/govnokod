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
        $id = $this->request->getInteger('id');

        $userMapper = $this->toolkit->getMapper('user', 'user');
        $user = $userMapper->searchById($id);

        if (!$user) {
            return $this->forward404($userMapper);
        }

        $this->smarty->assign('viewuser', $user);
        return $this->smarty->fetch('user/view.tpl');
    }
}

?>