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
 * userOpenIDLoginController
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */
class userOpenIDLoginController extends simpleController
{

    const OPENID_SESSION_TMP_KEY = 'openidurl';

    protected function getView()
    {
        $session = $this->toolkit->getSession();

        $validator = new formValidator();

        $openIDMode = $this->request->getString('openid_mode', SC_GET);

        if ($validator->validate()) {
            $openIDUrl = $this->request->getString('openidurl', SC_POST);

            fileLoader::load('libs/simpleOpenID/class.openid');
            $openid = new SimpleOpenID;
            $openid->SetIdentity($openIDUrl);
            $openid->SetTrustRoot($this->request->getUrl());
            $openid->SetRequiredFields(array('email', 'nickname'));
        	$openid->SetOptionalFields(array('timezone'));

        	if ($openid->GetOpenIDServer()) {
        	    $session->set(self::OPENID_SESSION_TMP_KEY, $openIDUrl);

        	    $url = new url('default2');
        	    $url->setAction($this->request->getAction());

        		$openid->SetApprovedURL($url->get());
        		$this->redirect($openid->GetRedirectURL());
        		return;
        	} else {
        		$error = $openid->GetError();
        		echo "ERROR CODE: " . $error['code'] . "<br>";
        		echo "ERROR DESCRIPTION: " . $error['description'] . "<br>";
        	}
        } elseif ($openIDMode === 'id_res') {
            $openIDUrl = $session->get(self::OPENID_SESSION_TMP_KEY, false);
            if (!$openIDUrl) {
                return 'фигня!';
            }

            fileLoader::load('libs/simpleOpenID/class.openid');
            $openIDUrl = $this->request->getString('openid_identity', SC_GET);

            $openid = new SimpleOpenID;
            $openid->SetIdentity($openIDUrl);
            $openid->SetTrustRoot($this->request->getUrl());
            $openid->SetRequiredFields(array('email', 'nickname'));
        	$openid->SetOptionalFields(array('timezone'));

            $openid_validation_result = $openid->ValidateWithServer();
        	if ($openid_validation_result == true) {
        		$userOpenIDMapper = $this->toolkit->getMapper('user', 'userOpenID');
        		$userOpenID = $userOpenIDMapper->searchByUrl($openIDUrl);
        		if (!$userOpenID) {
        		    $regData = array();
        		    $regData['nick'] = $this->request->getString('openid_sreg_nickname', SC_GET);
        		    $regData['email'] = $this->request->getString('openid_sreg_email', SC_GET);
        		    $regData['tz'] = $this->request->getString('openid_sreg_timezone', SC_GET);

        		    $userMapper = $this->toolkit->getMapper('user', 'user');
        		    $user = $userMapper->create();
        		    $user->setLogin($regData['email']);
        		    $user->setPassword('testme');
        		    $userMapper->save($user);

        		    $userOpenID = $userOpenIDMapper->create();
        		    $userOpenID->setUser($user);
        		    $userOpenID->setUrl($openIDUrl);
        		    $userOpenIDMapper->save($userOpenID);


        		}

        		$user = $userOpenID->getUser();
        		$this->toolkit->setUser($user);
        		$this->rememberUser($user);
        		$this->redirect('/user/login');

        	} else if($openid->IsError() == true) {
        		$error = $openid->GetError();
        		echo "ERROR CODE: " . $error['code'] . "<br>";
        		echo "ERROR DESCRIPTION: " . $error['description'] . "<br>";
        	} else {
        		echo "INVALID AUTHORIZATION";
        	}
        }

        $url = new url('default2');
        $url->setAction($this->request->getAction());

        $this->smarty->assign('form_action', $url->get());
        return $this->smarty->fetch('user/openIDLoginForm.tpl');
    }

    protected function rememberUser($user)
    {
        $userAuthMapper = $this->toolkit->getMapper('user', 'userAuth');
        $hash = $this->request->getString(userAuthMapper::$auth_cookie_name, SC_COOKIE);
        $ip = $this->request->getServer('REMOTE_ADDR');
        $userAuth = $userAuthMapper->saveAuth($user->getId(), $hash, $ip);

        $this->response->setCookie(userAuthMapper::$auth_cookie_name, $userAuth->getHash(), time() + 10 * 365 * 86400, '/');
    }
}

?>