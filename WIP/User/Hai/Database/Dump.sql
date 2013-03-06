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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,1,'1111-1111',NULL,NULL,'active'),(2,2,'2222-2222',NULL,NULL,'active'),(3,1,'47H1-123.45',NULL,NULL,'active'),(4,1,'59F1-123.45',NULL,NULL,'active');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_status`
--

LOCK TABLES `bus_status` WRITE;
/*!40000 ALTER TABLE `bus_status` DISABLE KEYS */;
INSERT INTO `bus_status` VALUES (4,3,'ontrip','2013-03-11 18:10:50','2013-03-25 06:10:50',8,'active'),(5,3,'ontrip','2013-03-27 06:10:50','2013-04-09 18:10:50',35,'active'),(6,3,'ontrip','2013-04-11 18:10:50','2013-04-25 06:10:50',8,'active'),(7,3,'ontrip','2013-04-27 06:10:50','2013-05-10 18:10:50',35,'active'),(8,3,'ontrip','2013-05-12 18:10:50','2013-05-26 06:10:50',8,'active'),(9,3,'ontrip','2013-05-28 06:10:50','2013-06-10 18:10:50',35,'active'),(10,3,'ontrip','2013-06-12 18:10:50','2013-06-26 06:10:50',8,'active'),(11,3,'ontrip','2013-06-28 06:10:50','2013-07-11 18:10:50',35,'active'),(12,3,'ontrip','2013-07-13 18:10:50','2013-07-27 06:10:50',8,'active'),(13,3,'ontrip','2013-07-29 06:10:50','2013-08-11 18:10:50',35,'active');
/*!40000 ALTER TABLE `bus_status` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (76,'An Giang'),(64,'Bà Rịa Vũng Tàu'),(75,'Bến Tre'),(62,'Bình Thuận'),(56,'Bình Định'),(4,'Hà Nội'),(39,'Hà Tĩnh'),(31,'Hải Phòng'),(58,'Khánh Hoà'),(63,'Lâm Đồng'),(25,'Lạng Sơn'),(20,'Lào Cai'),(72,'Long An'),(38,'Nghệ An'),(52,'Quảng Bình'),(55,'Quảng Ngãi'),(66,'Tây Ninh'),(37,'Thanh Hoá'),(54,'Thừa Thiên Huế'),(8,'TP. Hồ Chí Minh'),(29,'Yên Bái'),(511,'Đà Nẵng'),(61,'Đồng Nai');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reservation_id` int(11) NOT NULL,
  `pay_amount` double NOT NULL,
  `service_fee` double NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `transaction_id` varchar(45) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_reservation_id_idx` (`reservation_id`),
  KEY `payment_payment_method_id_idx` (`payment_method_id`),
  CONSTRAINT `payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `payment_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=839 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (750,1,NULL,'2013-04-11 15:14:36','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(751,1,NULL,'2013-03-11 01:56:27','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(752,1,NULL,'2013-04-29 12:28:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(753,1,NULL,'2013-03-24 02:59:37','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(754,1,NULL,'2013-05-04 10:32:39','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(755,1,NULL,'2013-04-09 01:03:41','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(756,1,NULL,'2013-04-29 18:40:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(757,1,NULL,'2013-04-28 10:38:13','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(758,1,NULL,'2013-04-02 15:40:09','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(759,1,NULL,'2013-04-27 02:15:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(760,1,NULL,'2013-04-27 16:13:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(761,1,NULL,'2013-04-25 07:33:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(762,1,NULL,'2013-03-30 20:34:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(763,1,NULL,'2013-03-16 14:09:43','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(764,1,NULL,'2013-03-18 20:50:29','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(765,1,NULL,'2013-04-09 14:38:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(766,1,NULL,'2013-03-30 18:28:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(767,1,NULL,'2013-04-29 15:16:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(768,1,NULL,'2013-04-25 17:51:07','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(769,1,NULL,'2013-04-26 02:09:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(770,1,NULL,'2013-04-06 13:08:39','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(771,1,NULL,'2013-03-10 17:50:58','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(772,1,NULL,'2013-03-07 05:40:45','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(773,1,NULL,'2013-04-14 14:45:58','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(774,1,NULL,'2013-04-09 04:15:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(775,1,NULL,'2013-03-11 19:53:58','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(776,1,NULL,'2013-04-24 12:10:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(777,1,NULL,'2013-03-10 02:48:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(778,1,NULL,'2013-04-26 16:37:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(779,1,NULL,'2013-04-19 20:45:12','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(780,1,NULL,'2013-03-13 07:09:08','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(781,1,NULL,'2013-05-04 08:00:21','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(782,1,NULL,'2013-04-29 11:13:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(783,1,NULL,'2013-04-10 15:47:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(784,1,NULL,'2013-03-14 02:51:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(785,1,NULL,'2013-03-27 19:58:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(786,1,NULL,'2013-03-16 04:36:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(787,1,NULL,'2013-04-22 09:08:13','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(788,1,NULL,'2013-04-06 01:30:39','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(789,1,NULL,'2013-03-22 20:46:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(790,1,NULL,'2013-03-07 12:31:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(791,1,NULL,'2013-04-12 12:30:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(792,1,NULL,'2013-03-08 20:14:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(793,1,NULL,'2013-03-22 17:59:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(794,1,NULL,'2013-03-27 00:56:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(795,1,NULL,'2013-04-14 04:23:20','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(796,1,NULL,'2013-04-28 19:19:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(797,1,NULL,'2013-04-29 07:12:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(798,1,NULL,'2013-04-16 07:39:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(799,1,NULL,'2013-05-04 19:18:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(800,1,NULL,'2013-03-29 01:26:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(801,1,NULL,'2013-04-30 22:21:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(802,1,NULL,'2013-03-18 23:07:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(803,1,NULL,'2013-04-27 07:01:14','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(804,1,NULL,'2013-03-08 22:34:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(805,1,NULL,'2013-03-14 21:36:19','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(806,1,NULL,'2013-04-25 22:07:10','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(807,1,NULL,'2013-05-03 07:01:58','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(808,1,NULL,'2013-03-19 20:40:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(809,1,NULL,'2013-03-19 03:58:03','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(810,1,NULL,'2013-04-24 13:05:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(811,1,NULL,'2013-04-29 21:46:15','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(812,1,NULL,'2013-04-12 11:51:37','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(813,1,NULL,'2013-04-14 04:00:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(814,1,NULL,'2013-05-02 02:26:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(815,1,NULL,'2013-04-30 16:39:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(816,1,NULL,'2013-04-21 05:06:27','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(817,1,NULL,'2013-03-16 04:08:08','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(818,1,NULL,'2013-05-05 06:56:32','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(819,1,NULL,'2013-04-22 15:56:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(820,1,NULL,'2013-03-29 03:43:21','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(821,1,NULL,'2013-03-21 13:44:32','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(822,1,NULL,'2013-03-19 06:23:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(823,1,NULL,'2013-03-18 15:27:15','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(824,1,NULL,'2013-04-16 12:31:59','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(825,1,NULL,'2013-03-10 02:01:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(826,1,NULL,'2013-03-29 18:49:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(827,1,NULL,'2013-03-21 01:23:41','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(828,1,NULL,'2013-04-26 01:38:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(829,1,NULL,'2013-05-05 06:13:15','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(830,1,NULL,'2013-03-06 16:55:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(831,1,NULL,'2013-04-25 08:25:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(832,1,NULL,'2013-03-09 01:13:27','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(833,1,NULL,'2013-04-24 14:28:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(834,1,NULL,'2013-05-02 04:00:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(835,1,NULL,'2013-03-18 05:17:55','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(836,1,NULL,'2013-04-27 22:44:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(837,1,NULL,'2013-03-12 22:09:58','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(838,1,NULL,'2013-04-14 14:12:02','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `reservation_refund_view`
--

DROP TABLE IF EXISTS `reservation_refund_view`;
/*!50001 DROP VIEW IF EXISTS `reservation_refund_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `reservation_refund_view` (
  `reservation_id` int(11),
  `refund_amount` double
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `reservation_view`
--

DROP TABLE IF EXISTS `reservation_view`;
/*!50001 DROP VIEW IF EXISTS `reservation_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `reservation_view` (
  `reservation_id` int(11),
  `start_trip_id` int(11),
  `end_trip_id` int(11),
  `ticket_price` double,
  `paid_amount` double,
  `refund_amount` double
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Customer',NULL),(2,'Operator',NULL),(3,'Administrator',NULL);
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
INSERT INTO `seat_position` VALUES (934,'B7'),(935,'A5'),(935,'C11'),(935,'D1'),(936,'A11'),(936,'C3'),(936,'C4'),(937,'C2'),(937,'D1'),(937,'D10'),(937,'D4'),(938,'A9'),(938,'B11'),(939,'B5'),(939,'C8'),(939,'D10'),(939,'D3'),(940,'A2'),(940,'A8'),(940,'A9'),(941,'A6'),(941,'B6'),(941,'D1'),(941,'D4'),(941,'D8'),(942,'B5'),(943,'A11'),(943,'A7'),(943,'D5'),(944,'C3'),(944,'D6'),(945,'C4'),(946,'A6'),(947,'A8'),(947,'B10'),(947,'B3'),(947,'C3'),(948,'A4'),(948,'A6'),(948,'C6'),(948,'D7'),(949,'B11'),(949,'B4'),(949,'D2'),(949,'D7'),(950,'A3'),(950,'B8'),(950,'C9'),(951,'C7'),(951,'D1'),(952,'B1'),(952,'C9'),(953,'A2'),(953,'B8'),(953,'D8'),(954,'B7'),(954,'C5'),(954,'D8'),(955,'A2'),(955,'A9'),(955,'B11'),(955,'B7'),(955,'C7'),(956,'B2'),(956,'C11'),(956,'C5'),(956,'C9'),(957,'B6'),(957,'D6'),(958,'A9'),(958,'C9'),(958,'D6'),(959,'A4'),(959,'C1'),(959,'D4'),(960,'A11'),(960,'B2'),(960,'C9'),(961,'B3'),(962,'A11'),(963,'B5'),(963,'B9'),(964,'A10'),(964,'A8'),(964,'B4'),(964,'B7'),(964,'C8'),(965,'A6'),(965,'B2'),(965,'B7'),(965,'B8'),(965,'C9'),(966,'B4'),(966,'D8'),(967,'A8'),(967,'C5'),(968,'A11'),(968,'A7'),(968,'C8'),(969,'B5'),(969,'D1'),(969,'D3'),(970,'A10'),(970,'C9'),(970,'D7'),(971,'B5'),(971,'C2'),(972,'A10'),(972,'B5'),(973,'A11'),(973,'A7'),(973,'D6'),(974,'A9'),(974,'B1'),(974,'B5'),(974,'C11'),(974,'D8'),(975,'B10'),(975,'B5'),(975,'C4'),(975,'C5'),(976,'A11'),(976,'B6'),(976,'D11'),(976,'D2'),(977,'A4'),(977,'D6'),(978,'A2'),(978,'C10'),(978,'D5'),(978,'D9'),(979,'A1'),(979,'A8'),(979,'C1'),(979,'D5'),(980,'C2'),(981,'A11'),(981,'C7'),(981,'C8'),(981,'D2'),(981,'D9'),(982,'D9'),(983,'C7'),(983,'D3'),(983,'D4'),(984,'A1'),(984,'B8'),(984,'C2'),(985,'A5'),(985,'A6'),(985,'B1'),(985,'C6'),(985,'D11'),(986,'A7'),(986,'A9'),(986,'B4'),(986,'C10'),(986,'D8'),(987,'B2'),(987,'B8'),(987,'C1'),(987,'D4'),(988,'B11'),(988,'C3'),(988,'C8'),(988,'D5'),(989,'B11'),(989,'B5'),(989,'C11'),(989,'D10'),(990,'B7'),(990,'B8'),(990,'C2'),(990,'D10'),(991,'D9'),(992,'D3'),(993,'A4'),(993,'B10'),(993,'B4'),(993,'C2'),(993,'C8'),(994,'C7'),(995,'B2'),(995,'B6'),(995,'D10'),(995,'D7'),(996,'B10'),(996,'B3'),(996,'C8'),(997,'A3'),(997,'B8'),(997,'C5'),(997,'D1'),(997,'D6'),(998,'B2'),(998,'C11'),(998,'C2'),(998,'C7'),(998,'D4'),(999,'B1'),(1000,'B7'),(1000,'C7'),(1000,'D11'),(1001,'B4'),(1002,'A10'),(1002,'A9'),(1002,'C4'),(1003,'C1'),(1003,'C8'),(1003,'D8'),(1004,'B6'),(1004,'C3'),(1004,'D1'),(1005,'A1'),(1005,'B6'),(1006,'B9'),(1006,'C5'),(1007,'A7'),(1007,'D10'),(1008,'A1'),(1009,'A4'),(1009,'D9'),(1010,'B1'),(1010,'B11'),(1010,'C5'),(1010,'D11'),(1011,'A2'),(1011,'D8'),(1012,'B11'),(1012,'D3'),(1013,'A9'),(1013,'B1'),(1013,'C11'),(1013,'C5'),(1013,'D4'),(1014,'A9'),(1014,'D1'),(1014,'D11'),(1014,'D6'),(1015,'B1'),(1015,'B3'),(1015,'D1'),(1015,'D7'),(1016,'A4'),(1016,'A6'),(1016,'B6'),(1016,'C3'),(1016,'D6'),(1017,'B6'),(1017,'D10'),(1017,'D3'),(1017,'D6'),(1018,'A4'),(1019,'C2'),(1020,'A4'),(1020,'B4'),(1020,'C11'),(1021,'A9'),(1021,'B4'),(1021,'C8'),(1022,'B10'),(1022,'B4'),(1022,'B5'),(1022,'D6'),(1023,'A3'),(1023,'A4'),(1023,'C9'),(1023,'D3'),(1023,'D6'),(1024,'B6'),(1024,'D6'),(1025,'C9'),(1026,'B10'),(1026,'B11'),(1026,'D2'),(1027,'B2'),(1027,'C6'),(1027,'D5'),(1028,'A11'),(1028,'A9'),(1028,'B1'),(1028,'B8'),(1029,'A3'),(1029,'B3'),(1029,'D1'),(1029,'D4'),(1029,'D8'),(1030,'A2'),(1030,'A3'),(1030,'C7'),(1031,'A11'),(1031,'B3'),(1031,'B9'),(1031,'D10'),(1032,'C1'),(1032,'D11'),(1032,'D8'),(1033,'A2'),(1033,'A5'),(1033,'B1'),(1033,'B10'),(1033,'B11'),(1034,'A5'),(1034,'D2'),(1035,'C5'),(1035,'D3'),(1036,'A2'),(1036,'C8'),(1036,'C9'),(1037,'D4'),(1038,'B11'),(1038,'D10'),(1039,'A5'),(1039,'A6'),(1040,'C7'),(1041,'C4'),(1041,'D3'),(1042,'A7'),(1042,'B8'),(1042,'D11'),(1043,'A9'),(1043,'B2'),(1043,'C4'),(1044,'A5'),(1044,'A9'),(1044,'B9'),(1044,'C6'),(1044,'C8'),(1045,'A11'),(1045,'A2'),(1045,'C5'),(1046,'B11'),(1046,'C3'),(1046,'D2'),(1047,'B2'),(1048,'A2'),(1048,'C1'),(1049,'C2'),(1049,'D8'),(1050,'A1'),(1050,'A8'),(1050,'C5'),(1051,'B2'),(1051,'B4'),(1051,'D1'),(1052,'A1'),(1052,'A9'),(1052,'C11'),(1053,'A2');
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
  `travel_time` bigint(20) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
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
INSERT INTO `segment` VALUES (1,1,2,5400000,'active'),(2,2,1,36000000,'active'),(3,3,5,3600000,'active'),(4,5,7,21600000,'active'),(5,7,6,32400000,'active'),(6,6,8,14400000,'active'),(7,3,35,16200000,'active'),(8,35,34,16200000,'active'),(9,34,33,4500000,'active'),(10,33,32,13500000,'active'),(11,32,31,10800000,'active'),(12,31,5,10800000,'active'),(13,5,8,57600000,'active'),(14,8,5,57600000,'active'),(15,5,31,10800000,'active'),(16,31,32,10800000,'active'),(17,32,33,13500000,'active'),(18,33,34,4500000,'active'),(19,34,35,16200000,'active'),(20,35,3,16200000,'active');
/*!40000 ALTER TABLE `segment` ENABLE KEYS */;
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
INSERT INTO `station` VALUES (1,'Bến xe Hà Tĩnh',39,'Hà Tĩnh','active'),(2,'Bến xe Bến Tre',75,'Bến Tre','active'),(3,'Bến xe Miền Đông',8,'TP. Hồ Chí Minh','active'),(5,'Bến xe Đà Nẵng',511,'Đà Nẵng','active'),(6,'Bến xe Hải Phòng',31,'Hải Phòng','active'),(7,'Bến xe Huế',54,'Thừa Thiên Huế','active'),(8,'Bến xe Hà Nội',4,'Hà Nội','active'),(9,'Bến xe Lào Cai',20,'Lào Cai','active'),(10,'Bến xe Lạng Sơn',25,'Lạng Sơn','active'),(11,'Bến xe Yên Bái',29,'Yên Bái','active'),(12,'Bến xe Đồng Nai',61,'Đồng Nai','active'),(13,'Bến xe Lâm Đồng',63,'Lâm Đồng','active'),(14,'Bến xe Vũng Tàu',64,'Vũng Tàu','active'),(15,'Bến xe Tây Ninh',66,'Tây Ninh','active'),(16,'Bến xe Long An',72,'Long An','active'),(17,'Bến xe An Giang',76,'An Giang','active'),(28,'Bến xe Vinh',38,'Vinh','active'),(29,'Bến xe Thanh Hoá',37,'Thanh Hoá','active'),(30,'Bến xe Quảng Bình',52,'Quảng Bình','active'),(31,'Bến xe Quảng Ngãi',55,'Quảng Ngãi','active'),(32,'Bến xe Quy Nhơn',56,'Quy Nhơn','active'),(33,'Bến xe Vạn Giã',58,'Vạn Giã','active'),(34,'Bến xe Nha Trang',58,'Nha Trang','active'),(35,'Bến xe Phan Thiết',62,'Phan Thiết','active'),(36,'Bến xe Bà Rịa',64,'Bà Rịa','active'),(37,'Bến xe Đà Lạt',63,'Đà Lạt','active');
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
INSERT INTO `system_setting` VALUES ('refund.1.rate','70'),('refund.1.time','10'),('refund.2.rate','30'),('refund.2.time','5'),('reservation.timeout','15');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,1,1,'2012-01-01 00:00:00',100000),(2,2,1,'2012-01-01 00:00:00',100000),(3,3,1,'2013-01-01 00:00:00',150000),(4,4,1,'2013-01-01 00:00:00',65000),(5,5,1,'2013-01-01 00:00:00',30000),(6,6,1,'2013-01-01 00:00:00',90000),(7,2,1,'2013-02-28 00:00:00',80000),(8,2,1,'2013-02-01 00:00:00',85000),(9,2,1,'2013-03-15 00:00:00',100000),(10,3,1,'2013-02-20 00:00:00',170000),(11,3,1,'2013-02-04 00:00:00',120000),(12,4,1,'2013-02-25 00:00:00',80000),(13,4,1,'2013-03-01 00:00:00',65000),(14,7,1,'2012-01-01 00:00:00',125000),(15,8,1,'2012-01-01 00:00:00',125000),(16,9,1,'2012-01-01 00:00:00',125000),(17,10,1,'2012-01-01 00:00:00',125000),(18,11,1,'2012-01-01 00:00:00',125000),(19,12,1,'2012-01-01 00:00:00',125000),(20,13,1,'2012-01-01 00:00:00',125000),(21,14,1,'2012-01-01 00:00:00',125000),(22,15,1,'2012-01-01 00:00:00',125000),(23,16,1,'2012-01-01 00:00:00',125000),(24,17,1,'2012-01-01 00:00:00',125000),(25,18,1,'2012-01-01 00:00:00',125000),(26,19,1,'2012-01-01 00:00:00',125000),(27,20,1,'2012-01-01 00:00:00',125000);
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
  PRIMARY KEY (`id`),
  KEY `ticket_reservation_id_idx` (`reservation_id`),
  CONSTRAINT `ticket_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1054 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (934,750),(935,751),(936,751),(937,752),(938,753),(939,754),(940,755),(941,756),(942,757),(943,758),(944,758),(945,759),(946,759),(947,760),(948,760),(949,761),(950,762),(951,763),(952,764),(953,765),(954,765),(955,766),(956,766),(957,767),(958,768),(959,769),(960,769),(961,770),(962,770),(963,771),(964,772),(965,772),(966,773),(967,773),(968,774),(969,774),(970,775),(971,776),(972,776),(973,777),(974,778),(975,778),(976,779),(977,780),(978,781),(979,781),(980,782),(981,783),(982,784),(983,785),(984,785),(985,786),(986,786),(987,787),(988,788),(989,788),(990,789),(991,790),(992,790),(993,791),(994,792),(995,793),(996,794),(997,795),(998,795),(999,796),(1000,797),(1001,798),(1002,799),(1003,799),(1004,800),(1005,801),(1006,802),(1007,802),(1008,803),(1009,804),(1010,805),(1011,806),(1012,806),(1013,807),(1014,808),(1015,808),(1016,809),(1017,810),(1018,811),(1019,811),(1020,812),(1021,812),(1022,813),(1023,814),(1024,815),(1025,816),(1026,817),(1027,818),(1028,819),(1029,820),(1030,821),(1031,822),(1032,823),(1033,824),(1034,825),(1035,825),(1036,826),(1037,827),(1038,828),(1039,828),(1040,829),(1041,830),(1042,831),(1043,831),(1044,832),(1045,833),(1046,833),(1047,834),(1048,835),(1049,835),(1050,836),(1051,837),(1052,837),(1053,838);
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
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_bus_id_idx` (`bus_status_id`),
  KEY `trip_segment_in_route_id_idx` (`route_details_id`),
  CONSTRAINT `trip_bus_status_id` FOREIGN KEY (`bus_status_id`) REFERENCES `bus_status` (`id`),
  CONSTRAINT `trip_segment_in_route_id` FOREIGN KEY (`route_details_id`) REFERENCES `route_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (7,4,7,'2013-03-11 18:10:50','2013-03-11 22:40:50','active'),(8,4,8,'2013-03-13 22:40:50','2013-03-14 03:10:50','active'),(9,4,9,'2013-03-16 03:10:50','2013-03-16 04:25:50','active'),(10,4,10,'2013-03-18 04:25:50','2013-03-18 08:10:50','active'),(11,4,11,'2013-03-20 08:10:50','2013-03-20 11:10:50','active'),(12,4,12,'2013-03-22 11:10:50','2013-03-22 14:10:50','active'),(13,4,13,'2013-03-24 14:10:50','2013-03-25 06:10:50','active'),(14,5,14,'2013-03-27 06:10:50','2013-03-27 22:10:50','active'),(15,5,15,'2013-03-29 22:10:50','2013-03-30 01:10:50','active'),(16,5,16,'2013-04-01 01:10:50','2013-04-01 04:10:50','active'),(17,5,17,'2013-04-03 04:10:50','2013-04-03 07:55:50','active'),(18,5,18,'2013-04-05 07:55:50','2013-04-05 09:10:50','active'),(19,5,19,'2013-04-07 09:10:50','2013-04-07 13:40:50','active'),(20,5,20,'2013-04-09 13:40:50','2013-04-09 18:10:50','active'),(21,6,7,'2013-04-11 18:10:50','2013-04-11 22:40:50','active'),(22,6,8,'2013-04-13 22:40:50','2013-04-14 03:10:50','active'),(23,6,9,'2013-04-16 03:10:50','2013-04-16 04:25:50','active'),(24,6,10,'2013-04-18 04:25:50','2013-04-18 08:10:50','active'),(25,6,11,'2013-04-20 08:10:50','2013-04-20 11:10:50','active'),(26,6,12,'2013-04-22 11:10:50','2013-04-22 14:10:50','active'),(27,6,13,'2013-04-24 14:10:50','2013-04-25 06:10:50','active'),(28,7,14,'2013-04-27 06:10:50','2013-04-27 22:10:50','active'),(29,7,15,'2013-04-29 22:10:50','2013-04-30 01:10:50','active'),(30,7,16,'2013-05-02 01:10:50','2013-05-02 04:10:50','active'),(31,7,17,'2013-05-04 04:10:50','2013-05-04 07:55:50','active'),(32,7,18,'2013-05-06 07:55:50','2013-05-06 09:10:50','active'),(33,7,19,'2013-05-08 09:10:50','2013-05-08 13:40:50','active'),(34,7,20,'2013-05-10 13:40:50','2013-05-10 18:10:50','active'),(35,8,7,'2013-05-12 18:10:50','2013-05-12 22:40:50','active'),(36,8,8,'2013-05-14 22:40:50','2013-05-15 03:10:50','active'),(37,8,9,'2013-05-17 03:10:50','2013-05-17 04:25:50','active'),(38,8,10,'2013-05-19 04:25:50','2013-05-19 08:10:50','active'),(39,8,11,'2013-05-21 08:10:50','2013-05-21 11:10:50','active'),(40,8,12,'2013-05-23 11:10:50','2013-05-23 14:10:50','active'),(41,8,13,'2013-05-25 14:10:50','2013-05-26 06:10:50','active'),(42,9,14,'2013-05-28 06:10:50','2013-05-28 22:10:50','active'),(43,9,15,'2013-05-30 22:10:50','2013-05-31 01:10:50','active'),(44,9,16,'2013-06-02 01:10:50','2013-06-02 04:10:50','active'),(45,9,17,'2013-06-04 04:10:50','2013-06-04 07:55:50','active'),(46,9,18,'2013-06-06 07:55:50','2013-06-06 09:10:50','active'),(47,9,19,'2013-06-08 09:10:50','2013-06-08 13:40:50','active'),(48,9,20,'2013-06-10 13:40:50','2013-06-10 18:10:50','active'),(49,10,7,'2013-06-12 18:10:50','2013-06-12 22:40:50','active'),(50,10,8,'2013-06-14 22:40:50','2013-06-15 03:10:50','active'),(51,10,9,'2013-06-17 03:10:50','2013-06-17 04:25:50','active'),(52,10,10,'2013-06-19 04:25:50','2013-06-19 08:10:50','active'),(53,10,11,'2013-06-21 08:10:50','2013-06-21 11:10:50','active'),(54,10,12,'2013-06-23 11:10:50','2013-06-23 14:10:50','active'),(55,10,13,'2013-06-25 14:10:50','2013-06-26 06:10:50','active'),(56,11,14,'2013-06-28 06:10:50','2013-06-28 22:10:50','active'),(57,11,15,'2013-06-30 22:10:50','2013-07-01 01:10:50','active'),(58,11,16,'2013-07-03 01:10:50','2013-07-03 04:10:50','active'),(59,11,17,'2013-07-05 04:10:50','2013-07-05 07:55:50','active'),(60,11,18,'2013-07-07 07:55:50','2013-07-07 09:10:50','active'),(61,11,19,'2013-07-09 09:10:50','2013-07-09 13:40:50','active'),(62,11,20,'2013-07-11 13:40:50','2013-07-11 18:10:50','active'),(63,12,7,'2013-07-13 18:10:50','2013-07-13 22:40:50','active'),(64,12,8,'2013-07-15 22:40:50','2013-07-16 03:10:50','active'),(65,12,9,'2013-07-18 03:10:50','2013-07-18 04:25:50','active'),(66,12,10,'2013-07-20 04:25:50','2013-07-20 08:10:50','active'),(67,12,11,'2013-07-22 08:10:50','2013-07-22 11:10:50','active'),(68,12,12,'2013-07-24 11:10:50','2013-07-24 14:10:50','active'),(69,12,13,'2013-07-26 14:10:50','2013-07-27 06:10:50','active'),(70,13,14,'2013-07-29 06:10:50','2013-07-29 22:10:50','active'),(71,13,15,'2013-07-31 22:10:50','2013-08-01 01:10:50','active'),(72,13,16,'2013-08-03 01:10:50','2013-08-03 04:10:50','active'),(73,13,17,'2013-08-05 04:10:50','2013-08-05 07:55:50','active'),(74,13,18,'2013-08-07 07:55:50','2013-08-07 09:10:50','active'),(75,13,19,'2013-08-09 09:10:50','2013-08-09 13:40:50','active'),(76,13,20,'2013-08-11 13:40:50','2013-08-11 18:10:50','active');
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
INSERT INTO `trip_in_ticket` VALUES (976,8),(983,8),(1053,8),(976,9),(983,9),(1053,9),(983,10),(999,10),(1042,10),(1053,10),(999,11),(1042,11),(1053,11),(964,12),(970,12),(999,12),(1042,12),(1053,12),(959,13),(964,13),(999,13),(1020,13),(1042,13),(971,14),(1018,14),(971,15),(996,15),(996,16),(968,17),(996,17),(996,18),(1048,18),(935,19),(978,19),(1038,19),(978,20),(1038,20),(1045,20),(966,21),(1009,21),(966,22),(1009,22),(1006,23),(1009,23),(1009,24),(1009,25),(1017,25),(1024,25),(985,26),(991,26),(997,26),(1009,26),(1017,26),(953,27),(985,27),(991,27),(997,27),(1009,27),(1051,28),(940,29),(1005,29),(1051,29),(940,30),(1002,30),(1005,30),(1010,30),(1034,30),(1051,30),(940,31),(1002,31),(1010,31),(1034,31),(940,32),(957,32),(1002,32),(1010,32),(1034,32),(957,33),(1010,33),(1030,33),(1034,33),(1047,33),(957,34),(1030,34),(1034,34),(1040,34),(1047,34),(1029,35),(1029,36),(942,37),(980,37),(1029,37),(942,38),(980,38),(942,39),(1008,39),(1026,39),(942,40),(1025,40),(1026,40),(1025,41),(990,42),(943,43),(950,43),(990,43),(943,44),(945,44),(950,44),(961,44),(981,44),(990,44),(943,45),(945,45),(950,45),(961,45),(981,45),(990,45),(1000,45),(943,46),(945,46),(950,46),(961,46),(981,46),(990,46),(1000,46),(941,47),(943,47),(947,47),(990,47),(1000,47),(990,48),(973,49),(1050,49),(934,50),(1004,50),(1050,50),(934,51),(939,51),(1004,51),(1050,51),(934,52),(939,52),(1004,52),(1032,52),(934,53),(1004,53),(1023,53),(1032,53),(934,54),(1004,54),(1023,54),(1014,55),(1023,55),(937,56),(937,57),(937,58),(974,58),(1001,58),(1013,58),(955,59),(974,59),(994,59),(955,60),(974,60),(994,60),(955,61),(994,61),(1027,61),(955,62),(987,62),(994,62),(1027,62),(988,63),(952,64),(958,64),(988,64),(958,65),(995,65),(1022,65),(958,66),(995,66),(1022,66),(958,67),(995,67),(1011,67),(1016,67),(1022,67),(1044,67),(958,68),(995,68),(1022,68),(963,69),(1037,69),(1031,70),(977,71),(993,71),(938,72),(977,72),(982,72),(993,72),(1028,72),(938,73),(982,73),(993,73),(938,74),(1033,74),(1041,74),(938,75),(949,75),(1036,75),(949,76),(951,76);
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
  `password` varchar(20) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'customer1','customer1',1,'First','Customer',NULL,NULL,'cust1_1357703483_per@fpt.edu.vn',NULL,'active'),(2,'truong','truong',3,'Truong','Nguyen Son',NULL,NULL,NULL,NULL,'active'),(3,'tram','tram',2,'Tram','Nguyen Thi Bich',NULL,NULL,NULL,NULL,'active');
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
			AND (`rsv`.`status` = 'unpaid'
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
			AND (`rsv`.`status` = 'unpaid'
			AND `rsv`.`book_time` > SUBDATE(NOW(), INTERVAL 15 MINUTE));
	RETURN `count`;
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
/*!50001 VIEW `remained_seats` AS select `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_location_id` AS `start_location_id`,`tse`.`end_location_id` AS `end_location_id`,(`btp`.`number_of_seats` - count(distinct `sp`.`seat_name`)) AS `number_of_remained_seats` from ((`trip_start_end` `tse` left join (((`trip_in_ticket` `tit` join `ticket` `tkt` on((`tit`.`ticket_id` = `tkt`.`id`))) join `reservation` `rsv` on(((`tkt`.`reservation_id` = `rsv`.`id`) and ((`rsv`.`status` = 'paid') or ((`rsv`.`status` = 'unpaid') and (`rsv`.`book_time` > (now() - interval 15 minute))))))) join `seat_position` `sp` on((`sp`.`ticket_id` = `tkt`.`id`))) on((`tit`.`trip_id` = `tse`.`trip_id`))) join ((`bus_status` `bst` join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) on((`bst`.`id` = `tse`.`bus_status_id`))) group by `tse`.`bus_status_id`,`tse`.`start_location_id`,`tse`.`end_location_id`,`btp`.`number_of_seats` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reservation_refund_view`
--

