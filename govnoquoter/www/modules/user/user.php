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

    protected $avatar = null;

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

    /*
    public function getAvatar()
    {
        if (is_null($this->avatar)) {
            $cache = cache::factory();
            $avatarCacheKey = 'govnokod_avatar_' . $this->getId();
            $avatar = $cache->get($avatarCacheKey);
            if (is_null($avatar) || !is_a($avatar, 'file')) {
                $avatar = parent::__call('getAvatar', array());
                if (!$avatar) {

                }

                $cache->set($avatarCacheKey, $avatar);
            }

            $this->avatar = $avatar;
        }

        return $this->avatar;
    }
    */

    public function getAcl($name)
    {
        // @todo: исправить! в acl решить что делать с obj_id = 0 (вероятно брать дефолты)
        return true;
    }
}
?>