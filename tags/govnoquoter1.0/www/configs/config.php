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

/**
 * Абсолютный путь до сайта.
 * Если mzz установлен в корень веб-сервера, оставьте поле пустым
 * Правильно: /mzz, /new/site
 * Неправильно: site1, site1/, /site1/
 *
 */
define('SITE_PATH', '');
define('COOKIE_DOMAIN', '');

define('DEBUG_MODE', 1);
define('SYSTEM_PATH', realpath(dirname(__FILE__) . '/../../../mzz_stable/system/'));

/**
 * Идентификатор записи в БД для неавторизированных пользователей
 */
define('MZZ_USER_GUEST_ID', 1);

/**
 * Идентификатор группы, для которой ACL всегда будет возвращать true (т.е. предоставит полный доступ)
 */
define('MZZ_ROOT_GID', 3);

require_once SYSTEM_PATH . 'systemConfig.php';

// дефолтный язык приложения
systemConfig::$i18n = 'ru';

// включаем мультиязычность
systemConfig::$i18nEnable = false;

// устанавливаем дефолтную кодировку для выдачи
ini_set('default_charset', 'utf-8');

systemConfig::$db['default']['driver'] = 'pdo';
systemConfig::$db['default']['dsn']  = 'mysql:host=localhost;dbname=govnokod';
systemConfig::$db['default']['user'] = 'root';
systemConfig::$db['default']['password'] = '';
systemConfig::$db['default']['charset'] = 'utf8';
systemConfig::$db['default']['pdoOptions'] = array();

systemConfig::$pathToApplication = dirname(__FILE__) . '/..';
systemConfig::$pathToTemp = realpath(dirname(__FILE__) . '/../../tmp');
systemConfig::$pathToConf = dirname(__FILE__);

systemConfig::$cache['default']['backend'] = 'memory';
systemConfig::$cache['memory']['backend'] = 'memory';
//systemConfig::$cache['default']['params'] = array('path' => systemConfig::$pathToTemp . DIRECTORY_SEPARATOR . 'cache', 'prefix' => 'cf2_');

systemConfig::$cache['geshi_code']['backend'] = 'memcache';
systemConfig::$cache['geshi_code']['params'] = array('servers' => array('localhost' => array()));

systemConfig::$cache['file']['backend'] = 'file';
systemConfig::$cache['file']['params'] = array('path' => systemConfig::$pathToTemp . DIRECTORY_SEPARATOR . 'cache' . DIRECTORY_SEPARATOR . 'code', 'prefix' => 'highlighted_');

systemConfig::init();

?>
