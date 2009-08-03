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
 * ratingsAlias
 * generated with mzz scaffolding
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */

class ratingsAlias extends entity
{
    protected $objectMapper = null;

    public function getObjectMapper()
    {
        if (is_null($this->objectMapper)) {
            $toolkit = systemToolkit::getInstance();
            $this->objectMapper = $toolkit->getMapper($this->getModule(), $this->getClass());
        }

        return $this->objectMapper;
    }

    public function getAcl($name = null)
    {
        switch ($name) {
            case 'rate':
                $user = systemToolkit::getInstance()->getUser();
                return $user->isLoggedIn();
                break;
        }

        return false;
    }
}

?>