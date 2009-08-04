# SQL Manager 2007 for MySQL 4.4.0.3
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : govnokod


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `govnokod`;

CREATE DATABASE `govnokod`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `govnokod`;

SET sql_mode = '';

#
# Structure for the `comments_comments` table : 
#

DROP TABLE IF EXISTS `comments_comments`;

CREATE TABLE `comments_comments` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `text` TEXT COLLATE utf8_general_ci,
  `user_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `created` INTEGER(11) UNSIGNED DEFAULT NULL,
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `rating` INTEGER(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `folder_id` (`folder_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=11 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `comments_comments` table  (LIMIT 0,500)
#

INSERT INTO `comments_comments` (`id`, `text`, `user_id`, `created`, `folder_id`, `rating`) VALUES 
  (1,'test',2,1248489822,2,1),
  (2,'test',1,1248493855,2,0),
  (3,'test',2,1248949870,1,2),
  (4,'test',2,1248949904,1,-1),
  (5,'test3',2,1248949924,1,5),
  (6,'test4',2,1248950009,1,0),
  (7,'test5',2,1248950053,1,-1),
  (8,'test56',2,1248950180,1,0),
  (9,'sdgfsdf',2,1248950407,1,0),
  (10,'test',2,1249123678,2,0);
COMMIT;

#
# Structure for the `comments_commentsFolder` table : 
#

DROP TABLE IF EXISTS `comments_commentsFolder`;

