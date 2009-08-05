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

        $module = $this->request->getString('module_name');
        $class = $this->request->getString('class_name');
        $id = $this->request->getInteger('id');

        $ratingsFolder = $ratingsFolderMapper->searchByModuleClassAndParent($module, $class, $id);
        if (!$ratingsFolder) {
            return $this->forward404($ratingsFolder);
        }

        $ratedObjectMapper = $ratingsFolder->getObjectMapper();
        $ratedObject = $ratingsFolder->getObject();

        $ratingsPlugin = $ratedObjectMapper->plugin('ratings');

        switch ($ratingsPlugin->getDriver()) {
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

                    //$criteria = new criteria;
                    //$criteria->add('ip_address', $ip);
                    //$criteria->add('parent_id', $object->getId())->add('created', time() - 7200, criteria::GREATER); //таймаут голосования - 2 часа

                    $ratingsMapper = $this->toolkit->getMapper('ratings', 'ratings');

                    $rate = $ratingsMapper->searchByUserAndFolder($user, $ratingsFolder);

                    if (!$rate) {
                        $ip = $this->request->getServer('REMOTE_ADDR');
                        $ua = $this->request->getServer('HTTP_USER_AGENT');

                        $rate = $ratingsMapper->create();
                        $rate->setUser($user->getId());
                        $rate->setIpAddress($ip);
                        $rate->setUserAgent($ua);
                        $rate->setRateValue($rateValue);
                        $rate->setFolder($ratingsFolder);

                        $ratingsMapper->save($rate);
                    }
                }

                $format = $this->request->getString('format', SC_GET);
                if ($format == 'ajax') {
                    switch ($module . '_' . $class) {
                        case 'quoter_quote':
                            $this->smarty->assign('quote', $ratedObject);
                            return $this->smarty->fetch('quoter/rating.tpl');
                            break;

                        case 'comments_comments':
                            $this->smarty->assign('comment', $ratedObject);
                            return $this->smarty->fetch('comments/rating.tpl');
                            break;
                    }
                }

                switch ($module . '_' . $class) {
                    case 'quoter_quote':
                        $backUrl = new url('quoteView');
                        $backUrl->add('id', $ratedObject->getId());
                        $this->redirect($backUrl->get());
                        return;
                        break;

                    case 'comments_comments':
                        if ($object->getFolder()->getType() == 'quote') {
                            $backUrl = new url('quoteView');
                            $backUrl->add('id', $ratedObject->getFolder()->getObject()->getId());
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