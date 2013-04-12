CREATE DATABASE  IF NOT EXISTS `bus_reservation` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bus_reservation`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: bus_reservation
-- ------------------------------------------------------
-- Server version	5.5.28-log

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
-- Table structure for table `bus`
--

DROP TABLE IF EXISTS `bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_type_id` int(11) NOT NULL,
  `plate_number` varchar(45) NOT NULL,
  `assigned_route_forward_id` int(11) DEFAULT NULL,
  `assigned_route_return_id` int(11) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `bus_bus_type_id_idx` (`bus_type_id`),
  KEY `bus_assigned_route_forward_id_idx` (`assigned_route_forward_id`),
  KEY `bus_assigned_route_return_id_idx` (`assigned_route_return_id`),
  CONSTRAINT `bus_assigned_route_forward_id` FOREIGN KEY (`assigned_route_forward_id`) REFERENCES `route` (`id`),
  CONSTRAINT `bus_assigned_route_return_id` FOREIGN KEY (`assigned_route_return_id`) REFERENCES `route` (`id`),
  CONSTRAINT `bus_bus_type_id` FOREIGN KEY (`bus_type_id`) REFERENCES `bus_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,1,'1111-1111',NULL,NULL,'active'),(2,2,'2222-2222',NULL,NULL,'active'),(3,1,'47H1-123.45',NULL,NULL,'active'),(4,1,'59F1-123.45',NULL,NULL,'active'),(5,1,'T1',1,2,'active'),(6,1,'T2',1,2,'active'),(7,1,'T3',1,2,'active'),(8,1,'T4',1,2,'active'),(9,1,'T5',1,2,'active'),(10,2,'N1',1,2,'active'),(11,2,'N2',1,2,'active'),(12,2,'N3',1,2,'active'),(13,2,'N4',1,2,'active'),(14,2,'N5',1,2,'active');
