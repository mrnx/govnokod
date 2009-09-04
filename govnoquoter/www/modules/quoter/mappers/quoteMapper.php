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

fileLoader::load('quoter/quote');
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/comments/plugins/commentsPlugin');
fileLoader::load('modules/ratings/plugins/ratingsPlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

/**
 * quoteMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.2
 */

class quoteMapper extends mapper
{
    protected $module = 'quoter';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'quote';
    protected $table = 'quoter_quote';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        ),
        'category_id' => array(
            'accessor' => 'getCategory',
            'mutator' => 'setCategory',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'quoter/quoteCategory',
            'join_type' => 'inner'
        ),
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'user/user',
            'join_type' => 'inner'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated',
            'orderBy' => 1,
            'orderByDirection' => 'desc',
            'options' => array('once')
        ),
        'text' => array(
            'accessor' => 'getText',
            'mutator' => 'setText'
        ),
        'description' => array(
            'accessor' => 'getDescription',
            'mutator' => 'setDescription'
        ),
        'active' => array(
            'accessor' => 'getIsActive',
            'mutator' => 'setIsActive'
        ),
        'comments_count' => array(
            'accessor' => 'getCommentsCount',
            'mutator' => 'setCommentsCount'
        ),
        'rating' => array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        ),
        'ratings_on' => array (
            'accessor' => 'getRatingsOn',
            'mutator' => 'setRatingsOn',
        ),
        'ratings_against' => array (
            'accessor' => 'getRatingsAgainst',
            'mutator' => 'setRatingsAgainst',
        )
    );

    public function __construct()
    {
        $this->attach(new ratingsPlugin(array('join_rate' => true)));
        parent::__construct();
        $this->plugins('acl_simple');
        $this->plugins('jip');
        $this->plugins('comments');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function preInsert(array & $data)
    {
        $data['created'] = new sqlFunction('UNIX_TIMESTAMP');
        $data['rating'] = 0;
        $data['active'] = 1;
    }

    public function postInsert(entity $object)
    {
        $toolkit = systemToolkit::getInstance();
        $categoryMapper = $toolkit->getMapper('quote', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() + 1);
        $categoryMapper->save($category);

        $userMapper = $toolkit->getMapper('user', 'user');
        $user = $object->getUser();
        $user->setQuotesCount($user->getQuotesCount() + 1);
        $userMapper->save($user);
    }

    public function preDelete(entity $object)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() - 1);
        $categoryMapper->save($category);
    }

    public function commentAdded(Array $data)
    {
        $quote = $data['commentedObject'];
        $comment = $data['commentObject'];
        $commentsFolder = $data['commentFolderObject'];

        $quote->setCommentsCount($commentsFolder->getCommentsCount());
        $this->save($quote);

        if ($comment->getTreeParent()) {
            $commentUser = $comment->getUser();
            $parentCommentUser = $comment->getTreeParent()->getUser();

            //не будем отсылать почту guest или самому себе
            if ($parentCommentUser->isLoggedIn() && $commentUser->getId() != $parentCommentUser->getId()) {
                $smarty = systemToolkit::getInstance()->getSmarty();

                $smarty->assign('commentsFolder', $commentsFolder);
                $smarty->assign('yourComment', $comment->getTreeParent());
                $smarty->assign('answerComment', $comment);
                $smarty->assign('quote', $quote);
                $smarty->assign('you', $parentCommentUser);
                $smarty->assign('him', $commentUser);
                $body = $smarty->fetch('quoter/mail/quote_comment_reply.tpl');

                fileLoader::load('service/mailer/mailer');
                $mailer = mailer::factory();

                $mailer->set($parentCommentUser->getEmail(), $parentCommentUser->getLogin(), 'noreply@govnokod.ru', 'Говнокод.ру', 'Ответ на Ваш комментарий к говнокоду #' . $quote->getId(), $body);
                $mailer->send();
            }
        }
    }

    public function ratingAdded(Array $data)
    {
        $object = $data['ratedObject'];
        $ratingsFolder = $data['ratingsFolder'];

        $object->setRating($ratingsFolder->getRating());
        $object->setRatingsOn($ratingsFolder->getRatingsOn());
        $object->setRatingsAgainst($ratingsFolder->getRatingsAgainst());

        $userMapper = systemToolkit::getInstance()->getMapper('user', 'user');
        $usersCount = $userMapper->getActiveUsersCount();

        $k = 100 / $usersCount;
        $procentsOn = $ratingsFolder->getRatingsOn() * $k;
        $procentsAgainst = $ratingsFolder->getRatingsAgainst() * $k;

        if ($procentsAgainst >= 30) {
            $object->setIsActive(0);
        }

        $this->save($object);
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        if (isset($args['id'])) {
            $do = $this->searchById($args['id']);
            if ($do) {
                return $do;
            }
        }
        throw new mzzDONotFoundException();
    }
}
?>