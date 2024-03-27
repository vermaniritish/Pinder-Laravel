-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: saloon
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

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
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `data` text,
  `client` int DEFAULT NULL,
  `admin` int DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin` (`admin`),
  KEY `client` (`client`),
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`admin`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `activities_ibfk_2` FOREIGN KEY (`client`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int DEFAULT NULL,
  `log_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_uuid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (29,2,'Home','9-F KItclu Nagar','Ludhiana','Punjab','Kitchlu Nagar',99.99999999,444.00000000,NULL,NULL,'2023-12-30 06:42:45',NULL),(32,2,'foo','foo','foo','foo','foo',99.99999999,444.00000000,NULL,'2024-01-05 15:46:12','2024-01-05 10:16:12','2024-01-05 10:16:34'),(33,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:46:34','2024-01-05 10:16:34','2024-01-05 10:16:46'),(34,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-01-05 15:46:46','2024-01-05 10:17:02'),(35,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,NULL,'2024-01-05 15:47:02','2024-01-05 10:18:25'),(36,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:25','2024-01-05 10:18:25','2024-01-05 10:18:27'),(37,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:27','2024-01-05 10:18:27','2024-01-05 10:18:27'),(38,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:27','2024-01-05 10:18:27','2024-02-03 23:40:18'),(39,NULL,'foo','The address field is required.','The city field is required.','The state field is required.','The area field is required.',99.99999999,444.00000000,NULL,'2024-02-04 05:10:19','2024-02-03 23:40:19',NULL),(40,4,NULL,'Chawni Mohalla, St. No. 4,  Manna Singh Nagar','Ludhiana',NULL,'141008',NULL,NULL,NULL,'2024-03-14 09:14:25','2024-03-14 09:14:25','2024-03-14 23:01:44'),(41,4,NULL,'Aaaa','Ludhiana',NULL,'1111',NULL,NULL,NULL,'2024-03-14 23:01:55','2024-03-14 23:01:55',NULL),(42,9,NULL,'Fffff','Ludhiana',NULL,'141001',NULL,NULL,NULL,'2024-03-16 13:55:02','2024-03-16 13:55:02',NULL),(43,9,NULL,'you','Panchkula',NULL,'141002',NULL,NULL,NULL,'2024-03-16 14:13:43','2024-03-16 14:13:43',NULL),(44,15,NULL,'Chawni Mohalla, St. No. 4,  Manna Singh Nagar','Ludhiana',NULL,'141008',NULL,NULL,NULL,'2024-03-19 16:23:52','2024-03-19 16:23:52',NULL),(45,8,NULL,'480,sector-9','Panchkula',NULL,'134109',NULL,NULL,NULL,'2024-03-19 18:10:56','2024-03-19 18:10:56',NULL),(46,4,NULL,'AAASSS','Panchkula',NULL,'112233',NULL,NULL,NULL,'2024-03-23 19:42:25','2024-03-23 19:42:25',NULL);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_permissions`
--

DROP TABLE IF EXISTS `admin_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `mode` enum('listing','create','update','delete') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `created_by` int NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `admin_id` (`admin_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `admin_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `otp` varchar(50) DEFAULT NULL,
  `otp_sent_on` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `address` tinytext,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (7,'Super','Admin','admin@laravel.com','$2y$10$RIGjhyvuyhJf.Kkjrcx/teILNFrgC.6v5Dw36LDFCuWZHOhGXCnCq',NULL,'2024-03-24 16:07:25',1,NULL,NULL,NULL,'/uploads/admins/1707670612357-group-1000001967-1.png',NULL,1,NULL,'0000-00-00 00:00:00',NULL,'2024-03-24 10:37:25');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_categories`
--

DROP TABLE IF EXISTS `blog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `image` text,
  `slug` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `blog_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `blog_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_categories`
--

LOCK TABLES `blog_categories` WRITE;
/*!40000 ALTER TABLE `blog_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category_relation`
--

DROP TABLE IF EXISTS `blog_category_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `blog_category_relation_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_category_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category_relation`
--

LOCK TABLES `blog_category_relation` WRITE;
/*!40000 ALTER TABLE `blog_category_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `image` text,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `blogs_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand_product`
--

DROP TABLE IF EXISTS `brand_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `brand_product_ibfk_3` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `brand_product_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand_product`
--

LOCK TABLES `brand_product` WRITE;
/*!40000 ALTER TABLE `brand_product` DISABLE KEYS */;
INSERT INTO `brand_product` VALUES (521,19,196,'2024-03-24 12:00:11','2024-03-24 12:00:11');
/*!40000 ALTER TABLE `brand_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `brands_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (6,'H&M',NULL,'<p>&nbsp;</p>\r\n\r\n<p>H&amp;M, or Hennes &amp; Mauritz, is a global fashion retailer known for its trendy and affordable clothing and accessories. Founded in 1947 in Sweden, H&amp;M has grown into one of the world&#39;s largest fashion retailers, with a presence in numerous countries.</p>','/uploads/brands/17027778445025-hm-logo.png',0,7,NULL,'2023-12-17 01:50:47','2023-12-16 20:20:47'),(14,'Honey Bee','honey-bee-MkO8V0',NULL,'/uploads/pages/1707748322363-honeybeelogo-200x.png',0,7,NULL,'2024-02-08 16:04:58','2024-02-12 14:32:05'),(15,'Richelon','richelon-job2o1',NULL,'/uploads/brands/17112667172520-logo-3-1.png',0,7,NULL,'2024-02-08 16:07:32','2024-03-24 07:51:59'),(16,'Rica','rica-9kY41E',NULL,'/uploads/pages/17076706006606-rica-logo.png',1,7,NULL,'2024-02-08 16:08:58','2024-02-11 16:56:42'),(17,'Lotus Herbals','lotus-herbals-o13O1z',NULL,'/uploads/pages/17077480782031-lotus-logo-a23a681d-2303-497c-aa08-f08ef9de97a4-140x.png',1,7,NULL,'2024-02-08 16:10:05','2024-02-12 14:28:00'),(18,'Cheryl\'s Cosmeceuticals','cheryls-cosmeceuticals-ZkWyaw',NULL,'/uploads/pages/17077478661422-logo.jpg',1,7,NULL,'2024-02-08 16:12:15','2024-02-12 14:24:28'),(19,'O3+','o3-AaLy1O',NULL,'/uploads/pages/17077477444336-o3.png',1,7,NULL,'2024-02-08 16:12:54','2024-02-12 14:22:26'),(20,'VLCC','vlcc-5VBYkG',NULL,'/uploads/pages/17077475356444-vlcc-logo.png',1,7,NULL,'2024-02-08 16:14:00','2024-02-12 14:19:03'),(21,'SARA','sara-XanK1r',NULL,'/uploads/pages/17077472395187-sara-beauty-164x.png',1,7,NULL,'2024-02-08 16:14:45','2024-02-12 14:14:02'),(22,'Aroma Treasures','aroma-treasures-xaMwkE',NULL,'/uploads/pages/17077469084805-aroma-treasures-logo.png',1,7,NULL,'2024-02-08 16:15:25','2024-02-12 14:08:30'),(23,'OxyLife','oxylife-JVoWVm',NULL,'/uploads/pages/17077484404027-android-icon-72x72.png',1,7,NULL,'2024-02-08 16:17:15','2024-02-12 14:34:06'),(24,'Ozone','ozone-DVz6VN',NULL,'/uploads/pages/17077487909041-326734689-723467489524333-2386076530513538069-n.jpg',1,7,NULL,'2024-02-08 16:17:56','2024-02-12 14:39:53');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `city_image` varchar(255) NOT NULL,
  `city_icon` varchar(255) NOT NULL,
  `state_id` char(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colours`
--

DROP TABLE IF EXISTS `colours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `color_code` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `colours_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colours`
--

LOCK TABLES `colours` WRITE;
/*!40000 ALTER TABLE `colours` DISABLE KEYS */;
INSERT INTO `colours` VALUES (1,'','hjghj','#FF0000',NULL,7,'0000-00-00 00:00:00','2024-03-16 19:54:13','2024-03-24 05:33:30'),(2,'','WHITE','#FF0001','/uploads/colours/17106862644202-screenshot-from-2024-03-08-19-34-21.png',7,'0000-00-00 00:00:00','2024-03-17 20:08:10','2024-03-24 05:28:27'),(3,'zzza-9VAO60','ZZZA','#FF0003',NULL,7,'2024-03-24 11:09:14','2024-03-24 10:59:44','2024-03-24 05:31:36');
/*!40000 ALTER TABLE `colours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iso2` char(2) DEFAULT NULL,
  `short_name` varchar(80) NOT NULL DEFAULT '',
  `long_name` varchar(80) NOT NULL DEFAULT '',
  `iso3` char(3) DEFAULT NULL,
  `numcode` varchar(6) DEFAULT NULL,
  `un_member` varchar(12) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `cctld` varchar(5) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(255) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `max_use` int DEFAULT NULL,
  `used` int DEFAULT '0',
  `end_date` date DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `is_percentage` tinyint NOT NULL DEFAULT '0',
  `amount` decimal(10,2) NOT NULL,
  `min_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_code` (`coupon_code`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `coupons_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'Welcome10','Use this coupon code to get 10% of discount.\r\nMinimum order value should be ₹ 600.','Welcome10','welcome10-AabNa0',1000,0,'2025-02-01',1,1,10.00,600.00,7,'2024-03-16 14:17:43','2024-03-16 14:42:15',NULL);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_logs`
--

DROP TABLE IF EXISTS `email_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `from` varchar(100) NOT NULL,
  `to` text NOT NULL,
  `cc` text,
  `bcc` text,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_logs`
--

LOCK TABLES `email_logs` WRITE;
/*!40000 ALTER TABLE `email_logs` DISABLE KEYS */;
INSERT INTO `email_logs` VALUES (19,'staff-assigned','Staff assigned to your order - #62.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:49','2024-01-24 12:18:49'),(20,'order-assigned','Order assigned to you  - #62.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:49','2024-01-24 12:18:49'),(21,'order-unassigned','Order Unassigned - #62','<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #62 has been unassigned from you. Here are the details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>Customer Name:</strong> Kiran Kumari<br />\r\n<strong>Customer Email: </strong>chaudharykiran125@gmail.com<br />\r\n<strong>Customer Contact:</strong> 08360445579<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(22,'staff-reassigned','Staff Reassigned - Order #62','<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(23,'staff-reassigned','Staff Reassigned - Order #62','<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','your.email+fakedata22046@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(24,'staff-assigned','Staff assigned to your order - #92.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-02-07 17:31:39','2024-02-07 17:31:39'),(25,'order-assigned','Order assigned to you  - #92.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-02-07 17:31:39','2024-02-07 17:31:39');
/*!40000 ALTER TABLE `email_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `type` enum('admin','client') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` text,
  `short_codes` tinytext,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'Staff Assigned','staff-assigned',NULL,'Staff assigned to your order - #{order_number}.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear {customer_name},</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {staff_name}</li>\r\n	<li><strong>Email:</strong> {staff_email}</li>\r\n	<li><strong>Contact Number:</strong> {staff_contact}</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 11:17:58'),(2,'Order Assigned','order-assigned',NULL,'Order assigned to you  - #{order_number}.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear {staff_name},</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {customer_name}</li>\r\n	<li><strong>Email:</strong> {customer_email}</li>\r\n	<li><strong>Contact Number:</strong> {customer_contact}</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:06:58'),(3,'Order Unassigned','order-unassigned',NULL,'Order Unassigned - #{order_number}','<p>Dear {staff_name},</p>\r\n\r\n<p>We regret to inform you that order #{order_number} has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>Customer Name:</strong> {customer_name}</li>\r\n	<li><strong>Customer Email: </strong>{customer_email}</li>\r\n	<li><strong>Customer Contact:</strong> {customer_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\n{company_name}<br />\r\n&nbsp;</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:21:10'),(4,'Staff Reassigned','staff-reassigned',NULL,'Staff Reassigned - Order #{order_number}','<p>Dear {customer_name},</p>\r\n\r\n<p>We want to inform you that the staff member for your order #{order_number} has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>New Staff Name:</strong> {staff_name}</li>\r\n	<li><strong>New Staff Email:</strong> {staff_email}</li>\r\n	<li><strong>New Staff Contact:</strong> {staff_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing {company_name}.</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}<br />\r\n&nbsp;</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:21:49');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `from_id` int NOT NULL,
  `to_id` int NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`to_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (5,'2014_10_12_000000_create_users_table',1),(6,'2014_10_12_100000_create_password_resets_table',1),(7,'2019_08_19_000000_create_failed_jobs_table',1),(8,'2023_12_09_113020_create_brands_table',1),(9,'2023_12_09_182202_create_products_table',2),(10,'2023_12_25_071344_create_activity_log_table',3),(11,'2023_12_26_071345_add_event_column_to_activity_log_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_comments`
--

DROP TABLE IF EXISTS `order_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `admin_id` (`admin_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `order_comments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_comments_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_comments_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_comments`
--

LOCK TABLES `order_comments` WRITE;
/*!40000 ALTER TABLE `order_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_description` text,
  `amount` decimal(10,0) NOT NULL,
  `quantity` int DEFAULT NULL,
  `duration_of_service` time DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` VALUES (242,131,131,'Full Body Wax | Honey','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',1077,1,'02:00:00',NULL,NULL,'2024-03-22 00:24:05'),(243,131,87,'Eyebrows','<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-22 00:24:05'),(244,131,103,'Lotus Radiant pearl facial','<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',760,1,'01:05:00',NULL,NULL,'2024-03-22 00:24:05'),(245,133,131,'Full Body Wax | Honey','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',1077,1,'02:00:00',NULL,NULL,'2024-03-22 12:44:59'),(246,133,90,'Lower Lip','<ul>\r\n	<li>Eliminates unwanted hair from the lower lip area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-22 12:44:59'),(247,133,103,'Lotus Radiant pearl facial','<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',760,1,'01:05:00',NULL,NULL,'2024-03-22 12:44:59'),(248,132,131,'Full Body Wax | Honey','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',1077,1,'02:00:00',NULL,NULL,'2024-03-22 12:44:59'),(249,132,90,'Lower Lip','<ul>\r\n	<li>Eliminates unwanted hair from the lower lip area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-22 12:44:59'),(250,132,103,'Lotus Radiant pearl facial','<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',760,1,'01:05:00',NULL,NULL,'2024-03-22 12:44:59'),(251,134,87,'Eyebrows','<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-23 19:42:57'),(252,134,132,'Full Body Wax | Chocolate','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n</ul>',1410,1,'02:00:00',NULL,NULL,'2024-03-23 19:42:57'),(253,134,93,'Full Face','<ul>\r\n	<li>Eliminates unwanted hair from the full face</li>\r\n	<li>This method prevents ingrown hairs&nbsp;</li>\r\n</ul>',198,1,'00:30:00',NULL,NULL,'2024-03-23 19:42:57'),(254,135,88,'Upper lip','<ul>\r\n	<li>Eliminates unwanted hair from the upper lip area</li>\r\n	<li>preventing ingrown hairs</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-23 19:45:26'),(255,135,131,'Full Body Wax | Honey','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',1077,1,'02:00:00',NULL,NULL,'2024-03-23 19:45:26'),(256,135,103,'Lotus Radiant pearl facial','<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',760,1,'01:05:00',NULL,NULL,'2024-03-23 19:45:26'),(257,136,87,'Eyebrows','<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',33,1,'00:05:00',NULL,NULL,'2024-03-23 19:46:34'),(258,136,131,'Full Body Wax | Honey','<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',1077,1,'02:00:00',NULL,NULL,'2024-03-23 19:46:34'),(259,136,103,'Lotus Radiant pearl facial','<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',760,1,'01:05:00',NULL,NULL,'2024-03-23 19:46:34');
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status_history`
--

DROP TABLE IF EXISTS `order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staff_id` int DEFAULT NULL,
  `old_value` int DEFAULT NULL,
  `new_value` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `field` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `created_by` (`created_by`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_status_history_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `order_status_history_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status_history`
--

LOCK TABLES `order_status_history` WRITE;
/*!40000 ALTER TABLE `order_status_history` DISABLE KEYS */;
INSERT INTO `order_status_history` VALUES (131,133,'accepted',NULL,NULL,NULL,NULL,7,'2024-03-22 12:56:41','2024-03-22 12:56:41'),(132,133,'accepted',NULL,NULL,NULL,NULL,7,'2024-03-22 12:56:42','2024-03-22 12:56:42'),(133,133,'on_the_way',NULL,NULL,NULL,NULL,7,'2024-03-22 12:56:42','2024-03-22 12:56:42'),(134,133,'accepted',NULL,NULL,NULL,NULL,7,'2024-03-22 12:56:42','2024-03-22 12:56:42'),(135,133,'on_the_way',NULL,NULL,NULL,NULL,7,'2024-03-22 22:05:32','2024-03-22 22:05:32'),(136,133,'reached_at_location',NULL,NULL,NULL,NULL,7,'2024-03-22 22:05:35','2024-03-22 22:05:35'),(137,133,'completed',NULL,NULL,NULL,NULL,7,'2024-03-22 22:05:38','2024-03-22 22:05:38'),(138,132,'in_progress',NULL,NULL,NULL,NULL,7,'2024-03-22 22:10:41','2024-03-22 22:10:41'),(139,131,'reached_at_location',NULL,NULL,NULL,NULL,7,'2024-03-22 22:10:45','2024-03-22 22:10:45'),(140,134,'',5,NULL,NULL,NULL,7,'2024-03-23 21:20:04','2024-03-23 21:20:04');
/*!40000 ALTER TABLE `order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prefix_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `manual_address` tinyint(1) DEFAULT '0',
  `address_id` int DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `booking_time` time DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shaguna_margin` decimal(10,2) DEFAULT NULL,
  `travel_charges` decimal(10,2) DEFAULT NULL,
  `partner_margin` decimal(10,2) DEFAULT NULL,
  `platform_charges` decimal(10,2) DEFAULT NULL,
  `buffer_margin_percent` decimal(10,2) DEFAULT NULL,
  `buffer_margin_amount` decimal(10,2) DEFAULT NULL,
  `shaguna_margin_percent` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `cgst` decimal(10,2) DEFAULT NULL,
  `sgst` decimal(10,2) DEFAULT NULL,
  `igst` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `our_profit` decimal(10,2) DEFAULT NULL,
  `staff_payment` decimal(10,2) DEFAULT NULL,
  `coupon` json DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_by_admin` tinyint(1) DEFAULT NULL,
  `status_by` int DEFAULT NULL,
  `status_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_id` (`address_id`),
  KEY `customer_id` (`customer_id`),
  KEY `status_by` (`status_by`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`status_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (131,4,'dsdss','2132',NULL,1,NULL,'Aaaa, Ludhiana 1111','Ludhiana',NULL,NULL,'30.7176535','76.6697667','2024-03-22','09:30:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1870.05,187.01,9.00,9.00,NULL,49.69,1732.73,276.05,1407.00,'{\"id\": 1, \"title\": \"Welcome10\", \"amount\": \"10.00\", \"min_amount\": \"600.00\", \"coupon_code\": \"Welcome10\", \"description\": \"Use this coupon code to get 10% of discount.\\r\\nMinimum order value should be ₹ 600.\", \"is_percentage\": 1}','reached_at_location',NULL,NULL,7,'2024-03-22 22:10:45','2024-03-22 00:24:05','2024-03-21 18:54:05',NULL),(132,8,'Amita','2133',NULL,1,NULL,'480,sector-9, Panchkula 134109','Panchkula',NULL,NULL,'30.710684','76.8129765','2024-03-22','13:30:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1870.05,0.00,NULL,NULL,18.00,83.35,1953.40,463.05,1407.00,NULL,'in_progress',NULL,NULL,7,'2024-03-22 22:10:41','2024-03-22 12:44:59','2024-03-22 07:14:59',NULL),(133,8,'Amita','2134',NULL,1,NULL,'480,sector-9, Panchkula 134109','Panchkula',NULL,NULL,'30.710684','76.8129765','2024-03-22','13:30:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1870.05,0.00,NULL,NULL,18.00,83.35,1953.40,463.05,1407.00,NULL,'completed',NULL,NULL,7,'2024-03-22 22:05:38','2024-03-22 12:44:59','2024-03-22 07:14:59',NULL),(134,4,'dsdss','2135',5,1,NULL,'Aaaa, Ludhiana 1111','Ludhiana',NULL,NULL,'30.8658365','75.8325356','2024-03-24','09:30:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1640.70,0.00,9.00,9.00,NULL,62.41,1703.11,346.70,1294.00,NULL,'pending',NULL,NULL,NULL,'2024-03-23 19:42:57','2024-03-23 19:42:57','2024-03-23 14:12:57',NULL),(135,4,'dsdss','2136',NULL,1,NULL,'AAASSS, Panchkula 112233','Panchkula',NULL,NULL,'30.8658381','75.8325694','2024-03-24','09:30:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1870.05,0.00,NULL,NULL,18.00,83.35,1953.40,463.05,1407.00,NULL,'pending',NULL,NULL,NULL,'2024-03-23 19:45:26','2024-03-23 19:45:26','2024-03-23 14:15:26',NULL),(136,4,'dsdss','2137',NULL,1,NULL,'Aaaa, Ludhiana 1111','Ludhiana',NULL,NULL,'30.8658384','75.8325535','2024-03-24','10:00:00',NULL,1.20,50.00,4.80,0.00,10.00,0.00,20.00,1870.05,0.00,9.00,9.00,NULL,83.35,1953.40,463.05,1407.00,NULL,'pending',NULL,NULL,NULL,'2024-03-23 19:46:34','2024-03-23 19:46:34','2024-03-23 14:16:34',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `slug` varchar(255) DEFAULT NULL,
  `image` text,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'Zara','<p>Zara is a renowned global fashion brand that has become synonymous with contemporary style and accessibility. Established with a commitment to delivering the latest fashion trends at affordable prices, Zara has become a favorite destination for fashion enthusiasts worldwide.</p>\r\n\r\n<p>Known for its agile approach to fashion, Zara quickly adapts to emerging styles and customer preferences. The brand offers a diverse range of clothing and accessories, blending quality craftsmanship with on-trend designs. Zara&#39;s collections cater to a broad audience, providing a seamless blend of elegance and modernity.</p>\r\n\r\n<p>With a keen eye on innovation and a dedication to sustainability, Zara continues to redefine the fashion landscape. From chic casual wear to sophisticated formal attire, Zara remains at the forefront of the fashion industry, making style accessible to all.&quot;</p>\r\n\r\n<p>Feel free to customize and modify this description according to your specific requirements or to better align with the unique aspects of Zara that you want to highlight.</p>',NULL,'/uploads/pages/17027386825949-zara.png',NULL,NULL,NULL,1,7,NULL,'2023-12-16 15:11:01','2023-12-16 09:41:01'),(2,'Customer Solutions Designer','<p>3521331</p>',NULL,'/uploads/pages/17027405889424-screenshot-from-2023-10-09-21-43-33.png','Corporate Communications Designer','Molestias soluta consectetur aliquam doloribus consectetur rem.','quam fugit placeat',1,7,NULL,'2023-12-16 15:29:50','2023-12-16 09:59:50'),(3,'Regional Security Producer','<p>You asked, Font Awesome delivers with 41 shiny new icons in version 4.7. Want to request new icons?&nbsp;<a href=\"https://fontawesome.com/v4/community/#requesting-new-icons\">Here&#39;s how</a>.&nbsp;Need vectors or want to use on the desktop? Check the&nbsp;<a href=\"https://fontawesome.com/v4/cheatsheet/\">cheatsheet</a>.</p>',NULL,'/uploads/pages/17027438998532-screenshot-from-2023-10-28-12-47-08.png','Human Group Consultant','Quas sunt dolorem ea necessitatibus veniam optio quasi atque necessitatibus.','modi cumque sint',1,7,NULL,'2023-12-16 16:25:01','2023-12-16 10:55:01');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `permissions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'Staff','staff','{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (7,NULL,'Threading','/uploads/categories/17079184798517-close-up-young-woman-getting-eyebrow-treatment-removebg-preview-1.png','threading',1,7,NULL,'2024-02-08 16:27:21','2024-03-10 07:10:07'),(8,NULL,'Waxing','/uploads/categories/1707919366857-wepik-export-20240214140229ya7k.png','waxing',1,7,NULL,'2024-02-08 16:27:34','2024-03-10 07:10:07'),(9,NULL,'Facials','/uploads/categories/17079196566021-wepik-export-20240214140724y4t6.png','facials',0,7,NULL,'2024-02-08 16:29:09','2024-03-24 06:53:25'),(10,NULL,'Cleanups','/uploads/categories/17079191908982-wepik-export-20240214135903lbwc.png','cleanups',0,7,NULL,'2024-02-08 16:29:27','2024-03-24 06:53:24'),(11,NULL,'Manicure','/uploads/categories/17079189304785-manicure-16238755371.png','manicure',0,7,NULL,'2024-02-08 16:29:55','2024-03-24 06:53:23'),(12,NULL,'Pedicure','/uploads/categories/17079186006046-rectangle-1132.png','pedicure',0,7,NULL,'2024-02-08 16:30:14','2024-03-24 06:53:23'),(13,NULL,'Bleach & Detan',NULL,'bleach-detan',0,7,NULL,'2024-02-08 16:31:15','2024-03-10 07:10:07'),(14,NULL,'Bleach','/uploads/categories/17079185506576-rectangle-1131.png','bleach-MkO8V0',0,7,NULL,'2024-02-11 13:02:11','2024-03-24 06:53:21'),(15,NULL,'De-tan','/uploads/categories/1707920179406-wepik-export-20240214135703zusm.png','de-tan',0,7,NULL,'2024-02-11 13:02:27','2024-03-24 06:53:20');
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category_relation`
--

DROP TABLE IF EXISTS `product_category_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_category_relation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_category_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=532 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category_relation`
--

LOCK TABLES `product_category_relation` WRITE;
/*!40000 ALTER TABLE `product_category_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_category_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reports`
--

DROP TABLE IF EXISTS `product_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `reasons` text NOT NULL,
  `ip` varchar(30) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `product_reports_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_reports_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reports`
--

LOCK TABLES `product_reports` WRITE;
/*!40000 ALTER TABLE `product_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sizes`
--

DROP TABLE IF EXISTS `product_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size_title` varchar(255) NOT NULL,
  `from_cm` int NOT NULL,
  `to_cm` int NOT NULL,
  `chest` int DEFAULT NULL,
  `waist` int DEFAULT NULL,
  `hip` int DEFAULT NULL,
  `length` int DEFAULT NULL,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `size_id` (`size_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_sizes_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `product_sizes_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sizes`
--

LOCK TABLES `product_sizes` WRITE;
/*!40000 ALTER TABLE `product_sizes` DISABLE KEYS */;
INSERT INTO `product_sizes` VALUES (115,'XL',1,1,2,1,1,1,196,27,4.00,'2024-03-24 12:00:11','2024-03-24 12:00:11');
/*!40000 ALTER TABLE `product_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sub_category_relation`
--

DROP TABLE IF EXISTS `product_sub_category_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sub_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `sub_category_id` int NOT NULL,
  `sub_category_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`sub_category_id`),
  CONSTRAINT `product_sub_category_relation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_sub_category_relation_ibfk_3` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sub_category_relation`
--

LOCK TABLES `product_sub_category_relation` WRITE;
/*!40000 ALTER TABLE `product_sub_category_relation` DISABLE KEYS */;
INSERT INTO `product_sub_category_relation` VALUES (3,196,1,'fg');
/*!40000 ALTER TABLE `product_sub_category_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shop_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `color_id` int DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `title` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `image` text,
  `cropped_area` text,
  `postcode` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `duration_of_service` time DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `service_price` decimal(10,2) DEFAULT NULL,
  `sold` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `shop_id` (`shop_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_ibfk_5` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (196,NULL,8,NULL,2,'Female',NULL,'sfsdf','sfsdf-P6B5lo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.00,NULL,NULL,0,1,7,NULL,'2024-03-24 17:30:11','2024-03-24 12:00:11');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_status` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `rating` int NOT NULL,
  `image` text,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,1,'Divya Chaudhary','3','<p>sdg</p>',3,NULL,1,7,'0000-00-00 00:00:00','2024-03-16 19:03:12','2024-03-21 15:36:06'),(2,1,'Divya Chaudhary','Larvel Devloper','<p><b>3</b></p>',1,NULL,1,7,NULL,'2024-03-16 19:14:56','2024-03-21 15:41:05'),(3,1,'Divya Chaudhary','Larvel Devloper','<p><b>2</b></p>',3,NULL,0,7,NULL,'2024-03-16 19:23:49','2024-03-21 16:35:23'),(4,1,'Divya Chaudhary','Larvel Devloper','<p>1</p>',4,'/uploads/ratings/17112669445658-logo-3-1.png',1,7,NULL,'2024-03-16 19:23:56','2024-03-24 07:55:46'),(5,1,'asdasda','ldcla','<p>dsfdsf</p>',1,NULL,0,7,'2024-03-24 10:47:32','2024-03-21 21:12:31','2024-03-24 05:17:32');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_keywords`
--

DROP TABLE IF EXISTS `search_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_keywords` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `keywords` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `search_keywords_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_keywords`
--

LOCK TABLES `search_keywords` WRITE;
/*!40000 ALTER TABLE `search_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_sugessions`
--

DROP TABLE IF EXISTS `search_sugessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_sugessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `search_sugessions_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_sugessions`
--

LOCK TABLES `search_sugessions` WRITE;
/*!40000 ALTER TABLE `search_sugessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_sugessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'company_name','Admin'),(2,'company_address','Admin'),(3,'pagination_method','scroll'),(4,'admin_second_auth_factor',''),(5,'admin_notification_email','admin@admin.com'),(6,'currency_code','INR'),(7,'currency_symbol','₹'),(8,'date_format','d-m-Y'),(9,'time_format','h:iA'),(10,'tax_percentage','10'),(11,'order_prefix','2001'),(12,'from_email','noreply@saloon.com'),(13,'email_method','smtp'),(14,'max_orders_per_hour','2'),(15,'duration','[\"09:30\", \"18:00\"]'),(16,'cgst','9'),(17,'sgst','9'),(18,'igst','18'),(19,'shaguna_margin','1.2'),(20,'travel_charges','50'),(21,'partner_margin','4.8'),(22,'platform_charges','0'),(23,'buffer_margin_percent','10'),(24,'buffer_margin_amount','0'),(25,'shaguna_margin_percent','20');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `bio` text,
  `website` text,
  `social_links` text,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `lat` varchar(50) DEFAULT NULL,
  `lng` varchar(50) DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `shops_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shops_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shops`
--

LOCK TABLES `shops` WRITE;
/*!40000 ALTER TABLE `shops` DISABLE KEYS */;
/*!40000 ALTER TABLE `shops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('Male','Female','Unisex') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size_title` varchar(10) DEFAULT NULL,
  `from_cm` int DEFAULT NULL,
  `to_cm` int DEFAULT NULL,
  `chest` int DEFAULT NULL,
  `waist` int DEFAULT NULL,
  `hip` int DEFAULT NULL,
  `length` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sizes_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (8,'Male','XL',1,1,1,1,1,1,7,'2024-03-16 10:11:20','2024-03-16 11:45:26','2024-03-16 11:45:26'),(12,'Male','L',1,1,1,1,1,1,7,'2024-03-16 11:16:53','2024-03-16 11:45:26','2024-03-16 11:45:26'),(15,'Male','XL',1,1,1,1,1,1,7,'2024-03-16 11:45:26','2024-03-16 11:45:32','2024-03-16 11:45:32'),(16,'Male','L',1,1,1,1,1,1,7,'2024-03-16 11:45:26','2024-03-16 11:45:32','2024-03-16 11:45:32'),(17,'Male','XL',2,1,1,1,1,1,7,'2024-03-16 11:45:32','2024-03-16 11:45:38','2024-03-16 11:45:38'),(18,'Male','L',1,1,1,1,1,1,7,'2024-03-16 11:45:32','2024-03-16 11:45:38','2024-03-16 11:45:38'),(19,'Male','XL',2,1,1,1,1,1,7,'2024-03-16 11:45:38','2024-03-17 12:57:35','2024-03-17 12:57:35'),(20,'Male','S',1,1,1,1,1,1,7,'2024-03-16 11:45:38','2024-03-17 12:57:35','2024-03-17 12:57:35'),(21,'Male','XL',2,1,1,1,1,1,7,'2024-03-17 12:57:35','2024-03-17 13:09:16','2024-03-17 13:09:16'),(22,'Male','S',1,1,1,1,1,1,7,'2024-03-17 12:57:35','2024-03-17 13:09:16','2024-03-17 13:09:16'),(23,'Male','M',1,1,1,1,1,1,7,'2024-03-17 12:57:35','2024-03-17 13:09:16','2024-03-17 13:09:16'),(24,'Male','XL',2,1,1,1,1,1,7,'2024-03-17 13:09:16','2024-03-17 13:09:16',NULL),(25,'Male','S',1,1,1,1,1,1,7,'2024-03-17 13:09:16','2024-03-17 13:09:16',NULL),(26,'Male','M',1,1,1,1,1,1,7,'2024-03-17 13:09:16','2024-03-17 13:09:16',NULL),(27,'Female','XL',1,1,2,1,1,1,7,'2024-03-17 14:25:28','2024-03-17 14:25:28',NULL),(28,'Unisex','XL',1,1,1,1,1,1,7,'2024-03-17 14:25:42','2024-03-17 14:25:42',NULL);
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sliders`
--

DROP TABLE IF EXISTS `sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sliders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `heading` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sub_heading` varchar(255) DEFAULT NULL,
  `button_status` tinyint(1) NOT NULL DEFAULT '0',
  `button_title` varchar(255) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `image` text,
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sliders_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sliders`
--

LOCK TABLES `sliders` WRITE;
/*!40000 ALTER TABLE `sliders` DISABLE KEYS */;
INSERT INTO `sliders` VALUES (7,'fv','fdfdf','fdfdf',0,NULL,NULL,0,'/uploads/sliders/17112669202769-logo-3-1.png',7,'0000-00-00 00:00:00','2024-03-24 11:29:08','2024-03-24 07:55:21');
/*!40000 ALTER TABLE `sliders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aadhar_card_number` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Graciela','Aufderhar',5423333333,'your.email+fakedata22046@gmail.com',1273456789012,'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',1,7,'2024-03-01 15:13:01','2024-01-19 15:54:40','2024-01-19 10:24:40'),(2,'Myles','Zulauf',1971231231,'your.email+fakedata88731@gmail.com',494123123123,'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',1,7,'2024-03-01 15:12:56','2024-01-20 01:46:46','2024-01-19 20:16:46'),(3,'Manisha','Kanwar',7018822593,'manisha90chandel@gmail.com',263355571779,NULL,1,7,NULL,'2024-03-01 15:12:47','2024-03-01 15:12:47'),(4,'Neha','.',9779996291,'neha123@gmail.com',863515348371,'/uploads/brands/1709383839179-whatsapp-image-2024-03-02-at-6.jpg',1,7,NULL,'2024-03-02 18:24:07','2024-03-02 18:24:07'),(5,'Suman','Kaur',7889409948,'gazleenkour@gmail.com',507169846069,NULL,1,7,NULL,'2024-03-06 10:46:13','2024-03-06 10:46:13'),(6,'shobhana','.',9988990950,'shobhanav786@gmail.com',296033557159,NULL,1,7,NULL,'2024-03-10 20:04:04','2024-03-10 20:04:04'),(7,'Gomti','Verma',7901751615,'gomtiverma087@gmail.com',788494991429,NULL,0,7,NULL,'2024-03-10 20:05:51','2024-03-10 20:05:51'),(8,'Divjot','Kaur',6239285811,'divjotrajpal13@gmail.com',219944689925,'/uploads/brands/17101474397437-divjot-staff-ldh.jpg',0,7,'2024-03-24 11:09:25','2024-03-11 14:29:43','2024-03-11 14:29:43'),(9,'sd',NULL,2222,NULL,NULL,NULL,1,7,'2024-03-23 20:31:22','2024-03-23 20:31:18','2024-03-23 20:31:18');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_documents`
--

DROP TABLE IF EXISTS `staff_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `file` text,
  `slug` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `created_by` int DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `staff_documents_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_documents_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_documents`
--

LOCK TABLES `staff_documents` WRITE;
/*!40000 ALTER TABLE `staff_documents` DISABLE KEYS */;
INSERT INTO `staff_documents` VALUES (11,2,'njkjjk','[\"/uploads/staff-documents/17061526554871-zara.png\",\"/uploads/staff-documents/17061526509131-hm-logo.png\"]',NULL,'2024-01-25 03:17:37',7,'2024-01-24 21:47:37'),(12,2,'iugyyu','[\"/uploads/staff-documents/17070249119068-zara.png\",\"/uploads/staff-documents/17070248966657-hm-logo.png\"]',NULL,'2024-02-04 05:35:13',7,'2024-02-04 00:05:13');
/*!40000 ALTER TABLE `staff_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `state_code` varchar(50) NOT NULL,
  `country_id` int NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`),
  CONSTRAINT `sub_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,8,'fg',NULL,'fg',1,7,NULL,'2024-03-24 12:53:06','2024-03-24 07:23:06');
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `address` text,
  `image` text,
  `bio` longtext,
  `last_login` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `otp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `seller` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_id` varchar(200) DEFAULT NULL,
  `google_id` varchar(200) DEFAULT NULL,
  `google_email` varchar(200) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Divya','Chaudhary','8360445579','2023-12-15','HOUSE NO 9-F KITCHLU NAGAR NEAR RAM SHARNAM',NULL,NULL,NULL,NULL,NULL,NULL,'female','chaudharydivya125@gmail.com','$2y$10$frqo8wY/h/iHj5Mt7ZAojehFnkhecYkJoXGWDi8gjVtY8zUzoU7fa',1,'2023-12-16 08:26:47',1,NULL,NULL,NULL,NULL,7,'2023-12-16 08:26:47','2023-12-16 02:56:47'),(2,'Kiran','Kumari','08360445579','2001-11-15','HOUSE NO 9F KITCHLU NAGAR NEAR RAM',NULL,NULL,NULL,NULL,NULL,NULL,'female','chaudharykiran125@gmail.com','$2y$10$BAZmu5zyp9.S6XwmHt0j6.YYYdwT2BJDV0rHdBp4ebPt83S6lTaKy',1,'2023-12-25 07:15:15',1,NULL,NULL,NULL,NULL,7,'2023-12-25 07:15:15','2023-12-25 01:45:15'),(3,'Himani','Mehta','8360445574','1999-02-15','HOUSE NO 9-F KITCHLU NAGAR NEAR RAM SHARNAM',NULL,NULL,NULL,NULL,NULL,NULL,'female','chaudharsfserfydivya125@gmail.com','$2y$10$eVNGd1WdnfEsDGk6kSvAzu7iC8NR1TnBiG5qSL8OU94NXaS4uPRPy',0,'2024-01-07 16:52:04',1,NULL,NULL,NULL,NULL,7,'2024-01-07 16:52:04','2024-01-07 11:22:04'),(4,'dsdss',NULL,'9988225144',NULL,NULL,NULL,NULL,NULL,'81Rwf6bpMz0Q90x29NXxyxS6GnFUUO5trDcxNPPaP8mqhPplPDCnJtUQqFJYaPo4','2024-04-20 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Shikha',NULL,'734099509',NULL,NULL,NULL,NULL,NULL,'Z60EwzSo9JMCFomzlFKbDkyf28VPu77dS7jBnmF3jEp67zu6DpPJHI4fxL6w1elG',NULL,'1749',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'DDD',NULL,'9988225144',NULL,NULL,NULL,NULL,NULL,'xJTbTC7y9oUeL4YUQzxi4zHXhK0dtBkqHJhpgY7f4GbI27BZQIKhNdM0FlGZiRod',NULL,'6922',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Shikha',NULL,'7340990509',NULL,NULL,NULL,NULL,NULL,'FKJPv3CXRemfaMmEGYcliMwaiN4Df5A0avQ5JqW8g1P1HqlzJtAYKCB9fjNj2aRk',NULL,'7304',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Amita',NULL,'9501583011',NULL,NULL,NULL,NULL,NULL,'iaTSIX3gj7uQPLoSD4SUJ4yUnpCJMVr7UfRP9Y1hSozHE5aZldCDAcm9BVAwOfKX','2024-04-20 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Raja Karan',NULL,'8198815002',NULL,NULL,NULL,NULL,NULL,'ZjmZZyaGZ1ZksTgr28tPfuvYnI5NqHJy4vlYNCcT8dbbSV30t3UomuIHZP63xbx0','2024-04-16 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'radha',NULL,'7348987407',NULL,NULL,NULL,NULL,NULL,'u8zyTTXvxzibp1NMqKh0pUD1lhgQscKBzmL5NZc5ibjY8ydkWCKQHGPezMNbfXDh','2024-04-26 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'Ritish',NULL,'9988225143',NULL,NULL,NULL,NULL,NULL,'HK5vrjrnpHXehWTFaobPBGkVokr1rj7yyrPbk3sYiIkFAnZGJpAp1vgWauWsIlk0',NULL,'8183',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'Tamanna Sharma',NULL,'7710516464',NULL,NULL,NULL,NULL,NULL,'EDOe4IsE9dywFkpssh2pJBsyvw2p7WTRYTeyJ3zkIQkk518AWSx9OmZGWNrzAKIP','2024-03-29 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'Ghh',NULL,'8542878841',NULL,NULL,NULL,NULL,NULL,'qtkPxcxVDbgGeEXLX4xvkZrsXV9N95b8Y1mespebGQhFKDcTBGLYgHgQU3E5YtpE',NULL,'9832',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,NULL,NULL,'6376906516',NULL,NULL,NULL,NULL,NULL,'ZfDHUJKTz6R60jLgEmsxUekE5n9I4Bddr92wI7p3Hzs0YWS9VxQxaMIXrFvh7q2o',NULL,'3689',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,'dsdss',NULL,'1122331122',NULL,NULL,NULL,NULL,NULL,'G2G1zDbhzieCKTgQ2rbgXI4Rqr7MfRLgulLXsB30LLlNLMUkPCv2gSVFk6oXeOVN','2024-04-19 00:00:00',NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_matches`
--

DROP TABLE IF EXISTS `users_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_matches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `match_id` int NOT NULL,
  `last_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_date` datetime DEFAULT NULL,
  `last_message_id` int DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `last_delete_id` int DEFAULT NULL,
  `is_mute` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `match_id` (`match_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `users_matches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_matches_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_matches_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_matches`
--

LOCK TABLES `users_matches` WRITE;
/*!40000 ALTER TABLE `users_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_permissions`
--

DROP TABLE IF EXISTS `users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `users_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_permissions`
--

LOCK TABLES `users_permissions` WRITE;
/*!40000 ALTER TABLE `users_permissions` DISABLE KEYS */;
INSERT INTO `users_permissions` VALUES (1,1,'email_buyer_message',1,'2023-12-16 02:56:47'),(2,1,'email_seller_message',1,'2023-12-16 02:56:47'),(3,1,'text_buyer_message',1,'2023-12-16 02:56:48'),(4,1,'text_seller_message',1,'2023-12-16 02:56:48'),(5,2,'email_buyer_message',1,'2023-12-25 01:45:15'),(6,2,'email_seller_message',1,'2023-12-25 01:45:15'),(7,2,'text_buyer_message',1,'2023-12-25 01:45:15'),(8,2,'text_seller_message',1,'2023-12-25 01:45:15'),(9,3,'email_buyer_message',1,'2024-01-07 11:22:04'),(10,3,'email_seller_message',1,'2024-01-07 11:22:04'),(11,3,'text_buyer_message',1,'2024-01-07 11:22:04'),(12,3,'text_seller_message',1,'2024-01-07 11:22:04');
/*!40000 ALTER TABLE `users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_tokens`
--

DROP TABLE IF EXISTS `users_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(200) NOT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `device_type` enum('android','ios','web') DEFAULT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  `fcm_token` text,
  `expire_on` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `users_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_tokens`
--

LOCK TABLES `users_tokens` WRITE;
/*!40000 ALTER TABLE `users_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_wishlist`
--

DROP TABLE IF EXISTS `users_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `users_wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_wishlist`
--

LOCK TABLES `users_wishlist` WRITE;
/*!40000 ALTER TABLE `users_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-24 17:44:57
