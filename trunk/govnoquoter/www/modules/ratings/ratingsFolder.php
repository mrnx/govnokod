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
 * ratingsFolder: класс для работы c данными
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */

class ratingsFolder extends entity
{
    protected $name = 'ratings';

    protected $objectMapper = null;

    public function getObjectMapper()
    {
        if (is_null($this->objectMapper)) {
            $toolkit = systemToolkit::getInstance();
            $this->objectMapper = $toolkit->getMapper($this->getModule(), $this->getType());
        }

        return $this->objectMapper;
    }

    public function getRatedObject($param)
    {
        return $this->getObjectMapper()->searchOneByField($this->getByField(), $param);
    }

    /*
    public function getRate()
    {
        if ($this->getRateCount() == 0) {
            return 0;
        }

        return $this->getRateSum() / $this->getRateCount();
    }

    public function getPercentRate()
    {
        return ($this->getRate() * 100) / ratingsFolderMapper::STARS_COUNT;
    }
    */
}

?>