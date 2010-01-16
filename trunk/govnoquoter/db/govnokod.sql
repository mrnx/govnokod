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
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments_comments`
--


/*!40000 ALTER TABLE `comments_comments` DISABLE KEYS */;
INSERT INTO `comments_comments` VALUES (1,'test',2,1248489822,2,1,0,0),(2,'test',1,1248493855,2,0,0,0),(3,'test',2,1248949870,1,2,0,0),(4,'test',2,1248949904,1,-10,0,0),(5,'test3',2,1248949924,1,5,0,0),(6,'test4',2,1248950009,1,0,0,0),(7,'test5',2,1248950053,1,1,0,0),(8,'test56',2,1248950180,1,-1,0,0),(9,'sdgfsdf',2,1248950407,1,0,0,0),(10,'test',2,1249123678,2,1,0,0),(11,'testme',1,1252543218,8,0,0,0),(12,'ёёёё!',1,1252561959,6,0,0,0),(13,'стотыщраз!',1,1252562152,8,0,0,0),(14,'фывафыва',1,1252562157,8,-1,0,1),(15,'test',2,1262931692,8,0,0,0),(16,'trololo',2,1263565387,8,0,0,0),(17,'trululu',2,1263565501,8,0,0,0),(18,'sdfsdf',2,1263566367,7,0,0,0),(19,'zskdfjslkdfj',2,1263566482,5,0,0,0),(20,'sdfsdf',2,1263567040,3,0,0,0),(21,'казу казу казу',2,1263568350,5,0,0,0);
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
INSERT INTO `comments_commentsFolder` VALUES (1,3,'quoter','quote','id',7),(2,1,'quoter','quote','id',3),(3,2,'quoter','quote','id',1),(4,5,'quoter','quote','id',0),(5,4,'quoter','quote','id',2),(6,6,'quoter','quote','id',1),(7,7,'quoter','quote','id',1),(8,8,'quoter','quote','id',6);
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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `comments_comments_lseen`
--


/*!40000 ALTER TABLE `comments_comments_lseen` DISABLE KEYS */;
INSERT INTO `comments_comments_lseen` VALUES (3,6,2,1,1252562007),(8,8,2,6,1263565501),(9,7,2,1,1263566367),(14,5,2,2,1263568350),(13,3,2,1,1263567040),(15,8,6,6,1263631537);
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
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments_comments_tree`
--


/*!40000 ALTER TABLE `comments_comments_tree` DISABLE KEYS */;
INSERT INTO `comments_comments_tree` VALUES (1,1,0,1,'1/'),(2,2,0,1,'2/'),(3,3,0,1,'3/'),(4,4,0,1,'4/'),(5,5,0,1,'5/'),(6,6,0,1,'6/'),(7,7,0,1,'7/'),(8,8,7,2,'7/8/'),(9,9,0,1,'9/'),(10,10,0,1,'10/'),(11,11,0,1,'11/'),(12,12,0,1,'12/'),(13,13,0,1,'13/'),(14,14,0,1,'14/'),(15,15,11,2,'11/15/'),(16,16,0,1,'16/'),(17,17,16,2,'16/17/'),(18,18,0,1,'18/'),(19,19,0,1,'19/'),(20,20,0,1,'20/'),(21,21,19,2,'19/21/');
/*!40000 ALTER TABLE `comments_comments_tree` ENABLE KEYS */;

--
-- Table structure for table `fileManager_file`
--

DROP TABLE IF EXISTS `fileManager_file`;
CREATE TABLE `fileManager_file` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `realname` char(255) NOT NULL default '',
  `name` char(255) NOT NULL default '',
  `ext` char(20) NOT NULL default '',
  `size` int(11) NOT NULL default '0',
  `modified` int(11) NOT NULL default '0',
  `downloads` int(11) NOT NULL default '0',
  `right_header` tinyint(4) NOT NULL default '0',
  `direct_link` int(11) NOT NULL default '0',
  `about` text NOT NULL,
  `folder_id` int(11) unsigned NOT NULL default '0',
  `storage_id` int(11) NOT NULL default '0',
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
  `name` char(255) NOT NULL default '',
  `title` char(255) NOT NULL default '',
  `filesize` int(11) unsigned NOT NULL default '0',
  `exts` char(255) NOT NULL default '',
  `storage_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `fileManager_folder`
--


/*!40000 ALTER TABLE `fileManager_folder` DISABLE KEYS */;
INSERT INTO `fileManager_folder` VALUES (1,'root','root',0,'',1);
/*!40000 ALTER TABLE `fileManager_folder` ENABLE KEYS */;

--
-- Table structure for table `fileManager_folder_tree`
--

DROP TABLE IF EXISTS `fileManager_folder_tree`;
CREATE TABLE `fileManager_folder_tree` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `path` text NOT NULL,
  `foreign_key` int(11) unsigned NOT NULL default '0',
  `level` int(11) unsigned NOT NULL default '0',
  `spath` text NOT NULL,
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
  `name` char(255) NOT NULL,
  `path` char(255) NOT NULL,
  `web_path` char(255) NOT NULL,
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
  `folder_id` int(11) unsigned NOT NULL default '0',
  `compiled` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `folder_id` (`folder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `page_page`
