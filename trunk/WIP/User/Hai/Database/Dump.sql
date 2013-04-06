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
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (4,'Hà Nội',21.03,105.84),(8,'TP. Hồ Chí Minh',10.78,106.69),(20,'Lào Cai',22.5,103.96),(25,'Lạng Sơn',21.86,106.76),(29,'Yên Bái',21.71,104.87),(31,'Hải Phòng',20.85,106.6833),(37,'Thanh Hoá',19.81,105.78),(38,'Nghệ An',19.3333,104.8333),(39,'Hà Tĩnh',18.37,105.9),(52,'Quảng Bình',17.5,106.3333),(54,'Thừa Thiên Huế',16.48,107.58),(55,'Quảng Ngãi',15.12,108.81),(56,'Bình Định',14.1667,109),(58,'Khánh Hoà',12.25,109.2),(61,'Đồng Nai',11.116666666666667,107.18333333333334),(62,'Bình Thuận',10.933333333333334,108.1),(63,'Lâm Đồng',11.9417,108.4383),(64,'Vũng Tàu',10.416666666666666,107.16805555555555),(66,'Tây Ninh',11.3,106.1),(72,'Long An',10.666666666666666,106.16666666666667),(75,'Bến Tre',10.2333,106.3833),(76,'An Giang',10.5,105.16666666666667),(511,'Đà Nẵng',16.0667,108.2333);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_template`
--

LOCK TABLES `mail_template` WRITE;
/*!40000 ALTER TABLE `mail_template` DISABLE KEYS */;
INSERT INTO `mail_template` VALUES (1,'MAIL0101','Kích hoạt tài khoản :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Kích hoạt tài khoản thành viên :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu mở tài khoản thành viên\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<p>Tên đăng nhập: :username:</p>\r\n<p>Tên chủ tài khoản: :fullName:</p>\r\n<p>Địa chỉ email: :email:</p>\r\n<br/>\r\n<p>Để hoàn tất quy trình đăng ký, xin quý khách vui lòng nhấn vào đường dẫn bên dưới\r\nhoặc sao chép vào thanh địa chỉ trên trình duyệt và nhấn Enter:</p>\r\n<p><a href=\":url:\">:url:</a></p>\r\n</div>'),(2,'MAIL0201','Thông báo huỷ đơn đặt vé :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo huỷ đơn đặt vé :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu huỷ đơn đặt vé\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<table>\r\n<tr><th>Mã đơn đặt vé</th><td>:reservationCode:</td></tr>\r\n<tr><th>Ngày đặt</th><td>:bookTime:</td></tr>\r\n</table>\r\n<p>Lộ trình:</p>\r\n<table>\r\n:loopTicket:<tr><td>Từ :from: đến :to:</td><td>:fromDate: - :toDate:</td><td>:seatNumbers:</td><td>:ticketPrice:</td></tr>\r\n:loopTicket:\r\n</table>\r\n<table>\r\n<tr><th>Tổng cộng</th><td>:totalAmount:</td></tr>\r\n<tr><th>Phí</th><td>:fee:</td></tr>\r\n<tr><th>Thành tiền</th><td>:amountToBePaid:</td></tr>\r\n<tr><th>Đã hoàn lại</th><td>:refundedAmount:</td></tr>\r\n</table>\r\n</div>'),(4,'MAIL0202','Thông báo  đặt vé hoàn tất :companyName:','<div style=\"width:100%;\">\r\n <p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo đặt vé hoàn tất :companyName:</p>\r\n <p>Chào :fullName:</p>\r\n <p>Chúng tôi đã nhận được yêu cầu đặt vé\r\n của quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n <table>\r\n <tr><th>Mã đơn đặt vé</th><td>:reservationCode:</td></tr>\r\n <tr><th>Ngày đặt</th><td>:bookTime:</td></tr>\r\n </table>\r\n <p>Lộ trình:</p>\r\n <table>\r\n :loopTicket:<tr><td>Từ :from: đến :to:</td><td>:fromDate: - :toDate:</td><td>:seatNumbers:</td><td>:ticketPrice:</td></tr>\r\n :loopTicket:\r\n </table>\r\n <table>\r\n <tr><th>Tổng cộng</th><td>:totalAmount:</td></tr>\r\n <tr><th>Phí</th><td>:fee:</td></tr>\r\n <tr><th>Thành tiền</th><td>:amountToBePaid:</td></tr>\r\n </table>\r\nChúc quý khách lên đường bình an\r\n </div>');
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
INSERT INTO `payment` VALUES (2,14,2604291.5,2604166.5,2,'0A820252UA8012206','pay'),(3,15,2604291.5,2604166.5,2,'05X518607J891805V','pay'),(4,16,999.5,499.5,2,'91B61848KM603761D','pay'),(5,17,999.5,499.5,2,'91B61848KM603761D','pay'),(6,20,249.5,124.5,2,'7HP61471AS1963121','pay'),(7,21,131,13,2,'55T492274L438751D','pay'),(8,22,131,6,2,'55T492274L438751D','pay'),(9,25,409.5,34.5,2,'5HR58967WC0106930','pay'),(10,26,392,17,2,'5HR58967WC0106930','pay'),(11,27,784.5,34.5,2,'0E422965AP622194N','pay'),(12,28,392,17,2,'0E422965AP622194N','pay'),(13,29,392,17,2,'2RH59954S0391005M','pay'),(14,30,784.5,34.5,2,'2RH59954S0391005M','pay'),(15,33,392,17,2,'5B0723365G388511Y','pay'),(16,34,784.5,34.5,2,'5B0723365G388511Y','pay');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,NULL,NULL,'2013-04-06 08:39:51','unpaid','Trường','Nguyễn Sơn','','hainl60335@fpt.edu.vn'),(2,NULL,NULL,'2013-04-06 08:48:21','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(3,NULL,NULL,'2013-04-06 08:53:35','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(4,NULL,NULL,'2013-04-06 08:56:12','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(5,NULL,'CEX6DH','2013-04-06 09:00:50','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(6,NULL,'BH7LJJ','2013-04-06 09:40:14','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(7,NULL,NULL,'2013-04-06 09:50:21','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(8,NULL,NULL,'2013-04-06 09:51:13','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(9,NULL,NULL,'2013-04-06 10:03:09','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(10,NULL,NULL,'2013-04-06 10:06:51','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(11,NULL,'4815RB','2013-04-06 10:12:05','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(12,NULL,'7JHEEC','2013-04-06 10:17:47','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(13,NULL,'CV39G1','2013-04-06 10:22:36','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(14,NULL,NULL,'2013-04-06 10:27:23','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(15,NULL,NULL,'2013-04-06 10:39:40','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(16,NULL,'5YV5L9','2013-04-06 10:40:09','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(17,NULL,'6JYKBP','2013-04-06 10:45:22','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(18,NULL,NULL,'2013-04-06 10:48:56','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(19,NULL,'8YMQHI','2013-04-06 11:01:13','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(20,NULL,'D1S6MC','2013-04-06 11:08:22','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(21,NULL,'AL7MTF','2013-04-06 11:14:51','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(22,NULL,NULL,'2013-04-06 11:18:18','unpaid','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn'),(23,NULL,'CZ6LZ8','2013-04-06 11:19:52','pending','Hải','Nguyễn Lương','','hainl60335@fpt.edu.vn');
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
INSERT INTO `seat_position` VALUES (1,'A11','active'),(2,'B11','active'),(2,'D11','active'),(2,'E11','active'),(3,'A10','active'),(3,'B10','active'),(4,'D11','active'),(4,'E11','active'),(5,'A11','active'),(6,'B11','active'),(7,'D10','active'),(8,'A11','active'),(9,'A11','active'),(10,'B11','active'),(11,'D11','active'),(12,'E11','active'),(13,'D11','active'),(14,'B11','active'),(15,'A10','active'),(16,'B10','active'),(17,'B11','active'),(18,'D11','active'),(18,'E11','active'),(19,'E10','active'),(19,'E9','active'),(20,'A9','active'),(21,'B9','active'),(21,'D11','active'),(22,'A10','active'),(22,'B10','active'),(23,'D9','active'),(23,'E11','active'),(24,'A9','active'),(24,'B9','active'),(25,'E10','active'),(25,'E9','active'),(26,'D10','active'),(27,'D9','active'),(27,'E11','active'),(28,'A9','active'),(29,'A8','active'),(30,'D11','active'),(30,'E11','active'),(31,'B8','active'),(32,'E10','active'),(32,'E9','active'),(33,'D8','active'),(34,'B9','active'),(34,'D9','active');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segment_travel_time`
--

