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
 * @version 0.2
 */
class quoterViewController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quote = $quoteMapper->searchByKey($id);

        if (!$quote) {
            return $this->forward404($quoteMapper);
        }

        $this->view->assign('quote', $quote);

        $onlyComments = $this->request->getBoolean('onlyComments', SC_GET);
        if ($onlyComments) {
            $this->view->disableMain();
            return $this->view->render('quoter/onlyComments.tpl');
        }

        return $this->view->render('quoter/view.tpl', 'native');
    }
}

?>