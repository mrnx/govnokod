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
 * quoterAdminController: контроллер для метода admin модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterAdminController extends simpleController
{
    protected function getView()
    {
        $quoteFolderMapper = $this->toolkit->getMapper('quoter', 'quoteFolder');
        $quoteCategoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        $categories = $quoteCategoryMapper->searchAll();

        $this->smarty->assign('folder', $quoteFolderMapper->getFolder());
        $this->smarty->assign('categories', $categories);
        return $this->smarty->fetch('quoter/admin.tpl');
    }
}

?>