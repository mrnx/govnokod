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
            $this->smarty->assign('user', $user);
            return $this->fetch('user/alreadyLogin.tpl');
        }

        $session = $this->toolkit->getSession();
        $isValidated = $session->get('openID_validated', false);
        $this->smarty->assign('isValidated', $isValidated);
        if (!$this->request->getBoolean('onlyForm') && $isValidated === true) {
            $userMapper = $this->toolkit->getMapper('user', 'user');
            $timezones = $userMapper->getTimezones();

            $openIDUrl = $session->get('openID_url', false);

            $cancelValidator = new formValidator('openid_reg_cancel');

            $validator = new formValidator('openid_reg_submit');
            $validator->add('required', 'login', 'Укажите логин!');
            $validator->add('required', 'email', 'Укажите адрес e-mail!');
            $validator->add('email', 'email', 'Неверный e-mail адрес!');
            $validator->add('required', 'timezone', 'Укажите часовой пояс!');
            $validator->add('in', 'timezone', 'Укажите часовой пояс из списка!', array_keys($timezones));

            if ($cancelValidator->validate()) {
                $session->destroy('openID_url');
                $session->destroy('openID_validated');
                $session->destroy('openID_RegData');

                $url = new url('openIDLogin');

                $this->redirect($url->get());
                return;
            } else if ($validator->validate()) {
                $login = $this->request->getString('login', SC_POST);
                $email = $this->request->getString('email', SC_POST);
                $timezone = $this->request->getNumeric('timezone', SC_POST);

                $user = $userMapper->create();
                $user->setLogin($login);
                $user->setEmail($email);
                $user->setTimezone($timezone);
                $user->setPassword(userMapper::generatePassword(mt_rand(6, 10)));
                $userMapper->save($user);

                $openid = new SimpleOpenID;
                $normalizedOpenIDUrl = $openid->OpenID_Standarize($openIDUrl);

                $userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
                $userOpenID = $userOpenIDMapper->create();
                $userOpenID->setUser($user);
                $userOpenID->setUrl($openIDUrl);
                $userOpenID->setStandarizedUrl($normalizedOpenIDUrl);
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

            $url = new url('openIDLogin');

            $this->smarty->assign('openIDUrl', $openIDUrl);
            $this->smarty->assign('timezones', $timezones);
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

                    $url = new url('openIDLogin');

                    $openid->SetApprovedURL($url->get());

                    if ($openid->ValidateWithServer()) {
                        $userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
                        $userOpenID = $userOpenIDMapper->searchByUrl($normalizedOpenIDUrl);
                        if (!$userOpenID) {
                            $regData = array();
                            $regData['login'] = $this->request->getString('openid_sreg_nickname', SC_GET);
                            $regData['email'] = $this->request->getString('openid_sreg_email', SC_GET);

                            $session->set('openID_validated', true);
                            $session->set('openID_RegData', $regData);

                            $url = new url('openIDLogin');
                            $this->redirect($url->get());
                            return;
                        }

                        $user = $userOpenID->getUser();
                        $this->toolkit->setUser($user);
                        $this->rememberUser($user);

                        $this->redirect($this->getSuccessUrl());
                        return;
                    } else {
                        $errors = array('openid_identifier' => 'Авторизация не подтверждена сервером!');
                    }
                } else {
                    $errors = array('openid_identifier' => 'Bad request!');
                }
                break;

            case 'cancel':
                $errors = array('openid_identifier' => 'Авторизация отменена');
                break;
        }

        $validator = new formValidator('openid_submit');
        $validator->add('required', 'openid_identifier', 'Введите openID идентификатор!');
        $validator->add('url', 'openid_identifier', 'Введите корректный openID идентификатор!');

        if (isset($errors)) {
            $openIDUrl = $session->get('openID_url', false);
            $session->destroy('openID_url');
        } else {
            $openIDUrl = '';
        }

        if (!$this->request->getBoolean('onlyForm') && $validator->validate()) {
            $openIDUrl = mzz_trim($this->request->getString('openid_identifier', SC_POST));

            if ((stripos($openIDUrl, 'http://') === false) && (stripos($openIDUrl, 'https://') === false)){
                $openIDUrl = 'http://' . $openIDUrl;
            }

            $openid = new SimpleOpenID;

            //@todo: метод httpRequest::getUrl() не совсем подходит, так как содержит в себе еще и SITE_PATH
            //при SITE_PATH == '' всё нормально, но иначе будет плохо (а будет ли иначе?)
            $openid->SetTrustRoot($this->request->getUrl());
            $openid->SetIdentity($openIDUrl);

            $normalizedOpenIDUrl = $openid->OpenID_Standarize($openIDUrl);
            $userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
            $userOpenID = $userOpenIDMapper->searchByUrl($normalizedOpenIDUrl);
            if (!$userOpenID) {
                $openid->SetRequiredFields(array('email', 'nickname'));
            }

            $openIDServer = $openid->GetOpenIDServer();

            if ($openIDServer) {
                $session = $this->toolkit->getSession();
                $session->set('openID_url', $openIDUrl);

                $url = new url('openIDLogin');

                $openid->SetApprovedURL($url->get());
                $this->redirect($openid->GetRedirectURL());
                return;
            } else {
                $error = $openid->GetError();
                if ($error) {
                    switch ($error['code']) {
                        case 'OPENID_NOSERVERSFOUND':
                            $errors['openid_identifier'] = 'Не удалось установить сервер провайдера OpenID. Возможно, ошиблись адресом?';
                            break;

                        default:
                            $errors['openid_identifier'] = 'Неопознанная ошибка OpenID';
                            break;
                    }
                }
            }
        } elseif (!isset($errors)) {
            $errors = $validator->getErrors()->export();
        }

        $url = new url('openIDLogin');

        $this->smarty->assign('openIDUrl', $openIDUrl);
        $this->smarty->assign('form_action', $url->get());
        $this->smarty->assign('errors', $errors);
        return $this->fetch('user/openIDLoginForm.tpl');
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