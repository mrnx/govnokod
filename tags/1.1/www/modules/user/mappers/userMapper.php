<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2005-2007
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('user');
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

/**
 * userMapper: маппер для пользователей
 *
 * @package modules
 * @subpackage user
 * @version 0.2.3
 */
class userMapper extends mapper
{
    const USER_GROUPS_CACHE_TTL = 86400;

    /**
     * Учётная запись не подтверждена
     *
     */
    const NOT_CONFIRMED = -1;

    /**
     * Неверные аутентификационные данные
     *
     */
    const WRONG_AUTH_DATA = 0;

    protected $module = 'user';

    /**
     * Имя таблицы
     *
     * @var string
     */
    protected $table = 'user_user';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'user';

    public $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk')
         ),
        'login' => array(
            'accessor' => 'getLogin',
            'mutator' => 'setLogin'
         ),
        'email' => array(
            'accessor' => 'getEmail',
            'mutator' => 'setEmail'
        ),
        'password' => array(
            'accessor' => 'getPassword',
            'mutator' => 'setPassword'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated'
        ),
        'confirmed' => array(
            'accessor' => 'getConfirmed',
            'mutator' => 'setConfirmed'
        ),
        'last_login' => array(
            'accessor' => 'getLastLogin',
            'mutator' => 'setLastLogin'
        ),
        'timezone' => array(
            'accessor' => 'getTimezone',
            'mutator' => 'setTimezone'
        ),
        'quotes_count' => array(
            'accessor' => 'getQuotesCount',
            'mutator' => 'setQuotesCount'
        ),
        'highlight_driver' => array(
            'accessor' => 'getHighlightDriver',
            'mutator' => 'setHighlightDriver'
        ),
        'avatar_type' => array(
            'accessor' => 'getAvatarType',
            'mutator' => 'setAvatarType',
        ),
        'preferred_langs' => array(
            'accessor' => 'getPreferredLangs',
            'mutator' => 'setPreferredLangs',
        ),
        'openID_identifiers' => array(
            'accessor' => 'getOpenIDIdentifiers',
            'mutator' => 'setOpenIDIdentifiers',
            'relation' => 'many',
            'mapper' => 'user/userOpenID',
            'foreign_key' => 'user_id',
            'local_key' => 'id'
        ),
        'groups' => array(
            'accessor' => 'getGroups',
            'mutator' => 'setGroups',
            'relation' => 'many-to-many',
            'mapper' => 'user/group',
            'reference' => 'user_userGroup_rel',
            'local_key' => 'id',
            'foreign_key' => 'id',
            'ref_local_key' => 'user_id',
            'ref_foreign_key' => 'group_id'
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->plugins('acl_simple');
        $this->plugins('jip');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    /**
     * Выполняет поиск объекта по логину
     *
     * @param string $login логин
     * @return object
     */
    public function searchByLogin($login)
    {
        return $this->searchOneByField('login', $login);
    }

    /**
     * Выполняет поиск объекта по email
     *
     * @param string $email
     * @return object
     */
    public function searchByEmail($email)
    {
        return $user = $this->searchOneByField('email', $email);
    }

    /**
     * Идентифицирует пользователя по логину и паролю и
     * в случае успеха устанавливает сессию
     * идентифицированного пользователя
     *
     * @param string $login логин
     * @param string $password пароль
     * @param string $loginField имя поля, которое используется в качестве логина
     * @return object
     */
    public function login($login, $password, $loginField = 'login')
    {
        $criteria = new criteria();
        $criteria->add($loginField, $login)->add('password', $this->cryptPassword($password));

        $user = $this->searchOneByCriteria($criteria);

        if ($user) {
            return $user->isConfirmed() ? $user : self::NOT_CONFIRMED;
        }

        return self::WRONG_AUTH_DATA;
    }

    /**
     * Возвращает объект для гостя (id = MZZ_USER_GUEST_ID)
     *
     * @return object
     */
    public function getGuest()
    {
        return $this->searchByKey(MZZ_USER_GUEST_ID);
    }

    protected function preInsert(& $data)
    {
        if (is_array($data)) {
            $data['created'] = time();
            if (isset($data['password'])) {
                $data['password'] = $this->cryptPassword($data['password']);
            }

            $data['avatar_type'] = 2;
            $data['highlight_driver'] = 'js';
            $data['last_login'] = time();
        }
    }

    protected function preUpdate(& $data)
    {
        if (is_array($data)) {
            if (isset($data['password'])) {
                $data['password'] = $this->cryptPassword($data['password']);
            }
        }
    }

    public function updateLastLoginTime($user)
    {
        $user->setLastLogin(new sqlFunction('unix_timestamp'));
        $this->save($user);
    }

    protected function cryptPassword($password)
    {
        return md5($password);
    }

    public static function generatePassword($nums)
    {
        if ($nums <= 0) {
            throw new mzzRuntimeException('Wrong nums for password');
        }

        $pass = '';
        $chars = array_merge(range('A', 'z'), range(1, 9));

        $maxchars = count($chars);

        for ($i = 0; $i < $nums; $i++) {
            $pass .= $chars[mt_rand(0, $maxchars - 1)];
        }

        return $pass;
    }

    public function getTimezones()
    {
        return array(
            '-12' => '(GMT - 12:00) Эневеток, Кваджалейн',
            '-11' => '(GMT - 11:00) о.Мидуэй, Самоа',
            '-10' => '(GMT - 10:00) Гавайи',
            '-9' => '(GMT - 9:00) Аляска',
            '-8' => '(GMT - 8:00) Тихоокеанское время (США и Канада), Тихуана',
            '-7' => '(GMT - 7:00) Горное время (США и Канада), Аризона',
            '-6' => '(GMT - 6:00) Центральное время (США и Канада), Мехико',
            '-5' => '(GMT - 5:00) Восточное время (США и Канада), Богота, Лима, Кито',
            '-4' => '(GMT - 4:00) Атлантическое время (Канада), Каракас, Ла Пас, Сантьяго',
            '-3.5' => '(GMT - 3:30) Ньюфаундленд',
            '-3' => '(GMT - 3:00) Бразилия, Буэнос-Айрес, Джорджтаун, Гренландия',
            '-2' => '(GMT - 2:00) Среднеатлантическое время',
            '-1' => '(GMT - 1:00) Азорские о-ва, о-ва Зеленого мыса',
            '0' => '(GMT) Касабланка, Дублин, Эдинбург, Лиссабон, Лондон, Монровия',
            '1' => '(GMT + 1:00) Амстердам, Берлин, Брюссель, Мадрид, Париж, Рим',
            '2' => '(GMT + 2:00) Каир, Хельсинки, Калининград, Южная Африка, Варшава',
            '3' => '(GMT + 3:00) Багдад, Эр-Рияд, Москва, Найроби',
            '3.5' => '(GMT + 3:30) Тегеран',
            '4' => '(GMT + 4:00) Абу-Даби, Баку, Мускат, Тбилиси',
            '4.5' => '(GMT + 4:30) Кабул',
            '5' => '(GMT + 5:00) Екатеринбург, Исламабад, Карачи, Ташкент',
            '5.5' => '(GMT + 5:30) Бомбей, Калькутта, Мадрас, Нью-Дели',
            '6' => '(GMT + 6:00) Алма-Ата, Коломбо, Дхака, Новосибирск, Омск',
            '7' => '(GMT + 7:00) Бангкок, Ханой, Джакарта, Красноярск',
            '8' => '(GMT + 8:00) Пекин, Гонконг, Перт, Сингапур, Тайпей',
            '9' => '(GMT + 9:00) Осака, Саппоро, Сеул, Токио, Якутск',
            '9.5' => '(GMT + 9:30) Аделаида, Дарвин',
            '10' => '(GMT + 10:00) Канберра, Мельбурн, Гуам, Сидней, Владивосток',
            '11' => '(GMT + 11:00) Магадан, Новая Каледония, Соломоновы о-ва',
            '12' => '(GMT + 12:00) Окленд, Фиджи, Камчатка, Веллингтон',
            '13' => '(GMT + 13:00) Камчатка, Анадырь',
            '14' => '(GMT + 14:00) Киритимати (остров Рождества)'
        );
    }

    public function getHighlighDrivers()
    {
        return array(
            'js' => 'HighlightJS',
            'geshi' => 'Geshi',
        );
    }

    public function getActiveUsersCount()
    {
        fileLoader::load('cache');
        $cache = cache::factory();
        $cacheKey = 'govnokod_active_users_count';
        $usersCount = $cache->get($cacheKey);
        if (!$usersCount) {
            $criteria = new criteria($this->table());
            $criteria->addSelectField(new sqlFunction('COUNT', '*'), 'active_users_count');

            $criteria->add('last_login', strtotime('-1 month'), criteria::GREATER_EQUAL);

            $select = new simpleSelect($criteria);
            $usersCount = $this->db()->getOne($select->toString());
            $cache->set($cacheKey, $usersCount);
        }

        return $usersCount;
    }

    public function convertArgsToObj($args)
    {
        if (isset($args['id'])) {
            if ($args['id'] == 0) {
                $toolkit = systemToolkit::getInstance();
                $user = $toolkit->getUser();
            } else {
                $user = $this->searchByKey($args['id']);
            }
            if ($user) {
                return $user;
            }
        }

        throw new mzzDONotFoundException();
    }
}

?>