# SQL Manager 2007 for MySQL 4.3.4.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : govnokod


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES cp1251 */;

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
  `obj_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `text` TEXT COLLATE utf8_general_ci,
  `author` VARCHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `author_ip` CHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `time` INTEGER(11) UNSIGNED DEFAULT NULL,
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=35 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `comments_comments` table  (LIMIT 0,500)
#

INSERT INTO `comments_comments` (`id`, `obj_id`, `text`, `author`, `author_ip`, `time`, `folder_id`) VALUES 
  (1,52,'zhep','2','',1227942640,1),
  (2,54,'wsdfasdf\r\n','2','',1227944856,2),
  (3,58,'lkajsdfkljxcv,mnwesdf\r\nas\r\ndf\r\nasdfas\r\ndf\r\nasdfasd\r\nf\r\nasd\r\nfa\r\nsdf\r\nasd\r\nfs\r\ndf\r\nasd\r\nfa\r\nsdf\r\nwdf',NULL,'',1227960648,1),
  (4,59,'sdfsdf',NULL,'',1227960677,1),
  (5,60,'sadklfjaslkdjf','sdfskdfj','',1227961524,1),
  (6,61,'sadklfjaslkdjf','sdfskdfj','',1227962282,1),
  (7,62,'ыдвлаофдлыва','двыфлаоыва','',1227962423,1),
  (8,63,'ыдвлаофдлыва','двыфлаоыва','',1227962465,1),
  (9,64,'<h1>asdf','/><h1>asdf','',1227962535,1),
  (10,65,'говно','тестер','127.0.0.1',1227962866,1),
  (11,67,'test','user','127.0.0.1',1228028311,5),
  (12,68,'text2','user2','127.0.0.1',1228028326,5),
  (13,71,'zdfdsf','esdf','127.0.0.1',1228055461,6),
  (14,72,'asdkfjhdskf','sdfklj','127.0.0.1',1228055476,6),
  (15,73,'sdf','sdf','127.0.0.1',1228055693,6),
  (16,74,'sdfkj','asdlfkjasldkf','127.0.0.1',1228056570,6),
  (17,75,'dfklj','test2','127.0.0.1',1228056599,6),
  (18,77,'asdlfkj\nsdf','striker','127.0.0.1',1228138713,7),
  (19,78,'sdf','striker2','127.0.0.1',1228138994,7),
  (20,79,'sdf','striker2','127.0.0.1',1228139024,7),
  (21,80,'sdf','striker2','127.0.0.1',1228139142,7),
  (23,82,'asldkfj','test','127.0.0.1',1228139221,7),
  (24,83,'asldkfj','test','127.0.0.1',1228139269,7),
  (25,84,'asldkfj','test','127.0.0.1',1228139299,7),
  (26,85,'asldkfj','test','127.0.0.1',1228139362,7),
  (27,86,'asldkfj','test','127.0.0.1',1228139375,7),
  (28,87,'sdklfjdsf','test','127.0.0.1',1228139504,7),
  (29,88,'Вы жопы','striker','127.0.0.1',1228140041,7),
  (30,89,'test','zhep','127.0.0.1',1228140956,7),
  (31,92,'По-моему это всё говно!','striker','127.0.0.1',1228220731,9),
  (32,93,'tesdf','striker','127.0.0.1',1228221903,6),
  (33,95,'test','strikerasdklfhaklsdhfkjah','127.0.0.1',1228276218,4),
  (34,97,'zhep','striker','127.0.0.1',1228276421,11);
COMMIT;

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
AUTO_INCREMENT=12 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `comments_commentsFolder` table  (LIMIT 0,500)
#

INSERT INTO `comments_commentsFolder` (`id`, `obj_id`, `parent_id`) VALUES 
  (1,51,48),
  (2,53,46),
  (3,55,50),
  (4,57,56),
  (5,66,49),
  (6,70,69),
  (7,76,43),
  (8,90,41),
  (9,91,40),
  (10,94,38),
  (11,96,47);
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
  `title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` TEXT COLLATE utf8_general_ci NOT NULL,
  `keywords` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `folder_id` INTEGER(11) UNSIGNED DEFAULT NULL,
  `allow_comment` TINYINT(4) DEFAULT '1',
  `compiled` INTEGER(11) DEFAULT NULL,
  `keywords_reset` TINYINT(1) DEFAULT '0',
  `description_reset` TINYINT(1) DEFAULT '0',
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=6 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_page` table  (LIMIT 0,500)
#

