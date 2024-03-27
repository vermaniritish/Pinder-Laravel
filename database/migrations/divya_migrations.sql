ALTER TABLE `colours`
ADD `title` varchar(255) NOT NULL AFTER `id`;
ALTER TABLE `colours`
ADD `slug` varchar(255) NOT NULL AFTER `id`;