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

/**
 * simple403Controller: контроллер для метода 403 модуля simple
 *
 * @package modules
 * @subpackage simple
 * @version 0.1
 */

class simple403Controller extends simpleController
{
    public function getView()
    {
        $header = $this->request->getBoolean('403header');

        if ($header) {
            $this->response->setStatus(403);
        }

        return $this->smarty->fetch('simple/403.tpl');
    }
}

?>