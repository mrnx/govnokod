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

fileLoader::load('comments');
fileLoader::load('orm/plugins/tree_mpPlugin');
fileLoader::load('orm/plugins/ratingsPlugin');

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
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'comments';
    protected $table = 'comments_comments';

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
            'mapper' => 'comments/commentsFolderMapper',
            'options' => array('once')
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'user/userMapper',
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
        )
    );

    public function __construct()
    {
        $this->attach(new ratingsPlugin(array('rating_count_field' => 'rating_count')));
        parent::__construct();
        $this->attach(new tree_mpPlugin(array('path_name' => 'id')), 'tree');
        $this->plugins('acl_ext');
        $this->plugins('jip');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function searchByFolderAndId(commentsFolder $folder, $id)
    {
        $criteria = new criteria;
        $criteria->add('folder_id', $folder->getId())->add('id', $id);
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
        if ($objectMapper->isAttached('comments')) {
            $commentsPlugin = $objectMapper->plugin('comments');
            if ($commentsPlugin->isExtendMap()) {
                $object = $folder->getObject();
                $object->setCommentsCount($object->getCommentsCount() + 1);
                $objectMapper->save($object);
            }
        }
    }

    public function convertArgsToObj($args)
    {
        if (isset($args['id']) && $comment = $this->searchById($args['id'])) {
            return $comment;
        }

        throw new mzzDONotFoundException();
    }
}

?>