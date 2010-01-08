<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2008
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

/**
 * quoteFolder: класс для работы c данными
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoteFolder extends entity
{

    public function getAcl($name = null)
    {
        switch ($name) {
            case 'add':
                $user = systemToolkit::getInstance()->getUser();
                return $user->isLoggedIn();
                break;
        }

        return parent::__call('getAcl', array($name));
    }

}
?>