--


/*!40000 ALTER TABLE `page_page` DISABLE KEYS */;
INSERT INTO `page_page` VALUES (1,'whatisopenid','Что такое openID','OpenID — это открытая децентрализованная система единого входа. Поддержка сайтами технологии OpenID позволяет пользователю использовать единый логин для авторизации на любом из этих сайтов.',1,0),(2,'preferences','Описание настроек','<h3><a href=\"#userpic\" name=\"userpic\">Юзерпик</a></h3>\n<p>На выбор авторизованного пользователя есть два варианта юзерпика:</p>\n<dl>\n    <dt><a href=\"http://gravatar.com/\">Gravatar</a></dt>\n    <dd>\n        <p><a href=\"http://gravatar.com/\"><img src=\"{$SITE_PATH}/files/avatars/gravatar_100.jpg\" alt=\"Gravatar\" /></a></p>\n        <p>Граватар, или глобально распознаваемый аватар - это просто изображение, которое следует за вами от сайта к сайту, всегда рядом с вашим именем, когда вы что-либо делаете. Аватары помогают идентифицировать ваши записи в блогах и на web-форумах, так почему бы не сделать это и на <del style=\"text-decoration: line-through\">всех остальных сайтах</del> Говнокод.ру?</p>\n    </dd>\n\n    <dt>Без аватара</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/noavatar_100.png\" alt=\"Без аватара\" /></p>\n        <p>Типичная унылая картинка, призванная хоть чем-то заполнить пространство.</p>\n    </dd>\n</dl>\n<p>Анонимусов мы не обошли стороной, предоставив ему прикольный, на наш взгляд, юзерпик:</p>\n<dl>\n    <dt>Юзерпик guest:</dt>\n    <dd>\n        <p><img src=\"{$SITE_PATH}/files/avatars/guest_100.png\" alt=\"guest avatar\" /></p>\n    </dd>\n</dl>\n<p> </p>\n<h3><a href=\"#langs\" name=\"langs\">Интересующие языки</a></h3>\n<p>Если какой-то язык Вы не понимаете или не хотите видеть по тем или иным убеждениям, то эта настройка Вам поможет! Опция не является агрессивной и будет участвовать только в формировании контента на главной странице. Это значит, что просматривать другие языки, перейдя в соответствующие разделы, всё равно будет возможно.</p>\n<p> </p>\n<h3><a href=\"#highlight\" name=\"highlight\">Способы подсветки кода</a></h3>\n<dl>\n    <dt>HighlightJS</dt>\n    <dd>\n        <p>Как видно из названия, это подсветка кода с помощью JavaScript. Плюсы подхода в том, что страницы заметно уменьшаются в размере, так как вся подсветка будет производится уже на клиентской стороне. Из минусов выделим, что с выключенным JS эта подсветка, естественно, не будет работать.</p> \n    </dd>\n\n    <dt>Geshi</dt>\n    <dd>\n        <p>Мощный движок подсветки кода. Является серверным решением со всем вытекающими.</p>\n    </dd>\n</dl>',1,1),(3,'feedback','Обратная связь','<dl>\n    <dt>Связаться непосредственно с автором можно по следующим адресам</dt>\n\n    <dd>\n        <ul>\n            <li>Электронная почта: <a href=\"&#109;&#97;&#105;&#108;&#116;&#111;&#58;%77%69%69%73%74%72%69%6b%65%72@%67%6d%61%69%6c.%63%6f%6d\" >&#x77;&#x69;&#x69;&#x73;&#x74;&#x72;&#x69;&#x6b;&#x65;&#x72;&#x40;&#x67;&#x6d;&#x61;&#x69;&#x6c;&#x2e;&#x63;&#x6f;&#x6d;</a></li>\n            <li>Jabber: <a href=\"xmpp:страйкер@jabber.ru\">страйкер@jabber.ru</a></li>\n            <li>ICQ: 257073504</li>\n        </ul>\n    </dd>\n\n    <dt>Страница проекта на <a href=\"http://code.google.com/\">google.code</a></dt>\n    <dd><a href=\"http://code.google.com/p/govnokod/\">http://code.google.com/p/govnokod/</a></dd>\n</dl>',1,0),(4,'injustice','Не пришло письмо подтверждения регистрации?','<p>Ничего страшного!</p>',1,0);
/*!40000 ALTER TABLE `page_page` ENABLE KEYS */;

