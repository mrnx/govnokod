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

fileLoader::load('comments/commentsVote');

/**
 * commentsVoteMapper: маппер
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */

class commentsVoteMapper extends simpleMapper
{
    /**
     * Имя модуля
     *
     * @var string
     */
    protected $name = 'comments';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $className = 'commentsVote';

    protected $obj_id_field = null;

    /**
     * Выполнение операций с массивом $fields перед вставкой в БД
     *
     * @param array $fields
     */
    protected function insertDataModify(&$fields)
    {
        $fields['datetime'] = time();
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        throw new mzzDONotFoundException();
    }
}

?>