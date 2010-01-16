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

fileLoader::load('comments/models/comments');
fileLoader::load('orm/plugins/tree_alPlugin');
fileLoader::load('modules/ratings/plugins/ratingsPlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');
fileLoader::load('orm/plugins/identityMapPlugin');

/**
 * commentsMapper: маппер
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */
class commentsMapper extends mapper
{
    /**
     * DomainObject class name
     *
     * @var string
     */
    protected $class = 'comments';
    
    /**
     * Table name
     *
     * @var string
     */
    protected $table = 'comments_comments';

    /**
     * Map
     *
     * @var array
     */
    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'orderBy' => 1,
            'options' => array('pk', 'once'),
        ),
        'folder_id' => array(
            'accessor' => 'getFolder',
            'mutator' => 'setFolder',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'comments/commentsFolder',
            'options' => array('once')
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'user/user',
            'options' => array('once')
        ),
        'text' => array(
            'accessor' => 'getText',
            'mutator' => 'setText'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated',
            'options' => array('once')
        ),
        'rating' => array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        ),
        'votes_on' => array(
            'accessor' => 'getVotesOn',
            'mutator' => 'setVotesOn'
        ),
        'votes_against' => array(
            'accessor' => 'getVotesAgainst',
            'mutator' => 'setVotesAgainst'
        )
    );

    public function __construct()
    {
        $this->attach(new ratingsPlugin(array('join_rate' => true)));
        parent::__construct();
        $this->attach(new tree_alPlugin(array('path_name' => 'id')), 'tree');
        $this->plugins('jip');
        $this->plugins('identityMap');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function searchByFolderAndId(commentsFolder $folder, $id)
    {
        $criteria = new criteria;
        $criteria->where('folder_id', $folder->getId())->where('id', $id);
        return $this->searchOneByCriteria($criteria);
    }

    public function preInsert(array &$data)
    {
        $data['created'] = time();
    }

    public function postInsert(entity $object)
    {
        $folder = $object->getFolder();
        $objectMapper = $folder->getObjectMapper();
        $commentedObject = $folder->getObject();

        $data = array(
            'commentedObject' => $commentedObject,
            'commentObject' => $object,
            'commentFolderObject' => $folder
        );

        $commentsFolderMapper = systemToolkit::getInstance()->getMapper('comments', 'commentsFolder');
        $commentsFolderMapper->notify('commentAdded', $data);

        $objectMapper->notify('commentAdded', $data);
    }

    public function ratingUserCanRate($vote, user $user, entity $object)
    {
        if (!$user->isLoggedIn()) {
            return false;
        }

        return $object->getUser()->getId() != $user->getId();
    }

    public function ratingAdded(Array $data)
    {
        $object = $data['ratedObject'];
        $ratingsFolder = $data['ratingsFolder'];

        $object->setRating($ratingsFolder->getRating());
        $object->setVotesOn($ratingsFolder->getRatingsOn());
        $object->setVotesAgainst($ratingsFolder->getRatingsAgainst());

        $this->save($object);

        //опять хак.
        $object->merge(array(
            'rating' => $ratingsFolder->getRating(),
            'votes_on' => $ratingsFolder->getRatingsOn(),
            'votes_against' => $ratingsFolder->getRatingsAgainst()
        ));
    }
}

?>