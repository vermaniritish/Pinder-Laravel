ALTER TABLE `colours`
ADD `title` varchar(255) NOT NULL AFTER `id`;
ALTER TABLE `colours`
ADD `slug` varchar(255) NOT NULL AFTER `id`;
ALTER TABLE `users`
ADD `session_keys` text COLLATE 'utf8mb3_general_ci' NULL AFTER `google_email`;





--please run email 
INSERT INTO `email_templates` (`id`, `title`, `slug`, `type`, `subject`, `description`, `short_codes`, `created`, `modified`) VALUES
(5,	'Registration',	'registration',	'client',	'Registration Successful.',	'<p>Dear {name}<br />\r\n<br />\r\nCongratulations! You have been registered on Pinder. Please click on below link to verify your email.</p>\r\n\r\n\r\n<p><br />\r\nThanks</p>',	'{name},{email}',	'2021-03-01 12:18:13',	'2024-04-19 10:14:54'),
(6,	'Forgot Password',	'user-forgot-password',	'client',	'Forgot Password',	'<p>Dear {first_name}&nbsp;{last_name},<br />\r\n<br />\r\nPlease click on below link to reset your account password. Enter your provided OTP to recover password.<br />\r\n<br />\r\n{recovery_link}<br />\r\n<br />\r\nOTP: {otp}<br />\r\n<br />\r\n<br />\r\nThank you!</p>',	'{first_name},{last_name},{email},{recovery_link},{admin_link},{company_name}',	'2021-03-01 12:18:09',	'2024-04-19 10:57:35'),
(7,	'Thanks for contacting',	'thank-you-for-contacting',	'client',	'Thank You For Contacting Us',	'<p>Dear {first_name} {last_name},</p>\r\n\r\n<p>Thank you for contacting us! We have received your message and will get back to you as soon as possible. Your patience is highly appreciated.<br />\r\nBest regards,<br />\r\n{company_name}</p>',	NULL,	NULL,	'2024-04-21 09:08:14'),
(8,	'Contact Us Request Received',	'admin-contact-us-request-received',	'admin',	'Contact Us Request Received',	'<p>Subject: New Contact Us Request Received</p>\r\n\r\n<p>Dear Admin,</p>\r\n\r\n<p>A new contact us request has been received. Here are the details:</p>\r\n\r\n<ul>\r\n	<li>Name: {first_name} {last_name}</li>\r\n	<li>Email: {email}</li>\r\n	<li>Phone Number: {number}</li>\r\n	<li>Message: {message}</li>\r\n</ul>\r\n\r\n<p>Please take appropriate action to respond to the user&#39;s request.</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>',	NULL,	NULL,	'2024-04-21 09:10:00');