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
 * quoterAdminCategoriesController
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */
class quoterAdminCategoriesController extends simpleController
{
    protected function getView()
    {
        $quoteFolderMapper = $this->toolkit->getMapper('quoter', 'quoteFolder');
        $quoteCategoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        $categories = $quoteCategoryMapper->searchAll();

        $this->smarty->assign('folder', $quoteFolderMapper->getFolder());
        $this->smarty->assign('categories', $categories);
        return $this->smarty->fetch('quoter/adminCategories.tpl');
    }
}

?>