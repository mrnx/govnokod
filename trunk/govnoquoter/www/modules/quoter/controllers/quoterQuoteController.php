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

        $criteria = new criteria;
        $criteria->add('active', 1)->add('id', $id);

        $quote = $quoteMapper->searchOneByCriteria($criteria);
        if (!$quote) {
            return $this->forward404($quoteMapper);
        }

        $allow = false;
        $token = $this->request->getString('token', SC_GET);
        $session = $this->toolkit->getSession();
        if ($token) {
            $value = $session->get($quote->getTokenName(), false);
            $allow = ($value === $token);
        }
        $session->destroy($quote->getTokenName());

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

        if (!$allow) {
            $newRating = $oldRating;
        }

        $ip = $this->request->getServer('REMOTE_ADDR');
        $db = DB::factory();

        $status = $oldRating;

        if ($newRating != $oldRating) {
            $vote_tmp = $db->getOne('SELECT * FROM `quoter_votes` WHERE `ip` = "' . $ip . '" AND `quote_id` = ' . $quote->getId() . ' AND `created` > ' . (time() - quote::VOTE_TIMEOUT));
            if (!$vote_tmp) {
                $quote->setRating($newRating);

                if ($newRating < 0) {
                    if ($oldRating >= 0) {
                        $quote->setDeleted(strtotime('+2 days'));
                    } else {
                        $deleted = $quote->getDeleted();
                        switch ($vote) {
                            case -1:
                                $quote->setDeleted(strtotime('-2 hours', $deleted));
                                break;

                            case 1:
                                $quote->setDeleted(strtotime('+1 hours', $deleted));
                                break;
                        }
                    }
                } else {
                    $quote->setDeleted(0);
                }

                $quoteMapper->save($quote);

                $voteData = array();
                $voteData['ip'] = $ip;
                $voteData['quote_id'] = $quote->getId();
                $voteData['created'] = time();
                $db->autoExecute('quoter_votes', $voteData);
                $status = $newRating;
            }
        }

        if ($this->request->getBoolean('ajax', SC_POST)) {
            $this->smarty->disableMain();
            return $status;
        }

        $url = new url('quoteView');
        $url->add('id', $quote->getId());
        $this->response->redirect($url->get());
    }
}

?>