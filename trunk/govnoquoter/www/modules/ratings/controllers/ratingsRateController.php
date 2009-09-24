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
 * ratingsRateController: контроллер для метода rate модуля ratings
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */
class ratingsRateController extends simpleController
{
    protected function getView()
    {
        $user = $this->toolkit->getUser();

        $ratingsFolderMapper = $this->toolkit->getMapper('ratings', 'ratingsFolder');

        $module = $this->request->getString('module_name');
        $class = $this->request->getString('class_name');

        $moduleClass = $module . '_' . $class;

        $id = $this->request->getInteger('id');

        $ratingsFolder = $ratingsFolderMapper->searchByModuleClassAndParent($module, $class, $id);
        if (!$ratingsFolder) {
            return $this->forward404($ratingsFolder);
        }

        $ratedObjectMapper = $ratingsFolder->getObjectMapper();
        $ratedObject = $ratingsFolder->getObject();

        $ratingsPlugin = $ratedObjectMapper->plugin('ratings');

        $vote = $this->request->getString('vote');

        if (!$ratingsPlugin->canRate($vote, $user, $ratedObject)) {
            return $this->forward403($ratingsFolderMapper);
        }

        $rateValue = $ratingsPlugin->getRateByVote($vote, $user, $ratedObject);

        if (!is_null($rateValue)) {
            $this->smarty->disableMain();
            $ip = $this->request->getServer('REMOTE_ADDR');
            $ua = $this->request->getServer('HTTP_USER_AGENT');

            $ratingsMapper = $this->toolkit->getMapper('ratings', 'ratings');

            $rate = $ratingsPlugin->searchUserRate($vote, $rateValue, $user, $ratedObject, $ratingsFolder, $ratingsMapper);

            if ($user->isLoggedIn()) {
                $rate = $ratingsMapper->searchByUserAndFolder($user, $ratingsFolder);
            } else if ($moduleClass == 'quoter_quote') {
                $rate = $ratingsMapper->searchByGestUserAndFolder($ip, $ratingsFolder);
            }

            if (!$rate) {
                $rate = $ratingsMapper->create();
                $rate->setUser($user->getId());
                $rate->setIpAddress($ip);
                $rate->setUserAgent($ua);
                $rate->setRateValue($rateValue);
                $rate->setFolder($ratingsFolder);

                $ratingsMapper->save($rate);
            }

            $format = $this->request->getString('format', SC_GET);
            switch ($moduleClass) {
                case 'quoter_quote':
                    if ($format == 'ajax') {
                        $this->smarty->assign('quote', $ratedObject);
                        return $this->smarty->fetch('quoter/rating.tpl');
                    } else {
                        $backUrl = new url('quoteView');
                        $backUrl->add('id', $ratedObject->getId());
                        $this->redirect($backUrl->get());
                        return;
                    }
                    break;

                case 'comments_comments':
                    if ($object->getFolder()->getType() == 'quote') {
                        if ($format == 'ajax') {
                             $this->smarty->assign('comment', $ratedObject);
                        return $this->smarty->fetch('comments/rating.tpl');
                        } else {
                            $backUrl = new url('quoteView');
                            $backUrl->add('id', $ratedObject->getFolder()->getObject()->getId());
                            $this->redirect($backUrl->get() . '#comment' . $object->getId());
                        }
                    }
                    return;
                    break;
            }

            return;
        }

        return $this->forward403($ratingsFolderMapper);
    }
}
?>