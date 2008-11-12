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
 * quoterViewController: контроллер для метода view модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterViewController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quote = $quoteMapper->searchById($id);

        if (!$quote) {
            return $quoteMapper->get404()->run();
        }

        $this->smarty->assign('quote', $quote);

        $format = $this->request->getString('format', SC_GET);
        if ($format == 'ajax') {
            $this->smarty->disableMain();
            return $this->smarty->fetch('quoter/ajaxview.tpl');
        }

        return $this->smarty->fetch('quoter/view.tpl');
    }
}

?>