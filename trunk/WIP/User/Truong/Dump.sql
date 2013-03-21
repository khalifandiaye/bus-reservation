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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_template`
--

LOCK TABLES `mail_template` WRITE;
/*!40000 ALTER TABLE `mail_template` DISABLE KEYS */;
INSERT INTO `mail_template` VALUES (1,'MAIL0101','Kích hoạt tài khoản :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Kích hoạt tài khoản thành viên :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu mở tài khoản thành viên\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<p>Tên đăng nhập: :username:</p>\r\n<p>Tên chủ tài khoản: :fullName:</p>\r\n<p>Địa chỉ email: :email:</p>\r\n<br/>\r\n<p>Để hoàn tất quy trình đăng ký, xin quý khách vui lòng nhấn vào đường dẫn bên dưới\r\nhoặc sao chép vào thanh địa chỉ trên trình duyệt và nhấn Enter:</p>\r\n<p><a href=\":url:\">:url:</a></p>\r\n</div>'),(2,'MAIL0201','Thông báo huỷ đơn đặt vé :companyName:','<div style=\"width:100%;\">\r\n<p style=\"color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;\" >Thông báo huỷ đơn đặt vé :companyName:</p>\r\n<p>Chào :fullName:</p>\r\n<p>Chúng tôi đã nhận được yêu cầu huỷ đơn đặt vé\r\ncủa quý khách tại <a href=\":siteurl:\">:siteName:</a> với các thông tin sau:</P>\r\n<table>\r\n<tr><th>Mã đơn đặt vé</th><td>:reservationCode:</td></tr>\r\n<tr><th>Ngày đặt</th><td>:bookTime:</td></tr>\r\n</table>\r\n<p>Lộ trình:</p>\r\n<table>\r\n:loopTicket:<tr><td>Từ :from: đến :to:</td><td>:fromDate: - :toDate:</td><td>:seatNumbers:</td><td>:ticketPrice:</td></tr>\r\n:loopTicket:\r\n</table>\r\n<table>\r\n<tr><th>Tổng cộng</th><td>:totalAmount:</td></tr>\r\n<tr><th>Phí</th><td>:fee:</td></tr>\r\n<tr><th>Thành tiền</th><td>:amountToBePaid:</td></tr>\r\n<tr><th>Đã hoàn lại</th><td>:refundedAmount:</td></tr>\r\n</table>\r\n</div>');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `segment_unique_index` (`departure_station_id`,`arrival_station_id`),
  KEY `segment_arrive_station_id_idx` (`departure_station_id`),
  KEY `segment_depart_station_id_idx` (`arrival_station_id`),
  CONSTRAINT `segment_arrive_station_id` FOREIGN KEY (`departure_station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `segment_depart_station_id` FOREIGN KEY (`arrival_station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


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
) ENGINE=InnoDB AUTO_INCREMENT=1417 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1219,964,'active'),(1220,965,'active'),(1221,966,'active'),(1222,967,'active'),(1223,968,'active'),(1224,968,'active'),(1225,969,'active'),(1226,970,'active'),(1227,971,'active'),(1228,972,'active'),(1229,973,'active'),(1230,974,'active'),(1231,974,'active'),(1232,975,'active'),(1233,976,'active'),(1234,976,'active'),(1235,977,'active'),(1236,977,'active'),(1237,978,'pending'),(1238,979,'active'),(1239,980,'active'),(1240,980,'active'),(1243,982,'active'),(1245,984,'active'),(1246,985,'active'),(1248,987,'active'),(1249,988,'active'),(1252,990,'active'),(1253,990,'active'),(1254,991,'active'),(1255,991,'active'),(1258,993,'active'),(1259,993,'active'),(1260,994,'pending'),(1261,994,'pending'),(1262,995,'active'),(1263,996,'active'),(1264,997,'active'),(1265,998,'active'),(1266,998,'active'),(1269,1001,'active'),(1272,1004,'active'),(1276,1007,'active'),(1277,1008,'active'),(1280,1010,'active'),(1281,1011,'active'),(1283,1013,'active'),(1284,1014,'active'),(1285,1014,'active'),(1286,1015,'active'),(1289,1017,'active'),(1290,1017,'active'),(1292,1019,'active'),(1296,1022,'active'),(1297,1023,'active'),(1298,1023,'active'),(1299,1024,'active'),(1300,1025,'active'),(1301,1025,'active'),(1304,1027,'active'),(1305,1028,'active'),(1306,1029,'active'),(1311,1033,'active'),(1314,1035,'active'),(1315,1036,'active'),(1316,1037,'active'),(1317,1038,'active'),(1320,1041,'active'),(1321,1041,'active'),(1323,1043,'active'),(1326,1045,'active'),(1331,1049,'active'),(1332,1050,'active'),(1333,1050,'active'),(1335,1052,'active'),(1336,1052,'active'),(1338,1054,'active'),(1339,1054,'active'),(1340,1055,'active'),(1342,1057,'active'),(1343,1058,'active'),(1346,1061,'active'),(1348,1063,'active'),(1355,1067,'active'),(1356,1068,'active'),(1359,1070,'active'),(1364,1075,'pending'),(1365,1075,'pending'),(1369,1078,'active'),(1370,1079,'active'),(1373,1081,'active'),(1377,1084,'active'),(1378,1085,'active'),(1383,1089,'active'),(1386,1091,'active'),(1387,1091,'active'),(1388,1092,'active'),(1389,1093,'active'),(1395,1097,'active'),(1396,1097,'active'),(1397,1098,'active'),(1399,1100,'active'),(1400,1101,'active'),(1401,1102,'active'),(1402,1103,'active'),(1404,1105,'active'),(1410,1110,'active'),(1411,1111,'active'),(1412,1111,'active'),(1414,1113,'active'),(1415,1114,'active'),(1416,1115,'active');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'customer1','ffbc4675f864e0e9aab8bdf7a0437010',1,'First','Customer',NULL,NULL,'cust1_1357703483_per@fpt.edu.vn',NULL,'active'),(2,'truong','047c30e8313db6e45fd87ab6e1bfd1fb',3,'Truong','Nguyen Son',NULL,NULL,NULL,NULL,'active'),(3,'tram','ecb1da74e8ff8fdd2911197ecf8badc0',2,'Tram','Nguyen Thi Bich',NULL,NULL,NULL,NULL,'active'),(4,'hainl','7a9cc2b1396295cf21e1a628a0a168be',1,'Hải','Nguyễn Lương',NULL,NULL,'hainl60335@fpt.edu.vn',NULL,'active');
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
		 WHERE DATE(dtrp.departure_time) >= SUBDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
		   AND DATE(dtrp.departure_time) <= ADDDATE(DATE(DEPT_DATE), INTERVAL 3 DAY)
			-- DATE(dtrp.departure_time) = DATE(DEPT_DATE)
		   AND DATE(dtrp.departure_time) >= ADDDATE(NOW(), INTERVAL 30 MINUTE)) dept
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
ORDER BY dept.departure_time ASC;
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

-- Dump completed on 2013-03-20 21:15:10
