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
 * userPreferencesController
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */
class userPreferencesController extends simpleController
{
    protected function getView()
    {
        $user = $this->toolkit->getUser();

        $drivers = array(
            'js' => 'HighlightJS',
            'geshi' => 'Geshi',
        );

        $validator = new formValidator();
        $validator->add('required', 'hdriver', 'Укажите способ подсветки кода');
        $validator->add('in', 'hdriver', 'Укажите способ подсветки кода из списка', array_keys($drivers));
        if ($validator->validate()) {
            $driver = $this->request->getString('hdriver', SC_POST);

            $userMapper = $this->toolkit->getMapper('user', 'user');
            $user->setHighlightDriver($driver);
            $userMapper->save($user);

            $this->redirect('/');
            return;
        }

        $url = new url('default2');
        $url->setAction('preferences');

        $this->smarty->assign('form_action', $url->get());
        $this->smarty->assign('drivers', $drivers);
        $this->smarty->assign('user', $user);
        return $this->smarty->fetch('user/preferences.tpl');
    }
}

?>