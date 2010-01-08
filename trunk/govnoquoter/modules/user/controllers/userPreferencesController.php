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
                $validator->rule('in', 'avatar', 'Выберите способ отображения аватара из списка!', array(1, 2));
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
                $type = 'global';

                $userMapper = $this->toolkit->getMapper('user', 'user');
                $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

                $drivers = $userMapper->getHighlighDrivers();
                $categories = $categoryMapper->searchAll();

                $validator = new formValidator();
                $validator->rule('required', 'hdriver', 'Укажите способ подсветки кода');
                $validator->rule('in', 'hdriver', 'Укажите способ подсветки кода из списка', array_keys($drivers));
                $validator->rule('required', 'avatar', 'Укажите способ отображения юзерпика!');
                $validator->rule('in', 'avatar', 'Выберите способ отображения юзерпика из списка!', array(1, 2));
                $validator->rule('required', 'lang', 'Должен быть выбран хотя бы один язык!');

                $timezones = $userMapper->getTimezones();
                $validator->rule('required', 'timezone', 'Укажите часовой пояс!');
                $validator->rule('in', 'timezone', 'Укажите часовой пояс из списка!', array_keys($timezones));

                if ($validator->validate()) {
                    $avatar = $this->request->getInteger('avatar', SC_POST);
                    $driver = $this->request->getString('hdriver', SC_POST);
                    $langs = $this->request->getArray('lang', SC_POST);
                    $timezone = $this->request->getNumeric('timezone', SC_POST);

                    if (sizeof($langs) == sizeof($categories)) {
                        $user->setPreferredLangs(false);
                    } else {
                        $preferredLangs = array();
                        foreach ($langs as $lang => $val) {
                            if (isset($categories[$lang])) {
                                $preferredLangs[] = $lang;
                            }
                        }

                        $user->setPreferredLangs($preferredLangs);
                    }

                    $user->setAvatarType($avatar);
                    $user->setHighlightDriver($driver);
                    $user->setTimezone($timezone);
                    $userMapper->save($user);

                    $url = new url('default2');
                    $url->setModule('user');
                    $url->setAction('login');

                    $this->redirect($url->get());
                    return;
                }

                $this->smarty->assign('drivers', $drivers);
                $this->smarty->assign('categories', $categories);
                $this->smarty->assign('timezones', $timezones);
                $this->setTemplatePrefix('global_');
                break;
        }

        $url = new url('default2');
        $url->setModule('user');
        $url->setAction('preferences');

        $this->smarty->assign('form_action', $url->get());
        $this->smarty->assign('validator', $validator);

        $this->smarty->assign('user', $user);
        $this->smarty->assign('type', $type);
        return $this->fetch('user/preferences.tpl');
    }
}

?>