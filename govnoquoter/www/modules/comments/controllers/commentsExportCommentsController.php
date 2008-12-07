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
 * commentsExportCommentsController: контроллер для метода exportAllComments модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */

class commentsExportCommentsController extends simpleController
{
    protected function getView()
    {
        return $this->smarty->fetch('comments/exportAllComments.tpl');
    }
}

?>