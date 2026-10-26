-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: mymart_dev_db
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mymart_dev_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mymart_dev_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mymart_dev_db`;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(1000) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,'C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\13bd9aff-bd35-453d-afd8-61f45460667c_iphone.jpg',4,1,79999,1),(2,'C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\13bd9aff-bd35-453d-afd8-61f45460667c_iphone.jpg',4,2,79999,2),(3,'C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\9a1ce6d8-4d71-4d6d-b42b-4e39cf6bf10e_d5daacff-9abc-4db8-b104-b3f16c248a18_iphone.jpg',5,1,79999,3),(4,'C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\13bd9aff-bd35-453d-afd8-61f45460667c_iphone.jpg',4,3,79999,4),(5,'C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\6f4265b5-9158-4a2b-98f3-2bfe73ea7f2c_HELP.md',2,1,109999,5);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `delivery_date` datetime(6) DEFAULT NULL,
  `order_status` varchar(50) DEFAULT NULL,
  `order_tracking_num` varchar(255) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT NULL,
  `razorpay_order_id` varchar(255) DEFAULT NULL,
  `razorpay_payment_id` varchar(255) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `total_quantity` int DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `shipping_addr_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `delivery_otp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FKilqjeviw38npkxx03hn8a255l` (`shipping_addr_id`),
  KEY `FKb27i75wq56qryt99ekyfi08ap` (`user_id`),
  CONSTRAINT `FKb27i75wq56qryt99ekyfi08ap` FOREIGN KEY (`user_id`) REFERENCES `user_dtls` (`user_id`),
  CONSTRAINT `FKilqjeviw38npkxx03hn8a255l` FOREIGN KEY (`shipping_addr_id`) REFERENCES `shipping_address` (`addr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2026-05-27 23:08:02.384163','2026-05-27 00:00:00.000000','CONFIRMED','69c771ce-04e8-470c-a0dc-2e9531a12a0d','PAID','order_SuTQ9nlSHqKUjW','payment_1001',79999,1,'2026-07-25 12:40:09.307698',5,10,'823835'),(2,'2026-05-27 23:10:41.666640',NULL,'CREATED','3b7b5de9-cb7b-4e76-9f10-3298138ac0dc','PENDING','order_SuTSxhxzgvGYf3','payment_1002',159998,2,'2026-05-27 23:10:41.666640',7,11,NULL),(3,'2026-05-27 23:11:27.630704',NULL,'CREATED','6856af5f-0df1-4542-9b14-8478e62092e1','PENDING','order_SuTTlpSt32QpgU','payment_1003',79999,1,'2026-05-27 23:11:27.630704',8,12,NULL),(4,'2026-05-27 23:11:45.326368',NULL,'CREATED','459383a6-a3fc-4037-b6ba-b462fc4483ad','PENDING','order_SuTU4zMugJatGd','payment_1004',239997,3,'2026-05-27 23:11:45.326368',9,13,NULL),(5,'2026-05-27 23:12:06.433116','2026-05-27 00:00:00.000000','CREATED','844cecd0-47b7-4c2e-8030-0bbbae84d5e8','PENDING','order_SuTURiOMpZqsOm','payment_1005',109999,1,'2026-05-27 23:36:37.713315',10,14,'457543');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `active` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `units_stock` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FK5cypb0k23bovo3rn1a5jqs6j4` (`category_id`),
  CONSTRAINT `FK5cypb0k23bovo3rn1a5jqs6j4` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'YES',1,'2026-05-20 12:53:56.767436','Apple smartphone','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploadsf5ed977d-31ba-4ce5-b181-a8afb6ef00e1_HELP.md','2026-05-20 12:53:56.767436','iPhone 15','iPhone 15 128GB',79999,10,1,NULL),(2,'NO',1,'2026-05-20 12:56:21.153687','Android smartphone updated again','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\6f4265b5-9158-4a2b-98f3-2bfe73ea7f2c_HELP.md','2026-05-20 12:59:47.762057','Samsung S24 Ultra','Samsung S24 Ultra 512GB',109999,3,1,1),(3,'NO',10,'2026-05-25 14:34:32.249512','Apple flagship smartphone','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\cf0ac97c-38f3-49cd-822e-af5becebb08f_product.png','2026-05-25 16:14:01.345769','iPhone 15','iPhone 15 128GB',79999,10,10,2),(4,'YES',10,'2026-05-25 15:45:03.351221','Apple flagship smartphone','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\13bd9aff-bd35-453d-afd8-61f45460667c_iphone.jpg','2026-05-25 15:45:03.351221','iPhone 15','iPhone 15 128GB',79999,10,10,2),(5,'YES',10,'2026-05-25 15:54:59.806520','Updated Apple flagship smartphone with titanium body','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\9a1ce6d8-4d71-4d6d-b42b-4e39cf6bf10e_d5daacff-9abc-4db8-b104-b3f16c248a18_iphone.jpg','2026-05-25 16:38:49.130686','iPhone 15 Pro Max','iPhone 15 128GB',159999,7,10,2),(6,'YES',10,'2026-05-25 17:25:59.240868','Apple flagship smartphone with A16 Bionic processor','C:\\Users\\amish\\Downloads\\ecommerce-backend-uploads\\4007a0e4-945f-49a4-8c1e-02ef812b92e8_iphone.jpg','2026-05-25 17:25:59.240868','iPhone 15','iPhone 15 128GB',79999,10,10,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `active_sw` varchar(255) DEFAULT NULL,
  `category_description` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'NO','Updated phones','Electronics Updated',NULL,'2026-05-20',NULL,'2026-05-20'),(2,'YES','All smartphone and mobile devices','Mobiles 20260525143307',10,'2026-05-25',10,'2026-05-25'),(3,'YES','All smartphone and mobile devices','Mobiles',NULL,'2026-05-25',NULL,'2026-05-25'),(4,'YES','All smartphone and mobile devices','Mobiles',NULL,'2026-05-25',NULL,'2026-05-25'),(5,'NO','Laptop computers and notebooks','Laptops',NULL,'2026-05-25',NULL,'2026-05-25'),(6,'YES','Electronic gadgets and accessories','Electronics',NULL,'2026-05-25',NULL,'2026-05-25'),(7,'YES','Updated electronics and gadgets category','Electronics Updated',NULL,'2026-05-25',NULL,'2026-05-25'),(8,'YES','Updated electronics and gadgets category','Electronics Updated',NULL,'2026-05-25',NULL,'2026-05-25'),(9,'YES','Smartphones','Mobiles',NULL,'2026-07-21',NULL,'2026-07-21'),(10,'YES','Smartphones','Mobiles',NULL,'2026-07-22',NULL,'2026-07-22'),(11,'YES','Smartphones','Mobiles',NULL,'2026-07-22',NULL,'2026-07-22');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_dtls`
--

DROP TABLE IF EXISTS `roles_dtls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_dtls` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `active_sw` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_dtls`
--

