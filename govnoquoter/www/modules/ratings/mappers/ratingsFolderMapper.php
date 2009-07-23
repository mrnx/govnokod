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

fileLoader::load('ratings/ratingsFolder');
fileLoader::load('orm/plugins/acl_simplePlugin');

/**
 * ratingsFolderMapper: маппер
 *
 * @package modules
 * @subpackage ratings
 * @version 0.3
 */
class ratingsFolderMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'ratingsFolder';
    protected $table = 'ratings_ratingsFolder';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
         ),
        'module' => array(
            'accessor' => 'getModule',
            'mutator' => 'setModule',
            'options' => array('ro'),
        ),
        'alias' => array(
            'accessor' => 'getAlias',
            'mutator' => 'setAlias',
            'options' => array('ro'),
        ),
        'type' => array(
            'accessor' => 'getType',
            'mutator' => 'setType',
            'options' => array('ro'),
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->plugins('acl_simple');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function searchByAlias($alias)
    {
        return $this->searchOneByField('alias', $alias);
    }

    public function convertArgsToObj($args)
    {
    }
}

?>