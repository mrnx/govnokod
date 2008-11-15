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

fileLoader::load('quoter/quoteCategory');

/**
 * quoteCategoryMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoteCategoryMapper extends simpleMapper
{
    /**
     * Имя модуля
     *
     * @var string
     */
    protected $name = 'quoter';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $className = 'quoteCategory';

    public function searchByName($name)
    {
        return $this->searchOneByField('name', $name);
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        if (isset($args['name'])) {
            $do = $this->searchByName($args['name']);
            if ($do) {
                return $do;
            }
        }
        throw new mzzDONotFoundException();
    }
}

?>