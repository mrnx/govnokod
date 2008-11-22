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

        $ip = $this->request->getServer('REMOTE_ADDR');
        $db = DB::factory();

        $vote = $db->getOne('SELECT * FROM `quoter_votes` WHERE `ip` = "' . $ip . '" AND `quote_id` = ' . $quote->getId() . ' AND `created` > ' . (time() - 3600 * 2));
        if (!$vote) {
            if ($newRating != $oldRating) {
                $quote->setRating($newRating);
                $quoteMapper->save($quote);

                $voteData = array();
                $voteData['ip'] = $ip;
                $voteData['quote_id'] = $quote->getId();
                $voteData['created'] = time();
                $db->autoExecute('quoter_votes', $voteData);
            }
        }

        $url = new url('quoteView');
        $url->add('id', $quote->getId());
        $this->response->redirect($url->get());
    }
}

?>