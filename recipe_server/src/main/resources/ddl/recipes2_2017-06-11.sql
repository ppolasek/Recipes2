# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.12)
# Database: recipes2
# Generation Time: 2017-06-11 19:42:38 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_lnmf77qvjnr2lmyxrrydom9hd` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id`, `created_on`, `updated_on`, `version`, `asset_name`, `caption`, `title`)
VALUES
	(1,'2017-06-11 13:40:33','2017-06-11 13:40:33',0,'gallery/breakfast.jpeg','Get your morning going','Breakfast'),
	(2,'2017-06-11 13:40:33','2017-06-11 13:40:33',0,'gallery/lunch.jpeg','Mid-day meals','Lunch'),
	(3,'2017-06-11 13:40:33','2017-06-11 13:40:33',0,'gallery/dinner.jpeg','A real meal','Dinner'),
	(4,'2017-06-11 13:40:33','2017-06-11 13:40:33',0,'gallery/appetizers.jpeg','Great snacks before dinner','Appetizers'),
	(5,'2017-06-11 13:40:33','2017-06-11 13:40:33',0,'gallery/desserts.jpeg','My favorite category!','Desserts');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cookbook
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cookbook`;

CREATE TABLE `cookbook` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL,
  `cookbook_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_lvko2c1oic63jrntop8s378jy` (`cookbook_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table history_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `history_item`;

CREATE TABLE `history_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL,
  `recipe_id` bigint(20) NOT NULL,
  `when_viewed` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table log_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_record`;

CREATE TABLE `log_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `level` varchar(20) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  `logger_name` varchar(50) DEFAULT NULL,
  `message` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table recipe
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipe`;

CREATE TABLE `recipe` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `category` tinyblob NOT NULL,
  `cookbook_name` varchar(100) DEFAULT NULL,
  `favorite` bit(1) NOT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `page_nrs` varchar(50) DEFAULT NULL,
  `recipe_name` varchar(100) NOT NULL,
  `recipe_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
