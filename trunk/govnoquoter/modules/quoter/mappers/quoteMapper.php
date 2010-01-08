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

fileLoader::load('quoter/models/quote');
fileLoader::load('modules/comments/plugins/commentsPlugin');
fileLoader::load('modules/ratings/plugins/ratingsPlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

/**
 * quoteMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.3
 */
class quoteMapper extends mapper
{
    /**
     * DomainObject class name
     *
     * @var string
     */
    protected $class = 'quote';

    /**
     * Table name
     *
     * @var string
     */
    protected $table = 'quoter_quote';

    /**
     * Map
     *
     * @var array
     */
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
        $this->plugins('jip');
        $this->attach(new commentsPlugin(array('join_last_seen' => true)));
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }
    
    public function searchActiveById($id)
    {
        $criteria = new criteria;
        $criteria->where('active', 1)->where('id', $id);
        return $this->searchOneByCriteria($criteria);
    }

    public function searchUserQuotes(user $user)
    {
        $criteria = new criteria;
        $criteria->where('active', 1)->where('user_id', $user->getId());
        
        return $this->searchAllByCriteria($criteria);
    }
    
    public function preInsert(& $data)
    {
        if (is_array($data)) {
            $data['created'] = new sqlFunction('UNIX_TIMESTAMP');
            $data['rating'] = 0;
            $data['active'] = 1;
        }
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

        $quoteUser = $quote->getUser();
        //отсылаем уведомление создателю говнокода
        if ($quoteUser->isLoggedIn() && $quoteUser->getId() != $comment->getUser()->getId()) {
            $smarty = systemToolkit::getInstance()->getSmarty();

            $smarty->assign('comment', $comment);
            $smarty->assign('quote', $quote);
            $smarty->assign('quoteUser', $quoteUser);
            $body = $smarty->fetch('quoter/mail/new_comment.tpl');

            fileLoader::load('service/mailer/mailer');
            $mailer = mailer::factory();

            $mailer->set($quoteUser->getEmail(), $quoteUser->getLogin(), 'noreply@govnokod.ru', 'Говнокод.ру', 'Новый комментарий к говнокоду #' . $quote->getId(), $body);
            $mailer->send();
        }

        //Рассылаем почту, если данный комментарий был ответом на другое комментарий
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

        $rating = $ratingsFolder->getRating();
        $votesOn = (int)$ratingsFolder->getRatingsOn();
        $votesAgainst = (int)$ratingsFolder->getRatingsAgainst();

        $object->setRating($rating);
        $object->setRatingsOn($votesOn);
        $object->setRatingsAgainst($votesAgainst);

        /*
        $userMapper = systemToolkit::getInstance()->getMapper('user', 'user');
        $usersCount = $userMapper->getActiveUsersCount();

        $k = 100 / $usersCount;
        $procentsOn = $ratingsFolder->getRatingsOn() * $k;
        $procentsAgainst = $ratingsFolder->getRatingsAgainst() * $k;

        if ($procentsAgainst >= 30) {
            $object->setIsActive(0);
        }
        */

        $ratesCount = $votesOn + $votesAgainst;
        $k = 100 / $ratesCount;
        $procentsOn = $ratingsFolder->getRatingsOn() * $k;
        $procentsAgainst = $ratingsFolder->getRatingsAgainst() * $k;

        //Если рейтинг стал ниже 10 и количество проголосовавших против больше 60%, то убираем говнокод
        if ($rating < -10 && $procentsAgainst > 60) {
            $object->setIsActive(0);
        }

        $this->save($object);
    }

    public function ratingGetVoteValue($vote, user $user, entity $object)
    {
        $rateValue = null;
        switch ($vote) {
            case 'on':
                $rateValue = ($user->isLoggedIn()) ? 1 : 0.1;
                break;

            case 'against':
                $rateValue = ($user->isLoggedIn()) ? -1 : -0.1;
                break;
        }

        return $rateValue;
    }

    public function ratingUserCanRate($vote, user $user, entity $object)
    {
        if ($object->getIsActive()) {
            //Если этот говнокод был запощен гостем (старые говнокоды, после апдейта сайта)
            if (!$object->getUser()->isLoggedIn()) {
                return true;
            }

            //у гостя будем проверять токены
            if (!$user->isLoggedIn()) {
                $toolkit = systemToolkit::getInstance();
                $request = $toolkit->getRequest();
                $session = $toolkit->getSession();

                $allow = false;
                $token = $request->getString('secret', SC_GET);
                if ($token) {
                    $value = $session->get($object->getTokenName(), false);
                    $allow = ($value === $token);
                }
                $session->destroy($object->getTokenName());

                return $allow;
            }

            return $object->getUser()->getId() != $user->getId();
        }

        return false;
    }

    public function ratingSearchUserRate($vote, $rateValue, user $user, entity $ratedObject, $ratingsFolder, $ratingsMapper, $ip, $ua)
    {
        if ($user->isLoggedIn()) {
            $rate = $ratingsMapper->searchByUserAndFolder($user, $ratingsFolder);
        } else {
            $rate = $ratingsMapper->searchByGestUserAndFolder($ip, $ratingsFolder, 7200); //таймаут голосования 2 часа
        }

        return $rate;
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