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

        $validator = new formValidator;
        $validator->submit('register');

        $validator->filter('trim', 'login');
        //$validator->filter('trim', 'email');
        $validator->filter('trim', 'password');
        $validator->filter('trim', 'repassword');

        $validator->rule('required', 'login', 'Вы забыли указать логин');
        $validator->rule('regex', 'login', 'Логин может содержать только латинские буквы, цифры, дефис и знак подчеркивания', '/^[-_a-z0-9]+$/i');
        $validator->rule('length', 'login', 'Логин должен быть длиннее 2-х символов', array(3, null));
        $validator->rule('length', 'login', 'Логин должен быть короче 20-ти символов', array(null, 20));
        $validator->rule('callback', 'login', 'Пользователь с таким логином уже существует. Выберите другой', array(array($this, 'checkUniqueUserLogin'), $userMapper));

        //$validator->rule('required', 'email', 'Без E-mail в наше время никуда, укажите его');
        //$validator->rule('email', 'email', 'Укажите правильный адрес E-mail');
        //$validator->rule('callback', 'email', 'Это прозвучит странно, но пользователь с таким E-mail уже существует. Укажите другой', array(array($this, 'checkUniqueUserEmail'), $userMapper));

        $validator->rule('required', 'password', 'Укажите пароль');
        $validator->rule('required', 'repassword', 'Подтвердите пароль');
        $validator->rule('callback', 'repassword', 'Повтор пароля не совпадает', array(array($this, 'checkRepass'), $this->request->getString('password', SC_POST)));

        $validator->rule('required', 'captcha', 'Укажите проверочный код');
        $validator->rule('captcha', 'captcha', 'Неправильно указан проверочный код. Попробуйте еще раз');

        if ($validator->validate()) {
            $login = $this->request->getString('login', SC_POST);
            $password = $this->request->getString('password', SC_POST);
            //$email = $this->request->getString('email', SC_POST);

            $user = $userMapper->create();
            $user->setLogin($login);
            //$user->setEmail($email);
            $user->setPassword($password);

            //$confirm = md5($email . $login . microtime(true) . mt_rand(0, 1000));
            $user->setConfirmed('');
            $userMapper->save($user);

            $groupMapper = $this->toolkit->getMapper('user', 'group');
            $groups = $groupMapper->searchDefaultGroups();

            $userGroups = $user->getGroups();

            foreach ($groups as $group) {
                $userGroups->add($group);
            }

            $userMapper->save($user);

            $this->toolkit->setUser($user);

            $url = new url('user-profile');
            $url->add('id', $user->getId());
            $url->add('login', $user->getLogin());

            $this->redirect($url->get() . '/');
            return;

            /*
            $this->smarty->assign('user', $user);
            $body = $this->smarty->fetch('user/register/mailbody.tpl');
            $alt_body = $this->smarty->fetch('user/register/mailbody_text.tpl');

            fileLoader::load('service/mailer/mailer');
            $mailer = mailer::factory();

            $mailer->set($user->getEmail(), $user->getLogin(), 'support@govnokod.ru', 'Говнокод.ру', 'Подтверждение регистрации на сайте Говнокод.ру', $body, $alt_body);
            $mailer->send();

            return $this->smarty->fetch('user/register/success.tpl');
            */
        }

        $url = new url('default2');
        $url->setModule('user');
        $url->setAction('register');

        $this->view->assign('form_action', $url->get());
        $this->view->assign('validator', $validator);
        return $this->view->render('user/register/form.tpl', 'native');
    }

    public function checkUniqueUserLogin($login, $userMapper)
    {
        $user = $userMapper->searchByLogin($login);
        return is_null($user);
    }

    public function checkUniqueUserEmail($email, $userMapper)
    {
        $user = $userMapper->searchByEmail($email);
        return is_null($user);
    }

    public function checkRepass($repassword, $password)
    {
        return $password === $repassword;
    }
}

?>