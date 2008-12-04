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
 * @version 0.1
 */


class comments extends simple
{
    const USERNAME_MAX_CHARS = 25;
    const TEXT_MAX_CHARS = 2000;

    protected $name = 'comments';

    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        switch ($name) {
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