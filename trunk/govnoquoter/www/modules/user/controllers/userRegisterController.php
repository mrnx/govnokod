<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2006
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('forms/validators/formValidator');

/**
 * userRegisterController: контроллер для метода register модуля user
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */

class userRegisterController extends simpleController
{
    protected function getView()
    {
        $userMapper = $this->toolkit->getMapper('user', 'user');
        $user = $this->toolkit->getUser();

        if ($user->isLoggedIn()) {
            $url = new url('default2');
            $url->setModule('user');
            $url->setAction('login');

            $this->redirect($url->get());
            return;
        }

        $userId = $this->request->getInteger('user', SC_GET);
        $confirm = $this->request->getString('confirm', SC_GET);

        if (empty($userId) || empty($confirm)) {
            $validator = new formValidator();
            $validator->add('required', 'login', 'Необходимо указать логин');
            $validator->add('required', 'password', 'Необходимо указать пароль');
            $validator->add('required', 'email', 'Необходимо указать обратный e-mail');
            $validator->add('email', 'email', 'Необходимо указать правильный e-mail');
            $validator->add('required', 'repassword', 'Необходимо указать повтор пароль');
            $validator->add('callback', 'login', 'Пользователь с таким логином уже существует', array(array($this, 'checkUniqueUserLogin'), $userMapper));
            $validator->add('callback', 'repassword', 'Повтор пароля не совпадает', array(array($this, 'checkRepass'), $this->request->getString('password', SC_POST)));

            $timezones = $userMapper->getTimezones();
            $validator->add('required', 'timezone', 'Укажите часовой пояс!');
            $validator->add('in', 'timezone', 'Укажите часовой пояс из списка!', array_keys($timezones));

            $validator->add('required', 'timezone', 'Укажите часовой пояс!');
            $validator->add('in', 'timezone', 'Укажите часовой пояс из списка!', array_keys($timezones));

            $url = new url('default2');
            $url->setAction('register');

            if (!$validator->validate()) {
                $this->smarty->assign('form_action', $url->get());
                $this->smarty->assign('timezones', $timezones);
                $this->smarty->assign('errors', $validator->getErrors());
                return $this->smarty->fetch('user/register.tpl');
            } else {
                $login = $this->request->getString('login', SC_POST);
                $password = $this->request->getString('password', SC_POST);
                $email = $this->request->getString('email', SC_POST);
                $timezone = $this->request->getNumeric('timezone', SC_POST);

                $user = $userMapper->create();
                $user->setLogin($login);
                $user->setPassword($password);
                $user->setTimezone($timezone);
                $user->setCreated(mktime());
                $confirm = md5($email . mktime());
                $user->setConfirmed($confirm);
                $userMapper->save($user);

                $url->add('user', $user->getId(), true);
                $url->add('confirm', $confirm, true);
                $this->smarty->assign('url', $url->get());

                if (mail($email, 'Подтверждения регистрации', $this->smarty->fetch('user/mail.tpl'))) {
                    return $this->smarty->fetch('user/success.tpl');
                } else {
                    return 'ошибка... не знаю чо написать. эксепшн наверное? откладываем до mzzMail';
                }
            }
        } else {
            $criteria = new criteria;
            $criteria->add('id', $userId)->add('confirmed', $confirm);
            $user = $userMapper->searchOneByCriteria($criteria);

            if ($user) {
                $user->setConfirmed(null);
                $userMapper->save($user);

                $groupMapper = $this->toolkit->getMapper('user', 'group');
                $groups = $groupMapper->searchAllByField('is_default', 1);

                $userGroupMapper = $this->toolkit->getMapper('user', 'userGroup');

                foreach ($groups as $group) {
                    $userGroup = $userGroupMapper->create();
                    $userGroup->setGroup($group);
                    $userGroup->setUser($user);
                    $userGroupMapper->save($userGroup);
                }

                return 'Регистрация подтверждена';
            } else {
                return 'Нет такого пользователя';
            }
        }
    }

    function checkUniqueUserLogin($login, $userMapper)
    {
        $user = $userMapper->searchByLogin($login);
        return is_null($user);
    }

    function checkRepass($repassword, $password)
    {
        return $password === $repassword;
    }
}

?>