LOCK TABLES `roles_dtls` WRITE;
/*!40000 ALTER TABLE `roles_dtls` DISABLE KEYS */;
INSERT INTO `roles_dtls` VALUES (1,'YES','ADMIN'),(2,'YES','USER'),(4,NULL,NULL),(5,NULL,NULL);
/*!40000 ALTER TABLE `roles_dtls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_address`
--

DROP TABLE IF EXISTS `shipping_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_address` (
  `addr_id` int NOT NULL AUTO_INCREMENT,
  `active_sw` varchar(255) DEFAULT NULL,
  `addr_type` varchar(500) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `house_num` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`addr_id`),
  KEY `FK571ev3wtthxnfscq30u6y7dmp` (`user_id`),
  CONSTRAINT `FK571ev3wtthxnfscq30u6y7dmp` FOREIGN KEY (`user_id`) REFERENCES `user_dtls` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_address`
--

LOCK TABLES `shipping_address` WRITE;
/*!40000 ALTER TABLE `shipping_address` DISABLE KEYS */;
INSERT INTO `shipping_address` VALUES (4,'YES','Office',' Chennai','India','Flat 5001','Telangana','500090',18),(5,'YES','HOME','Hyderabad','India','Flat 302','Telangana','500081',10),(6,'YES','OFFICE','Bangalore','India','12-4-56','Karnataka','560001',10),(7,'NO','HOME','Hyderabad','India','Flat 302','Telangana','500081',11),(8,'YES','HOME','Chennai','India','Plot 45','Tamil Nadu','600028',12),(9,'YES','HOME','Pune','India','Flat 205','Maharashtra','411001',13),(10,'YES','OFFICE','Mumbai','India','House No 18','Maharashtra','400001',14),(11,'YES','HOME','Delhi','India','Villa 7B','Delhi','110001',15),(12,'YES','OFFICE','Kolkata','India','Apartment 901','West Bengal','700001',16),(13,'YES','HOME','Ahmedabad','India','Street 12, Building 45','Gujarat','380001',17);
/*!40000 ALTER TABLE `shipping_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dtls`
--

DROP TABLE IF EXISTS `user_dtls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dtls` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `active_sw` varchar(255) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phno` bigint DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `pwd_updated` varchar(255) DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dtls`
--

LOCK TABLES `user_dtls` WRITE;
/*!40000 ALTER TABLE `user_dtls` DISABLE KEYS */;
INSERT INTO `user_dtls` VALUES (10,'YES','2026-05-23','rahul@gmail.com','Rahul Sharma',9876543210,'RahulNew123','YES','2026-05-23'),(11,'YES','2026-05-23','sneha@gmail.com','Sneha Patel',9123456780,'SnehaNew123','YES','2026-05-23'),(12,'YES','2026-05-23','arjun@gmail.com','Arjun Verma',9988776655,'VX87Y','NO','2026-05-23'),(13,'YES','2026-05-23','kiran@gmail.com','Kiran Kumar',9090909090,'IYBJM','NO','2026-05-23'),(14,'YES','2026-05-23','meera@gmail.com','Meera Nair',9876501234,'HA5OB','NO','2026-05-23'),(15,'YES','2026-05-23','vikram@gmail.com','Vikram Singh',9988123456,'59UXL','NO','2026-05-23'),(16,'YES','2026-05-25','admin20260525143208@test.com','Admin Test',9876543210,'admin123','NO','2026-05-25'),(17,'YES','2026-05-25','admin20260525144429@test.com','Admin Test',9876543210,'admin123','NO','2026-05-25'),(18,'YES','2026-05-25','address20260525170139@test.com','Address User',9876543210,'user123','NO','2026-05-25');
/*!40000 ALTER TABLE `user_dtls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKo4aw48b41l53nidxjvkk1c3dr` (`role_id`),
  CONSTRAINT `FKjiflila70olqi1qmwqjsisk4b` FOREIGN KEY (`user_id`) REFERENCES `user_dtls` (`user_id`),
  CONSTRAINT `FKo4aw48b41l53nidxjvkk1c3dr` FOREIGN KEY (`role_id`) REFERENCES `roles_dtls` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (10,1),(14,1),(15,1),(16,1),(17,1),(11,2),(12,2),(13,2),(18,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-22 16:31:34
