-- Adminer 4.8.1 MySQL 8.0.35 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `activities`;
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


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `activity_log`;
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
  CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `activity_log` (`id`, `admin_id`, `log_name`, `batch_uuid`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `created_at`, `updated_at`) VALUES
(206,	7,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'93',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 93, \"tax\": \"25491.35\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": null, \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-09 16:37:06\", \"discount\": \"254913.50\", \"latitude\": null, \"modified\": \"2024-02-09 16:37:06\", \"staff_id\": null, \"subtotal\": \"509827.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": null, \"status_by\": null, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-10-19\", \"booking_time\": \"03:55:00\", \"payment_type\": \"Credit/Debit Cards\", \"total_amount\": \"280404.85\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-09 11:07:06',	'2024-02-09 11:07:06'),
(207,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'93',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 93, \"tax\": \"25491.35\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-09 16:37:06\", \"discount\": \"254913.50\", \"latitude\": null, \"modified\": \"2024-02-09 16:37:06\", \"staff_id\": null, \"subtotal\": \"509827.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": \"2024-02-09 16:37:06\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-10-19\", \"booking_time\": \"03:55:00\", \"payment_type\": \"Credit/Debit Cards\", \"total_amount\": \"280404.85\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 93, \"tax\": \"25491.35\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-09 16:37:06\", \"discount\": \"254913.50\", \"latitude\": null, \"modified\": \"2024-02-09 16:37:06\", \"staff_id\": null, \"subtotal\": \"509827.00\", \"longitude\": null, \"prefix_id\": \"2094\", \"status_at\": \"2024-02-09 16:37:06\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-10-19\", \"booking_time\": \"03:55:00\", \"payment_type\": \"Credit/Debit Cards\", \"total_amount\": \"280404.85\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-09 11:07:06',	'2024-02-09 11:07:06'),
(208,	7,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": null, \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-20 16:29:04\", \"staff_id\": null, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": null, \"status_by\": null, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-12-01\", \"booking_time\": \"00:59:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-20 10:59:04',	'2024-02-20 10:59:04'),
(209,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-20 16:29:04\", \"staff_id\": null, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": \"2024-02-20 16:29:04\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-12-01\", \"booking_time\": \"00:59:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-20 16:29:04\", \"staff_id\": null, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-20 16:29:04\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-12-01\", \"booking_time\": \"00:59:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-20 10:59:05',	'2024-02-20 10:59:05'),
(210,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-20 16:29:04\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-25 23:58:51\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-25 18:28:51',	'2024-02-25 18:28:51'),
(211,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.15\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-25 23:58:51\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"441.65\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-25 23:59:54\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-25 18:29:54',	'2024-02-25 18:29:54'),
(212,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-25 23:59:54\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:53\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:53',	'2024-02-26 00:02:53'),
(213,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:53\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:55\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:55',	'2024-02-26 00:02:55'),
(214,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:55\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:56\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:56',	'2024-02-26 00:02:56'),
(215,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:56\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:57',	'2024-02-26 00:02:57'),
(216,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:57',	'2024-02-26 00:02:57'),
(217,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:57',	'2024-02-26 00:02:57'),
(218,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:02:57',	'2024-02-26 00:02:57'),
(219,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:32:57\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:33:11\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:03:11',	'2024-02-26 00:03:11'),
(220,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:33:11\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:33:49\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:03:49',	'2024-02-26 00:03:49'),
(221,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:33:49\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:34:34\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:04:34',	'2024-02-26 00:04:34'),
(222,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"40.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"400.00\", \"latitude\": null, \"modified\": \"2024-02-26 05:34:34\", \"staff_id\": 2, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"440.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"80.30\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-26 05:49:17\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"481.80\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-26 00:19:17',	'2024-02-26 00:19:17'),
(223,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"80.30\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-26 05:49:17\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"481.80\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": 6, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"80.30\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-27 23:06:13\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"481.80\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-27 17:36:13',	'2024-02-27 17:36:13'),
(224,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"80.30\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"401.50\", \"latitude\": null, \"modified\": \"2024-02-27 23:06:13\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"481.80\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"160.60\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"on_the_way\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-02-27 23:10:05\", \"staff_id\": 2, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-22 16:27:51\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2026-09-04\", \"booking_time\": \"22:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"963.60\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-02-27 17:40:05',	'2024-02-27 17:40:05'),
(225,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"160.60\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-02-27 23:10:05\", \"staff_id\": 1, \"subtotal\": \"803.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"963.60\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:02:15\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:32:15',	'2024-03-02 14:32:15'),
(226,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:02:15\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:03:46\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:33:46',	'2024-03-02 14:33:46'),
(227,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:03:46\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:08\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:08',	'2024-03-02 14:34:08'),
(228,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:08\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:10\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:10',	'2024-03-02 14:34:10'),
(229,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:10\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:11\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:11',	'2024-03-02 14:34:11'),
(230,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:11\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:11\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:11',	'2024-03-02 14:34:11'),
(231,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:11\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:12',	'2024-03-02 14:34:12'),
(232,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:12',	'2024-03-02 14:34:12'),
(233,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:12',	'2024-03-02 14:34:12'),
(234,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:12\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:19\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:20',	'2024-03-02 14:34:20'),
(235,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:19\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:20',	'2024-03-02 14:34:20'),
(236,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:20',	'2024-03-02 14:34:20'),
(237,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:34:20',	'2024-03-02 14:34:20'),
(238,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:04:20\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:05:25\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-02-28 06:06:14\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-02 14:35:25',	'2024-03-02 14:35:25'),
(239,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"in_progress\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-02 20:05:25\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:50:38\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-06 03:20:39',	'2024-03-06 03:20:39'),
(240,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:50:38\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"cancel\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:50:52\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-06 03:20:52',	'2024-03-06 03:20:52'),
(241,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"cancel\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:50:52\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:51:01\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-06 03:21:01',	'2024-03-06 03:21:01'),
(242,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"completed\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 08:51:01\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"cancel\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 09:06:43\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-06 03:36:43',	'2024-03-06 03:36:43'),
(243,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'94',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"cancel\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 09:06:43\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 94, \"tax\": \"215.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-02-20 16:29:04\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-06 09:06:49\", \"staff_id\": 1, \"subtotal\": \"1075.00\", \"longitude\": null, \"prefix_id\": \"2095\", \"status_at\": \"2024-03-04 23:02:12\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2023-06-08\", \"booking_time\": \"02:00:00\", \"payment_type\": \"COD\", \"total_amount\": \"1290.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-06 03:36:49',	'2024-03-06 03:36:49'),
(244,	7,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'95',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 95, \"tax\": \"160.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": null, \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-03-21 20:46:33\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-21 20:46:33\", \"staff_id\": null, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": null, \"status_by\": null, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-03-09\", \"booking_time\": \"20:49:00\", \"payment_type\": null, \"total_amount\": \"960.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-21 15:16:33',	'2024-03-21 15:16:33'),
(245,	7,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'95',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 95, \"tax\": \"160.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-03-21 20:46:33\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-21 20:46:33\", \"staff_id\": null, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": null, \"status_at\": \"2024-03-21 20:46:33\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-03-09\", \"booking_time\": \"20:49:00\", \"payment_type\": null, \"total_amount\": \"960.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}, \"attributes\": {\"id\": 95, \"tax\": \"160.00\", \"area\": \"Kitchlu Nagar\", \"city\": \"Ludhiana\", \"state\": \"Punjab\", \"status\": \"pending\", \"address\": \"9-F KItclu Nagar\", \"created\": \"2024-03-21 20:46:33\", \"discount\": \"0.00\", \"latitude\": null, \"modified\": \"2024-03-21 20:46:33\", \"staff_id\": null, \"subtotal\": \"800.00\", \"longitude\": null, \"prefix_id\": \"2096\", \"status_at\": \"2024-03-21 20:46:33\", \"status_by\": 7, \"address_id\": 29, \"created_by\": 7, \"deleted_at\": null, \"customer_id\": 2, \"booking_date\": \"2024-03-09\", \"booking_time\": \"20:49:00\", \"payment_type\": null, \"total_amount\": \"960.00\", \"customer_name\": \"Kiran Kumari\", \"coupon_code_id\": null, \"manual_address\": 0, \"created_by_admin\": true}}',	'2024-03-21 15:16:33',	'2024-03-21 15:16:33'),
(246,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'98',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 98, \"tax\": null, \"area\": null, \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\\nId sapiente eos modi\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:27:38\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:27:38\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}}',	'2024-04-19 08:57:39',	'2024-04-19 08:57:39'),
(247,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'98',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 98, \"tax\": null, \"area\": null, \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\\nId sapiente eos modi\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:27:38\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}, \"attributes\": {\"id\": 98, \"tax\": null, \"area\": null, \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\\nId sapiente eos modi\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:27:38\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:27:38\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2099\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}}',	'2024-04-19 08:57:39',	'2024-04-19 08:57:39'),
(248,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'99',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 99, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:28:57\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:28:57\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}}',	'2024-04-19 08:58:58',	'2024-04-19 08:58:58'),
(249,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'99',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 99, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:28:57\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}, \"attributes\": {\"id\": 99, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:28:57\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:28:57\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2100\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1}}',	'2024-04-19 08:58:58',	'2024-04-19 08:58:58'),
(250,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'100',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 100, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:40:46\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:40:46\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:10:46',	'2024-04-19 09:10:46'),
(251,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'100',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 100, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:40:46\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 100, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:40:46\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:40:46\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2101\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:10:46',	'2024-04-19 09:10:46'),
(252,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'101',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 101, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:32\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:48:32\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:18:32',	'2024-04-19 09:18:32'),
(253,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'101',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 101, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:32\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 101, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:32\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:48:32\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2102\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:18:32',	'2024-04-19 09:18:32'),
(254,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'101',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 101, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:32\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": 2102, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 101, \"tax\": \"1.60\", \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:32\", \"discount\": \"4.00\", \"latitude\": null, \"modified\": \"2024-04-19 14:48:32\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": \"20.00\", \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2102\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": \"17.60\", \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": \"10.00\"}}',	'2024-04-19 09:18:32',	'2024-04-19 09:18:32'),
(255,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'102',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 102, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:51\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:48:51\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:18:51',	'2024-04-19 09:18:51'),
(256,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'102',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 102, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:51\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 102, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:51\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 14:48:51\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2103\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:18:51',	'2024-04-19 09:18:51'),
(257,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'102',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 102, \"tax\": null, \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:51\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Amet vero dicta eni\", \"subtotal\": null, \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": 2103, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 102, \"tax\": \"185.44\", \"area\": \"\\nId sapiente eos modi\", \"city\": \"Est nostrum eos recu\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Cupiditate quis quo\", \"company\": \"Facere laboris labor\", \"created\": \"2024-04-19 14:48:51\", \"discount\": \"463.60\", \"latitude\": null, \"modified\": \"2024-04-19 14:48:51\", \"postcode\": \"Amet vero dicta eni\", \"subtotal\": \"2318.00\", \"last_name\": \"Necessitatibus numqu\", \"longitude\": null, \"prefix_id\": \"2103\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Est non officiis vol\", \"customer_id\": null, \"total_amount\": \"2039.84\", \"customer_email\": \"Eos possimus dolor\", \"customer_phone\": \"Eos possimus dolor\", \"manual_address\": 1, \"tax_percentage\": \"10.00\"}}',	'2024-04-19 09:18:51',	'2024-04-19 09:18:51'),
(258,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'103',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 103, \"tax\": null, \"area\": \"Et dolorum officiis\", \"city\": \"Nulla qui do consequ\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Aliquid commodi in s\", \"company\": \"Magni obcaecati volu\", \"created\": \"2024-04-19 15:06:06\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 15:06:06\", \"postcode\": \"Aliqua Ut tempora r\", \"subtotal\": null, \"last_name\": \"Voluptas aut enim fu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Sint quos non nisi\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Id non voluptates in\", \"customer_phone\": \"Id non voluptates in\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:36:06',	'2024-04-19 09:36:06'),
(259,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'103',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 103, \"tax\": null, \"area\": \"Et dolorum officiis\", \"city\": \"Nulla qui do consequ\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Aliquid commodi in s\", \"company\": \"Magni obcaecati volu\", \"created\": \"2024-04-19 15:06:06\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Aliqua Ut tempora r\", \"subtotal\": null, \"last_name\": \"Voluptas aut enim fu\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Sint quos non nisi\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Id non voluptates in\", \"customer_phone\": \"Id non voluptates in\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 103, \"tax\": null, \"area\": \"Et dolorum officiis\", \"city\": \"Nulla qui do consequ\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Aliquid commodi in s\", \"company\": \"Magni obcaecati volu\", \"created\": \"2024-04-19 15:06:06\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-19 15:06:06\", \"postcode\": \"Aliqua Ut tempora r\", \"subtotal\": null, \"last_name\": \"Voluptas aut enim fu\", \"longitude\": null, \"prefix_id\": \"2104\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Sint quos non nisi\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Id non voluptates in\", \"customer_phone\": \"Id non voluptates in\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-19 09:36:06',	'2024-04-19 09:36:06'),
(260,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'103',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 103, \"tax\": null, \"area\": \"Et dolorum officiis\", \"city\": \"Nulla qui do consequ\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Aliquid commodi in s\", \"company\": \"Magni obcaecati volu\", \"created\": \"2024-04-19 15:06:06\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Aliqua Ut tempora r\", \"subtotal\": null, \"last_name\": \"Voluptas aut enim fu\", \"longitude\": null, \"prefix_id\": 2104, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Sint quos non nisi\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"Id non voluptates in\", \"customer_phone\": \"Id non voluptates in\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 103, \"tax\": \"185.44\", \"area\": \"Et dolorum officiis\", \"city\": \"Nulla qui do consequ\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Aliquid commodi in s\", \"company\": \"Magni obcaecati volu\", \"created\": \"2024-04-19 15:06:06\", \"discount\": \"463.60\", \"latitude\": null, \"modified\": \"2024-04-19 15:06:06\", \"postcode\": \"Aliqua Ut tempora r\", \"subtotal\": \"2318.00\", \"last_name\": \"Voluptas aut enim fu\", \"longitude\": null, \"prefix_id\": \"2104\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Sint quos non nisi\", \"customer_id\": null, \"total_amount\": \"2039.84\", \"customer_email\": \"Id non voluptates in\", \"customer_phone\": \"Id non voluptates in\", \"manual_address\": 1, \"tax_percentage\": \"10.00\"}}',	'2024-04-19 09:36:06',	'2024-04-19 09:36:06'),
(261,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'104',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 104, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:40:11\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-20 11:40:11\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-20 06:10:11',	'2024-04-20 06:10:11'),
(262,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'104',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 104, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:40:11\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 104, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:40:11\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-20 11:40:11\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": \"2105\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-20 06:10:11',	'2024-04-20 06:10:11'),
(263,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'104',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 104, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:40:11\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": 2105, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": null, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 104, \"tax\": \"87.36\", \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:40:11\", \"discount\": \"218.40\", \"latitude\": null, \"modified\": \"2024-04-20 11:40:11\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": \"1092.00\", \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": \"2105\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": null, \"total_amount\": \"960.96\", \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": \"10.00\"}}',	'2024-04-20 06:10:12',	'2024-04-20 06:10:12'),
(264,	NULL,	'orders',	NULL,	'created',	'App\\Models\\Admin\\Orders',	'created',	'105',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"attributes\": {\"id\": 105, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:43:42\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-20 11:43:42\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": 16, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-20 06:13:42',	'2024-04-20 06:13:42'),
(265,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'105',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 105, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:43:42\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": null, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": 16, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 105, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:43:42\", \"discount\": null, \"latitude\": null, \"modified\": \"2024-04-20 11:43:42\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": \"2106\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": 16, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}}',	'2024-04-20 06:13:42',	'2024-04-20 06:13:42'),
(266,	NULL,	'orders',	NULL,	'updated',	'App\\Models\\Admin\\Orders',	'updated',	'105',	NULL,	NULL,	'{\"ip\": \"127.0.0.1\", \"old\": {\"id\": 105, \"tax\": null, \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\":4,\\\"coupon_code\\\":\\\"8540291\\\",\\\"title\\\":\\\"20% Off\\\",\\\"description\\\":\\\"<p>Inventore quis illum aliquam.<\\\\/p>\\\",\\\"amount\\\":20,\\\"is_percentage\\\":1,\\\"min_amount\\\":null}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:43:42\", \"discount\": null, \"latitude\": null, \"modified\": null, \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": null, \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": 2106, \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": 16, \"total_amount\": null, \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": null}, \"attributes\": {\"id\": 105, \"tax\": \"87.36\", \"area\": \"Ut iste adipisicing\", \"city\": \"Et deleniti quas rer\", \"state\": null, \"coupon\": \"{\\\"id\\\": 4, \\\"title\\\": \\\"20% Off\\\", \\\"amount\\\": 20, \\\"min_amount\\\": null, \\\"coupon_code\\\": \\\"8540291\\\", \\\"description\\\": \\\"<p>Inventore quis illum aliquam.</p>\\\", \\\"is_percentage\\\": 1}\", \"status\": \"pending\", \"address\": \"Atque autem placeat\", \"company\": \"In labore asperiores\", \"created\": \"2024-04-20 11:43:42\", \"discount\": \"218.40\", \"latitude\": null, \"modified\": \"2024-04-20 11:43:42\", \"postcode\": \"Ut eaque anim dolore\", \"subtotal\": \"1092.00\", \"last_name\": \"Ad atque sed adipisi\", \"longitude\": null, \"prefix_id\": \"2106\", \"address_id\": null, \"created_by\": null, \"deleted_at\": null, \"first_name\": \"Eligendi veritatis e\", \"customer_id\": 16, \"total_amount\": \"960.96\", \"customer_email\": \"ritish.vermani@hotmail.com\", \"customer_phone\": \"8877336655\", \"manual_address\": 1, \"tax_percentage\": \"10.00\"}}',	'2024-04-20 06:13:42',	'2024-04-20 06:13:42');

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `admin_permissions`;
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


DROP TABLE IF EXISTS `admins`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `email`, `password`, `phonenumber`, `last_login`, `is_admin`, `otp`, `otp_sent_on`, `token`, `image`, `created_by`, `status`, `deleted_at`, `created`, `address`, `modified`) VALUES
(7,	'Super',	'Admin',	'admin@laravel.com',	'$2y$10$RIGjhyvuyhJf.Kkjrcx/teILNFrgC.6v5Dw36LDFCuWZHOhGXCnCq',	NULL,	'2024-04-20 11:44:17',	1,	NULL,	NULL,	NULL,	'/uploads/admins/17070200025677-hm-logo.png',	NULL,	1,	NULL,	'0000-00-00 00:00:00',	NULL,	'2024-04-20 06:14:17');

DROP TABLE IF EXISTS `blog_categories`;
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


DROP TABLE IF EXISTS `blog_category_relation`;
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


DROP TABLE IF EXISTS `blogs`;
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


DROP TABLE IF EXISTS `brand_product`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `brand_product` (`id`, `brand_id`, `product_id`, `created`, `modified`) VALUES
(9,	5,	79,	'2024-01-07 06:34:55',	'2024-01-07 06:34:55'),
(10,	6,	79,	'2024-01-07 06:34:55',	'2024-01-07 06:34:55'),
(12,	5,	80,	'2024-01-07 09:49:43',	'2024-01-07 09:49:43'),
(13,	5,	81,	'2024-01-07 13:00:19',	'2024-01-07 13:00:19'),
(14,	5,	82,	'2024-01-07 13:00:54',	'2024-01-07 13:00:54'),
(15,	5,	83,	'2024-01-07 13:01:29',	'2024-01-07 13:01:29'),
(16,	5,	84,	'2024-01-23 10:12:25',	'2024-01-23 10:12:25'),
(17,	6,	84,	'2024-01-23 10:12:25',	'2024-01-23 10:12:25'),
(19,	5,	85,	'2024-01-30 10:43:26',	'2024-01-30 10:43:26'),
(20,	13,	87,	'2024-02-20 10:28:17',	'2024-02-20 10:28:17'),
(21,	4,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(22,	5,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(23,	13,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(24,	8,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(25,	7,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(26,	11,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(27,	9,	88,	'2024-02-20 10:38:49',	'2024-02-20 10:38:49'),
(28,	9,	89,	'2024-02-20 10:46:21',	'2024-02-20 10:46:21'),
(29,	7,	90,	'2024-03-14 00:53:00',	'2024-03-14 00:53:00'),
(30,	11,	90,	'2024-03-14 00:53:00',	'2024-03-14 00:53:00'),
(33,	10,	91,	'2024-03-16 03:51:55',	'2024-03-16 03:51:55'),
(34,	9,	91,	'2024-03-16 03:51:55',	'2024-03-16 03:51:55'),
(37,	13,	93,	'2024-03-23 04:14:27',	'2024-03-23 04:14:27'),
(38,	8,	93,	'2024-03-23 04:14:27',	'2024-03-23 04:14:27'),
(43,	7,	197,	'2024-03-30 06:45:58',	'2024-03-30 06:45:58'),
(44,	11,	197,	'2024-03-30 06:45:58',	'2024-03-30 06:45:58'),
(69,	11,	221,	'2024-04-05 17:40:44',	'2024-04-05 17:40:44'),
(70,	10,	221,	'2024-04-05 17:40:44',	'2024-04-05 17:40:44'),
(71,	9,	221,	'2024-04-05 17:40:44',	'2024-04-05 17:40:44'),
(72,	12,	221,	'2024-04-05 17:40:44',	'2024-04-05 17:40:44'),
(73,	10,	223,	'2024-04-09 17:20:33',	'2024-04-09 17:20:33'),
(74,	12,	223,	'2024-04-09 17:20:33',	'2024-04-09 17:20:33'),
(75,	8,	225,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10'),
(76,	7,	225,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10'),
(77,	10,	225,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10'),
(78,	9,	225,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10');

DROP TABLE IF EXISTS `brands`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brands` (`id`, `title`, `slug`, `description`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(4,	'ZARA',	NULL,	'<p>Zara is a renowned global fashion brand that has become synonymous with contemporary style and accessibility. Established with a commitment to delivering the latest fashion trends at affordable prices, Zara has become a favorite destination for fashion enthusiasts worldwide.</p>\r\n\r\n<p>Known for its agile approach to fashion, Zara quickly adapts to emerging styles and customer preferences. The brand offers a diverse range of clothing and accessories, blending quality craftsmanship with on-trend designs. Zara&#39;s collections cater to a broad audience, providing a seamless blend of elegance and modernity.</p>\r\n\r\n<p>With a keen eye on innovation and a dedication to sustainability, Zara continues to redefine the fashion landscape. From chic casual wear to sophisticated formal attire, Zara remains at the forefront of the fashion industry, making style accessible to all.&quot;</p>\r\n\r\n<p>Feel free to customize and modify this description according to your specific requirements or to better align with the unique aspects of Zara that you want to highlight.</p>',	'/uploads/brands/17027410337173-zara.png',	1,	7,	'2023-12-16 16:38:13',	'2023-12-16 15:43:28',	'2023-12-16 10:13:28'),
(5,	'ZARA',	NULL,	'<p>Zara is a renowned global fashion brand that has become synonymous with contemporary style and accessibility. Established with a commitment to delivering the latest fashion trends at affordable prices, Zara has become a favorite destination for fashion enthusiasts worldwide.</p>\r\n\r\n<p>Known for its agile approach to fashion, Zara quickly adapts to emerging styles and customer preferences. The brand offers a diverse range of clothing and accessories, blending quality craftsmanship with on-trend designs. Zara&#39;s collections cater to a broad audience, providing a seamless blend of elegance and modernity.</p>\r\n\r\n<p>With a keen eye on innovation and a dedication to sustainability, Zara continues to redefine the fashion landscape. From chic casual wear to sophisticated formal attire, Zara remains at the forefront of the fashion industry, making style accessible to all.</p>',	'/uploads/brands/17027449091372-zara.png',	1,	7,	NULL,	'2023-12-16 16:43:58',	'2023-12-16 11:13:58'),
(6,	'H&M',	NULL,	'<p>&nbsp;</p>\r\n\r\n<p>H&amp;M, or Hennes &amp; Mauritz, is a global fashion retailer known for its trendy and affordable clothing and accessories. Founded in 1947 in Sweden, H&amp;M has grown into one of the world&#39;s largest fashion retailers, with a presence in numerous countries.</p>',	'/uploads/brands/17027778445025-hm-logo.png',	0,	7,	NULL,	'2023-12-17 01:50:47',	'2023-12-16 20:20:47'),
(7,	'Internal Infrastructure Liaison',	NULL,	'<p>njjjjj</p>',	NULL,	1,	7,	'2023-12-17 04:46:21',	'2023-12-17 04:46:00',	'2023-12-16 23:16:00'),
(8,	'Regional Research Director',	NULL,	NULL,	NULL,	1,	7,	'2023-12-17 05:37:59',	'2023-12-17 05:09:53',	'2023-12-16 23:39:53'),
(9,	'Central Tactics Strategist',	NULL,	NULL,	NULL,	1,	7,	'2023-12-17 05:46:52',	'2023-12-17 05:44:46',	'2023-12-17 00:14:46'),
(10,	'Corporate Identity Agent',	NULL,	NULL,	NULL,	1,	7,	'2023-12-17 05:47:56',	'2023-12-17 05:45:23',	'2023-12-17 00:15:23'),
(11,	'Customer Metrics Strategist',	'customer-metrics-strategist-grd36z',	NULL,	NULL,	1,	7,	'2023-12-17 05:47:00',	'2023-12-17 05:46:33',	'2023-12-17 00:16:33'),
(12,	'AA',	'aa-5rkJ6x',	NULL,	'/uploads/brands/17040361703113-screenshot-from-2023-12-17-10-46-46.png',	1,	7,	'2024-01-06 09:55:39',	'2023-12-31 15:22:55',	'2023-12-31 09:52:55'),
(13,	'sdfdsasd',	'sdfdsasd-kV3vrg',	'<p>dfasdfdsf</p>',	'/uploads/brands/17061484914119-hm-logo.png',	1,	7,	NULL,	'2024-01-25 02:08:13',	'2024-01-24 20:38:13');

DROP TABLE IF EXISTS `cities`;
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


DROP TABLE IF EXISTS `colours`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `colours` (`id`, `slug`, `title`, `color_code`, `image`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(1,	'',	'Red',	'#11cdef',	NULL,	7,	'0000-00-00 00:00:00',	'2024-03-16 19:54:13',	'2024-04-10 17:04:01'),
(2,	'',	'BLue',	'#FF0001',	'/uploads/pages/17127686011178-thumbnail1.png',	7,	'0000-00-00 00:00:00',	'2024-03-17 20:08:10',	'2024-04-10 17:03:25');

DROP TABLE IF EXISTS `countries`;
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

INSERT INTO `countries` (`id`, `iso2`, `short_name`, `long_name`, `iso3`, `numcode`, `un_member`, `calling_code`, `cctld`, `status`) VALUES
(1,	NULL,	'United Kingdom',	'United Kingdom',	NULL,	NULL,	NULL,	NULL,	NULL,	1);

DROP TABLE IF EXISTS `coupons`;
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
  `is_percentage` tinyint NOT NULL,
  `amount` bigint NOT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_code` (`coupon_code`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `coupons_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `coupons` (`id`, `coupon_code`, `description`, `title`, `slug`, `max_use`, `used`, `end_date`, `status`, `is_percentage`, `amount`, `created_by`, `created`, `modified`, `deleted_at`) VALUES
(4,	'8540291',	'<p>Inventore quis illum aliquam.</p>',	'20% Off',	'20-off-g62n65',	77,	0,	'2024-08-07',	1,	1,	20,	7,	'2023-12-30 12:45:47',	'2023-12-30 08:06:08',	'2024-02-03 22:35:42'),
(5,	'23123',	NULL,	'50% off',	'50-off-LVgJr8',	19,	0,	'2024-02-06',	0,	1,	50,	7,	'2024-02-04 03:43:05',	'2024-02-03 22:13:05',	NULL),
(6,	'74047-9911',	NULL,	'50% off',	'50-off-PreJVN',	572,	0,	'2024-02-26',	0,	1,	50,	7,	'2024-02-04 04:05:36',	'2024-02-03 22:35:36',	NULL);

DROP TABLE IF EXISTS `email_logs`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `email_logs` (`id`, `slug`, `subject`, `description`, `from`, `to`, `cc`, `bcc`, `sent`, `open`, `created`, `modified`) VALUES
(19,	'staff-assigned',	'Staff assigned to your order - #62.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:49',	'2024-01-24 12:18:49'),
(20,	'order-assigned',	'Order assigned to you  - #62.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:49',	'2024-01-24 12:18:49'),
(21,	'order-unassigned',	'Order Unassigned - #62',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #62 has been unassigned from you. Here are the details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>Customer Name:</strong> Kiran Kumari<br />\r\n<strong>Customer Email: </strong>chaudharykiran125@gmail.com<br />\r\n<strong>Customer Contact:</strong> 08360445579<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(22,	'staff-reassigned',	'Staff Reassigned - Order #62',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(23,	'staff-reassigned',	'Staff Reassigned - Order #62',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(24,	'staff-assigned',	'Staff assigned to your order - #92.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-04 07:46:24',	'2024-02-04 02:16:24'),
(25,	'order-assigned',	'Order assigned to you  - #92.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-04 07:46:24',	'2024-02-04 02:16:24'),
(26,	'staff-assigned',	'Staff assigned to your order - #93.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 93</li>\r\n	<li><strong>Booking Date:</strong> 19-10-2023</li>\r\n	<li><strong>Order Total:</strong>  280404.85</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:24:53',	'2024-02-20 10:54:53'),
(27,	'order-assigned',	'Order assigned to you  - #93.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 93</li>\r\n	<li><strong>Booking Date:</strong> 19-10-2023</li>\r\n	<li><strong>Order Total:</strong>  280404.85</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:24:53',	'2024-02-20 10:54:53'),
(28,	'staff-assigned',	'Staff assigned to your order - #94.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 94</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Order Total:</strong>  441.65</li>\r\n	<li><strong>Payment Type: </strong>COD</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:38:11',	'2024-02-20 11:08:11'),
(29,	'order-assigned',	'Order assigned to you  - #94.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 94</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Order Total:</strong>  441.65</li>\r\n	<li><strong>Payment Type: </strong>COD</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:38:11',	'2024-02-20 11:08:11'),
(30,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:45:53',	'2024-02-20 11:15:53'),
(31,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:45:53',	'2024-02-20 11:15:53'),
(32,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:45:53',	'2024-02-20 11:15:53'),
(33,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Myles Zulauf,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:46:01',	'2024-02-20 11:16:01'),
(34,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:46:01',	'2024-02-20 11:16:01'),
(35,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-20 16:46:01',	'2024-02-20 11:16:01'),
(36,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:34',	'2024-02-21 09:16:34'),
(37,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:35',	'2024-02-21 09:16:35'),
(38,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:35',	'2024-02-21 09:16:35'),
(39,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Myles Zulauf,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:41',	'2024-02-21 09:16:41'),
(40,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:41',	'2024-02-21 09:16:41'),
(41,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 14:46:41',	'2024-02-21 09:16:41'),
(42,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 15:03:23',	'2024-02-21 09:33:23'),
(43,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 15:03:23',	'2024-02-21 09:33:23'),
(44,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-21 15:03:23',	'2024-02-21 09:33:23'),
(45,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Myles Zulauf,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-22 16:28:03',	'2024-02-22 10:58:03'),
(46,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-22 16:28:03',	'2024-02-22 10:58:03'),
(47,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 01-12-2024</li>\r\n	<li><strong>Total Amount: </strong> 441.65</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-22 16:28:03',	'2024-02-22 10:58:03'),
(48,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:06',	'2024-02-27 17:53:06'),
(49,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:06',	'2024-02-27 17:53:06'),
(50,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:06',	'2024-02-27 17:53:06'),
(51,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Myles Zulauf,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:10',	'2024-02-27 17:53:10'),
(52,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:10',	'2024-02-27 17:53:10'),
(53,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Myles Zulauf</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 1971231231</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 05-08-2025</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-27 23:23:10',	'2024-02-27 17:53:10'),
(54,	'order-unassigned',	'Order Unassigned - #94',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #94 has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>Customer Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Customer Email: </strong>chaudharykiran125@gmail.com</li>\r\n	<li><strong>Customer Contact:</strong> 08360445579</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 07-06-2023</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-28 06:06:26',	'2024-02-28 00:36:26'),
(55,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 07-06-2023</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-28 06:06:26',	'2024-02-28 00:36:26'),
(56,	'staff-reassigned',	'Staff Reassigned - Order #94',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #94 has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>94</li>\r\n	<li><strong>New Staff Name:</strong> Graciela Aufderhar</li>\r\n	<li><strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com</li>\r\n	<li><strong>New Staff Contact:</strong> 5423333333</li>\r\n	<li><strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</li>\r\n	<li><strong>Booking Date:</strong> 07-06-2023</li>\r\n	<li><strong>Total Amount: </strong> 963.60</li>\r\n	<li><strong>Payment Type:</strong> COD</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-28 06:06:26',	'2024-02-28 00:36:26'),
(57,	'registration',	'Registration Successful.',	'<p>Dear {first_name}&nbsp;{last_name}<br />\r\n<br />\r\nYou account has been registered on Admin. Please use the below credentails for login.<br />\r\n<br />\r\n<a href=\"http://127.0.0.1:8000/admin\" target=\"_blank\">http://127.0.0.1:8000/admin</a><br />\r\nEmail: ritish.vermani@hotmail.com<br />\r\nPassword: {password}<br />\r\n<br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 15:37:05',	'2024-04-19 10:07:05'),
(58,	'registration',	'Registration Successful.',	'<p>Dear {first_name}&nbsp;{last_name}<br />\r\n<br />\r\nYou account has been registered on Admin. Please use the below credentails for login.<br />\r\n<br />\r\n<a href=\"http://127.0.0.1:8000/admin\" target=\"_blank\">http://127.0.0.1:8000/admin</a><br />\r\nEmail: ritish.vermani@hotmail.com<br />\r\nPassword: {password}<br />\r\n<br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 15:42:31',	'2024-04-19 10:12:31'),
(59,	'registration',	'Registration Successful.',	'<p>Dear Ritish <br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n<p>{link}</p>\r\n\r\n<p><br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 15:45:30',	'2024-04-19 10:15:30'),
(60,	'registration',	'Registration Successful.',	'<p>Dear Ritish <br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n<p><a href=\"http://127.0.0.1:8000?token=vr7gm5QQ0olTsO727xiEi7ch2Wh2DTnJ\" target=\"_blank\">http://127.0.0.1:8000?token=vr7gm5QQ0olTsO727xiEi7ch2Wh2DTnJ</a></p>\r\n\r\n<p><br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 15:46:57',	'2024-04-19 10:16:57'),
(61,	'registration',	'Registration Successful.',	'<p>Dear Ritish <br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n\r\n<p><br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 15:49:38',	'2024-04-19 10:19:38'),
(62,	'registration',	'Registration Successful.',	'<p>Dear Ritish <br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n\r\n<p><br />\r\nThanks</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 16:05:51',	'2024-04-19 10:35:51'),
(63,	'user-forgot-password',	'Forgot Password',	'<p>Dear Ritish&nbsp;,<br />\r\n<br />\r\nPlease click on below link to reset your account password.<br />\r\n<br />\r\n847863\r\n<br />\r\n<a href=\"http://127.0.0.1:8000/auth/otp-verify/qh8fPkg5G9jlM2PHl6MH9yHYZPSvCZ09\" target=\"_blank\">http://127.0.0.1:8000/auth/otp-verify/qh8fPkg5G9jlM2PHl6MH9yHYZPSvCZ09</a><br />\r\n<br />\r\nThank you!</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 16:18:14',	'2024-04-19 10:48:14'),
(64,	'user-forgot-password',	'Forgot Password',	'<p>Dear Ritish&nbsp;,<br />\r\n<br />\r\nPlease click on below link to reset your account password.<br />\r\n<br />\r\n216512\r\n<br />\r\n<a href=\"http://127.0.0.1:8000/auth/otp-verify/eUYRmm5QxBHygAHB1IKesecYEkyJGLrL\" target=\"_blank\">http://127.0.0.1:8000/auth/otp-verify/eUYRmm5QxBHygAHB1IKesecYEkyJGLrL</a><br />\r\n<br />\r\nThank you!</p>',	'noreply@saloon.com',	'ritish.vermani@hotmail.com',	NULL,	NULL,	0,	0,	'2024-04-19 16:26:07',	'2024-04-19 10:56:07');

DROP TABLE IF EXISTS `email_templates`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `email_templates` (`id`, `title`, `slug`, `type`, `subject`, `description`, `short_codes`, `created`, `modified`) VALUES
(5,	'Registration',	'registration',	'client',	'Registration Successful.',	'<p>Dear {name}<br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n\r\n<p><br />\r\nThanks</p>',	'{name},{email}',	'2021-03-01 12:18:13',	'2024-04-19 10:14:54'),
(6,	'Forgot Password',	'user-forgot-password',	'client',	'Forgot Password',	'<p>Dear {first_name}&nbsp;{last_name},<br />\r\n<br />\r\nPlease click on below link to reset your account password. Enter your provided OTP to recover password.<br />\r\n<br />\r\n{recovery_link}<br />\r\n<br />\r\nOTP: {otp}<br />\r\n<br />\r\n<br />\r\nThank you!</p>',	'{first_name},{last_name},{email},{recovery_link},{admin_link},{company_name}',	'2021-03-01 12:18:09',	'2024-04-19 10:57:35');

DROP TABLE IF EXISTS `failed_jobs`;
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


DROP TABLE IF EXISTS `homepage`;
CREATE TABLE `homepage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `homepage` (`id`, `key`, `value`) VALUES
(1,	'_token',	'bVUQ6irLwnREpvTJd60Gq2DBZ6qqVxSmNAz4f86Z'),
(2,	'title',	'Ipsa laborum Do fa'),
(3,	'banner_1_label',	'Quibusdam ipsum del'),
(4,	'banner_1_heading',	'Possimus duis id vo\r\nUpto 10% off'),
(5,	'banner_1_button_status',	'1'),
(6,	'banner_1_button_title',	'Voluptatem Ipsum n'),
(7,	'banner_1_button_url',	'/'),
(8,	'banner_1_image',	'/uploads/home/17112626808696-banner11.jpg'),
(9,	'banner_2_label',	'Cillum fugit repell'),
(10,	'banner_2_heading',	'Est assumenda ut dis\r\nUpto 10% off'),
(11,	'banner_2_button_status',	'1'),
(12,	'banner_2_button_title',	'Molestiae architecto'),
(13,	'banner_2_button_url',	'/'),
(14,	'banner_2_image',	'/uploads/home/17112627087916-banner21.jpg'),
(15,	'banner_3_label',	'Est irure minim est'),
(16,	'banner_3_heading',	'Ipsa in nihil animi\r\nUpto 10% off'),
(17,	'banner_3_button_status',	'1'),
(18,	'banner_3_button_title',	'Maxime ad unde qui q'),
(19,	'banner_3_button_url',	'/'),
(20,	'banner_3_image',	'/uploads/home/17112627297498-banner31.jpg'),
(21,	'banner_4_label',	'Eaque dolor ipsam el'),
(22,	'banner_4_heading',	'Officiis accusantium\r\nUpto 10% off'),
(23,	'banner_4_button_status',	'1'),
(24,	'banner_4_button_title',	'Vel delectus lorem'),
(25,	'banner_4_button_url',	'/'),
(26,	'banner_4_image',	'/uploads/home/17112627533913-banner43.png'),
(27,	'meta_title',	'Omnis enim hic delec'),
(28,	'meta_description',	'Sed et recusandae E'),
(29,	'meta_keywords',	'Cumque quod sapiente'),
(30,	'deal_day_label',	'Hurry up and Get 25% Discount'),
(31,	'deal_day_heading',	'Deals Of The Day'),
(32,	'deal_day_subheading',	'Lorem ipsum dolor sit amet, consectetur adipisicing elit,\r\nsed do eiusmod tempor incididunt ut labore'),
(33,	'deal_day_button_status',	'1'),
(34,	'deal_day_button_title',	'Shop Now'),
(35,	'deal_day_button_url',	'/'),
(36,	'deal_day_image',	'/uploads/home/17112646993165-banner-bg11.jpg'),
(37,	'left_grid_label',	'Pick Your Items'),
(38,	'left_grid_heading',	'Up to 25% Off Order Now'),
(39,	'left_grid_button_status',	'1'),
(40,	'left_grid_button_title',	'Shop Now'),
(41,	'left_grid_button_url',	'/'),
(42,	'left_grid_image',	'/uploads/home/17112656235527-banner51.png'),
(43,	'right_grid_label',	'Special offer'),
(44,	'right_grid_heading',	'Up to 35% Off Order Now'),
(45,	'right_grid_button_status',	'1'),
(46,	'right_grid_button_title',	'Shop Now'),
(47,	'right_grid_button_url',	'/'),
(48,	'right_grid_image',	'/uploads/home/1711265685404-banner61.png'),
(49,	'bottom_banner_label',	'Need Winter Boots?'),
(50,	'bottom_banner_heading',	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua enim ad minim veniam, quis nostrud exercitation'),
(51,	'bottom_banner_button_status',	'1'),
(52,	'bottom_banner_button_title',	'Shop Now'),
(53,	'bottom_banner_button_url',	'/'),
(54,	'bottom_banner_image',	'/uploads/home/17112662077389-banner-bg21.png'),
(55,	'footer_icon_1_label',	'SECURE SHOPPING'),
(56,	'footer_icon_1_heading',	'Free order over £300'),
(57,	'footer_icon_1_image',	'/uploads/home/17112675948531-svgviewer-png-output-8.png'),
(58,	'footer_icon_2_label',	'ACCEPT PAYMENT'),
(59,	'footer_icon_2_heading',	'Visa, Paypal, Master'),
(60,	'footer_icon_2_image',	'/uploads/home/17112679028861-svgviewer-png-output-7.png'),
(61,	'footer_icon_3_label',	'30 DAY RETURN'),
(62,	'footer_icon_3_heading',	'30 day guarantee'),
(63,	'footer_icon_3_image',	'/uploads/home/17112679067953-svgviewer-png-output-5.png'),
(64,	'footer_icon_4_label',	'24/7 SUPPORT'),
(65,	'footer_icon_4_heading',	'Support every time'),
(66,	'footer_icon_4_image',	'/uploads/home/1711267607184-svgviewer-png-output-6.png'),
(67,	'footer_title',	'About Us'),
(68,	'footer_description',	'Lorem ipsum dolor sit amet, consectetur adipisici ti elit seddo eiusmod tempor incididunt utlabore et dolore magna aliqua enim ad minim veniam quisnostrud exercitation ullamco'),
(69,	'facebook',	'https://facebook.com/example'),
(70,	'twitter',	'https://twitter.com/example'),
(71,	'instagram',	'https://instagram.com/example'),
(72,	'youtube',	'https://youtube.com/example'),
(73,	'whatsapp',	'+12-2233443322'),
(74,	'footer_link1_title',	'About Us'),
(75,	'footer_link1',	'/about-us'),
(76,	'footer_link2_title',	'Contact Us'),
(77,	'footer_link2',	'/contact-us'),
(78,	'footer_link3_title',	'FAQs'),
(79,	'footer_link3',	'/faqs'),
(80,	'footer_link4_title',	'Privacy Policy'),
(81,	'footer_link4',	'/privacy-policy'),
(82,	'footer_link5_title',	'Delivery Information'),
(83,	'footer_link5',	'/delivery-information'),
(84,	'footer_link6_title',	'Return Policy'),
(85,	'footer_link6',	'/return-policy'),
(86,	'quick_links_title',	'Quick Links'),
(87,	'instagram_widget',	'<div class=\"footer__instagram footer__widget--inner\">\r\n                        <div class=\"footer__instagram--list d-flex\">\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF3TLBTT7\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram1.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF60sBxhN\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram2.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkF90ZB6HG\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram3.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"footer__instagram--list d-flex\">\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGAe6BQeu\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram4.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGCWcBbv9\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram5.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                            <div class=\"instagram__thumbnail\">\r\n                                <a class=\"instagram__thumbnail--img\" target=\"_blank\" href=\"https://www.instagram.com/p/CZkGFDMhoid\"><img src=\"http://127.0.0.1:8000/frontend/assets/img/other/instagram6.webp\" alt=\"instagram\"></a>\r\n                            </div>\r\n                        </div>\r\n                    </div>'),
(88,	'newsletter_text',	'Fill their seed open meat. Sea you great Saw image stl'),
(89,	'menu_header',	'[\r\n    {\r\n        \"id\": 7,\r\n        \"title\": \"T-Shirt\"\r\n    },\r\n    {\r\n        \"id\": 8,\r\n        \"title\": \"Polo T-Shirts\"\r\n    },\r\n    {\r\n        \"id\": 9,\r\n        \"title\": \"Hi Vis\"\r\n    },\r\n    {\r\n        \"id\": 10,\r\n        \"title\": \"Jackets\"\r\n    },\r\n    {\r\n        \"id\": 11,\r\n        \"title\": \"Hoodies\"\r\n    },\r\n    {\r\n        \"id\": 12,\r\n        \"title\": \"Bottoms\"\r\n    },\r\n    {\r\n        \"id\": 13,\r\n        \"title\": \"KnitWear\"\r\n    },\r\n    {\r\n        \"id\": 14,\r\n        \"title\": \"Headwear\"\r\n    }\r\n]'),
(90,	'featured_products',	'[\"221\",\"220\",\"219\",\"218\",\"217\",\"216\",\"215\"]'),
(91,	'trending_products',	'[\"220\",\"219\",\"218\",\"217\",\"216\"]'),
(92,	'new_arrivals',	'[\"220\",\"219\",\"218\",\"217\",\"216\"]'),
(93,	'best_products',	'[\"221\",\"220\",\"219\",\"218\",\"217\",\"216\",\"215\"]');

DROP TABLE IF EXISTS `messages`;
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


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(5,	'2014_10_12_000000_create_users_table',	1),
(6,	'2014_10_12_100000_create_password_resets_table',	1),
(7,	'2019_08_19_000000_create_failed_jobs_table',	1),
(8,	'2023_12_09_113020_create_brands_table',	1),
(9,	'2023_12_09_182202_create_products_table',	2),
(10,	'2023_12_25_071344_create_activity_log_table',	3),
(11,	'2023_12_26_071345_add_event_column_to_activity_log_table',	3);

DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE `newsletter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `newsletter` (`id`, `email`, `created_by`, `created`, `modified`) VALUES
(1,	'sdsdsd@sds.dsdsd',	NULL,	'2024-03-31 16:00:00',	'2024-03-31 10:30:00'),
(2,	'ritish.vermani@hotmail.com',	NULL,	'2024-03-31 16:06:00',	'2024-03-31 10:36:00');

DROP TABLE IF EXISTS `order_comments`;
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

INSERT INTO `order_comments` (`id`, `comment`, `category`, `order_id`, `admin_id`, `name`, `created_by`, `created`, `modified`) VALUES
(12,	'This is test order',	NULL,	105,	7,	'Super Admin',	7,	'2024-04-20 12:10:03',	'2024-04-20 06:40:03');

DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  `size_title` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_description` text,
  `amount` decimal(10,0) NOT NULL,
  `quantity` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `size_id` (`size_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `size_id`, `size_title`, `color`, `product_title`, `product_description`, `amount`, `quantity`, `deleted_at`, `created_at`, `updated_at`) VALUES
(200,	104,	223,	21,	'XL 2 - 1',	'Red',	'Blanditiis ut quia d',	'XL 2 - 1\nChest:1Waist: 1 Hip:1',	192,	1,	NULL,	NULL,	NULL),
(201,	104,	223,	22,	'S 1 - 1',	'Red',	'Blanditiis ut quia d',	'S 1 - 1\nChest:1Waist: 1 Hip:1',	332,	1,	NULL,	NULL,	NULL),
(202,	104,	223,	24,	'XL 2 - 1',	'BLue',	'Blanditiis ut quia d',	'XL 2 - 1\nChest:1Waist: 1 Hip:1',	194,	1,	NULL,	NULL,	NULL),
(203,	104,	223,	25,	'S 1 - 1',	'BLue',	'Blanditiis ut quia d',	'S 1 - 1\nChest:1Waist: 1 Hip:1',	334,	1,	NULL,	NULL,	NULL),
(204,	104,	225,	27,	'XL 1 - 1',	'Red',	'Ut ea quia et in dol',	'XL 1 - 1\nChest:1Waist: 1 Hip:1',	20,	2,	NULL,	NULL,	NULL),
(205,	105,	223,	21,	'XL 2 - 1',	'Red',	'Blanditiis ut quia d',	'XL 2 - 1\nChest:1Waist: 1 Hip:1',	192,	1,	NULL,	NULL,	NULL),
(206,	105,	223,	22,	'S 1 - 1',	'Red',	'Blanditiis ut quia d',	'S 1 - 1\nChest:1Waist: 1 Hip:1',	332,	1,	NULL,	NULL,	NULL),
(207,	105,	223,	24,	'XL 2 - 1',	'BLue',	'Blanditiis ut quia d',	'XL 2 - 1\nChest:1Waist: 1 Hip:1',	194,	1,	NULL,	NULL,	NULL),
(208,	105,	223,	25,	'S 1 - 1',	'BLue',	'Blanditiis ut quia d',	'S 1 - 1\nChest:1Waist: 1 Hip:1',	334,	1,	NULL,	NULL,	NULL),
(209,	105,	225,	27,	'XL 1 - 1',	'Red',	'Ut ea quia et in dol',	'XL 1 - 1\nChest:1Waist: 1 Hip:1',	20,	2,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `order_status_history`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_status_history` (`id`, `order_id`, `status`, `staff_id`, `old_value`, `new_value`, `field`, `created_by`, `created`, `modified`) VALUES
(159,	105,	'accepted',	NULL,	NULL,	NULL,	NULL,	7,	'2024-04-20 12:00:50',	'2024-04-20 12:00:50'),
(160,	105,	'on_the_way',	NULL,	NULL,	NULL,	NULL,	7,	'2024-04-20 12:09:17',	'2024-04-20 12:09:17'),
(161,	105,	'',	2,	NULL,	NULL,	NULL,	7,	'2024-04-20 12:09:48',	'2024-04-20 12:09:48');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prefix_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `manual_address` tinyint(1) DEFAULT '0',
  `address_id` int DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `tax_percentage` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `coupon` json DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_by` int DEFAULT NULL,
  `status_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
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
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`status_by`) REFERENCES `admins` (`id`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `orders` (`id`, `customer_id`, `staff_id`, `first_name`, `last_name`, `company`, `customer_email`, `customer_phone`, `prefix_id`, `manual_address`, `address_id`, `address`, `city`, `area`, `state`, `postcode`, `latitude`, `longitude`, `subtotal`, `discount`, `tax_percentage`, `tax`, `total_amount`, `coupon`, `status`, `status_by`, `status_at`, `created_by`, `created`, `modified`, `deleted_at`) VALUES
(104,	NULL,	NULL,	'Eligendi veritatis e',	'Ad atque sed adipisi',	'In labore asperiores',	'ritish.vermani@hotmail.com',	'8877336655',	'2105',	1,	NULL,	'Atque autem placeat',	'Et deleniti quas rer',	'Ut iste adipisicing',	NULL,	'Ut eaque anim dolore',	NULL,	NULL,	1092.00,	218.40,	10.00,	87.36,	960.96,	'{\"id\": 4, \"title\": \"20% Off\", \"amount\": 20, \"min_amount\": null, \"coupon_code\": \"8540291\", \"description\": \"<p>Inventore quis illum aliquam.</p>\", \"is_percentage\": 1}',	'pending',	NULL,	NULL,	NULL,	'2024-04-20 11:40:11',	'2024-04-20 11:40:11',	NULL),
(105,	16,	2,	'Eligendi veritatis e',	'Ad atque sed adipisi',	'In labore asperiores',	'ritish.vermani@hotmail.com',	'8877336655',	'2106',	1,	NULL,	'Atque autem placeat',	'Et deleniti quas rer',	'Ut iste adipisicing',	NULL,	'Ut eaque anim dolore',	NULL,	NULL,	1092.00,	218.40,	10.00,	87.36,	960.96,	'{\"id\": 4, \"title\": \"20% Off\", \"amount\": 20, \"min_amount\": null, \"coupon_code\": \"8540291\", \"description\": \"<p>Inventore quis illum aliquam.</p>\", \"is_percentage\": 1}',	'on_the_way',	7,	'2024-04-20 12:09:17',	NULL,	'2024-04-20 11:43:42',	'2024-04-20 11:43:42',	NULL);

DROP TABLE IF EXISTS `pages`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `pages` (`id`, `title`, `description`, `slug`, `image`, `meta_title`, `meta_description`, `meta_keywords`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(4,	'About Us',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'about-us',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:53:09'),
(5,	'FAQs',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'faqs',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:54:48'),
(6,	'Terms & Conditions',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'terms-conditions',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:54:48'),
(7,	'Privacy Policy',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'privacy-policy',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:54:48'),
(8,	'Delivery Information',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'delivery-information',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:54:48'),
(9,	'Return Policy',	'<h2>Who we are</h2>\r\n\r\n<p>Our website address is:&nbsp;<a href=\"mailto:info@example.com\">info@example.com</a></p>\r\n\r\n<h2>What personal data we collect and why we collect it</h2>\r\n\r\n<h3>Comments</h3>\r\n\r\n<p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&rsquo;s IP address and browser user agent string to help spam detection.</p>\r\n\r\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\r\n\r\n<h3>Media</h3>\r\n\r\n<p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\r\n\r\n<h3>Cookies</h3>\r\n\r\n<p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\r\n\r\n<p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\r\n\r\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &ldquo;Remember Me&rdquo;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\r\n\r\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\r\n\r\n<h3>Embedded content from other websites</h3>\r\n\r\n<p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\r\n\r\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\r\n\r\n<h2>How long we retain your data</h2>\r\n\r\n<p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\r\n\r\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\r\n\r\n<h2>What rights you have over your data</h2>\r\n\r\n<p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\r\n\r\n<h2>Where we send your data</h2>\r\n\r\n<p>Visitor comments may be checked through an automated spam detection service.</p>',	'return-policy',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-03-31 09:54:48'),
(10,	'Join Our Newsletter',	'<p>Enter your email address to subscribe our notification of our new post &amp; features by email.</p>',	'newsletter',	'/uploads/pages/1712338151941-screenshot-1.png',	NULL,	NULL,	NULL,	1,	NULL,	NULL,	'2024-03-31 14:56:35',	'2024-04-05 17:29:14');

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `permissions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `permissions` (`id`, `title`, `type`, `permissions`) VALUES
(1,	'Staff',	'staff',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}'),
(2,	'Coupon',	'coupons',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}'),
(3,	'Orders',	'orders',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}'),
(4,	'Brands',	'brands',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}'),
(5,	'Product Category',	'product_categories',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}'),
(6,	'Product',	'products',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}');

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE `product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `slug` varchar(255) DEFAULT NULL,
  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `product_categories` (`id`, `parent_id`, `title`, `description`, `slug`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(7,	NULL,	'T-Shirt',	'',	't-shirt',	NULL,	1,	7,	NULL,	'2024-03-27 21:51:45',	'2024-03-27 16:21:46'),
(8,	NULL,	'Polo T-Shirts',	'',	'polo-t-shirts',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:01',	'2024-03-27 16:22:01'),
(9,	NULL,	'Hi Vis',	'',	'hi-vis',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:14',	'2024-03-27 16:22:14'),
(10,	NULL,	'Jackets',	'',	'jackets',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:29',	'2024-03-27 16:22:29'),
(11,	NULL,	'Hoodies',	'',	'hoodies',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:37',	'2024-03-27 16:22:37'),
(12,	NULL,	'Bottoms',	'',	'bottoms',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:46',	'2024-03-27 16:22:46'),
(13,	NULL,	'KnitWear',	'',	'knitwear',	NULL,	1,	7,	NULL,	'2024-03-27 21:52:59',	'2024-03-27 16:22:59'),
(14,	NULL,	'Headwear',	'',	'headwear',	NULL,	1,	7,	NULL,	'2024-03-27 21:53:08',	'2024-03-27 16:23:08'),
(15,	NULL,	'Commodo quisquam exc',	NULL,	'commodo-quisquam-exc',	NULL,	1,	7,	NULL,	'2024-04-19 15:11:47',	'2024-04-19 09:41:47');

DROP TABLE IF EXISTS `product_category_relation`;
CREATE TABLE `product_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_category_relation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_category_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `product_colors`;
CREATE TABLE `product_colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `color_id` int DEFAULT NULL,
  `color_title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `color_id` (`color_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `product_colors_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_colors_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `colours` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_colors_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `product_colors` (`id`, `product_id`, `color_id`, `color_title`, `color_code`, `created_by`, `created`, `modified`) VALUES
(5,	221,	2,	'BLue',	NULL,	7,	'2024-04-05 23:10:44',	'2024-04-05 17:40:44'),
(6,	221,	1,	'Red',	NULL,	7,	'2024-04-05 23:10:44',	'2024-04-05 17:40:44'),
(7,	222,	2,	'BLue',	NULL,	7,	'2024-04-09 22:49:07',	'2024-04-09 17:19:07'),
(8,	222,	1,	'Red',	NULL,	7,	'2024-04-09 22:49:07',	'2024-04-09 17:19:07'),
(9,	223,	2,	'BLue',	NULL,	7,	'2024-04-09 22:50:33',	'2024-04-09 17:20:33'),
(10,	223,	1,	'Red',	NULL,	7,	'2024-04-09 22:50:33',	'2024-04-09 17:20:33'),
(11,	224,	2,	'BLue',	NULL,	7,	'2024-04-17 00:14:33',	'2024-04-16 18:44:33'),
(12,	224,	1,	'Red',	NULL,	7,	'2024-04-17 00:14:33',	'2024-04-16 18:44:33'),
(13,	225,	2,	'BLue',	NULL,	7,	'2024-04-17 00:15:10',	'2024-04-16 18:45:10'),
(14,	225,	1,	'Red',	NULL,	7,	'2024-04-17 00:15:10',	'2024-04-16 18:45:10');

DROP TABLE IF EXISTS `product_reports`;
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


DROP TABLE IF EXISTS `product_sizes`;
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
  `color_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `size_id` (`size_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_sizes_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `product_sizes_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `product_sizes` (`id`, `size_title`, `from_cm`, `to_cm`, `chest`, `waist`, `hip`, `length`, `product_id`, `size_id`, `color_id`, `price`, `sale_price`, `created_at`, `updated_at`) VALUES
(3,	'XL',	2,	1,	1,	1,	1,	1,	93,	24,	NULL,	10.00,	0.00,	'2024-03-23 04:14:27',	'2024-03-23 04:14:27'),
(4,	'S',	1,	1,	1,	1,	1,	1,	93,	25,	NULL,	16.00,	0.00,	'2024-03-23 04:14:27',	'2024-03-23 04:14:27'),
(11,	'XL',	2,	1,	1,	1,	1,	1,	197,	24,	NULL,	30.00,	0.00,	'2024-03-30 06:45:58',	'2024-03-30 06:45:58'),
(12,	'S',	1,	1,	1,	1,	1,	1,	197,	25,	NULL,	20.00,	0.00,	'2024-03-30 06:45:58',	'2024-03-30 06:45:58'),
(13,	'M',	1,	1,	1,	1,	1,	1,	197,	26,	NULL,	10.00,	0.00,	'2024-03-30 06:45:58',	'2024-03-30 06:45:58'),
(20,	'XL',	1,	1,	2,	1,	1,	1,	221,	27,	NULL,	10.00,	0.00,	'2024-04-05 17:40:44',	'2024-04-05 17:40:44'),
(21,	'XL',	2,	1,	1,	1,	1,	1,	223,	24,	1,	192.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-09 17:20:33'),
(22,	'S',	1,	1,	1,	1,	1,	1,	223,	25,	1,	332.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-09 17:20:33'),
(23,	'M',	1,	1,	1,	1,	1,	1,	223,	26,	1,	132.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-09 17:20:33'),
(24,	'XL',	2,	1,	1,	1,	1,	1,	223,	24,	2,	194.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-10 17:28:39'),
(25,	'S',	1,	1,	1,	1,	1,	1,	223,	25,	2,	334.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-10 17:28:39'),
(26,	'M',	1,	1,	1,	1,	1,	1,	223,	26,	2,	134.00,	0.00,	'2024-04-09 17:20:33',	'2024-04-10 17:28:39'),
(27,	'XL',	1,	1,	1,	1,	1,	1,	225,	28,	1,	20.00,	10.00,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10'),
(28,	'XL',	1,	1,	1,	1,	1,	1,	225,	28,	2,	12.00,	6.00,	'2024-04-16 18:45:10',	'2024-04-16 18:45:10');

DROP TABLE IF EXISTS `product_sub_category_relation`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `product_sub_category_relation` (`id`, `product_id`, `sub_category_id`, `sub_category_title`) VALUES
(10,	197,	2,	'V neck'),
(11,	197,	3,	'Ling Sleeve'),
(12,	197,	4,	'Short Sleeve'),
(31,	221,	2,	'V neck'),
(32,	221,	3,	'Ling Sleeve'),
(33,	221,	4,	'Short Sleeve'),
(34,	223,	2,	'V neck'),
(35,	223,	3,	'Ling Sleeve'),
(36,	223,	4,	'Short Sleeve'),
(37,	225,	2,	'V neck'),
(38,	225,	3,	'Ling Sleeve');

DROP TABLE IF EXISTS `products`;
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
  `short_description` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `products` (`id`, `shop_id`, `category_id`, `user_id`, `color_id`, `gender`, `tags`, `title`, `slug`, `short_description`, `description`, `image`, `cropped_area`, `postcode`, `phonenumber`, `address`, `duration_of_service`, `base_price`, `price`, `sale_price`, `max_price`, `service_price`, `sold`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(197,	NULL,	7,	NULL,	2,	'Male',	NULL,	'A Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(198,	NULL,	7,	NULL,	2,	'Male',	NULL,	'B Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(199,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Z Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(200,	NULL,	7,	NULL,	2,	'Male',	NULL,	'C Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(201,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	200.00,	NULL,	300.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(202,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1000.00,	NULL,	1100.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(203,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(204,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(205,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	300.00,	NULL,	400.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(206,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(207,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(208,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(209,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(210,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(211,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(212,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(213,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(214,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(215,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(216,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(217,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(218,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(219,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(220,	NULL,	7,	NULL,	2,	'Male',	NULL,	'Oversize Cotton Dress',	'oversize-cotton-dress-gqYLyv',	NULL,	NULL,	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	100.00,	NULL,	200.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(221,	NULL,	7,	NULL,	2,	'Female',	NULL,	'Molestias aut ut qui',	'molestias-aut-ut-qui-BpWZn0',	'<h2>Nam provident sequi</h2>\r\n\r\n<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Nam provident sequi, nemo sapiente culpa nostrum rem eum perferendis quibusdam, magnam a vitae corporis! Magnam enim modi, illo harum suscipit tempore aut dolore',	'<h2>Nam provident sequi</h2>\r\n\r\n<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Nam provident sequi, nemo sapiente culpa nostrum rem eum perferendis quibusdam, magnam a vitae corporis! Magnam enim modi, illo harum suscipit tempore aut dolore doloribus deserunt voluptatum illum, est porro? Ducimus dolore accusamus impedit ipsum maiores, ea iusto temporibus numquam eaque mollitia fugiat laborum dolor tempora eligendi voluptatem quis necessitatibus nam ab?</p>\r\n\r\n<h4>More Details</h4>\r\n\r\n<ul>\r\n	<li>&nbsp;Lorem ipsum dolor sit amet consectetur adipisicing elit. Laboriosam, dolorum?</li>\r\n	<li>&nbsp;Magnam enim modi, illo harum suscipit tempore aut dolore?</li>\r\n	<li>&nbsp;Numquam eaque mollitia fugiat laborum dolor tempora;</li>\r\n	<li>&nbsp;Sit amet consectetur adipisicing elit. Quo delectus repellat facere maiores.</li>\r\n	<li>&nbsp;Repellendus itaque sit quia consequuntur, unde veritatis. dolorum?</li>\r\n</ul>',	'[\"/uploads/products/17117807672619-product21.png\",\"/uploads/products/17123388418710-screenshot-1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	155.00,	NULL,	162.00,	NULL,	0,	1,	7,	NULL,	'2024-03-27 23:39:12',	'2024-04-05 17:41:25'),
(222,	NULL,	7,	NULL,	NULL,	'Male',	NULL,	'Blanditiis ut quia d',	'blanditiis-ut-quia-d-w09bGp',	'Sed omnis inventore',	'<p>Velit numquam et in .SSS</p>',	'[\"/uploads/products/17126831431727-aq41.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	680.00,	NULL,	342.00,	NULL,	0,	1,	7,	NULL,	'2024-04-09 22:49:07',	'2024-04-09 17:19:07'),
(223,	NULL,	7,	NULL,	NULL,	'Male',	NULL,	'Blanditiis ut quia d',	'blanditiis-ut-quia-d-804nzv',	'Sed omnis inventore',	'<p>Velit numquam et in .SSS</p>',	'[\"/uploads/products/17126831431727-aq41.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	680.00,	NULL,	342.00,	NULL,	0,	1,	7,	NULL,	'2024-04-09 22:50:33',	'2024-04-09 17:20:33'),
(224,	NULL,	7,	NULL,	NULL,	'Unisex',	NULL,	'Ut ea quia et in dol',	'ut-ea-quia-et-in-dol-3p8on0',	'Cupidatat est optio',	'<p>Et quasi saepe ipsum.</p>',	'[\"/uploads/products/17132930687511-mostlyclearnight1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	714.00,	NULL,	721.00,	NULL,	0,	1,	7,	NULL,	'2024-04-17 00:14:33',	'2024-04-16 18:44:33'),
(225,	NULL,	7,	NULL,	NULL,	'Unisex',	NULL,	'Ut ea quia et in dol',	'ut-ea-quia-et-in-dol-2vPZZ0',	'Cupidatat est optio',	'<p>Et quasi saepe ipsum.</p>',	'[\"/uploads/products/17132930687511-mostlyclearnight1.png\"]',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	714.00,	NULL,	721.00,	NULL,	0,	1,	7,	NULL,	'2024-04-17 00:15:10',	'2024-04-16 18:45:10');

DROP TABLE IF EXISTS `ratings`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `ratings` (`id`, `image_status`, `name`, `designation`, `message`, `rating`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(6,	1,	'Nike Mardson',	'Fashion Designer',	'Lorem ipsum dolor sit amet, consectetur adipisicin elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',	2,	'/uploads/ratings/1711258056417-testimonial-thumb31.png',	1,	7,	NULL,	'2024-03-24 10:47:13',	'2024-03-24 05:27:44');

DROP TABLE IF EXISTS `search_keywords`;
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

INSERT INTO `search_keywords` (`id`, `product_id`, `keywords`, `deleted_at`, `created`, `modified`) VALUES
(305,	78,	'Chief',	'2024-01-06 16:13:21',	'2024-01-06 15:51:46',	'2024-01-06 16:13:21'),
(306,	78,	'Brand',	'2024-01-06 16:13:21',	'2024-01-06 15:51:46',	'2024-01-06 16:13:21'),
(307,	78,	'Supervisor',	'2024-01-06 16:13:21',	'2024-01-06 15:51:46',	'2024-01-06 16:13:21'),
(308,	78,	'Chief Brand Supervisor',	'2024-01-06 16:13:21',	'2024-01-06 15:51:46',	'2024-01-06 16:13:21'),
(309,	79,	'Dynamic',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(310,	79,	'Usability',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(311,	79,	'Orchestrator',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(312,	79,	'Dynamic Usability Orchestrator',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(313,	79,	'Fashion',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(314,	79,	'Dynamic',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(315,	79,	'Usability',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(316,	79,	'Orchestrator',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(317,	79,	'Dynamic Usability Orchestrator',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54',	'2024-01-06 16:01:54'),
(318,	79,	'Fashion',	'2024-01-06 16:12:55',	'2024-01-06 16:01:54',	'2024-01-06 16:12:55'),
(319,	79,	'Dynamic',	'2024-01-06 16:12:55',	'2024-01-06 16:01:54',	'2024-01-06 16:12:55'),
(320,	79,	'Usability',	'2024-01-06 16:12:55',	'2024-01-06 16:01:54',	'2024-01-06 16:12:55'),
(321,	79,	'Orchestrator',	'2024-01-06 16:12:55',	'2024-01-06 16:01:54',	'2024-01-06 16:12:55'),
(322,	79,	'Dynamic Usability Orchestrator',	'2024-01-06 16:12:55',	'2024-01-06 16:01:54',	'2024-01-06 16:12:55'),
(323,	79,	'Fashion',	'2024-01-06 16:12:56',	'2024-01-06 16:12:55',	'2024-01-06 16:12:56'),
(324,	79,	'Dynamic',	'2024-01-06 16:12:56',	'2024-01-06 16:12:55',	'2024-01-06 16:12:56'),
(325,	79,	'Usability',	'2024-01-06 16:12:56',	'2024-01-06 16:12:55',	'2024-01-06 16:12:56'),
(326,	79,	'Orchestrator',	'2024-01-06 16:12:56',	'2024-01-06 16:12:55',	'2024-01-06 16:12:56'),
(327,	79,	'Dynamic Usability Orchestrator',	'2024-01-06 16:12:56',	'2024-01-06 16:12:55',	'2024-01-06 16:12:56'),
(328,	79,	'Fashion',	'2024-01-07 11:36:37',	'2024-01-06 16:12:56',	'2024-01-07 11:36:37'),
(329,	79,	'Dynamic',	'2024-01-07 11:36:37',	'2024-01-06 16:12:56',	'2024-01-07 11:36:37'),
(330,	79,	'Usability',	'2024-01-07 11:36:37',	'2024-01-06 16:12:56',	'2024-01-07 11:36:37'),
(331,	79,	'Orchestrator',	'2024-01-07 11:36:37',	'2024-01-06 16:12:56',	'2024-01-07 11:36:37'),
(332,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:36:37',	'2024-01-06 16:12:56',	'2024-01-07 11:36:37'),
(333,	78,	'Chief',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21'),
(334,	78,	'Brand',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21'),
(335,	78,	'Supervisor',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21'),
(336,	78,	'Chief Brand Supervisor',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21',	'2024-01-06 16:13:21'),
(337,	78,	'Beauty',	'2024-01-07 18:27:38',	'2024-01-06 16:13:21',	'2024-01-07 18:27:38'),
(338,	78,	'Chief',	'2024-01-07 18:27:38',	'2024-01-06 16:13:21',	'2024-01-07 18:27:38'),
(339,	78,	'Brand',	'2024-01-07 18:27:38',	'2024-01-06 16:13:21',	'2024-01-07 18:27:38'),
(340,	78,	'Supervisor',	'2024-01-07 18:27:38',	'2024-01-06 16:13:21',	'2024-01-07 18:27:38'),
(341,	78,	'Chief Brand Supervisor',	'2024-01-07 18:27:38',	'2024-01-06 16:13:21',	'2024-01-07 18:27:38'),
(342,	79,	'Fashion',	'2024-01-07 11:36:38',	'2024-01-07 11:36:37',	'2024-01-07 11:36:38'),
(343,	79,	'Dynamic',	'2024-01-07 11:36:38',	'2024-01-07 11:36:37',	'2024-01-07 11:36:38'),
(344,	79,	'Usability',	'2024-01-07 11:36:38',	'2024-01-07 11:36:37',	'2024-01-07 11:36:38'),
(345,	79,	'Orchestrator',	'2024-01-07 11:36:38',	'2024-01-07 11:36:37',	'2024-01-07 11:36:38'),
(346,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:36:38',	'2024-01-07 11:36:37',	'2024-01-07 11:36:38'),
(347,	79,	'Fashion',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(348,	79,	'Beauty',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(349,	79,	'Dynamic',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(350,	79,	'Usability',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(351,	79,	'Orchestrator',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(352,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:36:59',	'2024-01-07 11:36:38',	'2024-01-07 11:36:59'),
(353,	79,	'Fashion',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(354,	79,	'Beauty',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(355,	79,	'Dynamic',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(356,	79,	'Usability',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(357,	79,	'Orchestrator',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(358,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59',	'2024-01-07 11:36:59'),
(359,	79,	'Fashion',	'2024-01-07 11:37:11',	'2024-01-07 11:36:59',	'2024-01-07 11:37:11'),
(360,	79,	'Dynamic',	'2024-01-07 11:37:11',	'2024-01-07 11:36:59',	'2024-01-07 11:37:11'),
(361,	79,	'Usability',	'2024-01-07 11:37:11',	'2024-01-07 11:36:59',	'2024-01-07 11:37:11'),
(362,	79,	'Orchestrator',	'2024-01-07 11:37:11',	'2024-01-07 11:36:59',	'2024-01-07 11:37:11'),
(363,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:37:11',	'2024-01-07 11:36:59',	'2024-01-07 11:37:11'),
(364,	79,	'Fashion',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11'),
(365,	79,	'Dynamic',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11'),
(366,	79,	'Usability',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11'),
(367,	79,	'Orchestrator',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11'),
(368,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11',	'2024-01-07 11:37:11'),
(369,	79,	'Fashion',	'2024-01-07 11:37:22',	'2024-01-07 11:37:11',	'2024-01-07 11:37:22'),
(370,	79,	'Dynamic',	'2024-01-07 11:37:22',	'2024-01-07 11:37:11',	'2024-01-07 11:37:22'),
(371,	79,	'Usability',	'2024-01-07 11:37:22',	'2024-01-07 11:37:11',	'2024-01-07 11:37:22'),
(372,	79,	'Orchestrator',	'2024-01-07 11:37:22',	'2024-01-07 11:37:11',	'2024-01-07 11:37:22'),
(373,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:37:22',	'2024-01-07 11:37:11',	'2024-01-07 11:37:22'),
(374,	79,	'Fashion',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22'),
(375,	79,	'Dynamic',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22'),
(376,	79,	'Usability',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22'),
(377,	79,	'Orchestrator',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22'),
(378,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22',	'2024-01-07 11:37:22'),
(379,	79,	'Fashion',	'2024-01-07 11:48:14',	'2024-01-07 11:37:22',	'2024-01-07 11:48:14'),
(380,	79,	'Dynamic',	'2024-01-07 11:48:14',	'2024-01-07 11:37:22',	'2024-01-07 11:48:14'),
(381,	79,	'Usability',	'2024-01-07 11:48:14',	'2024-01-07 11:37:22',	'2024-01-07 11:48:14'),
(382,	79,	'Orchestrator',	'2024-01-07 11:48:14',	'2024-01-07 11:37:22',	'2024-01-07 11:48:14'),
(383,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:48:14',	'2024-01-07 11:37:22',	'2024-01-07 11:48:14'),
(384,	79,	'Fashion',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14'),
(385,	79,	'Dynamic',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14'),
(386,	79,	'Usability',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14'),
(387,	79,	'Orchestrator',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14'),
(388,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14',	'2024-01-07 11:48:14'),
(389,	79,	'Fashion',	'2024-01-07 11:48:25',	'2024-01-07 11:48:14',	'2024-01-07 11:48:25'),
(390,	79,	'Dynamic',	'2024-01-07 11:48:25',	'2024-01-07 11:48:14',	'2024-01-07 11:48:25'),
(391,	79,	'Usability',	'2024-01-07 11:48:25',	'2024-01-07 11:48:14',	'2024-01-07 11:48:25'),
(392,	79,	'Orchestrator',	'2024-01-07 11:48:25',	'2024-01-07 11:48:14',	'2024-01-07 11:48:25'),
(393,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:48:25',	'2024-01-07 11:48:14',	'2024-01-07 11:48:25'),
(394,	79,	'Fashion',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25'),
(395,	79,	'Dynamic',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25'),
(396,	79,	'Usability',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25'),
(397,	79,	'Orchestrator',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25'),
(398,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25',	'2024-01-07 11:48:25'),
(399,	79,	'Fashion',	'2024-01-07 11:56:18',	'2024-01-07 11:48:25',	'2024-01-07 11:56:18'),
(400,	79,	'Dynamic',	'2024-01-07 11:56:18',	'2024-01-07 11:48:25',	'2024-01-07 11:56:18'),
(401,	79,	'Usability',	'2024-01-07 11:56:18',	'2024-01-07 11:48:25',	'2024-01-07 11:56:18'),
(402,	79,	'Orchestrator',	'2024-01-07 11:56:18',	'2024-01-07 11:48:25',	'2024-01-07 11:56:18'),
(403,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:56:18',	'2024-01-07 11:48:25',	'2024-01-07 11:56:18'),
(404,	79,	'Fashion',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18'),
(405,	79,	'Dynamic',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18'),
(406,	79,	'Usability',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18'),
(407,	79,	'Orchestrator',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18'),
(408,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18',	'2024-01-07 11:56:18'),
(409,	79,	'Fashion',	'2024-01-07 11:56:19',	'2024-01-07 11:56:18',	'2024-01-07 11:56:19'),
(410,	79,	'Dynamic',	'2024-01-07 11:56:19',	'2024-01-07 11:56:18',	'2024-01-07 11:56:19'),
(411,	79,	'Usability',	'2024-01-07 11:56:19',	'2024-01-07 11:56:18',	'2024-01-07 11:56:19'),
(412,	79,	'Orchestrator',	'2024-01-07 11:56:19',	'2024-01-07 11:56:18',	'2024-01-07 11:56:19'),
(413,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:56:19',	'2024-01-07 11:56:18',	'2024-01-07 11:56:19'),
(414,	79,	'Fashion',	'2024-01-07 11:57:17',	'2024-01-07 11:56:19',	'2024-01-07 11:57:17'),
(415,	79,	'Dynamic',	'2024-01-07 11:57:17',	'2024-01-07 11:56:19',	'2024-01-07 11:57:17'),
(416,	79,	'Usability',	'2024-01-07 11:57:17',	'2024-01-07 11:56:19',	'2024-01-07 11:57:17'),
(417,	79,	'Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:56:19',	'2024-01-07 11:57:17'),
(418,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:56:19',	'2024-01-07 11:57:17'),
(419,	79,	'Fashion',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(420,	79,	'Dynamic',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(421,	79,	'Usability',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(422,	79,	'Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(423,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(424,	79,	'Fashion',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(425,	79,	'Dynamic',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(426,	79,	'Usability',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(427,	79,	'Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(428,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17',	'2024-01-07 11:57:17'),
(429,	79,	'Fashion',	'2024-01-07 11:57:43',	'2024-01-07 11:57:17',	'2024-01-07 11:57:43'),
(430,	79,	'Dynamic',	'2024-01-07 11:57:43',	'2024-01-07 11:57:17',	'2024-01-07 11:57:43'),
(431,	79,	'Usability',	'2024-01-07 11:57:43',	'2024-01-07 11:57:17',	'2024-01-07 11:57:43'),
(432,	79,	'Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:17',	'2024-01-07 11:57:43'),
(433,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:17',	'2024-01-07 11:57:43'),
(434,	79,	'Fashion',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(435,	79,	'Dynamic',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(436,	79,	'Usability',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(437,	79,	'Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(438,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(439,	79,	'Fashion',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(440,	79,	'Dynamic',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(441,	79,	'Usability',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(442,	79,	'Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(443,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43',	'2024-01-07 11:57:43'),
(444,	79,	'Fashion',	'2024-01-07 12:04:54',	'2024-01-07 11:57:43',	'2024-01-07 12:04:54'),
(445,	79,	'Dynamic',	'2024-01-07 12:04:54',	'2024-01-07 11:57:43',	'2024-01-07 12:04:54'),
(446,	79,	'Usability',	'2024-01-07 12:04:54',	'2024-01-07 11:57:43',	'2024-01-07 12:04:54'),
(447,	79,	'Orchestrator',	'2024-01-07 12:04:54',	'2024-01-07 11:57:43',	'2024-01-07 12:04:54'),
(448,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 12:04:54',	'2024-01-07 11:57:43',	'2024-01-07 12:04:54'),
(449,	79,	'Fashion',	'2024-01-07 12:04:55',	'2024-01-07 12:04:54',	'2024-01-07 12:04:55'),
(450,	79,	'Dynamic',	'2024-01-07 12:04:55',	'2024-01-07 12:04:54',	'2024-01-07 12:04:55'),
(451,	79,	'Usability',	'2024-01-07 12:04:55',	'2024-01-07 12:04:54',	'2024-01-07 12:04:55'),
(452,	79,	'Orchestrator',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(453,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(454,	79,	'Fashion',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(455,	79,	'Beauty',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(456,	79,	'Dynamic',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(457,	79,	'Usability',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(458,	79,	'Orchestrator',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(459,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55',	'2024-01-07 12:04:55'),
(460,	79,	'Fashion',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(461,	79,	'Beauty',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(462,	79,	'Dynamic',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(463,	79,	'Usability',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(464,	79,	'Orchestrator',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(465,	79,	'Dynamic Usability Orchestrator',	'2024-01-07 18:27:30',	'2024-01-07 12:04:55',	'2024-01-07 18:27:30'),
(466,	80,	'Dynamic',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(467,	80,	'Configuration',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(468,	80,	'Liaison',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(469,	80,	'Dynamic Configuration Liaison',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(470,	80,	'Fashion',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(471,	80,	'Dynamic',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(472,	80,	'Configuration',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(473,	80,	'Liaison',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(474,	80,	'Dynamic Configuration Liaison',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17',	'2024-01-07 12:05:17'),
(475,	80,	'Fashion',	'2024-01-07 15:19:43',	'2024-01-07 12:05:17',	'2024-01-07 15:19:43'),
(476,	80,	'Dynamic',	'2024-01-07 15:19:43',	'2024-01-07 12:05:17',	'2024-01-07 15:19:43'),
(477,	80,	'Configuration',	'2024-01-07 15:19:43',	'2024-01-07 12:05:17',	'2024-01-07 15:19:43'),
(478,	80,	'Liaison',	'2024-01-07 15:19:43',	'2024-01-07 12:05:17',	'2024-01-07 15:19:43'),
(479,	80,	'Dynamic Configuration Liaison',	'2024-01-07 15:19:43',	'2024-01-07 12:05:17',	'2024-01-07 15:19:43'),
(480,	80,	'Fashion',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(481,	80,	'Dynamic',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(482,	80,	'Configuration',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(483,	80,	'Liaison',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(484,	80,	'Dynamic Configuration Liaison',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(485,	80,	'Fashion',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(486,	80,	'Dynamic',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(487,	80,	'Configuration',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(488,	80,	'Liaison',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(489,	80,	'Dynamic Configuration Liaison',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43',	'2024-01-07 15:19:43'),
(490,	80,	'Fashion',	'2024-01-07 18:27:12',	'2024-01-07 15:19:43',	'2024-01-07 18:27:12'),
(491,	80,	'Dynamic',	'2024-01-07 18:27:12',	'2024-01-07 15:19:43',	'2024-01-07 18:27:12'),
(492,	80,	'Configuration',	'2024-01-07 18:27:12',	'2024-01-07 15:19:43',	'2024-01-07 18:27:12'),
(493,	80,	'Liaison',	'2024-01-07 18:27:12',	'2024-01-07 15:19:43',	'2024-01-07 18:27:12'),
(494,	80,	'Dynamic Configuration Liaison',	'2024-01-07 18:27:12',	'2024-01-07 15:19:43',	'2024-01-07 18:27:12'),
(495,	81,	'Jeans',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19'),
(496,	81,	'Jeans',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19'),
(497,	81,	'Fashion',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19'),
(498,	81,	'Jeans',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19'),
(499,	81,	'Jeans',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19',	'2024-01-07 18:30:19'),
(500,	81,	'Fashion',	NULL,	'2024-01-07 18:30:19',	'2024-01-07 13:00:19'),
(501,	81,	'Jeans',	NULL,	'2024-01-07 18:30:19',	'2024-01-07 13:00:19'),
(502,	81,	'Jeans',	NULL,	'2024-01-07 18:30:19',	'2024-01-07 13:00:19'),
(503,	82,	'Frock',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54'),
(504,	82,	'Frock',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54'),
(505,	82,	'Fashion',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54'),
(506,	82,	'Frock',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54'),
(507,	82,	'Frock',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54',	'2024-01-07 18:30:54'),
(508,	82,	'Fashion',	NULL,	'2024-01-07 18:30:54',	'2024-01-07 13:00:54'),
(509,	82,	'Frock',	NULL,	'2024-01-07 18:30:54',	'2024-01-07 13:00:54'),
(510,	82,	'Frock',	NULL,	'2024-01-07 18:30:54',	'2024-01-07 13:00:54'),
(511,	83,	'Top',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29'),
(512,	83,	'Top',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29'),
(513,	83,	'Fashion',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29'),
(514,	83,	'Top',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29'),
(515,	83,	'Top',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29',	'2024-01-07 18:31:29'),
(516,	83,	'Fashion',	NULL,	'2024-01-07 18:31:29',	'2024-01-07 13:01:29'),
(517,	83,	'Top',	NULL,	'2024-01-07 18:31:29',	'2024-01-07 13:01:29'),
(518,	83,	'Top',	NULL,	'2024-01-07 18:31:29',	'2024-01-07 13:01:29'),
(519,	84,	'National',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(520,	84,	'Assurance',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(521,	84,	'Engineer',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(522,	84,	'National Assurance Engineer',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(523,	84,	'Fashion',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(524,	84,	'National',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(525,	84,	'Assurance',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(526,	84,	'Engineer',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(527,	84,	'National Assurance Engineer',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25',	'2024-01-23 15:42:25'),
(528,	84,	'Fashion',	NULL,	'2024-01-23 15:42:25',	'2024-01-23 10:12:25'),
(529,	84,	'National',	NULL,	'2024-01-23 15:42:25',	'2024-01-23 10:12:25'),
(530,	84,	'Assurance',	NULL,	'2024-01-23 15:42:25',	'2024-01-23 10:12:25'),
(531,	84,	'Engineer',	NULL,	'2024-01-23 15:42:25',	'2024-01-23 10:12:25'),
(532,	84,	'National Assurance Engineer',	NULL,	'2024-01-23 15:42:25',	'2024-01-23 10:12:25'),
(533,	85,	'Dfgsdfg',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(534,	85,	'Dfgsdfg',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(535,	85,	'Fashion',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(536,	85,	'Beauty',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(537,	85,	'Dfgsdfg',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(538,	85,	'Dfgsdfg',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33',	'2024-01-24 09:56:33'),
(539,	85,	'Fashion',	'2024-01-30 16:13:26',	'2024-01-24 09:56:33',	'2024-01-30 16:13:26'),
(540,	85,	'Beauty',	'2024-01-30 16:13:26',	'2024-01-24 09:56:33',	'2024-01-30 16:13:26'),
(541,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-24 09:56:33',	'2024-01-30 16:13:26'),
(542,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-24 09:56:33',	'2024-01-30 16:13:26'),
(543,	85,	'Fashion',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(544,	85,	'Beauty',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(545,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(546,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(547,	85,	'Fashion',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(548,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(549,	85,	'Dfgsdfg',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26',	'2024-01-30 16:13:26'),
(550,	85,	'Fashion',	NULL,	'2024-01-30 16:13:26',	'2024-01-30 10:43:26'),
(551,	85,	'Dfgsdfg',	NULL,	'2024-01-30 16:13:26',	'2024-01-30 10:43:26'),
(552,	85,	'Dfgsdfg',	NULL,	'2024-01-30 16:13:26',	'2024-01-30 10:43:26');

DROP TABLE IF EXISTS `search_sugessions`;
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


DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `settings` (`id`, `name`, `value`) VALUES
(1,	'company_name',	'Admin'),
(2,	'company_address',	'Admin'),
(3,	'pagination_method',	'scroll'),
(4,	'admin_second_auth_factor',	''),
(5,	'admin_notification_email',	'admin@admin.com'),
(6,	'currency_code',	'GBP'),
(7,	'currency_symbol',	'£'),
(8,	'date_format',	'd-m-Y'),
(9,	'time_format',	'h:iA'),
(10,	'tax_percentage',	'10'),
(11,	'order_prefix',	'2001'),
(12,	'from_email',	'noreply@saloon.com'),
(13,	'email_method',	'smtp'),
(14,	'gst',	'10'),
(16,	'logo_options',	'[\"Printed Logo\", \"Embroidered Logo\"]'),
(17,	'logo_positions',	'[\"Chest Left\", \"Chest Middle\", \"Chest Right\", \"Arm Right\", \"Arm Left\", \"Back\", \"Text/Initial on Front\", \"Text/Initial at Back\"]');

DROP TABLE IF EXISTS `shops`;
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


DROP TABLE IF EXISTS `sizes`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `sizes` (`id`, `type`, `size_title`, `from_cm`, `to_cm`, `chest`, `waist`, `hip`, `length`, `created_by`, `created`, `modified`, `deleted_at`) VALUES
(8,	'Male',	'XL',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 10:11:20',	'2024-03-16 11:45:26',	'2024-03-16 11:45:26'),
(12,	'Male',	'L',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:16:53',	'2024-03-16 11:45:26',	'2024-03-16 11:45:26'),
(15,	'Male',	'XL',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:26',	'2024-03-16 11:45:32',	'2024-03-16 11:45:32'),
(16,	'Male',	'L',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:26',	'2024-03-16 11:45:32',	'2024-03-16 11:45:32'),
(17,	'Male',	'XL',	2,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:32',	'2024-03-16 11:45:38',	'2024-03-16 11:45:38'),
(18,	'Male',	'L',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:32',	'2024-03-16 11:45:38',	'2024-03-16 11:45:38'),
(19,	'Male',	'XL',	2,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:38',	'2024-03-17 12:57:35',	'2024-03-17 12:57:35'),
(20,	'Male',	'S',	1,	1,	1,	1,	1,	1,	7,	'2024-03-16 11:45:38',	'2024-03-17 12:57:35',	'2024-03-17 12:57:35'),
(21,	'Male',	'XL',	2,	1,	1,	1,	1,	1,	7,	'2024-03-17 12:57:35',	'2024-03-17 13:09:16',	'2024-03-17 13:09:16'),
(22,	'Male',	'S',	1,	1,	1,	1,	1,	1,	7,	'2024-03-17 12:57:35',	'2024-03-17 13:09:16',	'2024-03-17 13:09:16'),
(23,	'Male',	'M',	1,	1,	1,	1,	1,	1,	7,	'2024-03-17 12:57:35',	'2024-03-17 13:09:16',	'2024-03-17 13:09:16'),
(24,	'Male',	'XL',	2,	1,	1,	1,	1,	1,	7,	'2024-03-17 13:09:16',	'2024-03-17 13:09:16',	NULL),
(25,	'Male',	'S',	1,	1,	1,	1,	1,	1,	7,	'2024-03-17 13:09:16',	'2024-03-17 13:09:16',	NULL),
(26,	'Male',	'M',	1,	1,	1,	1,	1,	1,	7,	'2024-03-17 13:09:16',	'2024-03-17 13:09:16',	NULL),
(27,	'Female',	'XL',	1,	1,	2,	1,	1,	1,	7,	'2024-03-17 14:25:28',	'2024-03-17 14:25:28',	NULL),
(28,	'Unisex',	'XL',	1,	1,	1,	1,	1,	1,	7,	'2024-03-17 14:25:42',	'2024-03-17 14:25:42',	NULL);

DROP TABLE IF EXISTS `sliders`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `sliders` (`id`, `label`, `heading`, `sub_heading`, `button_status`, `button_title`, `button_url`, `status`, `image`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(7,	'PRO PREMIUM POLO',	'New Style\r\nCollection 2023',	'Up To 40% Off Final Sale Items. \r\nCaught in the Moment!',	1,	'Shop Now',	'/',	1,	NULL,	7,	'0000-00-00 00:00:00',	'2024-03-24 10:22:47',	'2024-03-24 05:00:41');

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `aadhar_card_number` bigint NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `staff` (`id`, `first_name`, `last_name`, `phone_number`, `email`, `aadhar_card_number`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(1,	'Graciela',	'Aufderhar',	5423333333,	'your.email+fakedata22046@gmail.com',	1273456789012,	'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',	0,	7,	NULL,	'2024-01-19 15:54:40',	'2024-01-19 10:24:40'),
(2,	'Myles',	'Zulauf',	1971231231,	'your.email+fakedata88731@gmail.com',	494123123123,	'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',	1,	7,	NULL,	'2024-01-20 01:46:46',	'2024-01-19 20:16:46');

DROP TABLE IF EXISTS `staff_documents`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `staff_documents` (`id`, `staff_id`, `title`, `file`, `slug`, `created`, `created_by`, `modified`) VALUES
(17,	2,	'.',	'[\"\\/uploads\\/staff-documents\\/17084487122745-hm-logo.png\"]',	NULL,	'2024-02-20 17:05:14',	7,	'2024-02-20 17:05:18');

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `state_code` varchar(50) NOT NULL,
  `country_id` int NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `sub_categories`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `sub_categories` (`id`, `category_id`, `title`, `description`, `image`, `slug`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(2,	7,	'V neck',	'',	NULL,	'v-neck',	1,	7,	NULL,	'2024-03-27 22:44:22',	'2024-03-27 17:48:35'),
(3,	7,	'Ling Sleeve',	'',	NULL,	'ling-sleeve',	1,	7,	NULL,	'2024-03-27 22:46:38',	'2024-03-27 17:16:38'),
(4,	7,	'Short Sleeve',	'',	NULL,	'short-sleeve',	1,	7,	NULL,	'2024-03-27 22:46:52',	'2024-03-27 17:16:52'),
(5,	7,	'SSSSSSSS',	NULL,	NULL,	'ssssssss',	1,	7,	NULL,	'2024-04-19 15:12:22',	'2024-04-19 09:42:22');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `postcode` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `image` text,
  `bio` longtext,
  `last_login` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `seller` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_id` varchar(200) DEFAULT NULL,
  `google_id` varchar(200) DEFAULT NULL,
  `google_email` varchar(200) DEFAULT NULL,
  `otp` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phonenumber`, `dob`, `address`, `address2`, `city`, `country`, `postcode`, `image`, `bio`, `last_login`, `token`, `gender`, `email`, `password`, `status`, `verified_at`, `seller`, `facebook_id`, `google_id`, `google_email`, `otp`, `deleted_at`, `created_by`, `created`, `modified`) VALUES
(16,	'Serina Cooley',	'',	'8877336655',	NULL,	'Voluptatem voluptati',	'Dolor molestiae quod',	'Animi aut blanditii',	NULL,	'Assumenda beatae ea',	NULL,	NULL,	'2024-04-20 11:16:08',	NULL,	NULL,	'ritish.vermani@hotmail.com',	'$2y$10$eM2X20PKiTEjw6QvtlftVebyOgaYD8aaizbjICHKWXRvG6y.g/25e',	1,	NULL,	0,	NULL,	NULL,	NULL,	'216512',	NULL,	7,	'2024-04-19 16:05:51',	'2024-04-19 13:48:02');

DROP TABLE IF EXISTS `users_matches`;
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


DROP TABLE IF EXISTS `users_permissions`;
CREATE TABLE `users_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `users_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `users_permissions` (`id`, `user_id`, `permission`, `status`, `created`) VALUES
(61,	16,	'email_buyer_message',	1,	'2024-04-19 10:35:51'),
(62,	16,	'email_seller_message',	1,	'2024-04-19 10:35:51'),
(63,	16,	'text_buyer_message',	1,	'2024-04-19 10:35:51'),
(64,	16,	'text_seller_message',	1,	'2024-04-19 10:35:51');

DROP TABLE IF EXISTS `users_tokens`;
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


DROP TABLE IF EXISTS `users_wishlist`;
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


-- 2024-04-20 06:47:20