--
-- Table structure for table `page_pageFolder`
--

DROP TABLE IF EXISTS `page_pageFolder`;
CREATE TABLE `page_pageFolder` (
  `id` int(11) NOT NULL auto_increment,
  `name` char(255) NOT NULL default '',
  `title` char(255) NOT NULL default '',
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
  `path` text NOT NULL,
  `foreign_key` int(11) NOT NULL default '0',
  `level` int(11) unsigned NOT NULL default '0',
  `spath` text NOT NULL,
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
  `created` int(11) unsigned NOT NULL default '0',
  `deleted` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  `description` text NOT NULL,
  `rating` float NOT NULL,
  `ratings_on` int(10) unsigned NOT NULL default '0',
  `ratings_against` int(10) unsigned NOT NULL default '0',
  `active` int(11) NOT NULL,
  `last_comment_id` int(10) unsigned NOT NULL default '0',
  `comments_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `quoter_quote`
--


/*!40000 ALTER TABLE `quoter_quote` DISABLE KEYS */;
INSERT INTO `quoter_quote` VALUES (1,1,1,1248257061,0,'$error = \"Всё хорошо\"; \r\nif (!$_POST[\'mail\'] || !checkEmail($_POST[\'mail\'])) {\r\n    $error .= \"Не верный E-mail\";\r\n}\r\n \r\n...\r\n \r\nif ($error == \"Всё хорошо\") {    $db->query(\"INSERT...\r\n} else {\r\n \r\n...','',-1,1,2,0,0,3),(2,7,2,1248257148,0,'asdfasdf','asdfasdf',5,0,0,1,20,1),(3,1,1,1248473224,0,'sdfsadf\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nasdfsdaf','asdfasdf',-2,0,2,0,0,7),(4,2,2,1250166047,0,'еуые\nsdfsdfasdf','еуые',0,0,0,1,21,2),(5,2,2,1250166079,0,'еуые','еуые',0,0,0,1,0,0),(6,3,2,1252065170,0,'SELECT * FROM\n`table`','asdfsadf\nas\ndf\nasdfasdf',0.1,1,0,1,0,1),(7,9,2,1252065623,0,'sdfasdfasdf','sdfsadf',0.3,3,0,1,18,1),(8,5,2,1252066462,0,'sdfasdf','',0.2,2,0,1,17,6);
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
INSERT INTO `quoter_quoteCategory` VALUES (1,'php','php','php','PHP',0),(2,'javascript','javascript','javascript','JavaScript',2),(3,'sql','sql','sql','SQL',1),(4,'perl','perl','perl','PERL',0),(5,'python','python','python','Python',1),(6,'c','c','cpp','Си',0),(7,'cpp','cpp','cpp','C++',1),(8,'csharp','csharp','cs','C#',0),(9,'java','java','java','Java',0),(10,'delphi','delphi','delphi','Delphi',0),(11,'actionscript3','actionscript3','javascript','ActionScript',0),(12,'asm','asm','avrasm','Assembler',0),(13,'vb','vb','vbscript','VisualBasic',0),(14,'kucha','','','Куча',0);
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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ratings_ratings`
--


/*!40000 ALTER TABLE `ratings_ratings` DISABLE KEYS */;
INSERT INTO `ratings_ratings` VALUES (1,1,1253838052,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,2),(2,1,1253867722,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,2),(3,1,1253867894,'127.0.0.1','Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.2.15 Version/10.00',0.1,4),(4,1,1262934092,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6',0.1,4),(5,1,1262934330,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6',0.1,2),(6,1,1262934337,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6',0.1,5),(7,2,1263625236,'127.0.0.1','Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7',-1,6);
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `ratings_ratingsFolder`
--


/*!40000 ALTER TABLE `ratings_ratingsFolder` DISABLE KEYS */;
INSERT INTO `ratings_ratingsFolder` VALUES (1,'quoter','quote',0,0,0,5),(2,'quoter','quote',3,0,0.3,7),(3,'comments','comments',0,0,0,11),(4,'quoter','quote',2,0,0.2,8),(5,'quoter','quote',1,0,0.1,6),(6,'comments','comments',0,1,-1,14);
/*!40000 ALTER TABLE `ratings_ratingsFolder` ENABLE KEYS */;

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
  `name` char(255) default '',
  `is_default` tinyint(4) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_group`
--


/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,'unauth',NULL),(2,'auth',1),(3,'root',0),(4,'moderators',0),(5,'admins',0);
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
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_roles`
--


/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,2,'quoter','user'),(2,4,'quoter','moderator'),(3,5,'quoter','admin'),(4,5,'quoter','moderator'),(5,4,'admin','moderator'),(8,5,'user','moderator');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
CREATE TABLE `user_user` (
  `id` int(11) NOT NULL auto_increment,
  `login` char(255) NOT NULL default '',
  `email` char(255) NOT NULL default '',
  `password` char(32) NOT NULL default '',
  `created` int(11) unsigned NOT NULL default '0',
  `confirmed` char(32) NOT NULL default '',
  `recover_code` char(32) NOT NULL default '',
  `recover_time` int(10) unsigned NOT NULL default '0',
  `last_login` int(11) unsigned NOT NULL default '0',
  `timezone` int(11) NOT NULL default '3',
  `skin` int(11) unsigned NOT NULL default '1',
  `quotes_count` int(10) unsigned NOT NULL default '0',
  `highlight_driver` char(20) NOT NULL default 'js',
  `avatar_type` int(11) NOT NULL default '2',
  `preferred_langs` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_user`
--


/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'guest','','',0,'','',0,1248576546,3,1,2,'js',0,''),(2,'admin','','098f6bcd4621d373cade4e832627b4f6',0,'','',0,1263623229,10,1,6,'js',2,''),(6,'striker','striker@bk.ru','202cb962ac59075b964b07152d234b70',1263629202,'','',0,1263632065,3,1,0,'js',2,''),(5,'sdfasdfasdfsdf','sadfsadfsdf@sdfasdf.ru','202cb962ac59075b964b07152d234b70',1253961805,'','',0,1253961805,-5,1,0,'js',2,''),(7,'striker123','striker123@bk.ru','202cb962ac59075b964b07152d234b70',1263629733,'','',0,1263629733,3,1,0,'js',2,''),(8,'striker123123','wii.striker@gmail.com','202cb962ac59075b964b07152d234b70',1263633882,'','',0,1263633882,3,1,0,'js',2,'');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;

--
-- Table structure for table `user_userAuth`
--

DROP TABLE IF EXISTS `user_userAuth`;
CREATE TABLE `user_userAuth` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL default '0',
  `ip` char(15) NOT NULL default '',
  `hash` char(32) NOT NULL default '',
  `time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_userAuth`
--


/*!40000 ALTER TABLE `user_userAuth` DISABLE KEYS */;
INSERT INTO `user_userAuth` VALUES (6,2,'127.0.0.1','2e2df9ab709a8c1b8180f702125c5f34',1263564888);
/*!40000 ALTER TABLE `user_userAuth` ENABLE KEYS */;

--
-- Table structure for table `user_userGroup_rel`
--

DROP TABLE IF EXISTS `user_userGroup_rel`;
CREATE TABLE `user_userGroup_rel` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) unsigned NOT NULL default '0',
  `user_id` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Dumping data for table `user_userGroup_rel`
--


/*!40000 ALTER TABLE `user_userGroup_rel` DISABLE KEYS */;
INSERT INTO `user_userGroup_rel` VALUES (1,1,1),(2,3,2),(3,2,6),(4,2,7),(7,2,8);
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
  `user_id` int(11) unsigned NOT NULL,
  `openid_url` char(255) NOT NULL default '',
  `openid_url_standarized` char(255) NOT NULL default '',
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

