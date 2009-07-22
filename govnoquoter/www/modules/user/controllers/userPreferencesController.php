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

        $type = $this->request->getString('name');
        switch ($type) {
            case 'personal':
                $validator = new formValidator();
                $validator->add('in', 'avatar', 'Выберите способ отображения аватара из списка!', array(1, 2));
                if ($validator->validate()) {
                    $avatar = $this->request->getInteger('avatar', SC_POST);
                    $user->setAvatarType($avatar);

                    $userMapper = $this->toolkit->getMapper('user', 'user');
                    $userMapper->save($user);

                    $this->redirect('/');
                    return;
                }

                $this->setTemplatePrefix('personal_');
                break;

            default:
                $type = 'global_';

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

                $this->smarty->assign('drivers', $drivers);
                $this->setTemplatePrefix('global_');
                break;
        }

        $url = new url('withAnyParam');
        $url->add('name', $type);
        $url->setAction('preferences');

        $this->smarty->assign('form_action', $url->get());

        $this->smarty->assign('user', $user);
        $this->smarty->assign('type', $type);
        return $this->fetch('user/preferences.tpl');
    }
}

?>