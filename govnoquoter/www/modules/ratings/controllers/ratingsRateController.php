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
        if (!$objectMapper->isAttached('ratings')) {
            throw new mzzRuntimeException('Please, attach a ratings plugin for ' . get_class($objectMapper) . '!');
        }

        $param = $this->request->getString('param');
        $object = $ratingsFolder->getRatedObject($param);

        if (!$object) {
            //return $this->forward404($objectMapper);
            return $this->forward404($ratingsFolderMapper);
        }

        //@todo: допустимые значения вынести лучше в БД
        switch ($alias) {
            case 'comment':
            case 'govnokod':
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

                    $ip = $this->request->getServer('REMOTE_ADDR');
                    $ua = $this->request->getServer('HTTP_USER_AGENT');

                    $ratingsMapper = $this->toolkit->getMapper('ratings', 'ratings');
                    $criteria = new criteria;
                    $criteria->add('ip_address', $ip)->add('folder_id', $ratingsFolder->getId());
                    $criteria->add('parent_id', $object->getId())->add('created', time() - 7200, criteria::GREATER); //таймаут голосования - 2 часа
                    $rate = $ratingsMapper->searchOneByCriteria($criteria);

                    if (!$rate) {
                        $object->setRating($object->getRating() + $rateValue);
                        $object->setRatingCount($object->getRatingCount() + 1);
                        $objectMapper->save($object);

                        $rate = $ratingsMapper->create();
                        $rate->setUser($user->getId());
                        $rate->setFolder($ratingsFolder->getId());
                        $rate->setIpAddress($ip);
                        $rate->setUserAgent($ua);
                        $rate->setRateValue($rateValue);
                        $rate->setParent($object->getId());
                        $ratingsMapper->save($rate);
                    }
                }

                $format = $this->request->getString('format', SC_GET);
                if ($format == 'ajax') {
                    switch ($alias) {
                        case 'govnokod':
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
                    case 'govnokod':
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