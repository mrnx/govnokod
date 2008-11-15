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
 * quoterQuoteController: контроллер для метода quote модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterQuoteController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');
        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');

        $quote = $quoteMapper->searchById($id);
        if (!$quote) {
            return $quoteMapper->get404()->run();
        }

        $vote = $this->request->getInteger('vote');
        $oldRating = $quote->getRating();
        $newRating = $oldRating;
        switch ($vote) {
            case -1:
                $newRating = $oldRating - 1;
                break;

            case 1:
                $newRating = $oldRating + 1;
                break;
        }

        if ($newRating != $oldRating) {
            $quote->setRating($newRating);
            $quoteMapper->save($quote);
        }

        $url = new url('withId');
        $url->setAction('');
        $url->add('id', $quote->getId());
        $this->response->redirect($url->get());
    }
}

?>