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

fileLoader::load('comments/commentsLastSeen');

/**
 * commentsLastSeenMapper
 *
 * @package modules
 * @subpackage comments
 * @version 0.1
 */

class commentsLastSeenMapper extends mapper
{
    /**
     * Module name
     *
     * @var string
     */
    protected $module = 'comments';

    /**
     * DomainObject class name
     *
     * @var string
     */
    protected $class = 'commentsLastSeen';

    /**
     * Table name
     *
     * @var string
     */
    protected $table = 'comments_comments_lseen';

    /**
     * Map
     *
     * @var array
     */
    protected $map = array (
        'id' => array (
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array ('pk', 'once')
        ),
        'folder_id' => array (
            'accessor' => 'getFolderId',
            'mutator' => 'setFolderId'
        ),
        'user_id' => array (
            'accessor' => 'getUserId',
            'mutator' => 'setUserId'
        ),
        'cnt' => array (
            'accessor' => 'getSeenCommentsCount',
            'mutator' => 'setSeenCommentsCount'
        ),
        'time_read' => array (
            'accessor' => 'getTimeRead',
            'mutator' => 'setTimeRead'
        )
    );

    public function searchByUserAndFolder(user $user, commentsFolder $folder)
    {
        $criteria = new criteria;
        $criteria->add('user_id', $user->getId())->add('folder_id', $folder->getId());
        return $this->searchOneByCriteria($criteria);
    }

    public function saveSeen(user $user, commentsFolder $folder, $commentsCount)
    {
        $data = array(
            'user_id' => $user->getId(),
            'folder_id' => $folder->getId(),
            'cnt' => $commentsCount,
            'time_read' => time()
        );

        $criteria = new criteria($this->table());
        $insert = new simpleInsert($criteria);

        $insertQuery = $insert->toString($data);
        $replaceQuery = preg_replace('!^INSERT!', 'REPLACE', $insertQuery);
        $this->db()->query($replaceQuery);
    }
}

?>