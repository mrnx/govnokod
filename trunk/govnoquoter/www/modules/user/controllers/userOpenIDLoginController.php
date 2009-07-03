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

fileLoader::load('libs/simpleOpenID/class.openid');
fileLoader::load('user/controllers/userLoginController');

/**
 * userOpenIDLoginController
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */
class userOpenIDLoginController extends userLoginController
{
    protected function getView()
    {
        $user = $this->toolkit->getUser();
        if ($user->isLoggedIn()) {
            $this->redirect($this->getSuccessUrl());
            return;
        }

        $session = $this->toolkit->getSession();
        $isValidated = $session->get('openID_validated', false);
        if ($isValidated === true) {
            $openIDUrl = $session->get('openID_url', false);

            $validator = new formValidator('openidsubmit');
            $validator->add('required', 'login', 'Укажите отображаемое имя');
            $validator->add('required', 'email', 'Укажите ваш адрес e-mail');
            $validator->add('email', 'email', 'Неверный e-mail адрес');

            if ($validator->validate()) {
                $login = $this->request->getString('login', SC_POST);
                $email = $this->request->getString('email', SC_POST);

                $userMapper = $this->toolkit->getMapper('user', 'user');
                $user = $userMapper->create();
                $user->setLogin($login);
                //$user->setEmail($email);
                //$user->setPassword(userMapper::generatePassword(mt_rand(6, 10)));
                $userMapper->save($user);

                $openid = new SimpleOpenID;
                $normalizedOpenIDUrl = $openid->OpenID_Standarize($openIDUrl);

                $userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
                $userOpenID = $userOpenIDMapper->create();
                $userOpenID->setUser($user);
                $userOpenID->setUrl($normalizedOpenIDUrl);
                $userOpenIDMapper->save($userOpenID);

                $this->toolkit->setUser($user);
                $this->rememberUser($user);

                $session->destroy('openID_url');
                $session->destroy('openID_validated');
                $session->destroy('openID_RegData');

                $this->redirect($this->getSuccessUrl());
                return;
            }

            $regData = $session->get('openID_RegData');
            $this->smarty->assign('regData', $regData);

            $url = new url('default2');
            $url->setAction($this->request->getAction());

            $this->smarty->assign('form_action', $url->get());
            return $this->smarty->fetch('user/openIDRegForm.tpl');
        }

        $openIDMode = $this->request->getString('openid_mode', SC_GET);

        switch ($openIDMode) {
            case 'id_res':
                $openIDUrl = $session->get('openID_url', false);
                if ($openIDUrl) {
                    $openid = new SimpleOpenID;
                    $openid->SetTrustRoot($this->request->getUrl());

                    $normalizedOpenIDUrl = $openid->OpenID_Standarize($openIDUrl);
                    $openid->SetIdentity($openIDUrl);

                    $url = new url('default2');
                    $url->setAction($this->request->getAction());

                    $openid->SetApprovedURL($url->get());

                    if ($openid->ValidateWithServer()) {
                        $userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
                        $userOpenID = $userOpenIDMapper->searchByUrl($normalizedOpenIDUrl);
                        if (!$userOpenID) {
                            $regData = array();
                            $regData['login'] = $this->request->getString('openid_sreg_nickname', SC_GET);
                            $regData['email'] = $this->request->getString('openid_sreg_email', SC_GET);
                            $regData['tz'] = $this->request->getString('openid_sreg_timezone', SC_GET);

                            $session->set('openID_validated', true);
                            $session->set('openID_RegData', $regData);

                            $url = new url('default2');
                            $url->setModule('user');
                            $url->setAction('openIDLogin');
                            $this->redirect($url->get());
                            return;
                        }

                        $user = $userOpenID->getUser();
                        $this->toolkit->setUser($user);
                        $this->rememberUser($user);

                        $this->redirect($this->getSuccessUrl());
                        return;
                    } else {
                        $errors['openidurl'] = 'Авторизация не подтверждена сервером!';
                    }
                }
                break;

            case 'cancel':
                $errors['openidurl'] = 'Авторизация отменена';
                break;
        }

        $validator = new formValidator('openidsubmit');
        $validator->add('required', 'openidurl', 'Введите свой openID идентификатор!');
        $validator->add('url', 'openidurl', 'Введите корректный openID идентификатор!');

        if (isset($errors)) {
            $session->destroy('openID_url');
        } else {
            $openIDUrl = '';
            $errors = array();
        }

        if ($validator->validate()) {
            $openIDUrl = $this->request->getString('openidurl', SC_POST);
            $openid = new SimpleOpenID;
            $openid->SetTrustRoot($this->request->getUrl());
            $openid->SetIdentity($openIDUrl);
            $openid->SetRequiredFields(array('email', 'nickname'));
            $openid->SetOptionalFields(array('timezone'));

            $openIDServer = $openid->GetOpenIDServer();

            if ($openIDServer) {
                $session = $this->toolkit->getSession();
                $session->set('openID_url', $openIDUrl);

                $url = new url('default2');
                $url->setAction($this->request->getAction());

                $openid->SetApprovedURL($url->get());
                $this->redirect($openid->GetRedirectURL());
                return;
            } else {
                $error = $openid->GetError();
                if ($error) {
                    switch ($error['code']) {
                        case 'OPENID_NOSERVERSFOUND':
                            $errors['openidurl'] = 'Не удалось установить сервер провайдера OpenID. Возможно, ошиблись адресом?';
                            break;

                        default:
                            $errors['openidurl'] = 'Неопознанная ошибка OpenID';
                            break;
                    }
                }
            }
        } elseif (!isset($errors)) {
            $errors = $validator->getErrors()->export();
        }

        $url = new url('default2');
        $url->setAction($this->request->getAction());

        $this->smarty->assign('openIDUrl', $openIDUrl);
        $this->smarty->assign('form_action', $url->get());
        $this->smarty->assign('errors', $errors);
        return $this->smarty->fetch('user/openIDLoginForm.tpl');
    }

    protected function getSuccessUrl()
    {
        $url = new url('default2');
        $url->setModule('user');
        $url->setAction('login');

        return $url->get();
    }
}
?>