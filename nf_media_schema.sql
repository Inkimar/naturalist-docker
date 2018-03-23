-- MySQL dump 10.13  Distrib 5.6.39, for Linux (x86_64)
--
-- Host: localhost    Database: nf_media
-- ------------------------------------------------------
-- Server version	5.6.39

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
-- Table structure for table `ADMIN_CONFIG`
--

DROP TABLE IF EXISTS `ADMIN_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADMIN_CONFIG` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ATTACHMENTS`
--

DROP TABLE IF EXISTS `ATTACHMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ATTACHMENTS` (
  `UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`UUID`),
  CONSTRAINT `FK_MEDIA_ATTACHMENTS` FOREIGN KEY (`UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(63) COLLATE utf8_unicode_ci NOT NULL,
  `AUTHOR` varchar(63) COLLATE utf8_unicode_ci NOT NULL,
  `FILENAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MD5SUM` varchar(35) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMMENTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LIQUIBASE` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DETERMINATION`
--

DROP TABLE IF EXISTS `DETERMINATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DETERMINATION` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TAG_KEY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EXTERNAL_SYSTEM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EXTERNAL_SYSTEM_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEDIA_UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SORT_ORDER` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_DETERMINATION_MEDIA` (`MEDIA_UUID`),
  CONSTRAINT `FK_DETERMINATION_MEDIA` FOREIGN KEY (`MEDIA_UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=10737 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IMAGE`
--

DROP TABLE IF EXISTS `IMAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IMAGE` (
  `UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `IS_EXPORTED` tinyint(1) DEFAULT '0',
  `EXIF` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`UUID`),
  CONSTRAINT `FK_MEDIA_UUID` FOREIGN KEY (`UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LIC`
--

DROP TABLE IF EXISTS `LIC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIC` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ABBREV` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VERSION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ISSUER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URI` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MEDIA`
--

DROP TABLE IF EXISTS `MEDIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MEDIA` (
  `UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DTYPE` varchar(31) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FILENAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MIME_TYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OWNER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VISIBILITY` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAGS` text COLLATE utf8_unicode_ci,
  `RESTFUL_STREAM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ALT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HASH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `copyrightOwnerLink` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalTitle` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originalTitleLink` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modification` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `authorDerivative` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MEDIA_TEXT`
--

DROP TABLE IF EXISTS `MEDIA_TEXT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MEDIA_TEXT` (
  `UUID` int(11) NOT NULL AUTO_INCREMENT,
  `LEGEND` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LANG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEDIA_UUID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMMENT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=10691 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MEDIA_X_LIC`
--

DROP TABLE IF EXISTS `MEDIA_X_LIC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MEDIA_X_LIC` (
  `LIC_ID` int(11) NOT NULL,
  `MEDIA_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`LIC_ID`,`MEDIA_ID`),
  KEY `FK_MEDIA_LIC_1` (`MEDIA_ID`),
  CONSTRAINT `FK_MEDIA_LIC_1` FOREIGN KEY (`MEDIA_ID`) REFERENCES `MEDIA` (`UUID`),
  CONSTRAINT `FK_MEDIA_LIC_2` FOREIGN KEY (`LIC_ID`) REFERENCES `LIC` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SOUND`
--

DROP TABLE IF EXISTS `SOUND`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SOUND` (
  `UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `IS_EXPORTED` tinyint(1) DEFAULT '0',
  `START_TIME` int(11) DEFAULT NULL,
  `END_TIME` int(11) DEFAULT NULL,
  PRIMARY KEY (`UUID`),
  CONSTRAINT `FK_MEDIA_SOUND` FOREIGN KEY (`UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TAGS`
--

DROP TABLE IF EXISTS `TAGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TAGS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TAG_KEY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEDIA_UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `FK_TAGS_MEDIA` (`MEDIA_UUID`),
  CONSTRAINT `FK_TAGS_MEDIA` FOREIGN KEY (`MEDIA_UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=10679 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `VIDEO`
--

DROP TABLE IF EXISTS `VIDEO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VIDEO` (
  `UUID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `IS_EXPORTED` tinyint(1) DEFAULT '0',
  `START_TIME` int(11) DEFAULT NULL,
  `END_TIME` int(11) DEFAULT NULL,
  PRIMARY KEY (`UUID`),
  CONSTRAINT `FK_MEDIA_VIDEO` FOREIGN KEY (`UUID`) REFERENCES `MEDIA` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-22 10:31:07
