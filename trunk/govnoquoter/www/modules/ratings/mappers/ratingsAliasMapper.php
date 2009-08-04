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

fileLoader::load('ratings/ratingsAlias');

/**
 * ratingsAliasMapper
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */

class ratingsAliasMapper extends mapper
{
    /**
     * DomainObject class name
     *
     * @var string
     */
    protected $class = 'ratingsAlias';

    /**
     * Table name
     *
     * @var string
     */
    protected $table = 'ratings_ratingsAlias';

    /**
     * Map
     *
     * @var array
     */
    protected $map = array (
        'id' => array (
            'accessor' => 'getId',
            'mutator' => 'setId',
            'type' => 'int',
            'range' => array (0, 4294967296),
            'options' => array ('pk', 'once')
        ),
        'alias' => array (
            'accessor' => 'getAlias',
            'mutator' => 'setAlias',
            'type' => 'char',
            'maxlength' => 50
        ),
        'module' => array (
            'accessor' => 'getModule',
            'mutator' => 'setModule',
            'type' => 'char',
            'maxlength' => 50
        ),
        'class' => array (
            'accessor' => 'getClass',
            'mutator' => 'setClass',
            'type' => 'char',
            'maxlength' => 50
        ),
        'driver' => array (
            'accessor' => 'getDriver',
            'mutator' => 'setClass',
            'type' => 'char',
            'maxlength' => 20
        ),
        'by_field' => array (
            'accessor' => 'getByField',
            'mutator' => 'setByField',
            'type' => 'char',
            'maxlength' => 20
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

    public function searchByModuleAndClass($module, $class)
    {
        $criteria = new criteria;
        $criteria->add('module', $module)->add('class', $class);

        return $this->searchOneByCriteria($criteria);
    }

    public function convertArgsToObj($args)
    {
        if (isset($args['alias'])) {
            $do = $this->searchByAlias($args['alias']);
            if ($do) {
                return $do;
            }
        }

        throw new mzzDONotFoundException();
    }
}

?>