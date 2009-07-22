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
fileLoader::load('orm/plugins/acl_extPlugin');
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
            'options' => array(
                'pk')),
        'login' => array(
            'accessor' => 'getLogin',
            'mutator' => 'setLogin'),
        'email' => array(
            'accessor' => 'getEmail',
            'mutator' => 'setEmail'),
        'password' => array(
            'accessor' => 'getPassword',
            'mutator' => 'setPassword'),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated'),
        'confirmed' => array(
            'accessor' => 'getConfirmed',
            'mutator' => 'setConfirmed'),
        'last_login' => array(
            'accessor' => 'getLastLogin',
            'mutator' => 'setLastLogin'),
        'language_id' => array(
            'accessor' => 'getLanguageId',
            'mutator' => 'setLanguageId'),
        'timezone' => array(
            'accessor' => 'getTimezone',
            'mutator' => 'setTimezone'),
        'skin' => array(
            'accessor' => 'getSkin',
            'mutator' => 'setSkin'),
        'highlight_driver' => array(
            'accessor' => 'getHighlightDriver',
            'mutator' => 'setHighlightDriver'
        ),
        'avatar_file_id' => array(
            'accessor' => 'getAvatar',
            'mutator' => 'setAvatar',
            'relation' => 'one',
            'mapper' => 'fileManager/fileMapper',
            'foreign_key' => 'id'
        ),
        'groups' => array(
            'accessor' => 'getGroups',
            'mutator' => 'setGroups',
            'relation' => 'many-to-many',
            'mapper' => 'user/groupMapper',
            'reference' => 'user_userGroup_rel',
            'local_key' => 'id',
            'foreign_key' => 'id',
            'ref_local_key' => 'user_id',
            'ref_foreign_key' => 'group_id'),
        'online' => array(
            'accessor' => 'getOnline',
            'relation' => 'one',
            'mapper' => 'user/userOnlineMapper',
            'local_key' => 'id',
            'foreign_key' => 'user_id',
            'options' => array(
                'ro')));

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