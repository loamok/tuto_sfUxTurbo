CREATE DATABASE IF NOT EXISTS `sqld` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `sqld`;

CREATE TABLE IF NOT EXISTS `wwwsqldesigner` (
  `keyword` varchar(255) NOT NULL default '',
  `data` mediumtext,
  `dt` timestamp,
  PRIMARY KEY  (`keyword`)
);


SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

COMMIT;