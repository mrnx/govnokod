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

fileLoader::load('user/userOpenID');

/**
 * userOpenIDMapper
 *
 * @package modules
 * @subpackage user
 * @version 0.1
 */
class userOpenIDMapper extends mapper
{
    protected $module = 'user';

    /**
     * DomainObject class name
     *
     * @var string
     */
    protected $class = 'userOpenID';

    /**
     * Table name
     *
     * @var string
     */
    protected $table = 'user_userOpenID';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'user/user',
            'join_type' => 'inner'
        ),
        'openid_url' => array(
            'accessor' => 'getUrl',
            'mutator' => 'setUrl',
        ),
        'openid_url_standarized' => array(
            'accessor' => 'getStandarizedUrl',
            'mutator' => 'setStandarizedUrl'
        )
    );

    public function searchById($id)
    {
        return $this->searchOneByField('id', $id);
    }

    public function searchAllByUserId($user_id)
    {
        return $this->searchAllByField('user_id', $user_id);
    }

    public function searchByUrl($url)
    {
        return $this->searchOneByField('openid_url_standarized', $url);
    }

    public function convertArgsToObj($args)
    {

    }
}
?>