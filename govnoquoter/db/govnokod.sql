-- MySQL dump 10.10
--
-- Host: localhost    Database: govnokod
-- ------------------------------------------------------
-- Server version	5.0.45-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `govnokod`
--

/*!40000 DROP DATABASE IF EXISTS `govnokod`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `govnokod` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `govnokod`;

--
-- Table structure for table `comments_comments`
--

DROP TABLE IF EXISTS `comments_comments`;
CREATE TABLE `comments_comments` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `text` text NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `created` int(11) unsigned NOT NULL default '0',
  `folder_id` int(11) unsigned NOT NULL default '0',
  `rating` int(11) NOT NULL default '0',
  `votes_on` int(10) unsigned NOT NULL default '0',
  `votes_against` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `folder_id` (`folder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments_comments`
--


/*!40000 ALTER TABLE `comments_comments` DISABLE KEYS */;
INSERT INTO `comments_comments` VALUES (1,'test',2,1248489822,2,1,0,0),(2,'test',1,1248493855,2,0,0,0),(3,'test',2,1248949870,1,2,0,0),(4,'test',2,1248949904,1,-10,0,0),(5,'test3',2,1248949924,1,5,0,0),(6,'test4',2,1248950009,1,0,0,0),(7,'test5',2,1248950053,1,1,0,0),(8,'test56',2,1248950180,1,-1,0,0),(9,'sdgfsdf',2,1248950407,1,0,0,0),(10,'test',2,1249123678,2,1,0,0),(11,'testme',1,1252543218,8,0,0,0),(12,'ёёёё!',1,1252561959,6,0,0,0),(13,'стотыщраз!',1,1252562152,8,0,0,0),(14,'фывафыва',1,1252562157,8,0,0,0),(15,'test',2,1262931692,8,0,0,0);
/*!40000 ALTER TABLE `comments_comments` ENABLE KEYS */;

--
-- Table structure for table `comments_commentsFolder`
--

