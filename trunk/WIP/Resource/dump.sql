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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (15,2,'50G-000.01',3,4,'active'),(16,2,'50G-000.02',3,4,'active'),(17,2,'51G-000.03',6,5,'active'),(18,2,'53G-002.01',4,3,'active'),(19,2,'52G-001.01',6,5,'active'),(20,1,'55N-000.01',3,4,'active'),(21,1,'55N-000.03',3,4,'active'),(22,1,'55N-000.04',3,4,'active'),(23,1,'55N-000.05',3,4,'active'),(24,1,'55N-001.01',6,5,'active'),(25,2,'50G-002.02',4,3,'active'),(26,1,'50N-010.01',6,5,'active'),(27,1,'50N-010.02',6,5,'active'),(28,1,'50N-010.03',6,5,'active'),(29,1,'50N-010.04',NULL,NULL,'active'),(30,2,'50G-010.05',6,5,'active'),(31,2,'50G-010.06',6,5,'active'),(32,2,'50G-010.07',6,5,'active'),(33,2,'50G-010.08',NULL,NULL,'active');
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
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_status`
--

LOCK TABLES `bus_status` WRITE;
/*!40000 ALTER TABLE `bus_status` DISABLE KEYS */;
INSERT INTO `bus_status` VALUES (274,20,'initiation','2013-04-17 12:31:20','2013-04-17 12:31:20',8,'active'),(275,21,'initiation','2013-04-17 12:31:21','2013-04-17 12:31:21',8,'active'),(276,15,'initiation','2013-04-17 12:31:30','2013-04-17 12:31:30',8,'active'),(277,16,'initiation','2013-04-17 12:31:30','2013-04-17 12:31:30',8,'active'),(278,20,'ontrip','2013-04-18 00:40:00','2013-04-19 08:40:00',3,'active'),(279,20,'return','2013-04-20 00:00:00','2013-04-20 00:00:00',8,'active'),(280,20,'ontrip','2013-04-21 06:00:00','2013-04-22 14:00:00',3,'active'),(281,21,'ontrip','2013-04-19 00:00:00','2013-04-20 08:00:00',3,'active'),(282,15,'ontrip','2013-04-18 00:36:00','2013-04-19 08:36:00',3,'active'),(283,21,'ontrip','2013-04-22 00:00:00','2013-04-23 08:00:00',8,'active'),(284,15,'ontrip','2013-04-20 00:00:00','2013-04-21 08:00:00',8,'active'),(285,22,'initiation','2013-04-17 12:44:56','2013-04-17 12:44:56',8,'active'),(286,23,'initiation','2013-04-17 12:44:56','2013-04-17 12:44:56',8,'active'),(287,21,'ontrip','2013-05-15 00:00:00','2013-05-16 08:00:00',3,'active'),(288,21,'return','2013-05-17 00:00:00','2013-05-17 00:00:00',8,'active'),(289,15,'ontrip','2013-05-20 00:00:00','2013-05-21 08:00:00',3,'active'),(290,16,'ontrip','2013-05-16 00:50:00','2013-05-17 08:50:00',3,'active'),(291,21,'ontrip','2013-05-18 14:00:00','2013-05-19 22:00:00',3,'active'),(292,20,'ontrip','2013-05-17 00:00:00','2013-05-18 08:00:00',8,'active'),(293,16,'ontrip','2013-05-18 00:00:00','2013-05-19 08:00:00',8,'active'),(294,25,'initiation','2013-04-22 20:40:00','2013-04-22 20:40:00',8,'active'),(295,17,'initiation','2013-04-22 20:40:00','2013-04-22 20:40:00',8,'active'),(296,19,'initiation','2013-04-22 20:40:00','2013-04-22 20:40:00',8,'active'),(297,24,'initiation','2013-04-22 20:40:09','2013-04-22 20:40:09',8,'active'),(298,24,'ontrip','2013-04-30 14:00:00','2013-05-01 20:00:00',3,'active'),(299,17,'ontrip','2013-04-30 08:00:00','2013-05-01 14:00:00',3,'active'),(300,19,'ontrip','2013-04-30 10:00:00','2013-05-01 16:00:00',3,'active'),(301,26,'initiation','2013-04-22 20:45:03','2013-04-22 20:45:03',8,'active'),(302,27,'initiation','2013-04-22 20:45:03','2013-04-22 20:45:03',8,'active'),(303,28,'initiation','2013-04-22 20:45:04','2013-04-22 20:45:04',8,'active'),(304,30,'initiation','2013-04-22 20:45:25','2013-04-22 20:45:25',8,'active'),(305,31,'initiation','2013-04-22 20:45:25','2013-04-22 20:45:25',8,'active'),(306,32,'initiation','2013-04-22 20:45:25','2013-04-22 20:45:25',8,'active'),(307,26,'ontrip','2013-05-01 14:00:00','2013-05-02 20:00:00',3,'active'),(308,27,'ontrip','2013-05-01 15:30:00','2013-05-02 21:30:00',3,'active'),(309,30,'ontrip','2013-05-01 10:30:00','2013-05-02 16:30:00',3,'active'),(310,28,'ontrip','2013-04-29 09:00:00','2013-04-30 15:00:00',3,'active'),(311,31,'ontrip','2013-04-29 14:00:00','2013-04-30 20:00:00',3,'active'),(312,32,'ontrip','2013-04-29 17:00:00','2013-04-30 23:00:00',3,'active'),(313,28,'ontrip','2013-04-30 17:00:00','2013-05-01 23:00:00',8,'active'),(314,31,'ontrip','2013-05-01 08:00:00','2013-05-02 14:00:00',8,'active'),(315,32,'ontrip','2013-05-01 14:00:00','2013-05-02 20:00:00',8,'active'),(316,24,'ontrip','2013-05-02 08:00:00','2013-05-03 14:00:00',8,'active'),(317,17,'ontrip','2013-05-02 14:00:00','2013-05-03 20:00:00',8,'active'),(318,19,'ontrip','2013-05-02 17:00:00','2013-05-03 23:00:00',8,'active'),(319,26,'ontrip','2013-05-03 08:00:00','2013-05-04 14:00:00',8,'active'),(320,27,'ontrip','2013-05-03 09:00:00','2013-05-04 15:00:00',8,'active'),(321,30,'ontrip','2013-05-03 17:00:00','2013-05-04 23:00:00',8,'active'),(322,28,'ontrip','2013-05-03 07:30:00','2013-05-04 13:30:00',3,'active'),(323,31,'ontrip','2013-05-03 11:00:00','2013-05-04 17:00:00',3,'active'),(324,32,'ontrip','2013-05-03 14:01:00','2013-05-04 20:01:00',3,'active'),(325,24,'ontrip','2013-05-04 07:00:00','2013-05-05 13:00:00',3,'active'),(326,17,'ontrip','2013-05-04 11:00:00','2013-05-05 17:00:00',3,'active'),(327,19,'ontrip','2013-05-04 17:00:00','2013-05-05 23:00:00',3,'active'),(328,26,'ontrip','2013-05-05 07:00:00','2013-05-06 13:00:00',3,'active'),(329,27,'ontrip','2013-05-05 11:00:00','2013-05-06 17:00:00',3,'active'),(330,30,'ontrip','2013-05-05 14:00:00','2013-05-06 20:00:00',3,'active'),(331,31,'ontrip','2013-05-04 18:00:00','2013-05-06 00:00:00',8,'active'),(332,28,'ontrip','2013-05-04 19:00:00','2013-05-06 01:00:00',8,'active'),(333,24,'ontrip','2013-05-05 14:00:00','2013-05-06 20:00:00',8,'active'),(334,17,'ontrip','2013-05-05 18:00:00','2013-05-07 00:00:00',8,'active'),(335,32,'ontrip','2013-05-05 19:00:00','2013-05-07 01:00:00',8,'active'),(336,19,'ontrip','2013-05-06 11:00:00','2013-05-07 17:00:00',8,'active'),(337,28,'ontrip','2013-05-06 07:00:00','2013-05-07 13:00:00',3,'active'),(338,31,'ontrip','2013-05-06 11:00:00','2013-05-07 17:00:00',3,'active'),(339,24,'ontrip','2013-05-07 07:00:00','2013-05-08 13:00:00',3,'active'),(340,17,'ontrip','2013-05-07 17:00:00','2013-05-08 23:00:00',3,'active'),(341,32,'ontrip','2013-05-07 14:00:00','2013-05-08 20:00:00',3,'active'),(342,30,'ontrip','2013-05-06 21:00:00','2013-05-08 03:00:00',8,'active'),(343,26,'ontrip','2013-05-07 14:00:00','2013-05-08 20:00:00',8,'active'),(344,27,'ontrip','2013-05-07 10:00:00','2013-05-08 16:00:00',8,'active'),(345,24,'ontrip','2013-05-08 14:00:00','2013-05-09 20:00:00',8,'active'),(346,28,'ontrip','2013-05-08 08:00:00','2013-05-09 14:00:00',8,'active'),(347,31,'ontrip','2013-05-08 19:00:00','2013-05-10 01:00:00',8,'active'),(348,17,'ontrip','2013-05-09 09:00:00','2013-05-10 15:00:00',8,'active'),(349,32,'ontrip','2013-05-09 14:00:00','2013-05-10 20:00:00',8,'active'),(350,19,'ontrip','2013-05-08 14:30:00','2013-05-09 20:30:00',3,'active'),(351,30,'ontrip','2013-05-08 18:30:00','2013-05-10 00:30:00',3,'active'),(352,26,'ontrip','2013-05-09 08:30:00','2013-05-10 14:30:00',3,'active'),(353,27,'ontrip','2013-05-09 10:30:00','2013-05-10 16:30:00',3,'active'),(354,24,'ontrip','2013-05-10 08:30:00','2013-05-11 14:30:00',3,'active'),(355,28,'ontrip','2013-05-10 14:00:00','2013-05-11 20:00:00',3,'active'),(356,17,'ontrip','2013-05-10 16:30:00','2013-05-11 22:30:00',3,'active'),(357,31,'ontrip','2013-05-11 10:00:00','2013-05-12 16:00:00',3,'active'),(358,32,'ontrip','2013-05-11 19:00:00','2013-05-13 01:00:00',3,'active'),(359,19,'ontrip','2013-05-10 07:30:00','2013-05-11 13:30:00',8,'active'),(360,30,'ontrip','2013-05-10 17:30:00','2013-05-11 23:30:00',8,'active'),(361,26,'ontrip','2013-05-11 07:30:00','2013-05-12 13:30:00',8,'active'),(362,27,'ontrip','2013-05-11 10:30:00','2013-05-12 16:30:00',8,'active'),(363,24,'ontrip','2013-05-12 08:30:00','2013-05-13 14:30:00',8,'active'),(364,28,'ontrip','2013-05-12 11:30:00','2013-05-13 17:30:00',8,'active'),(365,17,'ontrip','2013-05-13 10:30:00','2013-05-14 16:30:00',8,'active'),(366,31,'ontrip','2013-05-13 07:30:00','2013-05-14 13:30:00',8,'active'),(367,32,'ontrip','2013-05-13 17:30:00','2013-05-14 23:30:00',8,'active'),(368,19,'ontrip','2013-05-12 08:30:00','2013-05-13 14:30:00',3,'active'),(369,26,'ontrip','2013-05-12 14:30:00','2013-05-13 20:30:00',3,'active'),(370,27,'ontrip','2013-05-13 07:30:00','2013-05-14 13:30:00',3,'active'),(371,30,'ontrip','2013-05-13 14:30:00','2013-05-14 20:30:00',3,'active'),(372,24,'ontrip','2013-05-13 17:30:00','2013-05-14 23:30:00',3,'active'),(373,28,'ontrip','2013-05-14 07:30:00','2013-05-15 13:30:00',3,'active'),(374,31,'ontrip','2013-05-14 14:30:00','2013-05-15 20:30:00',3,'active'),(375,17,'ontrip','2013-05-15 10:30:00','2013-05-16 16:30:00',3,'active'),(376,32,'ontrip','2013-05-15 15:20:00','2013-05-16 21:20:00',3,'active'),(377,24,'ontrip','2013-05-15 07:30:00','2013-05-16 13:30:00',8,'active'),(378,26,'ontrip','2013-05-14 07:30:00','2013-05-15 13:30:00',8,'active'),(379,19,'ontrip','2013-05-14 10:30:00','2013-05-15 16:30:00',8,'active'),(380,27,'ontrip','2013-05-15 14:30:00','2013-05-16 20:30:00',8,'active'),(381,30,'ontrip','2013-05-15 17:30:00','2013-05-16 23:30:00',8,'active'),(382,28,'ontrip','2013-05-16 07:30:00','2013-05-17 13:30:00',8,'active'),(383,31,'ontrip','2013-05-16 14:30:00','2013-05-17 20:30:00',8,'active'),(384,17,'ontrip','2013-05-16 17:30:00','2013-05-17 23:30:00',8,'active'),(385,32,'ontrip','2013-05-17 14:30:00','2013-05-18 20:30:00',8,'active'),(386,26,'ontrip','2013-05-16 07:00:00','2013-05-17 13:00:00',3,'active'),(387,19,'ontrip','2013-05-16 10:30:00','2013-05-17 16:30:00',3,'active'),(388,24,'ontrip','2013-05-17 06:30:00','2013-05-18 12:30:00',3,'active'),(389,30,'ontrip','2013-05-17 14:30:00','2013-05-18 20:30:00',3,'active'),(390,27,'ontrip','2013-05-17 17:00:00','2013-05-18 23:00:00',3,'active'),(391,28,'ontrip','2013-05-18 07:00:00','2013-05-19 13:00:00',3,'active'),(392,17,'ontrip','2013-05-18 09:00:00','2013-05-19 15:00:00',3,'active'),(393,31,'ontrip','2013-05-19 07:30:00','2013-05-20 13:30:00',3,'active'),(394,32,'ontrip','2013-05-18 21:30:00','2013-05-20 03:30:00',3,'active'),(395,26,'ontrip','2013-05-18 07:30:00','2013-05-19 13:30:00',8,'active'),(396,19,'ontrip','2013-05-18 14:30:00','2013-05-19 20:30:00',8,'active'),(397,24,'ontrip','2013-05-18 15:00:00','2013-05-19 21:00:00',8,'active'),(398,27,'ontrip','2013-05-19 06:00:00','2013-05-20 12:00:00',8,'active'),(399,30,'ontrip','2013-05-19 09:30:00','2013-05-20 15:30:00',8,'active'),(400,28,'ontrip','2013-05-20 11:00:00','2013-05-21 17:00:00',8,'active'),(401,17,'ontrip','2013-05-20 14:00:00','2013-05-21 20:00:00',8,'active'),(402,31,'ontrip','2013-05-20 17:00:00','2013-05-21 23:00:00',8,'active'),(403,24,'ontrip','2013-05-20 18:00:00','2013-05-22 00:00:00',3,'active'),(404,26,'ontrip','2013-05-20 15:30:00','2013-05-21 21:30:00',3,'active'),(405,18,'initiation','2013-04-22 21:42:48','2013-04-22 21:42:48',3,'active'),(406,25,'initiation','2013-04-22 21:42:48','2013-04-22 21:42:48',3,'active'),(407,18,'ontrip','2013-05-12 06:30:00','2013-05-13 14:30:00',8,'active'),(408,25,'ontrip','2013-05-13 06:30:00','2013-05-14 14:30:00',8,'active'),(409,22,'ontrip','2013-05-13 07:30:00','2013-05-14 15:30:00',3,'active'),(410,23,'ontrip','2013-05-14 07:30:00','2013-05-15 15:30:00',3,'active'),(411,18,'ontrip','2013-05-15 07:30:00','2013-05-16 15:30:00',3,'active'),(412,25,'ontrip','2013-05-17 07:30:00','2013-05-18 15:30:00',3,'active'),(413,22,'ontrip','2013-05-15 10:30:00','2013-05-16 18:30:00',8,'active'),(414,23,'ontrip','2013-05-16 07:30:00','2013-05-17 15:30:00',8,'active');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
INSERT INTO `location` VALUES (4,'Hà Nội',21.03,105.84),(8,'TP. Hồ Chí Minh',10.78,106.69),(20,'Lào Cai',22.5,103.96),(25,'Lạng Sơn',21.86,106.76),(29,'Yên Bái',21.71,104.87),(31,'Hải Phòng',20.85,106.6833),(37,'Thanh Hoá',19.81,105.78),(38,'Nghệ An',19.3333,104.8333),(39,'Hà Tĩnh',18.37,105.9),(52,'Quảng Bình',17.46906,106.59984),(54,'Thừa Thiên Huế',16.48,107.58),(55,'Quảng Ngãi',15.12,108.81),(56,'Bình Định',14.1667,109),(58,'Vạn Giã',12.25,109.2),(59,'Gia Lai',13.9833,108),(61,'Đồng Nai',11.116666666666667,107.18333333333334),(62,'Bình Thuận',10.933333333333334,108.1),(63,'Lâm Đồng',11.9417,108.4383),(64,'Vũng Tàu',10.416666666666666,107.16805555555555),(66,'Tây Ninh',11.3,106.1),(72,'Long An',10.666666666666666,106.16666666666667),(75,'Bến Tre',10.2333,106.3833),(76,'An Giang',10.5,105.16666666666667),(500,'Đăk Lăk',12.667,108.05),(511,'Đà Nẵng',16.0667,108.2333),(512,'Bà Rịa',10.35,107.25),(513,'Nha Trang',12.25,109.1833);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (17,35,1000.5,0,1,'tram','pay'),(18,36,800,0,1,'tram','pay');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (24,3,'7VCIXV','2013-04-22 20:57:52','paid','Truong','Nguyen','','truongns@live.com');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (3,'Hà Nội - TP. Hồ Chí Minh','active'),(4,'TP. Hồ Chí Minh - Hà Nội','active'),(5,'TP. Hồ Chí Minh - Hà Nội','active'),(6,'Hà Nội - TP. Hồ Chí Minh','active');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_details`
--

