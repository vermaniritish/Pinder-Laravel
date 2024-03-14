ALTER TABLE `order_status_history`
ADD `staff_id` int NULL AFTER `status`,
ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;
ALTER TABLE `order_status_history`
ADD `old_value` int NULL AFTER `staff_id`,
ADD `new_value` tinytext COLLATE 'utf8mb4_general_ci' NULL AFTER `old_value`,
ADD `field` tinytext COLLATE 'utf8mb4_general_ci' NULL AFTER `new_value`;

ALTER TABLE `order_products`
ADD `updated_at` datetime NULL ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE `order_products`
CHANGE `created` `created_at` datetime NULL ON UPDATE CURRENT_TIMESTAMP AFTER `deleted_at`;

--today
ALTER TABLE `order_products`
CHANGE `created_at` `created_at` timestamp NULL ON UPDATE CURRENT_TIMESTAMP AFTER `deleted_at`,
CHANGE `updated_at` `updated_at` timestamp NULL AFTER `created_at`;