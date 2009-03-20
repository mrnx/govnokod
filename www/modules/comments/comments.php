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
 * comments: класс для работы с ...
 *
 * @package modules
 * @subpackage comments
 * @version 0.1.2
 */

class comments extends simple
{
    const USERNAME_MAX_CHARS = 50;
    const TEXT_MAX_CHARS = 2000;
    const VOTE_TIMEOUT = 7200;
    const VOTE_TOKEN_PREFIX = 'commentsvotetoken_';

    protected $name = 'comments';

    protected $token = null;

    public function getVoteToken()
    {
        if (is_null($this->token)) {
            $session = systemToolkit::getInstance()->getSession();
            $token = md5('comments' . microtime(true) . $this->getTokenName());
            $session->set($this->getTokenName(), $token);
            $this->token = $token;
        }
        return $this->token;
    }

    public function getTokenName()
    {
        return self::VOTE_TOKEN_PREFIX . $this->getId();
    }

    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        switch ($name) {
            case 'vote':
                return true;
                break;

            case 'edit':
            case 'delete':
                $groups = $user->getGroupsList();
                if (in_array(4, $groups) || in_array(MZZ_ROOT_GID, $groups)) {
                    return true;
                }
                break;
        }

        return false;
    }
}

?>