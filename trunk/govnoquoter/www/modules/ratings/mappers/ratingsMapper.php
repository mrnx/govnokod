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

fileLoader::load('ratings');

/**
 * ratingsMapper: маппер
 *
 * @package modules
 * @subpackage ratings
 * @version 0.1
 */
class ratingsMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'ratings';
    protected $table = 'ratings_ratings';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
         ),
        'folder_id' => array(
            'accessor' => 'getFolder',
            'mutator' => 'setFolder'
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser'
        ),
        'ip_address' => array(
            'accessor' => 'getIpAddress',
            'mutator' => 'setIpAddress'
        ),
        'useragent' => array(
            'accessor' => 'getUserAgent',
            'mutator' => 'setUserAgent'
        ),
        'ratevalue' => array(
            'accessor' => 'getRateValue',
            'mutator' => 'setRateValue'
        ),
        'parent_id' => array(
            'accessor' => 'getParent',
            'mutator' => 'setParent'
        ),
    );

    public function preInsert(array & $data)
    {
        $data['created'] = time();
    }

    public function convertArgsToObj($args)
    {
    }
}

?>