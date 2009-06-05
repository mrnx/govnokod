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
    protected function getView()
    {
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
            fileLoader::load('libs/simpleOpenID/class.openid');
            $openIDUrl = $this->request->getString('openid_identity', SC_GET);

            $openid = new SimpleOpenID;
            $openid->SetIdentity($openIDUrl);
            $openid_validation_result = $openid->ValidateWithServer();
        	if ($openid_validation_result == true){
        		echo "VALID";
        	}else if($openid->IsError() == true){
        		$error = $openid->GetError();
        		echo "ERROR CODE: " . $error['code'] . "<br>";
        		echo "ERROR DESCRIPTION: " . $error['description'] . "<br>";
        	}else{											// Signature Verification Failed
        		echo "INVALID AUTHORIZATION";
        	}
        }

        $url = new url('default2');
        $url->setAction($this->request->getAction());

        $this->smarty->assign('form_action', $url->get());
        return $this->smarty->fetch('user/openIDLoginForm.tpl');
    }
}

?>