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
 * comments: класс для работы с данными
 *
 * @package modules
 * @subpackage comments
 * @version 0.2
 */
class comments extends entity
{
    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        if (!$user->isLoggedIn()) {
            switch ($name) {
                case 'edit':
                case 'delete':
                    return false;
                    break;
            }
        }

        return parent::__call('getAcl', array($name));
    }
}
?>