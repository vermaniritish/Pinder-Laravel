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
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
INSERT INTO `addresses` VALUES (29,2,'Home','9-F KItclu Nagar','Ludhiana','Punjab',NULL,'Kitchlu Nagar',99.99999999,444.00000000,NULL,NULL,'2023-12-30 06:42:45',NULL),(32,2,'foo','foo','foo','foo',NULL,'foo',99.99999999,444.00000000,NULL,'2024-01-05 15:46:12','2024-01-05 10:16:12','2024-01-05 10:16:34'),(33,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:46:34','2024-01-05 10:16:34','2024-01-05 10:16:46'),(34,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-01-05 15:46:46','2024-01-05 10:17:02'),(35,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,NULL,'2024-01-05 15:47:02','2024-01-05 10:18:25'),(36,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:25','2024-01-05 10:18:25','2024-01-05 10:18:27'),(37,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:27','2024-01-05 10:18:27','2024-01-05 10:18:27'),(38,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,'2024-01-05 15:48:27','2024-01-05 10:18:27','2024-02-03 23:40:18'),(39,NULL,'foo','The address field is required.','The city field is required.','The state field is required.',NULL,'The area field is required.',99.99999999,444.00000000,NULL,'2024-02-04 05:10:19','2024-02-03 23:40:19',NULL),(40,4,NULL,'Chawni Mohalla, St. No. 4,  Manna Singh Nagar','Ludhiana',NULL,NULL,'141008',NULL,NULL,NULL,'2024-03-14 09:14:25','2024-03-14 09:14:25','2024-03-14 23:01:44'),(41,4,NULL,'Aaaa','Ludhiana',NULL,NULL,'1111',NULL,NULL,NULL,'2024-03-14 23:01:55','2024-03-14 23:01:55',NULL),(42,9,NULL,'Fffff','Ludhiana',NULL,NULL,'141001',NULL,NULL,NULL,'2024-03-16 13:55:02','2024-03-16 13:55:02',NULL),(43,9,NULL,'you','Panchkula',NULL,NULL,'141002',NULL,NULL,NULL,'2024-03-16 14:13:43','2024-03-16 14:13:43',NULL),(45,8,NULL,'480,sector-9','Panchkula',NULL,NULL,'134109',NULL,NULL,NULL,'2024-03-19 18:10:56','2024-03-19 18:10:56',NULL),(46,4,NULL,'AAASSS','Panchkula',NULL,NULL,'112233',NULL,NULL,NULL,'2024-03-23 19:42:25','2024-03-23 19:42:25',NULL);
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
INSERT INTO `admins` VALUES (7,'Super','Admin','admin@laravel.com','$2y$10$RIGjhyvuyhJf.Kkjrcx/teILNFrgC.6v5Dw36LDFCuWZHOhGXCnCq',NULL,'2024-03-30 19:21:45',1,NULL,NULL,'NhW56gLXLkcld118m4GXSKCKYdYhuVOJ','/uploads/admins/1707670612357-group-1000001967-1.png',NULL,1,NULL,'0000-00-00 00:00:00',NULL,'2024-03-30 13:51:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=549 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand_product`
--

LOCK TABLES `brand_product` WRITE;
/*!40000 ALTER TABLE `brand_product` DISABLE KEYS */;
INSERT INTO `brand_product` VALUES (521,19,196,'2024-03-24 12:00:11','2024-03-24 12:00:11'),(524,16,197,'2024-03-28 00:49:22','2024-03-28 00:49:22'),(533,21,198,'2024-03-28 01:54:37','2024-03-28 01:54:37'),(534,16,198,'2024-03-28 01:54:37','2024-03-28 01:54:37'),(535,22,199,'2024-03-29 02:47:06','2024-03-29 02:47:06'),(536,21,200,'2024-03-29 03:13:40','2024-03-29 03:13:40'),(537,20,201,'2024-03-30 07:30:32','2024-03-30 07:30:32'),(538,23,201,'2024-03-30 07:30:32','2024-03-30 07:30:32'),(547,21,202,'2024-03-30 11:05:02','2024-03-30 11:05:02'),(548,16,203,'2024-03-30 11:19:29','2024-03-30 11:19:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_logs`
--

LOCK TABLES `email_logs` WRITE;
/*!40000 ALTER TABLE `email_logs` DISABLE KEYS */;
INSERT INTO `email_logs` VALUES (19,'staff-assigned','Staff assigned to your order - #62.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:49','2024-01-24 12:18:49'),(20,'order-assigned','Order assigned to you  - #62.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:49','2024-01-24 12:18:49'),(21,'order-unassigned','Order Unassigned - #62','<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #62 has been unassigned from you. Here are the details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>Customer Name:</strong> Kiran Kumari<br />\r\n<strong>Customer Email: </strong>chaudharykiran125@gmail.com<br />\r\n<strong>Customer Contact:</strong> 08360445579<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(22,'staff-reassigned','Staff Reassigned - Order #62','<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(23,'staff-reassigned','Staff Reassigned - Order #62','<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>','noreply@saloon.com','your.email+fakedata22046@gmail.com',NULL,NULL,0,0,'2024-01-24 17:48:52','2024-01-24 12:18:52'),(24,'staff-assigned','Staff assigned to your order - #92.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','chaudharykiran125@gmail.com',NULL,NULL,0,0,'2024-02-07 17:31:39','2024-02-07 17:31:39'),(25,'order-assigned','Order assigned to you  - #92.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>','noreply@saloon.com','your.email+fakedata88731@gmail.com',NULL,NULL,0,0,'2024-02-07 17:31:39','2024-02-07 17:31:39'),(26,'registration','User Registered Successfully','<p>Hi [User&#39;s Name],</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: {email}&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-27 23:49:22','2024-03-27 18:19:22'),(27,'registration','User Registered Successfully','<p>Hi [User&#39;s Name],</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: {email}&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-27 23:50:59','2024-03-27 18:20:59'),(28,'registration','User Registered Successfully','<p>Hi [User&#39;s Name],</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: {email}&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudharydivya1125@gmail.com',NULL,NULL,0,0,'2024-03-29 18:35:09','2024-03-29 13:05:09'),(29,'registration','User Registered Successfully','<p>Hi [User&#39;s Name],</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: chaudssharydivya125@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudssharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-29 18:55:08','2024-03-29 13:25:08'),(30,'registration','User Registered Successfully','<p>Hi [User&#39;s Name],</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: chaudsshhharydivya125@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudsshhharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-29 18:55:21','2024-03-29 13:25:21'),(31,'registration','User Registered Successfully','<p>Hi Cow ,</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: chaudsshhharydivya125@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudsshhharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-29 18:56:35','2024-03-29 13:26:35'),(32,'registration','User Registered Successfully','<p>Hi Robin Son hood,</p>\r\n\r\n<p>Congratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: chaudhhharydivya125@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform and enjoy all the features we offer!</p>\r\n\r\n<p>If you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudhhharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-29 18:57:43','2024-03-29 13:27:43'),(33,'registration','User Registered Successfully','<p>Hi Charity ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: charity@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=WREA24dDHh\" target=\"_blank\">http://127.0.0.1:8000?token=WREA24dDHh</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','charity@gmail.com',NULL,NULL,0,0,'2024-03-29 22:02:32','2024-03-29 16:32:32'),(34,'registration','User Registered Successfully','<p>Hi Charity ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: charieety@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=WCocy1W2UDTkwBpZYKss5cmn3Sn5Prrz\" target=\"_blank\">http://127.0.0.1:8000?token=WCocy1W2UDTkwBpZYKss5cmn3Sn5Prrz</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','charieety@gmail.com',NULL,NULL,0,0,'2024-03-29 22:20:52','2024-03-29 16:50:52'),(35,'registration','User Registered Successfully','<p>Hi Divya ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: chaudharydivya125@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=Hxox9SdJ5s4lYfCO3FHowItSJ0cSaeD4\" target=\"_blank\">http://127.0.0.1:8000?token=Hxox9SdJ5s4lYfCO3FHowItSJ0cSaeD4</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-29 22:27:57','2024-03-29 16:57:57'),(36,'registration','User Registered Successfully','<p>Hi Kanupriya ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: kanupriya@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=xK3jc5u8Py0vpO7hIFBSOTleKPix5xuF\" target=\"_blank\">http://127.0.0.1:8000?token=xK3jc5u8Py0vpO7hIFBSOTleKPix5xuF</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','kanupriya@gmail.com',NULL,NULL,0,0,'2024-03-30 09:35:03','2024-03-30 04:05:03'),(37,'registration','User Registered Successfully','<p>Hi Divya ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: abc@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=8re7z8b5XhwuFzgro40xTwvWJSxODgh7\" target=\"_blank\">http://127.0.0.1:8000?token=8re7z8b5XhwuFzgro40xTwvWJSxODgh7</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','abc@gmail.com',NULL,NULL,0,0,'2024-03-30 13:06:02','2024-03-30 07:36:02'),(38,'registration','User Registered Successfully','<p>Hi Raha ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: raha@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=mfw3EjaVwHy49vqTo6TaC4hcwwRTGpzj\" target=\"_blank\">http://127.0.0.1:8000?token=mfw3EjaVwHy49vqTo6TaC4hcwwRTGpzj</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','raha@gmail.com',NULL,NULL,0,0,'2024-03-30 13:51:01','2024-03-30 08:21:01'),(39,'registration','User Registered Successfully','<p>Hi Raha ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: rahaa@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=Kn2hlalUrsznDBWgxpOJ4DJTtOf5um5Y\" target=\"_blank\">http://127.0.0.1:8000?token=Kn2hlalUrsznDBWgxpOJ4DJTtOf5um5Y</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','rahaa@gmail.com',NULL,NULL,0,0,'2024-03-30 13:51:13','2024-03-30 08:21:13'),(40,'registration','User Registered Successfully','<p>Hi Charity ,<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: charitable@gmail.com&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n<a href=\"http://127.0.0.1:8000?token=y4kluonf0y3dinlILQ8LywQ62orCMEaL\" target=\"_blank\">http://127.0.0.1:8000?token=y4kluonf0y3dinlILQ8LywQ62orCMEaL</a><br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','noreply@saloon.com','charitable@gmail.com',NULL,NULL,0,0,'2024-03-30 14:27:54','2024-03-30 08:57:54'),(41,'user-forgot-password','Password Recovery Email','<p>Hello Divya ,</p>\r\n\r\n<p>We received a request to reset your password for your account associated with the email address: chaudharydivya125@gmail.com.<br />\r\nTo reset your password, please click on the following link:</p>\r\n\r\n<p>http://127.0.0.1:8000/auth/recover-password/9rlnSBuwv7HoHJLo54WmCqnWCM94kOBL</p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-30 14:34:31','2024-03-30 09:04:31'),(42,'user-forgot-password','Password Recovery Email','<p>Hello Divya ,</p>\r\n\r\n<p>We received a request to reset your password for your account associated with the email address: chaudharydivya125@gmail.com.<br />\r\nTo reset your password, please click on the following link:</p>\r\n\r\n<p><a href=\"http://127.0.0.1:8000/auth/recover-password/SN4BGUH5lTK4u8qrz4HfQRqhhIMKxX7V\" target=\"_blank\">http://127.0.0.1:8000/auth/recover-password/SN4BGUH5lTK4u8qrz4HfQRqhhIMKxX7V</a></p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-30 14:37:31','2024-03-30 09:07:31'),(43,'user-forgot-password','Password Recovery Email','<p>Hello Divya ,</p>\r\n\r\n<p>Your OTP&nbsp; to reset your password is 438723.<br />\r\nTo reset your password, please click on the following link and enter otp.</p>\r\n\r\n<p><a href=\"http://127.0.0.1:8000/auth/recover-password/Pl2vijwZ1krj7fK2uPSyyVjAjzVdFfvF\" target=\"_blank\">http://127.0.0.1:8000/auth/recover-password/Pl2vijwZ1krj7fK2uPSyyVjAjzVdFfvF</a></p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-30 19:41:09','2024-03-30 14:11:09'),(44,'user-forgot-password','Password Recovery Email','<p>Hello Divya ,</p>\r\n\r\n<p>Your OTP&nbsp; to reset your password is 710185.<br />\r\nTo reset your password, please click on the following link and enter otp.</p>\r\n\r\n<p><a href=\"http://127.0.0.1:8000/auth/otp-verify/4pXrB4oZjtF8VYwa2p4DEekvuSr5xOCx\" target=\"_blank\">http://127.0.0.1:8000/auth/otp-verify/4pXrB4oZjtF8VYwa2p4DEekvuSr5xOCx</a></p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-30 20:06:48','2024-03-30 14:36:48'),(45,'user-forgot-password','Password Recovery Email','<p>Hello Divya ,</p>\r\n\r\n<p>Your OTP&nbsp; to reset your password is 553505.<br />\r\nTo reset your password, please click on the following link and enter otp.</p>\r\n\r\n<p><a href=\"http://127.0.0.1:8000/auth/otp-verify/Rnz06hE2FVCK0e5RbQfhUSqRS2ooAiud\" target=\"_blank\">http://127.0.0.1:8000/auth/otp-verify/Rnz06hE2FVCK0e5RbQfhUSqRS2ooAiud</a></p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','noreply@saloon.com','chaudharydivya125@gmail.com',NULL,NULL,0,0,'2024-03-30 20:24:00','2024-03-30 14:54:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'Staff Assigned','staff-assigned',NULL,'Staff assigned to your order - #{order_number}.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear {customer_name},</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {staff_name}</li>\r\n	<li><strong>Email:</strong> {staff_email}</li>\r\n	<li><strong>Contact Number:</strong> {staff_contact}</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 11:17:58'),(2,'Order Assigned','order-assigned',NULL,'Order assigned to you  - #{order_number}.','<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear {staff_name},</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {customer_name}</li>\r\n	<li><strong>Email:</strong> {customer_email}</li>\r\n	<li><strong>Contact Number:</strong> {customer_contact}</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:06:58'),(3,'Order Unassigned','order-unassigned',NULL,'Order Unassigned - #{order_number}','<p>Dear {staff_name},</p>\r\n\r\n<p>We regret to inform you that order #{order_number} has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>Customer Name:</strong> {customer_name}</li>\r\n	<li><strong>Customer Email: </strong>{customer_email}</li>\r\n	<li><strong>Customer Contact:</strong> {customer_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\n{company_name}<br />\r\n&nbsp;</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:21:10'),(4,'Staff Reassigned','staff-reassigned',NULL,'Staff Reassigned - Order #{order_number}','<p>Dear {customer_name},</p>\r\n\r\n<p>We want to inform you that the staff member for your order #{order_number} has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>New Staff Name:</strong> {staff_name}</li>\r\n	<li><strong>New Staff Email:</strong> {staff_email}</li>\r\n	<li><strong>New Staff Contact:</strong> {staff_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing {company_name}.</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}<br />\r\n&nbsp;</p>','{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',NULL,'2024-01-24 12:21:49'),(5,'Registration','registration',NULL,'User Registered Successfully','<p>Hi {name},<br />\r\nCongratulations! &nbsp;Your registration is complete.</p>\r\n\r\n<p>Account Details:&nbsp;<br />\r\nEmail Address: {email}&nbsp;</p>\r\n\r\n<p>Get started exploring our platform by clicking the link below!<br />\r\n{url}<br />\r\nIf you have any questions, feel free to reach out to our support team.</p>\r\n\r\n<p>Welcome aboard!</p>\r\n\r\n<form>&nbsp;</form>','{name}, {email}, {url}',NULL,'2024-03-29 16:29:16'),(6,'User Forgot Password','user-forgot-password','client','Password Recovery Email','<p>Hello {first_name} {last_name},</p>\r\n\r\n<p>Your OTP&nbsp; to reset your password is {otp}.<br />\r\nTo reset your password, please click on the following link and enter otp.</p>\r\n\r\n<p>{recovery_link}</p>\r\n\r\n<p>If you did not request a password reset, please ignore this email. Your password will remain unchanged.</p>\r\n\r\n<p>Thank you!<br />\r\n&nbsp;</p>','{first_name}, {last_name}, {email}, {recovery_link}, {otp}',NULL,'2024-03-30 14:10:01');
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
-- Table structure for table `homepage`
--

DROP TABLE IF EXISTS `homepage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homepage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homepage`
--

LOCK TABLES `homepage` WRITE;
/*!40000 ALTER TABLE `homepage` DISABLE KEYS */;
INSERT INTO `homepage` VALUES (1,'_token','ZJt08ZhNgHK7ySolnH2aFYLPV9Dv1d4NX2ROdYDn'),(2,'title','Ipsa laborum Do fa'),(3,'banner_1_label','Quibusdam ipsum del'),(4,'banner_1_heading','Possimus duis id vo\r\nUpto 10% off'),(5,'banner_1_button_status','1'),(6,'banner_1_button_title','Voluptatem Ipsum n'),(7,'banner_1_button_url','/'),(8,'banner_1_image','/uploads/home/17112626808696-banner11.jpg'),(9,'banner_2_label','Cillum fugit repell'),(10,'banner_2_heading','Est assumenda ut dis\r\nUpto 10% off'),(11,'banner_2_button_status','1'),(12,'banner_2_button_title','Molestiae architecto'),(13,'banner_2_button_url','/'),(14,'banner_2_image','/uploads/home/17112627087916-banner21.jpg'),(15,'banner_3_label','Est irure minim est'),(16,'banner_3_heading','Ipsa in nihil animi\r\nUpto 10% off'),(17,'banner_3_button_status','1'),(18,'banner_3_button_title','Maxime ad unde qui q'),(19,'banner_3_button_url','/'),(20,'banner_3_image','/uploads/home/17112627297498-banner31.jpg'),(21,'banner_4_label','Eaque dolor ipsam el'),(22,'banner_4_heading','Officiis accusantium\r\nUpto 10% off'),(23,'banner_4_button_status','1'),(24,'banner_4_button_title','Vel delectus lorem'),(25,'banner_4_button_url','/'),(26,'banner_4_image','/uploads/home/17112627533913-banner43.png'),(27,'meta_title','Omnis enim hic delec'),(28,'meta_description','Sed et recusandae E'),(29,'meta_keywords','Cumque quod sapiente'),(30,'deal_day_label','Hurry up and Get 25% Discount'),(31,'deal_day_heading','Deals Of The Day'),(32,'deal_day_subheading','Lorem ipsum dolor sit amet, consectetur adipisicing elit,\r\nsed do eiusmod tempor incididunt ut labore'),(33,'deal_day_button_status','1'),(34,'deal_day_button_title','Shop Now'),(35,'deal_day_button_url','/'),(36,'deal_day_image','/uploads/home/17112646993165-banner-bg11.jpg'),(37,'left_grid_label','Pick Your Items'),(38,'left_grid_heading','Up to 25% Off Order Now'),(39,'left_grid_button_status','1'),(40,'left_grid_button_title','Shop Now'),(41,'left_grid_button_url','/'),(42,'left_grid_image','/uploads/home/17112656235527-banner51.png'),(43,'right_grid_label','Special offer'),(44,'right_grid_heading','Up to 35% Off Order Now'),(45,'right_grid_button_status','1'),(46,'right_grid_button_title','Shop Now'),(47,'right_grid_button_url','/'),(48,'right_grid_image','/uploads/home/1711265685404-banner61.png'),(49,'bottom_banner_label','Need Winter Boots?'),(50,'bottom_banner_heading','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua enim ad minim veniam, quis nostrud exercitation'),(51,'bottom_banner_button_status','1'),(52,'bottom_banner_button_title','Shop Now'),(53,'bottom_banner_button_url','/'),(54,'bottom_banner_image','/uploads/home/17112662077389-banner-bg21.png'),(55,'footer_icon_1_label','SECURE SHOPPING'),(56,'footer_icon_1_heading','Free order over £300'),(57,'footer_icon_1_image','/uploads/home/17112675948531-svgviewer-png-output-8.png'),(58,'footer_icon_2_label','ACCEPT PAYMENT'),(59,'footer_icon_2_heading','Visa, Paypal, Master'),(60,'footer_icon_2_image','/uploads/home/17112679028861-svgviewer-png-output-7.png'),(61,'footer_icon_3_label','30 DAY RETURN'),(62,'footer_icon_3_heading','30 day guarantee'),(63,'footer_icon_3_image','/uploads/home/17112679067953-svgviewer-png-output-5.png'),(64,'footer_icon_4_label','24/7 SUPPORT'),(65,'footer_icon_4_heading','Support every time'),(66,'footer_icon_4_image','/uploads/home/1711267607184-svgviewer-png-output-6.png'),(67,'footer_title','About Us'),(68,'footer_description','Lorem ipsum dolor sit amet, consectetur adipisici ti elit seddo eiusmod tempor incididunt utlabore et dolore magna aliqua enim ad minim veniam quisnostrud exercitation ullamco'),(69,'facebook','https://facebook.com/example'),(70,'twitter','https://twitter.com/example'),(71,'instagram','https://instagram.com/example'),(72,'youtube','https://youtube.com/example'),(73,'whatsapp','+12-2233443322'),(74,'footer_link1_title','About Us'),(75,'footer_link1','/about-us'),(76,'footer_link2_title','Contact Us'),(77,'footer_link2','/contact-us'),(78,'footer_link3_title','FAQs'),(79,'footer_link3','/faqs'),(80,'footer_link4_title','Privacy Policy'),(81,'footer_link4','/privacy-policy'),(82,'footer_link5_title','Delivery Information'),(83,'footer_link5','/delivery-information'),(84,'footer_link6_title','Return Policy'),(85,'footer_link6','/return-policy'),(86,'quick_links_title','Quick Links'),(87,'instagram_widget','<div class=\"footer_instagram footerwidget--inner\">\r\n                        <div class=\"footerinstagram--list d-flex\">\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagramthumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF3TLBTT7\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram1.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagramthumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF60sBxhN\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram2.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagramthumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF90ZB6HG\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram3.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"footerinstagram--list d-flex\">\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagramthumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGAe6BQeu\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram4.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagramthumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGCWcBbv9\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram5.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagramthumbnail\">\r\n                                <a class=\"instagram_thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGFDMhoid\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram6.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                        </div>\r\n                    </div>'),(88,'newsletter_text','Fill their seed open meat. Sea you great Saw image stl'),(89,'menu_header','[\r\n    {\r\n        \"id\": 7,\r\n        \"title\": \"T-Shirt\"\r\n    },\r\n    {\r\n        \"id\": 8,\r\n        \"title\": \"Polo T-Shirts\"\r\n    },\r\n    {\r\n        \"id\": 9,\r\n        \"title\": \"Hi Vis\"\r\n    },\r\n    {\r\n        \"id\": 10,\r\n        \"title\": \"Jackets\"\r\n    },\r\n    {\r\n        \"id\": 11,\r\n        \"title\": \"Hoodies\"\r\n    },\r\n    {\r\n        \"id\": 12,\r\n        \"title\": \"Bottoms\"\r\n    },\r\n    {\r\n        \"id\": 13,\r\n        \"title\": \"KnitWear\"\r\n    },\r\n    {\r\n        \"id\": 14,\r\n        \"title\": \"Headwear\"\r\n    }\r\n]');
/*!40000 ALTER TABLE `homepage` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (5,'2014_10_12_000000_create_users_table',1),(6,'2014_10_12_100000_create_password_resets_table',1),(7,'2019_08_19_000000_create_failed_jobs_table',1),(8,'2023_12_09_113020_create_brands_table',1),(9,'2023_12_09_182202_create_products_table',2),(10,'2023_12_25_071344_create_activity_log_table',3),(11,'2023_12_26_071345_add_event_column_to_activity_log_table',3),(12,'2019_12_14_000001_create_personal_access_tokens_table',4);
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
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','bcc03b666b650bd1f9c2de567fdeda43138f88047c863a705592f98102fc9df8','[\"*\"]',NULL,'2024-03-29 12:10:53','2024-03-29 12:10:53'),(2,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','d36ed67caf01f81d104a00dba97b2baaaf873bd7359802698b9ee3a836f7ba76','[\"*\"]',NULL,'2024-03-29 12:14:14','2024-03-29 12:14:14'),(3,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','295a09eb7ca78ea333607c3c75cbaac0844cd66d407f65b98df0ad5f4a7fa33c','[\"*\"]',NULL,'2024-03-29 12:15:07','2024-03-29 12:15:07'),(4,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','4c2a0f45ec65e086b8453ad2693f1eb75e36d74adce9db6546a4a9d98352ebbd','[\"*\"]',NULL,'2024-03-29 12:17:31','2024-03-29 12:17:31'),(5,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','f2e5de25773b831fc5e293b4d538dd8e9bcbbf70eb986bd018fb7f21d81b0568','[\"*\"]',NULL,'2024-03-29 12:55:25','2024-03-29 12:55:25'),(6,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','709b5357f470b3e175f557c4d450d8f79d529b0bf79d4b0e71bfbb01ec1b3e6c','[\"*\"]',NULL,'2024-03-29 12:55:28','2024-03-29 12:55:28'),(7,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','29b515d179155bc9b495aa728d7bf7f278a761966e49b3fc58499ff47e436091','[\"*\"]',NULL,'2024-03-29 16:30:48','2024-03-29 16:30:48'),(8,'App\\Models\\Admin\\Users',25,'chaudharydivya125@gmail.com','95825e58b714dbbb2a0ea4c527f92033b918c95bf59859acd793d05e60a6db93','[\"*\"]',NULL,'2024-03-29 16:31:04','2024-03-29 16:31:04'),(9,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','b7b8205da73a43159799e205ae9894e0861d5af665dcbc77caacc204949f489c','[\"*\"]',NULL,'2024-03-30 07:27:27','2024-03-30 07:27:27'),(10,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','f8e9efa9b78d7f33676b87166b4ba5175201ce875364ca2fd2ea1eb28b6dbefc','[\"*\"]',NULL,'2024-03-30 07:28:12','2024-03-30 07:28:12'),(11,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','7fbb03a1a05e7812d344a40b2622a8ca2c5bdaad326339df887917d9fb7e763a','[\"*\"]',NULL,'2024-03-30 07:37:45','2024-03-30 07:37:45'),(12,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','109376f3d28d40b621f70a1db08120348bc59af18aecc9c76bacbdc6f9a9bc24','[\"*\"]',NULL,'2024-03-30 07:37:57','2024-03-30 07:37:57'),(13,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','4900a9fb852e71dfb8a445494bf224df92455c72369e5b90f474c94f0ef7840c','[\"*\"]',NULL,'2024-03-30 08:27:52','2024-03-30 08:27:52'),(14,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','fe0b9a798c73b3614caefd17db41ecd901db5ad71fff677794682f250099fdf0','[\"*\"]',NULL,'2024-03-30 08:46:40','2024-03-30 08:46:40'),(15,'App\\Models\\Admin\\Users',33,'chaudharydivya125@gmail.com','d00321f9fca8bf44f5fd45fd1ccf99d0b721dec062618d2460d1a2fc670f3526','[\"*\"]',NULL,'2024-03-30 08:47:52','2024-03-30 08:47:52');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
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
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (7,NULL,'Threading',NULL,'/uploads/categories/17079184798517-close-up-young-woman-getting-eyebrow-treatment-removebg-preview-1.png','threading',1,7,NULL,'2024-02-08 16:27:21','2024-03-10 07:10:07'),(8,NULL,'Waxing',NULL,'/uploads/categories/1707919366857-wepik-export-20240214140229ya7k.png','waxing',1,7,NULL,'2024-02-08 16:27:34','2024-03-10 07:10:07'),(9,NULL,'Facials',NULL,'/uploads/categories/17079196566021-wepik-export-20240214140724y4t6.png','facials',0,7,NULL,'2024-02-08 16:29:09','2024-03-24 06:53:25'),(10,NULL,'Cleanups',NULL,'/uploads/categories/17079191908982-wepik-export-20240214135903lbwc.png','cleanups',0,7,NULL,'2024-02-08 16:29:27','2024-03-24 06:53:24'),(11,NULL,'Manicure',NULL,'/uploads/categories/17079189304785-manicure-16238755371.png','manicure',0,7,NULL,'2024-02-08 16:29:55','2024-03-24 06:53:23'),(12,NULL,'Pedicure',NULL,'/uploads/categories/17079186006046-rectangle-1132.png','pedicure',0,7,NULL,'2024-02-08 16:30:14','2024-03-24 06:53:23'),(13,NULL,'Bleach & Detan',NULL,NULL,'bleach-detan',0,7,NULL,'2024-02-08 16:31:15','2024-03-10 07:10:07'),(14,NULL,'Bleach',NULL,'/uploads/categories/17079185506576-rectangle-1131.png','bleach-MkO8V0',0,7,NULL,'2024-02-11 13:02:11','2024-03-24 06:53:21'),(15,NULL,'De-tan',NULL,'/uploads/categories/1707920179406-wepik-export-20240214135703zusm.png','de-tan',0,7,NULL,'2024-02-11 13:02:27','2024-03-24 06:53:20'),(17,NULL,'HAHAHA','<h2>What is Lorem Ipsum?</h2>\r\n\r\n<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<h2>Why do we use it?</h2>\r\n\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>','/uploads/categories/17115870411742-logo-3-1.png','hahaha-2oLZrA',0,7,NULL,'2024-03-28 05:35:14','2024-03-28 00:50:43');
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
-- Table structure for table `product_colors`
--

DROP TABLE IF EXISTS `product_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color_id` int NOT NULL,
  `color_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` int NOT NULL,
  `modified` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `color_id` (`color_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `product_colors_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_colors_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `colours` (`id`),
  CONSTRAINT `product_colors_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_colors`
--

LOCK TABLES `product_colors` WRITE;
/*!40000 ALTER TABLE `product_colors` DISABLE KEYS */;
INSERT INTO `product_colors` VALUES (16,202,2,'WHITE',NULL,7,2024,2024),(17,202,1,'hjghj',NULL,7,2024,2024),(18,203,2,'WHITE',NULL,7,2024,2024),(19,203,1,'hjghj',NULL,7,2024,2024);
/*!40000 ALTER TABLE `product_colors` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sizes`
--

LOCK TABLES `product_sizes` WRITE;
/*!40000 ALTER TABLE `product_sizes` DISABLE KEYS */;
INSERT INTO `product_sizes` VALUES (115,'XL',1,1,2,1,1,1,196,27,4.00,'2024-03-24 12:00:11','2024-03-24 12:00:11'),(118,'XL',2,1,1,1,1,1,197,24,1.00,'2024-03-28 00:49:22','2024-03-28 00:49:22'),(123,'XL',1,1,2,1,1,1,198,27,52.00,'2024-03-28 01:54:37','2024-03-28 01:54:37'),(124,'XL',2,1,1,1,1,1,199,24,1.00,'2024-03-29 02:47:06','2024-03-29 02:47:06'),(125,'XL',1,1,2,1,1,1,200,27,0.00,'2024-03-29 03:13:40','2024-03-29 03:13:40'),(126,'S',1,1,1,1,1,1,201,25,7.00,'2024-03-30 07:30:32','2024-03-30 07:30:32'),(135,'XL',2,1,1,1,1,1,202,24,3.00,'2024-03-30 11:05:02','2024-03-30 11:05:02'),(136,'XL',2,1,1,1,1,1,203,24,0.00,'2024-03-30 11:19:29','2024-03-30 11:19:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sub_category_relation`
--

LOCK TABLES `product_sub_category_relation` WRITE;
/*!40000 ALTER TABLE `product_sub_category_relation` DISABLE KEYS */;
INSERT INTO `product_sub_category_relation` VALUES (3,196,1,'fg'),(6,197,1,'fg'),(13,198,1,'fg'),(14,198,2,'kjjh'),(15,199,1,'fg'),(16,200,1,'fg'),(17,201,1,'fg'),(18,201,2,'kjjh'),(30,202,1,'fg'),(31,202,2,'kjjh'),(32,203,1,'fg');
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
  `max_price` decimal(10,2) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (196,NULL,8,NULL,'Female',NULL,'sfsdf','sfsdf-P6B5lo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.00,NULL,NULL,0,1,7,NULL,'2024-03-24 17:30:11','2024-03-24 12:00:11'),(197,NULL,8,NULL,'Male',NULL,'zdfv','zdfv-9rRMA6',NULL,'[\"\\/uploads\\/products\\/17115869433166-logo-3-1.png\"]',NULL,NULL,NULL,NULL,'00:59:00',NULL,4.00,NULL,NULL,0,1,7,NULL,'2024-03-27 20:21:36','2024-03-28 00:49:22'),(198,NULL,8,NULL,'Female','[\"bgffggf\",\"ghh\"]','m,m','mm-2VzB2V',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.00,NULL,NULL,0,1,7,NULL,'2024-03-28 07:10:51','2024-03-28 01:54:36'),(199,NULL,8,NULL,'Male','[\"kjkjnhj\",\"kknn\"]','k,k,','kk-grdk76',NULL,NULL,NULL,NULL,NULL,NULL,'00:59:00',NULL,1.00,3.00,NULL,0,1,7,NULL,'2024-03-29 08:17:06','2024-03-29 02:47:06'),(200,NULL,8,NULL,'Female',NULL,'dvsdf','dvsdf-Lo1qdo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.00,NULL,NULL,0,1,7,NULL,'2024-03-29 08:43:40','2024-03-29 03:13:40'),(201,NULL,8,NULL,'Male','[\"svsdf\",\"sdfsdf\"]','sdsdfsfsdf','sdsdfsfsdf-yV7GEV',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3.00,3.00,NULL,0,1,7,NULL,'2024-03-30 13:00:32','2024-03-30 07:30:32'),(202,NULL,8,NULL,'Male',NULL,'dsfsdf','dsfsdf-NrYPb6','<p>hahaha</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.00,2.00,NULL,0,1,7,NULL,'2024-03-30 15:28:41','2024-03-30 11:05:02'),(203,NULL,8,NULL,'Male',NULL,'seth','seth-9VAl9r','<p>hahahaha</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,3.00,1.00,NULL,0,1,7,NULL,'2024-03-30 16:19:33','2024-03-30 11:19:29');
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
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,8,'fg',NULL,NULL,'fg',1,7,NULL,'2024-03-24 12:53:06','2024-03-24 07:23:06'),(2,8,'kjjh','<h2>What is Lorem Ipsum?</h2>\r\n\r\n<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<h2>Why do we use it?</h2>\r\n\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>','/uploads/subCategories/17115872109762-logo-3-1.png','kjjh-NrYGo5',1,7,NULL,'2024-03-28 06:05:07','2024-03-28 00:53:32');
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
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (33,'Divya','','',NULL,NULL,NULL,NULL,NULL,'Rnz06hE2FVCK0e5RbQfhUSqRS2ooAiud',NULL,'553505',NULL,'chaudharydivya125@gmail.com','$2y$10$58ZOOpDXkA.A14SamdPJ1.1QAuAGUh5DF5kDx2suLDrEAvB8gEK76',1,'2024-03-29 22:28:57',0,NULL,NULL,NULL,'0000-00-00 00:00:00','127.0.0.1','2024-03-29 16:57:57',NULL,7,'2024-03-29 22:27:57','2024-03-29 16:57:57'),(34,'Charity','','',NULL,NULL,NULL,NULL,NULL,'iqh17zhbIZVhI9Q1G0D5Y7N8OjfsgybS',NULL,NULL,NULL,'charity@gmail.com','$2y$10$KEScC2AgIUtfoT1NddosQOgKNU9Z1a/qf5LRJVBk8iu3yOwhgy/lu',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:22:48','2024-03-30 03:52:48'),(35,'Kabir','','',NULL,NULL,NULL,NULL,NULL,'jK5vBrMpk9PBczDG2dgcMzfAlJCEP7NQ',NULL,NULL,NULL,'kabir@gmail.com','$2y$10$rrGDm1L9pS.9p0LRpqwKpO8cGHsstehVuJ9fB19kZWEBs/C.7hAP2',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:23:24','2024-03-30 03:53:24'),(36,'Priya','','',NULL,NULL,NULL,NULL,NULL,'G6Euu01dhptUBoYBSJCHXyqmAZcu60KG',NULL,NULL,NULL,'priya@gmail.com','$2y$10$vJI3K3qx8QX1YYB2ZAgv2evOJM.OfIW4WAELexHaLtlmmo2oXak1W',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:29:03','2024-03-30 03:59:03'),(37,'Himani','','',NULL,NULL,NULL,NULL,NULL,'t3EHRWS6sFtXam0Kw4ib3Y0opUchQjGx',NULL,NULL,NULL,'himani@gmail.com','$2y$10$L2pzYM.GNX/NLFLZ7hRz5OlMT3rOBo3jpASrmlegrJtS8CPqUAzai',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:31:11','2024-03-30 04:01:11'),(38,'Supriya','','',NULL,NULL,NULL,NULL,NULL,'vGcFRr1AviT5kc0VFr1gJpmteAbDqYL1',NULL,NULL,NULL,'supriya@gmail.com','$2y$10$sG5/zVdLDa1TDi0LKJo5wu1okPJcqbh9V508kGabqsjctme2e4yKS',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:33:34','2024-03-30 04:03:34'),(39,'Kanupriya','','',NULL,NULL,NULL,NULL,NULL,'xK3jc5u8Py0vpO7hIFBSOTleKPix5xuF',NULL,NULL,NULL,'kanupriya@gmail.com','$2y$10$7EkSKJgIdGz5d1SmwAP20OBLTw6lUIgbONdjzZvXyO0BstJvUHulC',1,'2024-03-30 09:35:58',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 09:35:03','2024-03-30 04:05:03'),(40,'Divya','','',NULL,NULL,NULL,NULL,NULL,'8re7z8b5XhwuFzgro40xTwvWJSxODgh7',NULL,NULL,NULL,'abc@gmail.com','$2y$10$TeMz7xC9cUa9FpD8.Nlo2ODtCSFvVb9VuPaL7Jl9USgdIjCPcY0U6',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 13:06:01','2024-03-30 07:36:01'),(41,'Raha','','',NULL,NULL,NULL,NULL,NULL,'mfw3EjaVwHy49vqTo6TaC4hcwwRTGpzj',NULL,NULL,NULL,'raha@gmail.com','$2y$10$/RxIf2jk53NZR3BPG3QoGukRe8.cs7.S.h6i6nnt3QZPKuvdu1eCq',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 13:51:01','2024-03-30 08:21:01'),(42,'Raha','','',NULL,NULL,NULL,NULL,NULL,'Kn2hlalUrsznDBWgxpOJ4DJTtOf5um5Y',NULL,NULL,NULL,'rahaa@gmail.com','$2y$10$RkRu.//SKS4JphBlvX6xS..i/YkaiwrpKkTxjJG..EXBsi2fDiQky',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,'2024-03-30 13:51:13','2024-03-30 08:21:13'),(43,'Charity','','',NULL,NULL,NULL,NULL,NULL,'y4kluonf0y3dinlILQ8LywQ62orCMEaL',NULL,NULL,NULL,'charitable@gmail.com','$2y$10$k3MCIQagRH9ASRjevkWVheEKSVN6Ch98pR3gnwxujVsd7jWlNMpr2',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-03-30 14:27:54','2024-03-30 08:57:54');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
  `permission` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_permissions`
--

LOCK TABLES `users_permissions` WRITE;
/*!40000 ALTER TABLE `users_permissions` DISABLE KEYS */;
INSERT INTO `users_permissions` VALUES (1,39,'email_buyer_message','1','2024-03-30 04:05:03','2024-03-30 04:05:03'),(2,39,'email_seller_message','1','2024-03-30 04:05:03','2024-03-30 04:05:03'),(3,39,'text_buyer_message','1','2024-03-30 04:05:03','2024-03-30 04:05:03'),(4,39,'text_seller_message','1','2024-03-30 04:05:03','2024-03-30 04:05:03'),(5,40,'email_buyer_message','1','2024-03-30 07:36:02','2024-03-30 07:36:02'),(6,40,'email_seller_message','1','2024-03-30 07:36:02','2024-03-30 07:36:02'),(7,40,'text_buyer_message','1','2024-03-30 07:36:02','2024-03-30 07:36:02'),(8,40,'text_seller_message','1','2024-03-30 07:36:02','2024-03-30 07:36:02'),(9,41,'email_buyer_message','1','2024-03-30 08:21:01','2024-03-30 08:21:01'),(10,41,'email_seller_message','1','2024-03-30 08:21:01','2024-03-30 08:21:01'),(11,41,'text_buyer_message','1','2024-03-30 08:21:01','2024-03-30 08:21:01'),(12,41,'text_seller_message','1','2024-03-30 08:21:01','2024-03-30 08:21:01'),(13,42,'email_buyer_message','1','2024-03-30 08:21:13','2024-03-30 08:21:13'),(14,42,'email_seller_message','1','2024-03-30 08:21:13','2024-03-30 08:21:13'),(15,42,'text_buyer_message','1','2024-03-30 08:21:13','2024-03-30 08:21:13'),(16,42,'text_seller_message','1','2024-03-30 08:21:13','2024-03-30 08:21:13'),(17,43,'email_buyer_message','1','2024-03-30 08:57:54','2024-03-30 08:57:54'),(18,43,'email_seller_message','1','2024-03-30 08:57:54','2024-03-30 08:57:54'),(19,43,'text_buyer_message','1','2024-03-30 08:57:54','2024-03-30 08:57:54'),(20,43,'text_seller_message','1','2024-03-30 08:57:54','2024-03-30 08:57:54');
/*!40000 ALTER TABLE `users_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-30 20:37:04
