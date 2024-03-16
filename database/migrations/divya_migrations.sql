ALTER TABLE `products`
ADD `color_id` int NULL AFTER `user_id`,
ADD FOREIGN KEY (`color_id`) REFERENCES `colours` (`id`) ON DELETE SET NULL;
ALTER TABLE `products`
ADD `gender` enum('Male','Female','Unisex') COLLATE 'utf8mb4_general_ci' NULL AFTER `color_id`;