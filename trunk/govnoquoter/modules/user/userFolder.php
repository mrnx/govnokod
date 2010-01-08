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
 * userFolder: класс для работы c данными
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */

class userFolder extends entity
{
    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        switch ($name) {
            case 'preferences':
                return $user->isLoggedIn();
                break;
        }

        return parent::__call('getAcl', array($name));
    }
}
?>