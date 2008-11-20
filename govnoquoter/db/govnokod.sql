# SQL Manager 2007 for MySQL 4.3.4.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : govnokod


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

SET sql_mode = '';

#
# Structure for the `comments_comments` table : 
#

DROP TABLE IF EXISTS `comments_comments`;

CREATE TABLE `comments_comments` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `text` TEXT COLLATE utf8_general_ci,
  `author` INTEGER(11) UNSIGNED DEFAULT NULL,
  `time` INTEGER(11) UNSIGNED DEFAULT NULL,
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `comments_commentsFolder` table : 
#

DROP TABLE IF EXISTS `comments_commentsFolder`;

CREATE TABLE `comments_commentsFolder` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `parent_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `fileManager_file` table : 
#

DROP TABLE IF EXISTS `fileManager_file`;

CREATE TABLE `fileManager_file` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `realname` VARCHAR(255) COLLATE utf8_general_ci DEFAULT 'имя в фс в каталоге на сервере',
  `name` VARCHAR(255) COLLATE utf8_general_ci DEFAULT 'имя с которым файл будет отдаваться клиенту',
  `ext` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `size` INTEGER(11) DEFAULT NULL,
  `modified` INTEGER(11) DEFAULT NULL,
  `downloads` INTEGER(11) DEFAULT NULL,
  `right_header` TINYINT(4) DEFAULT NULL,
  `direct_link` INTEGER(11) DEFAULT '0',
  `about` TEXT COLLATE utf8_general_ci,
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `storage_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `realname` (`realname`),
  KEY `folder_id` (`folder_id`, `name`, `ext`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `fileManager_folder` table : 
#

DROP TABLE IF EXISTS `fileManager_folder`;

CREATE TABLE `fileManager_folder` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `parent` INTEGER(11) UNSIGNED DEFAULT NULL,
  `path` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `filesize` INTEGER(11) UNSIGNED DEFAULT NULL,
  `exts` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `fileManager_folder` table  (LIMIT 0,500)
#

INSERT INTO `fileManager_folder` (`id`, `name`, `title`, `parent`, `path`, `obj_id`, `filesize`, `exts`) VALUES 
  (1,'root','/',1,'root',24,NULL,NULL);
COMMIT;

#
# Structure for the `fileManager_folder_tree` table : 
#

DROP TABLE IF EXISTS `fileManager_folder_tree`;

CREATE TABLE `fileManager_folder_tree` (
  `id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `lkey` INTEGER(10) NOT NULL DEFAULT '0',
  `rkey` INTEGER(10) NOT NULL DEFAULT '0',
  `level` INTEGER(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `left_key` (`lkey`, `rkey`, `level`),
  KEY `level` (`level`, `lkey`),
  KEY `rkey` (`rkey`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `fileManager_folder_tree` table  (LIMIT 0,500)
#

INSERT INTO `fileManager_folder_tree` (`id`, `lkey`, `rkey`, `level`) VALUES 
  (1,1,2,1);
COMMIT;

#
# Structure for the `fileManager_storage` table : 
#

DROP TABLE IF EXISTS `fileManager_storage`;

CREATE TABLE `fileManager_storage` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `path` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `web_path` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `fileManager_storage` table  (LIMIT 0,500)
#

INSERT INTO `fileManager_storage` (`id`, `name`, `path`, `web_path`) VALUES 
  (1,'local','../files/','/'),
  (2,'avatars','files/avatars/','/files/avatars/');
COMMIT;

#
# Structure for the `page_page` table : 
#

DROP TABLE IF EXISTS `page_page`;

CREATE TABLE `page_page` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `allow_comment` TINYINT(4) DEFAULT '1',
  `compiled` INTEGER(11) DEFAULT NULL,
  `keywords_reset` TINYINT(1) DEFAULT '0',
  `description_reset` TINYINT(1) DEFAULT '0',
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_page` table  (LIMIT 0,500)
#

INSERT INTO `page_page` (`id`, `obj_id`, `name`, `folder_id`, `allow_comment`, `compiled`, `keywords_reset`, `description_reset`) VALUES 
  (1,11,'main',1,1,0,0,0),
  (2,12,'404',1,1,NULL,0,0),
  (3,13,'403',1,1,NULL,0,0);
COMMIT;

#
# Structure for the `page_pageFolder` table : 
#

DROP TABLE IF EXISTS `page_pageFolder`;

CREATE TABLE `page_pageFolder` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) UNSIGNED NOT NULL DEFAULT '0',
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `parent` INTEGER(11) DEFAULT '0',
  `path` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder` (`id`, `obj_id`, `name`, `title`, `parent`, `path`) VALUES 
  (1,10,'root','root',1,'root');
COMMIT;

#
# Structure for the `page_pageFolder_tree` table : 
#

DROP TABLE IF EXISTS `page_pageFolder_tree`;

CREATE TABLE `page_pageFolder_tree` (
  `id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `lkey` INTEGER(10) NOT NULL DEFAULT '0',
  `rkey` INTEGER(10) NOT NULL DEFAULT '0',
  `level` INTEGER(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `left_key` (`lkey`, `rkey`, `level`),
  KEY `level` (`level`, `lkey`),
  KEY `rkey` (`rkey`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder_tree` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder_tree` (`id`, `lkey`, `rkey`, `level`) VALUES 
  (1,1,2,1);
COMMIT;

#
# Structure for the `page_page_lang` table : 
#

DROP TABLE IF EXISTS `page_page_lang`;

CREATE TABLE `page_page_lang` (
  `id` INTEGER(11) NOT NULL DEFAULT '0',
  `lang_id` INTEGER(11) NOT NULL DEFAULT '0',
  `title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` TEXT COLLATE utf8_general_ci NOT NULL,
  `keywords` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `description` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`, `lang_id`)
)ENGINE=MyISAM
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_page_lang` table  (LIMIT 0,500)
#

INSERT INTO `page_page_lang` (`id`, `lang_id`, `title`, `content`, `keywords`, `description`) VALUES 
  (1,1,'Первая страница','Это <b>первая</b>, главная <strike>страница</strike>\n',NULL,NULL),
  (1,2,'About us','<strong>mzz</strong> - is a php5 framework for web-applications.',NULL,NULL),
  (2,1,'404 Not Found','Запрашиваемая страница не найдена!',NULL,NULL),
  (2,2,'404 Not Found','Page doesn''t exist',NULL,NULL),
  (4,1,'Доступ запрещён','Доступ запрещён',NULL,NULL),
  (4,2,'Access not allowed.','Access not allowed. Try to login or register.',NULL,NULL);
COMMIT;

#
# Structure for the `quoter_quote` table : 
#

DROP TABLE IF EXISTS `quoter_quote`;

CREATE TABLE `quoter_quote` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) NOT NULL,
  `category_id` INTEGER(11) NOT NULL,
  `username` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `user` INTEGER(11) NOT NULL,
  `created` INTEGER(11) DEFAULT NULL,
  `text` TEXT COLLATE utf8_general_ci NOT NULL,
  `description` TEXT COLLATE utf8_general_ci NOT NULL,
  `rating` INTEGER(11) NOT NULL,
  `comments_count` INTEGER(11) NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quote` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quote` (`id`, `obj_id`, `category_id`, `username`, `user`, `created`, `text`, `description`, `rating`, `comments_count`) VALUES 
  (1,25,1,'',0,1226759659,'<?php\r\necho ''test'';\r\n?>','',0,0),
  (2,26,1,'',0,1226925376,'<?php\r\n/**\r\n * $URL$\r\n *\r\n * MZZ Content Management System (c) 2008\r\n * Website : http://www.mzz.ru\r\n *\r\n * This program is free software and released under\r\n * the GNU Lesser General Public License (See /docs/LGPL.txt).\r\n *\r\n * @link http://www.mzz.ru\r\n * @version $Id$\r\n */\r\n\r\n/**\r\n * quoterListController: контроллер для метода list модуля quoter\r\n *\r\n * @package modules\r\n * @subpackage quoter\r\n * @version 0.1\r\n */\r\n\r\nclass quoterListController extends simpleController\r\n{\r\n    protected function getView()\r\n    {\r\n        $action = $this->request->getAction();\r\n        $listAll = ($action == ''listAll'');\r\n\r\n        $criteria = new criteria;\r\n        $criteria->setOrderByFieldDesc(''created'');\r\n\r\n        if (!$listAll) {\r\n            $name = $this->request->getString(''name'');\r\n            $categoryMapper = $this->toolkit->getMapper(''quoter'', ''quoteCategory'');\r\n\r\n            $category = $categoryMapper->searchByName($name);\r\n            if (!$category) {\r\n                return $categoryMapper->get404()->run();\r\n            }\r\n\r\n            $criteria->add(''category_id'', $category->getId());\r\n            $this->smarty->assign(''category'', $category);\r\n        }\r\n\r\n        $quoteMapper = $this->toolkit->getMapper(''quoter'', ''quote'');\r\n        $quotes = $quoteMapper->searchAllByCriteria($criteria);\r\n\r\n        $this->smarty->assign(''quotes'', $quotes);\r\n        $this->smarty->assign(''listAll'', $listAll);\r\n        return $this->smarty->fetch(''quoter/list.tpl'');\r\n    }\r\n}\r\n\r\n?>','',0,0);
COMMIT;

#
# Structure for the `quoter_quoteCategory` table : 
#

DROP TABLE IF EXISTS `quoter_quoteCategory`;

CREATE TABLE `quoter_quoteCategory` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) NOT NULL,
  `name` CHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` CHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `quote_counts` INTEGER(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quoteCategory` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quoteCategory` (`id`, `obj_id`, `name`, `title`, `quote_counts`) VALUES 
  (1,22,'php','PHP',0),
  (2,23,'javascript','JavaScript',0);
COMMIT;

#
# Structure for the `sys_access` table : 
#

DROP TABLE IF EXISTS `sys_access`;

CREATE TABLE `sys_access` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `action_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `class_section_id` INTEGER(11) DEFAULT NULL,
  `obj_id` INTEGER(11) DEFAULT NULL,
  `uid` INTEGER(11) DEFAULT NULL,
  `gid` INTEGER(11) DEFAULT NULL,
  `allow` TINYINT(1) UNSIGNED DEFAULT '0',
  `deny` TINYINT(1) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `class_action_id` (`class_section_id`, `obj_id`, `uid`, `gid`),
  KEY `obj_id_gid` (`obj_id`, `gid`),
  KEY `obj_id_uid` (`obj_id`, `uid`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `sys_access_registry` table : 
#

DROP TABLE IF EXISTS `sys_access_registry`;

CREATE TABLE `sys_access_registry` (
  `obj_id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_section_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`obj_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=27 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_access_registry` table  (LIMIT 0,500)
#

INSERT INTO `sys_access_registry` (`obj_id`, `class_section_id`) VALUES 
  (1,9),
  (2,7),
  (3,7),
  (4,7),
  (5,7),
  (6,7),
  (7,7),
  (8,7),
  (9,7),
  (10,13),
  (11,6),
  (12,6),
  (13,6),
  (14,4),
  (15,4),
  (16,4),
  (17,3),
  (18,3),
  (19,8),
  (20,8),
  (21,8),
  (22,55),
  (23,55),
  (24,15),
  (25,54),
  (26,54);
COMMIT;

#
# Structure for the `sys_actions` table : 
#

DROP TABLE IF EXISTS `sys_actions`;

CREATE TABLE `sys_actions` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=109 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_actions` table  (LIMIT 0,500)
#

INSERT INTO `sys_actions` (`id`, `name`) VALUES 
  (1,'edit'),
  (2,'delete'),
  (3,'view'),
  (4,'create'),
  (5,'list'),
  (6,'createFolder'),
  (7,'editFolder'),
  (8,'deleteFolder'),
  (9,'editACL'),
  (10,'login'),
  (11,'exit'),
  (12,'memberOf'),
  (13,'groupDelete'),
  (14,'groupsList'),
  (15,'groupEdit'),
  (16,'membersList'),
  (17,'addToGroup'),
  (18,'editDefault'),
  (19,'post'),
  (20,'admin'),
  (21,'devToolbar'),
  (27,'upload'),
  (28,'get'),
  (29,'move'),
  (30,'moveFolder'),
  (51,'groupCreate'),
  (52,'viewGallery'),
  (53,'createAlbum'),
  (54,'editAlbum'),
  (55,'viewAlbum'),
  (56,'uploadPhoto'),
  (57,'viewThumbnail'),
  (59,'viewPhoto'),
  (60,'editPhoto'),
  (61,'save'),
  (62,'deletemenu'),
  (63,'addmenu'),
  (64,'editmenu'),
  (65,'additem'),
  (66,'last'),
  (67,'moveUp'),
  (68,'moveDown'),
  (69,'register'),
  (70,'results'),
  (71,'send'),
  (72,'addCategory'),
  (73,'deleteCategory'),
  (74,'editCategory'),
  (75,'viewActual'),
  (76,'deleteAlbum'),
  (77,'deletecat'),
  (78,'createcat'),
  (79,'editcat'),
  (80,'forum'),
  (81,'thread'),
  (82,'newThread'),
  (83,'createCategory'),
  (84,'createForum'),
  (85,'editForum'),
  (86,'goto'),
  (87,'editThread'),
  (88,'moveThread'),
  (89,'up'),
  (90,'down'),
  (91,'createRoot'),
  (92,'browse'),
  (93,'new'),
  (94,'editTags'),
  (95,'tagsCloud'),
  (96,'itemsTagsCloud'),
  (97,'searchByTag'),
  (98,'profile'),
  (99,'groupAdmin'),
  (100,'editProfile'),
  (101,'massAction'),
  (102,'translate'),
  (103,'configuration'),
  (104,'adminTypes'),
  (105,'adminProperties'),
  (106,'listAll'),
  (107,'add'),
  (108,'quote');
COMMIT;

#
# Structure for the `sys_cfg` table : 
#

DROP TABLE IF EXISTS `sys_cfg`;

CREATE TABLE `sys_cfg` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `section` INTEGER(11) NOT NULL DEFAULT '0',
  `module` INTEGER(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `section_module` (`section`, `module`)
)ENGINE=MyISAM
AUTO_INCREMENT=27 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_cfg` table  (LIMIT 0,500)
#

INSERT INTO `sys_cfg` (`id`, `section`, `module`) VALUES 
  (1,0,0),
  (2,0,1),
  (3,0,2),
  (7,0,9),
  (9,0,10),
  (15,10,10),
  (16,0,8),
  (17,1,1),
  (18,9,9),
  (19,0,5),
  (20,0,6),
  (21,0,11),
  (22,0,12),
  (23,0,17),
  (24,0,18),
  (25,0,16),
  (26,0,15);
COMMIT;

#
# Structure for the `sys_cfg_titles` table : 
#

DROP TABLE IF EXISTS `sys_cfg_titles`;

CREATE TABLE `sys_cfg_titles` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
)ENGINE=MyISAM
AUTO_INCREMENT=18 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_cfg_titles` table  (LIMIT 0,500)
#

INSERT INTO `sys_cfg_titles` (`id`, `title`) VALUES 
  (1,'Элементов на странице'),
  (2,'Каталог загрузки'),
  (3,'Кэ'),
  (4,'Ширина создаваемой превью'),
  (5,'Длина создаваемого превью'),
  (6,'Ширина создаваемого превью'),
  (7,'Секция файлменеджера'),
  (8,'Количество последних фотографий'),
  (9,''),
  (10,'public_path'),
  (11,'Длина строки'),
  (12,'Количество постов на странице'),
  (13,'Путь до каталога хранения файлов в модуле fileManager'),
  (14,'Тем на страницу'),
  (15,'Количество тем на страницу'),
  (16,'Минимальная длина тега (символов)'),
  (17,'Максимальный вес тега');
COMMIT;

#
# Structure for the `sys_cfg_types` table : 
#

DROP TABLE IF EXISTS `sys_cfg_types`;

CREATE TABLE `sys_cfg_types` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_cfg_types` table  (LIMIT 0,500)
#

INSERT INTO `sys_cfg_types` (`id`, `name`, `title`) VALUES 
  (1,'char','Строка'),
  (2,'int','Целое');
COMMIT;

#
# Structure for the `sys_cfg_values` table : 
#

DROP TABLE IF EXISTS `sys_cfg_values`;

CREATE TABLE `sys_cfg_values` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cfg_id` INTEGER(11) NOT NULL DEFAULT '0',
  `name` INTEGER(11) NOT NULL DEFAULT '0',
  `title` INTEGER(11) DEFAULT NULL,
  `type_id` INTEGER(11) NOT NULL DEFAULT '1',
  `value` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfg_id_name` (`cfg_id`, `name`)
)ENGINE=MyISAM
AUTO_INCREMENT=59 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_cfg_values` table  (LIMIT 0,500)
#

INSERT INTO `sys_cfg_values` (`id`, `cfg_id`, `name`, `title`, `type_id`, `value`) VALUES 
  (1,1,3,3,1,'true'),
  (2,2,1,1,1,'10'),
  (3,3,1,1,1,'20'),
  (14,6,1,1,1,'20'),
  (23,9,1,1,2,'10'),
  (28,4,1,1,1,'10'),
  (29,10,1,1,1,'10'),
  (31,11,1,1,1,'60'),
  (34,7,1,1,1,'10'),
  (41,17,1,1,1,'10'),
  (44,21,4,6,1,'80'),
  (45,21,5,5,1,'60'),
  (46,21,6,7,1,'fileManager'),
  (47,21,7,8,1,'5'),
  (48,18,1,1,1,'10'),
  (50,7,8,10,1,'files'),
  (53,15,1,1,1,'60'),
  (54,26,11,12,2,'10'),
  (55,21,12,13,1,'root/gallery'),
  (56,26,13,15,2,'10'),
  (57,23,14,16,2,'2'),
  (58,23,15,17,2,'5');
COMMIT;

#
# Structure for the `sys_cfg_vars` table : 
#

DROP TABLE IF EXISTS `sys_cfg_vars`;

CREATE TABLE `sys_cfg_vars` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=16 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_cfg_vars` table  (LIMIT 0,500)
#

INSERT INTO `sys_cfg_vars` (`id`, `name`) VALUES 
  (1,'items_per_page'),
  (2,'upload_path'),
  (3,'cache'),
  (4,'thmb_width'),
  (5,'thmb_height'),
  (6,'filemanager_section'),
  (7,'last_photo_number'),
  (8,'public_path'),
  (9,'strlen'),
  (10,'length'),
  (11,'posts_per_page'),
  (12,'fileManager_path'),
  (13,'threads_per_page'),
  (14,'minLength'),
  (15,'maxWeight');
COMMIT;

#
# Structure for the `sys_classes` table : 
#

DROP TABLE IF EXISTS `sys_classes`;

CREATE TABLE `sys_classes` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `module_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=58 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_classes` table  (LIMIT 0,500)
#

INSERT INTO `sys_classes` (`id`, `name`, `module_id`) VALUES 
  (1,'news',1),
  (2,'newsFolder',1),
  (3,'user',2),
  (4,'group',2),
  (6,'page',4),
  (7,'access',5),
  (8,'userGroup',2),
  (9,'admin',6),
  (10,'comments',8),
  (11,'commentsFolder',8),
  (12,'userAuth',2),
  (13,'pageFolder',4),
  (17,'file',9),
  (18,'folder',9),
  (19,'catalogue',10),
  (20,'catalogueFolder',10),
  (21,'gallery',11),
  (22,'album',11),
  (23,'photo',11),
  (24,'menuItem',12),
  (25,'menu',12),
  (26,'menuFolder',12),
  (27,'userOnline',2),
  (28,'question',13),
  (29,'answer',13),
  (30,'voteFolder',13),
  (32,'message',14),
  (33,'messageCategory',14),
  (34,'voteCategory',13),
  (35,'forum',15),
  (36,'category',15),
  (37,'thread',15),
  (38,'post',15),
  (39,'faq',16),
  (41,'faqCategory',16),
  (42,'faqFolder',16),
  (43,'categoryFolder',15),
  (44,'tags',17),
  (45,'tagsItem',17),
  (46,'tagsItemRel',17),
  (47,'captcha',18),
  (48,'profile',15),
  (49,'storage',9),
  (50,'userFolder',2),
  (52,'groupFolder',2),
  (53,'ratingsFolder',21),
  (54,'ratings',21),
  (55,'quote',22),
  (56,'quoteCategory',22),
  (57,'quoteFolder',22);
COMMIT;

#
# Structure for the `sys_classes_actions` table : 
#

DROP TABLE IF EXISTS `sys_classes_actions`;

CREATE TABLE `sys_classes_actions` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `action_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`, `action_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=298 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_classes_actions` table  (LIMIT 0,500)
#

INSERT INTO `sys_classes_actions` (`id`, `class_id`, `action_id`) VALUES 
  (1,1,1),
  (2,1,2),
  (3,1,3),
  (4,1,9),
  (5,2,4),
  (6,2,5),
  (7,2,6),
  (8,2,7),
  (9,2,8),
  (10,2,9),
  (11,3,10),
  (12,3,11),
  (13,3,5),
  (14,3,1),
  (15,3,12),
  (16,3,2),
  (17,4,13),
  (19,4,15),
  (20,4,16),
  (21,4,17),
  (22,3,9),
  (23,4,9),
  (24,6,3),
  (25,6,9),
  (28,6,1),
  (29,6,2),
  (31,7,18),
  (32,7,9),
  (34,9,3),
  (35,9,9),
  (36,10,1),
  (37,10,2),
  (38,10,9),
  (39,11,5),
  (40,11,19),
  (41,11,9),
  (46,13,9),
  (47,13,7),
  (48,13,6),
  (49,13,4),
  (50,13,5),
  (51,9,21),
  (62,18,27),
  (63,17,1),
  (64,17,28),
  (65,17,2),
  (66,17,9),
  (67,18,9),
  (68,17,18),
  (69,18,18),
  (70,1,29),
  (71,17,29),
  (72,18,6),
  (73,18,8),
  (74,18,7),
  (76,2,30),
  (77,18,30),
  (91,13,8),
  (92,13,30),
  (95,19,2),
  (99,20,5),
  (100,20,4),
  (102,20,6),
  (103,20,7),
  (104,20,30),
  (105,20,8),
  (107,19,29),
  (108,19,1),
  (111,19,9),
  (114,7,20),
  (115,20,9),
  (116,6,29),
  (129,19,3),
  (130,21,9),
  (131,22,9),
  (132,23,9),
  (133,21,52),
  (134,21,53),
  (135,22,54),
  (136,22,55),
  (137,22,56),
  (138,23,57),
  (139,23,2),
  (141,23,3),
  (143,23,59),
  (144,23,60),
  (145,24,9),
  (146,25,9),
  (147,25,3),
  (151,24,1),
  (152,24,4),
  (155,25,62),
  (156,24,2),
  (157,26,9),
  (158,26,20),
  (160,26,63),
  (161,25,64),
  (168,21,20),
  (169,28,9),
  (170,29,9),
  (171,30,9),
  (172,31,9),
  (174,28,3),
  (176,28,70),
  (177,28,1),
  (178,28,19),
  (179,32,9),
  (180,33,9),
  (181,33,5),
  (182,32,3),
  (185,33,71),
  (186,32,2),
  (187,30,20),
  (189,28,2),
  (190,34,9),
  (192,34,4),
  (194,30,72),
  (195,34,73),
  (196,34,74),
  (197,34,75),
  (198,22,76),
  (199,24,29),
  (200,35,9),
  (201,36,9),
  (202,37,9),
  (203,38,9),
  (205,39,9),
  (206,40,9),
  (207,41,9),
  (208,42,9),
  (209,41,5),
  (210,41,4),
  (211,39,1),
  (212,39,2),
  (214,41,77),
  (215,42,20),
  (216,42,78),
  (217,41,79),
  (218,43,9),
  (219,43,80),
  (221,37,81),
  (222,35,5),
  (223,35,82),
  (224,37,19),
  (225,38,1),
  (226,43,83),
  (227,35,20),
  (229,36,74),
  (230,36,84),
  (231,35,85),
  (232,37,66),
  (233,38,86),
  (234,37,87),
  (235,37,88),
  (239,25,91),
  (240,18,5),
  (241,18,92),
  (242,44,9),
  (243,45,9),
  (244,46,9),
  (249,45,96),
  (250,45,95),
  (251,45,94),
  (252,45,5),
  (253,1,97),
  (254,47,9),
  (255,47,3),
  (258,48,9),
  (259,48,98),
  (260,49,9),
  (261,36,73),
  (263,50,9),
  (264,50,20),
  (266,50,69),
  (270,50,4),
  (271,50,51),
  (272,51,9),
  (277,52,9),
  (279,52,51),
  (280,52,14),
  (281,48,100),
  (282,20,101),
  (284,53,9),
  (285,54,9),
  (286,53,3),
  (288,19,104),
  (289,19,105),
  (290,55,9),
  (291,56,9),
  (292,57,9);
COMMIT;

#
# Structure for the `sys_classes_sections` table : 
#

DROP TABLE IF EXISTS `sys_classes_sections`;

CREATE TABLE `sys_classes_sections` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `class_id` INTEGER(11) DEFAULT NULL,
  `section_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_section` (`section_id`, `class_id`),
  KEY `class_id` (`class_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=57 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_classes_sections` table  (LIMIT 0,500)
#

INSERT INTO `sys_classes_sections` (`id`, `class_id`, `section_id`) VALUES 
  (3,3,2),
  (4,4,2),
  (6,6,4),
  (7,7,6),
  (8,8,2),
  (9,9,7),
  (10,10,8),
  (11,11,8),
  (12,12,2),
  (13,13,4),
  (14,17,9),
  (15,18,9),
  (24,27,2),
  (28,31,13),
  (40,45,17),
  (41,44,17),
  (42,46,17),
  (43,47,18),
  (48,49,9),
  (49,50,2),
  (50,51,2),
  (51,52,2),
  (54,55,20),
  (55,56,20),
  (56,57,20);
COMMIT;

#
# Structure for the `sys_lang` table : 
#

DROP TABLE IF EXISTS `sys_lang`;

CREATE TABLE `sys_lang` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_lang` table  (LIMIT 0,500)
#

INSERT INTO `sys_lang` (`id`, `name`, `title`) VALUES 
  (1,'ru','ру'),
  (2,'en','en');
COMMIT;

#
# Structure for the `sys_lang_lang` table : 
#

DROP TABLE IF EXISTS `sys_lang_lang`;

CREATE TABLE `sys_lang_lang` (
  `id` INTEGER(11) UNSIGNED NOT NULL,
  `lang_id` INTEGER(11) UNSIGNED NOT NULL,
  `name` CHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`, `lang_id`)
)ENGINE=MyISAM
ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_lang_lang` table  (LIMIT 0,500)
#

INSERT INTO `sys_lang_lang` (`id`, `lang_id`, `name`) VALUES 
  (1,1,'русский'),
  (1,2,'russian'),
  (2,1,'английский'),
  (2,2,'english');
COMMIT;

#
# Structure for the `sys_modules` table : 
#

DROP TABLE IF EXISTS `sys_modules`;

CREATE TABLE `sys_modules` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `main_class` INTEGER(11) UNSIGNED DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `icon` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `order` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=23 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_modules` table  (LIMIT 0,500)
#

INSERT INTO `sys_modules` (`id`, `name`, `main_class`, `title`, `icon`, `order`) VALUES 
  (1,'news',1,'Новости','news.gif',10),
  (2,'user',50,'Пользователи','users.gif',90),
  (4,'page',6,'Страницы','pages.gif',20),
  (5,'access',7,'Права доступа','access.gif',10),
  (6,'admin',9,'Администрирование','admin.gif',20),
  (8,'comments',10,'Комментарии','comments.gif',40),
  (9,'fileManager',17,'Менеджер файлов','fm.gif',50),
  (10,'catalogue',19,'Каталог','catalogue.gif',30),
  (11,'gallery',21,'Галерея','gallery.gif',80),
  (12,'menu',26,'Меню','pages.gif',90),
  (13,'voting',30,'Голосование','voting.gif',0),
  (14,'message',32,'Сообщения пользователей','page.gif',0),
  (15,'forum',35,'Форум','forum.gif',0),
  (16,'faq',42,'FAQ','faq.gif',0),
  (17,'tags',45,'','',0),
  (18,'captcha',47,'Captcha','',0),
  (19,'pager',NULL,'Пейджер',NULL,NULL),
  (20,'simple',NULL,'simple',NULL,NULL),
  (21,'ratings',53,'Рейтинги','',0),
  (22,'quoter',57,'','',0);
COMMIT;

#
# Structure for the `sys_obj_id` table : 
#

DROP TABLE IF EXISTS `sys_obj_id`;

CREATE TABLE `sys_obj_id` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=27 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_obj_id` table  (LIMIT 0,500)
#

INSERT INTO `sys_obj_id` (`id`) VALUES 
  (1),
  (2),
  (3),
  (4),
  (5),
  (6),
  (7),
  (8),
  (9),
  (10),
  (11),
  (12),
  (13),
  (14),
  (15),
  (16),
  (17),
  (18),
  (19),
  (20),
  (21),
  (22),
  (23),
  (24),
  (25),
  (26);
COMMIT;

#
# Structure for the `sys_obj_id_named` table : 
#

DROP TABLE IF EXISTS `sys_obj_id_named`;

CREATE TABLE `sys_obj_id_named` (
  `obj_id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`obj_id`),
  UNIQUE KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=10 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_obj_id_named` table  (LIMIT 0,500)
#

INSERT INTO `sys_obj_id_named` (`obj_id`, `name`) VALUES 
  (1,'access_admin_admin'),
  (2,'access_sys_access'),
  (3,'access_captcha_captcha'),
  (4,'access_comments_comments'),
  (5,'access_fileManager_file'),
  (6,'access_page_page'),
  (7,'access_quoter_quoteFolder'),
  (8,'access_tags_tagsItem'),
  (9,'access_user_userFolder');
COMMIT;

#
# Structure for the `sys_sections` table : 
#

DROP TABLE IF EXISTS `sys_sections`;

CREATE TABLE `sys_sections` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `order` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`, `id`)
)ENGINE=MyISAM
AUTO_INCREMENT=21 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_sections` table  (LIMIT 0,500)
#

INSERT INTO `sys_sections` (`id`, `name`, `title`, `order`) VALUES 
  (2,'user','Пользователи',80),
  (4,'page','Страницы',60),
  (6,'sys','Системное',0),
  (7,'admin','Администрирование',10),
  (8,'comments','Комментарии',30),
  (9,'fileManager','Менеджер файлов',40),
  (17,'tags',NULL,NULL),
  (18,'captcha',NULL,NULL),
  (20,'quoter','Цитатник',0);
COMMIT;

#
# Structure for the `sys_skins` table : 
#

DROP TABLE IF EXISTS `sys_skins`;

CREATE TABLE `sys_skins` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_skins` table  (LIMIT 0,500)
#

INSERT INTO `sys_skins` (`id`, `name`, `title`) VALUES 
  (1,'default','default'),
  (2,'light','light');
COMMIT;

#
# Structure for the `tags_item_rel` table : 
#

DROP TABLE IF EXISTS `tags_item_rel`;

CREATE TABLE `tags_item_rel` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  `item_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  `obj_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `tags_tagCoords` table : 
#

DROP TABLE IF EXISTS `tags_tagCoords`;

CREATE TABLE `tags_tagCoords` (
  `rel_id` INTEGER(10) UNSIGNED NOT NULL,
  `x` INTEGER(11) NOT NULL,
  `y` INTEGER(11) NOT NULL,
  `w` INTEGER(11) NOT NULL,
  `h` INTEGER(11) NOT NULL,
  PRIMARY KEY (`rel_id`)
)ENGINE=MyISAM
ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `tags_tags` table : 
#

DROP TABLE IF EXISTS `tags_tags`;

CREATE TABLE `tags_tags` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `obj_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `tags_tagsItem` table : 
#

DROP TABLE IF EXISTS `tags_tagsItem`;

CREATE TABLE `tags_tagsItem` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_obj_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  `obj_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  `owner` INTEGER(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `user_group` table : 
#

DROP TABLE IF EXISTS `user_group`;

CREATE TABLE `user_group` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `is_default` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_group` table  (LIMIT 0,500)
#

INSERT INTO `user_group` (`id`, `obj_id`, `name`, `is_default`) VALUES 
  (1,14,'unauth',NULL),
  (2,15,'auth',1),
  (3,16,'root',0);
COMMIT;

#
# Structure for the `user_user` table : 
#

DROP TABLE IF EXISTS `user_user`;

CREATE TABLE `user_user` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(10) UNSIGNED NOT NULL DEFAULT '0',
  `login` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` VARCHAR(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created` INTEGER(11) DEFAULT NULL,
  `confirmed` VARCHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  `last_login` INTEGER(11) DEFAULT NULL,
  `language_id` INTEGER(11) DEFAULT NULL,
  `timezone` INTEGER(11) DEFAULT '3',
  `skin` INTEGER(11) UNSIGNED DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `login` (`login`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_user` table  (LIMIT 0,500)
#

INSERT INTO `user_user` (`id`, `obj_id`, `login`, `password`, `created`, `confirmed`, `last_login`, `language_id`, `timezone`, `skin`) VALUES 
  (1,17,'guest','',NULL,NULL,1226928564,NULL,3,1),
  (2,18,'admin','098f6bcd4621d373cade4e832627b4f6',NULL,NULL,1226760405,1,3,1);
COMMIT;

#
# Structure for the `user_userAuth` table : 
#

DROP TABLE IF EXISTS `user_userAuth`;

CREATE TABLE `user_userAuth` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `ip` CHAR(15) COLLATE utf8_general_ci DEFAULT NULL,
  `hash` CHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `time` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `user_userGroup_rel` table : 
#

DROP TABLE IF EXISTS `user_userGroup_rel`;

CREATE TABLE `user_userGroup_rel` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `group_id` INTEGER(11) DEFAULT NULL,
  `user_id` INTEGER(11) DEFAULT NULL,
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`, `user_id`),
  KEY `user_id` (`user_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=31 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userGroup_rel` table  (LIMIT 0,500)
#

INSERT INTO `user_userGroup_rel` (`id`, `group_id`, `user_id`, `obj_id`) VALUES 
  (1,1,1,19),
  (23,2,2,20),
  (24,3,2,21);
COMMIT;

#
# Structure for the `user_userOnline` table : 
#

DROP TABLE IF EXISTS `user_userOnline`;

CREATE TABLE `user_userOnline` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER(11) DEFAULT NULL,
  `session` CHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  `last_activity` INTEGER(11) DEFAULT NULL,
  `url` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `ip` CHAR(15) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`, `session`),
  KEY `last_activity` (`last_activity`)
)ENGINE=MyISAM
AUTO_INCREMENT=374 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userOnline` table  (LIMIT 0,500)
#

INSERT INTO `user_userOnline` (`id`, `user_id`, `session`, `last_activity`, `url`, `ip`) VALUES 
  (373,1,'045ddad5cffea0b825b49d86f36ddf1a',1227200801,'http://govnokod/','127.0.0.1');
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;