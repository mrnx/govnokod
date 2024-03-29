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
            'join_type' => 'inner',
            'options' => array('lazy')
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
            'options' => array('once'),
            'orderBy' => 1,
            'orderByDirection' => 'desc'
        ),
        'text' => array(
            'accessor' => 'getText',
            'mutator' => 'setText'
        ),
        'description' => array(
            'accessor' => 'getDescription',
            'mutator' => 'setDescription'
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
            'mutator' => 'setRatingsOn'
        ),
        'ratings_against' => array (
            'accessor' => 'getRatingsAgainst',
            'mutator' => 'setRatingsAgainst'
        ),
        'best_in_day' => array(
            'accessor' => 'getIsBestInDay',
            'mutator' => 'setIsBestInDay'
        ),
        'best_in_week' => array(
            'accessor' => 'getIsBestInWeek',
            'mutator' => 'setIsBestInWeek'
        ),
        'best_in_month' => array(
            'accessor' => 'getIsBestInMonth',
            'mutator' => 'setIsBestInMonth'
        ),
        'best_in_day_time' => array(
            'accessor' => 'getBestInDayTime',
            'mutator' => 'setBestInDayTime'
        ),
        'best_in_week_time' => array(
            'accessor' => 'getBestInDayTime',
            'mutator' => 'setBestInDayTime'
        ),
        'best_in_month_time' => array(
            'accessor' => 'getBestInDayTime',
            'mutator' => 'setBestInDayTime'
        ),
        'last_comment_id' => array(
            'accessor' => 'getLastComment',
            'mutator' => 'setLastComment',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'comments/comments',
            'options' => array('lazy')
        )
    );

    public function __construct($module)
    {
        $this->attach(new ratingsPlugin(array('join_rate' => true)));
        parent::__construct($module);
        $this->plugins('jip');
        $this->attach(new commentsPlugin(array('join_last_seen' => true)));
    }

    public function searchAllByParams(Array $params)
    {
        $criteria = new criteria;

        if (isset($params['category_id'])) {
            if (is_array($params['category_id'])) {
                $comparsion = criteria::IN;
            } else {
                $comparsion = criteria::EQUAL;
            }

            $criteria->where('category_id', $params['category_id'], $comparsion);
        }

        if (isset($params['user_id'])) {
            $criteria->where('user_id', $params['user_id']);
        }

        if (isset($params['keyword'])) {
            $criterion = new criterion('text', '%' . $params['keyword'] . '%', criteria::LIKE);
            $criterion->addOr(new criterion('description', '%' . $params['keyword'] . '%', criteria::LIKE));

            $criteria->where($criterion);
        }

        /*
        if (isset($params['not_category_id'])) {
            $criteria->where('category_id', $params['not_category_id'], criteria::NOT_EQUAL);
        }
        */

        if (isset($params['order'])) {
            if (is_string($params['order'])) {
                $params['order'] = array(
                    $params['order']
                );
            }

            if (is_array($params['order'])) {
                foreach ($params['order'] as $order) {
                    $parts = explode(' ', $order, 2);
                    if (sizeof($parts) == 1) {
                        $field = $parts[0];
                        $direction = 'desc';
                    } else if (sizeof($parts) == 2) {
                        $field = $parts[0];
                        $direction = $parts[1];
                    }

                    if ($direction == 'desc') {
                        $criteria->orderByDesc($field);
                    } else {
                        $criteria->orderByAsc($field);
                    }
                }
            }
        }

        //$criteria->debug();

        return $this->searchAllByCriteria($criteria);
    }

    public function searchForLiveComments($limit = 20)
    {
        $criteria = new criteria;
        $criteria->where('last_comment_id', 0, criteria::GREATER)->orderByDesc('last_comment_id')->limit($limit);

        $collection = $this->searchAllByCriteria($criteria);
        return $collection;
    }

    public function preInsert(& $data)
    {
        if (is_array($data)) {
            $data['created'] = new sqlFunction('UNIX_TIMESTAMP');
            $data['rating'] = 0;
            //$data['active'] = 1;
        }
    }

    public function postInsert(entity $object)
    {
        $toolkit = systemToolkit::getInstance();
        $categoryMapper = $toolkit->getMapper('quoter', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() + 1);
        $categoryMapper->save($category);

        $userMapper = $toolkit->getMapper('user', 'user');
        $user = $object->getUser();
        $user->setQuotesCount($user->getQuotesCount() + 1);
        $userMapper->save($user);
    }

    public function postUpdate(entity $object)
    {
        $cache = cache::factory('memcache');
        $cache->delete('quote_geshi_' . $object->getId());
        $cache->delete('quote_geshi_' . $object->getId() . '_15');
    }

    public function preDelete(entity $object)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quoter', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() - 1);
        $categoryMapper->save($category);
    }

    public function commentAdded(Array $data)
    {
        $quote = $data['commentedObject'];
        $comment = $data['commentObject'];
        $commentsFolder = $data['commentFolderObject'];

        $quote->setLastComment($comment->getId());
        $quote->setCommentsCount($commentsFolder->getCommentsCount());
        $this->save($quote);

        $cache = cache::factory('memcache');
        $cache->delete('live_comments');

        $quoteUser = $quote->getUser();

        $mailAlreadySended = false;
        //Рассылаем почту, если данный комментарий был ответом на другой комментарий
        if ($comment->getTreeParent()) {
            $commentUser = $comment->getUser();
            $parentCommentUser = $comment->getTreeParent()->getUser();

            //не будем отсылать почту guest или самому себе
            if ($parentCommentUser->isLoggedIn() && $commentUser->getId() != $parentCommentUser->getId()) {
                $view = systemToolkit::getInstance()->getView();

                $view->assign('commentsFolder', $commentsFolder);
                $view->assign('yourComment', $comment->getTreeParent());
                $view->assign('answerComment', $comment);
                $view->assign('quote', $quote);
                $view->assign('you', $parentCommentUser);
                $view->assign('him', $commentUser);
                $body = $view->render('quoter/service/mail/quote_comment_reply.tpl', 'native');

                fileLoader::load('service/mailer/mailer');
                $mailer = mailer::factory();

                $mailer->set($parentCommentUser->getEmail(), $parentCommentUser->getLogin(), 'support@govnokod.ru', 'Говнокод.ру', 'Ответ на Ваш комментарий к говнокоду #' . $quote->getId(), $body);
                $mailer->send();

                $mailAlreadySended = true;
            }
        }

        if ($mailAlreadySended === false) {
            //отсылаем уведомление создателю говнокода
            if ($quoteUser->isLoggedIn() && $quoteUser->getId() != $comment->getUser()->getId()) {
                $view = systemToolkit::getInstance()->getView();

                $view->assign('comment', $comment);
                $view->assign('quote', $quote);
                $view->assign('quoteUser', $quoteUser);
                $body = $view->render('quoter/service/mail/new_comment.tpl', 'native');

                fileLoader::load('service/mailer/mailer');
                $mailer = mailer::factory();

                $mailer->set($quoteUser->getEmail(), $quoteUser->getLogin(), 'support@govnokod.ru', 'Говнокод.ру', 'Новый комментарий к говнокоду #' . $quote->getId(), $body);
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
                $rateValue = ($user->isLoggedIn()) ? 1 : 0.2;
                break;

            case 'against':
                $rateValue = ($user->isLoggedIn()) ? -1 : -0.2;
                break;
        }

        return $rateValue;
    }

    public function ratingUserCanRate($vote, user $user, entity $object)
    {
        if (!$object->getUser()->isLoggedIn()) {
            return true;
        }

        return $object->getUser()->getId() != $user->getId();

        /*
        if ($object->getIsActive()) {
            //Если этот говнокод был запощен гостем (старые говнокоды, после апдейта сайта)
            //то не учитываем голос
            if (!$object->getUser()->isLoggedIn()) {
                return true;
            }

            //у гостя будем проверять токены
            if (!$user->isLoggedIn()) {
                return false;
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
        */
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