INSERT INTO `page_page` (`id`, `obj_id`, `name`, `title`, `content`, `keywords`, `description`, `folder_id`, `allow_comment`, `compiled`, `keywords_reset`, `description_reset`) VALUES 
  (1,11,'main','','','','',1,1,0,0,0),
  (5,31,'php','PHP: Hypertext Preprocessor','PHP is a widely-used general-purpose scripting language that is especially suited for Web development and can be embedded into HTML.','','',2,0,0,0,0);
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
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder` (`id`, `obj_id`, `name`, `title`, `parent`, `path`) VALUES 
  (1,10,'root','root',1,'root'),
  (2,30,'languages','Описание языков программирования',2,'root/languages');
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
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `page_pageFolder_tree` table  (LIMIT 0,500)
#

INSERT INTO `page_pageFolder_tree` (`id`, `lkey`, `rkey`, `level`) VALUES 
  (1,1,4,1),
  (2,2,3,2);
COMMIT;

#
# Structure for the `quoter_quote` table : 
#

DROP TABLE IF EXISTS `quoter_quote`;

CREATE TABLE `quoter_quote` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `obj_id` INTEGER(11) NOT NULL,
  `category_id` INTEGER(11) NOT NULL,
  `created` INTEGER(11) DEFAULT NULL,
  `text` TEXT COLLATE utf8_general_ci NOT NULL,
  `highlited_lines` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` TEXT COLLATE utf8_general_ci NOT NULL,
  `rating` INTEGER(11) NOT NULL,
  `active` INTEGER(11) NOT NULL,
  `comments_count` INTEGER(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=19 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quote` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quote` (`id`, `obj_id`, `category_id`, `created`, `text`, `highlited_lines`, `description`, `rating`, `active`, `comments_count`) VALUES 
  (6,38,3,1227331945,'SELECT *\r\nFROM basenews bs\r\nWHERE \r\n    1 \r\n    AND\r\n    bs.id in (SELECT bsnet.id_basenews FROM basenewscategory bsnet WHERE bsnet.id_s_news_essence = \"3\")\r\nORDER BY bs.datein DESC\r\nLIMIT 0, 10','6','описание',1,1,0),
  (8,40,1,1227353872,'$error = \"Всё хорошо\";\r\n \r\nif (!$_POST[''mail''] || !checkEmail($_POST[''mail''])) {\r\n    $error .= \"Не верный E-mail\";\r\n}\r\n \r\n...\r\n \r\nif ($error == \"Всё хорошо\") {\r\n    $db->query(\"INSERT...\r\n} else {\r\n \r\n...','1, 9','',4,1,1),
  (9,41,1,1227608639,'sa\r\ndf\r\nas\r\ndf\r\nas\r\ndf\r\nwdf','3, 6','',1,1,0),
  (10,42,1,1227774485,'sdfds','','asdfsdf',1,1,0),
  (11,43,5,1227774578,'sdfsf','','<h1>test',1,1,12),
  (12,46,1,1227869406,'<?php\r\n/**\r\n * $URL$$URL$$URL$\r\n *\r\n * MZZ Content Management System (c) 2008\r\n * Website : http://www.mzz.ru\r\n *\r\n * This program is free software and released under\r\n * the GNU Lesser General Public License (See /docs/LGPL.txt).\r\n *\r\n * @link http://www.mzz.ru\r\n * @version $Id$\r\n */\r\n\r\n/**\r\n * quoterListController: контроллер для метода list модуля quoter\r\n *\r\n * @package modules\r\n * @subpackage quoter\r\n * @version 0.1\r\n */\r\n\r\nclass quoterListController extends simpleController\r\n{\r\n    protected function getView()\r\n    {\r\n        $action = $this->request->getAction();\r\n        $listAll = ($action == ''listAll'');\r\n\r\n        $criteria = new criteria;\r\n        $criteria->add(''active'', 1)->setOrderByFieldDesc(''created'');\r\n\r\n        $categoryMapper = $this->toolkit->getMapper(''quoter'', ''quoteCategory'');\r\n        $categories = $categoryMapper->searchAll();\r\n        $this->smarty->assign(''categories'', $categories);\r\n\r\n        if (!$listAll) {\r\n            $name = $this->request->getString(''name'');\r\n\r\n            $category = null;\r\n            foreach ($categories as $cat) {\r\n                if ($cat->getName() == $name) {\r\n                    $category = $cat;\r\n                    break;\r\n                }\r\n            }\r\n\r\n            if (!$category) {\r\n                return $categoryMapper->get404()->run();\r\n            }\r\n\r\n            $criteria->add(''category_id'', $category->getId());\r\n            $this->smarty->assign(''category'', $category);\r\n        }\r\n\r\n        $quoteMapper = $this->toolkit->getMapper(''quoter'', ''quote'');\r\n        $pager = $this->setPager($quoteMapper, 10, true);\r\n        $quotes = $quoteMapper->searchAllByCriteria($criteria);\r\n\r\n        //если получаем список конкретной категории, то есть шанс пересчитать количество элементов в категории\r\n        if (!$listAll) {\r\n            if ($category->getQuoteCounts() != $pager->getItemsCount()) {\r\n                $category->setQuoteCounts($pager->getItemsCount());\r\n                $categoryMapper->save($category);\r\n            }\r\n        }\r\n\r\n        $this->smarty->assign(''quotes'', $quotes);\r\n        $this->smarty->assign(''listAll'', $listAll);\r\n        return $this->smarty->fetch(''quoter/list.tpl'');\r\n    }\r\n}\r\n\r\n?>','23, 34','описание',1,1,0),
  (13,47,1,1227917115,'<?php\r\n/**\r\n * \r\n *\r\n * MZZ Content Management System (c) 2008\r\n * Website : http://www.mzz.ru\r\n *\r\n * This program is free software and released under\r\n * the GNU Lesser General Public License (See /docs/LGPL.txt).\r\n *\r\n * @link http://www.mzz.ru\r\n * @version $Id$\r\n */\r\n\r\n/**\r\n * quoterListController: контроллер для метода list модуля quoter\r\n *\r\n * @package modules\r\n * @subpackage quoter\r\n * @version 0.1\r\n */\r\n\r\nclass quoterListController extends simpleController\r\n{\r\n    protected function getView()\r\n    {\r\n        $action = $this->request->getAction();\r\n        $listAll = ($action == ''listAll'');\r\n\r\n        $criteria = new criteria;\r\n        $criteria->add(''active'', 1)->setOrderByFieldDesc(''created'');\r\n\r\n        $categoryMapper = $this->toolkit->getMapper(''quoter'', ''quoteCategory'');\r\n        $categories = $categoryMapper->searchAll();\r\n        $this->smarty->assign(''categories'', $categories);\r\n\r\n        if (!$listAll) {\r\n            $name = $this->request->getString(''name'');\r\n\r\n            $category = null;\r\n            foreach ($categories as $cat) {\r\n                if ($cat->getName() == $name) {\r\n                    $category = $cat;\r\n                    break;\r\n                }\r\n            }\r\n\r\n            if (!$category) {\r\n                return $categoryMapper->get404()->run();\r\n            }\r\n\r\n            $criteria->add(''category_id'', $category->getId());\r\n            $this->smarty->assign(''category'', $category);\r\n        }\r\n\r\n        $quoteMapper = $this->toolkit->getMapper(''quoter'', ''quote'');\r\n        $pager = $this->setPager($quoteMapper, 10, true);\r\n        $quotes = $quoteMapper->searchAllByCriteria($criteria);\r\n\r\n        //если получаем список конкретной категории, то есть шанс пересчитать количество элементов в категории\r\n        if (!$listAll) {\r\n            if ($category->getQuoteCounts() != $pager->getItemsCount()) {\r\n                $category->setQuoteCounts($pager->getItemsCount());\r\n                $categoryMapper->save($category);\r\n            }\r\n        }\r\n\r\n        $this->smarty->assign(''quotes'', $quotes);\r\n        $this->smarty->assign(''listAll'', $listAll);\r\n        return $this->smarty->fetch(''quoter/list.tpl'');\r\n    }\r\n}\r\n\r\n?>','','0',2,1,1),
  (14,48,1,1227939331,'s\r\ndf\r\nas\r\ndf\r\nas\r\ndf','','sdfsdf',0,1,0),
  (15,49,1,1227939358,'sd\r\nfa\r\nsdf\r\nas\r\ndf','','0',0,1,2),
  (16,50,1,1227939458,'as\r\ndf\r\nasd\r\nf\r\nasdf','','',0,1,0),
  (17,56,1,1227958275,'session_start();\r\nif ($_SESSION[''ok''] !== 1){\r\necho \"Сделали , блок сесиией\";\r\n$_SESSION[''ok''] = ''1'';\r\n } else {\r\necho \"Блок!\";\r\n}','2, 4','Mr_Smile: сматрите ) в первый раз на странице должна быть надпись \"Сделали блок сессией\"\r\nMr_Smile:  при последующих обновлениях надпись должн абыть \"Блок\"\r\nMr_Smile: а сколько ни обновляй все кажет \"Сделали блок сессией\"\r\nMr_Smile: я ахутнГ?',0,1,1),
  (18,69,1,1228053313,'<?php\r\n/**\r\n * $URL$\r\n *\r\n * MZZ Content Management System (c) 2008\r\n * Website : http://www.mzz.ru\r\n *\r\n * This program is free software and released under\r\n * the GNU Lesser General Public License (See /docs/LGPL.txt).\r\n *\r\n * @link http://www.mzz.ru\r\n * @version $Id$\r\n */\r\n\r\nfileLoader::load(''forms/validators/formValidator'');\r\n\r\n/**\r\n * quoterSaveController: контроллер для метода add модуля quoter\r\n *\r\n * @package modules\r\n * @subpackage quoter\r\n * @version 0.1\r\n */\r\n\r\nclass quoterSaveController extends simpleController\r\n{\r\n    protected function getView()\r\n    {\r\n        $action = $this->request->getAction();\r\n        $isEdit = ($action == ''edit'');\r\n\r\n        $quoteMapper = $this->toolkit->getMapper(''quoter'', ''quote'');\r\n        $categoryMapper = $this->toolkit->getMapper(''quoter'', ''quoteCategory'');\r\n        if ($isEdit) {\r\n            $id = $this->request->getInteger(''id'');\r\n            $quote = $quoteMapper->searchById($id);\r\n\r\n            if (!$quote) {\r\n                return $quoteMapper->get404()->run();\r\n            }\r\n        } else {\r\n            $quote = $quoteMapper->create();\r\n        }\r\n\r\n        $currentCategory = (!$isEdit) ? $this->request->getString(''name'') : '''';\r\n        $this->smarty->assign(''currentCategory'', ($isEdit) ? $quote->getCategory()->getId() : null);\r\n\r\n        $categories = $categoryMapper->searchAll();\r\n        $categoriesSelect = array();\r\n        foreach ($categories as $category) {\r\n            if (!$isEdit && $category->getName() == $currentCategory) {\r\n                $this->smarty->assign(''currentCategory'', $category->getId());\r\n            }\r\n            $categoriesSelect[$category->getId()] = $category->getTitle();\r\n        }\r\n\r\n        $lines = $quote->getHighlightedLines();\r\n        $linesPost = $this->request->getArray(''lines'', SC_POST);\r\n        if ($linesPost) {\r\n            $lines = $linesPost;\r\n        }\r\n        $this->smarty->assign(''lines'', $lines);\r\n\r\n        $validator = new formValidator();\r\n        $validator->add(''required'', ''text'', ''Укажите код'');\r\n        $validator->add(''callback'', ''text'', ''Такой длинный код врядли может быть смешным'', array(''checkCodeLength''));\r\n        $validator->add(''required'', ''category_id'', ''Укажите язык'');\r\n        $validator->add(''in'', ''category_id'', ''Укажите правильный язык'', array_keys($categoriesSelect));\r\n\r\n        if (!$isEdit) {\r\n            $validator->add(''required'', ''captcha'', ''Произвол не пройдёт!'');\r\n            $validator->add(''captcha'', ''captcha'', ''Неверно введен проверочный код!'');\r\n        }\r\n\r\n        if ($validator->validate()) {\r\n            $categoryId = $this->request->getInteger(''category_id'', SC_POST);\r\n            $text = $this->request->getString(''text'', SC_POST);\r\n            $description = $this->request->getString(''description'', SC_POST);\r\n\r\n            $lines = $this->request->getArray(''lines'', SC_POST);\r\n            if (!is_array($lines)) {\r\n                $lines = array();\r\n            }\r\n\r\n            $linesCount = substr_count($text, \"\\n\");\r\n\r\n            $highlightedLines = array();\r\n            foreach ($lines as $line) {\r\n                if ($line > 0 && $line <= $linesCount && !in_array($line, $highlightedLines)) {\r\n                    $highlightedLines[] = $line;\r\n                }\r\n            }\r\n\r\n            $quote->setCategory($categoryId);\r\n            $quote->setText(trim($text));\r\n            $quote->setDescription($description);\r\n            $quote->setHighlitedLines(join('', '', $highlightedLines));\r\n            $quoteMapper->save($quote);\r\n\r\n            $url = new url(''quoteView'');','','<?php\r\n/**\r\n * $URL$\r\n *\r\n * MZZ Content Management System (c) 2008\r\n * Website : http://www.mzz.ru\r\n *\r\n * This program is free software and released under\r\n * the GNU Lesser General Public License (See /docs/LGPL.txt).\r\n *\r\n * @link http://www.mzz.ru\r\n * @version $Id$\r\n */\r\n\r\nfileLoader::load(''forms/validators/formValidator'');\r\n\r\n/**\r\n * quoterSaveController: контроллер для метода add модуля quoter\r\n *\r\n * @package modules\r\n * @subpackage quoter\r\n * @version 0.1\r\n */\r\n\r\nclass quoterSaveController extends simpleController\r\n{\r\n    protected function getView()\r\n    {\r\n        $action = $this->request->getAction();\r\n        $isEdit = ($action == ''edit'');\r\n\r\n        $quoteMapper = $this->toolkit->getMapper(''quoter'', ''quote'');\r\n        $categoryMapper = $this->toolkit->getMapper(''quoter'', ''quoteCategory'');\r\n        if ($isEdit) {\r\n            $id = $this->request->getInteger(''id'');\r\n            $quote = $quoteMapper->searchById($id);\r\n\r\n            if (!$quote) {\r\n                return $quoteMapper->get404()->run();\r\n            }\r\n        } else {\r\n            $quote = $quoteMapper->create();\r\n        }\r\n\r\n        $currentCategory = (!$isEdit) ? $this->request->getString(''name'') : '''';\r\n        $this->smarty->assign(''currentCategory'', ($isEdit) ? $quote->getCategory()->getId() : null);\r\n\r\n        $categories = $categoryMapper->searchAll();\r\n        $categoriesSelect = array();\r\n        foreach ($categories as $category) {\r\n            if (!$isEdit && $category->getName() == $currentCategory) {\r\n                $this->smarty->assign(''currentCategory'', $category->getId());\r\n            }\r\n            $categoriesSelect[$category->getId()] = $category->getTitle();\r\n        }\r\n\r\n        $lines = $quote->getHighlightedLines();\r\n        $linesPost = $this->request->getArray(''lines'', SC_POST);\r\n        if ',1,1,6);
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
AUTO_INCREMENT=7 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_quoteCategory` table  (LIMIT 0,500)
#

INSERT INTO `quoter_quoteCategory` (`id`, `obj_id`, `name`, `title`, `quote_counts`) VALUES 
  (1,22,'php','PHP',10),
  (2,23,'javascript','JavaScript',0),
  (3,34,'mysql','MySQL',1),
  (4,35,'perl','PERL',0),
  (5,36,'python','Python',1),
  (6,45,'cpp','C++',0);
COMMIT;

#
# Structure for the `quoter_votes` table : 
#

DROP TABLE IF EXISTS `quoter_votes`;

CREATE TABLE `quoter_votes` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(20) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `quote_id` INTEGER(11) NOT NULL,
  `created` INTEGER(11) NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=9 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `quoter_votes` table  (LIMIT 0,500)
#

INSERT INTO `quoter_votes` (`id`, `ip`, `quote_id`, `created`) VALUES 
  (1,'127.0.0.1',13,1227926027),
  (2,'127.0.0.1',12,1227926070),
  (3,'127.0.0.1',10,1227926174),
  (4,'127.0.0.1',9,1227926226),
  (5,'127.0.0.1',8,1227926231),
  (6,'127.0.0.1',11,1227926590),
  (7,'127.0.0.1',13,1227936796),
  (8,'127.0.0.1',18,1228054138);
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
AUTO_INCREMENT=98 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (27,49),
  (28,51),
  (30,13),
  (31,6),
  (34,55),
  (35,55),
  (36,55),
  (38,54),
  (40,54),
  (41,54),
  (42,54),
  (43,54),
  (44,56),
  (45,55),
  (46,54),
  (47,54),
  (48,54),
  (49,54),
  (50,54),
  (51,11),
  (52,10),
  (53,11),
  (54,10),
  (55,11),
  (56,54),
  (57,11),
  (58,10),
  (59,10),
  (60,10),
  (61,10),
  (62,10),
  (63,10),
  (64,10),
  (65,10),
  (66,11),
  (67,10),
  (68,10),
  (69,54),
  (70,11),
  (71,10),
  (72,10),
  (73,10),
  (74,10),
  (75,10),
  (76,11),
  (77,10),
  (78,10),
  (79,10),
  (80,10),
  (82,10),
  (83,10),
  (84,10),
  (85,10),
  (86,10),
  (87,10),
  (88,10),
  (89,10),
  (90,11),
  (91,11),
  (92,10),
  (93,10),
  (94,11),
  (95,10),
  (96,11),
  (97,10);
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
AUTO_INCREMENT=111 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (110,'searchAll');
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
AUTO_INCREMENT=308 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (292,57,9),
  (299,55,2),
  (300,55,1),
  (305,57,72),
  (306,56,74),
  (307,57,110);
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
  (22,'quoter',57,'Цитатник','',0);
COMMIT;

#
# Structure for the `sys_obj_id` table : 
#

DROP TABLE IF EXISTS `sys_obj_id`;

CREATE TABLE `sys_obj_id` (
  `id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=98 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (26),
  (27),
  (28),
  (29),
  (30),
  (31),
  (32),
  (33),
  (34),
  (35),
  (36),
  (37),
  (38),
  (39),
  (40),
  (41),
  (42),
  (43),
  (44),
  (45),
  (46),
  (47),
  (48),
  (49),
  (50),
  (51),
  (52),
  (53),
  (54),
  (55),
  (56),
  (57),
  (58),
  (59),
  (60),
  (61),
  (62),
  (63),
  (64),
  (65),
  (66),
  (67),
  (68),
  (69),
  (70),
  (71),
  (72),
  (73),
  (74),
  (75),
  (76),
  (77),
  (78),
  (79),
  (80),
  (81),
  (82),
  (83),
  (84),
  (85),
  (86),
  (87),
  (88),
  (89),
  (90),
  (91),
  (92),
  (93),
  (94),
  (95),
  (96),
  (97);
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
AUTO_INCREMENT=45 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

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
  (9,'access_user_userFolder'),
  (27,'user_userFolder'),
  (28,'user_groupFolder'),
  (44,'quoter_quoteFolder');
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
  (1,17,'guest','',NULL,NULL,1227260702,NULL,3,1),
  (2,18,'admin','2cdcbe2c0a133787ceeb5516360c1cde',NULL,NULL,1226760405,1,3,1);
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
AUTO_INCREMENT=3 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userAuth` table  (LIMIT 0,500)
#

INSERT INTO `user_userAuth` (`id`, `user_id`, `ip`, `hash`, `obj_id`, `time`) VALUES 
  (1,2,'127.0.0.1','ff8016044599df55feddb81887319425',NULL,1228272639),
  (2,2,'127.0.0.1','687ff7f98a7f3ea102baee8cf5ab4ffc',NULL,1227331503);
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
AUTO_INCREMENT=377 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

#
# Data for the `user_userOnline` table  (LIMIT 0,500)
#

INSERT INTO `user_userOnline` (`id`, `user_id`, `session`, `last_activity`, `url`, `ip`) VALUES 
  (376,2,'093f5a031e5859f82bbc8b5158ad0750',1227261708,'http://govnokod/admin/user/admin','127.0.0.1');
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;