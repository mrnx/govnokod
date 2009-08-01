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
 * quoterDeleteController: контроллер для метода delete модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterDeleteController extends simpleController
{
    protected function getView()
    {
        $onlyDelete = $this->request->getAction() == 'delete';

        $id = $this->request->getInteger('id');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $quote = $quoteMapper->searchById($id);

        if (!$quote) {
            return $this->forward404($quoteMapper);
        }

        if ($onlyDelete) {
            $quoteMapper->delete();
        } else {
            $quote->setIsActive(!$quote->getIsActive());
            $quoteMapper->save($quote);
        }

        return jipTools::redirect();
    }
}

?>