CREATE DATABASE  IF NOT EXISTS `bus_reservation` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bus_reservation`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: bus_reservation
-- ------------------------------------------------------
-- Server version	5.5.28

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (76,'An Giang'),(64,'Bà Rịa Vũng Tàu'),(75,'Bến Tre'),(62,'Bình Thuận'),(56,'Bình Định'),(4,'Hà Nội'),(39,'Hà Tĩnh'),(31,'Hải Phòng'),(58,'Khánh Hoà'),(63,'Lâm Đồng'),(25,'Lạng Sơn'),(20,'Lào Cai'),(72,'Long An'),(38,'Nghệ An'),(52,'Quảng Bình'),(55,'Quảng Ngãi'),(66,'Tây Ninh'),(37,'Thanh Hoá'),(54,'Thừa Thiên Huế'),(8,'TP. Hồ Chí Minh'),(29,'Yên Bái'),(511,'Đà Nẵng'),(61,'Đồng Nai');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (11,153,397000,17500,2,'68X2160439520110L','pay'),(12,130,1958000,63000,2,'61269572B6664915S','pay'),(15,137,527000,21000,2,'5J777951W1357152F','pay'),(16,130,208000,6000,2,'2G122410L22675119','refund'),(17,137,368000,10500,2,'69J401522L9850834','refund');
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
  `start_city_id` int(11),
  `end_city_id` int(11),
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
  `phone` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `reservation_booker_id_idx` (`user_id`),
  CONSTRAINT `reservation_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (130,1,'BDYBHD','2013-02-25 13:13:47','refunded','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(131,1,NULL,'2013-02-19 19:11:18','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(132,1,NULL,'2013-03-10 03:36:07','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(133,1,NULL,'2013-03-09 06:05:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(134,1,NULL,'2013-03-08 20:23:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(135,1,NULL,'2013-03-04 04:45:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(136,1,NULL,'2013-03-02 07:41:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(137,1,'BEP5WF','2013-02-26 07:05:34','refunded','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(138,1,NULL,'2013-02-26 12:07:52','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(139,1,NULL,'2013-02-22 17:17:56','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(140,1,NULL,'2013-02-18 18:29:52','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(141,1,NULL,'2013-02-24 01:34:38','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(142,1,NULL,'2013-02-09 10:49:05','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(143,1,NULL,'2013-02-24 02:30:46','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(144,1,NULL,'2013-02-23 08:58:12','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(145,1,NULL,'2013-02-16 12:51:46','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(146,1,NULL,'2013-03-01 20:01:59','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(147,1,NULL,'2013-02-23 03:30:18','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(148,1,NULL,'2013-03-01 15:10:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(149,1,NULL,'2013-03-05 10:37:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(150,1,NULL,'2013-02-14 17:53:38','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(151,1,NULL,'2013-03-01 16:06:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(152,1,NULL,'2013-02-05 22:37:43','deleted','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(153,NULL,'25G3Q6','2013-02-21 11:12:00','paid','Trường','Nguyễn Sơn','123456789','truongns60466@fpt.edu.vn'),(173,NULL,NULL,'2013-02-22 17:35:56','unpaid','Trường','Nguyễn Sơn','123456789','truongns60466@fpt.edu.vn'),(174,NULL,NULL,'2013-02-22 18:22:32','unpaid','Trường','Nguyễn Sơn','123456','truongns60466@fpt.edu.vn'),(175,1,NULL,'2013-03-04 07:49:35','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(176,1,NULL,'2013-03-06 08:45:18','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(177,1,NULL,'2013-03-24 14:20:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(178,1,NULL,'2013-04-12 08:28:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(179,1,NULL,'2013-04-14 22:46:02','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(180,1,NULL,'2013-04-14 11:38:06','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(181,1,NULL,'2013-04-21 08:25:17','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(182,1,NULL,'2013-04-30 05:26:20','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(183,1,NULL,'2013-05-10 01:29:08','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(184,1,NULL,'2013-05-15 00:02:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(185,1,NULL,'2013-05-26 08:03:12','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(186,1,NULL,'2013-06-05 02:45:43','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(187,1,NULL,'2013-06-09 09:03:07','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(188,1,NULL,'2013-06-23 06:45:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(189,1,NULL,'2013-06-30 19:58:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(190,1,NULL,'2013-07-04 03:52:31','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(191,1,NULL,'2013-07-12 06:23:39','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(192,1,NULL,'2013-07-25 05:37:41','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(193,1,NULL,'2013-07-25 02:31:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(194,1,NULL,'2013-08-11 20:48:18','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(195,1,NULL,'2013-08-24 07:51:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(196,1,NULL,'2013-09-11 18:33:29','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(197,1,NULL,'2013-09-11 08:57:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(198,1,NULL,'2013-09-11 03:33:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(199,1,NULL,'2013-09-24 04:41:29','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(200,1,NULL,'2013-10-01 18:22:09','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(201,1,NULL,'2013-10-13 03:53:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(202,1,NULL,'2013-10-25 06:22:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(203,1,NULL,'2013-10-29 14:02:43','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(204,1,NULL,'2013-11-17 07:17:08','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(205,1,NULL,'2013-11-18 22:08:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(206,1,NULL,'2013-11-20 00:16:16','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(207,1,NULL,'2013-12-01 12:34:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(208,1,NULL,'2013-12-11 13:54:02','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(209,1,NULL,'2013-12-29 04:57:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(210,1,NULL,'2013-12-29 22:21:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(211,1,NULL,'2014-01-12 05:40:24','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(212,1,NULL,'2014-01-19 12:20:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(213,1,NULL,'2014-02-03 01:22:20','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(214,1,NULL,'2014-02-16 01:57:44','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(215,1,NULL,'2014-03-04 10:05:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(216,1,NULL,'2014-03-07 22:11:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(217,1,NULL,'2014-03-08 12:16:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(218,1,NULL,'2014-03-13 20:52:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(219,1,NULL,'2014-03-22 19:04:59','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(220,1,NULL,'2014-03-31 19:13:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(221,1,NULL,'2014-04-03 19:17:53','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(222,1,NULL,'2014-04-06 17:37:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(223,1,NULL,'2014-04-17 16:50:18','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(224,1,NULL,'2014-04-22 22:45:25','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(225,1,NULL,'2014-04-27 16:49:26','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(226,1,NULL,'2014-04-27 18:54:31','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(227,1,NULL,'2014-05-05 22:55:36','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(228,1,NULL,'2014-05-09 20:37:28','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(229,1,NULL,'2014-05-17 00:38:33','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(230,1,NULL,'2014-05-16 19:27:36','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(231,1,NULL,'2014-05-20 02:24:01','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(232,1,NULL,'2014-06-08 09:04:41','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(233,1,NULL,'2014-06-13 15:29:21','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(234,1,NULL,'2014-06-13 05:40:49','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(235,1,NULL,'2014-06-27 17:54:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(236,1,NULL,'2014-07-14 14:14:25','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(237,1,NULL,'2014-07-29 12:09:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(238,1,NULL,'2014-08-02 19:30:29','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(239,1,NULL,'2014-08-21 17:21:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(240,1,NULL,'2014-08-23 22:59:30','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(241,1,NULL,'2014-08-27 20:00:50','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(242,1,NULL,'2014-09-05 00:11:48','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(243,1,NULL,'2014-09-15 10:03:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(244,1,NULL,'2014-09-15 18:00:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn');
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
INSERT INTO `route_details` VALUES (7,7,1),(20,7,2),(8,8,1),(19,8,2),(9,9,1),(18,9,2),(10,10,1),(17,10,2),(11,11,1),(16,11,2),(12,12,1),(15,12,2),(13,13,1),(14,13,2);
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
  `reservation_id` int(11) NOT NULL,
  `seat_name` varchar(5) NOT NULL,
  PRIMARY KEY (`reservation_id`,`seat_name`),
  KEY `seat_position_in_reservation_reservation_id_idx` (`reservation_id`),
  CONSTRAINT `seat_position_in_reservation_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_position`
--

LOCK TABLES `seat_position` WRITE;
/*!40000 ALTER TABLE `seat_position` DISABLE KEYS */;
INSERT INTO `seat_position` VALUES (130,'A16'),(130,'A3'),(130,'A9'),(130,'B20'),(130,'C6'),(131,'B9'),(131,'C10'),(131,'C16'),(131,'D10'),(131,'D16'),(132,'A16'),(132,'B6'),(132,'B7'),(132,'C13'),(132,'D1'),(133,'A17'),(133,'A18'),(133,'B4'),(133,'C1'),(133,'C10'),(134,'A9'),(134,'B14'),(134,'C4'),(134,'D1'),(134,'D3'),(135,'A12'),(135,'A3'),(135,'B7'),(135,'B8'),(135,'C20'),(136,'A8'),(136,'C14'),(136,'C19'),(136,'D19'),(137,'A8'),(137,'B11'),(137,'C1'),(137,'D13'),(138,'B20'),(138,'C15'),(138,'C3'),(138,'C9'),(139,'B1'),(139,'B13'),(139,'C3'),(139,'C4'),(140,'A17'),(140,'A2'),(140,'C12'),(140,'D1'),(140,'D7'),(141,'A16'),(141,'D15'),(141,'D16'),(141,'D3'),(141,'D7'),(142,'A1'),(142,'B18'),(142,'B7'),(142,'C16'),(142,'D13'),(143,'A18'),(143,'B13'),(143,'B9'),(143,'C2'),(143,'D14'),(144,'A7'),(144,'A8'),(144,'B4'),(144,'D14'),(144,'D2'),(145,'B16'),(145,'B17'),(145,'B4'),(145,'B8'),(145,'D6'),(146,'A1'),(146,'A16'),(146,'B3'),(146,'C16'),(146,'D17'),(147,'A1'),(147,'A16'),(147,'B13'),(147,'B6'),(147,'D15'),(148,'A10'),(148,'A5'),(148,'C1'),(148,'C12'),(149,'B3'),(149,'C16'),(149,'C6'),(149,'D13'),(149,'D7'),(150,'A17'),(150,'B16'),(150,'B7'),(150,'C17'),(150,'D1'),(151,'B2'),(151,'B20'),(151,'C10'),(151,'D7'),(151,'D9'),(152,'A11'),(152,'A9'),(152,'C20'),(152,'C3'),(152,'D19'),(153,'A7'),(153,'B7'),(153,'D7'),(173,'A8'),(173,'B8'),(174,'A8'),(174,'B8'),(175,'A10'),(175,'B4'),(175,'D11'),(175,'D2'),(175,'D3'),(176,'A1'),(176,'C10'),(176,'C5'),(176,'C6'),(177,'B7'),(177,'C10'),(177,'C8'),(177,'D7'),(177,'D8'),(178,'B4'),(178,'B7'),(178,'D10'),(178,'D3'),(178,'D8'),(179,'A3'),(179,'C1'),(179,'C6'),(179,'D10'),(179,'D8'),(180,'A1'),(180,'A9'),(180,'B11'),(180,'D1'),(180,'D7'),(181,'A3'),(181,'B4'),(181,'B5'),(181,'B9'),(181,'C9'),(182,'A3'),(182,'B10'),(182,'B7'),(182,'B9'),(182,'C5'),(183,'B5'),(183,'D10'),(183,'D2'),(183,'D3'),(183,'D4'),(184,'A4'),(184,'A5'),(184,'C4'),(184,'D11'),(184,'D2'),(185,'A2'),(185,'A9'),(185,'B6'),(185,'C3'),(185,'D2'),(186,'A9'),(186,'C1'),(186,'C10'),(186,'C6'),(187,'A8'),(187,'B10'),(187,'B2'),(187,'B8'),(188,'A1'),(188,'A4'),(188,'B10'),(188,'C3'),(188,'D7'),(189,'A3'),(189,'A5'),(189,'B2'),(189,'B6'),(189,'D3'),(190,'A11'),(190,'B10'),(190,'B8'),(190,'C2'),(190,'D8'),(191,'A9'),(191,'C1'),(191,'C11'),(191,'D7'),(192,'A3'),(192,'B7'),(192,'B9'),(192,'C2'),(192,'C3'),(193,'C11'),(193,'C2'),(193,'D2'),(193,'D6'),(194,'A1'),(194,'A11'),(194,'A3'),(194,'A6'),(194,'C11'),(195,'A11'),(195,'A8'),(195,'B4'),(195,'C1'),(195,'D6'),(196,'A2'),(196,'B8'),(196,'C3'),(196,'D10'),(197,'B1'),(197,'B11'),(197,'C1'),(197,'C10'),(197,'D11'),(198,'B3'),(198,'C11'),(198,'C4'),(198,'C8'),(198,'D4'),(199,'B11'),(199,'D2'),(199,'D3'),(199,'D9'),(200,'B4'),(200,'B5'),(200,'B6'),(200,'D1'),(200,'D11'),(201,'A8'),(201,'B4'),(201,'C5'),(201,'D3'),(202,'A8'),(202,'C7'),(202,'D4'),(202,'D7'),(203,'B8'),(203,'B9'),(203,'C8'),(203,'D3'),(203,'D6'),(204,'A5'),(204,'B11'),(204,'C10'),(204,'D10'),(204,'D5'),(205,'A1'),(205,'A7'),(205,'A9'),(205,'C11'),(205,'D2'),(206,'A5'),(206,'A8'),(206,'C7'),(206,'D11'),(206,'D6'),(207,'A5'),(207,'B7'),(207,'D1'),(207,'D10'),(207,'D8'),(208,'A4'),(208,'A5'),(208,'B11'),(208,'D11'),(208,'D5'),(209,'B8'),(209,'C1'),(209,'C3'),(209,'D3'),(209,'D9'),(210,'B9'),(210,'C2'),(210,'C6'),(210,'D10'),(210,'D2'),(211,'A10'),(211,'A2'),(211,'A4'),(211,'B3'),(211,'D9'),(212,'A1'),(212,'B2'),(212,'B8'),(212,'C3'),(212,'C6'),(213,'A1'),(213,'A10'),(213,'D11'),(213,'D2'),(213,'D7'),(214,'A6'),(214,'A9'),(214,'B2'),(214,'C2'),(214,'C9'),(215,'B9'),(215,'C5'),(215,'D11'),(215,'D7'),(215,'D9'),(216,'A4'),(216,'B9'),(216,'C1'),(216,'C5'),(216,'D9'),(217,'A7'),(217,'B1'),(217,'D4'),(217,'D5'),(217,'D8'),(218,'A1'),(218,'A5'),(218,'C7'),(218,'C9'),(218,'D1'),(219,'A10'),(219,'B10'),(219,'B3'),(219,'B4'),(219,'B9'),(220,'B6'),(220,'C2'),(220,'C6'),(220,'D3'),(221,'A4'),(221,'A5'),(221,'B1'),(221,'B5'),(221,'D5'),(222,'A7'),(222,'B4'),(222,'B7'),(222,'C5'),(222,'D11'),(223,'B1'),(223,'B11'),(223,'C10'),(223,'C4'),(223,'D3'),(224,'B7'),(224,'C11'),(224,'C5'),(224,'C8'),(224,'D2'),(225,'A5'),(225,'B5'),(225,'C1'),(225,'C2'),(225,'C8'),(226,'A7'),(226,'B1'),(226,'B9'),(226,'C1'),(226,'D4'),(227,'A10'),(227,'A7'),(227,'A9'),(227,'B8'),(227,'C1'),(228,'A3'),(228,'A8'),(228,'B8'),(228,'C10'),(228,'C9'),(229,'A4'),(229,'B3'),(229,'B5'),(229,'D11'),(229,'D6'),(230,'A8'),(230,'B11'),(230,'B5'),(230,'D3'),(230,'D6'),(231,'A2'),(231,'B8'),(231,'D10'),(231,'D9'),(232,'A10'),(232,'A11'),(232,'C7'),(232,'D10'),(232,'D11'),(233,'A9'),(233,'B11'),(233,'C2'),(233,'C9'),(233,'D4'),(234,'A5'),(234,'A6'),(234,'C6'),(234,'C9'),(234,'D5'),(235,'A2'),(235,'B1'),(235,'B8'),(235,'C6'),(235,'D5'),(236,'A10'),(236,'A6'),(236,'D1'),(236,'D10'),(237,'A1'),(237,'A2'),(237,'A6'),(237,'D3'),(237,'D6'),(238,'A2'),(238,'B11'),(238,'B3'),(238,'B4'),(238,'D7'),(239,'A3'),(239,'B10'),(239,'B8'),(239,'C11'),(239,'C9'),(240,'B11'),(240,'D2'),(240,'D4'),(240,'D6'),(240,'D8'),(241,'C10'),(241,'C11'),(241,'C3'),(241,'D10'),(241,'D3'),(242,'A10'),(242,'B5'),(242,'C8'),(242,'D2'),(242,'D4'),(243,'A3'),(243,'A8'),(243,'B9'),(243,'C11'),(243,'D5'),(244,'A1'),(244,'A10'),(244,'A7'),(244,'B4'),(244,'D9');
/*!40000 ALTER TABLE `seat_position` ENABLE KEYS */;
UNLOCK TABLES;

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
  `travel_time` time NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `segment_arrive_station_id_idx` (`departure_station_id`),
  KEY `segment_depart_station_id_idx` (`arrival_station_id`),
  CONSTRAINT `segment_arrive_station_id` FOREIGN KEY (`departure_station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `segment_depart_station_id` FOREIGN KEY (`arrival_station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment`
--

LOCK TABLES `segment` WRITE;
/*!40000 ALTER TABLE `segment` DISABLE KEYS */;
INSERT INTO `segment` VALUES (1,1,2,'01:30:00','active'),(2,2,1,'01:30:00','active'),(3,3,5,'10:00:00','active'),(4,5,7,'06:00:00','active'),(5,7,6,'09:00:00','active'),(6,6,8,'04:00:00','active'),(7,3,35,'04:30:00','active'),(8,35,34,'04:30:00','active'),(9,34,33,'01:15:00','active'),(10,33,32,'03:45:00','active'),(11,32,31,'03:00:00','active'),(12,31,5,'03:00:00','active'),(13,5,8,'16:00:00','active');
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
  `city_id` int(11) NOT NULL,
  `address` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `station_city_id_idx` (`city_id`),
  CONSTRAINT `station_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`)
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
  UNIQUE KEY `segment_in_route_id` (`segment_id`,`valid_from`),
  KEY `tariff_segment_in_route_id_idx` (`segment_id`),
  KEY `tariff_bus_type_id_idx` (`bus_type_id`),
  CONSTRAINT `tariff_bus_type_id` FOREIGN KEY (`bus_type_id`) REFERENCES `bus_type` (`id`),
  CONSTRAINT `tariff_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,1,1,'2012-01-01 00:00:00',100000),(2,2,1,'2012-01-01 00:00:00',100000),(3,3,1,'2013-01-01 00:00:00',150000),(4,4,1,'2013-01-01 00:00:00',65000),(5,5,1,'2013-01-01 00:00:00',30000),(6,6,1,'2013-01-01 00:00:00',90000),(7,2,1,'2013-02-28 00:00:00',80000),(8,2,1,'2013-02-01 00:00:00',85000),(9,2,1,'2013-03-15 00:00:00',100000),(10,3,1,'2013-02-20 00:00:00',170000),(11,3,1,'2013-02-04 00:00:00',120000),(12,4,1,'2013-02-25 00:00:00',80000),(13,4,1,'2013-03-01 00:00:00',65000),(14,7,1,'2012-01-01 00:00:00',125000),(15,8,1,'2012-01-01 00:00:00',125000),(16,9,1,'2012-01-01 00:00:00',125000),(17,10,1,'2012-01-01 00:00:00',125000),(18,11,1,'2012-01-01 00:00:00',125000),(19,12,1,'2012-01-01 00:00:00',125000),(20,13,1,'2012-01-01 00:00:00',125000);
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
-- Table structure for table `trip_in_reservation`
--

DROP TABLE IF EXISTS `trip_in_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trip_in_reservation` (
  `reservation_id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  PRIMARY KEY (`reservation_id`,`trip_id`),
  KEY `trip_in_reservation_trip_id_idx` (`trip_id`),
  KEY `trip_in_reservation_reservation_id_idx` (`reservation_id`),
  CONSTRAINT `trip_in_reservation_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `trip_in_reservation_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_in_reservation`
--

LOCK TABLES `trip_in_reservation` WRITE;
/*!40000 ALTER TABLE `trip_in_reservation` DISABLE KEYS */;
INSERT INTO `trip_in_reservation` VALUES (153,7),(173,7),(174,7),(229,7),(240,7),(198,8),(220,8),(229,8),(240,8),(133,9),(198,9),(209,9),(220,9),(229,9),(236,9),(240,9),(133,10),(182,10),(193,10),(198,10),(203,10),(220,10),(240,10),(130,11),(182,11),(193,11),(198,11),(220,11),(240,11),(130,12),(193,12),(198,12),(240,12),(130,13),(198,13),(231,13),(240,13),(237,14),(144,15),(147,15),(237,15),(144,16),(237,16),(144,17),(239,17),(144,18),(232,18),(183,19),(175,20),(183,20),(244,20),(195,21),(226,21),(143,22),(195,22),(226,22),(135,23),(140,23),(143,23),(194,23),(195,23),(238,23),(135,24),(140,24),(143,24),(194,24),(238,24),(140,25),(143,25),(194,25),(234,25),(238,25),(140,26),(143,26),(234,26),(140,27),(176,27),(234,27),(178,28),(213,28),(227,28),(213,29),(227,29),(233,29),(141,30),(213,30),(227,30),(233,30),(141,31),(201,31),(202,31),(213,31),(227,31),(233,31),(141,32),(150,32),(202,32),(213,32),(227,32),(233,32),(150,33),(188,33),(202,33),(213,33),(216,33),(224,33),(227,33),(137,34),(150,34),(188,34),(189,34),(202,34),(213,34),(216,34),(199,35),(142,36),(199,36),(142,37),(199,37),(142,38),(142,39),(204,39),(206,39),(136,40),(204,40),(136,41),(190,41),(204,41),(148,42),(197,42),(180,43),(197,43),(180,44),(197,44),(210,44),(235,44),(180,45),(197,45),(210,45),(230,45),(235,45),(180,46),(208,46),(210,46),(221,46),(228,46),(230,46),(235,46),(208,47),(221,47),(235,47),(134,48),(235,48),(217,49),(225,49),(177,50),(217,50),(225,50),(241,50),(177,51),(217,51),(225,51),(241,51),(177,52),(217,52),(222,52),(139,53),(177,53),(222,53),(139,54),(177,54),(222,54),(242,54),(185,55),(222,55),(200,57),(151,58),(152,58),(200,58),(214,58),(151,59),(152,59),(179,59),(214,59),(219,59),(151,60),(152,60),(192,60),(211,60),(219,60),(151,61),(192,61),(211,61),(219,61),(138,62),(192,62),(205,62),(219,62),(243,63),(196,64),(243,64),(181,65),(196,65),(243,65),(181,66),(191,66),(196,66),(243,66),(181,67),(191,67),(196,67),(243,67),(132,68),(181,68),(191,68),(181,69),(186,69),(218,69),(149,70),(149,71),(223,71),(145,72),(215,72),(223,72),(146,73),(187,73),(207,73),(212,73),(215,73),(223,73),(131,74),(184,74),(207,74),(212,74),(215,74),(223,74),(131,75),(184,75),(131,76),(184,76);
/*!40000 ALTER TABLE `trip_in_reservation` ENABLE KEYS */;
UNLOCK TABLES;

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
  `start_city_id` int(11),
  `departure_time` datetime,
  `end_city_id` int(11),
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
  `start_city_id` int(11),
  `end_city_id` int(11),
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
  `start_city_id` int(11),
  `departure_time` datetime,
  `end_city_id` int(11),
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
/*!50001 VIEW `remained_seats` AS select `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_city_id` AS `start_city_id`,`tse`.`end_city_id` AS `end_city_id`,(`btp`.`number_of_seats` - count(distinct `sp`.`seat_name`)) AS `number_of_remained_seats` from ((((((`trip_start_end` `tse` left join `trip_in_reservation` `tir` on((`tir`.`trip_id` = `tse`.`trip_id`))) left join `reservation` `rsv` on(((`rsv`.`id` = `tir`.`reservation_id`) and ((`rsv`.`status` = 'paid') or ((`rsv`.`status` = 'unpaid') and (`rsv`.`book_time` >= (now() - '0000-00-00 00:15:00'))))))) left join `seat_position` `sp` on((`sp`.`reservation_id` = `rsv`.`id`))) join `bus_status` `bst` on((`bst`.`id` = `tse`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) group by `tse`.`bus_status_id`,`tse`.`start_city_id`,`tse`.`end_city_id`,`btp`.`number_of_seats` */;
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
/*!50001 VIEW `reservation_view` AS select `rsv`.`id` AS `reservation_id`,`trp_start`.`id` AS `start_trip_id`,`trp_end`.`id` AS `end_trip_id`,sum(`tar`.`fare`) AS `ticket_price`,`pay`.`pay_amount` AS `paid_amount`,`ref`.`refund_amount` AS `refund_amount` from (((((((((((((`reservation` `rsv` join `trip_in_reservation` `tir_start` on((`rsv`.`id` = `tir_start`.`reservation_id`))) join `trip` `trp_start` on((`trp_start`.`id` = `tir_start`.`trip_id`))) join `trip_in_reservation` `tir_end` on((`rsv`.`id` = `tir_end`.`reservation_id`))) join `trip` `trp_end` on((`trp_end`.`id` = `tir_end`.`trip_id`))) join `trip_in_reservation` `tir` on((`rsv`.`id` = `tir`.`reservation_id`))) join `trip` `trp` on((`trp`.`id` = `tir`.`trip_id`))) join `route_details` `rds` on((`rds`.`id` = `trp`.`route_details_id`))) join `segment` `seg` on((`seg`.`id` = `rds`.`segment_id`))) join `bus_status` `bst` on((`bst`.`id` = `trp`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `tariff` `tar` on(((`seg`.`id` = `tar`.`segment_id`) and (`tar`.`bus_type_id` = `bus`.`bus_type_id`)))) left join `payment` `pay` on(((`rsv`.`id` = `pay`.`reservation_id`) and (`pay`.`type` = 'pay')))) left join `reservation_refund_view` `ref` on((`rsv`.`id` = `ref`.`reservation_id`))) where ((`trp_start`.`departure_time` = (select min(`trp1`.`departure_time`) from ((`reservation` `rsv1` join `trip_in_reservation` `tir1` on((`rsv1`.`id` = `tir1`.`reservation_id`))) join `trip` `trp1` on((`trp1`.`id` = `tir1`.`trip_id`))) where (`rsv`.`id` = `rsv1`.`id`))) and (`trp_end`.`departure_time` = (select max(`trp2`.`departure_time`) from ((`reservation` `rsv2` join `trip_in_reservation` `tir2` on((`rsv2`.`id` = `tir2`.`reservation_id`))) join `trip` `trp2` on((`trp2`.`id` = `tir2`.`trip_id`))) where (`rsv`.`id` = `rsv2`.`id`))) and (`tar`.`valid_from` = (select max(`tar1`.`valid_from`) from (((((`trip` `trp1` join `route_details` `rds1` on((`rds1`.`id` = `trp1`.`route_details_id`))) join `segment` `seg1` on((`seg1`.`id` = `rds1`.`segment_id`))) join `bus_status` `bst1` on((`bst1`.`id` = `trp1`.`bus_status_id`))) join `bus` `bus1` on((`bus1`.`id` = `bst1`.`bus_id`))) join `tariff` `tar1` on(((`seg1`.`id` = `tar1`.`segment_id`) and (`tar1`.`bus_type_id` = `bus1`.`bus_type_id`)))) where ((`trp1`.`id` = `trp`.`id`) and (`tar1`.`valid_from` < `rsv`.`book_time`))))) group by `rsv`.`id`,`trp_start`.`id`,`trp_end`.`id`,`pay`.`pay_amount`,`ref`.`refund_amount` */;
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
/*!50001 VIEW `trip_start_end` AS select `trp`.`id` AS `trip_id`,`trp`.`bus_status_id` AS `bus_status_id`,`st1`.`city_id` AS `start_city_id`,`tr1`.`departure_time` AS `departure_time`,`st2`.`city_id` AS `end_city_id`,`tr2`.`arrival_time` AS `arrival_time` from ((((((((`trip` `tr1` join `route_details` `rd1` on((`rd1`.`id` = `tr1`.`route_details_id`))) join `segment` `sg1` on((`sg1`.`id` = `rd1`.`segment_id`))) join `station` `st1` on((`st1`.`id` = `sg1`.`departure_station_id`))) join `trip` `tr2` on((`tr1`.`bus_status_id` = `tr2`.`bus_status_id`))) join `route_details` `rd2` on((`rd2`.`id` = `tr2`.`route_details_id`))) join `segment` `sg2` on((`sg2`.`id` = `rd2`.`segment_id`))) join `station` `st2` on((`st2`.`id` = `sg2`.`arrival_station_id`))) join `trip` `trp` on((`trp`.`bus_status_id` = `tr2`.`bus_status_id`))) where ((`tr1`.`departure_time` <= `tr2`.`departure_time`) and (`trp`.`departure_time` >= `tr1`.`departure_time`) and (`trp`.`departure_time` <= `tr2`.`departure_time`)) */;
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
/*!50001 VIEW `trip_with_fare_period` AS select distinct `tse`.`bus_status_id` AS `bus_status_id`,`tse`.`start_city_id` AS `start_city_id`,`tse`.`end_city_id` AS `end_city_id`,`tar`.`valid_from` AS `start_period`,`tar`.`valid_to` AS `end_period`,sum(`tar`.`fare`) AS `fare` from ((((((`trip_start_end` `tse` join `bus_status` `bst` on((`bst`.`id` = `tse`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `bus_type` `btp` on((`btp`.`id` = `bus`.`bus_type_id`))) join `trip` `trp` on((`trp`.`id` = `tse`.`trip_id`))) join `route_details` `rds` on((`rds`.`id` = `trp`.`route_details_id`))) join `tariff_view` `tar` on(((`tar`.`segment_id` = `rds`.`segment_id`) and (`tar`.`bus_type_id` = `bus`.`bus_type_id`) and (`tar`.`valid_from` <= `tse`.`departure_time`)))) group by `tse`.`bus_status_id`,`tse`.`start_city_id`,`tse`.`end_city_id`,`tar`.`valid_from`,`tar`.`valid_to` */;
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
/*!50001 VIEW `trip_with_number_of_remained_seats_in_subroute` AS select `trip_start_end`.`trip_id` AS `trip_id`,`trip_start_end`.`bus_status_id` AS `bus_status_id`,`trip_start_end`.`start_city_id` AS `start_city_id`,`trip_start_end`.`departure_time` AS `departure_time`,`trip_start_end`.`end_city_id` AS `end_city_id`,`trip_start_end`.`arrival_time` AS `arrival_time`,`temp`.`number_of_remained_seats` AS `number_of_remained_seats`,`twfp`.`start_period` AS `start_period`,`twfp`.`end_period` AS `end_period`,`twfp`.`fare` AS `fare` from ((`trip_start_end` join `remained_seats` `temp` on(((`trip_start_end`.`bus_status_id` = `temp`.`bus_status_id`) and (`trip_start_end`.`start_city_id` = `temp`.`start_city_id`) and (`trip_start_end`.`end_city_id` = `temp`.`end_city_id`)))) join `trip_with_fare_period` `twfp` on(((`trip_start_end`.`bus_status_id` = `twfp`.`bus_status_id`) and (`trip_start_end`.`start_city_id` = `twfp`.`start_city_id`) and (`trip_start_end`.`end_city_id` = `twfp`.`end_city_id`)))) */;
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

-- Dump completed on 2013-02-27 14:11:30
