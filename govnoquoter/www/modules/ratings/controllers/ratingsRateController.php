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
            throw new mzzRuntimeException('Please, add a ratings plugin for ' . get_class($objectMapper) . '!');
        }

        $param = $this->request->getString('param');
        $object = $ratingsFolder->getRatedObject($param);

        if (!$object) {
            //return $this->forward404($objectMapper);
            return $this->forward404($ratingsFolderMapper);
        }

        switch ($alias) {
            case 'govnokod':
                $object->setRating(1);
                $backUrl = new url('quoteView');
                $backUrl->add('id', $object->getId());
                $this->redirect($backUrl->get());
                break;
        }
    }
}
?>