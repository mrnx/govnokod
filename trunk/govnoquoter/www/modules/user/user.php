<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2005-2007
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('service/skin');

/**
 * user: user
 *
 * @package modules
 * @subpackage user
 * @version 0.1.5
 */
class user extends entity
{
    const NO_AVATAR_URL = '/files/avatars/';

    protected $avatarUrls = array();

    /**
     * Проверяет является ли пользователь авторизированным
     * Пользователь считается таковым, если у него установлен
     * id больше 0 и он не равен значению константы MZZ_USER_GUEST_ID
     *
     * @return boolean
     */
    public function isLoggedIn()
    {
        return $this->getId() > 0 && $this->getId() !=  MZZ_USER_GUEST_ID;
    }

    public function isConfirmed()
    {
        return is_null($this->getConfirmed());
    }

    public function isActive()
    {
        return !is_null($this->getOnline());
    }

    public function getSkin()
    {
        $id = parent::__call('getSkin', array());
        return new skin($id);
    }

    public function getAvatarUrl($size = 100)
    {
        $size = (int)$size;

        if (!isset($this->avatarUrls[$size])) {
            $avatarValue = $this->getAvatarType();

            switch ($avatarValue) {
                case 2:
                    $email = $this->getEmail();
                    $avatarUrl = 'http://www.gravatar.com/avatar/' . md5(strtolower($email)) . '?default=' . urlencode($this->getNoAvatarUrl($size)). '&size=' . $size;
                    break;

                default:
                    $avatarUrl = $this->getNoAvatarUrl($size);
                    break;
            }

            $this->avatarUrls[$size] = $avatarUrl;
        }

        return $this->avatarUrls[$size];
    }

    protected function getNoAvatarUrl($size)
    {
        $request = systemToolkit::getInstance()->getRequest();
        return $request->getUrl() . '/files/avatars/noavatar_' . $size . '.png';
    }

    public function getAcl($name)
    {
        // @todo: исправить! в acl решить что делать с obj_id = 0 (вероятно брать дефолты)
        return true;
    }
}
?>