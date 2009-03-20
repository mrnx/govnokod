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
 * commentsVoteController: контроллер для метода vote модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */

class commentsVoteController extends simpleController
{
    protected function getView()
    {
        $id = $this->request->getInteger('id');
        $commentsMapper = $this->toolkit->getMapper('comments', 'comments');

        $comment = $commentsMapper->searchByKey($id);

        if (!$comment) {
            $this->forward404($commentsMapper);
        }

        $allow = false;
        $token = $this->request->getString('token', SC_GET);
        $session = $this->toolkit->getSession();
        if ($token) {
            $value = $session->get($comment->getTokenName(), false);
            $allow = ($value === $token);
        }
        $session->destroy($comment->getTokenName());

        $vote = $this->request->getInteger('vote');
        $oldRating = $comment->getRating();
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
        $ua = $this->request->getServer('HTTP_USER_AGENT');

        $status = $oldRating;

        if ($newRating != $oldRating) {
            $criteria = new criteria;
            $criteria->add('comment_id', $id)->add('ip_address', $ip)->add('datetime', (time() - comments::VOTE_TIMEOUT), criteria::GREATER);

            $voteMapper = $this->toolkit->getMapper('comments', 'commentsVote');
            $commentVote = $voteMapper->searchOneByCriteria($criteria);
            if (!$commentVote) {
                $commentVote = $voteMapper->create();
                $commentVote->setComment($comment);
                $commentVote->setValue($vote);
                $commentVote->setIp($ip);
                $commentVote->setUseragent($ua);
                $commentVote->setUser(MZZ_USER_GUEST_ID);
                $voteMapper->save($commentVote);

                $comment->setRating($newRating);
                $commentsMapper->save($comment);

                $status = $newRating;
            }
        }

        if ($this->request->getBoolean('ajax', SC_POST)) {
            $this->smarty->disableMain();
            return $status;
        }

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote', 'quoter');
        $quote = $quoteMapper->searchOneByField('obj_id', $comment->getFolder()->getParentId());

        if ($quote) {
            $url = new url('quoteView');
            $url->add('id', $quote->getId());
            $this->response->redirect($url->get() . '#comment' . $id);
        }
    }
}

?>