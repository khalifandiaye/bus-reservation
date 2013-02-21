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
INSERT INTO `bus_status` VALUES (4,3,'ontrip','2013-03-19 09:19:49','2013-03-18 20:19:49',8,'active'),(5,3,'ontrip','2013-03-21 09:19:49','2013-03-20 20:19:49',35,'active'),(6,3,'ontrip','2013-03-23 09:19:49','2013-03-22 20:19:49',8,'active'),(7,3,'ontrip','2013-03-25 09:19:49','2013-03-24 20:19:49',35,'active'),(8,3,'ontrip','2013-03-27 09:19:49','2013-03-26 20:19:49',8,'active'),(9,3,'ontrip','2013-03-29 09:19:49','2013-03-28 20:19:49',35,'active'),(10,3,'ontrip','2013-03-31 09:19:49','2013-03-30 20:19:49',8,'active'),(11,3,'ontrip','2013-04-02 09:19:49','2013-04-01 20:19:49',35,'active'),(12,3,'ontrip','2013-04-04 09:19:49','2013-04-03 20:19:49',8,'active'),(13,3,'ontrip','2013-04-06 09:19:49','2013-04-05 20:19:49',35,'active');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (130,1,NULL,'2013-02-25 13:13:47','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(131,1,NULL,'2013-02-19 19:11:18','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(132,1,NULL,'2013-03-10 03:36:07','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(133,1,NULL,'2013-03-09 06:05:23','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(134,1,NULL,'2013-03-08 20:23:00','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(135,1,NULL,'2013-03-04 04:45:04','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(136,1,NULL,'2013-03-02 07:41:51','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(137,1,NULL,'2013-02-26 07:05:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(138,1,NULL,'2013-02-26 12:07:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(139,1,NULL,'2013-02-22 17:17:56','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(140,1,NULL,'2013-02-18 18:29:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(141,1,NULL,'2013-02-24 01:34:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(142,1,NULL,'2013-02-09 10:49:05','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(143,1,NULL,'2013-02-24 02:30:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(144,1,NULL,'2013-02-23 08:58:12','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(145,1,NULL,'2013-02-16 12:51:46','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(146,1,NULL,'2013-03-01 20:01:59','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(147,1,NULL,'2013-02-23 03:30:18','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(148,1,NULL,'2013-03-01 15:10:11','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(149,1,NULL,'2013-03-05 10:37:52','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(150,1,NULL,'2013-02-14 17:53:38','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(151,1,NULL,'2013-03-01 16:06:34','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn'),(152,1,NULL,'2013-02-05 22:37:43','unpaid','First','Customer','123456789','cust1_1357703483_per@fpt.edu.vn');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
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
INSERT INTO `seat_position` VALUES (130,'A16'),(130,'A3'),(130,'A9'),(130,'B20'),(130,'C6'),(131,'B9'),(131,'C10'),(131,'C16'),(131,'D10'),(131,'D16'),(132,'A16'),(132,'B6'),(132,'B7'),(132,'C13'),(132,'D1'),(133,'A17'),(133,'A18'),(133,'B4'),(133,'C1'),(133,'C10'),(134,'A9'),(134,'B14'),(134,'C4'),(134,'D1'),(134,'D3'),(135,'A12'),(135,'A3'),(135,'B7'),(135,'B8'),(135,'C20'),(136,'A8'),(136,'C14'),(136,'C19'),(136,'D19'),(137,'A8'),(137,'B11'),(137,'C1'),(137,'D13'),(138,'B20'),(138,'C15'),(138,'C3'),(138,'C9'),(139,'B1'),(139,'B13'),(139,'C3'),(139,'C4'),(140,'A17'),(140,'A2'),(140,'C12'),(140,'D1'),(140,'D7'),(141,'A16'),(141,'D15'),(141,'D16'),(141,'D3'),(141,'D7'),(142,'A1'),(142,'B18'),(142,'B7'),(142,'C16'),(142,'D13'),(143,'A18'),(143,'B13'),(143,'B9'),(143,'C2'),(143,'D14'),(144,'A7'),(144,'A8'),(144,'B4'),(144,'D14'),(144,'D2'),(145,'B16'),(145,'B17'),(145,'B4'),(145,'B8'),(145,'D6'),(146,'A1'),(146,'A16'),(146,'B3'),(146,'C16'),(146,'D17'),(147,'A1'),(147,'A16'),(147,'B13'),(147,'B6'),(147,'D15'),(148,'A10'),(148,'A5'),(148,'C1'),(148,'C12'),(149,'B3'),(149,'C16'),(149,'C6'),(149,'D13'),(149,'D7'),(150,'A17'),(150,'B16'),(150,'B7'),(150,'C17'),(150,'D1'),(151,'B2'),(151,'B20'),(151,'C10'),(151,'D7'),(151,'D9'),(152,'A11'),(152,'A9'),(152,'C20'),(152,'C3'),(152,'D19');
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
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_settings` (
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
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
INSERT INTO `trip` VALUES (7,4,7,'2013-03-19 09:19:49','2013-03-19 06:49:49','active'),(8,4,8,'2013-03-19 06:49:49','2013-03-19 04:19:49','active'),(9,4,9,'2013-03-19 04:19:49','2013-03-18 22:34:49','active'),(10,4,10,'2013-03-18 22:34:49','2013-03-18 19:19:49','active'),(11,4,11,'2013-03-18 19:19:49','2013-03-18 15:19:49','active'),(12,4,12,'2013-03-18 15:19:49','2013-03-18 11:19:49','active'),(13,4,13,'2013-03-18 11:19:49','2013-03-18 20:19:49','active'),(14,5,14,'2013-03-21 09:19:49','2013-03-21 18:19:49','active'),(15,5,15,'2013-03-21 18:19:49','2013-03-21 14:19:49','active'),(16,5,16,'2013-03-21 14:19:49','2013-03-21 10:19:49','active'),(17,5,17,'2013-03-21 10:19:49','2013-03-21 07:04:49','active'),(18,5,18,'2013-03-21 07:04:49','2013-03-21 01:19:49','active'),(19,5,19,'2013-03-21 01:19:49','2013-03-20 22:49:49','active'),(20,5,20,'2013-03-20 22:49:49','2013-03-20 20:19:49','active'),(21,6,7,'2013-03-23 09:19:49','2013-03-23 06:49:49','active'),(22,6,8,'2013-03-23 06:49:49','2013-03-23 04:19:49','active'),(23,6,9,'2013-03-23 04:19:49','2013-03-22 22:34:49','active'),(24,6,10,'2013-03-22 22:34:49','2013-03-22 19:19:49','active'),(25,6,11,'2013-03-22 19:19:49','2013-03-22 15:19:49','active'),(26,6,12,'2013-03-22 15:19:49','2013-03-22 11:19:49','active'),(27,6,13,'2013-03-22 11:19:49','2013-03-22 20:19:49','active'),(28,7,14,'2013-03-25 09:19:49','2013-03-25 18:19:49','active'),(29,7,15,'2013-03-25 18:19:49','2013-03-25 14:19:49','active'),(30,7,16,'2013-03-25 14:19:49','2013-03-25 10:19:49','active'),(31,7,17,'2013-03-25 10:19:49','2013-03-25 07:04:49','active'),(32,7,18,'2013-03-25 07:04:49','2013-03-25 01:19:49','active'),(33,7,19,'2013-03-25 01:19:49','2013-03-24 22:49:49','active'),(34,7,20,'2013-03-24 22:49:49','2013-03-24 20:19:49','active'),(35,8,7,'2013-03-27 09:19:49','2013-03-27 06:49:49','active'),(36,8,8,'2013-03-27 06:49:49','2013-03-27 04:19:49','active'),(37,8,9,'2013-03-27 04:19:49','2013-03-26 22:34:49','active'),(38,8,10,'2013-03-26 22:34:49','2013-03-26 19:19:49','active'),(39,8,11,'2013-03-26 19:19:49','2013-03-26 15:19:49','active'),(40,8,12,'2013-03-26 15:19:49','2013-03-26 11:19:49','active'),(41,8,13,'2013-03-26 11:19:49','2013-03-26 20:19:49','active'),(42,9,14,'2013-03-29 09:19:49','2013-03-29 18:19:49','active'),(43,9,15,'2013-03-29 18:19:49','2013-03-29 14:19:49','active'),(44,9,16,'2013-03-29 14:19:49','2013-03-29 10:19:49','active'),(45,9,17,'2013-03-29 10:19:49','2013-03-29 07:04:49','active'),(46,9,18,'2013-03-29 07:04:49','2013-03-29 01:19:49','active'),(47,9,19,'2013-03-29 01:19:49','2013-03-28 22:49:49','active'),(48,9,20,'2013-03-28 22:49:49','2013-03-28 20:19:49','active'),(49,10,7,'2013-03-31 09:19:49','2013-03-31 06:49:49','active'),(50,10,8,'2013-03-31 06:49:49','2013-03-31 04:19:49','active'),(51,10,9,'2013-03-31 04:19:49','2013-03-30 22:34:49','active'),(52,10,10,'2013-03-30 22:34:49','2013-03-30 19:19:49','active'),(53,10,11,'2013-03-30 19:19:49','2013-03-30 15:19:49','active'),(54,10,12,'2013-03-30 15:19:49','2013-03-30 11:19:49','active'),(55,10,13,'2013-03-30 11:19:49','2013-03-30 20:19:49','active'),(56,11,14,'2013-04-02 09:19:49','2013-04-02 18:19:49','active'),(57,11,15,'2013-04-02 18:19:49','2013-04-02 14:19:49','active'),(58,11,16,'2013-04-02 14:19:49','2013-04-02 10:19:49','active'),(59,11,17,'2013-04-02 10:19:49','2013-04-02 07:04:49','active'),(60,11,18,'2013-04-02 07:04:49','2013-04-02 01:19:49','active'),(61,11,19,'2013-04-02 01:19:49','2013-04-01 22:49:49','active'),(62,11,20,'2013-04-01 22:49:49','2013-04-01 20:19:49','active'),(63,12,7,'2013-04-04 09:19:49','2013-04-04 06:49:49','active'),(64,12,8,'2013-04-04 06:49:49','2013-04-04 04:19:49','active'),(65,12,9,'2013-04-04 04:19:49','2013-04-03 22:34:49','active'),(66,12,10,'2013-04-03 22:34:49','2013-04-03 19:19:49','active'),(67,12,11,'2013-04-03 19:19:49','2013-04-03 15:19:49','active'),(68,12,12,'2013-04-03 15:19:49','2013-04-03 11:19:49','active'),(69,12,13,'2013-04-03 11:19:49','2013-04-03 20:19:49','active'),(70,13,14,'2013-04-06 09:19:49','2013-04-06 18:19:49','active'),(71,13,15,'2013-04-06 18:19:49','2013-04-06 14:19:49','active'),(72,13,16,'2013-04-06 14:19:49','2013-04-06 10:19:49','active'),(73,13,17,'2013-04-06 10:19:49','2013-04-06 07:04:49','active'),(74,13,18,'2013-04-06 07:04:49','2013-04-06 01:19:49','active'),(75,13,19,'2013-04-06 01:19:49','2013-04-05 22:49:49','active'),(76,13,20,'2013-04-05 22:49:49','2013-04-05 20:19:49','active');
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
INSERT INTO `trip_in_reservation` VALUES (133,9),(133,10),(130,11),(130,12),(130,13),(144,15),(147,15),(144,16),(144,17),(144,18),(143,22),(135,23),(140,23),(143,23),(135,24),(140,24),(143,24),(140,25),(143,25),(140,26),(143,26),(140,27),(141,30),(141,31),(141,32),(150,32),(150,33),(137,34),(150,34),(142,36),(142,37),(142,38),(142,39),(136,40),(136,41),(148,42),(134,48),(139,53),(139,54),(151,58),(152,58),(151,59),(152,59),(151,60),(152,60),(151,61),(138,62),(132,68),(149,70),(149,71),(145,72),(146,73),(131,74),(131,75),(131,76);
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
/*!50001 VIEW `reservation_view` AS select `rsv`.`id` AS `reservation_id`,`trp_start`.`id` AS `start_trip_id`,`trp_end`.`id` AS `end_trip_id`,sum(`tar`.`fare`) AS `ticket_price`,`pay`.`pay_amount` AS `paid_amount`,`ref`.`pay_amount` AS `refund_amount` from (((((((((((((`reservation` `rsv` join `trip_in_reservation` `tir_start` on((`rsv`.`id` = `tir_start`.`reservation_id`))) join `trip` `trp_start` on((`trp_start`.`id` = `tir_start`.`trip_id`))) join `trip_in_reservation` `tir_end` on((`rsv`.`id` = `tir_end`.`reservation_id`))) join `trip` `trp_end` on((`trp_end`.`id` = `tir_end`.`trip_id`))) join `trip_in_reservation` `tir` on((`rsv`.`id` = `tir`.`reservation_id`))) join `trip` `trp` on((`trp`.`id` = `tir`.`trip_id`))) join `route_details` `rds` on((`rds`.`id` = `trp`.`route_details_id`))) join `segment` `seg` on((`seg`.`id` = `rds`.`segment_id`))) join `bus_status` `bst` on((`bst`.`id` = `trp`.`bus_status_id`))) join `bus` on((`bus`.`id` = `bst`.`bus_id`))) join `tariff` `tar` on(((`seg`.`id` = `tar`.`segment_id`) and (`tar`.`bus_type_id` = `bus`.`bus_type_id`)))) left join `payment` `pay` on(((`rsv`.`id` = `pay`.`reservation_id`) and (`pay`.`type` = 'pay')))) left join `payment` `ref` on(((`rsv`.`id` = `ref`.`reservation_id`) and (`ref`.`type` = 'refund')))) where ((`trp_start`.`departure_time` = (select min(`trp1`.`departure_time`) from ((`reservation` `rsv1` join `trip_in_reservation` `tir1` on((`rsv1`.`id` = `tir1`.`reservation_id`))) join `trip` `trp1` on((`trp1`.`id` = `tir1`.`trip_id`))) where (`rsv`.`id` = `rsv1`.`id`))) and (`trp_end`.`departure_time` = (select max(`trp2`.`departure_time`) from ((`reservation` `rsv2` join `trip_in_reservation` `tir2` on((`rsv2`.`id` = `tir2`.`reservation_id`))) join `trip` `trp2` on((`trp2`.`id` = `tir2`.`trip_id`))) where (`rsv`.`id` = `rsv2`.`id`))) and (`tar`.`valid_from` = (select max(`tar1`.`valid_from`) from (((((`trip` `trp1` join `route_details` `rds1` on((`rds1`.`id` = `trp1`.`route_details_id`))) join `segment` `seg1` on((`seg1`.`id` = `rds1`.`segment_id`))) join `bus_status` `bst1` on((`bst1`.`id` = `trp1`.`bus_status_id`))) join `bus` `bus1` on((`bus1`.`id` = `bst1`.`bus_id`))) join `tariff` `tar1` on(((`seg1`.`id` = `tar1`.`segment_id`) and (`tar1`.`bus_type_id` = `bus1`.`bus_type_id`)))) where ((`trp1`.`id` = `trp`.`id`) and (`tar1`.`valid_from` < `rsv`.`book_time`))))) group by `rsv`.`id`,`trp_start`.`id`,`trp_end`.`id`,`pay`.`pay_amount`,`ref`.`pay_amount` */;
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

-- Dump completed on 2013-02-21 10:53:43
