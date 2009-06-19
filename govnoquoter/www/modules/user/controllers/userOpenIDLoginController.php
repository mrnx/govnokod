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
        $openIDMode = $this->request->getString('openid_mode', SC_GET);

        switch ($openIDMode) {
            case 'id_res':
                $session = $this->toolkit->getSession();
                $openIDUrl = $session->get('openidurl', false);
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
                            $regData['nick'] = $this->request->getString('openid_sreg_nickname', SC_GET);
                            $regData['email'] = $this->request->getString('openid_sreg_email', SC_GET);
                            $regData['tz'] = $this->request->getString('openid_sreg_timezone', SC_GET);

                            $userDataValidator = new formValidator('openid_mode');
                            $userDataValidator->disableCSRF();
                            $userDataValidator->add('required', 'nick', 'Укажите отображаемое имя');
                            $userDataValidator->add('required', 'email', 'Укажите ваш адрес e-mail');
                            $userDataValidator->add('email', 'email', 'Неверный e-mail адрес');

                            if ($userDataValidator->validate($regData)) {
                                $userMapper = $this->toolkit->getMapper('user', 'user');
                                $user = $userMapper->create();
                                $user->setLogin($regData['nick']);
                                $user->setEmail($regData['email']);
                                $user->setPassword(userMapper::generatePassword(mt_rand(6, 10)));
                                $userMapper->save($user);

                                $userOpenID = $userOpenIDMapper->create();
                                $userOpenID->setUser($user);
                                $userOpenID->setUrl($normalizedOpenIDUrl);
                                $userOpenIDMapper->save($userOpenID);
                            } else {
                                $errors = $userDataValidator->getErrors()->export();
                            }
                        }

                        if (!isset($errors)) {
                            $user = $userOpenID->getUser();
                            $this->toolkit->setUser($user);
                            $this->rememberUser($user);

                            $this->redirect('/user/login');
                            return;
                        }
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
            $session->destroy('openidurl');
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
                $session->set('openidurl', $openIDUrl);

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
                            $errors['openidurl'] = 'Не удалось найти сервер провайдера OpenID на заданной странице. Возможно, ошиблись?';
                            break;

                        default:
                            $errors['openidurl'] = 'Неопознанная ошибка openid';
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
}
?>