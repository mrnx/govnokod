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
 * quoterListController: контроллер для метода listAll модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterListController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();
        $listAll = ($action == 'listAll');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quotes = $quoteMapper->searchAll();

        $this->smarty->assign('quotes', $quotes);
        return $this->smarty->fetch('quoter/list.tpl');
    }
}

?>