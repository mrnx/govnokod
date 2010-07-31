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
 * appUserAuthMapper: маппер
 *
 * @package modules
 * @subpackage user
 * @version 0.2
 */
class appUserAuthMapper extends userAuthMapper 
{
    public function getAuth($hash, $ip)
    {
        if (!$hash) {
            return null;
        }

        $criteria = new criteria();
        $criteria->where('hash', $hash);

        $auth = $this->searchOneByCriteria($criteria);

        if ($auth) {
            $this->save($auth);
        }

        return $auth;
    }

    public function saveAuth($user, $hash, $ip)
    {
        $userAuth = $this->getAuth($hash, $ip);

        if (!is_null($userAuth) && $user_id != $userAuth->getUserId()) {
            $userAuth = null;
        }

        if (is_null($userAuth)) {
            $userAuth = $this->create();
            $userAuth->setIp($ip);
            $userAuth->setUser($user);
            $this->save($userAuth);
        }

        return $userAuth;
    }
}

?>