CREATE TABLE `comments_commentsFolder` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `module` CHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` CHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `by_field` CHAR(25) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `comments_count` INTEGER(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_id_2` (`parent_id`, `type`),
  KEY `parent_id` (`parent_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `comments_commentsFolder` table  (LIMIT 0,500)
#

INSERT INTO `comments_commentsFolder` (`id`, `parent_id`, `module`, `type`, `by_field`, `comments_count`) VALUES 
  (1,3,'quoter','quote','id',7),
  (2,1,'quoter','quote','id',3),
  (3,2,'quoter','quote','id',0);
COMMIT;

#
# Structure for the `comments_comments_tree` table : 
#

DROP TABLE IF EXISTS `comments_comments_tree`;

CREATE TABLE `comments_comments_tree` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `foreign_key` INTEGER(11) DEFAULT NULL,
  `parent_id` INTEGER(11) DEFAULT NULL,
  `level` INTEGER(11) DEFAULT NULL,
  `path` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `foreign_key` (`foreign_key`)
)ENGINE=MyISAM
AUTO_INCREMENT=11 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `comments_comments_tree` table  (LIMIT 0,500)
#

INSERT INTO `comments_comments_tree` (`id`, `foreign_key`, `parent_id`, `level`, `path`) VALUES 
  (1,1,0,1,'1/'),
  (2,2,0,1,'2/'),
  (3,3,0,1,'3/'),
  (4,4,0,1,'4/'),
  (5,5,0,1,'5/'),
  (6,6,0,1,'6/'),
  (7,7,0,1,'7/'),
  (8,8,7,2,'7/8/'),
  (9,9,0,1,'9/'),
  (10,10,0,1,'10/');
COMMIT;

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
  `downloads` INTEGER(11) DEFAULT '0',
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
AUTO_INCREMENT=4 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `fileManager_folder` table : 
#

DROP TABLE IF EXISTS `fileManager_folder`;

CREATE TABLE `fileManager_folder` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `filesize` INTEGER(11) UNSIGNED DEFAULT NULL,
  `exts` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `storage_id` INTEGER(11) NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `fileManager_folder` table  (LIMIT 0,500)
#

INSERT INTO `fileManager_folder` (`id`, `name`, `title`, `filesize`, `exts`, `storage_id`) VALUES 
  (1,'root','root',NULL,NULL,1);
COMMIT;

#
# Structure for the `fileManager_folder_tree` table : 
#

DROP TABLE IF EXISTS `fileManager_folder_tree`;

CREATE TABLE `fileManager_folder_tree` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` TEXT COLLATE utf8_general_ci,
  `foreign_key` INTEGER(11) DEFAULT NULL,
  `level` INTEGER(11) UNSIGNED DEFAULT NULL,
  `spath` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `fileManager_folder_tree` table  (LIMIT 0,500)
#

INSERT INTO `fileManager_folder_tree` (`id`, `path`, `foreign_key`, `level`, `spath`) VALUES 
  (1,'root/',1,1,'1/');
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
  `name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` TEXT COLLATE utf8_general_ci NOT NULL,
  `keywords` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `allow_comment` TINYINT(4) DEFAULT '1',
  `compiled` INTEGER(11) DEFAULT NULL,
  `keywords_reset` TINYINT(1) DEFAULT '0',
  `description_reset` TINYINT(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `folder_id` (`folder_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_page` table  (LIMIT 0,500)
#

INSERT INTO `page_page` (`id`, `name`, `title`, `content`, `keywords`, `description`, `folder_id`, `allow_comment`, `compiled`, `keywords_reset`, `description_reset`) VALUES 
  (1,'whatisopenid','Что такое openID','OpenID — это открытая децентрализованная система единого входа. Поддержка сайтами технологии OpenID позволяет пользователю использовать единый логин для авторизации на любом из этих сайтов.','','',1,0,0,0,0),
  (2,'preferences','Описание настроек','<h3><a href=\"#userpic\" name=\"userpic\">Юзерпик</a></h3>\n<p>На выбор авторизованного пользователя есть два варианта юзерпика:</p>\n<dl>\n    <dt><a href=\"http://gravatar.com/\">Gravatar</a></dt>\n    <dd>\n        <p><a href=\"http://gravatar.com/\"><img src=\"{$SITE_PATH}/files/avatars/gravatar_100.jpg\" alt=\"Gravatar\" /></a></p>\n        <p>Граватар, или глобально распознаваемый аватар - это просто изображение, которое следует за вами от сайта к сайту, всегда рядом с вашим именем, когда вы что-либо делаете. Аватары помогают идентифицировать ваши записи в блогах и на web-форумах, так почему бы не сделать это и на <del style=\"text-decoration: line-through\">всех остальных сайтах</del> Говнокод.ру?</p>\n        <p> </p>\n    </dd>\n\n    <dt>Без аватара</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/noavatar_100.png\" alt=\"Без аватара\" /></p>\n        <p>Типичная унылая картинка, призванная хоть чем-то заполнить пространство.</p>\n    </dd>\n</dl>\n<p> </p>\n<p>Анонимусов мы не обошли стороной, предоставив ему прикольный, на наш взгляд, юзерпик:</p>\n<dl>\n    <dt>Юзерпик guest:</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/guest_100.png\" alt=\"guest avatar\" /></p>\n    </dd>\n</dl>\n<p> </p>\n<h3><a href=\"#langs\" name=\"langs\">Интересующие языки</a></h3>\n<p>Если какой-то язык Вы не понимаете или не хотите видеть по тем или иным убеждениям, то эта настройка Вам поможет! Опция не является агрессивной и будет участвовать только в формировании контента на главной странице. Это значит, что просматривать другие языки, перейдя в соответствующие разделы, всё равно будет возможно.</p>\n<p> </p>\n<h3><a href=\"#highlight\" name=\"highlight\">Способы подсветки кода</a></h3>\n<dl>\n    <dt>HighlightJS</dt>\n    <dd>\n        <p>Как видно из названия, это подсветка кода с помощью JavaScript. Плюсы подхода в том, что страницы заметно уменьшаются в размере, так как вся подсветка будет производится уже на клиентской стороне. Из минусов выделим, что с выключенным JS эта подсветка, естественно, не будет работать.</p> \n        <p> </p>\n    </dd>\n\n    <dt>Geshi</dt>\n    <dd>\n        <p>Мощный движок подсветки кода. Является серверным решением со всем вытекающими.</p>\n    </dd>\n</dl>','','',1,0,1,0,0);
COMMIT;

#
# Structure for the `page_pageFolder` table : 
#

DROP TABLE IF EXISTS `page_pageFolder`;

CREATE TABLE `page_pageFolder` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder` (`id`, `name`, `title`) VALUES 
  (1,'root','root');
COMMIT;

#
# Structure for the `page_pageFolder_tree` table : 
#

DROP TABLE IF EXISTS `page_pageFolder_tree`;

CREATE TABLE `page_pageFolder_tree` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` TEXT COLLATE utf8_general_ci,
  `foreign_key` INTEGER(11) DEFAULT NULL,
  `level` INTEGER(11) UNSIGNED DEFAULT NULL,
  `spath` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY (`id`),
  KEY `foreign_key` (`foreign_key`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder_tree` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder_tree` (`id`, `path`, `foreign_key`, `level`, `spath`) VALUES 
  (1,'root/',1,1,'1/');
COMMIT;

#
# Structure for the `quoter_quote` table : 
#

DROP TABLE IF EXISTS `quoter_quote`;

CREATE TABLE `quoter_quote` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `category_id` INTEGER(11) NOT NULL,
  `user_id` INTEGER(10) UNSIGNED NOT NULL,
  `created` INTEGER(11) DEFAULT NULL,
  `deleted` INTEGER(11) NOT NULL DEFAULT '0',
  `text` TEXT COLLATE utf8_general_ci NOT NULL,
  `description` TEXT COLLATE utf8_general_ci NOT NULL,
  `rating` INTEGER(11) NOT NULL,
  `active` INTEGER(11) NOT NULL,
  `comments_count` INTEGER(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quote` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quote` (`id`, `category_id`, `user_id`, `created`, `deleted`, `text`, `description`, `rating`, `active`, `comments_count`) VALUES 
  (1,1,1,1248257061,0,'$error = \"Всё хорошо\"; \r\nif (!$_POST[''mail''] || !checkEmail($_POST[''mail''])) {\r\n    $error .= \"Не верный E-mail\";\r\n}\r\n \r\n...\r\n \r\nif ($error == \"Всё хорошо\") {    $db->query(\"INSERT...\r\n} else {\r\n \r\n...','',-2,1,3),
  (2,7,2,1248257148,0,'asdfasdf','asdfasdf',4,1,0),
  (3,1,1,1248473224,0,'sdfsadf\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nasdfsdaf','asdfasdf',38,1,7);
COMMIT;

#
# Structure for the `quoter_quoteCategory` table : 
#

DROP TABLE IF EXISTS `quoter_quoteCategory`;

CREATE TABLE `quoter_quoteCategory` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `geshi_alias` CHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `js_alias` CHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `title` CHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `quote_counts` INTEGER(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
)ENGINE=MyISAM
AUTO_INCREMENT=14 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quoteCategory` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quoteCategory` (`id`, `name`, `geshi_alias`, `js_alias`, `title`, `quote_counts`) VALUES 
  (1,'php','php','php','PHP',2),
  (2,'javascript','javascript','javascript','JavaScript',0),
  (3,'sql','sql','sql','SQL',0),
  (4,'perl','perl','perl','PERL',0),
  (5,'python','python','python','Python',0),
  (6,'c','c','cpp','Си',0),
  (7,'cpp','cpp','cpp','C++',1),
  (8,'csharp','csharp','cs','C#',0),
  (9,'java','java','java','Java',0),
  (10,'delphi','delphi','delphi','Delphi',0),
  (11,'actionscript3','actionscript3','javascript','ActionScript',0),
  (12,'asm','asm','avrasm','Assembler',0),
  (13,'vb','vb','vbscript','VisualBasic',0);
COMMIT;

#
# Structure for the `ratings_ratings` table : 
#

DROP TABLE IF EXISTS `ratings_ratings`;

CREATE TABLE `ratings_ratings` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER(10) UNSIGNED NOT NULL,
  `created` INTEGER(11) NOT NULL,
  `ip_address` CHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `useragent` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ratevalue` INTEGER(11) NOT NULL,
  `folder_id` INTEGER(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`folder_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=114 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `ratings_ratings` table  (LIMIT 0,500)
#

INSERT INTO `ratings_ratings` (`id`, `user_id`, `created`, `ip_address`, `useragent`, `ratevalue`, `folder_id`) VALUES 
  (1,2,1249385155,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,3),
  (2,2,1249385265,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (3,2,1249385266,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (4,2,1249385268,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (5,2,1249385269,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (6,2,1249385270,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (7,2,1249385272,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (8,2,1249385273,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (9,2,1249385275,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (10,2,1249385431,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (11,2,1249385453,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (12,2,1249385476,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (13,2,1249385750,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,4),
  (14,2,1249385784,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,4),
  (15,2,1249385793,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,5),
  (16,2,1249385871,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,6),
  (17,2,1249385925,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,7),
  (18,2,1249385927,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,7),
  (19,2,1249385928,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,7),
  (20,2,1249385930,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,7),
  (21,2,1249385931,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,7),
  (22,2,1249386050,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (23,2,1249386104,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (24,2,1249386159,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (25,2,1249386411,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (26,2,1249386413,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (27,2,1249386415,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (28,2,1249386417,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (29,2,1249386418,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (30,2,1249386419,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (31,2,1249386421,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (32,2,1249386423,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (33,2,1249386424,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (34,2,1249386425,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (35,2,1249386430,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (36,2,1249386431,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (37,2,1249386433,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (38,2,1249386434,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (39,2,1249386436,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,2),
  (40,2,1249386437,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,2),
  (41,2,1249386446,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,2),
  (42,2,1249386448,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,2),
  (43,2,1249386449,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,2),
  (44,2,1249386642,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (45,2,1249386644,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (46,2,1249386651,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (47,2,1249386657,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (48,2,1249386663,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (49,2,1249386665,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (50,2,1249386671,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (51,2,1249386704,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (52,2,1249386705,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (53,2,1249386707,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (54,2,1249386709,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (55,2,1249386731,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (56,2,1249386733,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (57,2,1249386735,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (58,2,1249386737,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (59,2,1249386739,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (60,2,1249386791,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (61,2,1249386796,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (62,2,1249386798,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (63,2,1249386801,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (64,2,1249386802,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (65,2,1249386887,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (66,2,1249386889,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (67,2,1249386890,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (68,2,1249386892,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (69,2,1249386893,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (70,2,1249386895,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (71,2,1249386937,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (72,2,1249386941,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (73,2,1249386972,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (74,2,1249386974,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (75,2,1249386977,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (76,2,1249386978,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (77,2,1249387083,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (78,2,1249387117,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (79,2,1249387131,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (80,2,1249387193,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (81,2,1249387205,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (82,2,1249387244,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (83,2,1249387246,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (84,2,1249387249,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (85,2,1249387269,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (86,2,1249387319,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (87,2,1249387332,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (88,2,1249387376,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (89,2,1249387378,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (90,2,1249387409,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (91,2,1249387591,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (92,2,1249387607,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (93,2,1249387626,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (94,2,1249387632,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (95,2,1249387635,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (96,2,1249387777,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (97,2,1249387780,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (98,2,1249387849,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (99,2,1249387923,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (100,2,1249387978,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (101,2,1249388001,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (102,2,1249388030,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (103,2,1249388057,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (104,2,1249388171,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (105,2,1249388238,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (106,2,1249388248,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (107,2,1249388261,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (108,2,1249388285,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (109,2,1249388357,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (110,2,1249388370,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1),
  (111,2,1249388372,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (112,2,1249388374,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',-1,1),
  (113,2,1249388489,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2',1,1);
COMMIT;

#
# Structure for the `ratings_ratingsFolder` table : 
#

DROP TABLE IF EXISTS `ratings_ratingsFolder`;

CREATE TABLE `ratings_ratingsFolder` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` CHAR(20) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `class` CHAR(20) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ratings_on` INTEGER(10) UNSIGNED NOT NULL,
  `ratings_against` INTEGER(10) UNSIGNED NOT NULL,
  `rating` FLOAT DEFAULT NULL,
  `parent_id` INTEGER(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `module_class` (`module`, `class`)
)ENGINE=MyISAM
AUTO_INCREMENT=8 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `ratings_ratingsFolder` table  (LIMIT 0,500)
#

INSERT INTO `ratings_ratingsFolder` (`id`, `module`, `class`, `ratings_on`, `ratings_against`, `rating`, `parent_id`) VALUES 
  (1,'quoter','quote',66,28,38,3),
  (2,'quoter','quote',7,4,3,2),
  (3,'quoter','quote',0,2,-2,1),
  (4,'comments','comments',2,0,2,3),
  (5,'comments','comments',0,1,-1,4),
  (6,'comments','comments',0,1,-1,7),
  (7,'comments','comments',5,0,5,5);
COMMIT;

#
# Structure for the `sys_access` table : 
#

DROP TABLE IF EXISTS `sys_access`;

CREATE TABLE `sys_access` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `action_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `class_id` INTEGER(11) DEFAULT NULL,
  `obj_id` INTEGER(11) DEFAULT NULL,
  `uid` INTEGER(11) DEFAULT NULL,
  `gid` INTEGER(11) DEFAULT NULL,
  `allow` TINYINT(1) UNSIGNED DEFAULT '0',
  `deny` TINYINT(1) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `class_action_id` (`class_id`, `obj_id`, `uid`, `gid`),
  KEY `obj_id_gid` (`obj_id`, `gid`),
  KEY `obj_id_uid` (`obj_id`, `uid`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_access` table  (LIMIT 0,500)
#

INSERT INTO `sys_access` (`id`, `action_id`, `class_id`, `obj_id`, `uid`, `gid`, `allow`, `deny`) VALUES 
  (3,1,55,0,NULL,5,1,0);
COMMIT;

#
# Structure for the `sys_access_registry` table : 
#

DROP TABLE IF EXISTS `sys_access_registry`;

CREATE TABLE `sys_access_registry` (
  `obj_id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`obj_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=24 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_access_registry` table  (LIMIT 0,500)
#

INSERT INTO `sys_access_registry` (`obj_id`, `class_id`) VALUES 
  (1,9),
  (2,7),
  (3,7),
  (4,7),
  (5,7),
  (6,7),
  (7,7),
  (8,7),
  (9,7),
  (10,7),
  (11,7),
  (12,7),
  (13,7),
  (14,7),
  (15,7),
  (16,7),
  (17,7),
  (18,7),
  (19,7),
  (20,7),
  (22,52),
  (23,50);
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
AUTO_INCREMENT=121 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (108,'quote'),
  (109,'rss'),
  (110,'vote'),
  (111,'rate'),
  (112,'loginForm'),
  (113,'preferences'),
  (114,'search'),
  (115,'best'),
  (116,'exportAllComments'),
  (117,'listCategories'),
  (118,'openIDLogin'),
  (119,'adminCategories'),
  (120,'active');
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
AUTO_INCREMENT=62 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (57,'quoteFolder',22),
  (59,'commentsVote',8),
  (60,'userOpenID',2);
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
AUTO_INCREMENT=331 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (14,3,1),
  (15,3,12),
  (16,3,2),
  (17,4,13),
  (19,4,15),
  (20,4,16),
  (21,4,17),
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
  (266,50,69),
  (270,50,4),
  (272,51,9),
  (277,52,9),
  (279,52,51),
  (280,52,14),
  (281,48,100),
  (282,20,101),
  (288,19,104),
  (289,19,105),
  (299,55,2),
  (300,55,1),
  (301,56,74),
  (302,57,72),
  (303,58,9),
  (304,59,9),
  (306,10,110),
  (309,56,5),
  (310,3,112),
  (311,50,5),
  (313,11,8),
  (314,11,109),
  (315,57,106),
  (316,57,107),
  (318,57,20),
  (319,57,114),
  (320,57,115),
  (322,57,117),
  (323,3,3),
  (325,53,111),
  (326,55,3),
  (327,50,118),
  (328,50,113),
  (329,57,119),
  (330,55,120);
COMMIT;

#
# Structure for the `sys_config` table : 
#

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(10) UNSIGNED NOT NULL,
  `module_name` VARCHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` VARCHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type_id` INTEGER(11) NOT NULL,
  `value` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `args` TEXT COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  `title` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `icon` CHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `order` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=23 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_modules` table  (LIMIT 0,500)
#

INSERT INTO `sys_modules` (`id`, `name`, `title`, `icon`, `order`) VALUES 
  (1,'news','Новости','news.gif',10),
  (2,'user','Пользователи','users.gif',90),
  (4,'page','Страницы','pages.gif',20),
  (5,'access','Права доступа','access.gif',10),
  (6,'admin','Администрирование','admin.gif',20),
  (8,'comments','Комментарии','comments.gif',40),
  (9,'fileManager','Менеджер файлов','fm.gif',50),
  (10,'catalogue','Каталог','catalogue.gif',30),
  (11,'gallery','Галерея','gallery.gif',80),
  (12,'menu','Меню','pages.gif',90),
  (13,'voting','Голосование','voting.gif',0),
  (14,'message','Сообщения пользователей','page.gif',0),
  (15,'forum','Форум','forum.gif',0),
  (16,'faq','FAQ','faq.gif',0),
  (17,'tags','','',0),
  (18,'captcha','Captcha','',0),
  (19,'pager','Пейджер',NULL,NULL),
  (20,'simple','simple',NULL,NULL),
  (21,'ratings','Рейтинги','',0),
  (22,'quoter','Цитатник','',0);
COMMIT;

#
# Structure for the `sys_obj_id` table : 
#

DROP TABLE IF EXISTS `sys_obj_id`;

CREATE TABLE `sys_obj_id` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=24 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (23);
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
AUTO_INCREMENT=24 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `sys_obj_id_named` table  (LIMIT 0,500)
#

INSERT INTO `sys_obj_id_named` (`obj_id`, `name`) VALUES 
  (1,'access_admin'),
  (2,'access_access'),
  (3,'access_captcha'),
  (4,'access_catalogue'),
  (5,'access_comments'),
  (6,'access_faq'),
  (7,'access_fileManager'),
  (8,'access_forum'),
  (9,'access_gallery'),
  (10,'access_menu'),
  (11,'access_message'),
  (12,'access_news'),
  (13,'access_page'),
  (14,'access_pager'),
  (15,'access_quoter'),
  (16,'access_ratings'),
  (17,'access_simple'),
  (18,'access_tags'),
  (19,'access_user'),
  (20,'access_voting'),
  (21,'quoteFolder'),
  (22,'groupFolder'),
  (23,'userFolder');
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
AUTO_INCREMENT=6 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_group` table  (LIMIT 0,500)
#

INSERT INTO `user_group` (`id`, `obj_id`, `name`, `is_default`) VALUES 
  (1,14,'unauth',NULL),
  (2,15,'auth',1),
  (3,16,'root',0),
  (4,824,'moderators',0),
  (5,0,'admins',0);
COMMIT;

#
# Structure for the `user_user` table : 
#

DROP TABLE IF EXISTS `user_user`;

CREATE TABLE `user_user` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` VARCHAR(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created` INTEGER(11) DEFAULT NULL,
  `confirmed` VARCHAR(32) COLLATE utf8_general_ci DEFAULT NULL,
  `last_login` INTEGER(11) DEFAULT NULL,
  `timezone` VARCHAR(50) COLLATE utf8_general_ci DEFAULT '3',
  `skin` INTEGER(11) UNSIGNED DEFAULT '1',
  `highlight_driver` CHAR(20) COLLATE utf8_general_ci DEFAULT 'js',
  `avatar_type` INTEGER(11) DEFAULT '2',
  `preferred_langs` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY (`id`),
  KEY `login` (`login`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_user` table  (LIMIT 0,500)
#

INSERT INTO `user_user` (`id`, `login`, `email`, `password`, `created`, `confirmed`, `last_login`, `timezone`, `skin`, `highlight_driver`, `avatar_type`, `preferred_langs`) VALUES 
  (1,'guest','','',NULL,NULL,1248576546,'3',1,'js',0,''),
  (2,'admin','','098f6bcd4621d373cade4e832627b4f6',NULL,NULL,1249122515,'10',1,'js',2,'');
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
AUTO_INCREMENT=13 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userAuth` table  (LIMIT 0,500)
#

INSERT INTO `user_userAuth` (`id`, `user_id`, `ip`, `hash`, `obj_id`, `time`) VALUES 
  (6,2,'127.0.0.1','e72d5a8b19ff4c6d90a74144b0563884',NULL,NULL),
  (7,2,'127.0.0.1','48b163622d77b2e43771e790793dcb10',NULL,NULL),
  (8,2,'127.0.0.1','5d82afb95098444f58a3e080a943b7a1',NULL,NULL),
  (9,2,'127.0.0.1','f3de662b13c15da5337b98d957b8a1a8',NULL,NULL),
  (11,2,'127.0.0.1','f26cfd6bff517d558552d2eba71c06bf',NULL,NULL),
  (12,2,'127.0.0.1','05c83e93d9ad07f844450fae3e1cb8c6',NULL,NULL);
COMMIT;

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
AUTO_INCREMENT=39 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userGroup_rel` table  (LIMIT 0,500)
#

INSERT INTO `user_userGroup_rel` (`id`, `group_id`, `user_id`, `obj_id`) VALUES 
  (1,1,1,19),
  (23,2,2,20),
  (24,3,2,21),
  (31,2,4,780),
  (33,2,5,783),
  (35,4,5,825),
  (36,4,4,826),
  (37,2,6,975),
  (38,4,6,976);
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
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Structure for the `user_userOpenID` table : 
#

DROP TABLE IF EXISTS `user_userOpenID`;

CREATE TABLE `user_userOpenID` (
  `id` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER(11) NOT NULL,
  `openid_url` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `openid_url_standarized` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;