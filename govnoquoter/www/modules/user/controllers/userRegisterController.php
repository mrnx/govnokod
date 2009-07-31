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
            $validator->add('length', 'login', 'Длина логина не менее 3-х и не более 30-ти символов', array(3, 30));
            $validator->add('required', 'password', 'Необходимо указать пароль');
            $validator->add('required', 'email', 'Необходимо указать e-mail');
            $validator->add('email', 'email', 'Необходимо указать правильный e-mail');
            $validator->add('required', 'repassword', 'Необходимо указать повтор пароль');
            $validator->add('callback', 'login', 'Пользователь с таким логином уже существует', array(array($this, 'checkUniqueUserLogin'), $userMapper));
            $validator->add('callback', 'email', 'Пользователь с таким email уже существует', array(array($this, 'checkUniqueUserEmail'), $userMapper));
            $validator->add('callback', 'repassword', 'Повтор пароля не совпадает', array(array($this, 'checkRepass'), $this->request->getString('password', SC_POST)));

            $timezones = $userMapper->getTimezones();
            $validator->add('required', 'timezone', 'Укажите часовой пояс');
            $validator->add('in', 'timezone', 'Укажите часовой пояс из списка!', array_keys($timezones));

            if (!$validator->validate()) {
                $url = new url('default2');
                $url->setModule('user');
                $url->setAction('register');

                $this->smarty->assign('form_action', $url->get());
                $this->smarty->assign('timezones', $timezones);
                $this->smarty->assign('errors', $validator->getErrors());
                return $this->smarty->fetch('user/register/register.tpl');
            } else {
                $login = $this->request->getString('login', SC_POST);
                $password = $this->request->getString('password', SC_POST);
                $email = $this->request->getString('email', SC_POST);
                $timezone = $this->request->getNumeric('timezone', SC_POST);

                $user = $userMapper->create();
                $user->setLogin($login);
                $user->setEmail($email);
                $user->setPassword($password);
                $user->setTimezone($timezone);
                $user->setCreated(mktime());

                $confirm = md5($email . mktime() . mt_rand(0, 1000));

                $user->setConfirmed($confirm);
                $userMapper->save($user);

                $this->smarty->assign('confirm', $confirm);
                $this->smarty->assign('user', $user);

                fileLoader::load('service/simpleMailer');

                $subject = 'Подтверждение регистрации на сайте Говнокод.ру';
                $body = $this->smarty->fetch('user/mail/register.tpl');

                $mailer = new simpleMailer($subject, $body, $email, 'noreply@govnokod.ru', 'Говнокод.ру');

    			if (!$mailer->send()) {
    			    return $this->smarty->fetch('user/mail/mailCrash.tpl');
    			}

    			return $this->smarty->fetch('user/register/success.tpl');
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

    function checkUniqueUserEmail($email, $userMapper)
    {
        $user = $userMapper->searchByEmail($email);
        return is_null($user);
    }

    function checkRepass($repassword, $password)
    {
        return $password === $repassword;
    }
}

?>