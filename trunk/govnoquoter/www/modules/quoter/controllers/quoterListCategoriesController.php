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
 * quoterListCategoriesController: контроллер для метода listCategories модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */
class quoterListCategoriesController extends simpleController
{
    protected function getView()
    {
        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        $categories = $categoryMapper->searchAllWithQuotes();
        $this->smarty->assign('categories', $categories);

        return $this->fetch('quoter/listCategories.tpl');
    }
}

?>