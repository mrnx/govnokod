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
fileLoader::load('orm/plugins/tree_alPlugin');
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/ratings/plugins/ratingsPlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

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
        )
    );

    public function __construct()
    {
        $this->attach(new ratingsPlugin());
        parent::__construct();
        $this->attach(new tree_alPlugin(array('path_name' => 'id')), 'tree');
        $this->attach(new acl_simplePlugin(), 'acl');
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
        $commentedObject = $folder->getObject();

        $data = array(
            'commentedObject' => $commentedObject,
            'commentObject' => $object,
            'commentFolderObject' => $folder
        );

        $commentsFolderMapper = systemToolkit::getInstance()->getMapper('comments', 'commentsFolder');
        $commentsFolderMapper->notify('commentAdded', $data);

        $objectMapper->notify('commentAdded', $data);

        if ($folder->getModule() == 'quoter' && $folder->getType() == 'quote') {
            //если это был ответ, то отсылаем почту
            if ($object->getTreeParent()) {
                $thisCommentUser = $object->getUser();
                $parentCommentUser = $object->getTreeParent()->getUser();

                //не будем отсылать почту guest или самому себе
                if ($parentCommentUser->isLoggedIn() && $thisCommentUser->getId() != $parentCommentUser->getId()) {
                    fileLoader::load('service/simpleMailer');

                    $subject = 'Ответ на Ваш комментарий к говнокоду #' . $commentedObject->getId();

                    $smarty = systemToolkit::getInstance()->getSmarty();

                    $smarty->assign('commentsFolder', $folder);
                    $smarty->assign('yourComment', $object->getTreeParent());
                    $smarty->assign('answerComment', $object);
                    $smarty->assign('quote', $commentedObject);
                    $smarty->assign('you', $parentCommentUser);
                    $smarty->assign('him', $thisCommentUser);
                    $body = $smarty->fetch('comments/mail/quote_comment_reply.tpl');

                    $mailer = new simpleMailer($subject, $body, $parentCommentUser->getEmail(), 'noreply@govnokod.ru', 'Говнокод.ру');

        			if (!$mailer->send()) {
        			    return $this->smarty->fetch('user/mail/mailCrash.tpl');
        			}
                }
            }
        }
    }

    public function ratingAdded(Array $data)
    {
        $object = $data['ratedObject'];
        $ratingsFolder = $data['ratingsFolder'];

        $object->setRating($ratingsFolder->getRating());

        $this->save($object);
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