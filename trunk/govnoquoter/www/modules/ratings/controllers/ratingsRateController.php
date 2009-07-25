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
        $ratingsFolderMapper = $this->toolkit->getMapper('ratings', 'ratingsFolder');

        $alias = $this->request->getString('alias');

        $ratingsFolder = $ratingsFolderMapper->searchByAlias($alias);
        if (!$ratingsFolder) {
            return $this->forward404($ratingsFolderMapper);
        }

        $objectMapper = $ratingsFolder->getObjectMapper();

        $ratingsMapper = $this->toolkit->getMapper('ratings', 'ratings');
        $ratingsMapper->setRatedMapper($objectMapper);

        $ratingsPlugin = $objectMapper->plugin('ratings');

        $rateDriver = $ratingsPlugin->getRateDriver();
        $ratingsMapper->setRateDriver($rateDriver);

        $param = $this->request->getString('param');
        $object = $objectMapper->searchOneByField($ratingsPlugin->getByField(), $param);

        if (!$object) {
            //return $this->forward404($objectMapper);
            return $this->forward404($ratingsFolderMapper);
        }

        switch ($ratingsMapper->getRateDriver()) {
            case 'simple':
                $this->smarty->disableMain();
                $vote = $this->request->getString('vote');
                switch ($vote) {
                    case 'on':
                        $rateValue = 1;
                        break;

                    case 'against':
                        $rateValue = -1;
                        break;
                }

                if (isset($rateValue)) {
                    $user = $this->toolkit->getUser();

                    /*
                    $criteria = new criteria;
                    $criteria->add('ip_address', $ip);
                    $criteria->add('parent_id', $object->getId())->add('created', time() - 7200, criteria::GREATER); //таймаут голосования - 2 часа
                    */

                    $rate = $ratingsMapper->searchByUser($user, $object->getId());

                    if (!$rate) {
                        $ip = $this->request->getServer('REMOTE_ADDR');
                        $ua = $this->request->getServer('HTTP_USER_AGENT');

                        $rate = $ratingsMapper->create();
                        $rate->setUser($user->getId());
                        $rate->setIpAddress($ip);
                        $rate->setUserAgent($ua);
                        $rate->setRateValue($rateValue);
                        $rate->setParent($object->getId());
                        $ratingsMapper->save($rate);

                        $object->setRating($object->getRating() + $rateValue);

                        $data = array($object, $rate);
                        $objectMapper->notify('ratingAdded', $data);

                        $objectMapper->save($object);

                        if ($ratingsPlugin->isWithJoinCurrentUserRate()) {
                            $object->merge(array('current_user_rate' => $rateValue));
                        }
                    }
                }

                $format = $this->request->getString('format', SC_GET);
                if ($format == 'ajax') {
                    switch ($alias) {
                        case 'code':
                            $this->smarty->assign('quote', $object);
                            return $this->smarty->fetch('quoter/rating.tpl');
                            break;

                        case 'comment':
                            $this->smarty->assign('comment', $object);
                            return $this->smarty->fetch('comments/rating.tpl');
                            break;
                    }
                }

                switch ($alias) {
                    case 'code':
                        $backUrl = new url('quoteView');
                        $backUrl->add('id', $object->getId());
                        $this->redirect($backUrl->get());
                        return;
                        break;

                    case 'comment':
                        if ($object->getFolder()->getType() == 'quote') {
                            $backUrl = new url('quoteView');
                            $backUrl->add('id', $object->getFolder()->getObject()->getId());
                            $this->redirect($backUrl->get() . '#comment' . $object->getId());
                        }
                        return;
                        break;
                }

                break;
        }

        return $this->forward404($ratingsFolderMapper);
    }
}
?>