LOCK TABLES `segment_travel_time` WRITE;
/*!40000 ALTER TABLE `segment_travel_time` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,1,1,'2012-01-01 00:00:00',100),(2,2,1,'2012-01-01 00:00:00',100),(3,3,1,'2013-01-01 00:00:00',150),(4,4,1,'2013-01-01 00:00:00',65),(5,5,1,'2013-01-01 00:00:00',30),(6,6,1,'2013-01-01 00:00:00',90),(7,2,1,'2013-02-28 00:00:00',80),(8,2,1,'2013-02-01 00:00:00',85),(9,2,1,'2013-03-15 00:00:00',100),(10,3,1,'2013-02-20 00:00:00',170),(11,3,1,'2013-02-04 00:00:00',120),(12,4,1,'2013-02-25 00:00:00',80),(13,4,1,'2013-03-01 00:00:00',65),(14,7,1,'2012-01-01 00:00:00',125),(15,8,1,'2012-01-01 00:00:00',125),(16,9,1,'2012-01-01 00:00:00',125),(17,10,1,'2012-01-01 00:00:00',125),(18,11,1,'2012-01-01 00:00:00',125),(19,12,1,'2012-01-01 00:00:00',125),(20,13,1,'2012-01-01 00:00:00',125),(21,14,1,'2012-01-01 00:00:00',125),(22,15,1,'2012-01-01 00:00:00',125),(23,16,1,'2012-01-01 00:00:00',125),(24,17,1,'2012-01-01 00:00:00',125),(25,18,1,'2012-01-01 00:00:00',125),(26,19,1,'2012-01-01 00:00:00',125),(27,20,1,'2012-01-01 00:00:00',125);
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
INSERT INTO `ticket` VALUES (1,1,'active'),(2,2,'active'),(3,3,'active'),(4,3,'active'),(5,4,'active'),(6,4,'active'),(7,5,'pending'),(8,5,'pending'),(9,6,'pending'),(10,7,'active'),(11,8,'active'),(12,9,'active'),(13,10,'active'),(14,11,'pending'),(15,12,'pending'),(16,13,'pending'),(17,13,'pending'),(18,14,'active'),(19,15,'active'),(20,16,'pending'),(21,17,'pending'),(22,17,'pending'),(23,18,'active'),(24,18,'active'),(25,19,'pending'),(26,19,'pending'),(27,20,'pending'),(28,20,'pending'),(29,21,'pending'),(30,21,'pending'),(31,22,'active'),(32,22,'active'),(33,23,'pending'),(34,23,'pending');
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (7,4,7,'2013-03-11 18:10:50','2013-03-11 22:40:50'),(8,4,8,'2013-03-13 22:40:50','2013-03-14 03:10:50'),(9,4,9,'2013-03-16 03:10:50','2013-03-16 04:25:50'),(10,4,10,'2013-03-18 04:25:50','2013-03-18 08:10:50'),(11,4,11,'2013-03-20 08:10:50','2013-03-20 11:10:50'),(12,4,12,'2013-03-22 11:10:50','2013-03-22 14:10:50'),(13,4,13,'2013-03-24 14:10:50','2013-03-25 06:10:50'),(14,5,14,'2013-03-27 06:10:50','2013-03-27 22:10:50'),(15,5,15,'2013-03-29 22:10:50','2013-03-30 01:10:50'),(16,5,16,'2013-04-01 01:10:50','2013-04-01 04:10:50'),(17,5,17,'2013-04-03 04:10:50','2013-04-03 07:55:50'),(18,5,18,'2013-04-05 07:55:50','2013-04-05 09:10:50'),(19,5,19,'2013-04-07 09:10:50','2013-04-07 13:40:50'),(20,5,20,'2013-04-09 13:40:50','2013-04-09 18:10:50'),(21,6,7,'2013-04-11 18:10:50','2013-04-11 22:40:50'),(22,6,8,'2013-04-13 22:40:50','2013-04-14 03:10:50'),(23,6,9,'2013-04-16 03:10:50','2013-04-16 04:25:50'),(24,6,10,'2013-04-18 04:25:50','2013-04-18 08:10:50'),(25,6,11,'2013-04-20 08:10:50','2013-04-20 11:10:50'),(26,6,12,'2013-04-22 11:10:50','2013-04-22 14:10:50'),(27,6,13,'2013-04-24 14:10:50','2013-04-25 06:10:50'),(28,7,14,'2013-04-27 06:10:50','2013-04-27 22:10:50'),(29,7,15,'2013-04-29 22:10:50','2013-04-30 01:10:50'),(30,7,16,'2013-05-02 01:10:50','2013-05-02 04:10:50'),(31,7,17,'2013-05-04 04:10:50','2013-05-04 07:55:50'),(32,7,18,'2013-05-06 07:55:50','2013-05-06 09:10:50'),(33,7,19,'2013-05-08 09:10:50','2013-05-08 13:40:50'),(34,7,20,'2013-05-10 13:40:50','2013-05-10 18:10:50'),(35,8,7,'2013-05-12 18:10:50','2013-05-12 22:40:50'),(36,8,8,'2013-05-14 22:40:50','2013-05-15 03:10:50'),(37,8,9,'2013-05-17 03:10:50','2013-05-17 04:25:50'),(38,8,10,'2013-05-19 04:25:50','2013-05-19 08:10:50'),(39,8,11,'2013-05-21 08:10:50','2013-05-21 11:10:50'),(40,8,12,'2013-05-23 11:10:50','2013-05-23 14:10:50'),(41,8,13,'2013-05-25 14:10:50','2013-05-26 06:10:50'),(42,9,14,'2013-05-28 06:10:50','2013-05-28 22:10:50'),(43,9,15,'2013-05-30 22:10:50','2013-05-31 01:10:50'),(44,9,16,'2013-06-02 01:10:50','2013-06-02 04:10:50'),(45,9,17,'2013-06-04 04:10:50','2013-06-04 07:55:50'),(46,9,18,'2013-06-06 07:55:50','2013-06-06 09:10:50'),(47,9,19,'2013-06-08 09:10:50','2013-06-08 13:40:50'),(48,9,20,'2013-06-10 13:40:50','2013-06-10 18:10:50'),(49,10,7,'2013-06-12 18:10:50','2013-06-12 22:40:50'),(50,10,8,'2013-06-14 22:40:50','2013-06-15 03:10:50'),(51,10,9,'2013-06-17 03:10:50','2013-06-17 04:25:50'),(52,10,10,'2013-06-19 04:25:50','2013-06-19 08:10:50'),(53,10,11,'2013-06-21 08:10:50','2013-06-21 11:10:50'),(54,10,12,'2013-06-23 11:10:50','2013-06-23 14:10:50'),(55,10,13,'2013-06-25 14:10:50','2013-06-26 06:10:50'),(56,11,14,'2013-06-28 06:10:50','2013-06-28 22:10:50'),(57,11,15,'2013-06-30 22:10:50','2013-07-01 01:10:50'),(58,11,16,'2013-07-03 01:10:50','2013-07-03 04:10:50'),(59,11,17,'2013-07-05 04:10:50','2013-07-05 07:55:50'),(60,11,18,'2013-07-07 07:55:50','2013-07-07 09:10:50'),(61,11,19,'2013-07-09 09:10:50','2013-07-09 13:40:50'),(62,11,20,'2013-07-11 13:40:50','2013-07-11 18:10:50'),(63,12,7,'2013-07-13 18:10:50','2013-07-13 22:40:50'),(64,12,8,'2013-07-15 22:40:50','2013-07-16 03:10:50'),(65,12,9,'2013-07-18 03:10:50','2013-07-18 04:25:50'),(66,12,10,'2013-07-20 04:25:50','2013-07-20 08:10:50'),(67,12,11,'2013-07-22 08:10:50','2013-07-22 11:10:50'),(68,12,12,'2013-07-24 11:10:50','2013-07-24 14:10:50'),(69,12,13,'2013-07-26 14:10:50','2013-07-27 06:10:50'),(70,13,14,'2013-07-29 06:10:50','2013-07-29 22:10:50'),(71,13,15,'2013-07-31 22:10:50','2013-08-01 01:10:50'),(72,13,16,'2013-08-03 01:10:50','2013-08-03 04:10:50'),(73,13,17,'2013-08-05 04:10:50','2013-08-05 07:55:50'),(74,13,18,'2013-08-07 07:55:50','2013-08-07 09:10:50'),(75,13,19,'2013-08-09 09:10:50','2013-08-09 13:40:50'),(76,13,20,'2013-08-11 13:40:50','2013-08-11 18:10:50');
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
INSERT INTO `trip_in_ticket` VALUES (1,21),(2,21),(3,21),(5,21),(7,21),(9,21),(10,21),(11,21),(12,21),(13,21),(14,21),(15,21),(16,21),(18,21),(19,21),(20,21),(21,21),(23,21),(25,21),(27,21),(29,21),(31,21),(33,21),(16,22),(19,22),(23,22),(25,22),(27,22),(29,22),(31,22),(33,22),(16,23),(19,23),(23,23),(25,23),(27,23),(29,23),(31,23),(33,23),(16,24),(17,31),(17,32),(26,32),(28,32),(30,32),(32,32),(34,32),(17,33),(24,33),(26,33),(28,33),(30,33),(32,33),(34,33),(4,34),(6,34),(8,34),(17,34),(22,34),(24,34),(26,34),(28,34),(30,34),(32,34),(34,34);
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
                              IN BUS_TYPE INT,
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
        SUM(trff.fare) * PSSGR_NO 		AS fare,
		rmst.number_of_remained_seats 	AS remained_seats,
		dept.route_id					AS route	
FROM   
	-- departure trip information
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
	INNER JOIN bus_status bstt
	  ON bstt.id = arrv.bus_status_id AND
		 bstt.status = 'active'
	INNER JOIN bus
	  ON bus.id = bstt.bus_id AND bus.bus_type_id = BUS_TYPE
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
GROUP BY ftrp.bus_status_id
ORDER BY dept.departure_time ASC, rmst.number_of_remained_seats ASC;
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

-- Dump completed on 2013-04-06 11:41:09