LOCK TABLES `route_details` WRITE;
/*!40000 ALTER TABLE `route_details` DISABLE KEYS */;
INSERT INTO `route_details` VALUES (21,21,3),(22,22,3),(23,23,3),(24,24,3),(25,25,3),(26,26,4),(27,27,4),(28,28,4),(29,29,4),(30,30,4),(31,31,5),(32,32,5),(33,33,5),(34,34,5),(35,35,6),(36,36,6),(37,37,6),(38,38,6);
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
INSERT INTO `seat_position` VALUES (35,'A1','active'),(35,'A2','active'),(35,'B1','active'),(35,'D1','active'),(35,'E1','active'),(36,'A1','active'),(36,'A2','active'),(36,'B1','active'),(36,'B2','active');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment`
--

LOCK TABLES `segment` WRITE;
/*!40000 ALTER TABLE `segment` DISABLE KEYS */;
INSERT INTO `segment` VALUES (26,3,35),(31,3,38),(28,5,7),(24,5,35),(23,7,5),(29,7,29),(21,8,29),(35,8,30),(22,29,7),(30,29,8),(34,30,8),(36,30,39),(25,35,3),(27,35,5),(38,38,3),(32,38,39),(33,39,30),(37,39,38);
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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment_travel_time`
--

LOCK TABLES `segment_travel_time` WRITE;
/*!40000 ALTER TABLE `segment_travel_time` DISABLE KEYS */;
INSERT INTO `segment_travel_time` VALUES (41,21,9000000,'2013-04-17 12:19:47'),(42,22,30600000,'2013-04-17 12:19:47'),(43,23,7200000,'2013-04-17 12:19:47'),(44,24,46800000,'2013-04-17 12:19:47'),(45,25,14400000,'2013-04-17 12:19:47'),(46,26,14400000,'2013-04-17 12:19:47'),(47,27,46800000,'2013-04-17 12:19:47'),(48,28,7200000,'2013-04-17 12:19:47'),(49,29,30600000,'2013-04-17 12:19:47'),(50,30,9000000,'2013-04-17 12:19:47'),(51,31,23400000,'2013-04-22 20:37:47'),(52,32,12600000,'2013-04-22 20:37:47'),(53,33,36000000,'2013-04-22 20:37:47'),(54,34,30600000,'2013-04-22 20:37:47'),(55,35,30600000,'2013-04-22 20:37:47'),(56,36,36000000,'2013-04-22 20:37:47'),(57,37,12600000,'2013-04-22 20:37:47'),(58,38,23400000,'2013-04-22 20:37:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Bến xe Hà Tĩnh',39,'Hà Tĩnh','active'),(2,'Bến xe Bến Tre',75,'Bến Tre','active'),(3,'Bến xe Miền Đông',8,'TP. Hồ Chí Minh','active'),(5,'Bến xe Đà Nẵng',511,'Đà Nẵng','active'),(6,'Bến xe Hải Phòng',31,'Hải Phòng','active'),(7,'Bến xe Huế',54,'Thừa Thiên Huế','active'),(8,'Bến xe Hà Nội',4,'Hà Nội','active'),(9,'Bến xe Lào Cai',20,'Lào Cai','active'),(10,'Bến xe Lạng Sơn',25,'Lạng Sơn','active'),(11,'Bến xe Yên Bái',29,'Yên Bái','active'),(12,'Bến xe Đồng Nai',61,'Đồng Nai','active'),(13,'Bến xe Lâm Đồng',63,'Lâm Đồng','active'),(14,'Bến xe Vũng Tàu',64,'Vũng Tàu','active'),(15,'Bến xe Tây Ninh',66,'Tây Ninh','active'),(16,'Bến xe Long An',72,'Long An','active'),(17,'Bến xe An Giang',76,'An Giang','active'),(28,'Bến xe Vinh',38,'Vinh','active'),(29,'Bến xe Thanh Hoá',37,'Thanh Hoá','active'),(30,'Bến xe Đồng Hới',52,'Quảng Bình','active'),(31,'Bến xe Quảng Ngãi',55,'Quảng Ngãi','active'),(32,'Bến xe Quy Nhơn',56,'Quy Nhơn','active'),(33,'Bến xe Vạn Giã',58,'Vạn Giã','active'),(34,'Bến xe Nha Trang',513,'Nha Trang','active'),(35,'Bến xe Phan Thiết',62,'Phan Thiết','active'),(36,'Bến xe Bà Rịa',512,'Bà Rịa','active'),(37,'Bến xe Đà Lạt',63,'Đà Lạt','active'),(38,'Bến xe Buôn Ma Thuột',500,'Đăk Lăk','active'),(39,'Bến xe Pleiku',59,'Gia Lai','active'),(40,'Bến xe Miền Tây',8,'TP. Hồ Chí Minh','active');
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
INSERT INTO `system_setting` VALUES ('maximum.segment.in.route','5'),('minimum.segment.traveltime','3600000'),('refund.1.rate','70'),('refund.1.time','10'),('refund.2.rate','30'),('refund.2.time','5'),('reservation.timeout','15'),('segment.default.price','50'),('station.delay','30');
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (35,21,1,'2013-04-17 00:00:00',90),(36,21,2,'2013-04-17 00:00:00',125),(37,22,1,'2013-04-17 00:00:00',210),(38,22,2,'2013-04-17 00:00:00',300),(39,23,1,'2013-04-17 00:00:00',70),(40,23,2,'2013-04-17 00:00:00',100),(41,24,1,'2013-04-17 00:00:00',315),(42,24,2,'2013-04-17 00:00:00',450),(43,25,1,'2013-04-17 00:00:00',105),(44,25,2,'2013-04-17 00:00:00',150),(45,26,1,'2013-04-17 00:00:00',105),(46,26,2,'2013-04-17 00:00:00',150),(47,27,1,'2013-04-17 00:00:00',315),(48,27,2,'2013-04-17 00:00:00',450),(49,28,1,'2013-04-17 00:00:00',70),(50,28,2,'2013-04-17 00:00:00',100),(51,29,1,'2013-04-17 00:00:00',210),(52,29,2,'2013-04-17 00:00:00',300),(53,30,1,'2013-04-17 00:00:00',90),(54,30,2,'2013-04-17 00:00:00',125),(55,31,1,'2013-04-22 00:00:00',200),(56,31,2,'2013-04-22 00:00:00',250),(57,32,1,'2013-04-22 00:00:00',100),(58,32,2,'2013-04-22 00:00:00',150),(59,33,1,'2013-04-22 00:00:00',350),(60,33,2,'2013-04-22 00:00:00',400),(61,34,1,'2013-04-22 00:00:00',250),(62,34,2,'2013-04-22 00:00:00',300),(63,35,1,'2013-04-22 00:00:00',250),(64,35,2,'2013-04-22 00:00:00',300),(65,36,1,'2013-04-22 00:00:00',350),(66,36,2,'2013-04-22 00:00:00',400),(67,37,1,'2013-04-22 00:00:00',100),(68,37,2,'2013-04-22 00:00:00',150),(69,38,1,'2013-04-22 00:00:00',200),(70,38,2,'2013-04-22 00:00:00',250);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (35,24,'active'),(36,24,'active');
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
) ENGINE=InnoDB AUTO_INCREMENT=2331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1827,278,21,'2013-04-18 00:40:00','2013-04-18 03:10:00'),(1828,278,22,'2013-04-18 03:40:00','2013-04-18 12:10:00'),(1829,278,23,'2013-04-18 12:40:00','2013-04-18 14:40:00'),(1830,278,24,'2013-04-18 15:10:00','2013-04-19 04:10:00'),(1831,278,25,'2013-04-19 04:40:00','2013-04-19 08:40:00'),(1832,280,21,'2013-04-21 06:00:00','2013-04-21 08:30:00'),(1833,280,22,'2013-04-21 09:00:00','2013-04-21 17:30:00'),(1834,280,23,'2013-04-21 18:00:00','2013-04-21 20:00:00'),(1835,280,24,'2013-04-21 20:30:00','2013-04-22 09:30:00'),(1836,280,25,'2013-04-22 10:00:00','2013-04-22 14:00:00'),(1837,281,21,'2013-04-19 00:00:00','2013-04-19 02:30:00'),(1838,281,22,'2013-04-19 03:00:00','2013-04-19 11:30:00'),(1839,281,23,'2013-04-19 12:00:00','2013-04-19 14:00:00'),(1840,281,24,'2013-04-19 14:30:00','2013-04-20 03:30:00'),(1841,281,25,'2013-04-20 04:00:00','2013-04-20 08:00:00'),(1842,282,21,'2013-04-18 00:36:00','2013-04-18 03:06:00'),(1843,282,22,'2013-04-18 03:36:00','2013-04-18 12:06:00'),(1844,282,23,'2013-04-18 12:36:00','2013-04-18 14:36:00'),(1845,282,24,'2013-04-18 15:06:00','2013-04-19 04:06:00'),(1846,282,25,'2013-04-19 04:36:00','2013-04-19 08:36:00'),(1847,283,26,'2013-04-22 00:00:00','2013-04-22 04:00:00'),(1848,283,27,'2013-04-22 04:30:00','2013-04-22 17:30:00'),(1849,283,28,'2013-04-22 18:00:00','2013-04-22 20:00:00'),(1850,283,29,'2013-04-22 20:30:00','2013-04-23 05:00:00'),(1851,283,30,'2013-04-23 05:30:00','2013-04-23 08:00:00'),(1852,284,26,'2013-04-20 00:00:00','2013-04-20 04:00:00'),(1853,284,27,'2013-04-20 04:30:00','2013-04-20 17:30:00'),(1854,284,28,'2013-04-20 18:00:00','2013-04-20 20:00:00'),(1855,284,29,'2013-04-20 20:30:00','2013-04-21 05:00:00'),(1856,284,30,'2013-04-21 05:30:00','2013-04-21 08:00:00'),(1857,287,21,'2013-05-15 00:00:00','2013-05-15 02:30:00'),(1858,287,22,'2013-05-15 03:00:00','2013-05-15 11:30:00'),(1859,287,23,'2013-05-15 12:00:00','2013-05-15 14:00:00'),(1860,287,24,'2013-05-15 14:30:00','2013-05-16 03:30:00'),(1861,287,25,'2013-05-16 04:00:00','2013-05-16 08:00:00'),(1862,289,21,'2013-05-20 00:00:00','2013-05-20 02:30:00'),(1863,289,22,'2013-05-20 03:00:00','2013-05-20 11:30:00'),(1864,289,23,'2013-05-20 12:00:00','2013-05-20 14:00:00'),(1865,289,24,'2013-05-20 14:30:00','2013-05-21 03:30:00'),(1866,289,25,'2013-05-21 04:00:00','2013-05-21 08:00:00'),(1867,290,21,'2013-05-16 00:50:00','2013-05-16 03:20:00'),(1868,290,22,'2013-05-16 03:50:00','2013-05-16 12:20:00'),(1869,290,23,'2013-05-16 12:50:00','2013-05-16 14:50:00'),(1870,290,24,'2013-05-16 15:20:00','2013-05-17 04:20:00'),(1871,290,25,'2013-05-17 04:50:00','2013-05-17 08:50:00'),(1872,291,21,'2013-05-18 14:00:00','2013-05-18 16:30:00'),(1873,291,22,'2013-05-18 17:00:00','2013-05-19 01:30:00'),(1874,291,23,'2013-05-19 02:00:00','2013-05-19 04:00:00'),(1875,291,24,'2013-05-19 04:30:00','2013-05-19 17:30:00'),(1876,291,25,'2013-05-19 18:00:00','2013-05-19 22:00:00'),(1877,292,26,'2013-05-17 00:00:00','2013-05-17 04:00:00'),(1878,292,27,'2013-05-17 04:30:00','2013-05-17 17:30:00'),(1879,292,28,'2013-05-17 18:00:00','2013-05-17 20:00:00'),(1880,292,29,'2013-05-17 20:30:00','2013-05-18 05:00:00'),(1881,292,30,'2013-05-18 05:30:00','2013-05-18 08:00:00'),(1882,293,26,'2013-05-18 00:00:00','2013-05-18 04:00:00'),(1883,293,27,'2013-05-18 04:30:00','2013-05-18 17:30:00'),(1884,293,28,'2013-05-18 18:00:00','2013-05-18 20:00:00'),(1885,293,29,'2013-05-18 20:30:00','2013-05-19 05:00:00'),(1886,293,30,'2013-05-19 05:30:00','2013-05-19 08:00:00'),(1887,298,35,'2013-04-30 14:00:00','2013-04-30 22:30:00'),(1888,298,36,'2013-04-30 23:00:00','2013-05-01 09:00:00'),(1889,298,37,'2013-05-01 09:30:00','2013-05-01 13:00:00'),(1890,298,38,'2013-05-01 13:30:00','2013-05-01 20:00:00'),(1891,299,35,'2013-04-30 08:00:00','2013-04-30 16:30:00'),(1892,299,36,'2013-04-30 17:00:00','2013-05-01 03:00:00'),(1893,299,37,'2013-05-01 03:30:00','2013-05-01 07:00:00'),(1894,299,38,'2013-05-01 07:30:00','2013-05-01 14:00:00'),(1895,300,35,'2013-04-30 10:00:00','2013-04-30 18:30:00'),(1896,300,36,'2013-04-30 19:00:00','2013-05-01 05:00:00'),(1897,300,37,'2013-05-01 05:30:00','2013-05-01 09:00:00'),(1898,300,38,'2013-05-01 09:30:00','2013-05-01 16:00:00'),(1899,307,35,'2013-05-01 14:00:00','2013-05-01 22:30:00'),(1900,307,36,'2013-05-01 23:00:00','2013-05-02 09:00:00'),(1901,307,37,'2013-05-02 09:30:00','2013-05-02 13:00:00'),(1902,307,38,'2013-05-02 13:30:00','2013-05-02 20:00:00'),(1903,308,35,'2013-05-01 15:30:00','2013-05-02 00:00:00'),(1904,308,36,'2013-05-02 00:30:00','2013-05-02 10:30:00'),(1905,308,37,'2013-05-02 11:00:00','2013-05-02 14:30:00'),(1906,308,38,'2013-05-02 15:00:00','2013-05-02 21:30:00'),(1907,309,35,'2013-05-01 10:30:00','2013-05-01 19:00:00'),(1908,309,36,'2013-05-01 19:30:00','2013-05-02 05:30:00'),(1909,309,37,'2013-05-02 06:00:00','2013-05-02 09:30:00'),(1910,309,38,'2013-05-02 10:00:00','2013-05-02 16:30:00'),(1911,310,35,'2013-04-29 09:00:00','2013-04-29 17:30:00'),(1912,310,36,'2013-04-29 18:00:00','2013-04-30 04:00:00'),(1913,310,37,'2013-04-30 04:30:00','2013-04-30 08:00:00'),(1914,310,38,'2013-04-30 08:30:00','2013-04-30 15:00:00'),(1915,311,35,'2013-04-29 14:00:00','2013-04-29 22:30:00'),(1916,311,36,'2013-04-29 23:00:00','2013-04-30 09:00:00'),(1917,311,37,'2013-04-30 09:30:00','2013-04-30 13:00:00'),(1918,311,38,'2013-04-30 13:30:00','2013-04-30 20:00:00'),(1919,312,35,'2013-04-29 17:00:00','2013-04-30 01:30:00'),(1920,312,36,'2013-04-30 02:00:00','2013-04-30 12:00:00'),(1921,312,37,'2013-04-30 12:30:00','2013-04-30 16:00:00'),(1922,312,38,'2013-04-30 16:30:00','2013-04-30 23:00:00'),(1923,313,31,'2013-04-30 17:00:00','2013-04-30 23:30:00'),(1924,313,32,'2013-05-01 00:00:00','2013-05-01 03:30:00'),(1925,313,33,'2013-05-01 04:00:00','2013-05-01 14:00:00'),(1926,313,34,'2013-05-01 14:30:00','2013-05-01 23:00:00'),(1927,314,31,'2013-05-01 08:00:00','2013-05-01 14:30:00'),(1928,314,32,'2013-05-01 15:00:00','2013-05-01 18:30:00'),(1929,314,33,'2013-05-01 19:00:00','2013-05-02 05:00:00'),(1930,314,34,'2013-05-02 05:30:00','2013-05-02 14:00:00'),(1931,315,31,'2013-05-01 14:00:00','2013-05-01 20:30:00'),(1932,315,32,'2013-05-01 21:00:00','2013-05-02 00:30:00'),(1933,315,33,'2013-05-02 01:00:00','2013-05-02 11:00:00'),(1934,315,34,'2013-05-02 11:30:00','2013-05-02 20:00:00'),(1935,316,31,'2013-05-02 08:00:00','2013-05-02 14:30:00'),(1936,316,32,'2013-05-02 15:00:00','2013-05-02 18:30:00'),(1937,316,33,'2013-05-02 19:00:00','2013-05-03 05:00:00'),(1938,316,34,'2013-05-03 05:30:00','2013-05-03 14:00:00'),(1939,317,31,'2013-05-02 14:00:00','2013-05-02 20:30:00'),(1940,317,32,'2013-05-02 21:00:00','2013-05-03 00:30:00'),(1941,317,33,'2013-05-03 01:00:00','2013-05-03 11:00:00'),(1942,317,34,'2013-05-03 11:30:00','2013-05-03 20:00:00'),(1943,318,31,'2013-05-02 17:00:00','2013-05-02 23:30:00'),(1944,318,32,'2013-05-03 00:00:00','2013-05-03 03:30:00'),(1945,318,33,'2013-05-03 04:00:00','2013-05-03 14:00:00'),(1946,318,34,'2013-05-03 14:30:00','2013-05-03 23:00:00'),(1947,319,31,'2013-05-03 08:00:00','2013-05-03 14:30:00'),(1948,319,32,'2013-05-03 15:00:00','2013-05-03 18:30:00'),(1949,319,33,'2013-05-03 19:00:00','2013-05-04 05:00:00'),(1950,319,34,'2013-05-04 05:30:00','2013-05-04 14:00:00'),(1951,320,31,'2013-05-03 09:00:00','2013-05-03 15:30:00'),(1952,320,32,'2013-05-03 16:00:00','2013-05-03 19:30:00'),(1953,320,33,'2013-05-03 20:00:00','2013-05-04 06:00:00'),(1954,320,34,'2013-05-04 06:30:00','2013-05-04 15:00:00'),(1955,321,31,'2013-05-03 17:00:00','2013-05-03 23:30:00'),(1956,321,32,'2013-05-04 00:00:00','2013-05-04 03:30:00'),(1957,321,33,'2013-05-04 04:00:00','2013-05-04 14:00:00'),(1958,321,34,'2013-05-04 14:30:00','2013-05-04 23:00:00'),(1959,322,35,'2013-05-03 07:30:00','2013-05-03 16:00:00'),(1960,322,36,'2013-05-03 16:30:00','2013-05-04 02:30:00'),(1961,322,37,'2013-05-04 03:00:00','2013-05-04 06:30:00'),(1962,322,38,'2013-05-04 07:00:00','2013-05-04 13:30:00'),(1963,323,35,'2013-05-03 11:00:00','2013-05-03 19:30:00'),(1964,323,36,'2013-05-03 20:00:00','2013-05-04 06:00:00'),(1965,323,37,'2013-05-04 06:30:00','2013-05-04 10:00:00'),(1966,323,38,'2013-05-04 10:30:00','2013-05-04 17:00:00'),(1967,324,35,'2013-05-03 14:01:00','2013-05-03 22:31:00'),(1968,324,36,'2013-05-03 23:01:00','2013-05-04 09:01:00'),(1969,324,37,'2013-05-04 09:31:00','2013-05-04 13:01:00'),(1970,324,38,'2013-05-04 13:31:00','2013-05-04 20:01:00'),(1971,325,35,'2013-05-04 07:00:00','2013-05-04 15:30:00'),(1972,325,36,'2013-05-04 16:00:00','2013-05-05 02:00:00'),(1973,325,37,'2013-05-05 02:30:00','2013-05-05 06:00:00'),(1974,325,38,'2013-05-05 06:30:00','2013-05-05 13:00:00'),(1975,326,35,'2013-05-04 11:00:00','2013-05-04 19:30:00'),(1976,326,36,'2013-05-04 20:00:00','2013-05-05 06:00:00'),(1977,326,37,'2013-05-05 06:30:00','2013-05-05 10:00:00'),(1978,326,38,'2013-05-05 10:30:00','2013-05-05 17:00:00'),(1979,327,35,'2013-05-04 17:00:00','2013-05-05 01:30:00'),(1980,327,36,'2013-05-05 02:00:00','2013-05-05 12:00:00'),(1981,327,37,'2013-05-05 12:30:00','2013-05-05 16:00:00'),(1982,327,38,'2013-05-05 16:30:00','2013-05-05 23:00:00'),(1983,328,35,'2013-05-05 07:00:00','2013-05-05 15:30:00'),(1984,328,36,'2013-05-05 16:00:00','2013-05-06 02:00:00'),(1985,328,37,'2013-05-06 02:30:00','2013-05-06 06:00:00'),(1986,328,38,'2013-05-06 06:30:00','2013-05-06 13:00:00'),(1987,329,35,'2013-05-05 11:00:00','2013-05-05 19:30:00'),(1988,329,36,'2013-05-05 20:00:00','2013-05-06 06:00:00'),(1989,329,37,'2013-05-06 06:30:00','2013-05-06 10:00:00'),(1990,329,38,'2013-05-06 10:30:00','2013-05-06 17:00:00'),(1991,330,35,'2013-05-05 14:00:00','2013-05-05 22:30:00'),(1992,330,36,'2013-05-05 23:00:00','2013-05-06 09:00:00'),(1993,330,37,'2013-05-06 09:30:00','2013-05-06 13:00:00'),(1994,330,38,'2013-05-06 13:30:00','2013-05-06 20:00:00'),(1995,331,31,'2013-05-04 18:00:00','2013-05-05 00:30:00'),(1996,331,32,'2013-05-05 01:00:00','2013-05-05 04:30:00'),(1997,331,33,'2013-05-05 05:00:00','2013-05-05 15:00:00'),(1998,331,34,'2013-05-05 15:30:00','2013-05-06 00:00:00'),(1999,332,31,'2013-05-04 19:00:00','2013-05-05 01:30:00'),(2000,332,32,'2013-05-05 02:00:00','2013-05-05 05:30:00'),(2001,332,33,'2013-05-05 06:00:00','2013-05-05 16:00:00'),(2002,332,34,'2013-05-05 16:30:00','2013-05-06 01:00:00'),(2003,333,31,'2013-05-05 14:00:00','2013-05-05 20:30:00'),(2004,333,32,'2013-05-05 21:00:00','2013-05-06 00:30:00'),(2005,333,33,'2013-05-06 01:00:00','2013-05-06 11:00:00'),(2006,333,34,'2013-05-06 11:30:00','2013-05-06 20:00:00'),(2007,334,31,'2013-05-05 18:00:00','2013-05-06 00:30:00'),(2008,334,32,'2013-05-06 01:00:00','2013-05-06 04:30:00'),(2009,334,33,'2013-05-06 05:00:00','2013-05-06 15:00:00'),(2010,334,34,'2013-05-06 15:30:00','2013-05-07 00:00:00'),(2011,335,31,'2013-05-05 19:00:00','2013-05-06 01:30:00'),(2012,335,32,'2013-05-06 02:00:00','2013-05-06 05:30:00'),(2013,335,33,'2013-05-06 06:00:00','2013-05-06 16:00:00'),(2014,335,34,'2013-05-06 16:30:00','2013-05-07 01:00:00'),(2015,336,31,'2013-05-06 11:00:00','2013-05-06 17:30:00'),(2016,336,32,'2013-05-06 18:00:00','2013-05-06 21:30:00'),(2017,336,33,'2013-05-06 22:00:00','2013-05-07 08:00:00'),(2018,336,34,'2013-05-07 08:30:00','2013-05-07 17:00:00'),(2019,337,35,'2013-05-06 07:00:00','2013-05-06 15:30:00'),(2020,337,36,'2013-05-06 16:00:00','2013-05-07 02:00:00'),(2021,337,37,'2013-05-07 02:30:00','2013-05-07 06:00:00'),(2022,337,38,'2013-05-07 06:30:00','2013-05-07 13:00:00'),(2023,338,35,'2013-05-06 11:00:00','2013-05-06 19:30:00'),(2024,338,36,'2013-05-06 20:00:00','2013-05-07 06:00:00'),(2025,338,37,'2013-05-07 06:30:00','2013-05-07 10:00:00'),(2026,338,38,'2013-05-07 10:30:00','2013-05-07 17:00:00'),(2027,339,35,'2013-05-07 07:00:00','2013-05-07 15:30:00'),(2028,339,36,'2013-05-07 16:00:00','2013-05-08 02:00:00'),(2029,339,37,'2013-05-08 02:30:00','2013-05-08 06:00:00'),(2030,339,38,'2013-05-08 06:30:00','2013-05-08 13:00:00'),(2031,340,35,'2013-05-07 17:00:00','2013-05-08 01:30:00'),(2032,340,36,'2013-05-08 02:00:00','2013-05-08 12:00:00'),(2033,340,37,'2013-05-08 12:30:00','2013-05-08 16:00:00'),(2034,340,38,'2013-05-08 16:30:00','2013-05-08 23:00:00'),(2035,341,35,'2013-05-07 14:00:00','2013-05-07 22:30:00'),(2036,341,36,'2013-05-07 23:00:00','2013-05-08 09:00:00'),(2037,341,37,'2013-05-08 09:30:00','2013-05-08 13:00:00'),(2038,341,38,'2013-05-08 13:30:00','2013-05-08 20:00:00'),(2039,342,31,'2013-05-06 21:00:00','2013-05-07 03:30:00'),(2040,342,32,'2013-05-07 04:00:00','2013-05-07 07:30:00'),(2041,342,33,'2013-05-07 08:00:00','2013-05-07 18:00:00'),(2042,342,34,'2013-05-07 18:30:00','2013-05-08 03:00:00'),(2043,343,31,'2013-05-07 14:00:00','2013-05-07 20:30:00'),(2044,343,32,'2013-05-07 21:00:00','2013-05-08 00:30:00'),(2045,343,33,'2013-05-08 01:00:00','2013-05-08 11:00:00'),(2046,343,34,'2013-05-08 11:30:00','2013-05-08 20:00:00'),(2047,344,31,'2013-05-07 10:00:00','2013-05-07 16:30:00'),(2048,344,32,'2013-05-07 17:00:00','2013-05-07 20:30:00'),(2049,344,33,'2013-05-07 21:00:00','2013-05-08 07:00:00'),(2050,344,34,'2013-05-08 07:30:00','2013-05-08 16:00:00'),(2051,345,31,'2013-05-08 14:00:00','2013-05-08 20:30:00'),(2052,345,32,'2013-05-08 21:00:00','2013-05-09 00:30:00'),(2053,345,33,'2013-05-09 01:00:00','2013-05-09 11:00:00'),(2054,345,34,'2013-05-09 11:30:00','2013-05-09 20:00:00'),(2055,346,31,'2013-05-08 08:00:00','2013-05-08 14:30:00'),(2056,346,32,'2013-05-08 15:00:00','2013-05-08 18:30:00'),(2057,346,33,'2013-05-08 19:00:00','2013-05-09 05:00:00'),(2058,346,34,'2013-05-09 05:30:00','2013-05-09 14:00:00'),(2059,347,31,'2013-05-08 19:00:00','2013-05-09 01:30:00'),(2060,347,32,'2013-05-09 02:00:00','2013-05-09 05:30:00'),(2061,347,33,'2013-05-09 06:00:00','2013-05-09 16:00:00'),(2062,347,34,'2013-05-09 16:30:00','2013-05-10 01:00:00'),(2063,348,31,'2013-05-09 09:00:00','2013-05-09 15:30:00'),(2064,348,32,'2013-05-09 16:00:00','2013-05-09 19:30:00'),(2065,348,33,'2013-05-09 20:00:00','2013-05-10 06:00:00'),(2066,348,34,'2013-05-10 06:30:00','2013-05-10 15:00:00'),(2067,349,31,'2013-05-09 14:00:00','2013-05-09 20:30:00'),(2068,349,32,'2013-05-09 21:00:00','2013-05-10 00:30:00'),(2069,349,33,'2013-05-10 01:00:00','2013-05-10 11:00:00'),(2070,349,34,'2013-05-10 11:30:00','2013-05-10 20:00:00'),(2071,350,35,'2013-05-08 14:30:00','2013-05-08 23:00:00'),(2072,350,36,'2013-05-08 23:30:00','2013-05-09 09:30:00'),(2073,350,37,'2013-05-09 10:00:00','2013-05-09 13:30:00'),(2074,350,38,'2013-05-09 14:00:00','2013-05-09 20:30:00'),(2075,351,35,'2013-05-08 18:30:00','2013-05-09 03:00:00'),(2076,351,36,'2013-05-09 03:30:00','2013-05-09 13:30:00'),(2077,351,37,'2013-05-09 14:00:00','2013-05-09 17:30:00'),(2078,351,38,'2013-05-09 18:00:00','2013-05-10 00:30:00'),(2079,352,35,'2013-05-09 08:30:00','2013-05-09 17:00:00'),(2080,352,36,'2013-05-09 17:30:00','2013-05-10 03:30:00'),(2081,352,37,'2013-05-10 04:00:00','2013-05-10 07:30:00'),(2082,352,38,'2013-05-10 08:00:00','2013-05-10 14:30:00'),(2083,353,35,'2013-05-09 10:30:00','2013-05-09 19:00:00'),(2084,353,36,'2013-05-09 19:30:00','2013-05-10 05:30:00'),(2085,353,37,'2013-05-10 06:00:00','2013-05-10 09:30:00'),(2086,353,38,'2013-05-10 10:00:00','2013-05-10 16:30:00'),(2087,354,35,'2013-05-10 08:30:00','2013-05-10 17:00:00'),(2088,354,36,'2013-05-10 17:30:00','2013-05-11 03:30:00'),(2089,354,37,'2013-05-11 04:00:00','2013-05-11 07:30:00'),(2090,354,38,'2013-05-11 08:00:00','2013-05-11 14:30:00'),(2091,355,35,'2013-05-10 14:00:00','2013-05-10 22:30:00'),(2092,355,36,'2013-05-10 23:00:00','2013-05-11 09:00:00'),(2093,355,37,'2013-05-11 09:30:00','2013-05-11 13:00:00'),(2094,355,38,'2013-05-11 13:30:00','2013-05-11 20:00:00'),(2095,356,35,'2013-05-10 16:30:00','2013-05-11 01:00:00'),(2096,356,36,'2013-05-11 01:30:00','2013-05-11 11:30:00'),(2097,356,37,'2013-05-11 12:00:00','2013-05-11 15:30:00'),(2098,356,38,'2013-05-11 16:00:00','2013-05-11 22:30:00'),(2099,357,35,'2013-05-11 10:00:00','2013-05-11 18:30:00'),(2100,357,36,'2013-05-11 19:00:00','2013-05-12 05:00:00'),(2101,357,37,'2013-05-12 05:30:00','2013-05-12 09:00:00'),(2102,357,38,'2013-05-12 09:30:00','2013-05-12 16:00:00'),(2103,358,35,'2013-05-11 19:00:00','2013-05-12 03:30:00'),(2104,358,36,'2013-05-12 04:00:00','2013-05-12 14:00:00'),(2105,358,37,'2013-05-12 14:30:00','2013-05-12 18:00:00'),(2106,358,38,'2013-05-12 18:30:00','2013-05-13 01:00:00'),(2107,359,31,'2013-05-10 07:30:00','2013-05-10 14:00:00'),(2108,359,32,'2013-05-10 14:30:00','2013-05-10 18:00:00'),(2109,359,33,'2013-05-10 18:30:00','2013-05-11 04:30:00'),(2110,359,34,'2013-05-11 05:00:00','2013-05-11 13:30:00'),(2111,360,31,'2013-05-10 17:30:00','2013-05-11 00:00:00'),(2112,360,32,'2013-05-11 00:30:00','2013-05-11 04:00:00'),(2113,360,33,'2013-05-11 04:30:00','2013-05-11 14:30:00'),(2114,360,34,'2013-05-11 15:00:00','2013-05-11 23:30:00'),(2115,361,31,'2013-05-11 07:30:00','2013-05-11 14:00:00'),(2116,361,32,'2013-05-11 14:30:00','2013-05-11 18:00:00'),(2117,361,33,'2013-05-11 18:30:00','2013-05-12 04:30:00'),(2118,361,34,'2013-05-12 05:00:00','2013-05-12 13:30:00'),(2119,362,31,'2013-05-11 10:30:00','2013-05-11 17:00:00'),(2120,362,32,'2013-05-11 17:30:00','2013-05-11 21:00:00'),(2121,362,33,'2013-05-11 21:30:00','2013-05-12 07:30:00'),(2122,362,34,'2013-05-12 08:00:00','2013-05-12 16:30:00'),(2123,363,31,'2013-05-12 08:30:00','2013-05-12 15:00:00'),(2124,363,32,'2013-05-12 15:30:00','2013-05-12 19:00:00'),(2125,363,33,'2013-05-12 19:30:00','2013-05-13 05:30:00'),(2126,363,34,'2013-05-13 06:00:00','2013-05-13 14:30:00'),(2127,364,31,'2013-05-12 11:30:00','2013-05-12 18:00:00'),(2128,364,32,'2013-05-12 18:30:00','2013-05-12 22:00:00'),(2129,364,33,'2013-05-12 22:30:00','2013-05-13 08:30:00'),(2130,364,34,'2013-05-13 09:00:00','2013-05-13 17:30:00'),(2131,365,31,'2013-05-13 10:30:00','2013-05-13 17:00:00'),(2132,365,32,'2013-05-13 17:30:00','2013-05-13 21:00:00'),(2133,365,33,'2013-05-13 21:30:00','2013-05-14 07:30:00'),(2134,365,34,'2013-05-14 08:00:00','2013-05-14 16:30:00'),(2135,366,31,'2013-05-13 07:30:00','2013-05-13 14:00:00'),(2136,366,32,'2013-05-13 14:30:00','2013-05-13 18:00:00'),(2137,366,33,'2013-05-13 18:30:00','2013-05-14 04:30:00'),(2138,366,34,'2013-05-14 05:00:00','2013-05-14 13:30:00'),(2139,367,31,'2013-05-13 17:30:00','2013-05-14 00:00:00'),(2140,367,32,'2013-05-14 00:30:00','2013-05-14 04:00:00'),(2141,367,33,'2013-05-14 04:30:00','2013-05-14 14:30:00'),(2142,367,34,'2013-05-14 15:00:00','2013-05-14 23:30:00'),(2143,368,35,'2013-05-12 08:30:00','2013-05-12 17:00:00'),(2144,368,36,'2013-05-12 17:30:00','2013-05-13 03:30:00'),(2145,368,37,'2013-05-13 04:00:00','2013-05-13 07:30:00'),(2146,368,38,'2013-05-13 08:00:00','2013-05-13 14:30:00'),(2147,369,35,'2013-05-12 14:30:00','2013-05-12 23:00:00'),(2148,369,36,'2013-05-12 23:30:00','2013-05-13 09:30:00'),(2149,369,37,'2013-05-13 10:00:00','2013-05-13 13:30:00'),(2150,369,38,'2013-05-13 14:00:00','2013-05-13 20:30:00'),(2151,370,35,'2013-05-13 07:30:00','2013-05-13 16:00:00'),(2152,370,36,'2013-05-13 16:30:00','2013-05-14 02:30:00'),(2153,370,37,'2013-05-14 03:00:00','2013-05-14 06:30:00'),(2154,370,38,'2013-05-14 07:00:00','2013-05-14 13:30:00'),(2155,371,35,'2013-05-13 14:30:00','2013-05-13 23:00:00'),(2156,371,36,'2013-05-13 23:30:00','2013-05-14 09:30:00'),(2157,371,37,'2013-05-14 10:00:00','2013-05-14 13:30:00'),(2158,371,38,'2013-05-14 14:00:00','2013-05-14 20:30:00'),(2159,372,35,'2013-05-13 17:30:00','2013-05-14 02:00:00'),(2160,372,36,'2013-05-14 02:30:00','2013-05-14 12:30:00'),(2161,372,37,'2013-05-14 13:00:00','2013-05-14 16:30:00'),(2162,372,38,'2013-05-14 17:00:00','2013-05-14 23:30:00'),(2163,373,35,'2013-05-14 07:30:00','2013-05-14 16:00:00'),(2164,373,36,'2013-05-14 16:30:00','2013-05-15 02:30:00'),(2165,373,37,'2013-05-15 03:00:00','2013-05-15 06:30:00'),(2166,373,38,'2013-05-15 07:00:00','2013-05-15 13:30:00'),(2167,374,35,'2013-05-14 14:30:00','2013-05-14 23:00:00'),(2168,374,36,'2013-05-14 23:30:00','2013-05-15 09:30:00'),(2169,374,37,'2013-05-15 10:00:00','2013-05-15 13:30:00'),(2170,374,38,'2013-05-15 14:00:00','2013-05-15 20:30:00'),(2171,375,35,'2013-05-15 10:30:00','2013-05-15 19:00:00'),(2172,375,36,'2013-05-15 19:30:00','2013-05-16 05:30:00'),(2173,375,37,'2013-05-16 06:00:00','2013-05-16 09:30:00'),(2174,375,38,'2013-05-16 10:00:00','2013-05-16 16:30:00'),(2175,376,35,'2013-05-15 15:20:00','2013-05-15 23:50:00'),(2176,376,36,'2013-05-16 00:20:00','2013-05-16 10:20:00'),(2177,376,37,'2013-05-16 10:50:00','2013-05-16 14:20:00'),(2178,376,38,'2013-05-16 14:50:00','2013-05-16 21:20:00'),(2179,377,31,'2013-05-15 07:30:00','2013-05-15 14:00:00'),(2180,377,32,'2013-05-15 14:30:00','2013-05-15 18:00:00'),(2181,377,33,'2013-05-15 18:30:00','2013-05-16 04:30:00'),(2182,377,34,'2013-05-16 05:00:00','2013-05-16 13:30:00'),(2183,378,31,'2013-05-14 07:30:00','2013-05-14 14:00:00'),(2184,378,32,'2013-05-14 14:30:00','2013-05-14 18:00:00'),(2185,378,33,'2013-05-14 18:30:00','2013-05-15 04:30:00'),(2186,378,34,'2013-05-15 05:00:00','2013-05-15 13:30:00'),(2187,379,31,'2013-05-14 10:30:00','2013-05-14 17:00:00'),(2188,379,32,'2013-05-14 17:30:00','2013-05-14 21:00:00'),(2189,379,33,'2013-05-14 21:30:00','2013-05-15 07:30:00'),(2190,379,34,'2013-05-15 08:00:00','2013-05-15 16:30:00'),(2191,380,31,'2013-05-15 14:30:00','2013-05-15 21:00:00'),(2192,380,32,'2013-05-15 21:30:00','2013-05-16 01:00:00'),(2193,380,33,'2013-05-16 01:30:00','2013-05-16 11:30:00'),(2194,380,34,'2013-05-16 12:00:00','2013-05-16 20:30:00'),(2195,381,31,'2013-05-15 17:30:00','2013-05-16 00:00:00'),(2196,381,32,'2013-05-16 00:30:00','2013-05-16 04:00:00'),(2197,381,33,'2013-05-16 04:30:00','2013-05-16 14:30:00'),(2198,381,34,'2013-05-16 15:00:00','2013-05-16 23:30:00'),(2199,382,31,'2013-05-16 07:30:00','2013-05-16 14:00:00'),(2200,382,32,'2013-05-16 14:30:00','2013-05-16 18:00:00'),(2201,382,33,'2013-05-16 18:30:00','2013-05-17 04:30:00'),(2202,382,34,'2013-05-17 05:00:00','2013-05-17 13:30:00'),(2203,383,31,'2013-05-16 14:30:00','2013-05-16 21:00:00'),(2204,383,32,'2013-05-16 21:30:00','2013-05-17 01:00:00'),(2205,383,33,'2013-05-17 01:30:00','2013-05-17 11:30:00'),(2206,383,34,'2013-05-17 12:00:00','2013-05-17 20:30:00'),(2207,384,31,'2013-05-16 17:30:00','2013-05-17 00:00:00'),(2208,384,32,'2013-05-17 00:30:00','2013-05-17 04:00:00'),(2209,384,33,'2013-05-17 04:30:00','2013-05-17 14:30:00'),(2210,384,34,'2013-05-17 15:00:00','2013-05-17 23:30:00'),(2211,385,31,'2013-05-17 14:30:00','2013-05-17 21:00:00'),(2212,385,32,'2013-05-17 21:30:00','2013-05-18 01:00:00'),(2213,385,33,'2013-05-18 01:30:00','2013-05-18 11:30:00'),(2214,385,34,'2013-05-18 12:00:00','2013-05-18 20:30:00'),(2215,386,35,'2013-05-16 07:00:00','2013-05-16 15:30:00'),(2216,386,36,'2013-05-16 16:00:00','2013-05-17 02:00:00'),(2217,386,37,'2013-05-17 02:30:00','2013-05-17 06:00:00'),(2218,386,38,'2013-05-17 06:30:00','2013-05-17 13:00:00'),(2219,387,35,'2013-05-16 10:30:00','2013-05-16 19:00:00'),(2220,387,36,'2013-05-16 19:30:00','2013-05-17 05:30:00'),(2221,387,37,'2013-05-17 06:00:00','2013-05-17 09:30:00'),(2222,387,38,'2013-05-17 10:00:00','2013-05-17 16:30:00'),(2223,388,35,'2013-05-17 06:30:00','2013-05-17 15:00:00'),(2224,388,36,'2013-05-17 15:30:00','2013-05-18 01:30:00'),(2225,388,37,'2013-05-18 02:00:00','2013-05-18 05:30:00'),(2226,388,38,'2013-05-18 06:00:00','2013-05-18 12:30:00'),(2227,389,35,'2013-05-17 14:30:00','2013-05-17 23:00:00'),(2228,389,36,'2013-05-17 23:30:00','2013-05-18 09:30:00'),(2229,389,37,'2013-05-18 10:00:00','2013-05-18 13:30:00'),(2230,389,38,'2013-05-18 14:00:00','2013-05-18 20:30:00'),(2231,390,35,'2013-05-17 17:00:00','2013-05-18 01:30:00'),(2232,390,36,'2013-05-18 02:00:00','2013-05-18 12:00:00'),(2233,390,37,'2013-05-18 12:30:00','2013-05-18 16:00:00'),(2234,390,38,'2013-05-18 16:30:00','2013-05-18 23:00:00'),(2235,391,35,'2013-05-18 07:00:00','2013-05-18 15:30:00'),(2236,391,36,'2013-05-18 16:00:00','2013-05-19 02:00:00'),(2237,391,37,'2013-05-19 02:30:00','2013-05-19 06:00:00'),(2238,391,38,'2013-05-19 06:30:00','2013-05-19 13:00:00'),(2239,392,35,'2013-05-18 09:00:00','2013-05-18 17:30:00'),(2240,392,36,'2013-05-18 18:00:00','2013-05-19 04:00:00'),(2241,392,37,'2013-05-19 04:30:00','2013-05-19 08:00:00'),(2242,392,38,'2013-05-19 08:30:00','2013-05-19 15:00:00'),(2243,393,35,'2013-05-19 07:30:00','2013-05-19 16:00:00'),(2244,393,36,'2013-05-19 16:30:00','2013-05-20 02:30:00'),(2245,393,37,'2013-05-20 03:00:00','2013-05-20 06:30:00'),(2246,393,38,'2013-05-20 07:00:00','2013-05-20 13:30:00'),(2247,394,35,'2013-05-18 21:30:00','2013-05-19 06:00:00'),(2248,394,36,'2013-05-19 06:30:00','2013-05-19 16:30:00'),(2249,394,37,'2013-05-19 17:00:00','2013-05-19 20:30:00'),(2250,394,38,'2013-05-19 21:00:00','2013-05-20 03:30:00'),(2251,395,31,'2013-05-18 07:30:00','2013-05-18 14:00:00'),(2252,395,32,'2013-05-18 14:30:00','2013-05-18 18:00:00'),(2253,395,33,'2013-05-18 18:30:00','2013-05-19 04:30:00'),(2254,395,34,'2013-05-19 05:00:00','2013-05-19 13:30:00'),(2255,396,31,'2013-05-18 14:30:00','2013-05-18 21:00:00'),(2256,396,32,'2013-05-18 21:30:00','2013-05-19 01:00:00'),(2257,396,33,'2013-05-19 01:30:00','2013-05-19 11:30:00'),(2258,396,34,'2013-05-19 12:00:00','2013-05-19 20:30:00'),(2259,397,31,'2013-05-18 15:00:00','2013-05-18 21:30:00'),(2260,397,32,'2013-05-18 22:00:00','2013-05-19 01:30:00'),(2261,397,33,'2013-05-19 02:00:00','2013-05-19 12:00:00'),(2262,397,34,'2013-05-19 12:30:00','2013-05-19 21:00:00'),(2263,398,31,'2013-05-19 06:00:00','2013-05-19 12:30:00'),(2264,398,32,'2013-05-19 13:00:00','2013-05-19 16:30:00'),(2265,398,33,'2013-05-19 17:00:00','2013-05-20 03:00:00'),(2266,398,34,'2013-05-20 03:30:00','2013-05-20 12:00:00'),(2267,399,31,'2013-05-19 09:30:00','2013-05-19 16:00:00'),(2268,399,32,'2013-05-19 16:30:00','2013-05-19 20:00:00'),(2269,399,33,'2013-05-19 20:30:00','2013-05-20 06:30:00'),(2270,399,34,'2013-05-20 07:00:00','2013-05-20 15:30:00'),(2271,400,31,'2013-05-20 11:00:00','2013-05-20 17:30:00'),(2272,400,32,'2013-05-20 18:00:00','2013-05-20 21:30:00'),(2273,400,33,'2013-05-20 22:00:00','2013-05-21 08:00:00'),(2274,400,34,'2013-05-21 08:30:00','2013-05-21 17:00:00'),(2275,401,31,'2013-05-20 14:00:00','2013-05-20 20:30:00'),(2276,401,32,'2013-05-20 21:00:00','2013-05-21 00:30:00'),(2277,401,33,'2013-05-21 01:00:00','2013-05-21 11:00:00'),(2278,401,34,'2013-05-21 11:30:00','2013-05-21 20:00:00'),(2279,402,31,'2013-05-20 17:00:00','2013-05-20 23:30:00'),(2280,402,32,'2013-05-21 00:00:00','2013-05-21 03:30:00'),(2281,402,33,'2013-05-21 04:00:00','2013-05-21 14:00:00'),(2282,402,34,'2013-05-21 14:30:00','2013-05-21 23:00:00'),(2283,403,35,'2013-05-20 18:00:00','2013-05-21 02:30:00'),(2284,403,36,'2013-05-21 03:00:00','2013-05-21 13:00:00'),(2285,403,37,'2013-05-21 13:30:00','2013-05-21 17:00:00'),(2286,403,38,'2013-05-21 17:30:00','2013-05-22 00:00:00'),(2287,404,35,'2013-05-20 15:30:00','2013-05-21 00:00:00'),(2288,404,36,'2013-05-21 00:30:00','2013-05-21 10:30:00'),(2289,404,37,'2013-05-21 11:00:00','2013-05-21 14:30:00'),(2290,404,38,'2013-05-21 15:00:00','2013-05-21 21:30:00'),(2291,407,26,'2013-05-12 06:30:00','2013-05-12 10:30:00'),(2292,407,27,'2013-05-12 11:00:00','2013-05-13 00:00:00'),(2293,407,28,'2013-05-13 00:30:00','2013-05-13 02:30:00'),(2294,407,29,'2013-05-13 03:00:00','2013-05-13 11:30:00'),(2295,407,30,'2013-05-13 12:00:00','2013-05-13 14:30:00'),(2296,408,26,'2013-05-13 06:30:00','2013-05-13 10:30:00'),(2297,408,27,'2013-05-13 11:00:00','2013-05-14 00:00:00'),(2298,408,28,'2013-05-14 00:30:00','2013-05-14 02:30:00'),(2299,408,29,'2013-05-14 03:00:00','2013-05-14 11:30:00'),(2300,408,30,'2013-05-14 12:00:00','2013-05-14 14:30:00'),(2301,409,21,'2013-05-13 07:30:00','2013-05-13 10:00:00'),(2302,409,22,'2013-05-13 10:30:00','2013-05-13 19:00:00'),(2303,409,23,'2013-05-13 19:30:00','2013-05-13 21:30:00'),(2304,409,24,'2013-05-13 22:00:00','2013-05-14 11:00:00'),(2305,409,25,'2013-05-14 11:30:00','2013-05-14 15:30:00'),(2306,410,21,'2013-05-14 07:30:00','2013-05-14 10:00:00'),(2307,410,22,'2013-05-14 10:30:00','2013-05-14 19:00:00'),(2308,410,23,'2013-05-14 19:30:00','2013-05-14 21:30:00'),(2309,410,24,'2013-05-14 22:00:00','2013-05-15 11:00:00'),(2310,410,25,'2013-05-15 11:30:00','2013-05-15 15:30:00'),(2311,411,21,'2013-05-15 07:30:00','2013-05-15 10:00:00'),(2312,411,22,'2013-05-15 10:30:00','2013-05-15 19:00:00'),(2313,411,23,'2013-05-15 19:30:00','2013-05-15 21:30:00'),(2314,411,24,'2013-05-15 22:00:00','2013-05-16 11:00:00'),(2315,411,25,'2013-05-16 11:30:00','2013-05-16 15:30:00'),(2316,412,21,'2013-05-17 07:30:00','2013-05-17 10:00:00'),(2317,412,22,'2013-05-17 10:30:00','2013-05-17 19:00:00'),(2318,412,23,'2013-05-17 19:30:00','2013-05-17 21:30:00'),(2319,412,24,'2013-05-17 22:00:00','2013-05-18 11:00:00'),(2320,412,25,'2013-05-18 11:30:00','2013-05-18 15:30:00'),(2321,413,26,'2013-05-15 10:30:00','2013-05-15 14:30:00'),(2322,413,27,'2013-05-15 15:00:00','2013-05-16 04:00:00'),(2323,413,28,'2013-05-16 04:30:00','2013-05-16 06:30:00'),(2324,413,29,'2013-05-16 07:00:00','2013-05-16 15:30:00'),(2325,413,30,'2013-05-16 16:00:00','2013-05-16 18:30:00'),(2326,414,26,'2013-05-16 07:30:00','2013-05-16 11:30:00'),(2327,414,27,'2013-05-16 12:00:00','2013-05-17 01:00:00'),(2328,414,28,'2013-05-17 01:30:00','2013-05-17 03:30:00'),(2329,414,29,'2013-05-17 04:00:00','2013-05-17 12:30:00'),(2330,414,30,'2013-05-17 13:00:00','2013-05-17 15:30:00');
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
INSERT INTO `trip_in_ticket` VALUES (36,1906),(35,1923);
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
		(`rsv`.`status` = 'paid'
		OR `rsv`.`status` = 'pending'
			OR (`rsv`.`status` = 'unpaid'
			AND `rsv`.`book_time` > SUBDATE(NOW(), INTERVAL 15 MINUTE)))
		AND (`tkt`.`status` = 'active' OR `tkt`.`status` = 'pending');
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
		(`rsv`.`status` = 'paid'
		OR `rsv`.`status` = 'pending'
			OR (`rsv`.`status` = 'unpaid'
			AND `rsv`.`book_time` > SUBDATE(NOW(), INTERVAL 15 MINUTE)))
		AND (`tkt`.`status` = 'active' OR `tkt`.`status` = 'pending');
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
		sum(trff.fare)					AS fare,
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
/*!50001 VIEW `remained_seats` AS select `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_location_id` AS `start_location_id`,`tse`.`end_location_id` AS `end_location_id`,(`btp`.`number_of_seats` - count(distinct `sp`.`seat_name`)) AS `number_of_remained_seats` from ((`trip_start_end` `tse` left join (((`trip_in_ticket` `tit` join `ticket` `tkt` on((`tit`.`ticket_id` = `tkt`.`id`))) join `reservation` `rsv` on(((`tkt`.`reservation_id` = `rsv`.`id`) and ((`rsv`.`status` = 'paid') or (`rsv`.`status` = 'pending') or ((`rsv`.`status` = 'unpaid') and (`rsv`.`book_time` > (now() - interval 15 minute)))) and ((`tkt`.`status` = 'active') or (`tkt`.`status` = 'pending'))))) join `seat_position` `sp` on((`sp`.`ticket_id` = `tkt`.`id`))) on((`tit`.`trip_id` = `tse`.`trip_id`))) join ((`bus_status` `bst` join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) on((`bst`.`id` = `tse`.`bus_status_id`))) group by `tse`.`bus_status_id`,`tse`.`start_location_id`,`tse`.`end_location_id`,`btp`.`number_of_seats` */;
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

-- Dump completed on 2013-04-24  0:20:21
