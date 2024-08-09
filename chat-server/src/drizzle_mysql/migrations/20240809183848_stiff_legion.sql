CREATE TABLE `activities` (
	`user` varchar(256) NOT NULL,
	`is_active` boolean NOT NULL,
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `activities_user_unique` UNIQUE(`user`)
);
--> statement-breakpoint
CREATE TABLE `authentication` (
	`key` int AUTO_INCREMENT NOT NULL,
	`password` text NOT NULL,
	`phone` varchar(256),
	`uuid` varchar(256) NOT NULL,
	`email` varchar(256) NOT NULL,
	`tokens` json NOT NULL DEFAULT ('[]'),
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `authentication_key` PRIMARY KEY(`key`),
	CONSTRAINT `authentication_phone_unique` UNIQUE(`phone`),
	CONSTRAINT `authentication_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `authentication_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
CREATE TABLE `connections` (
	`key` int AUTO_INCREMENT NOT NULL,
	`user_one` varchar(256) NOT NULL,
	`user_two` varchar(256) NOT NULL,
	`last_message` varchar(256),
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `connections_key` PRIMARY KEY(`key`),
	CONSTRAINT `connections_last_message_unique` UNIQUE(`last_message`),
	CONSTRAINT `connections_user_one_user_two_unique` UNIQUE(`user_one`,`user_two`),
	CONSTRAINT `unique_combination` UNIQUE(`user_one`,`user_two`)
);
--> statement-breakpoint
CREATE TABLE `medias` (
	`key` int AUTO_INCREMENT NOT NULL,
	`name` varchar(256) NOT NULL,
	`extension` varchar(50) NOT NULL,
	`message` varchar(256),
	`type` enum('profile','photo','video','voice_note') NOT NULL,
	`uuid` varchar(256) NOT NULL,
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `medias_key` PRIMARY KEY(`key`),
	CONSTRAINT `medias_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `medias_uuid_name_type_message_unique` UNIQUE(`uuid`,`name`,`type`,`message`),
	CONSTRAINT `unique_combination` UNIQUE(`uuid`,`name`,`type`,`message`)
);
--> statement-breakpoint
CREATE TABLE `messages` (
	`key` varchar(256) NOT NULL,
	`text` text,
	`voice_note` varchar(256),
	`parent` varchar(256),
	`sender` varchar(256) NOT NULL,
	`receiver` varchar(256) NOT NULL,
	`attachment` json,
	`deliver_time` timestamp,
	`seen_time` timestamp,
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `messages_key_unique` UNIQUE(`key`)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`uid` int AUTO_INCREMENT NOT NULL,
	`uuid` varchar(256) NOT NULL,
	`name` text NOT NULL,
	`email` varchar(256) NOT NULL,
	`photo` text,
	`birthdate` date,
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	CONSTRAINT `users_uid` PRIMARY KEY(`uid`),
	CONSTRAINT `users_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `users_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
ALTER TABLE `activities` ADD CONSTRAINT `activities_user_authentication_uuid_fk` FOREIGN KEY (`user`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_user_one_authentication_uuid_fk` FOREIGN KEY (`user_one`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_user_two_authentication_uuid_fk` FOREIGN KEY (`user_two`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_last_message_messages_key_fk` FOREIGN KEY (`last_message`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `medias` ADD CONSTRAINT `medias_message_messages_key_fk` FOREIGN KEY (`message`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `medias` ADD CONSTRAINT `medias_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_parent_messages_key_fk` FOREIGN KEY (`parent`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_users_uuid_fk` FOREIGN KEY (`sender`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_receiver_users_uuid_fk` FOREIGN KEY (`receiver`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_email_authentication_email_fk` FOREIGN KEY (`email`) REFERENCES `authentication`(`email`) ON DELETE no action ON UPDATE no action;