<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2006
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
*/

/**
 * ratingsPlugin: плагин для рейтингуемых модулей.
 *
 * @package orm
 * @subpackage plugins
 * @version 0.0.1
 */
class ratingsPlugin extends observer
{
    protected $options = array(
        'byField' => 'obj_id'
    );

    protected function updateMap(& $map)
    {
        $map['ratingsFolder'] = array(
            'accessor' => 'getRatingsFolder',
            'mutator' => 'setRatingsFolder',
            'relation' => 'one',
            'local_key' => $this->getByField(),
            'foreign_key' => 'parent_id',
            'mapper' => 'ratings/ratingsFolderMapper',
            'options' => array('ro')
        );
    }

    public function getByField()
    {
        return $this->options['byField'];
    }
}
?>