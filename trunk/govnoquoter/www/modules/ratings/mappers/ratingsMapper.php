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
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated'
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
        'folder_id' => array(
            'accessor' => 'getFolder',
            'mutator' => 'setFolder',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'ratings/ratingsFolder'
        )
    );

    public function searchByUserAndFolder(user $user, ratingsFolder $folder)
    {
        $criteria = new criteria;
        $criteria->add('user_id', $user->getId())->add('folder_id', $folder->getId());
        return $this->searchOneByCriteria($criteria);
    }

    public function preInsert(array & $data)
    {
        $data['created'] = time();
    }

    public function postInsert(entity $object)
    {
        $folder = $object->getFolder();
        $ratedObject = $object->getRatedObject();
        $ratedObjectMapper = $folder->getAlias()->getObjectMapper();

        $data = array(
            'ratings' => $object,
            'ratingsFolder' => $folder,
            'ratedObject' => $ratedObject,
            'ratedObjectMapper' => $ratedObject
        );

        $ratingsFolderMapper = systemToolkit::getInstance()->getMapper('ratings', 'ratingsFolder');
        $ratingsFolderMapper->notify('ratingAdded', $data);
    }

    public function convertArgsToObj($args)
    {
    }
}

?>