/*!40000 ALTER TABLE `bus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `bus_free_time`
--

DROP TABLE IF EXISTS `bus_free_time`;
/*!50001 DROP VIEW IF EXISTS `bus_free_time`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `bus_free_time` (
  `id` int(11),
  `bus_id` int(11),
  `from_date` datetime,
  `to_date` datetime,
  `station_id` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bus_status`
--

DROP TABLE IF EXISTS `bus_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) NOT NULL,
  `bus_status` varchar(20) NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `end_station_id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `bus_status_bus_id_idx` (`bus_id`),
  KEY `bus_status_end_station_id_idx` (`end_station_id`),
  CONSTRAINT `bus_status_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`),
  CONSTRAINT `bus_status_end_station_id` FOREIGN KEY (`end_station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_status`
--

LOCK TABLES `bus_status` WRITE;
/*!40000 ALTER TABLE `bus_status` DISABLE KEYS */;
INSERT INTO `bus_status` VALUES (154,3,'ontrip','2013-04-11 22:46:00','2013-04-12 12:46:00',8,'active'),(155,3,'ontrip','2013-04-13 12:46:00','2013-04-14 02:46:00',3,'active'),(156,3,'ontrip','2013-04-15 02:46:00','2013-04-15 16:46:00',8,'active'),(157,3,'ontrip','2013-04-16 16:46:00','2013-04-17 06:46:00',3,'active'),(158,3,'ontrip','2013-04-18 06:46:00','2013-04-18 20:46:00',8,'active'),(159,3,'ontrip','2013-04-19 20:46:00','2013-04-20 10:46:00',3,'active'),(160,3,'ontrip','2013-04-21 10:46:00','2013-04-22 00:46:00',8,'active'),(161,3,'ontrip','2013-04-23 00:46:00','2013-04-23 14:46:00',3,'active'),(162,3,'ontrip','2013-04-24 14:46:00','2013-04-25 04:46:00',8,'active'),(163,3,'ontrip','2013-04-26 04:46:00','2013-04-26 18:46:00',3,'active'),(164,3,'ontrip','2013-04-27 18:46:00','2013-04-28 08:46:00',8,'active'),(165,3,'ontrip','2013-04-29 08:46:00','2013-04-29 22:46:00',3,'active'),(166,3,'ontrip','2013-04-30 22:46:00','2013-05-01 12:46:00',8,'active'),(167,3,'ontrip','2013-05-02 12:46:00','2013-05-03 02:46:00',3,'active'),(168,3,'ontrip','2013-05-04 02:46:00','2013-05-04 16:46:00',8,'active'),(169,3,'ontrip','2013-05-05 16:46:00','2013-05-06 06:46:00',3,'active'),(170,3,'ontrip','2013-05-07 06:46:00','2013-05-07 20:46:00',8,'active'),(171,3,'ontrip','2013-05-08 20:46:00','2013-05-09 10:46:00',3,'active'),(172,3,'ontrip','2013-05-10 10:46:00','2013-05-11 00:46:00',8,'active'),(173,3,'ontrip','2013-05-12 00:46:00','2013-05-12 14:46:00',3,'active'),(174,3,'ontrip','2013-05-13 14:46:00','2013-05-14 04:46:00',8,'active'),(175,3,'ontrip','2013-05-15 04:46:00','2013-05-15 18:46:00',3,'active'),(176,3,'ontrip','2013-05-16 18:46:00','2013-05-17 08:46:00',8,'active'),(177,3,'ontrip','2013-05-18 08:46:00','2013-05-18 22:46:00',3,'active'),(178,3,'ontrip','2013-05-19 22:46:00','2013-05-20 12:46:00',8,'active'),(179,3,'ontrip','2013-05-21 12:46:00','2013-05-22 02:46:00',3,'active'),(180,3,'ontrip','2013-05-23 02:46:00','2013-05-23 16:46:00',8,'active'),(181,3,'ontrip','2013-05-24 16:46:00','2013-05-25 06:46:00',3,'active'),(182,3,'ontrip','2013-05-26 06:46:00','2013-05-26 20:46:00',8,'active'),(183,3,'ontrip','2013-05-27 20:46:00','2013-05-28 10:46:00',3,'active'),(184,3,'ontrip','2013-05-29 10:46:00','2013-05-30 00:46:00',8,'active'),(185,3,'ontrip','2013-05-31 00:46:00','2013-05-31 14:46:00',3,'active'),(186,3,'ontrip','2013-06-01 14:46:00','2013-06-02 04:46:00',8,'active'),(187,3,'ontrip','2013-06-03 04:46:00','2013-06-03 18:46:00',3,'active'),(188,3,'ontrip','2013-06-04 18:46:00','2013-06-05 08:46:00',8,'active'),(189,3,'ontrip','2013-06-06 08:46:00','2013-06-06 22:46:00',3,'active'),(190,3,'ontrip','2013-06-07 22:46:00','2013-06-08 12:46:00',8,'active'),(191,3,'ontrip','2013-06-09 12:46:00','2013-06-10 02:46:00',3,'active'),(192,3,'ontrip','2013-06-11 02:46:00','2013-06-11 16:46:00',8,'active'),(193,3,'ontrip','2013-06-12 16:46:00','2013-06-13 06:46:00',3,'active'),(194,5,'ontrip','2013-04-11 12:46:16','2013-04-12 02:46:16',8,'active'),(195,5,'ontrip','2013-04-13 02:46:16','2013-04-13 16:46:16',3,'active'),(196,5,'ontrip','2013-04-14 16:46:16','2013-04-15 06:46:16',8,'active'),(197,5,'ontrip','2013-04-16 06:46:16','2013-04-16 20:46:16',3,'active'),(198,5,'ontrip','2013-04-17 20:46:16','2013-04-18 10:46:16',8,'active'),(199,5,'ontrip','2013-04-19 10:46:16','2013-04-20 00:46:16',3,'active'),(200,5,'ontrip','2013-04-21 00:46:16','2013-04-21 14:46:16',8,'active'),(201,5,'ontrip','2013-04-22 14:46:16','2013-04-23 04:46:16',3,'active'),(202,5,'ontrip','2013-04-24 04:46:16','2013-04-24 18:46:16',8,'active'),(203,5,'ontrip','2013-04-25 18:46:16','2013-04-26 08:46:16',3,'active'),(204,5,'ontrip','2013-04-27 08:46:16','2013-04-27 22:46:16',8,'active'),(205,5,'ontrip','2013-04-28 22:46:16','2013-04-29 12:46:16',3,'active'),(206,5,'ontrip','2013-04-30 12:46:16','2013-05-01 02:46:16',8,'active'),(207,5,'ontrip','2013-05-02 02:46:16','2013-05-02 16:46:16',3,'active'),(208,5,'ontrip','2013-05-03 16:46:16','2013-05-04 06:46:16',8,'active'),(209,5,'ontrip','2013-05-05 06:46:16','2013-05-05 20:46:16',3,'active'),(210,5,'ontrip','2013-05-06 20:46:16','2013-05-07 10:46:16',8,'active'),(211,5,'ontrip','2013-05-08 10:46:16','2013-05-09 00:46:16',3,'active'),(212,5,'ontrip','2013-05-10 00:46:16','2013-05-10 14:46:16',8,'active'),(213,5,'ontrip','2013-05-11 14:46:16','2013-05-12 04:46:16',3,'active'),(214,5,'ontrip','2013-05-13 04:46:16','2013-05-13 18:46:16',8,'active'),(215,5,'ontrip','2013-05-14 18:46:16','2013-05-15 08:46:16',3,'active'),(216,5,'ontrip','2013-05-16 08:46:16','2013-05-16 22:46:16',8,'active'),(217,5,'ontrip','2013-05-17 22:46:16','2013-05-18 12:46:16',3,'active'),(218,5,'ontrip','2013-05-19 12:46:16','2013-05-20 02:46:16',8,'active'),(219,5,'ontrip','2013-05-21 02:46:16','2013-05-21 16:46:16',3,'active'),(220,5,'ontrip','2013-05-22 16:46:16','2013-05-23 06:46:16',8,'active'),(221,5,'ontrip','2013-05-24 06:46:16','2013-05-24 20:46:16',3,'active'),(222,5,'ontrip','2013-05-25 20:46:16','2013-05-26 10:46:16',8,'active'),(223,5,'ontrip','2013-05-27 10:46:16','2013-05-28 00:46:16',3,'active'),(224,5,'ontrip','2013-05-29 00:46:16','2013-05-29 14:46:16',8,'active'),(225,5,'ontrip','2013-05-30 14:46:16','2013-05-31 04:46:16',3,'active'),(226,5,'ontrip','2013-06-01 04:46:16','2013-06-01 18:46:16',8,'active'),(227,5,'ontrip','2013-06-02 18:46:16','2013-06-03 08:46:16',3,'active'),(228,5,'ontrip','2013-06-04 08:46:16','2013-06-04 22:46:16',8,'active'),(229,5,'ontrip','2013-06-05 22:46:16','2013-06-06 12:46:16',3,'active'),(230,5,'ontrip','2013-06-07 12:46:16','2013-06-08 02:46:16',8,'active'),(231,5,'ontrip','2013-06-09 02:46:16','2013-06-09 16:46:16',3,'active'),(232,5,'ontrip','2013-06-10 16:46:16','2013-06-11 06:46:16',8,'active'),(233,5,'ontrip','2013-06-12 06:46:16','2013-06-12 20:46:16',3,'active'),(234,10,'ontrip','2013-04-11 13:46:28','2013-04-12 03:46:28',8,'active'),(235,10,'ontrip','2013-04-13 03:46:28','2013-04-13 17:46:28',3,'active'),(236,10,'ontrip','2013-04-14 17:46:28','2013-04-15 07:46:28',8,'active'),(237,10,'ontrip','2013-04-16 07:46:28','2013-04-16 21:46:28',3,'active'),(238,10,'ontrip','2013-04-17 21:46:28','2013-04-18 11:46:28',8,'active'),(239,10,'ontrip','2013-04-19 11:46:28','2013-04-20 01:46:28',3,'active'),(240,10,'ontrip','2013-04-21 01:46:28','2013-04-21 15:46:28',8,'active'),(241,10,'ontrip','2013-04-22 15:46:28','2013-04-23 05:46:28',3,'active'),(242,10,'ontrip','2013-04-24 05:46:28','2013-04-24 19:46:28',8,'active'),(243,10,'ontrip','2013-04-25 19:46:28','2013-04-26 09:46:28',3,'active'),(244,10,'ontrip','2013-04-27 09:46:28','2013-04-27 23:46:28',8,'active'),(245,10,'ontrip','2013-04-28 23:46:28','2013-04-29 13:46:28',3,'active'),(246,10,'ontrip','2013-04-30 13:46:28','2013-05-01 03:46:28',8,'active'),(247,10,'ontrip','2013-05-02 03:46:28','2013-05-02 17:46:28',3,'active'),(248,10,'ontrip','2013-05-03 17:46:28','2013-05-04 07:46:28',8,'active'),(249,10,'ontrip','2013-05-05 07:46:28','2013-05-05 21:46:28',3,'active'),(250,10,'ontrip','2013-05-06 21:46:28','2013-05-07 11:46:28',8,'active'),(251,10,'ontrip','2013-05-08 11:46:28','2013-05-09 01:46:28',3,'active'),(252,10,'ontrip','2013-05-10 01:46:28','2013-05-10 15:46:28',8,'active'),(253,10,'ontrip','2013-05-11 15:46:28','2013-05-12 05:46:28',3,'active'),(254,10,'ontrip','2013-05-13 05:46:28','2013-05-13 19:46:28',8,'active'),(255,10,'ontrip','2013-05-14 19:46:28','2013-05-15 09:46:28',3,'active'),(256,10,'ontrip','2013-05-16 09:46:28','2013-05-16 23:46:28',8,'active'),(257,10,'ontrip','2013-05-17 23:46:28','2013-05-18 13:46:28',3,'active'),(258,10,'ontrip','2013-05-19 13:46:28','2013-05-20 03:46:28',8,'active'),(259,10,'ontrip','2013-05-21 03:46:28','2013-05-21 17:46:28',3,'active'),(260,10,'ontrip','2013-05-22 17:46:28','2013-05-23 07:46:28',8,'active'),(261,10,'ontrip','2013-05-24 07:46:28','2013-05-24 21:46:28',3,'active'),(262,10,'ontrip','2013-05-25 21:46:28','2013-05-26 11:46:28',8,'active'),(263,10,'ontrip','2013-05-27 11:46:28','2013-05-28 01:46:28',3,'active'),(264,10,'ontrip','2013-05-29 01:46:28','2013-05-29 15:46:28',8,'active'),(265,10,'ontrip','2013-05-30 15:46:28','2013-05-31 05:46:28',3,'active'),(266,10,'ontrip','2013-06-01 05:46:28','2013-06-01 19:46:28',8,'active'),(267,10,'ontrip','2013-06-02 19:46:28','2013-06-03 09:46:28',3,'active'),(268,10,'ontrip','2013-06-04 09:46:28','2013-06-04 23:46:28',8,'active'),(269,10,'ontrip','2013-06-05 23:46:28','2013-06-06 13:46:28',3,'active'),(270,10,'ontrip','2013-06-07 13:46:28','2013-06-08 03:46:28',8,'active'),(271,10,'ontrip','2013-06-09 03:46:28','2013-06-09 17:46:28',3,'active'),(272,10,'ontrip','2013-06-10 17:46:28','2013-06-11 07:46:28',8,'active'),(273,10,'ontrip','2013-06-12 07:46:28','2013-06-12 21:46:28',3,'active');
/*!40000 ALTER TABLE `bus_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_status_change`
--

DROP TABLE IF EXISTS `bus_status_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus_status_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bus_status_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `change_type_id` int(11) NOT NULL,
  `reason` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_status_change_bus_status_id_idx` (`bus_status_id`),
  KEY `bus_status_change_user_id_idx` (`user_id`),
  KEY `bus_status_change_change_type_id_idx` (`change_type_id`),
  CONSTRAINT `bus_status_change_bus_status_id` FOREIGN KEY (`bus_status_id`) REFERENCES `bus_status` (`id`),
  CONSTRAINT `bus_status_change_change_type_id` FOREIGN KEY (`change_type_id`) REFERENCES `bus_status_change_type` (`id`),
  CONSTRAINT `bus_status_change_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_status_change`
--

LOCK TABLES `bus_status_change` WRITE;
/*!40000 ALTER TABLE `bus_status_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `bus_status_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_status_change_type`
--

DROP TABLE IF EXISTS `bus_status_change_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus_status_change_type` (
  `id` int(11) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description_UNIQUE` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_status_change_type`
--

LOCK TABLES `bus_status_change_type` WRITE;
/*!40000 ALTER TABLE `bus_status_change_type` DISABLE KEYS */;
INSERT INTO `bus_status_change_type` VALUES (1,'cancel');
/*!40000 ALTER TABLE `bus_status_change_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_type`
--

DROP TABLE IF EXISTS `bus_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `number_of_seats` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_type`
--

LOCK TABLES `bus_type` WRITE;
/*!40000 ALTER TABLE `bus_type` DISABLE KEYS */;
INSERT INTO `bus_type` VALUES (1,'Ghế ngồi',45),(2,'Giường nằm',40);
/*!40000 ALTER TABLE `bus_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=514 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (4,'Hà Nội',21.03,105.84),(8,'TP. Hồ Chí Minh',10.78,106.69),(20,'Lào Cai',22.5,103.96),(25,'Lạng Sơn',21.86,106.76),(29,'Yên Bái',21.71,104.87),(31,'Hải Phòng',20.85,106.6833),(37,'Thanh Hoá',19.81,105.78),(38,'Nghệ An',19.3333,104.8333),(39,'Hà Tĩnh',18.37,105.9),(52,'Quảng Bình',17.5,106.3333),(54,'Thừa Thiên Huế',16.48,107.58),(55,'Quảng Ngãi',15.12,108.81),(56,'Bình Định',14.1667,109),(58,'Vạn Giã',12.25,109.2),(61,'Đồng Nai',11.116666666666667,107.18333333333334),(62,'Bình Thuận',10.933333333333334,108.1),(63,'Lâm Đồng',11.9417,108.4383),(64,'Vũng Tàu',10.416666666666666,107.16805555555555),(66,'Tây Ninh',11.3,106.1),(72,'Long An',10.666666666666666,106.16666666666667),(75,'Bến Tre',10.2333,106.3833),(76,'An Giang',10.5,105.16666666666667),(511,'Đà Nẵng',16.0667,108.2333),(512,'Bà Rịa',10.35,107.25),(513,'Nha Trang',12.25,109.1833);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_template`
--

DROP TABLE IF EXISTS `mail_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `subject` tinytext NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_template`
--

LOCK TABLES `mail_template` WRITE;
/*!40000 ALTER TABLE `mail_template` DISABLE KEYS */;
INSERT INTO `mail_template` VALUES (1,'MAIL0101','Kích hoạt tài khoản :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Kích hoạt tài khoản thành viên :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu mở tài khoản thành viên\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<p>Tên đăng nhập: :username:</p>\r\n<p>Tên chủ tài khoản: :fullName:</p>\r\n<p>Địa chỉ email: :email:</p>\r\n<br/>\r\n<p>Để hoàn tất quy trình đăng ký, xin quý khách vui lòng nhấn vào đường dẫn bên dưới\r\nhoặc sao chép vào thanh địa chỉ trên trình duyệt và nhấn Enter:</p>\r\n<p><a href=\":url:\">:url:</a></p>\r\n</div>'),(2,'MAIL0201','Thông báo huỷ đơn đặt vé :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo huỷ đơn đặt vé :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu huỷ đơn đặt vé\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<table>\r\n<tr><th>Mã đơn đặt vé</th><td>:reservationCode:</td></tr>\r\n<tr><th>Ngày đặt</th><td>:bookTime:</td></tr>\r\n</table>\r\n<p>Lộ trình:</p>\r\n<table>\r\n:loopTicket:<tr><td>Từ :from: đến :to:</td><td>:fromDate: - :toDate:</td><td>:seatNumbers:</td><td>:ticketPrice:</td></tr>\r\n:loopTicket:\r\n</table>\r\n<table>\r\n<tr><th>Tổng cộng</th><td>:totalAmount:</td></tr>\r\n<tr><th>Phí</th><td>:fee:</td></tr>\r\n<tr><th>Thành tiền</th><td>:amountToBePaid:</td></tr>\r\n<tr><th>Đã hoàn lại</th><td>:refundedAmount:</td></tr>\r\n</table>\r\n</div>'),(4,'MAIL0202','Thông báo  đặt vé hoàn tất :companyName:','<div style=\"width:100%;\">\r\n <p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo đặt vé hoàn tất :companyName:</p>\r\n <p>Chào :fullName:</p>\r\n <p>Chúng tôi đã nhận được yêu cầu đặt vé\r\n của quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n <table>\r\n <tr><th>Mã đơn đặt vé</th><td>:reservationCode:</td></tr>\r\n <tr><th>Ngày đặt</th><td>:bookTime:</td></tr>\r\n </table>\r\n <p>Lộ trình:</p>\r\n <table>\r\n :loopTicket:<tr><td>Từ :from: đến :to:</td><td>:fromDate: - :toDate:</td><td>:seatNumbers:</td><td>:ticketPrice:</td></tr>\r\n :loopTicket:\r\n </table>\r\n <table>\r\n <tr><th>Tổng cộng</th><td>:totalAmount:</td></tr>\r\n <tr><th>Phí</th><td>:fee:</td></tr>\r\n <tr><th>Thành tiền</th><td>:amountToBePaid:</td></tr>\r\n </table>\r\nChúc quý khách lên đường bình an\r\n </div>'),(5,'MAIL0102','Thông báo thay đổi mật khẩu tại :companyName:','<div style=\"width:100%;\"><p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo thay đổi mật khẩu :companyName:</p><p>Chào :fullName:</p><p>Mật khẩu mới của quý khách tại <a href=\":siteurl:\">:siteName:</a> là: :newPass:</P>Hân hạnh được phục vụ quý khách.</div>');
/*!40000 ALTER TABLE `mail_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) unsigned NOT NULL,
  `pay_amount` double NOT NULL,
  `service_fee` double NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `transaction_id` varchar(45) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_reservation_id_idx` (`ticket_id`),
  KEY `payment_payment_method_id_idx` (`payment_method_id`),
  CONSTRAINT `payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `payment_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`trigger_payment_insert`
BEFORE INSERT ON `bus_reservation`.`payment`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	IF NEW.`type` = 'pay' THEN
		SELECT 
			`check_ticket_with_inactive_trip`(NEW.`ticket_id`)
		INTO num_rows;
		IF num_rows > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrrs009";
		END IF;
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`trigger_payment_update`
BEFORE UPDATE ON `bus_reservation`.`payment`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	IF NEW.`type` = 'pay' THEN
		SELECT 
			`check_ticket_with_inactive_trip`(NEW.`ticket_id`)
		INTO num_rows;
		IF num_rows > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrrs009";
		END IF;
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `ratio` double NOT NULL,
  `addition` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'Cash',0,0),(2,'Paypal',0.039,0.3),(3,'CreditCard',0,0.2);
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `remained_seats`
--

DROP TABLE IF EXISTS `remained_seats`;
/*!50001 DROP VIEW IF EXISTS `remained_seats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `remained_seats` (
  `bus_status_id` int(11),
  `start_location_id` int(11),
  `end_location_id` int(11),
  `number_of_remained_seats` bigint(22)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `code` varchar(12) DEFAULT NULL,
  `book_time` datetime NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'unpaid',
  `booker_first_name` varchar(45) NOT NULL,
  `booker_last_name` varchar(45) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `reservation_booker_id_idx` (`user_id`),
  CONSTRAINT `reservation_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Customer',NULL),(2,'Operator',NULL),(3,'Administrator',NULL),(4,'Developer',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'TP. Hồ Chí Minh - Hà Nội','active'),(2,'Hà Nội - TP.Hồ Chí Minh','active');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route_details`
--

DROP TABLE IF EXISTS `route_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segment_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `segment_in_route_id` (`segment_id`,`route_id`),
  KEY `segment_in_route_route_id_idx` (`route_id`),
  KEY `segment_in_route_segment_id_idx` (`segment_id`),
  CONSTRAINT `segment_in_route_route_id` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`),
  CONSTRAINT `segment_in_route_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_details`
--

LOCK TABLES `route_details` WRITE;
/*!40000 ALTER TABLE `route_details` DISABLE KEYS */;
INSERT INTO `route_details` VALUES (7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,2),(15,15,2),(16,16,2),(17,17,2),(18,18,2),(19,19,2),(20,20,2);
/*!40000 ALTER TABLE `route_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `route_terminal`
--

DROP TABLE IF EXISTS `route_terminal`;
/*!50001 DROP VIEW IF EXISTS `route_terminal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `route_terminal` (
  `id` int(11),
  `start_terminal_id` int(11),
  `end_terminal_id` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `seat_position`
--

DROP TABLE IF EXISTS `seat_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_position` (
  `ticket_id` int(11) unsigned NOT NULL,
  `seat_name` varchar(5) NOT NULL,
  `status` varchar(10) DEFAULT 'active',
  PRIMARY KEY (`ticket_id`,`seat_name`),
  KEY `seat_position_ticket_id_idx` (`ticket_id`),
  CONSTRAINT `seat_position_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_position`
--

LOCK TABLES `seat_position` WRITE;
/*!40000 ALTER TABLE `seat_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_position` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`prevent_duplicate_seat_insert_seat`
BEFORE INSERT ON `bus_reservation`.`seat_position`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	SELECT 
		`check_double_booking_seat`(NEW.`seat_name`, NEW.`ticket_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrdb002";
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`prevent_duplicate_seat_update_seat`
BEFORE UPDATE ON `bus_reservation`.`seat_position`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	SELECT 
		`check_double_booking_seat`(NEW.`seat_name`, NEW.`ticket_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrdb002";
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `segment`
--

DROP TABLE IF EXISTS `segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departure_station_id` int(11) NOT NULL,
  `arrival_station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `segment_unique_index` (`departure_station_id`,`arrival_station_id`),
  KEY `segment_arrive_station_id_idx` (`departure_station_id`),
  KEY `segment_depart_station_id_idx` (`arrival_station_id`),
  CONSTRAINT `segment_arrive_station_id` FOREIGN KEY (`departure_station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `segment_depart_station_id` FOREIGN KEY (`arrival_station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment`
--

LOCK TABLES `segment` WRITE;
/*!40000 ALTER TABLE `segment` DISABLE KEYS */;
INSERT INTO `segment` VALUES (1,1,2),(2,2,1),(3,3,5),(7,3,35),(4,5,7),(13,5,8),(15,5,31),(6,6,8),(5,7,6),(14,8,5),(12,31,5),(16,31,32),(11,32,31),(17,32,33),(10,33,32),(18,33,34),(9,34,33),(19,34,35),(20,35,3),(8,35,34);
/*!40000 ALTER TABLE `segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `segment_travel_time`
--

DROP TABLE IF EXISTS `segment_travel_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment_travel_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segment_id` int(11) NOT NULL,
  `travel_time` bigint(20) NOT NULL,
  `valid_from` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `segment_travel_time_segment_id_idx` (`segment_id`),
  CONSTRAINT `segment_travel_time_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment_travel_time`
--

LOCK TABLES `segment_travel_time` WRITE;
/*!40000 ALTER TABLE `segment_travel_time` DISABLE KEYS */;
INSERT INTO `segment_travel_time` VALUES (21,1,7200000,'2013-01-01 00:00:00'),(22,2,7200000,'2013-01-01 00:00:00'),(23,3,7200000,'2013-01-01 00:00:00'),(24,4,7200000,'2013-01-01 00:00:00'),(25,5,7200000,'2013-01-01 00:00:00'),(26,6,7200000,'2013-01-01 00:00:00'),(27,7,7200000,'2013-01-01 00:00:00'),(28,8,7200000,'2013-01-01 00:00:00'),(29,9,7200000,'2013-01-01 00:00:00'),(30,10,7200000,'2013-01-01 00:00:00'),(31,11,7200000,'2013-01-01 00:00:00'),(32,12,7200000,'2013-01-01 00:00:00'),(33,13,7200000,'2013-01-01 00:00:00'),(34,14,7200000,'2013-01-01 00:00:00'),(35,15,7200000,'2013-01-01 00:00:00'),(36,16,7200000,'2013-01-01 00:00:00'),(37,17,7200000,'2013-01-01 00:00:00'),(38,18,7200000,'2013-01-01 00:00:00'),(39,19,7200000,'2013-01-01 00:00:00'),(40,20,7200000,'2013-01-01 00:00:00');
/*!40000 ALTER TABLE `segment_travel_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `location_id` int(11) NOT NULL,
  `address` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `station_city_id_idx` (`location_id`),
  CONSTRAINT `station_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Bến xe Hà Tĩnh',39,'Hà Tĩnh','active'),(2,'Bến xe Bến Tre',75,'Bến Tre','active'),(3,'Bến xe Miền Đông',8,'TP. Hồ Chí Minh','active'),(5,'Bến xe Đà Nẵng',511,'Đà Nẵng','active'),(6,'Bến xe Hải Phòng',31,'Hải Phòng','active'),(7,'Bến xe Huế',54,'Thừa Thiên Huế','active'),(8,'Bến xe Hà Nội',4,'Hà Nội','active'),(9,'Bến xe Lào Cai',20,'Lào Cai','active'),(10,'Bến xe Lạng Sơn',25,'Lạng Sơn','active'),(11,'Bến xe Yên Bái',29,'Yên Bái','active'),(12,'Bến xe Đồng Nai',61,'Đồng Nai','active'),(13,'Bến xe Lâm Đồng',63,'Lâm Đồng','active'),(14,'Bến xe Vũng Tàu',64,'Vũng Tàu','active'),(15,'Bến xe Tây Ninh',66,'Tây Ninh','active'),(16,'Bến xe Long An',72,'Long An','active'),(17,'Bến xe An Giang',76,'An Giang','active'),(28,'Bến xe Vinh',38,'Vinh','active'),(29,'Bến xe Thanh Hoá',37,'Thanh Hoá','active'),(30,'Bến xe Quảng Bình',52,'Quảng Bình','active'),(31,'Bến xe Quảng Ngãi',55,'Quảng Ngãi','active'),(32,'Bến xe Quy Nhơn',56,'Quy Nhơn','active'),(33,'Bến xe Vạn Giã',58,'Vạn Giã','active'),(34,'Bến xe Nha Trang',513,'Nha Trang','active'),(35,'Bến xe Phan Thiết',62,'Phan Thiết','active'),(36,'Bến xe Bà Rịa',512,'Bà Rịa','active'),(37,'Bến xe Đà Lạt',63,'Đà Lạt','active');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_setting`
--

DROP TABLE IF EXISTS `system_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_setting` (
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_setting`
--

LOCK TABLES `system_setting` WRITE;
/*!40000 ALTER TABLE `system_setting` DISABLE KEYS */;
INSERT INTO `system_setting` VALUES ('refund.1.rate','70'),('refund.1.time','10'),('refund.2.rate','30'),('refund.2.time','5'),('reservation.timeout','15'),('station.delay','30');
/*!40000 ALTER TABLE `system_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariff`
--

DROP TABLE IF EXISTS `tariff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tariff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segment_id` int(11) NOT NULL,
  `bus_type_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `fare` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `segment_in_route_id` (`segment_id`,`valid_from`,`bus_type_id`),
  KEY `tariff_segment_in_route_id_idx` (`segment_id`),
  KEY `tariff_bus_type_id_idx` (`bus_type_id`),
  CONSTRAINT `tariff_bus_type_id` FOREIGN KEY (`bus_type_id`) REFERENCES `bus_type` (`id`),
  CONSTRAINT `tariff_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,1,1,'2012-01-01 00:00:00',100),(2,2,1,'2012-01-01 00:00:00',100),(3,3,1,'2013-01-01 00:00:00',150),(4,4,1,'2013-01-01 00:00:00',65),(5,5,1,'2013-01-01 00:00:00',30),(6,6,1,'2013-01-01 00:00:00',90),(7,2,1,'2013-02-28 00:00:00',80),(8,2,1,'2013-02-01 00:00:00',85),(9,2,1,'2013-03-15 00:00:00',100),(10,3,1,'2013-02-20 00:00:00',170),(11,3,1,'2013-02-04 00:00:00',120),(12,4,1,'2013-02-25 00:00:00',80),(13,4,1,'2013-03-01 00:00:00',65),(14,7,1,'2012-01-01 00:00:00',125),(15,8,1,'2012-01-01 00:00:00',125),(16,9,1,'2012-01-01 00:00:00',125),(17,10,1,'2012-01-01 00:00:00',125),(18,11,1,'2012-01-01 00:00:00',125),(19,12,1,'2012-01-01 00:00:00',125),(20,13,1,'2012-01-01 00:00:00',125),(21,14,1,'2012-01-01 00:00:00',125),(22,15,1,'2012-01-01 00:00:00',125),(23,16,1,'2012-01-01 00:00:00',125),(24,17,1,'2012-01-01 00:00:00',125),(25,18,1,'2012-01-01 00:00:00',125),(26,19,1,'2012-01-01 00:00:00',125),(27,20,1,'2012-01-01 00:00:00',125),(28,7,2,'2013-04-09 00:00:00',200),(29,8,2,'2013-04-09 00:00:00',210),(30,9,2,'2013-04-09 00:00:00',220),(31,10,2,'2013-04-09 00:00:00',230),(32,11,2,'2013-04-09 00:00:00',240),(33,12,2,'2013-04-09 00:00:00',250),(34,13,2,'2013-04-09 00:00:00',260);
/*!40000 ALTER TABLE `tariff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `tariff_view`
--

DROP TABLE IF EXISTS `tariff_view`;
/*!50001 DROP VIEW IF EXISTS `tariff_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tariff_view` (
  `id` int(11),
  `segment_id` int(11),
  `bus_type_id` int(11),
  `fare` double,
  `valid_from` datetime,
  `valid_to` datetime
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `ticket_reservation_id_idx` (`reservation_id`),
  CONSTRAINT `ticket_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_status_id` int(11) NOT NULL,
  `route_details_id` int(11) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_bus_id_idx` (`bus_status_id`),
  KEY `trip_segment_in_route_id_idx` (`route_details_id`),
  CONSTRAINT `trip_bus_status_id` FOREIGN KEY (`bus_status_id`) REFERENCES `bus_status` (`id`),
  CONSTRAINT `trip_segment_in_route_id` FOREIGN KEY (`route_details_id`) REFERENCES `route_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1827 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (987,154,7,'2013-04-11 22:46:00','2013-04-12 00:46:00'),(988,154,8,'2013-04-12 00:46:00','2013-04-12 02:46:00'),(989,154,9,'2013-04-12 02:46:00','2013-04-12 04:46:00'),(990,154,10,'2013-04-12 04:46:00','2013-04-12 06:46:00'),(991,154,11,'2013-04-12 06:46:00','2013-04-12 08:46:00'),(992,154,12,'2013-04-12 08:46:00','2013-04-12 10:46:00'),(993,154,13,'2013-04-12 10:46:00','2013-04-12 12:46:00'),(994,155,14,'2013-04-13 12:46:00','2013-04-13 14:46:00'),(995,155,15,'2013-04-13 14:46:00','2013-04-13 16:46:00'),(996,155,16,'2013-04-13 16:46:00','2013-04-13 18:46:00'),(997,155,17,'2013-04-13 18:46:00','2013-04-13 20:46:00'),(998,155,18,'2013-04-13 20:46:00','2013-04-13 22:46:00'),(999,155,19,'2013-04-13 22:46:00','2013-04-14 00:46:00'),(1000,155,20,'2013-04-14 00:46:00','2013-04-14 02:46:00'),(1001,156,7,'2013-04-15 02:46:00','2013-04-15 04:46:00'),(1002,156,8,'2013-04-15 04:46:00','2013-04-15 06:46:00'),(1003,156,9,'2013-04-15 06:46:00','2013-04-15 08:46:00'),(1004,156,10,'2013-04-15 08:46:00','2013-04-15 10:46:00'),(1005,156,11,'2013-04-15 10:46:00','2013-04-15 12:46:00'),(1006,156,12,'2013-04-15 12:46:00','2013-04-15 14:46:00'),(1007,156,13,'2013-04-15 14:46:00','2013-04-15 16:46:00'),(1008,157,14,'2013-04-16 16:46:00','2013-04-16 18:46:00'),(1009,157,15,'2013-04-16 18:46:00','2013-04-16 20:46:00'),(1010,157,16,'2013-04-16 20:46:00','2013-04-16 22:46:00'),(1011,157,17,'2013-04-16 22:46:00','2013-04-17 00:46:00'),(1012,157,18,'2013-04-17 00:46:00','2013-04-17 02:46:00'),(1013,157,19,'2013-04-17 02:46:00','2013-04-17 04:46:00'),(1014,157,20,'2013-04-17 04:46:00','2013-04-17 06:46:00'),(1015,158,7,'2013-04-18 06:46:00','2013-04-18 08:46:00'),(1016,158,8,'2013-04-18 08:46:00','2013-04-18 10:46:00'),(1017,158,9,'2013-04-18 10:46:00','2013-04-18 12:46:00'),(1018,158,10,'2013-04-18 12:46:00','2013-04-18 14:46:00'),(1019,158,11,'2013-04-18 14:46:00','2013-04-18 16:46:00'),(1020,158,12,'2013-04-18 16:46:00','2013-04-18 18:46:00'),(1021,158,13,'2013-04-18 18:46:00','2013-04-18 20:46:00'),(1022,159,14,'2013-04-19 20:46:00','2013-04-19 22:46:00'),(1023,159,15,'2013-04-19 22:46:00','2013-04-20 00:46:00'),(1024,159,16,'2013-04-20 00:46:00','2013-04-20 02:46:00'),(1025,159,17,'2013-04-20 02:46:00','2013-04-20 04:46:00'),(1026,159,18,'2013-04-20 04:46:00','2013-04-20 06:46:00'),(1027,159,19,'2013-04-20 06:46:00','2013-04-20 08:46:00'),(1028,159,20,'2013-04-20 08:46:00','2013-04-20 10:46:00'),(1029,160,7,'2013-04-21 10:46:00','2013-04-21 12:46:00'),(1030,160,8,'2013-04-21 12:46:00','2013-04-21 14:46:00'),(1031,160,9,'2013-04-21 14:46:00','2013-04-21 16:46:00'),(1032,160,10,'2013-04-21 16:46:00','2013-04-21 18:46:00'),(1033,160,11,'2013-04-21 18:46:00','2013-04-21 20:46:00'),(1034,160,12,'2013-04-21 20:46:00','2013-04-21 22:46:00'),(1035,160,13,'2013-04-21 22:46:00','2013-04-22 00:46:00'),(1036,161,14,'2013-04-23 00:46:00','2013-04-23 02:46:00'),(1037,161,15,'2013-04-23 02:46:00','2013-04-23 04:46:00'),(1038,161,16,'2013-04-23 04:46:00','2013-04-23 06:46:00'),(1039,161,17,'2013-04-23 06:46:00','2013-04-23 08:46:00'),(1040,161,18,'2013-04-23 08:46:00','2013-04-23 10:46:00'),(1041,161,19,'2013-04-23 10:46:00','2013-04-23 12:46:00'),(1042,161,20,'2013-04-23 12:46:00','2013-04-23 14:46:00'),(1043,162,7,'2013-04-24 14:46:00','2013-04-24 16:46:00'),(1044,162,8,'2013-04-24 16:46:00','2013-04-24 18:46:00'),(1045,162,9,'2013-04-24 18:46:00','2013-04-24 20:46:00'),(1046,162,10,'2013-04-24 20:46:00','2013-04-24 22:46:00'),(1047,162,11,'2013-04-24 22:46:00','2013-04-25 00:46:00'),(1048,162,12,'2013-04-25 00:46:00','2013-04-25 02:46:00'),(1049,162,13,'2013-04-25 02:46:00','2013-04-25 04:46:00'),(1050,163,14,'2013-04-26 04:46:00','2013-04-26 06:46:00'),(1051,163,15,'2013-04-26 06:46:00','2013-04-26 08:46:00'),(1052,163,16,'2013-04-26 08:46:00','2013-04-26 10:46:00'),(1053,163,17,'2013-04-26 10:46:00','2013-04-26 12:46:00'),(1054,163,18,'2013-04-26 12:46:00','2013-04-26 14:46:00'),(1055,163,19,'2013-04-26 14:46:00','2013-04-26 16:46:00'),(1056,163,20,'2013-04-26 16:46:00','2013-04-26 18:46:00'),(1057,164,7,'2013-04-27 18:46:00','2013-04-27 20:46:00'),(1058,164,8,'2013-04-27 20:46:00','2013-04-27 22:46:00'),(1059,164,9,'2013-04-27 22:46:00','2013-04-28 00:46:00'),(1060,164,10,'2013-04-28 00:46:00','2013-04-28 02:46:00'),(1061,164,11,'2013-04-28 02:46:00','2013-04-28 04:46:00'),(1062,164,12,'2013-04-28 04:46:00','2013-04-28 06:46:00'),(1063,164,13,'2013-04-28 06:46:00','2013-04-28 08:46:00'),(1064,165,14,'2013-04-29 08:46:00','2013-04-29 10:46:00'),(1065,165,15,'2013-04-29 10:46:00','2013-04-29 12:46:00'),(1066,165,16,'2013-04-29 12:46:00','2013-04-29 14:46:00'),(1067,165,17,'2013-04-29 14:46:00','2013-04-29 16:46:00'),(1068,165,18,'2013-04-29 16:46:00','2013-04-29 18:46:00'),(1069,165,19,'2013-04-29 18:46:00','2013-04-29 20:46:00'),(1070,165,20,'2013-04-29 20:46:00','2013-04-29 22:46:00'),(1071,166,7,'2013-04-30 22:46:00','2013-05-01 00:46:00'),(1072,166,8,'2013-05-01 00:46:00','2013-05-01 02:46:00'),(1073,166,9,'2013-05-01 02:46:00','2013-05-01 04:46:00'),(1074,166,10,'2013-05-01 04:46:00','2013-05-01 06:46:00'),(1075,166,11,'2013-05-01 06:46:00','2013-05-01 08:46:00'),(1076,166,12,'2013-05-01 08:46:00','2013-05-01 10:46:00'),(1077,166,13,'2013-05-01 10:46:00','2013-05-01 12:46:00'),(1078,167,14,'2013-05-02 12:46:00','2013-05-02 14:46:00'),(1079,167,15,'2013-05-02 14:46:00','2013-05-02 16:46:00'),(1080,167,16,'2013-05-02 16:46:00','2013-05-02 18:46:00'),(1081,167,17,'2013-05-02 18:46:00','2013-05-02 20:46:00'),(1082,167,18,'2013-05-02 20:46:00','2013-05-02 22:46:00'),(1083,167,19,'2013-05-02 22:46:00','2013-05-03 00:46:00'),(1084,167,20,'2013-05-03 00:46:00','2013-05-03 02:46:00'),(1085,168,7,'2013-05-04 02:46:00','2013-05-04 04:46:00'),(1086,168,8,'2013-05-04 04:46:00','2013-05-04 06:46:00'),(1087,168,9,'2013-05-04 06:46:00','2013-05-04 08:46:00'),(1088,168,10,'2013-05-04 08:46:00','2013-05-04 10:46:00'),(1089,168,11,'2013-05-04 10:46:00','2013-05-04 12:46:00'),(1090,168,12,'2013-05-04 12:46:00','2013-05-04 14:46:00'),(1091,168,13,'2013-05-04 14:46:00','2013-05-04 16:46:00'),(1092,169,14,'2013-05-05 16:46:00','2013-05-05 18:46:00'),(1093,169,15,'2013-05-05 18:46:00','2013-05-05 20:46:00'),(1094,169,16,'2013-05-05 20:46:00','2013-05-05 22:46:00'),(1095,169,17,'2013-05-05 22:46:00','2013-05-06 00:46:00'),(1096,169,18,'2013-05-06 00:46:00','2013-05-06 02:46:00'),(1097,169,19,'2013-05-06 02:46:00','2013-05-06 04:46:00'),(1098,169,20,'2013-05-06 04:46:00','2013-05-06 06:46:00'),(1099,170,7,'2013-05-07 06:46:00','2013-05-07 08:46:00'),(1100,170,8,'2013-05-07 08:46:00','2013-05-07 10:46:00'),(1101,170,9,'2013-05-07 10:46:00','2013-05-07 12:46:00'),(1102,170,10,'2013-05-07 12:46:00','2013-05-07 14:46:00'),(1103,170,11,'2013-05-07 14:46:00','2013-05-07 16:46:00'),(1104,170,12,'2013-05-07 16:46:00','2013-05-07 18:46:00'),(1105,170,13,'2013-05-07 18:46:00','2013-05-07 20:46:00'),(1106,171,14,'2013-05-08 20:46:00','2013-05-08 22:46:00'),(1107,171,15,'2013-05-08 22:46:00','2013-05-09 00:46:00'),(1108,171,16,'2013-05-09 00:46:00','2013-05-09 02:46:00'),(1109,171,17,'2013-05-09 02:46:00','2013-05-09 04:46:00'),(1110,171,18,'2013-05-09 04:46:00','2013-05-09 06:46:00'),(1111,171,19,'2013-05-09 06:46:00','2013-05-09 08:46:00'),(1112,171,20,'2013-05-09 08:46:00','2013-05-09 10:46:00'),(1113,172,7,'2013-05-10 10:46:00','2013-05-10 12:46:00'),(1114,172,8,'2013-05-10 12:46:00','2013-05-10 14:46:00'),(1115,172,9,'2013-05-10 14:46:00','2013-05-10 16:46:00'),(1116,172,10,'2013-05-10 16:46:00','2013-05-10 18:46:00'),(1117,172,11,'2013-05-10 18:46:00','2013-05-10 20:46:00'),(1118,172,12,'2013-05-10 20:46:00','2013-05-10 22:46:00'),(1119,172,13,'2013-05-10 22:46:00','2013-05-11 00:46:00'),(1120,173,14,'2013-05-12 00:46:00','2013-05-12 02:46:00'),(1121,173,15,'2013-05-12 02:46:00','2013-05-12 04:46:00'),(1122,173,16,'2013-05-12 04:46:00','2013-05-12 06:46:00'),(1123,173,17,'2013-05-12 06:46:00','2013-05-12 08:46:00'),(1124,173,18,'2013-05-12 08:46:00','2013-05-12 10:46:00'),(1125,173,19,'2013-05-12 10:46:00','2013-05-12 12:46:00'),(1126,173,20,'2013-05-12 12:46:00','2013-05-12 14:46:00'),(1127,174,7,'2013-05-13 14:46:00','2013-05-13 16:46:00'),(1128,174,8,'2013-05-13 16:46:00','2013-05-13 18:46:00'),(1129,174,9,'2013-05-13 18:46:00','2013-05-13 20:46:00'),(1130,174,10,'2013-05-13 20:46:00','2013-05-13 22:46:00'),(1131,174,11,'2013-05-13 22:46:00','2013-05-14 00:46:00'),(1132,174,12,'2013-05-14 00:46:00','2013-05-14 02:46:00'),(1133,174,13,'2013-05-14 02:46:00','2013-05-14 04:46:00'),(1134,175,14,'2013-05-15 04:46:00','2013-05-15 06:46:00'),(1135,175,15,'2013-05-15 06:46:00','2013-05-15 08:46:00'),(1136,175,16,'2013-05-15 08:46:00','2013-05-15 10:46:00'),(1137,175,17,'2013-05-15 10:46:00','2013-05-15 12:46:00'),(1138,175,18,'2013-05-15 12:46:00','2013-05-15 14:46:00'),(1139,175,19,'2013-05-15 14:46:00','2013-05-15 16:46:00'),(1140,175,20,'2013-05-15 16:46:00','2013-05-15 18:46:00'),(1141,176,7,'2013-05-16 18:46:00','2013-05-16 20:46:00'),(1142,176,8,'2013-05-16 20:46:00','2013-05-16 22:46:00'),(1143,176,9,'2013-05-16 22:46:00','2013-05-17 00:46:00'),(1144,176,10,'2013-05-17 00:46:00','2013-05-17 02:46:00'),(1145,176,11,'2013-05-17 02:46:00','2013-05-17 04:46:00'),(1146,176,12,'2013-05-17 04:46:00','2013-05-17 06:46:00'),(1147,176,13,'2013-05-17 06:46:00','2013-05-17 08:46:00'),(1148,177,14,'2013-05-18 08:46:00','2013-05-18 10:46:00'),(1149,177,15,'2013-05-18 10:46:00','2013-05-18 12:46:00'),(1150,177,16,'2013-05-18 12:46:00','2013-05-18 14:46:00'),(1151,177,17,'2013-05-18 14:46:00','2013-05-18 16:46:00'),(1152,177,18,'2013-05-18 16:46:00','2013-05-18 18:46:00'),(1153,177,19,'2013-05-18 18:46:00','2013-05-18 20:46:00'),(1154,177,20,'2013-05-18 20:46:00','2013-05-18 22:46:00'),(1155,178,7,'2013-05-19 22:46:00','2013-05-20 00:46:00'),(1156,178,8,'2013-05-20 00:46:00','2013-05-20 02:46:00'),(1157,178,9,'2013-05-20 02:46:00','2013-05-20 04:46:00'),(1158,178,10,'2013-05-20 04:46:00','2013-05-20 06:46:00'),(1159,178,11,'2013-05-20 06:46:00','2013-05-20 08:46:00'),(1160,178,12,'2013-05-20 08:46:00','2013-05-20 10:46:00'),(1161,178,13,'2013-05-20 10:46:00','2013-05-20 12:46:00'),(1162,179,14,'2013-05-21 12:46:00','2013-05-21 14:46:00'),(1163,179,15,'2013-05-21 14:46:00','2013-05-21 16:46:00'),(1164,179,16,'2013-05-21 16:46:00','2013-05-21 18:46:00'),(1165,179,17,'2013-05-21 18:46:00','2013-05-21 20:46:00'),(1166,179,18,'2013-05-21 20:46:00','2013-05-21 22:46:00'),(1167,179,19,'2013-05-21 22:46:00','2013-05-22 00:46:00'),(1168,179,20,'2013-05-22 00:46:00','2013-05-22 02:46:00'),(1169,180,7,'2013-05-23 02:46:00','2013-05-23 04:46:00'),(1170,180,8,'2013-05-23 04:46:00','2013-05-23 06:46:00'),(1171,180,9,'2013-05-23 06:46:00','2013-05-23 08:46:00'),(1172,180,10,'2013-05-23 08:46:00','2013-05-23 10:46:00'),(1173,180,11,'2013-05-23 10:46:00','2013-05-23 12:46:00'),(1174,180,12,'2013-05-23 12:46:00','2013-05-23 14:46:00'),(1175,180,13,'2013-05-23 14:46:00','2013-05-23 16:46:00'),(1176,181,14,'2013-05-24 16:46:00','2013-05-24 18:46:00'),(1177,181,15,'2013-05-24 18:46:00','2013-05-24 20:46:00'),(1178,181,16,'2013-05-24 20:46:00','2013-05-24 22:46:00'),(1179,181,17,'2013-05-24 22:46:00','2013-05-25 00:46:00'),(1180,181,18,'2013-05-25 00:46:00','2013-05-25 02:46:00'),(1181,181,19,'2013-05-25 02:46:00','2013-05-25 04:46:00'),(1182,181,20,'2013-05-25 04:46:00','2013-05-25 06:46:00'),(1183,182,7,'2013-05-26 06:46:00','2013-05-26 08:46:00'),(1184,182,8,'2013-05-26 08:46:00','2013-05-26 10:46:00'),(1185,182,9,'2013-05-26 10:46:00','2013-05-26 12:46:00'),(1186,182,10,'2013-05-26 12:46:00','2013-05-26 14:46:00'),(1187,182,11,'2013-05-26 14:46:00','2013-05-26 16:46:00'),(1188,182,12,'2013-05-26 16:46:00','2013-05-26 18:46:00'),(1189,182,13,'2013-05-26 18:46:00','2013-05-26 20:46:00'),(1190,183,14,'2013-05-27 20:46:00','2013-05-27 22:46:00'),(1191,183,15,'2013-05-27 22:46:00','2013-05-28 00:46:00'),(1192,183,16,'2013-05-28 00:46:00','2013-05-28 02:46:00'),(1193,183,17,'2013-05-28 02:46:00','2013-05-28 04:46:00'),(1194,183,18,'2013-05-28 04:46:00','2013-05-28 06:46:00'),(1195,183,19,'2013-05-28 06:46:00','2013-05-28 08:46:00'),(1196,183,20,'2013-05-28 08:46:00','2013-05-28 10:46:00'),(1197,184,7,'2013-05-29 10:46:00','2013-05-29 12:46:00'),(1198,184,8,'2013-05-29 12:46:00','2013-05-29 14:46:00'),(1199,184,9,'2013-05-29 14:46:00','2013-05-29 16:46:00'),(1200,184,10,'2013-05-29 16:46:00','2013-05-29 18:46:00'),(1201,184,11,'2013-05-29 18:46:00','2013-05-29 20:46:00'),(1202,184,12,'2013-05-29 20:46:00','2013-05-29 22:46:00'),(1203,184,13,'2013-05-29 22:46:00','2013-05-30 00:46:00'),(1204,185,14,'2013-05-31 00:46:00','2013-05-31 02:46:00'),(1205,185,15,'2013-05-31 02:46:00','2013-05-31 04:46:00'),(1206,185,16,'2013-05-31 04:46:00','2013-05-31 06:46:00'),(1207,185,17,'2013-05-31 06:46:00','2013-05-31 08:46:00'),(1208,185,18,'2013-05-31 08:46:00','2013-05-31 10:46:00'),(1209,185,19,'2013-05-31 10:46:00','2013-05-31 12:46:00'),(1210,185,20,'2013-05-31 12:46:00','2013-05-31 14:46:00'),(1211,186,7,'2013-06-01 14:46:00','2013-06-01 16:46:00'),(1212,186,8,'2013-06-01 16:46:00','2013-06-01 18:46:00'),(1213,186,9,'2013-06-01 18:46:00','2013-06-01 20:46:00'),(1214,186,10,'2013-06-01 20:46:00','2013-06-01 22:46:00'),(1215,186,11,'2013-06-01 22:46:00','2013-06-02 00:46:00'),(1216,186,12,'2013-06-02 00:46:00','2013-06-02 02:46:00'),(1217,186,13,'2013-06-02 02:46:00','2013-06-02 04:46:00'),(1218,187,14,'2013-06-03 04:46:00','2013-06-03 06:46:00'),(1219,187,15,'2013-06-03 06:46:00','2013-06-03 08:46:00'),(1220,187,16,'2013-06-03 08:46:00','2013-06-03 10:46:00'),(1221,187,17,'2013-06-03 10:46:00','2013-06-03 12:46:00'),(1222,187,18,'2013-06-03 12:46:00','2013-06-03 14:46:00'),(1223,187,19,'2013-06-03 14:46:00','2013-06-03 16:46:00'),(1224,187,20,'2013-06-03 16:46:00','2013-06-03 18:46:00'),(1225,188,7,'2013-06-04 18:46:00','2013-06-04 20:46:00'),(1226,188,8,'2013-06-04 20:46:00','2013-06-04 22:46:00'),(1227,188,9,'2013-06-04 22:46:00','2013-06-05 00:46:00'),(1228,188,10,'2013-06-05 00:46:00','2013-06-05 02:46:00'),(1229,188,11,'2013-06-05 02:46:00','2013-06-05 04:46:00'),(1230,188,12,'2013-06-05 04:46:00','2013-06-05 06:46:00'),(1231,188,13,'2013-06-05 06:46:00','2013-06-05 08:46:00'),(1232,189,14,'2013-06-06 08:46:00','2013-06-06 10:46:00'),(1233,189,15,'2013-06-06 10:46:00','2013-06-06 12:46:00'),(1234,189,16,'2013-06-06 12:46:00','2013-06-06 14:46:00'),(1235,189,17,'2013-06-06 14:46:00','2013-06-06 16:46:00'),(1236,189,18,'2013-06-06 16:46:00','2013-06-06 18:46:00'),(1237,189,19,'2013-06-06 18:46:00','2013-06-06 20:46:00'),(1238,189,20,'2013-06-06 20:46:00','2013-06-06 22:46:00'),(1239,190,7,'2013-06-07 22:46:00','2013-06-08 00:46:00'),(1240,190,8,'2013-06-08 00:46:00','2013-06-08 02:46:00'),(1241,190,9,'2013-06-08 02:46:00','2013-06-08 04:46:00'),(1242,190,10,'2013-06-08 04:46:00','2013-06-08 06:46:00'),(1243,190,11,'2013-06-08 06:46:00','2013-06-08 08:46:00'),(1244,190,12,'2013-06-08 08:46:00','2013-06-08 10:46:00'),(1245,190,13,'2013-06-08 10:46:00','2013-06-08 12:46:00'),(1246,191,14,'2013-06-09 12:46:00','2013-06-09 14:46:00'),(1247,191,15,'2013-06-09 14:46:00','2013-06-09 16:46:00'),(1248,191,16,'2013-06-09 16:46:00','2013-06-09 18:46:00'),(1249,191,17,'2013-06-09 18:46:00','2013-06-09 20:46:00'),(1250,191,18,'2013-06-09 20:46:00','2013-06-09 22:46:00'),(1251,191,19,'2013-06-09 22:46:00','2013-06-10 00:46:00'),(1252,191,20,'2013-06-10 00:46:00','2013-06-10 02:46:00'),(1253,192,7,'2013-06-11 02:46:00','2013-06-11 04:46:00'),(1254,192,8,'2013-06-11 04:46:00','2013-06-11 06:46:00'),(1255,192,9,'2013-06-11 06:46:00','2013-06-11 08:46:00'),(1256,192,10,'2013-06-11 08:46:00','2013-06-11 10:46:00'),(1257,192,11,'2013-06-11 10:46:00','2013-06-11 12:46:00'),(1258,192,12,'2013-06-11 12:46:00','2013-06-11 14:46:00'),(1259,192,13,'2013-06-11 14:46:00','2013-06-11 16:46:00'),(1260,193,14,'2013-06-12 16:46:00','2013-06-12 18:46:00'),(1261,193,15,'2013-06-12 18:46:00','2013-06-12 20:46:00'),(1262,193,16,'2013-06-12 20:46:00','2013-06-12 22:46:00'),(1263,193,17,'2013-06-12 22:46:00','2013-06-13 00:46:00'),(1264,193,18,'2013-06-13 00:46:00','2013-06-13 02:46:00'),(1265,193,19,'2013-06-13 02:46:00','2013-06-13 04:46:00'),(1266,193,20,'2013-06-13 04:46:00','2013-06-13 06:46:00'),(1267,194,7,'2013-04-11 12:46:16','2013-04-11 14:46:16'),(1268,194,8,'2013-04-11 14:46:16','2013-04-11 16:46:16'),(1269,194,9,'2013-04-11 16:46:16','2013-04-11 18:46:16'),(1270,194,10,'2013-04-11 18:46:16','2013-04-11 20:46:16'),(1271,194,11,'2013-04-11 20:46:16','2013-04-11 22:46:16'),(1272,194,12,'2013-04-11 22:46:16','2013-04-12 00:46:16'),(1273,194,13,'2013-04-12 00:46:16','2013-04-12 02:46:16'),(1274,195,14,'2013-04-13 02:46:16','2013-04-13 04:46:16'),(1275,195,15,'2013-04-13 04:46:16','2013-04-13 06:46:16'),(1276,195,16,'2013-04-13 06:46:16','2013-04-13 08:46:16'),(1277,195,17,'2013-04-13 08:46:16','2013-04-13 10:46:16'),(1278,195,18,'2013-04-13 10:46:16','2013-04-13 12:46:16'),(1279,195,19,'2013-04-13 12:46:16','2013-04-13 14:46:16'),(1280,195,20,'2013-04-13 14:46:16','2013-04-13 16:46:16'),(1281,196,7,'2013-04-14 16:46:16','2013-04-14 18:46:16'),(1282,196,8,'2013-04-14 18:46:16','2013-04-14 20:46:16'),(1283,196,9,'2013-04-14 20:46:16','2013-04-14 22:46:16'),(1284,196,10,'2013-04-14 22:46:16','2013-04-15 00:46:16'),(1285,196,11,'2013-04-15 00:46:16','2013-04-15 02:46:16'),(1286,196,12,'2013-04-15 02:46:16','2013-04-15 04:46:16'),(1287,196,13,'2013-04-15 04:46:16','2013-04-15 06:46:16'),(1288,197,14,'2013-04-16 06:46:16','2013-04-16 08:46:16'),(1289,197,15,'2013-04-16 08:46:16','2013-04-16 10:46:16'),(1290,197,16,'2013-04-16 10:46:16','2013-04-16 12:46:16'),(1291,197,17,'2013-04-16 12:46:16','2013-04-16 14:46:16'),(1292,197,18,'2013-04-16 14:46:16','2013-04-16 16:46:16'),(1293,197,19,'2013-04-16 16:46:16','2013-04-16 18:46:16'),(1294,197,20,'2013-04-16 18:46:16','2013-04-16 20:46:16'),(1295,198,7,'2013-04-17 20:46:16','2013-04-17 22:46:16'),(1296,198,8,'2013-04-17 22:46:16','2013-04-18 00:46:16'),(1297,198,9,'2013-04-18 00:46:16','2013-04-18 02:46:16'),(1298,198,10,'2013-04-18 02:46:16','2013-04-18 04:46:16'),(1299,198,11,'2013-04-18 04:46:16','2013-04-18 06:46:16'),(1300,198,12,'2013-04-18 06:46:16','2013-04-18 08:46:16'),(1301,198,13,'2013-04-18 08:46:16','2013-04-18 10:46:16'),(1302,199,14,'2013-04-19 10:46:16','2013-04-19 12:46:16'),(1303,199,15,'2013-04-19 12:46:16','2013-04-19 14:46:16'),(1304,199,16,'2013-04-19 14:46:16','2013-04-19 16:46:16'),(1305,199,17,'2013-04-19 16:46:16','2013-04-19 18:46:16'),(1306,199,18,'2013-04-19 18:46:16','2013-04-19 20:46:16'),(1307,199,19,'2013-04-19 20:46:16','2013-04-19 22:46:16'),(1308,199,20,'2013-04-19 22:46:16','2013-04-20 00:46:16'),(1309,200,7,'2013-04-21 00:46:16','2013-04-21 02:46:16'),(1310,200,8,'2013-04-21 02:46:16','2013-04-21 04:46:16'),(1311,200,9,'2013-04-21 04:46:16','2013-04-21 06:46:16'),(1312,200,10,'2013-04-21 06:46:16','2013-04-21 08:46:16'),(1313,200,11,'2013-04-21 08:46:16','2013-04-21 10:46:16'),(1314,200,12,'2013-04-21 10:46:16','2013-04-21 12:46:16'),(1315,200,13,'2013-04-21 12:46:16','2013-04-21 14:46:16'),(1316,201,14,'2013-04-22 14:46:16','2013-04-22 16:46:16'),(1317,201,15,'2013-04-22 16:46:16','2013-04-22 18:46:16'),(1318,201,16,'2013-04-22 18:46:16','2013-04-22 20:46:16'),(1319,201,17,'2013-04-22 20:46:16','2013-04-22 22:46:16'),(1320,201,18,'2013-04-22 22:46:16','2013-04-23 00:46:16'),(1321,201,19,'2013-04-23 00:46:16','2013-04-23 02:46:16'),(1322,201,20,'2013-04-23 02:46:16','2013-04-23 04:46:16'),(1323,202,7,'2013-04-24 04:46:16','2013-04-24 06:46:16'),(1324,202,8,'2013-04-24 06:46:16','2013-04-24 08:46:16'),(1325,202,9,'2013-04-24 08:46:16','2013-04-24 10:46:16'),(1326,202,10,'2013-04-24 10:46:16','2013-04-24 12:46:16'),(1327,202,11,'2013-04-24 12:46:16','2013-04-24 14:46:16'),(1328,202,12,'2013-04-24 14:46:16','2013-04-24 16:46:16'),(1329,202,13,'2013-04-24 16:46:16','2013-04-24 18:46:16'),(1330,203,14,'2013-04-25 18:46:16','2013-04-25 20:46:16'),(1331,203,15,'2013-04-25 20:46:16','2013-04-25 22:46:16'),(1332,203,16,'2013-04-25 22:46:16','2013-04-26 00:46:16'),(1333,203,17,'2013-04-26 00:46:16','2013-04-26 02:46:16'),(1334,203,18,'2013-04-26 02:46:16','2013-04-26 04:46:16'),(1335,203,19,'2013-04-26 04:46:16','2013-04-26 06:46:16'),(1336,203,20,'2013-04-26 06:46:16','2013-04-26 08:46:16'),(1337,204,7,'2013-04-27 08:46:16','2013-04-27 10:46:16'),(1338,204,8,'2013-04-27 10:46:16','2013-04-27 12:46:16'),(1339,204,9,'2013-04-27 12:46:16','2013-04-27 14:46:16'),(1340,204,10,'2013-04-27 14:46:16','2013-04-27 16:46:16'),(1341,204,11,'2013-04-27 16:46:16','2013-04-27 18:46:16'),(1342,204,12,'2013-04-27 18:46:16','2013-04-27 20:46:16'),(1343,204,13,'2013-04-27 20:46:16','2013-04-27 22:46:16'),(1344,205,14,'2013-04-28 22:46:16','2013-04-29 00:46:16'),(1345,205,15,'2013-04-29 00:46:16','2013-04-29 02:46:16'),(1346,205,16,'2013-04-29 02:46:16','2013-04-29 04:46:16'),(1347,205,17,'2013-04-29 04:46:16','2013-04-29 06:46:16'),(1348,205,18,'2013-04-29 06:46:16','2013-04-29 08:46:16'),(1349,205,19,'2013-04-29 08:46:16','2013-04-29 10:46:16'),(1350,205,20,'2013-04-29 10:46:16','2013-04-29 12:46:16'),(1351,206,7,'2013-04-30 12:46:16','2013-04-30 14:46:16'),(1352,206,8,'2013-04-30 14:46:16','2013-04-30 16:46:16'),(1353,206,9,'2013-04-30 16:46:16','2013-04-30 18:46:16'),(1354,206,10,'2013-04-30 18:46:16','2013-04-30 20:46:16'),(1355,206,11,'2013-04-30 20:46:16','2013-04-30 22:46:16'),(1356,206,12,'2013-04-30 22:46:16','2013-05-01 00:46:16'),(1357,206,13,'2013-05-01 00:46:16','2013-05-01 02:46:16'),(1358,207,14,'2013-05-02 02:46:16','2013-05-02 04:46:16'),(1359,207,15,'2013-05-02 04:46:16','2013-05-02 06:46:16'),(1360,207,16,'2013-05-02 06:46:16','2013-05-02 08:46:16'),(1361,207,17,'2013-05-02 08:46:16','2013-05-02 10:46:16'),(1362,207,18,'2013-05-02 10:46:16','2013-05-02 12:46:16'),(1363,207,19,'2013-05-02 12:46:16','2013-05-02 14:46:16'),(1364,207,20,'2013-05-02 14:46:16','2013-05-02 16:46:16'),(1365,208,7,'2013-05-03 16:46:16','2013-05-03 18:46:16'),(1366,208,8,'2013-05-03 18:46:16','2013-05-03 20:46:16'),(1367,208,9,'2013-05-03 20:46:16','2013-05-03 22:46:16'),(1368,208,10,'2013-05-03 22:46:16','2013-05-04 00:46:16'),(1369,208,11,'2013-05-04 00:46:16','2013-05-04 02:46:16'),(1370,208,12,'2013-05-04 02:46:16','2013-05-04 04:46:16'),(1371,208,13,'2013-05-04 04:46:16','2013-05-04 06:46:16'),(1372,209,14,'2013-05-05 06:46:16','2013-05-05 08:46:16'),(1373,209,15,'2013-05-05 08:46:16','2013-05-05 10:46:16'),(1374,209,16,'2013-05-05 10:46:16','2013-05-05 12:46:16'),(1375,209,17,'2013-05-05 12:46:16','2013-05-05 14:46:16'),(1376,209,18,'2013-05-05 14:46:16','2013-05-05 16:46:16'),(1377,209,19,'2013-05-05 16:46:16','2013-05-05 18:46:16'),(1378,209,20,'2013-05-05 18:46:16','2013-05-05 20:46:16'),(1379,210,7,'2013-05-06 20:46:16','2013-05-06 22:46:16'),(1380,210,8,'2013-05-06 22:46:16','2013-05-07 00:46:16'),(1381,210,9,'2013-05-07 00:46:16','2013-05-07 02:46:16'),(1382,210,10,'2013-05-07 02:46:16','2013-05-07 04:46:16'),(1383,210,11,'2013-05-07 04:46:16','2013-05-07 06:46:16'),(1384,210,12,'2013-05-07 06:46:16','2013-05-07 08:46:16'),(1385,210,13,'2013-05-07 08:46:16','2013-05-07 10:46:16'),(1386,211,14,'2013-05-08 10:46:16','2013-05-08 12:46:16'),(1387,211,15,'2013-05-08 12:46:16','2013-05-08 14:46:16'),(1388,211,16,'2013-05-08 14:46:16','2013-05-08 16:46:16'),(1389,211,17,'2013-05-08 16:46:16','2013-05-08 18:46:16'),(1390,211,18,'2013-05-08 18:46:16','2013-05-08 20:46:16'),(1391,211,19,'2013-05-08 20:46:16','2013-05-08 22:46:16'),(1392,211,20,'2013-05-08 22:46:16','2013-05-09 00:46:16'),(1393,212,7,'2013-05-10 00:46:16','2013-05-10 02:46:16'),(1394,212,8,'2013-05-10 02:46:16','2013-05-10 04:46:16'),(1395,212,9,'2013-05-10 04:46:16','2013-05-10 06:46:16'),(1396,212,10,'2013-05-10 06:46:16','2013-05-10 08:46:16'),(1397,212,11,'2013-05-10 08:46:16','2013-05-10 10:46:16'),(1398,212,12,'2013-05-10 10:46:16','2013-05-10 12:46:16'),(1399,212,13,'2013-05-10 12:46:16','2013-05-10 14:46:16'),(1400,213,14,'2013-05-11 14:46:16','2013-05-11 16:46:16'),(1401,213,15,'2013-05-11 16:46:16','2013-05-11 18:46:16'),(1402,213,16,'2013-05-11 18:46:16','2013-05-11 20:46:16'),(1403,213,17,'2013-05-11 20:46:16','2013-05-11 22:46:16'),(1404,213,18,'2013-05-11 22:46:16','2013-05-12 00:46:16'),(1405,213,19,'2013-05-12 00:46:16','2013-05-12 02:46:16'),(1406,213,20,'2013-05-12 02:46:16','2013-05-12 04:46:16'),(1407,214,7,'2013-05-13 04:46:16','2013-05-13 06:46:16'),(1408,214,8,'2013-05-13 06:46:16','2013-05-13 08:46:16'),(1409,214,9,'2013-05-13 08:46:16','2013-05-13 10:46:16'),(1410,214,10,'2013-05-13 10:46:16','2013-05-13 12:46:16'),(1411,214,11,'2013-05-13 12:46:16','2013-05-13 14:46:16'),(1412,214,12,'2013-05-13 14:46:16','2013-05-13 16:46:16'),(1413,214,13,'2013-05-13 16:46:16','2013-05-13 18:46:16'),(1414,215,14,'2013-05-14 18:46:16','2013-05-14 20:46:16'),(1415,215,15,'2013-05-14 20:46:16','2013-05-14 22:46:16'),(1416,215,16,'2013-05-14 22:46:16','2013-05-15 00:46:16'),(1417,215,17,'2013-05-15 00:46:16','2013-05-15 02:46:16'),(1418,215,18,'2013-05-15 02:46:16','2013-05-15 04:46:16'),(1419,215,19,'2013-05-15 04:46:16','2013-05-15 06:46:16'),(1420,215,20,'2013-05-15 06:46:16','2013-05-15 08:46:16'),(1421,216,7,'2013-05-16 08:46:16','2013-05-16 10:46:16'),(1422,216,8,'2013-05-16 10:46:16','2013-05-16 12:46:16'),(1423,216,9,'2013-05-16 12:46:16','2013-05-16 14:46:16'),(1424,216,10,'2013-05-16 14:46:16','2013-05-16 16:46:16'),(1425,216,11,'2013-05-16 16:46:16','2013-05-16 18:46:16'),(1426,216,12,'2013-05-16 18:46:16','2013-05-16 20:46:16'),(1427,216,13,'2013-05-16 20:46:16','2013-05-16 22:46:16'),(1428,217,14,'2013-05-17 22:46:16','2013-05-18 00:46:16'),(1429,217,15,'2013-05-18 00:46:16','2013-05-18 02:46:16'),(1430,217,16,'2013-05-18 02:46:16','2013-05-18 04:46:16'),(1431,217,17,'2013-05-18 04:46:16','2013-05-18 06:46:16'),(1432,217,18,'2013-05-18 06:46:16','2013-05-18 08:46:16'),(1433,217,19,'2013-05-18 08:46:16','2013-05-18 10:46:16'),(1434,217,20,'2013-05-18 10:46:16','2013-05-18 12:46:16'),(1435,218,7,'2013-05-19 12:46:16','2013-05-19 14:46:16'),(1436,218,8,'2013-05-19 14:46:16','2013-05-19 16:46:16'),(1437,218,9,'2013-05-19 16:46:16','2013-05-19 18:46:16'),(1438,218,10,'2013-05-19 18:46:16','2013-05-19 20:46:16'),(1439,218,11,'2013-05-19 20:46:16','2013-05-19 22:46:16'),(1440,218,12,'2013-05-19 22:46:16','2013-05-20 00:46:16'),(1441,218,13,'2013-05-20 00:46:16','2013-05-20 02:46:16'),(1442,219,14,'2013-05-21 02:46:16','2013-05-21 04:46:16'),(1443,219,15,'2013-05-21 04:46:16','2013-05-21 06:46:16'),(1444,219,16,'2013-05-21 06:46:16','2013-05-21 08:46:16'),(1445,219,17,'2013-05-21 08:46:16','2013-05-21 10:46:16'),(1446,219,18,'2013-05-21 10:46:16','2013-05-21 12:46:16'),(1447,219,19,'2013-05-21 12:46:16','2013-05-21 14:46:16'),(1448,219,20,'2013-05-21 14:46:16','2013-05-21 16:46:16'),(1449,220,7,'2013-05-22 16:46:16','2013-05-22 18:46:16'),(1450,220,8,'2013-05-22 18:46:16','2013-05-22 20:46:16'),(1451,220,9,'2013-05-22 20:46:16','2013-05-22 22:46:16'),(1452,220,10,'2013-05-22 22:46:16','2013-05-23 00:46:16'),(1453,220,11,'2013-05-23 00:46:16','2013-05-23 02:46:16'),(1454,220,12,'2013-05-23 02:46:16','2013-05-23 04:46:16'),(1455,220,13,'2013-05-23 04:46:16','2013-05-23 06:46:16'),(1456,221,14,'2013-05-24 06:46:16','2013-05-24 08:46:16'),(1457,221,15,'2013-05-24 08:46:16','2013-05-24 10:46:16'),(1458,221,16,'2013-05-24 10:46:16','2013-05-24 12:46:16'),(1459,221,17,'2013-05-24 12:46:16','2013-05-24 14:46:16'),(1460,221,18,'2013-05-24 14:46:16','2013-05-24 16:46:16'),(1461,221,19,'2013-05-24 16:46:16','2013-05-24 18:46:16'),(1462,221,20,'2013-05-24 18:46:16','2013-05-24 20:46:16'),(1463,222,7,'2013-05-25 20:46:16','2013-05-25 22:46:16'),(1464,222,8,'2013-05-25 22:46:16','2013-05-26 00:46:16'),(1465,222,9,'2013-05-26 00:46:16','2013-05-26 02:46:16'),(1466,222,10,'2013-05-26 02:46:16','2013-05-26 04:46:16'),(1467,222,11,'2013-05-26 04:46:16','2013-05-26 06:46:16'),(1468,222,12,'2013-05-26 06:46:16','2013-05-26 08:46:16'),(1469,222,13,'2013-05-26 08:46:16','2013-05-26 10:46:16'),(1470,223,14,'2013-05-27 10:46:16','2013-05-27 12:46:16'),(1471,223,15,'2013-05-27 12:46:16','2013-05-27 14:46:16'),(1472,223,16,'2013-05-27 14:46:16','2013-05-27 16:46:16'),(1473,223,17,'2013-05-27 16:46:16','2013-05-27 18:46:16'),(1474,223,18,'2013-05-27 18:46:16','2013-05-27 20:46:16'),(1475,223,19,'2013-05-27 20:46:16','2013-05-27 22:46:16'),(1476,223,20,'2013-05-27 22:46:16','2013-05-28 00:46:16'),(1477,224,7,'2013-05-29 00:46:16','2013-05-29 02:46:16'),(1478,224,8,'2013-05-29 02:46:16','2013-05-29 04:46:16'),(1479,224,9,'2013-05-29 04:46:16','2013-05-29 06:46:16'),(1480,224,10,'2013-05-29 06:46:16','2013-05-29 08:46:16'),(1481,224,11,'2013-05-29 08:46:16','2013-05-29 10:46:16'),(1482,224,12,'2013-05-29 10:46:16','2013-05-29 12:46:16'),(1483,224,13,'2013-05-29 12:46:16','2013-05-29 14:46:16'),(1484,225,14,'2013-05-30 14:46:16','2013-05-30 16:46:16'),(1485,225,15,'2013-05-30 16:46:16','2013-05-30 18:46:16'),(1486,225,16,'2013-05-30 18:46:16','2013-05-30 20:46:16'),(1487,225,17,'2013-05-30 20:46:16','2013-05-30 22:46:16'),(1488,225,18,'2013-05-30 22:46:16','2013-05-31 00:46:16'),(1489,225,19,'2013-05-31 00:46:16','2013-05-31 02:46:16'),(1490,225,20,'2013-05-31 02:46:16','2013-05-31 04:46:16'),(1491,226,7,'2013-06-01 04:46:16','2013-06-01 06:46:16'),(1492,226,8,'2013-06-01 06:46:16','2013-06-01 08:46:16'),(1493,226,9,'2013-06-01 08:46:16','2013-06-01 10:46:16'),(1494,226,10,'2013-06-01 10:46:16','2013-06-01 12:46:16'),(1495,226,11,'2013-06-01 12:46:16','2013-06-01 14:46:16'),(1496,226,12,'2013-06-01 14:46:16','2013-06-01 16:46:16'),(1497,226,13,'2013-06-01 16:46:16','2013-06-01 18:46:16'),(1498,227,14,'2013-06-02 18:46:16','2013-06-02 20:46:16'),(1499,227,15,'2013-06-02 20:46:16','2013-06-02 22:46:16'),(1500,227,16,'2013-06-02 22:46:16','2013-06-03 00:46:16'),(1501,227,17,'2013-06-03 00:46:16','2013-06-03 02:46:16'),(1502,227,18,'2013-06-03 02:46:16','2013-06-03 04:46:16'),(1503,227,19,'2013-06-03 04:46:16','2013-06-03 06:46:16'),(1504,227,20,'2013-06-03 06:46:16','2013-06-03 08:46:16'),(1505,228,7,'2013-06-04 08:46:16','2013-06-04 10:46:16'),(1506,228,8,'2013-06-04 10:46:16','2013-06-04 12:46:16'),(1507,228,9,'2013-06-04 12:46:16','2013-06-04 14:46:16'),(1508,228,10,'2013-06-04 14:46:16','2013-06-04 16:46:16'),(1509,228,11,'2013-06-04 16:46:16','2013-06-04 18:46:16'),(1510,228,12,'2013-06-04 18:46:16','2013-06-04 20:46:16'),(1511,228,13,'2013-06-04 20:46:16','2013-06-04 22:46:16'),(1512,229,14,'2013-06-05 22:46:16','2013-06-06 00:46:16'),(1513,229,15,'2013-06-06 00:46:16','2013-06-06 02:46:16'),(1514,229,16,'2013-06-06 02:46:16','2013-06-06 04:46:16'),(1515,229,17,'2013-06-06 04:46:16','2013-06-06 06:46:16'),(1516,229,18,'2013-06-06 06:46:16','2013-06-06 08:46:16'),(1517,229,19,'2013-06-06 08:46:16','2013-06-06 10:46:16'),(1518,229,20,'2013-06-06 10:46:16','2013-06-06 12:46:16'),(1519,230,7,'2013-06-07 12:46:16','2013-06-07 14:46:16'),(1520,230,8,'2013-06-07 14:46:16','2013-06-07 16:46:16'),(1521,230,9,'2013-06-07 16:46:16','2013-06-07 18:46:16'),(1522,230,10,'2013-06-07 18:46:16','2013-06-07 20:46:16'),(1523,230,11,'2013-06-07 20:46:16','2013-06-07 22:46:16'),(1524,230,12,'2013-06-07 22:46:16','2013-06-08 00:46:16'),(1525,230,13,'2013-06-08 00:46:16','2013-06-08 02:46:16'),(1526,231,14,'2013-06-09 02:46:16','2013-06-09 04:46:16'),(1527,231,15,'2013-06-09 04:46:16','2013-06-09 06:46:16'),(1528,231,16,'2013-06-09 06:46:16','2013-06-09 08:46:16'),(1529,231,17,'2013-06-09 08:46:16','2013-06-09 10:46:16'),(1530,231,18,'2013-06-09 10:46:16','2013-06-09 12:46:16'),(1531,231,19,'2013-06-09 12:46:16','2013-06-09 14:46:16'),(1532,231,20,'2013-06-09 14:46:16','2013-06-09 16:46:16'),(1533,232,7,'2013-06-10 16:46:16','2013-06-10 18:46:16'),(1534,232,8,'2013-06-10 18:46:16','2013-06-10 20:46:16'),(1535,232,9,'2013-06-10 20:46:16','2013-06-10 22:46:16'),(1536,232,10,'2013-06-10 22:46:16','2013-06-11 00:46:16'),(1537,232,11,'2013-06-11 00:46:16','2013-06-11 02:46:16'),(1538,232,12,'2013-06-11 02:46:16','2013-06-11 04:46:16'),(1539,232,13,'2013-06-11 04:46:16','2013-06-11 06:46:16'),(1540,233,14,'2013-06-12 06:46:16','2013-06-12 08:46:16'),(1541,233,15,'2013-06-12 08:46:16','2013-06-12 10:46:16'),(1542,233,16,'2013-06-12 10:46:16','2013-06-12 12:46:16'),(1543,233,17,'2013-06-12 12:46:16','2013-06-12 14:46:16'),(1544,233,18,'2013-06-12 14:46:16','2013-06-12 16:46:16'),(1545,233,19,'2013-06-12 16:46:16','2013-06-12 18:46:16'),(1546,233,20,'2013-06-12 18:46:16','2013-06-12 20:46:16'),(1547,234,7,'2013-04-11 13:46:28','2013-04-11 15:46:28'),(1548,234,8,'2013-04-11 15:46:28','2013-04-11 17:46:28'),(1549,234,9,'2013-04-11 17:46:28','2013-04-11 19:46:28'),(1550,234,10,'2013-04-11 19:46:28','2013-04-11 21:46:28'),(1551,234,11,'2013-04-11 21:46:28','2013-04-11 23:46:28'),(1552,234,12,'2013-04-11 23:46:28','2013-04-12 01:46:28'),(1553,234,13,'2013-04-12 01:46:28','2013-04-12 03:46:28'),(1554,235,14,'2013-04-13 03:46:28','2013-04-13 05:46:28'),(1555,235,15,'2013-04-13 05:46:28','2013-04-13 07:46:28'),(1556,235,16,'2013-04-13 07:46:28','2013-04-13 09:46:28'),(1557,235,17,'2013-04-13 09:46:28','2013-04-13 11:46:28'),(1558,235,18,'2013-04-13 11:46:28','2013-04-13 13:46:28'),(1559,235,19,'2013-04-13 13:46:28','2013-04-13 15:46:28'),(1560,235,20,'2013-04-13 15:46:28','2013-04-13 17:46:28'),(1561,236,7,'2013-04-14 17:46:28','2013-04-14 19:46:28'),(1562,236,8,'2013-04-14 19:46:28','2013-04-14 21:46:28'),(1563,236,9,'2013-04-14 21:46:28','2013-04-14 23:46:28'),(1564,236,10,'2013-04-14 23:46:28','2013-04-15 01:46:28'),(1565,236,11,'2013-04-15 01:46:28','2013-04-15 03:46:28'),(1566,236,12,'2013-04-15 03:46:28','2013-04-15 05:46:28'),(1567,236,13,'2013-04-15 05:46:28','2013-04-15 07:46:28'),(1568,237,14,'2013-04-16 07:46:28','2013-04-16 09:46:28'),(1569,237,15,'2013-04-16 09:46:28','2013-04-16 11:46:28'),(1570,237,16,'2013-04-16 11:46:28','2013-04-16 13:46:28'),(1571,237,17,'2013-04-16 13:46:28','2013-04-16 15:46:28'),(1572,237,18,'2013-04-16 15:46:28','2013-04-16 17:46:28'),(1573,237,19,'2013-04-16 17:46:28','2013-04-16 19:46:28'),(1574,237,20,'2013-04-16 19:46:28','2013-04-16 21:46:28'),(1575,238,7,'2013-04-17 21:46:28','2013-04-17 23:46:28'),(1576,238,8,'2013-04-17 23:46:28','2013-04-18 01:46:28'),(1577,238,9,'2013-04-18 01:46:28','2013-04-18 03:46:28'),(1578,238,10,'2013-04-18 03:46:28','2013-04-18 05:46:28'),(1579,238,11,'2013-04-18 05:46:28','2013-04-18 07:46:28'),(1580,238,12,'2013-04-18 07:46:28','2013-04-18 09:46:28'),(1581,238,13,'2013-04-18 09:46:28','2013-04-18 11:46:28'),(1582,239,14,'2013-04-19 11:46:28','2013-04-19 13:46:28'),(1583,239,15,'2013-04-19 13:46:28','2013-04-19 15:46:28'),(1584,239,16,'2013-04-19 15:46:28','2013-04-19 17:46:28'),(1585,239,17,'2013-04-19 17:46:28','2013-04-19 19:46:28'),(1586,239,18,'2013-04-19 19:46:28','2013-04-19 21:46:28'),(1587,239,19,'2013-04-19 21:46:28','2013-04-19 23:46:28'),(1588,239,20,'2013-04-19 23:46:28','2013-04-20 01:46:28'),(1589,240,7,'2013-04-21 01:46:28','2013-04-21 03:46:28'),(1590,240,8,'2013-04-21 03:46:28','2013-04-21 05:46:28'),(1591,240,9,'2013-04-21 05:46:28','2013-04-21 07:46:28'),(1592,240,10,'2013-04-21 07:46:28','2013-04-21 09:46:28'),(1593,240,11,'2013-04-21 09:46:28','2013-04-21 11:46:28'),(1594,240,12,'2013-04-21 11:46:28','2013-04-21 13:46:28'),(1595,240,13,'2013-04-21 13:46:28','2013-04-21 15:46:28'),(1596,241,14,'2013-04-22 15:46:28','2013-04-22 17:46:28'),(1597,241,15,'2013-04-22 17:46:28','2013-04-22 19:46:28'),(1598,241,16,'2013-04-22 19:46:28','2013-04-22 21:46:28'),(1599,241,17,'2013-04-22 21:46:28','2013-04-22 23:46:28'),(1600,241,18,'2013-04-22 23:46:28','2013-04-23 01:46:28'),(1601,241,19,'2013-04-23 01:46:28','2013-04-23 03:46:28'),(1602,241,20,'2013-04-23 03:46:28','2013-04-23 05:46:28'),(1603,242,7,'2013-04-24 05:46:28','2013-04-24 07:46:28'),(1604,242,8,'2013-04-24 07:46:28','2013-04-24 09:46:28'),(1605,242,9,'2013-04-24 09:46:28','2013-04-24 11:46:28'),(1606,242,10,'2013-04-24 11:46:28','2013-04-24 13:46:28'),(1607,242,11,'2013-04-24 13:46:28','2013-04-24 15:46:28'),(1608,242,12,'2013-04-24 15:46:28','2013-04-24 17:46:28'),(1609,242,13,'2013-04-24 17:46:28','2013-04-24 19:46:28'),(1610,243,14,'2013-04-25 19:46:28','2013-04-25 21:46:28'),(1611,243,15,'2013-04-25 21:46:28','2013-04-25 23:46:28'),(1612,243,16,'2013-04-25 23:46:28','2013-04-26 01:46:28'),(1613,243,17,'2013-04-26 01:46:28','2013-04-26 03:46:28'),(1614,243,18,'2013-04-26 03:46:28','2013-04-26 05:46:28'),(1615,243,19,'2013-04-26 05:46:28','2013-04-26 07:46:28'),(1616,243,20,'2013-04-26 07:46:28','2013-04-26 09:46:28'),(1617,244,7,'2013-04-27 09:46:28','2013-04-27 11:46:28'),(1618,244,8,'2013-04-27 11:46:28','2013-04-27 13:46:28'),(1619,244,9,'2013-04-27 13:46:28','2013-04-27 15:46:28'),(1620,244,10,'2013-04-27 15:46:28','2013-04-27 17:46:28'),(1621,244,11,'2013-04-27 17:46:28','2013-04-27 19:46:28'),(1622,244,12,'2013-04-27 19:46:28','2013-04-27 21:46:28'),(1623,244,13,'2013-04-27 21:46:28','2013-04-27 23:46:28'),(1624,245,14,'2013-04-28 23:46:28','2013-04-29 01:46:28'),(1625,245,15,'2013-04-29 01:46:28','2013-04-29 03:46:28'),(1626,245,16,'2013-04-29 03:46:28','2013-04-29 05:46:28'),(1627,245,17,'2013-04-29 05:46:28','2013-04-29 07:46:28'),(1628,245,18,'2013-04-29 07:46:28','2013-04-29 09:46:28'),(1629,245,19,'2013-04-29 09:46:28','2013-04-29 11:46:28'),(1630,245,20,'2013-04-29 11:46:28','2013-04-29 13:46:28'),(1631,246,7,'2013-04-30 13:46:28','2013-04-30 15:46:28'),(1632,246,8,'2013-04-30 15:46:28','2013-04-30 17:46:28'),(1633,246,9,'2013-04-30 17:46:28','2013-04-30 19:46:28'),(1634,246,10,'2013-04-30 19:46:28','2013-04-30 21:46:28'),(1635,246,11,'2013-04-30 21:46:28','2013-04-30 23:46:28'),(1636,246,12,'2013-04-30 23:46:28','2013-05-01 01:46:28'),(1637,246,13,'2013-05-01 01:46:28','2013-05-01 03:46:28'),(1638,247,14,'2013-05-02 03:46:28','2013-05-02 05:46:28'),(1639,247,15,'2013-05-02 05:46:28','2013-05-02 07:46:28'),(1640,247,16,'2013-05-02 07:46:28','2013-05-02 09:46:28'),(1641,247,17,'2013-05-02 09:46:28','2013-05-02 11:46:28'),(1642,247,18,'2013-05-02 11:46:28','2013-05-02 13:46:28'),(1643,247,19,'2013-05-02 13:46:28','2013-05-02 15:46:28'),(1644,247,20,'2013-05-02 15:46:28','2013-05-02 17:46:28'),(1645,248,7,'2013-05-03 17:46:28','2013-05-03 19:46:28'),(1646,248,8,'2013-05-03 19:46:28','2013-05-03 21:46:28'),(1647,248,9,'2013-05-03 21:46:28','2013-05-03 23:46:28'),(1648,248,10,'2013-05-03 23:46:28','2013-05-04 01:46:28'),(1649,248,11,'2013-05-04 01:46:28','2013-05-04 03:46:28'),(1650,248,12,'2013-05-04 03:46:28','2013-05-04 05:46:28'),(1651,248,13,'2013-05-04 05:46:28','2013-05-04 07:46:28'),(1652,249,14,'2013-05-05 07:46:28','2013-05-05 09:46:28'),(1653,249,15,'2013-05-05 09:46:28','2013-05-05 11:46:28'),(1654,249,16,'2013-05-05 11:46:28','2013-05-05 13:46:28'),(1655,249,17,'2013-05-05 13:46:28','2013-05-05 15:46:28'),(1656,249,18,'2013-05-05 15:46:28','2013-05-05 17:46:28'),(1657,249,19,'2013-05-05 17:46:28','2013-05-05 19:46:28'),(1658,249,20,'2013-05-05 19:46:28','2013-05-05 21:46:28'),(1659,250,7,'2013-05-06 21:46:28','2013-05-06 23:46:28'),(1660,250,8,'2013-05-06 23:46:28','2013-05-07 01:46:28'),(1661,250,9,'2013-05-07 01:46:28','2013-05-07 03:46:28'),(1662,250,10,'2013-05-07 03:46:28','2013-05-07 05:46:28'),(1663,250,11,'2013-05-07 05:46:28','2013-05-07 07:46:28'),(1664,250,12,'2013-05-07 07:46:28','2013-05-07 09:46:28'),(1665,250,13,'2013-05-07 09:46:28','2013-05-07 11:46:28'),(1666,251,14,'2013-05-08 11:46:28','2013-05-08 13:46:28'),(1667,251,15,'2013-05-08 13:46:28','2013-05-08 15:46:28'),(1668,251,16,'2013-05-08 15:46:28','2013-05-08 17:46:28'),(1669,251,17,'2013-05-08 17:46:28','2013-05-08 19:46:28'),(1670,251,18,'2013-05-08 19:46:28','2013-05-08 21:46:28'),(1671,251,19,'2013-05-08 21:46:28','2013-05-08 23:46:28'),(1672,251,20,'2013-05-08 23:46:28','2013-05-09 01:46:28'),(1673,252,7,'2013-05-10 01:46:28','2013-05-10 03:46:28'),(1674,252,8,'2013-05-10 03:46:28','2013-05-10 05:46:28'),(1675,252,9,'2013-05-10 05:46:28','2013-05-10 07:46:28'),(1676,252,10,'2013-05-10 07:46:28','2013-05-10 09:46:28'),(1677,252,11,'2013-05-10 09:46:28','2013-05-10 11:46:28'),(1678,252,12,'2013-05-10 11:46:28','2013-05-10 13:46:28'),(1679,252,13,'2013-05-10 13:46:28','2013-05-10 15:46:28'),(1680,253,14,'2013-05-11 15:46:28','2013-05-11 17:46:28'),(1681,253,15,'2013-05-11 17:46:28','2013-05-11 19:46:28'),(1682,253,16,'2013-05-11 19:46:28','2013-05-11 21:46:28'),(1683,253,17,'2013-05-11 21:46:28','2013-05-11 23:46:28'),(1684,253,18,'2013-05-11 23:46:28','2013-05-12 01:46:28'),(1685,253,19,'2013-05-12 01:46:28','2013-05-12 03:46:28'),(1686,253,20,'2013-05-12 03:46:28','2013-05-12 05:46:28'),(1687,254,7,'2013-05-13 05:46:28','2013-05-13 07:46:28'),(1688,254,8,'2013-05-13 07:46:28','2013-05-13 09:46:28'),(1689,254,9,'2013-05-13 09:46:28','2013-05-13 11:46:28'),(1690,254,10,'2013-05-13 11:46:28','2013-05-13 13:46:28'),(1691,254,11,'2013-05-13 13:46:28','2013-05-13 15:46:28'),(1692,254,12,'2013-05-13 15:46:28','2013-05-13 17:46:28'),(1693,254,13,'2013-05-13 17:46:28','2013-05-13 19:46:28'),(1694,255,14,'2013-05-14 19:46:28','2013-05-14 21:46:28'),(1695,255,15,'2013-05-14 21:46:28','2013-05-14 23:46:28'),(1696,255,16,'2013-05-14 23:46:28','2013-05-15 01:46:28'),(1697,255,17,'2013-05-15 01:46:28','2013-05-15 03:46:28'),(1698,255,18,'2013-05-15 03:46:28','2013-05-15 05:46:28'),(1699,255,19,'2013-05-15 05:46:28','2013-05-15 07:46:28'),(1700,255,20,'2013-05-15 07:46:28','2013-05-15 09:46:28'),(1701,256,7,'2013-05-16 09:46:28','2013-05-16 11:46:28'),(1702,256,8,'2013-05-16 11:46:28','2013-05-16 13:46:28'),(1703,256,9,'2013-05-16 13:46:28','2013-05-16 15:46:28'),(1704,256,10,'2013-05-16 15:46:28','2013-05-16 17:46:28'),(1705,256,11,'2013-05-16 17:46:28','2013-05-16 19:46:28'),(1706,256,12,'2013-05-16 19:46:28','2013-05-16 21:46:28'),(1707,256,13,'2013-05-16 21:46:28','2013-05-16 23:46:28'),(1708,257,14,'2013-05-17 23:46:28','2013-05-18 01:46:28'),(1709,257,15,'2013-05-18 01:46:28','2013-05-18 03:46:28'),(1710,257,16,'2013-05-18 03:46:28','2013-05-18 05:46:28'),(1711,257,17,'2013-05-18 05:46:28','2013-05-18 07:46:28'),(1712,257,18,'2013-05-18 07:46:28','2013-05-18 09:46:28'),(1713,257,19,'2013-05-18 09:46:28','2013-05-18 11:46:28'),(1714,257,20,'2013-05-18 11:46:28','2013-05-18 13:46:28'),(1715,258,7,'2013-05-19 13:46:28','2013-05-19 15:46:28'),(1716,258,8,'2013-05-19 15:46:28','2013-05-19 17:46:28'),(1717,258,9,'2013-05-19 17:46:28','2013-05-19 19:46:28'),(1718,258,10,'2013-05-19 19:46:28','2013-05-19 21:46:28'),(1719,258,11,'2013-05-19 21:46:28','2013-05-19 23:46:28'),(1720,258,12,'2013-05-19 23:46:28','2013-05-20 01:46:28'),(1721,258,13,'2013-05-20 01:46:28','2013-05-20 03:46:28'),(1722,259,14,'2013-05-21 03:46:28','2013-05-21 05:46:28'),(1723,259,15,'2013-05-21 05:46:28','2013-05-21 07:46:28'),(1724,259,16,'2013-05-21 07:46:28','2013-05-21 09:46:28'),(1725,259,17,'2013-05-21 09:46:28','2013-05-21 11:46:28'),(1726,259,18,'2013-05-21 11:46:28','2013-05-21 13:46:28'),(1727,259,19,'2013-05-21 13:46:28','2013-05-21 15:46:28'),(1728,259,20,'2013-05-21 15:46:28','2013-05-21 17:46:28'),(1729,260,7,'2013-05-22 17:46:28','2013-05-22 19:46:28'),(1730,260,8,'2013-05-22 19:46:28','2013-05-22 21:46:28'),(1731,260,9,'2013-05-22 21:46:28','2013-05-22 23:46:28'),(1732,260,10,'2013-05-22 23:46:28','2013-05-23 01:46:28'),(1733,260,11,'2013-05-23 01:46:28','2013-05-23 03:46:28'),(1734,260,12,'2013-05-23 03:46:28','2013-05-23 05:46:28'),(1735,260,13,'2013-05-23 05:46:28','2013-05-23 07:46:28'),(1736,261,14,'2013-05-24 07:46:28','2013-05-24 09:46:28'),(1737,261,15,'2013-05-24 09:46:28','2013-05-24 11:46:28'),(1738,261,16,'2013-05-24 11:46:28','2013-05-24 13:46:28'),(1739,261,17,'2013-05-24 13:46:28','2013-05-24 15:46:28'),(1740,261,18,'2013-05-24 15:46:28','2013-05-24 17:46:28'),(1741,261,19,'2013-05-24 17:46:28','2013-05-24 19:46:28'),(1742,261,20,'2013-05-24 19:46:28','2013-05-24 21:46:28'),(1743,262,7,'2013-05-25 21:46:28','2013-05-25 23:46:28'),(1744,262,8,'2013-05-25 23:46:28','2013-05-26 01:46:28'),(1745,262,9,'2013-05-26 01:46:28','2013-05-26 03:46:28'),(1746,262,10,'2013-05-26 03:46:28','2013-05-26 05:46:28'),(1747,262,11,'2013-05-26 05:46:28','2013-05-26 07:46:28'),(1748,262,12,'2013-05-26 07:46:28','2013-05-26 09:46:28'),(1749,262,13,'2013-05-26 09:46:28','2013-05-26 11:46:28'),(1750,263,14,'2013-05-27 11:46:28','2013-05-27 13:46:28'),(1751,263,15,'2013-05-27 13:46:28','2013-05-27 15:46:28'),(1752,263,16,'2013-05-27 15:46:28','2013-05-27 17:46:28'),(1753,263,17,'2013-05-27 17:46:28','2013-05-27 19:46:28'),(1754,263,18,'2013-05-27 19:46:28','2013-05-27 21:46:28'),(1755,263,19,'2013-05-27 21:46:28','2013-05-27 23:46:28'),(1756,263,20,'2013-05-27 23:46:28','2013-05-28 01:46:28'),(1757,264,7,'2013-05-29 01:46:28','2013-05-29 03:46:28'),(1758,264,8,'2013-05-29 03:46:28','2013-05-29 05:46:28'),(1759,264,9,'2013-05-29 05:46:28','2013-05-29 07:46:28'),(1760,264,10,'2013-05-29 07:46:28','2013-05-29 09:46:28'),(1761,264,11,'2013-05-29 09:46:28','2013-05-29 11:46:28'),(1762,264,12,'2013-05-29 11:46:28','2013-05-29 13:46:28'),(1763,264,13,'2013-05-29 13:46:28','2013-05-29 15:46:28'),(1764,265,14,'2013-05-30 15:46:28','2013-05-30 17:46:28'),(1765,265,15,'2013-05-30 17:46:28','2013-05-30 19:46:28'),(1766,265,16,'2013-05-30 19:46:28','2013-05-30 21:46:28'),(1767,265,17,'2013-05-30 21:46:28','2013-05-30 23:46:28'),(1768,265,18,'2013-05-30 23:46:28','2013-05-31 01:46:28'),(1769,265,19,'2013-05-31 01:46:28','2013-05-31 03:46:28'),(1770,265,20,'2013-05-31 03:46:28','2013-05-31 05:46:28'),(1771,266,7,'2013-06-01 05:46:28','2013-06-01 07:46:28'),(1772,266,8,'2013-06-01 07:46:28','2013-06-01 09:46:28'),(1773,266,9,'2013-06-01 09:46:28','2013-06-01 11:46:28'),(1774,266,10,'2013-06-01 11:46:28','2013-06-01 13:46:28'),(1775,266,11,'2013-06-01 13:46:28','2013-06-01 15:46:28'),(1776,266,12,'2013-06-01 15:46:28','2013-06-01 17:46:28'),(1777,266,13,'2013-06-01 17:46:28','2013-06-01 19:46:28'),(1778,267,14,'2013-06-02 19:46:28','2013-06-02 21:46:28'),(1779,267,15,'2013-06-02 21:46:28','2013-06-02 23:46:28'),(1780,267,16,'2013-06-02 23:46:28','2013-06-03 01:46:28'),(1781,267,17,'2013-06-03 01:46:28','2013-06-03 03:46:28'),(1782,267,18,'2013-06-03 03:46:28','2013-06-03 05:46:28'),(1783,267,19,'2013-06-03 05:46:28','2013-06-03 07:46:28'),(1784,267,20,'2013-06-03 07:46:28','2013-06-03 09:46:28'),(1785,268,7,'2013-06-04 09:46:28','2013-06-04 11:46:28'),(1786,268,8,'2013-06-04 11:46:28','2013-06-04 13:46:28'),(1787,268,9,'2013-06-04 13:46:28','2013-06-04 15:46:28'),(1788,268,10,'2013-06-04 15:46:28','2013-06-04 17:46:28'),(1789,268,11,'2013-06-04 17:46:28','2013-06-04 19:46:28'),(1790,268,12,'2013-06-04 19:46:28','2013-06-04 21:46:28'),(1791,268,13,'2013-06-04 21:46:28','2013-06-04 23:46:28'),(1792,269,14,'2013-06-05 23:46:28','2013-06-06 01:46:28'),(1793,269,15,'2013-06-06 01:46:28','2013-06-06 03:46:28'),(1794,269,16,'2013-06-06 03:46:28','2013-06-06 05:46:28'),(1795,269,17,'2013-06-06 05:46:28','2013-06-06 07:46:28'),(1796,269,18,'2013-06-06 07:46:28','2013-06-06 09:46:28'),(1797,269,19,'2013-06-06 09:46:28','2013-06-06 11:46:28'),(1798,269,20,'2013-06-06 11:46:28','2013-06-06 13:46:28'),(1799,270,7,'2013-06-07 13:46:28','2013-06-07 15:46:28'),(1800,270,8,'2013-06-07 15:46:28','2013-06-07 17:46:28'),(1801,270,9,'2013-06-07 17:46:28','2013-06-07 19:46:28'),(1802,270,10,'2013-06-07 19:46:28','2013-06-07 21:46:28'),(1803,270,11,'2013-06-07 21:46:28','2013-06-07 23:46:28'),(1804,270,12,'2013-06-07 23:46:28','2013-06-08 01:46:28'),(1805,270,13,'2013-06-08 01:46:28','2013-06-08 03:46:28'),(1806,271,14,'2013-06-09 03:46:28','2013-06-09 05:46:28'),(1807,271,15,'2013-06-09 05:46:28','2013-06-09 07:46:28'),(1808,271,16,'2013-06-09 07:46:28','2013-06-09 09:46:28'),(1809,271,17,'2013-06-09 09:46:28','2013-06-09 11:46:28'),(1810,271,18,'2013-06-09 11:46:28','2013-06-09 13:46:28'),(1811,271,19,'2013-06-09 13:46:28','2013-06-09 15:46:28'),(1812,271,20,'2013-06-09 15:46:28','2013-06-09 17:46:28'),(1813,272,7,'2013-06-10 17:46:28','2013-06-10 19:46:28'),(1814,272,8,'2013-06-10 19:46:28','2013-06-10 21:46:28'),(1815,272,9,'2013-06-10 21:46:28','2013-06-10 23:46:28'),(1816,272,10,'2013-06-10 23:46:28','2013-06-11 01:46:28'),(1817,272,11,'2013-06-11 01:46:28','2013-06-11 03:46:28'),(1818,272,12,'2013-06-11 03:46:28','2013-06-11 05:46:28'),(1819,272,13,'2013-06-11 05:46:28','2013-06-11 07:46:28'),(1820,273,14,'2013-06-12 07:46:28','2013-06-12 09:46:28'),(1821,273,15,'2013-06-12 09:46:28','2013-06-12 11:46:28'),(1822,273,16,'2013-06-12 11:46:28','2013-06-12 13:46:28'),(1823,273,17,'2013-06-12 13:46:28','2013-06-12 15:46:28'),(1824,273,18,'2013-06-12 15:46:28','2013-06-12 17:46:28'),(1825,273,19,'2013-06-12 17:46:28','2013-06-12 19:46:28'),(1826,273,20,'2013-06-12 19:46:28','2013-06-12 21:46:28');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_in_ticket`
--

DROP TABLE IF EXISTS `trip_in_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trip_in_ticket` (
  `ticket_id` int(11) unsigned NOT NULL,
  `trip_id` int(11) NOT NULL,
  PRIMARY KEY (`ticket_id`,`trip_id`),
  KEY `trip_in_reservation_trip_id_idx` (`trip_id`),
  KEY `trip_in_reservation_reservation_id_idx` (`ticket_id`),
  KEY `trip_in_ticket_ticket_id_idx` (`ticket_id`),
  CONSTRAINT `trip_in_ticket_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `trip_in_ticket_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_in_ticket`
--

LOCK TABLES `trip_in_ticket` WRITE;
/*!40000 ALTER TABLE `trip_in_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip_in_ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`prevent_duplicate_seat_insert_trip`
BEFORE INSERT ON `bus_reservation`.`trip_in_ticket`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	SELECT 
		`check_double_booking_trip`(NEW.`trip_id`,NEW.`ticket_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrdb002";
	END IF;
	SELECT 
		`check_inactive_trip`(NEW.`trip_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrrs009";
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bus_reservation`.`prevent_duplicate_seat_update_trip`
BEFORE UPDATE ON `bus_reservation`.`trip_in_ticket`
FOR EACH ROW
begin
	DECLARE num_rows INTEGER;
	SELECT 
		`check_double_booking_trip`(NEW.`trip_id`,NEW.`ticket_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrdb002";
	END IF;
	SELECT 
		`check_inactive_trip`(NEW.`trip_id`)
	INTO num_rows;
	IF num_rows > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "msgerrrs009";
	END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `trip_start_end`
--

DROP TABLE IF EXISTS `trip_start_end`;
/*!50001 DROP VIEW IF EXISTS `trip_start_end`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `trip_start_end` (
  `trip_id` int(11),
  `bus_status_id` int(11),
  `start_location_id` int(11),
  `departure_time` datetime,
  `end_location_id` int(11),
  `arrival_time` datetime
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `trip_with_fare_period`
--

DROP TABLE IF EXISTS `trip_with_fare_period`;
/*!50001 DROP VIEW IF EXISTS `trip_with_fare_period`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `trip_with_fare_period` (
  `bus_status_id` int(11),
  `start_location_id` int(11),
  `end_location_id` int(11),
  `start_period` datetime,
  `end_period` datetime,
  `fare` double
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `trip_with_number_of_remained_seats_in_subroute`
--

DROP TABLE IF EXISTS `trip_with_number_of_remained_seats_in_subroute`;
/*!50001 DROP VIEW IF EXISTS `trip_with_number_of_remained_seats_in_subroute`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `trip_with_number_of_remained_seats_in_subroute` (
  `trip_id` int(11),
  `bus_status_id` int(11),
  `start_location_id` int(11),
  `departure_time` datetime,
  `end_location_id` int(11),
  `arrival_time` datetime,
  `number_of_remained_seats` bigint(22),
  `start_period` datetime,
  `end_period` datetime,
  `fare` double
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role_id` int(11) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `civil_id` varchar(20) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `user_role_id_idx` (`role_id`),
  CONSTRAINT `user_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'customer1','ffbc4675f864e0e9aab8bdf7a0437010',1,'First','Customer',NULL,NULL,'cust1_1357703483_per@fpt.edu.vn',NULL,'active'),(2,'truong','047c30e8313db6e45fd87ab6e1bfd1fb',3,'Truong','Nguyen Son',NULL,NULL,NULL,NULL,'active'),(3,'tram','ecb1da74e8ff8fdd2911197ecf8badc0',2,'Tram','Nguyen Thi Bich',NULL,NULL,NULL,NULL,'active'),(4,'hainl','7a9cc2b1396295cf21e1a628a0a168be',4,'Hải','Nguyễn Lương',NULL,NULL,'hainl60335@fpt.edu.vn',NULL,'active'),(5,'newuser','0354d89c28ec399c00d3cb2d094cf093',1,NULL,NULL,NULL,NULL,'hainl60335@fpt.edu.vn',NULL,'new');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bus_reservation'
--
/*!50003 DROP FUNCTION IF EXISTS `check_double_booking_seat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `check_double_booking_seat`(seatname varchar(5), ticket_id int) RETURNS int(11)
BEGIN
	DECLARE `count` INTEGER;
	SELECT 
		COUNT(*)
	INTO `count` FROM
		`seat_position` `stp`
			INNER JOIN
		`ticket` `tkt` ON `stp`.`ticket_id` = `tkt`.`id`
			AND `stp`.`ticket_id` <> `ticket_id`
			AND `stp`.`seat_name` = `seat_name`
			INNER JOIN
		`reservation` `rsv` ON `tkt`.`reservation_id` = `rsv`.`id`
			INNER JOIN
		`trip_in_ticket` `tit` ON `tit`.`ticket_id` = `stp`.`ticket_id`
			INNER JOIN
		`trip_in_ticket` `tit_new` ON `tit_new`.`trip_id` = `tit`.`trip_id`
			AND `tit_new`.`ticket_id` = `ticket_id`
	WHERE
		`rsv`.`status` = 'paid'
		OR `rsv`.`status` = 'pending'
			OR (`rsv`.`status` = 'unpaid'
			AND `rsv`.`book_time` > SUBDATE(NOW(), INTERVAL 15 MINUTE));
	RETURN `count`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_double_booking_trip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `check_double_booking_trip`(`trip_id` INT, `ticket_id` INT) RETURNS int(11)
BEGIN
	DECLARE `count` INT;
	SELECT 
		COUNT(*)
	INTO `count` FROM
		`trip_in_ticket` `tit`
			INNER JOIN
		`ticket` `tkt` ON `tit`.`ticket_id` = `tkt`.`id`
			AND `tit`.`ticket_id` <> `ticket_id`
			AND `tit`.`trip_id` = `trip_id`
			INNER JOIN
		`reservation` `rsv` ON `tkt`.`reservation_id` = `rsv`.`id`
			INNER JOIN
		`seat_position` `stp` ON `stp`.`ticket_id` = `tit`.`ticket_id`
			INNER JOIN
		`seat_position` `stp_new` ON `stp_new`.`seat_name` = `stp`.`seat_name`
			AND `stp_new`.`ticket_id` = `ticket_id`
	WHERE
		`rsv`.`status` = 'paid'
		OR `rsv`.`status` = 'pending'
			OR (`rsv`.`status` = 'unpaid'
			AND `rsv`.`book_time` > SUBDATE(NOW(), INTERVAL 15 MINUTE));
	RETURN `count`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_inactive_trip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `check_inactive_trip`(trip_id int) RETURNS int(11)
BEGIN
	DECLARE `count` INTEGER;
	SELECT 
		COUNT(*)
	INTO `count` FROM
		`trip` `trp`
			INNER JOIN
		`bus_status` `bst` ON `trp`.`bus_status_id` = `bst`.`id`
			AND
		`trp`.`id` = `trip_id`
	WHERE
		`bst`.`status` <> 'active';
RETURN `count`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_ticket_with_inactive_trip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `check_ticket_with_inactive_trip`(ticket_id int) RETURNS int(11)
BEGIN
	DECLARE `count` INTEGER;
	SELECT 
		COUNT(*)
	INTO `count` FROM
		`trip_in_ticket` `tit`
			INNER JOIN
		`trip` `trp`  ON `tit`.`trip_id` = `trp`.`id`
			AND
		`tit`.`ticket_id` = `ticket_id`
			INNER JOIN
		`bus_status` `bst` ON `trp`.`bus_status_id` = `bst`.`id`
	WHERE
		`bst`.`status` <> 'active';
RETURN `count`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_top_four_trips` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `get_top_four_trips`()
BEGIN
SELECT  dept.bus_status_id,
		dept.city_name       			AS departure_city,
	    dept.station_name    			AS departure_station_name,
	    dept.station_address 			AS departure_station_address,
        dept.departure_time,
		arrv.city_name       			AS arrival_city,
        arrv.station_name    			AS arrival_station_name,
		arrv.station_address 			AS arrival_station_address,
		arrv.arrival_time,
		trff.fare						AS fare,
		rmst.number_of_remained_seats 	AS remained_seats,
		dept.route_id					AS route,
		btyp.name					    AS bus_type,
		btyp.id							AS bus_type_id
		
FROM   
	-- departure trip information (first trip in journey)
	    (SELECT dtrp.bus_status_id,
				ddtl.city_name,	
				ddtl.city_id,
			 	ddtl.station_name, 
				ddtl.station_address,
				dtrp.departure_time,
				ddtl.route_id
         FROM trip dtrp
           INNER JOIN
			 (SELECT drdt.id      AS route_details_id,
				     dsta.name    AS station_name,
			 		 dcty.name    AS city_name,
					 dcty.id      AS city_id,
					 dsta.address AS station_address,
					 drou.id	  AS route_id
			  FROM   route_details drdt
				INNER JOIN route    drou ON drou.id = drdt.route_id
				INNER JOIN segment  dseg ON dseg.id = drdt.segment_id        			
				INNER JOIN station  dsta ON dsta.id = dseg.departure_station_id			   
				INNER JOIN location dcty ON dcty.id = dsta.location_id  ) ddtl           			     
		   ON dtrp.route_details_id = ddtl.route_details_id
		 WHERE  
		    dtrp.departure_time >= ADDDATE(NOW(), INTERVAL 35 MINUTE)
		) dept
	INNER JOIN	 
	-- arrival trip information (last trip in journey)
        (SELECT atrp.bus_status_id,
                adtl.city_name,
				adtl.city_id,
				adtl.station_name, 
			    adtl.station_address,
				atrp.arrival_time
         FROM trip atrp 
           INNER JOIN     
			(SELECT ardt.id      AS route_details_id,
					acty.name    AS city_name,
					acty.id		 AS city_id,
					asta.name    AS station_name,                               			
					asta.address AS station_address			   
			 FROM   route_details ardt                                       			    
			   INNER JOIN segment  aseg ON ardt.segment_id = aseg.id          			
			   INNER JOIN station  asta ON asta.id = aseg.arrival_station_id			   
			   INNER JOIN location acty ON acty.id = asta.location_id  ) adtl           			     
		   ON atrp.route_details_id = adtl.route_details_id) arrv
    ON dept.bus_status_id = arrv.bus_status_id AND dept.city_id <> arrv.city_id
	INNER JOIN bus_status bstt
	  ON bstt.id = arrv.bus_status_id AND
		 bstt.status = 'active'
-- bus type information
    INNER JOIN bus
      ON bus.id = bstt.bus_id  
	INNER JOIN bus_type btyp
	  ON bus.bus_type_id =  btyp.id
-- fare information
	INNER JOIN trip ftrp
      ON dept.bus_status_id = ftrp.bus_status_id
        AND dept.departure_time <= ftrp.departure_time
	    AND arrv.arrival_time >= ftrp.arrival_time
    INNER JOIN route_details frdt 
      ON ftrp.route_details_id = frdt.id
    INNER JOIN tariff trff 
	  ON frdt.segment_id = trff.segment_id 
        AND trff.bus_type_id = bus.bus_type_id -- BUS_TYPE
-- remained seat view
	INNER JOIN remained_seats rmst
	  ON rmst.start_location_id = dept.city_id AND 
		 rmst.end_location_id = arrv.city_id AND 
		 rmst.bus_status_id = dept.bus_status_id
WHERE   -- departure date is in range of valid fare dates
        trff.valid_from IN (SELECT MAX(ttrf.valid_from) 
                            FROM   tariff ttrf 
                            WHERE  ttrf.valid_from <= ftrp.departure_time AND
								   ttrf.segment_id = trff.segment_id AND
								   ttrf.bus_type_id = trff.bus_type_id) AND
		-- remained seat >= min number of passenger allowed
        rmst.number_of_remained_seats >= 1
GROUP BY ftrp.bus_status_id
ORDER BY dept.departure_time ASC, rmst.number_of_remained_seats ASC
LIMIT 4;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_trips` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `search_trips`(IN DEPT_CITY INT, 
							  IN ARRV_CITY INT,
							  IN DEPT_DATE VARCHAR(10),
							  IN PSSGR_NO INT,
                           -- IN BUS_TYPE INT,
							  IN MIN_DATE VARCHAR(20))
BEGIN
SELECT  dept.bus_status_id,
		dept.city_name       			AS departure_city,
	    dept.station_name    			AS departure_station_name,
	    dept.station_address 			AS departure_station_address,
        dept.departure_time,
		arrv.city_name       			AS arrival_city,
        arrv.station_name    			AS arrival_station_name,
		arrv.station_address 			AS arrival_station_address,
		arrv.arrival_time,
--      SUM(trff.fare) * PSSGR_NO 		AS fare,
-- 		get fare for each person
		trff.fare						AS fare,
		rmst.number_of_remained_seats 	AS remained_seats,
		dept.route_id					AS route,
		btyp.name					    AS bus_type,
		btyp.id							AS bus_type_id
		
FROM   
	-- departure trip information (first trip in journey)
	    (SELECT dtrp.bus_status_id,
				ddtl.city_name,
			 	ddtl.station_name, 
				ddtl.station_address,
				dtrp.departure_time,
				ddtl.route_id
         FROM trip dtrp
           INNER JOIN
			 (SELECT drdt.id      AS route_details_id,
				     dsta.name    AS station_name,
			 		 dcty.name    AS city_name,                               			
					 dsta.address AS station_address,
					 drou.id	  AS route_id
			  FROM   route_details drdt
				INNER JOIN route    drou ON drou.id = drdt.route_id
				INNER JOIN segment  dseg ON dseg.id = drdt.segment_id        			
				INNER JOIN station  dsta ON dsta.id = dseg.departure_station_id			   
				INNER JOIN location dcty ON dcty.id = dsta.location_id             			     
			 WHERE  dcty.id = DEPT_CITY) ddtl
		   ON dtrp.route_details_id = ddtl.route_details_id
		 WHERE DATE(dtrp.departure_time) >= SUBDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
		   AND DATE(dtrp.departure_time) <= ADDDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
			-- DATE(dtrp.departure_time) = DATE(DEPT_DATE)
		    -- AND DATE(dtrp.departure_time) >= ADDDATE(NOW(), INTERVAL 30 MINUTE)
		   AND dtrp.departure_time >= cast(MIN_DATE as datetime)) dept
	INNER JOIN	 
	-- arrival trip information (last trip in journey)
        (SELECT atrp.bus_status_id,
                adtl.city_name,
				adtl.station_name, 
			    adtl.station_address,
				atrp.arrival_time
         FROM trip atrp 
           INNER JOIN     
			(SELECT ardt.id      AS route_details_id,
					acty.name    AS city_name,
					asta.name    AS station_name,                               			
					asta.address AS station_address			   
			 FROM   route_details ardt                                       			    
			   INNER JOIN segment  aseg ON ardt.segment_id = aseg.id          			
			   INNER JOIN station  asta ON asta.id = aseg.arrival_station_id			   
			   INNER JOIN location acty ON acty.id = asta.location_id             			     
			 WHERE  acty.id = ARRV_CITY) adtl
		   ON atrp.route_details_id = adtl.route_details_id) arrv
    ON dept.bus_status_id = arrv.bus_status_id
	INNER JOIN bus_status bstt
	  ON bstt.id = arrv.bus_status_id AND
		 bstt.status = 'active'
-- bus type information
    INNER JOIN bus
      ON bus.id = bstt.bus_id  -- AND bus.bus_type_id = BUS_TYPE
	INNER JOIN bus_type btyp
	  ON bus.bus_type_id =  btyp.id
-- fare information
	INNER JOIN trip ftrp
      ON dept.bus_status_id = ftrp.bus_status_id
        AND dept.departure_time <= ftrp.departure_time
	    AND arrv.arrival_time >= ftrp.arrival_time
    INNER JOIN route_details frdt 
      ON ftrp.route_details_id = frdt.id
    INNER JOIN tariff trff 
	  ON frdt.segment_id = trff.segment_id 
        AND trff.bus_type_id = bus.bus_type_id -- BUS_TYPE
-- remained seat view
	INNER JOIN remained_seats rmst
	  ON rmst.start_location_id = DEPT_CITY AND 
		 rmst.end_location_id = ARRV_CITY AND 
		 rmst.bus_status_id = dept.bus_status_id
WHERE   -- departure date is in range of valid fare dates
        trff.valid_from IN (SELECT MAX(ttrf.valid_from) 
                            FROM   tariff ttrf 
                            WHERE  ttrf.valid_from <= ftrp.departure_time AND
								   ttrf.segment_id = trff.segment_id AND
								   ttrf.bus_type_id = trff.bus_type_id) AND
		-- remained seat >= min number of passenger allowed
        rmst.number_of_remained_seats >= PSSGR_NO
GROUP BY ftrp.bus_status_id
ORDER BY DATE(dept.departure_time) ASC, btyp.id ASC, TIME(dept.departure_time) ASC, rmst.number_of_remained_seats ASC;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bus_free_time`
--

/*!50001 DROP TABLE IF EXISTS `bus_free_time`*/;
/*!50001 DROP VIEW IF EXISTS `bus_free_time`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bus_free_time` AS select `bst_from`.`id` AS `id`,`bst_from`.`bus_id` AS `bus_id`,`bst_from`.`to_date` AS `from_date`,`bst_to`.`from_date` AS `to_date`,`bst_from`.`end_station_id` AS `station_id` from (`bus_status` `bst_from` left join `bus_status` `bst_to` on(((`bst_from`.`bus_id` = `bst_to`.`bus_id`) and (`bst_from`.`to_date` <= `bst_to`.`from_date`)))) where ((`bst_to`.`from_date` = (select min(`bst1`.`from_date`) from `bus_status` `bst1` where ((`bst_from`.`bus_id` = `bst1`.`bus_id`) and (`bst_from`.`to_date` <= `bst1`.`from_date`)))) or isnull(`bst_to`.`from_date`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `remained_seats`
--

/*!50001 DROP TABLE IF EXISTS `remained_seats`*/;
/*!50001 DROP VIEW IF EXISTS `remained_seats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `remained_seats` AS select `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_location_id` AS `start_location_id`,`tse`.`end_location_id` AS `end_location_id`,(`btp`.`number_of_seats` - count(distinct `sp`.`seat_name`)) AS `number_of_remained_seats` from ((`trip_start_end` `tse` left join (((`trip_in_ticket` `tit` join `ticket` `tkt` on((`tit`.`ticket_id` = `tkt`.`id`))) join `reservation` `rsv` on(((`tkt`.`reservation_id` = `rsv`.`id`) and ((`rsv`.`status` = 'paid') or (`rsv`.`status` = 'pending') or ((`rsv`.`status` = 'unpaid') and (`rsv`.`book_time` > (now() - interval 15 minute))))))) join `seat_position` `sp` on((`sp`.`ticket_id` = `tkt`.`id`))) on((`tit`.`trip_id` = `tse`.`trip_id`))) join ((`bus_status` `bst` join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) on((`bst`.`id` = `tse`.`bus_status_id`))) group by `tse`.`bus_status_id`,`tse`.`start_location_id`,`tse`.`end_location_id`,`btp`.`number_of_seats` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `route_terminal`
--

/*!50001 DROP TABLE IF EXISTS `route_terminal`*/;
/*!50001 DROP VIEW IF EXISTS `route_terminal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `route_terminal` AS select `rds_from`.`route_id` AS `id`,`seg_from`.`departure_station_id` AS `start_terminal_id`,`seg_to`.`arrival_station_id` AS `end_terminal_id` from ((`route_details` `rds_from` join `segment` `seg_from` on((`seg_from`.`id` = `rds_from`.`segment_id`))) left join (`route_details` `rds_to` join `segment` `seg_to` on((`seg_to`.`id` = `rds_to`.`segment_id`))) on((`rds_from`.`route_id` = `rds_to`.`route_id`))) where ((`rds_from`.`id` = (select min(`rds1`.`id`) from `route_details` `rds1` where (`rds_from`.`route_id` = `rds1`.`route_id`))) and (`rds_to`.`id` = (select max(`rds2`.`id`) from `route_details` `rds2` where (`rds_from`.`route_id` = `rds2`.`route_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tariff_view`
--

/*!50001 DROP TABLE IF EXISTS `tariff_view`*/;
/*!50001 DROP VIEW IF EXISTS `tariff_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tariff_view` AS select distinct `tar_from`.`id` AS `id`,`tar_from`.`segment_id` AS `segment_id`,`tar_from`.`bus_type_id` AS `bus_type_id`,`tar_from`.`fare` AS `fare`,`tar_from`.`valid_from` AS `valid_from`,`tar_to`.`valid_from` AS `valid_to` from (`tariff` `tar_from` left join `tariff` `tar_to` on(((`tar_to`.`segment_id` = `tar_from`.`segment_id`) and (`tar_to`.`bus_type_id` = `tar_from`.`bus_type_id`) and (`tar_to`.`valid_from` > `tar_from`.`valid_from`)))) where ((`tar_to`.`valid_from` <= (select min(`tar2`.`valid_from`) from `tariff` `tar2` where ((`tar2`.`segment_id` = `tar_to`.`segment_id`) and (`tar2`.`bus_type_id` = `tar_to`.`bus_type_id`) and (`tar2`.`valid_from` > `tar_from`.`valid_from`)))) or isnull(`tar_to`.`valid_from`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trip_start_end`
--

/*!50001 DROP TABLE IF EXISTS `trip_start_end`*/;
/*!50001 DROP VIEW IF EXISTS `trip_start_end`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=TEMPTABLE */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trip_start_end` AS select `trp`.`id` AS `trip_id`,`trp`.`bus_status_id` AS `bus_status_id`,`st1`.`location_id` AS `start_location_id`,`tr1`.`departure_time` AS `departure_time`,`st2`.`location_id` AS `end_location_id`,`tr2`.`arrival_time` AS `arrival_time` from ((((((((`trip` `tr1` join `route_details` `rd1` on((`rd1`.`id` = `tr1`.`route_details_id`))) join `segment` `sg1` on((`sg1`.`id` = `rd1`.`segment_id`))) join `station` `st1` on((`st1`.`id` = `sg1`.`departure_station_id`))) join `trip` `tr2` on((`tr1`.`bus_status_id` = `tr2`.`bus_status_id`))) join `route_details` `rd2` on((`rd2`.`id` = `tr2`.`route_details_id`))) join `segment` `sg2` on((`sg2`.`id` = `rd2`.`segment_id`))) join `station` `st2` on((`st2`.`id` = `sg2`.`arrival_station_id`))) join `trip` `trp` on((`trp`.`bus_status_id` = `tr2`.`bus_status_id`))) where ((`tr1`.`departure_time` <= `tr2`.`departure_time`) and (`trp`.`departure_time` >= `tr1`.`departure_time`) and (`trp`.`departure_time` <= `tr2`.`departure_time`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trip_with_fare_period`
--

