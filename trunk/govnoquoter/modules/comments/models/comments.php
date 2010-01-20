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
class comments extends entity implements iACL
{
    public function getAcl($action)
    {
        if ($action == 'edit') {
            $user = systemToolkit::getInstance()->getUser();

            if ($user->isLoggedIn() && $user->getId() == $this->getUser()->getId()) {
                return (($this->getCreated() + 60 * 5) > time());
            }

            return false;
        }
    }
}
?>