# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.12)
# Database: recipes2
# Generation Time: 2017-07-13 20:40:08 +0000
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
  `favorite` bit(1) NOT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `page_nrs` varchar(50) DEFAULT NULL,
  `recipe_name` varchar(100) NOT NULL,
  `recipe_url` varchar(500) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  `cookbook_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrufhnv33hpfxstx9x108553kj` (`category_id`),
  KEY `FKsn5npoilvjktpcg2tosxg3yg1` (`cookbook_id`),
  CONSTRAINT `FKrufhnv33hpfxstx9x108553kj` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FKsn5npoilvjktpcg2tosxg3yg1` FOREIGN KEY (`cookbook_id`) REFERENCES `cookbook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table recipe_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipe_tag`;

CREATE TABLE `recipe_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL,
  `tag_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table recipe_tag_join
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipe_tag_join`;

CREATE TABLE `recipe_tag_join` (
  `recipe_id` bigint(20) NOT NULL,
  `recipe_tags_id` bigint(20) NOT NULL,
  PRIMARY KEY (`recipe_id`,`recipe_tags_id`),
  UNIQUE KEY `UK_ovxjgjo58a289qvie5bacqxi9` (`recipe_tags_id`),
  CONSTRAINT `FK29d7u7v421f58ddw4k1bwg0ue` FOREIGN KEY (`recipe_tags_id`) REFERENCES `recipe_tag` (`id`),
  CONSTRAINT `FKkky0adladi9iqmwtvetqvjjnr` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