/*!50001 DROP TABLE IF EXISTS `trip_with_fare_period`*/;
/*!50001 DROP VIEW IF EXISTS `trip_with_fare_period`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trip_with_fare_period` AS select distinct `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_location_id` AS `start_location_id`,`tse`.`end_location_id` AS `end_location_id`,`tar`.`valid_from` AS `start_period`,`tar`.`valid_to` AS `end_period`,sum(`tar`.`fare`) AS `fare` from ((((((`trip_start_end` `tse` join `bus_status` `bst` on((`bst`.`id` = `tse`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) join `trip` `trp` on((`trp`.`id` = `tse`.`trip_id`))) join `route_details` `rds` on((`rds`.`id` = `trp`.`route_details_id`))) join `tariff_view` `tar` on(((`tar`.`segment_id` = `rds`.`segment_id`) and (`tar`.`bus_type_id` = `bus`.`bus_type_id`) and (`tar`.`valid_from` <= `tse`.`departure_time`)))) group by `tse`.`bus_status_id`,`tse`.`start_location_id`,`tse`.`end_location_id`,`tar`.`valid_from`,`tar`.`valid_to` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trip_with_number_of_remained_seats_in_subroute`
--

/*!50001 DROP TABLE IF EXISTS `trip_with_number_of_remained_seats_in_subroute`*/;
/*!50001 DROP VIEW IF EXISTS `trip_with_number_of_remained_seats_in_subroute`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trip_with_number_of_remained_seats_in_subroute` AS select `trip_start_end`.`trip_id` AS `trip_id`,`trip_start_end`.`bus_status_id` AS `bus_status_id`,`trip_start_end`.`start_location_id` AS `start_location_id`,`trip_start_end`.`departure_time` AS `departure_time`,`trip_start_end`.`end_location_id` AS `end_location_id`,`trip_start_end`.`arrival_time` AS `arrival_time`,`temp`.`number_of_remained_seats` AS `number_of_remained_seats`,`twfp`.`start_period` AS `start_period`,`twfp`.`end_period` AS `end_period`,`twfp`.`fare` AS `fare` from ((`trip_start_end` join `remained_seats` `temp` on(((`trip_start_end`.`bus_status_id` = `temp`.`bus_status_id`) and (`trip_start_end`.`start_location_id` = `temp`.`start_location_id`) and (`trip_start_end`.`end_location_id` = `temp`.`end_location_id`)))) join `trip_with_fare_period` `twfp` on(((`trip_start_end`.`bus_status_id` = `twfp`.`bus_status_id`) and (`trip_start_end`.`start_location_id` = `twfp`.`start_location_id`) and (`trip_start_end`.`end_location_id` = `twfp`.`end_location_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-12 21:15:41