DROP TABLE IF EXISTS `comments_commentsFolder`;
CREATE TABLE `comments_commentsFolder` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_id` int(11) unsigned NOT NULL,
  `module` char(50) NOT NULL default '',
  `type` char(50) NOT NULL default '',
  `by_field` char(25) NOT NULL default '',
  `comments_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `parent_id_type` (`parent_id`,`type`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `comments_commentsFolder`
--


/*!40000 ALTER TABLE `comments_commentsFolder` DISABLE KEYS */;
INSERT INTO `comments_commentsFolder` VALUES (1,3,'quoter','quote','id',7),(2,1,'quoter','quote','id',3),(3,2,'quoter','quote','id',0),(4,5,'quoter','quote','id',0),(5,4,'quoter','quote','id',0),(6,6,'quoter','quote','id',1),(7,7,'quoter','quote','id',0),(8,8,'quoter','quote','id',4);
/*!40000 ALTER TABLE `comments_commentsFolder` ENABLE KEYS */;

--
-- Table structure for table `comments_comments_lseen`
--

DROP TABLE IF EXISTS `comments_comments_lseen`;
CREATE TABLE `comments_comments_lseen` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `folder_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `cnt` int(10) unsigned NOT NULL default '0',
  `time_read` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `folder_id` (`folder_id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `comments_comments_lseen`
--


/*!40000 ALTER TABLE `comments_comments_lseen` DISABLE KEYS */;
INSERT INTO `comments_comments_lseen` VALUES (3,6,2,1,1252562007),(5,8,2,4,1262931692);
/*!40000 ALTER TABLE `comments_comments_lseen` ENABLE KEYS */;

--
-- Table structure for table `comments_comments_tree`
--

DROP TABLE IF EXISTS `comments_comments_tree`;
CREATE TABLE `comments_comments_tree` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `foreign_key` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `level` int(11) default NULL,
  `path` text,
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `foreign_key` (`foreign_key`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments_comments_tree`
--


/*!40000 ALTER TABLE `comments_comments_tree` DISABLE KEYS */;
INSERT INTO `comments_comments_tree` VALUES (1,1,0,1,'1/'),(2,2,0,1,'2/'),(3,3,0,1,'3/'),(4,4,0,1,'4/'),(5,5,0,1,'5/'),(6,6,0,1,'6/'),(7,7,0,1,'7/'),(8,8,7,2,'7/8/'),(9,9,0,1,'9/'),(10,10,0,1,'10/'),(11,11,0,1,'11/'),(12,12,0,1,'12/'),(13,13,0,1,'13/'),(14,14,0,1,'14/'),(15,15,11,2,'11/15/');
/*!40000 ALTER TABLE `comments_comments_tree` ENABLE KEYS */;

--
-- Table structure for table `fileManager_file`
--

DROP TABLE IF EXISTS `fileManager_file`;
CREATE TABLE `fileManager_file` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `realname` varchar(255) default 'имя в фс в каталоге на сервере',
  `name` varchar(255) default 'имя с которым файл будет отдаваться клиенту',
  `ext` varchar(20) default NULL,
  `size` int(11) default NULL,
  `modified` int(11) default NULL,
  `downloads` int(11) default '0',
  `right_header` tinyint(4) default NULL,
  `direct_link` int(11) default '0',
  `about` text,
  `folder_id` int(11) unsigned default NULL,
  `obj_id` int(11) unsigned default NULL,
  `storage_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `realname` (`realname`),
  KEY `folder_id` (`folder_id`,`name`,`ext`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fileManager_file`
--


/*!40000 ALTER TABLE `fileManager_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `fileManager_file` ENABLE KEYS */;

--
-- Table structure for table `fileManager_folder`
--

DROP TABLE IF EXISTS `fileManager_folder`;
CREATE TABLE `fileManager_folder` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` char(255) default NULL,
  `title` char(255) default NULL,
  `filesize` int(11) unsigned default NULL,
  `exts` char(255) default NULL,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `fileManager_folder`
--


/*!40000 ALTER TABLE `fileManager_folder` DISABLE KEYS */;
INSERT INTO `fileManager_folder` VALUES (1,'root','root',NULL,NULL,1);
/*!40000 ALTER TABLE `fileManager_folder` ENABLE KEYS */;

--
-- Table structure for table `fileManager_folder_tree`
--

DROP TABLE IF EXISTS `fileManager_folder_tree`;
CREATE TABLE `fileManager_folder_tree` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `path` text,
  `foreign_key` int(11) default NULL,
  `level` int(11) unsigned default NULL,
  `spath` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fileManager_folder_tree`
--


/*!40000 ALTER TABLE `fileManager_folder_tree` DISABLE KEYS */;
INSERT INTO `fileManager_folder_tree` VALUES (1,'root/',1,1,'1/');
/*!40000 ALTER TABLE `fileManager_folder_tree` ENABLE KEYS */;

--
-- Table structure for table `fileManager_storage`
--

DROP TABLE IF EXISTS `fileManager_storage`;
CREATE TABLE `fileManager_storage` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` char(255) default NULL,
  `path` char(255) default NULL,
  `web_path` char(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `fileManager_storage`
--


/*!40000 ALTER TABLE `fileManager_storage` DISABLE KEYS */;
INSERT INTO `fileManager_storage` VALUES (1,'local','../files/','/'),(2,'avatars','files/avatars/','/files/avatars/');
/*!40000 ALTER TABLE `fileManager_storage` ENABLE KEYS */;

--
-- Table structure for table `mailer_mail`
--

DROP TABLE IF EXISTS `mailer_mail`;
CREATE TABLE `mailer_mail` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `to` varchar(255) NOT NULL default '',
  `toName` varchar(255) NOT NULL default '',
  `from` varchar(255) NOT NULL default '',
  `fromName` varchar(255) NOT NULL default '',
  `subject` varchar(255) NOT NULL default '',
  `body` text NOT NULL,
  `created` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mailer_mail`
--


/*!40000 ALTER TABLE `mailer_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailer_mail` ENABLE KEYS */;

--
-- Table structure for table `page_page`
--

DROP TABLE IF EXISTS `page_page`;
CREATE TABLE `page_page` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `content` text NOT NULL,
  `keywords` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `folder_id` int(11) unsigned default NULL,
  `allow_comment` tinyint(4) default '1',
  `compiled` int(11) default NULL,
  `keywords_reset` tinyint(1) default '0',
  `description_reset` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  KEY `folder_id` (`folder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `page_page`
--


/*!40000 ALTER TABLE `page_page` DISABLE KEYS */;
INSERT INTO `page_page` VALUES (1,'whatisopenid','Что такое openID','OpenID — это открытая децентрализованная система единого входа. Поддержка сайтами технологии OpenID позволяет пользователю использовать единый логин для авторизации на любом из этих сайтов.','','',1,0,0,0,0),(2,'preferences','Описание настроек','<h3><a href=\"#userpic\" name=\"userpic\">Юзерпик</a></h3>\n<p>На выбор авторизованного пользователя есть два варианта юзерпика:</p>\n<dl>\n    <dt><a href=\"http://gravatar.com/\">Gravatar</a></dt>\n    <dd>\n        <p><a href=\"http://gravatar.com/\"><img src=\"{$SITE_PATH}/files/avatars/gravatar_100.jpg\" alt=\"Gravatar\" /></a></p>\n        <p>Граватар, или глобально распознаваемый аватар - это просто изображение, которое следует за вами от сайта к сайту, всегда рядом с вашим именем, когда вы что-либо делаете. Аватары помогают идентифицировать ваши записи в блогах и на web-форумах, так почему бы не сделать это и на <del style=\"text-decoration: line-through\">всех остальных сайтах</del> Говнокод.ру?</p>\n    </dd>\n\n    <dt>Без аватара</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/noavatar_100.png\" alt=\"Без аватара\" /></p>\n        <p>Типичная унылая картинка, призванная хоть чем-то заполнить пространство.</p>\n    </dd>\n</dl>\n<p>Анонимусов мы не обошли стороной, предоставив ему прикольный, на наш взгляд, юзерпик:</p>\n<dl>\n    <dt>Юзерпик guest:</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/guest_100.png\" alt=\"guest avatar\" /></p>\n    </dd>\n</dl>\n<p> </p>\n<h3><a href=\"#langs\" name=\"langs\">Интересующие языки</a></h3>\n<p>Если какой-то язык Вы не понимаете или не хотите видеть по тем или иным убеждениям, то эта настройка Вам поможет! Опция не является агрессивной и будет участвовать только в формировании контента на главной странице. Это значит, что просматривать другие языки, перейдя в соответствующие разделы, всё равно будет возможно.</p>\n<p> </p>\n<h3><a href=\"#highlight\" name=\"highlight\">Способы подсветки кода</a></h3>\n<dl>\n    <dt>HighlightJS</dt>\n    <dd>\n        <p>Как видно из названия, это подсветка кода с помощью JavaScript. Плюсы подхода в том, что страницы заметно уменьшаются в размере, так как вся подсветка будет производится уже на клиентской стороне. Из минусов выделим, что с выключенным JS эта подсветка, естественно, не будет работать.</p> \n    </dd>\n\n    <dt>Geshi</dt>\n    <dd>\n        <p>Мощный движок подсветки кода. Является серверным решением со всем вытекающими.</p>\n    </dd>\n</dl>','','',1,0,1,0,0),(3,'feedback','Обратная связь','<dl>\n    <dt>Связаться непосредственно с автором можно по следующим адресам</dt>\n\n    <dd>\n        <ul>\n            <li>Электронная почта: <a href=\"&#109;&#97;&#105;&#108;&#116;&#111;&#58;%77%69%69%73%74%72%69%6b%65%72@%67%6d%61%69%6c.%63%6f%6d\" >&#x77;&#x69;&#x69;&#x73;&#x74;&#x72;&#x69;&#x6b;&#x65;&#x72;&#x40;&#x67;&#x6d;&#x61;&#x69;&#x6c;&#x2e;&#x63;&#x6f;&#x6d;</a></li>\n            <li>Jabber: <a href=\"xmpp:страйкер@jabber.ru\">страйкер@jabber.ru</a></li>\n            <li>ICQ: 257073504</li>\n        </ul>\n    </dd>\n\n    <dt>Страница проекта на <a href=\"http://code.google.com/\">google.code</a></dt>\n    <dd><a href=\"http://code.google.com/p/govnokod/\">http://code.google.com/p/govnokod/</a></dd>\n</dl>','','',1,0,0,0,0);
/*!40000 ALTER TABLE `page_page` ENABLE KEYS */;

--
-- Table structure for table `page_pageFolder`
--

DROP TABLE IF EXISTS `page_pageFolder`;
CREATE TABLE `page_pageFolder` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(255) default NULL,
  `title` char(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `page_pageFolder`
--


/*!40000 ALTER TABLE `page_pageFolder` DISABLE KEYS */;
INSERT INTO `page_pageFolder` VALUES (1,'root','root');
/*!40000 ALTER TABLE `page_pageFolder` ENABLE KEYS */;

--
-- Table structure for table `page_pageFolder_tree`
--

DROP TABLE IF EXISTS `page_pageFolder_tree`;
CREATE TABLE `page_pageFolder_tree` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `path` text,
  `foreign_key` int(11) default NULL,
  `level` int(11) unsigned default NULL,
  `spath` text,
  PRIMARY KEY  (`id`),
  KEY `foreign_key` (`foreign_key`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `page_pageFolder_tree`
--


/*!40000 ALTER TABLE `page_pageFolder_tree` DISABLE KEYS */;
INSERT INTO `page_pageFolder_tree` VALUES (1,'root/',1,1,'1/');
/*!40000 ALTER TABLE `page_pageFolder_tree` ENABLE KEYS */;

--
-- Table structure for table `quoter_quote`
--

DROP TABLE IF EXISTS `quoter_quote`;
CREATE TABLE `quoter_quote` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created` int(11) default NULL,
  `deleted` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  `description` text NOT NULL,
  `rating` float NOT NULL,
  `ratings_on` int(10) unsigned NOT NULL default '0',
  `ratings_against` int(10) unsigned NOT NULL default '0',
  `active` int(11) NOT NULL,
  `comments_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `quoter_quote`
--


/*!40000 ALTER TABLE `quoter_quote` DISABLE KEYS */;
INSERT INTO `quoter_quote` VALUES (1,1,1,1248257061,0,'$error = \"Всё хорошо\"; \r\nif (!$_POST[\'mail\'] || !checkEmail($_POST[\'mail\'])) {\r\n    $error .= \"Не верный E-mail\";\r\n}\r\n \r\n...\r\n \r\nif ($error == \"Всё хорошо\") {    $db->query(\"INSERT...\r\n} else {\r\n \r\n...','',-1,1,2,0,3),(2,7,2,1248257148,0,'asdfasdf','asdfasdf',5,0,0,1,0),(3,1,1,1248473224,0,'sdfsadf\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nasdfsdaf','asdfasdf',-2,0,2,0,7),(4,2,2,1250166047,0,'еуые','еуые',0,0,0,1,0),(5,2,2,1250166079,0,'еуые','еуые',0,0,0,1,0),(6,3,2,1252065170,0,'sdfasdf\nasd\nf\nasdf','asdf',0,0,0,1,1),(7,9,2,1252065623,0,'sdfasdfasdf','sdfsadf',0.2,2,0,1,0),(8,5,2,1252066462,0,'sdfasdf','',0.1,1,0,1,4);
/*!40000 ALTER TABLE `quoter_quote` ENABLE KEYS */;

--
-- Table structure for table `quoter_quoteCategory`
--

DROP TABLE IF EXISTS `quoter_quoteCategory`;
CREATE TABLE `quoter_quoteCategory` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(50) NOT NULL default '',
  `geshi_alias` char(50) NOT NULL default '',
  `js_alias` char(50) NOT NULL default '',
  `title` char(50) NOT NULL default '',
  `quote_counts` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `quoter_quoteCategory`
--


/*!40000 ALTER TABLE `quoter_quoteCategory` DISABLE KEYS */;
INSERT INTO `quoter_quoteCategory` VALUES (1,'php','php','php','PHP',0),(2,'javascript','javascript','javascript','JavaScript',3),(3,'sql','sql','sql','SQL',0),(4,'perl','perl','perl','PERL',0),(5,'python','python','python','Python',1),(6,'c','c','cpp','Си',0),(7,'cpp','cpp','cpp','C++',1),(8,'csharp','csharp','cs','C#',0),(9,'java','java','java','Java',0),(10,'delphi','delphi','delphi','Delphi',0),(11,'actionscript3','actionscript3','javascript','ActionScript',0),(12,'asm','asm','avrasm','Assembler',0),(13,'vb','vb','vbscript','VisualBasic',0),(14,'kucha','','','Куча',0);
/*!40000 ALTER TABLE `quoter_quoteCategory` ENABLE KEYS */;

--
-- Table structure for table `ratings_ratings`
--

DROP TABLE IF EXISTS `ratings_ratings`;
CREATE TABLE `ratings_ratings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL,
  `created` int(11) NOT NULL,
  `ip_address` char(50) NOT NULL default '',
  `useragent` varchar(255) NOT NULL default '',
  `ratevalue` float NOT NULL,
  `folder_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`folder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ratings_ratings`
--


/*!40000 ALTER TABLE `ratings_ratings` DISABLE KEYS */;
INSERT INTO `ratings_ratings` VALUES (1,1,1253838052,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,2),(2,1,1253867722,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,2),(3,1,1253867894,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,4);
/*!40000 ALTER TABLE `ratings_ratings` ENABLE KEYS */;

--
-- Table structure for table `ratings_ratingsFolder`
--

DROP TABLE IF EXISTS `ratings_ratingsFolder`;
CREATE TABLE `ratings_ratingsFolder` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `module` char(20) NOT NULL default '',
  `class` char(20) NOT NULL default '',
  `ratings_on` int(10) unsigned NOT NULL,
  `ratings_against` int(10) unsigned NOT NULL,
  `rating` float default NULL,
  `parent_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `module_class` (`module`,`class`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `ratings_ratingsFolder`
--


/*!40000 ALTER TABLE `ratings_ratingsFolder` DISABLE KEYS */;
INSERT INTO `ratings_ratingsFolder` VALUES (1,'quoter','quote',0,0,0,5),(2,'quoter','quote',2,0,0.2,7),(3,'comments','comments',0,0,0,11),(4,'quoter','quote',1,0,0.1,8);
/*!40000 ALTER TABLE `ratings_ratingsFolder` ENABLE KEYS */;

--
-- Table structure for table `sys_access`
--

DROP TABLE IF EXISTS `sys_access`;
CREATE TABLE `sys_access` (
  `id` int(11) NOT NULL auto_increment,
  `action_id` int(11) unsigned default NULL,
  `class_id` int(11) default NULL,
  `obj_id` int(11) default NULL,
  `uid` int(11) default NULL,
  `gid` int(11) default NULL,
  `allow` tinyint(1) unsigned default '0',
  `deny` tinyint(1) unsigned default '0',
  PRIMARY KEY  (`id`),
  KEY `class_action_id` (`class_id`,`obj_id`,`uid`,`gid`),
  KEY `obj_id_gid` (`obj_id`,`gid`),
  KEY `obj_id_uid` (`obj_id`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_access`
--


/*!40000 ALTER TABLE `sys_access` DISABLE KEYS */;
INSERT INTO `sys_access` VALUES (3,1,55,0,NULL,5,1,0);
/*!40000 ALTER TABLE `sys_access` ENABLE KEYS */;

--
-- Table structure for table `sys_access_registry`
--

DROP TABLE IF EXISTS `sys_access_registry`;
CREATE TABLE `sys_access_registry` (
  `obj_id` int(11) unsigned NOT NULL auto_increment,
  `class_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`obj_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_access_registry`
--


/*!40000 ALTER TABLE `sys_access_registry` DISABLE KEYS */;
INSERT INTO `sys_access_registry` VALUES (1,9),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7),(9,7),(10,7),(11,7),(12,7),(13,7),(14,7),(15,7),(16,7),(17,7),(18,7),(19,7),(20,7),(22,52),(23,50);
/*!40000 ALTER TABLE `sys_access_registry` ENABLE KEYS */;

--
-- Table structure for table `sys_actions`
--

DROP TABLE IF EXISTS `sys_actions`;
CREATE TABLE `sys_actions` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_actions`
--


/*!40000 ALTER TABLE `sys_actions` DISABLE KEYS */;
INSERT INTO `sys_actions` VALUES (1,'edit'),(2,'delete'),(3,'view'),(4,'create'),(5,'list'),(6,'createFolder'),(7,'editFolder'),(8,'deleteFolder'),(9,'editACL'),(10,'login'),(11,'exit'),(12,'memberOf'),(13,'groupDelete'),(14,'groupsList'),(15,'groupEdit'),(16,'membersList'),(17,'addToGroup'),(18,'editDefault'),(19,'post'),(20,'admin'),(21,'devToolbar'),(27,'upload'),(28,'get'),(29,'move'),(30,'moveFolder'),(51,'groupCreate'),(52,'viewGallery'),(53,'createAlbum'),(54,'editAlbum'),(55,'viewAlbum'),(56,'uploadPhoto'),(57,'viewThumbnail'),(59,'viewPhoto'),(60,'editPhoto'),(61,'save'),(62,'deletemenu'),(63,'addmenu'),(64,'editmenu'),(65,'additem'),(66,'last'),(67,'moveUp'),(68,'moveDown'),(69,'register'),(70,'results'),(71,'send'),(72,'addCategory'),(73,'deleteCategory'),(74,'editCategory'),(75,'viewActual'),(76,'deleteAlbum'),(77,'deletecat'),(78,'createcat'),(79,'editcat'),(80,'forum'),(81,'thread'),(82,'newThread'),(83,'createCategory'),(84,'createForum'),(85,'editForum'),(86,'goto'),(87,'editThread'),(88,'moveThread'),(89,'up'),(90,'down'),(91,'createRoot'),(92,'browse'),(93,'new'),(94,'editTags'),(95,'tagsCloud'),(96,'itemsTagsCloud'),(97,'searchByTag'),(98,'profile'),(99,'groupAdmin'),(100,'editProfile'),(101,'massAction'),(102,'translate'),(103,'configuration'),(104,'adminTypes'),(105,'adminProperties'),(106,'listAll'),(107,'add'),(108,'quote'),(109,'rss'),(110,'vote'),(111,'rate'),(112,'loginForm'),(113,'preferences'),(114,'search'),(115,'best'),(116,'exportAllComments'),(117,'listCategories'),(118,'openIDLogin'),(119,'adminCategories'),(120,'active'),(121,'userrss'),(122,'userquotes');
/*!40000 ALTER TABLE `sys_actions` ENABLE KEYS */;

--
-- Table structure for table `sys_classes`
--

DROP TABLE IF EXISTS `sys_classes`;
CREATE TABLE `sys_classes` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(255) default NULL,
  `module_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_classes`
--


/*!40000 ALTER TABLE `sys_classes` DISABLE KEYS */;
INSERT INTO `sys_classes` VALUES (1,'news',1),(2,'newsFolder',1),(3,'user',2),(4,'group',2),(6,'page',4),(7,'access',5),(8,'userGroup',2),(9,'admin',6),(10,'comments',8),(11,'commentsFolder',8),(12,'userAuth',2),(13,'pageFolder',4),(17,'file',9),(18,'folder',9),(19,'catalogue',10),(20,'catalogueFolder',10),(21,'gallery',11),(22,'album',11),(23,'photo',11),(24,'menuItem',12),(25,'menu',12),(26,'menuFolder',12),(27,'userOnline',2),(28,'question',13),(29,'answer',13),(30,'voteFolder',13),(32,'message',14),(33,'messageCategory',14),(34,'voteCategory',13),(35,'forum',15),(36,'category',15),(37,'thread',15),(38,'post',15),(39,'faq',16),(41,'faqCategory',16),(42,'faqFolder',16),(43,'categoryFolder',15),(44,'tags',17),(45,'tagsItem',17),(46,'tagsItemRel',17),(47,'captcha',18),(48,'profile',15),(49,'storage',9),(50,'userFolder',2),(52,'groupFolder',2),(53,'ratingsFolder',21),(54,'ratings',21),(55,'quote',22),(56,'quoteCategory',22),(57,'quoteFolder',22),(58,'userOpenID',2),(59,'commentsLastSeen',8);
/*!40000 ALTER TABLE `sys_classes` ENABLE KEYS */;

--
-- Table structure for table `sys_classes_actions`
--

DROP TABLE IF EXISTS `sys_classes_actions`;
CREATE TABLE `sys_classes_actions` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `class_id` int(11) unsigned default NULL,
  `action_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `class_id` (`class_id`,`action_id`)
) ENGINE=MyISAM AUTO_INCREMENT=335 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_classes_actions`
--


/*!40000 ALTER TABLE `sys_classes_actions` DISABLE KEYS */;
INSERT INTO `sys_classes_actions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,9),(5,2,4),(6,2,5),(7,2,6),(8,2,7),(9,2,8),(10,2,9),(11,3,10),(12,3,11),(14,3,1),(15,3,12),(16,3,2),(17,4,13),(19,4,15),(20,4,16),(21,4,17),(23,4,9),(24,6,3),(25,6,9),(28,6,1),(29,6,2),(31,7,18),(32,7,9),(34,9,3),(35,9,9),(36,10,1),(37,10,2),(38,10,9),(39,11,5),(40,11,19),(46,13,9),(47,13,7),(48,13,6),(49,13,4),(50,13,5),(51,9,21),(62,18,27),(63,17,1),(64,17,28),(65,17,2),(66,17,9),(67,18,9),(68,17,18),(69,18,18),(70,1,29),(71,17,29),(72,18,6),(73,18,8),(74,18,7),(76,2,30),(77,18,30),(91,13,8),(92,13,30),(95,19,2),(99,20,5),(100,20,4),(102,20,6),(103,20,7),(104,20,30),(105,20,8),(107,19,29),(108,19,1),(111,19,9),(114,7,20),(115,20,9),(116,6,29),(129,19,3),(130,21,9),(131,22,9),(132,23,9),(133,21,52),(134,21,53),(135,22,54),(136,22,55),(137,22,56),(138,23,57),(139,23,2),(141,23,3),(143,23,59),(144,23,60),(145,24,9),(146,25,9),(147,25,3),(151,24,1),(152,24,4),(155,25,62),(156,24,2),(157,26,9),(158,26,20),(160,26,63),(161,25,64),(168,21,20),(169,28,9),(170,29,9),(171,30,9),(172,31,9),(174,28,3),(176,28,70),(177,28,1),(178,28,19),(179,32,9),(180,33,9),(181,33,5),(182,32,3),(185,33,71),(186,32,2),(187,30,20),(189,28,2),(190,34,9),(192,34,4),(194,30,72),(195,34,73),(196,34,74),(197,34,75),(198,22,76),(199,24,29),(200,35,9),(201,36,9),(202,37,9),(203,38,9),(205,39,9),(206,40,9),(207,41,9),(208,42,9),(209,41,5),(210,41,4),(211,39,1),(212,39,2),(214,41,77),(215,42,20),(216,42,78),(217,41,79),(218,43,9),(219,43,80),(221,37,81),(222,35,5),(223,35,82),(224,37,19),(225,38,1),(226,43,83),(227,35,20),(229,36,74),(230,36,84),(231,35,85),(232,37,66),(233,38,86),(234,37,87),(235,37,88),(239,25,91),(240,18,5),(241,18,92),(242,44,9),(243,45,9),(244,46,9),(249,45,96),(250,45,95),(251,45,94),(252,45,5),(253,1,97),(254,47,9),(255,47,3),(258,48,9),(259,48,98),(260,49,9),(261,36,73),(266,50,69),(270,50,4),(272,51,9),(277,52,9),(279,52,51),(280,52,14),(281,48,100),(282,20,101),(288,19,104),(289,19,105),(299,55,2),(300,55,1),(301,56,74),(302,57,72),(303,58,9),(304,59,9),(306,10,110),(309,56,5),(310,3,112),(311,50,5),(313,11,8),(314,11,109),(315,57,106),(316,57,107),(318,57,20),(319,57,114),(320,57,115),(322,57,117),(323,3,3),(325,53,111),(326,55,3),(327,50,118),(328,50,113),(329,57,119),(330,55,120),(331,57,109),(332,57,121),(334,57,122);
/*!40000 ALTER TABLE `sys_classes_actions` ENABLE KEYS */;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(11) NOT NULL auto_increment,
  `obj_id` int(10) unsigned NOT NULL,
  `module_name` varchar(50) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `type_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL default '',
  `args` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_config`
--


/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;

--
-- Table structure for table `sys_lang`
--

DROP TABLE IF EXISTS `sys_lang`;
CREATE TABLE `sys_lang` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` char(20) default NULL,
  `title` char(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_lang`
--


/*!40000 ALTER TABLE `sys_lang` DISABLE KEYS */;
INSERT INTO `sys_lang` VALUES (1,'ru','ру'),(2,'en','en');
/*!40000 ALTER TABLE `sys_lang` ENABLE KEYS */;

--
-- Table structure for table `sys_lang_lang`
--

DROP TABLE IF EXISTS `sys_lang_lang`;
CREATE TABLE `sys_lang_lang` (
  `id` int(11) unsigned NOT NULL,
  `lang_id` int(11) unsigned NOT NULL,
  `name` char(32) default NULL,
  PRIMARY KEY  (`id`,`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_lang_lang`
--


/*!40000 ALTER TABLE `sys_lang_lang` DISABLE KEYS */;
INSERT INTO `sys_lang_lang` VALUES (1,1,'русский'),(1,2,'russian'),(2,1,'английский'),(2,2,'english');
/*!40000 ALTER TABLE `sys_lang_lang` ENABLE KEYS */;

--
-- Table structure for table `sys_modules`
--

DROP TABLE IF EXISTS `sys_modules`;
CREATE TABLE `sys_modules` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` char(255) default NULL,
  `title` char(255) default NULL,
  `icon` char(255) default NULL,
  `order` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_modules`
--


/*!40000 ALTER TABLE `sys_modules` DISABLE KEYS */;
INSERT INTO `sys_modules` VALUES (1,'news','Новости','news.gif',10),(2,'user','Пользователи','users.gif',90),(4,'page','Страницы','pages.gif',20),(5,'access','Права доступа','access.gif',10),(6,'admin','Администрирование','admin.gif',20),(8,'comments','Комментарии','comments.gif',40),(9,'fileManager','Менеджер файлов','fm.gif',50),(10,'catalogue','Каталог','catalogue.gif',30),(11,'gallery','Галерея','gallery.gif',80),(12,'menu','Меню','pages.gif',90),(13,'voting','Голосование','voting.gif',0),(14,'message','Сообщения пользователей','page.gif',0),(15,'forum','Форум','forum.gif',0),(16,'faq','FAQ','faq.gif',0),(17,'tags','','',0),(18,'captcha','Captcha','',0),(19,'pager','Пейджер',NULL,NULL),(20,'simple','simple',NULL,NULL),(21,'ratings','Рейтинги','',0),(22,'quoter','Цитатник','',0);
/*!40000 ALTER TABLE `sys_modules` ENABLE KEYS */;

--
-- Table structure for table `sys_obj_id`
--

DROP TABLE IF EXISTS `sys_obj_id`;
CREATE TABLE `sys_obj_id` (
  `id` int(11) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_obj_id`
--


/*!40000 ALTER TABLE `sys_obj_id` DISABLE KEYS */;
INSERT INTO `sys_obj_id` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23);
/*!40000 ALTER TABLE `sys_obj_id` ENABLE KEYS */;

--
-- Table structure for table `sys_obj_id_named`
--

DROP TABLE IF EXISTS `sys_obj_id_named`;
CREATE TABLE `sys_obj_id_named` (
  `obj_id` int(11) unsigned NOT NULL auto_increment,
  `name` char(255) default NULL,
  PRIMARY KEY  (`obj_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_obj_id_named`
--


/*!40000 ALTER TABLE `sys_obj_id_named` DISABLE KEYS */;
INSERT INTO `sys_obj_id_named` VALUES (1,'access_admin'),(2,'access_access'),(3,'access_captcha'),(4,'access_catalogue'),(5,'access_comments'),(6,'access_faq'),(7,'access_fileManager'),(8,'access_forum'),(9,'access_gallery'),(10,'access_menu'),(11,'access_message'),(12,'access_news'),(13,'access_page'),(14,'access_pager'),(15,'access_quoter'),(16,'access_ratings'),(17,'access_simple'),(18,'access_tags'),(19,'access_user'),(20,'access_voting'),(21,'quoteFolder'),(22,'groupFolder'),(23,'userFolder');
/*!40000 ALTER TABLE `sys_obj_id_named` ENABLE KEYS */;

--
-- Table structure for table `sys_skins`
--

DROP TABLE IF EXISTS `sys_skins`;
CREATE TABLE `sys_skins` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` char(32) default NULL,
  `title` char(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `sys_skins`
--


/*!40000 ALTER TABLE `sys_skins` DISABLE KEYS */;
INSERT INTO `sys_skins` VALUES (1,'default','default'),(2,'light','light');
/*!40000 ALTER TABLE `sys_skins` ENABLE KEYS */;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `id` int(11) NOT NULL auto_increment,
  `obj_id` int(10) unsigned NOT NULL default '0',
  `name` char(255) default NULL,
  `is_default` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_group`
--


/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,14,'unauth',NULL),(2,15,'auth',1),(3,16,'root',0),(4,824,'moderators',0),(5,0,'admins',0);
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `module` char(32) NOT NULL default '',
  `role` char(32) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_module_role` (`group_id`,`module`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_roles`
--


/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
CREATE TABLE `user_user` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `password` varchar(32) NOT NULL default '',
  `created` int(11) default NULL,
  `confirmed` varchar(32) default NULL,
  `last_login` int(11) default NULL,
  `timezone` varchar(50) default '3',
  `skin` int(11) unsigned default '1',
  `quotes_count` int(10) unsigned NOT NULL default '0',
  `highlight_driver` char(20) default 'js',
  `avatar_type` int(11) default '2',
  `preferred_langs` text,
  PRIMARY KEY  (`id`),
  KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_user`
--


/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'guest','','',NULL,NULL,1248576546,'3',1,2,'js',0,''),(2,'admin','','098f6bcd4621d373cade4e832627b4f6',NULL,NULL,1253773150,'10',1,6,'js',2,''),(4,'sdfasdfasdf','sadfsadf@sdfasdf.ru','202cb962ac59075b964b07152d234b70',1253961725,'005a0882dcea82748a4f3f6a46c3ed7b',1253961725,'-5',1,0,'js',2,NULL),(5,'sdfasdfasdfsdf','sadfsadfsdf@sdfasdf.ru','202cb962ac59075b964b07152d234b70',1253961805,NULL,1253961805,'-5',1,0,'js',2,NULL);
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;

--
-- Table structure for table `user_userAuth`
--

DROP TABLE IF EXISTS `user_userAuth`;
CREATE TABLE `user_userAuth` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned default NULL,
  `ip` char(15) default NULL,
  `hash` char(32) default NULL,
  `time` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_userAuth`
--


/*!40000 ALTER TABLE `user_userAuth` DISABLE KEYS */;
INSERT INTO `user_userAuth` VALUES (4,2,'127.0.0.1','1e27e369faa572da4ef2dd5ce8d5a438',1262928828);
/*!40000 ALTER TABLE `user_userAuth` ENABLE KEYS */;

--
-- Table structure for table `user_userGroup_rel`
--

DROP TABLE IF EXISTS `user_userGroup_rel`;
CREATE TABLE `user_userGroup_rel` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `obj_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_userGroup_rel`
--


/*!40000 ALTER TABLE `user_userGroup_rel` DISABLE KEYS */;
INSERT INTO `user_userGroup_rel` VALUES (1,1,1,19),(23,2,2,20),(24,3,2,21),(31,2,4,780),(33,2,5,783),(35,4,5,825),(36,4,4,826),(37,2,6,975),(38,4,6,976);
/*!40000 ALTER TABLE `user_userGroup_rel` ENABLE KEYS */;

--
-- Table structure for table `user_userOnline`
--

DROP TABLE IF EXISTS `user_userOnline`;
CREATE TABLE `user_userOnline` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `session` char(32) default NULL,
  `last_activity` int(11) default NULL,
  `url` char(255) default NULL,
  `ip` char(15) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`session`),
  KEY `last_activity` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_userOnline`
--


/*!40000 ALTER TABLE `user_userOnline` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_userOnline` ENABLE KEYS */;

--
-- Table structure for table `user_userOpenID`
--

DROP TABLE IF EXISTS `user_userOpenID`;
CREATE TABLE `user_userOpenID` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `openid_url` varchar(255) NOT NULL default '',
  `openid_url_standarized` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_userOpenID`
--


/*!40000 ALTER TABLE `user_userOpenID` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_userOpenID` ENABLE KEYS */;

--
-- Dumping routines for database 'govnokod'
--
DELIMITER ;;
DELIMITER ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