/*!50001 DROP TABLE IF EXISTS `reservation_refund_view`*/;
/*!50001 DROP VIEW IF EXISTS `reservation_refund_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reservation_refund_view` AS select `rsv`.`id` AS `reservation_id`,sum(`ref`.`pay_amount`) AS `refund_amount` from (`reservation` `rsv` join `payment` `ref` on(((`ref`.`reservation_id` = `rsv`.`id`) and (`ref`.`type` = 'refund')))) group by `rsv`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reservation_view`
--

/*!50001 DROP TABLE IF EXISTS `reservation_view`*/;
/*!50001 DROP VIEW IF EXISTS `reservation_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reservation_view` AS select `rsv`.`id` AS `reservation_id`,`trp_start`.`id` AS `start_trip_id`,`trp_end`.`id` AS `end_trip_id`,sum(`tar`.`fare`) AS `ticket_price`,`pay`.`pay_amount` AS `paid_amount`,`ref`.`refund_amount` AS `refund_amount` from ((((((((((((((((`reservation` `rsv` join `ticket` `tkt` on((`tkt`.`reservation_id` = `rsv`.`id`))) join `ticket` `tkt_start` on((`tkt_start`.`reservation_id` = `rsv`.`id`))) join `ticket` `tkt_end` on((`tkt_end`.`reservation_id` = `rsv`.`id`))) join `trip_in_ticket` `tit_start` on((`tit_start`.`ticket_id` = `tkt_start`.`id`))) join `trip` `trp_start` on((`trp_start`.`id` = `tit_start`.`trip_id`))) join `trip_in_ticket` `tit_end` on((`tit_end`.`ticket_id` = `tkt_end`.`id`))) join `trip` `trp_end` on((`trp_end`.`id` = `tit_end`.`trip_id`))) join `trip_in_ticket` `tit` on((`tit`.`ticket_id` = `tkt`.`id`))) join `trip` `trp` on((`trp`.`id` = `tit`.`trip_id`))) join `route_details` `rds` on((`rds`.`id` = `trp`.`route_details_id`))) join `segment` `seg` on((`seg`.`id` = `rds`.`segment_id`))) join `bus_status` `bst` on((`bst`.`id` = `trp`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `tariff` `tar` on(((`seg`.`id` = `tar`.`segment_id`) and (`tar`.`bus_type_id` = `bus`.`bus_type_id`)))) left join `payment` `pay` on(((`rsv`.`id` = `pay`.`reservation_id`) and (`pay`.`type` = 'pay')))) left join `reservation_refund_view` `ref` on((`rsv`.`id` = `ref`.`reservation_id`))) where ((`trp_start`.`departure_time` = (select min(`trp1`.`departure_time`) from ((`ticket` `tkt1` join `trip_in_ticket` `tit1` on((`tit1`.`ticket_id` = `tkt1`.`id`))) join `trip` `trp1` on((`trp1`.`id` = `tit1`.`trip_id`))) where (`tkt1`.`reservation_id` = `rsv`.`id`))) and (`trp_end`.`departure_time` = (select max(`trp2`.`departure_time`) from ((`ticket` `tkt2` join `trip_in_ticket` `tit2` on((`tit2`.`ticket_id` = `tkt2`.`id`))) join `trip` `trp2` on((`trp2`.`id` = `tit2`.`trip_id`))) where (`tkt2`.`reservation_id` = `rsv`.`id`))) and (`tar`.`valid_from` = (select max(`tar1`.`valid_from`) from (((((`trip` `trp1` join `route_details` `rds1` on((`rds1`.`id` = `trp1`.`route_details_id`))) join `segment` `seg1` on((`seg1`.`id` = `rds1`.`segment_id`))) join `bus_status` `bst1` on((`bst1`.`id` = `trp1`.`bus_status_id`))) join `bus` `bus1` on((`bus1`.`id` = `bst1`.`bus_id`))) join `tariff` `tar1` on(((`seg1`.`id` = `tar1`.`segment_id`) and (`tar1`.`bus_type_id` = `bus1`.`bus_type_id`)))) where ((`trp1`.`id` = `trp`.`id`) and (`tar1`.`valid_from` < `rsv`.`book_time`))))) group by `rsv`.`id`,`trp_start`.`id`,`trp_end`.`id`,`pay`.`pay_amount`,`ref`.`refund_amount` */;
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

-- Dump completed on 2013-03-06 22:21:30
