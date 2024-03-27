ALTER TABLE `colours`
ADD `title` varchar(255) NOT NULL AFTER `id`;
ALTER TABLE `colours`
ADD `slug` varchar(255) NOT NULL AFTER `id`;
ALTER TABLE `users`
ADD `session_keys` text COLLATE 'utf8mb3_general_ci' NULL AFTER `google_email`;