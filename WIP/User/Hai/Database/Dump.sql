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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=1114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (964,1,NULL,'2013-03-24 00:51:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(965,1,NULL,'2013-04-04 06:02:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(966,1,NULL,'2013-04-23 05:12:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(967,1,NULL,'2013-05-05 07:49:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(968,1,NULL,'2013-04-11 00:48:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(969,1,NULL,'2013-05-02 16:04:54','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(970,1,NULL,'2013-03-14 09:23:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(971,1,NULL,'2013-04-16 03:07:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(972,1,NULL,'2013-03-20 08:35:57','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(973,1,NULL,'2013-03-08 19:29:39','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(974,1,NULL,'2013-03-16 13:26:22','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(975,1,NULL,'2013-03-25 17:43:19','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(976,1,NULL,'2013-03-30 10:24:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(977,1,NULL,'2013-04-22 20:48:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(978,1,NULL,'2013-05-03 06:23:59','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(979,1,NULL,'2013-04-24 00:56:28','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(980,1,NULL,'2013-03-20 20:19:20','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(982,1,NULL,'2013-03-11 22:22:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(984,1,NULL,'2013-03-08 10:56:54','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(985,1,NULL,'2013-04-04 09:46:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(987,1,NULL,'2013-03-16 08:18:25','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(988,1,NULL,'2013-03-31 21:43:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(990,1,NULL,'2013-04-25 08:58:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(991,1,NULL,'2013-03-29 21:12:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(993,1,NULL,'2013-03-07 13:14:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(994,1,NULL,'2013-03-20 09:21:10','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(995,1,NULL,'2013-04-29 11:05:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(996,1,NULL,'2013-03-12 16:52:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(997,1,NULL,'2013-04-23 04:02:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(998,1,NULL,'2013-04-03 23:59:36','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1001,1,NULL,'2013-04-03 22:34:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1004,1,NULL,'2013-04-03 17:58:22','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1007,1,NULL,'2013-03-30 08:05:22','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1008,1,NULL,'2013-04-17 04:33:37','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1010,1,NULL,'2013-03-13 23:15:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1011,1,NULL,'2013-04-22 02:48:35','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1013,1,NULL,'2013-03-12 05:54:09','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1014,1,NULL,'2013-04-09 19:20:40','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1015,1,NULL,'2013-04-07 23:48:13','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1017,1,NULL,'2013-04-09 13:45:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1019,1,NULL,'2013-04-16 04:28:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1022,1,NULL,'2013-04-28 00:19:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1023,1,NULL,'2013-04-24 11:18:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1024,1,NULL,'2013-04-03 05:24:28','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1025,1,NULL,'2013-04-27 17:10:31','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1027,1,NULL,'2013-04-11 12:58:13','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1028,1,NULL,'2013-04-25 15:03:57','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1029,1,NULL,'2013-03-14 11:31:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1033,1,NULL,'2013-03-12 22:32:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1035,1,NULL,'2013-03-23 12:03:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1036,1,NULL,'2013-04-06 07:25:25','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1037,1,NULL,'2013-04-26 16:46:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1038,1,NULL,'2013-03-13 09:34:15','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1041,1,NULL,'2013-04-12 07:40:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1043,1,NULL,'2013-04-16 21:51:32','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1045,1,NULL,'2013-04-14 14:11:35','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1049,1,NULL,'2013-03-24 19:32:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1050,1,NULL,'2013-04-15 11:22:07','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1052,1,NULL,'2013-04-01 15:40:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1054,1,NULL,'2013-04-06 19:07:27','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1055,1,NULL,'2013-04-06 06:59:02','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1057,1,NULL,'2013-03-09 03:14:14','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1058,1,NULL,'2013-03-15 04:52:32','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1061,1,NULL,'2013-03-24 10:59:28','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1063,1,NULL,'2013-03-30 17:22:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1067,1,NULL,'2013-04-28 03:32:37','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1068,1,NULL,'2013-04-12 18:51:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1070,1,NULL,'2013-04-10 14:46:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1075,1,NULL,'2013-03-23 23:46:40','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1078,1,NULL,'2013-04-05 09:57:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1079,1,NULL,'2013-03-17 20:54:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1081,1,NULL,'2013-04-13 07:42:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1084,1,NULL,'2013-04-26 05:41:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1085,1,NULL,'2013-03-18 21:07:09','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1089,1,NULL,'2013-03-16 23:24:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1091,1,NULL,'2013-03-31 23:13:42','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1092,1,NULL,'2013-04-28 00:59:16','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1093,1,NULL,'2013-03-31 19:45:41','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1097,1,NULL,'2013-03-31 17:10:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1098,1,NULL,'2013-04-15 22:50:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1100,1,NULL,'2013-03-14 17:11:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1101,1,NULL,'2013-04-20 16:30:25','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1102,1,NULL,'2013-03-12 13:28:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1103,1,NULL,'2013-03-29 21:38:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1105,1,NULL,'2013-04-11 18:23:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1110,1,NULL,'2013-03-09 13:51:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1111,1,NULL,'2013-04-02 10:12:45','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(1113,1,NULL,'2013-04-25 07:33:03','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn');
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
INSERT INTO `seat_position` VALUES (1219,'A4','active'),(1219,'A5','active'),(1219,'C10','active'),(1220,'B11','active'),(1220,'B2','active'),(1220,'C1','active'),(1220,'C5','active'),(1220,'D3','active'),(1221,'B9','active'),(1221,'D10','active'),(1221,'D7','active'),(1222,'D10','active'),(1222,'D5','active'),(1223,'A9','active'),(1223,'B1','active'),(1223,'B10','active'),(1223,'D6','active'),(1224,'A11','active'),(1224,'B10','active'),(1224,'C10','active'),(1224,'D9','active'),(1225,'A9','active'),(1225,'B1','active'),(1225,'C11','active'),(1226,'A4','active'),(1227,'A1','active'),(1228,'B4','active'),(1228,'B5','active'),(1228,'D2','active'),(1228,'D5','active'),(1229,'A2','active'),(1229,'B9','active'),(1229,'D11','active'),(1230,'D9','active'),(1231,'B5','active'),(1232,'D8','active'),(1233,'A11','active'),(1233,'B4','active'),(1233,'D9','active'),(1234,'C1','active'),(1234,'C7','active'),(1234,'D4','active'),(1235,'A7','active'),(1235,'C9','active'),(1235,'D11','active'),(1235,'D6','active'),(1236,'A8','active'),(1236,'B4','active'),(1236,'C10','active'),(1236,'C8','active'),(1237,'B6','active'),(1237,'B7','active'),(1237,'C5','active'),(1237,'C8','active'),(1237,'D8','active'),(1238,'C11','active'),(1239,'C1','active'),(1239,'D3','active'),(1239,'D8','active'),(1240,'A10','active'),(1240,'B7','active'),(1240,'C11','active'),(1243,'A11','active'),(1243,'A2','active'),(1245,'B2','active'),(1245,'B5','active'),(1245,'C10','active'),(1245,'C2','active'),(1245,'D9','active'),(1246,'C5','active'),(1248,'D1','active'),(1248,'D7','active'),(1249,'B3','active'),(1249,'C8','active'),(1252,'B1','active'),(1252,'B10','active'),(1252,'D3','active'),(1252,'D6','active'),(1253,'A8','active'),(1253,'D4','active'),(1253,'D5','active'),(1253,'D8','active'),(1254,'A3','active'),(1254,'C6','active'),(1255,'A9','active'),(1255,'D8','active'),(1258,'B9','active'),(1258,'D5','active'),(1259,'C7','active'),(1259,'D10','active'),(1260,'A5','active'),(1260,'A9','active'),(1261,'B11','active'),(1261,'B9','active'),(1262,'A11','active'),(1263,'C6','active'),(1263,'C7','active'),(1264,'A10','active'),(1265,'A9','active'),(1265,'B11','active'),(1265,'D10','active'),(1266,'A8','active'),(1266,'B8','active'),(1266,'C11','active'),(1269,'B1','active'),(1269,'B3','active'),(1272,'A8','active'),(1272,'C4','active'),(1272,'D10','active'),(1276,'D8','active'),(1277,'B5','active'),(1280,'C10','active'),(1281,'A6','active'),(1281,'C1','active'),(1281,'D5','active'),(1283,'A1','active'),(1283,'A8','active'),(1283,'C11','active'),(1283,'D11','active'),(1283,'D5','active'),(1284,'A11','active'),(1284,'D6','active'),(1284,'D8','active'),(1285,'A6','active'),(1285,'B3','active'),(1285,'C6','active'),(1286,'A1','active'),(1286,'B10','active'),(1286,'C8','active'),(1286,'D2','active'),(1289,'C2','active'),(1289,'C4','active'),(1289,'C6','active'),(1290,'B2','active'),(1290,'C8','active'),(1290,'D4','active'),(1292,'A3','active'),(1296,'A9','active'),(1296,'D2','active'),(1297,'A1','active'),(1297,'A10','active'),(1298,'A6','active'),(1298,'B5','active'),(1299,'B4','active'),(1299,'B7','active'),(1299,'C7','active'),(1299,'C9','active'),(1299,'D5','active'),(1300,'A8','active'),(1300,'B1','active'),(1300,'C8','active'),(1300,'D1','active'),(1301,'A4','active'),(1301,'A8','active'),(1301,'B6','active'),(1301,'C6','active'),(1304,'C3','active'),(1305,'B4','active'),(1306,'A4','active'),(1306,'B8','active'),(1306,'C7','active'),(1306,'D4','active'),(1311,'D5','active'),(1311,'D8','active'),(1314,'A9','active'),(1314,'C4','active'),(1314,'D1','active'),(1314,'D8','active'),(1315,'C6','active'),(1316,'C2','active'),(1317,'A1','active'),(1317,'A5','active'),(1317,'B3','active'),(1317,'D11','active'),(1320,'C10','active'),(1320,'C4','active'),(1320,'D7','active'),(1321,'A2','active'),(1321,'A9','active'),(1321,'D1','active'),(1323,'A8','active'),(1323,'B1','active'),(1323,'B5','active'),(1323,'B6','active'),(1326,'B3','active'),(1331,'B7','active'),(1331,'D11','active'),(1332,'A10','active'),(1332,'C2','active'),(1333,'A6','active'),(1333,'D5','active'),(1335,'C1','active'),(1335,'C10','active'),(1335,'C2','active'),(1335,'C7','active'),(1336,'A7','active'),(1336,'D11','active'),(1336,'D5','active'),(1336,'D6','active'),(1338,'B9','active'),(1339,'B4','active'),(1340,'A2','active'),(1340,'A4','active'),(1340,'C6','active'),(1340,'C9','active'),(1342,'B9','active'),(1343,'A3','active'),(1343,'C11','active'),(1343,'C5','active'),(1343,'D7','active'),(1346,'B3','active'),(1346,'C10','active'),(1346,'C3','active'),(1346,'D5','active'),(1346,'D9','active'),(1348,'B10','active'),(1348,'C10','active'),(1355,'B2','active'),(1356,'A4','active'),(1356,'C10','active'),(1359,'B10','active'),(1359,'C1','active'),(1359,'C6','active'),(1359,'D7','active'),(1364,'A4','active'),(1364,'B8','active'),(1364,'C11','active'),(1364,'D10','active'),(1365,'A2','active'),(1365,'C9','active'),(1365,'D5','active'),(1365,'D8','active'),(1369,'B1','active'),(1369,'B9','active'),(1370,'A4','active'),(1370,'A9','active'),(1370,'C7','active'),(1370,'D9','active'),(1373,'C11','active'),(1377,'A1','active'),(1377,'A6','active'),(1377,'A7','active'),(1377,'B11','active'),(1377,'D1','active'),(1378,'B4','active'),(1378,'D2','active'),(1383,'A3','active'),(1383,'A7','active'),(1383,'B7','active'),(1383,'B9','active'),(1386,'C9','active'),(1386,'D4','active'),(1387,'A5','active'),(1387,'C1','active'),(1388,'D3','active'),(1389,'A6','active'),(1389,'B7','active'),(1389,'D7','active'),(1395,'A2','active'),(1395,'B3','active'),(1396,'C6','active'),(1396,'D10','active'),(1397,'C9','active'),(1399,'A5','active'),(1400,'A4','active'),(1400,'B2','active'),(1400,'C6','active'),(1401,'A10','active'),(1401,'D11','active'),(1402,'A7','active'),(1402,'B2','active'),(1404,'C3','active'),(1404,'C4','active'),(1404,'D2','active'),(1404,'D6','active'),(1410,'A7','active'),(1410,'B7','active'),(1410,'C10','active'),(1410,'C4','active'),(1410,'C5','active'),(1411,'D2','active'),(1411,'D5','active'),(1412,'C7','active'),(1412,'D9','active'),(1414,'A9','active'),(1414,'B11','active'),(1414,'B7','active'),(1414,'D10','active');
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
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `ticket_reservation_id_idx` (`reservation_id`),
  CONSTRAINT `ticket_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1415 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1219,964,'active'),(1220,965,'active'),(1221,966,'active'),(1222,967,'active'),(1223,968,'active'),(1224,968,'active'),(1225,969,'active'),(1226,970,'active'),(1227,971,'active'),(1228,972,'active'),(1229,973,'active'),(1230,974,'active'),(1231,974,'active'),(1232,975,'active'),(1233,976,'active'),(1234,976,'active'),(1235,977,'active'),(1236,977,'active'),(1237,978,'active'),(1238,979,'active'),(1239,980,'active'),(1240,980,'active'),(1243,982,'active'),(1245,984,'active'),(1246,985,'active'),(1248,987,'active'),(1249,988,'active'),(1252,990,'active'),(1253,990,'active'),(1254,991,'active'),(1255,991,'active'),(1258,993,'active'),(1259,993,'active'),(1260,994,'active'),(1261,994,'active'),(1262,995,'active'),(1263,996,'active'),(1264,997,'active'),(1265,998,'active'),(1266,998,'active'),(1269,1001,'active'),(1272,1004,'active'),(1276,1007,'active'),(1277,1008,'active'),(1280,1010,'active'),(1281,1011,'active'),(1283,1013,'active'),(1284,1014,'active'),(1285,1014,'active'),(1286,1015,'active'),(1289,1017,'active'),(1290,1017,'active'),(1292,1019,'active'),(1296,1022,'active'),(1297,1023,'active'),(1298,1023,'active'),(1299,1024,'active'),(1300,1025,'active'),(1301,1025,'active'),(1304,1027,'active'),(1305,1028,'active'),(1306,1029,'active'),(1311,1033,'active'),(1314,1035,'active'),(1315,1036,'active'),(1316,1037,'active'),(1317,1038,'active'),(1320,1041,'active'),(1321,1041,'active'),(1323,1043,'active'),(1326,1045,'active'),(1331,1049,'active'),(1332,1050,'active'),(1333,1050,'active'),(1335,1052,'active'),(1336,1052,'active'),(1338,1054,'active'),(1339,1054,'active'),(1340,1055,'active'),(1342,1057,'active'),(1343,1058,'active'),(1346,1061,'active'),(1348,1063,'active'),(1355,1067,'active'),(1356,1068,'active'),(1359,1070,'active'),(1364,1075,'active'),(1365,1075,'active'),(1369,1078,'active'),(1370,1079,'active'),(1373,1081,'active'),(1377,1084,'active'),(1378,1085,'active'),(1383,1089,'active'),(1386,1091,'active'),(1387,1091,'active'),(1388,1092,'active'),(1389,1093,'active'),(1395,1097,'active'),(1396,1097,'active'),(1397,1098,'active'),(1399,1100,'active'),(1400,1101,'active'),(1401,1102,'active'),(1402,1103,'active'),(1404,1105,'active'),(1410,1110,'active'),(1411,1111,'active'),(1412,1111,'active'),(1414,1113,'active');
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
INSERT INTO `trip_in_ticket` VALUES (1401,7),(1355,8),(1401,8),(1410,8),(1258,9),(1355,9),(1386,9),(1401,9),(1410,9),(1237,10),(1258,10),(1260,10),(1355,10),(1386,10),(1411,10),(1235,11),(1237,11),(1258,11),(1260,11),(1355,11),(1364,11),(1411,11),(1237,12),(1258,12),(1260,12),(1355,12),(1364,12),(1311,13),(1320,13),(1355,13),(1369,13),(1259,15),(1261,15),(1335,15),(1365,15),(1259,16),(1261,16),(1264,16),(1365,16),(1412,16),(1259,17),(1261,17),(1264,17),(1387,17),(1412,17),(1259,18),(1280,18),(1387,18),(1283,20),(1389,20),(1306,22),(1300,23),(1306,23),(1228,24),(1300,24),(1306,24),(1284,25),(1300,25),(1306,25),(1265,26),(1284,26),(1300,26),(1252,27),(1265,27),(1346,28),(1301,29),(1346,29),(1297,30),(1301,30),(1346,30),(1297,31),(1299,31),(1301,31),(1348,31),(1395,31),(1239,32),(1297,32),(1299,32),(1301,32),(1348,32),(1395,32),(1239,33),(1297,33),(1299,33),(1348,33),(1395,33),(1239,34),(1248,34),(1289,34),(1297,34),(1348,34),(1223,35),(1240,35),(1298,35),(1223,36),(1240,36),(1298,36),(1222,37),(1223,37),(1240,37),(1298,37),(1232,38),(1298,38),(1356,38),(1232,39),(1298,39),(1338,39),(1356,39),(1359,39),(1225,40),(1230,40),(1232,40),(1336,40),(1230,41),(1232,41),(1246,42),(1263,42),(1246,43),(1263,43),(1296,43),(1305,43),(1236,44),(1246,44),(1263,44),(1296,44),(1317,44),(1246,45),(1263,45),(1296,45),(1317,45),(1383,45),(1224,46),(1246,46),(1263,46),(1314,46),(1316,46),(1317,46),(1383,46),(1388,46),(1224,47),(1246,47),(1263,47),(1314,47),(1317,47),(1323,47),(1388,47),(1397,47),(1224,48),(1263,48),(1314,48),(1397,48),(1227,49),(1233,49),(1281,49),(1227,50),(1233,50),(1281,50),(1396,50),(1227,51),(1233,51),(1238,51),(1281,51),(1332,51),(1396,51),(1227,52),(1238,52),(1281,52),(1396,52),(1227,53),(1238,53),(1249,53),(1281,53),(1404,53),(1227,54),(1281,54),(1404,54),(1227,55),(1342,55),(1343,55),(1400,55),(1404,55),(1219,56),(1231,56),(1266,56),(1321,56),(1219,57),(1231,57),(1266,57),(1219,58),(1221,58),(1339,58),(1377,58),(1219,59),(1221,59),(1331,59),(1377,59),(1219,60),(1221,60),(1269,60),(1377,60),(1221,61),(1254,61),(1269,61),(1276,61),(1377,61),(1254,62),(1269,62),(1276,62),(1255,63),(1290,63),(1399,63),(1229,64),(1255,64),(1399,64),(1229,65),(1272,65),(1373,65),(1229,66),(1262,66),(1272,66),(1292,66),(1373,66),(1220,67),(1229,67),(1262,67),(1272,67),(1292,67),(1373,67),(1220,68),(1229,68),(1262,68),(1272,68),(1277,68),(1373,68),(1220,69),(1272,69),(1277,69),(1370,69),(1373,69),(1253,70),(1243,71),(1285,71),(1226,72),(1243,72),(1285,72),(1414,72),(1340,73),(1414,73),(1234,74),(1333,74),(1340,74),(1378,74),(1414,74),(1234,75),(1245,75),(1304,75),(1326,75),(1340,75),(1378,75),(1414,75),(1234,76),(1286,76),(1304,76),(1315,76),(1326,76),(1402,76),(1414,76);
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
                              IN BUS_TYPE INT)
BEGIN
SELECT  dept.bus_status_id,
		dept.city_name       		AS departure_city,
	    dept.station_name    		AS departure_station_name,
	    dept.station_address 		AS departure_station_address,
        dept.departure_time,
		arrv.city_name       		AS arrival_city,
        arrv.station_name    		AS arrival_station_name,
		arrv.station_address 		AS arrival_station_address,
		arrv.arrival_time,
        SUM(trff.fare) * PSSGR_NO 	AS fare
FROM   
	-- departure trip information
	    (SELECT dtrp.bus_status_id,
				ddtl.city_name,
			 	ddtl.station_name, 
				ddtl.station_address,
				dtrp.departure_time
         FROM trip dtrp
           INNER JOIN
			 (SELECT drdt.id      AS route_details_id,
				     dsta.name    AS station_name,
			 		 dcty.name    AS city_name,                               			
					 dsta.address AS station_address
			  FROM   route_details drdt
				INNER JOIN route    drou ON drou.id = drdt.route_id
				INNER JOIN segment  dseg ON dseg.id = drdt.segment_id        			
				INNER JOIN station  dsta ON dsta.id = dseg.departure_station_id			   
				INNER JOIN location dcty ON dcty.id = dsta.location_id             			     
			 WHERE  dcty.id = DEPT_CITY) ddtl
		   ON dtrp.route_details_id = ddtl.route_details_id
		 WHERE DATE(dtrp.departure_time) = DATE(DEPT_DATE)
		   AND DATE(dtrp.departure_time) >= ADDTIME(NOW(), '0 0:30:0.000000')) dept
	INNER JOIN	 
	-- arrival trip information
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
-- fare information
	INNER JOIN trip ftrp
      ON dept.bus_status_id = ftrp.bus_status_id
        AND dept.departure_time <= ftrp.departure_time
	    AND arrv.arrival_time >= ftrp.arrival_time
    INNER JOIN route_details frdt 
      ON ftrp.route_details_id = frdt.id
    INNER JOIN tariff trff 
	  ON frdt.segment_id = trff.segment_id 
        AND trff.bus_type_id = BUS_TYPE
	INNER JOIN remained_seats rmst
	  ON rmst.start_location_id = DEPT_CITY AND 
		 rmst.end_location_id = ARRV_CITY AND 
		 rmst.bus_status_id = dept.bus_status_id
WHERE   -- departure date is in range of valid fare dates
        trff.valid_from IN (SELECT MAX(ttrf.valid_from) 
                            FROM   tariff ttrf 
                            WHERE  ttrf.valid_from <= ftrp.departure_time AND
								   ttrf.segment_id = trff.segment_id) AND
        rmst.number_of_remained_seats >= PSSGR_NO
GROUP BY ftrp.bus_status_id;
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

-- Dump completed on 2013-03-07 13:53:23
