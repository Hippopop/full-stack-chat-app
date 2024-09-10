CREATE TABLE `activities` (
	`user` varchar(256) NOT NULL,
	`socket` varchar(256),
	`is_active` boolean NOT NULL DEFAULT false,
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `activities_user` PRIMARY KEY(`user`),
	CONSTRAINT `activities_socket_unique` UNIQUE(`socket`)
);
--> statement-breakpoint
CREATE TABLE `authentication` (
	`key` int AUTO_INCREMENT NOT NULL,
	`password` text NOT NULL,
	`phone` varchar(256),
	`uuid` varchar(256) NOT NULL,
	`email` varchar(256) NOT NULL,
	`tokens` json NOT NULL DEFAULT ('[]'),
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `authentication_key` PRIMARY KEY(`key`),
	CONSTRAINT `authentication_phone_unique` UNIQUE(`phone`),
	CONSTRAINT `authentication_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `authentication_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
CREATE TABLE `connections` (
	`key` int AUTO_INCREMENT NOT NULL,
	`accept_timestamp` int,
	`to_user` varchar(256) NOT NULL,
	`from_user` varchar(256) NOT NULL,
	`connection_status` enum('requested','accepted','rejected','blocked'),
	`last_message` int,
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `connections_key` PRIMARY KEY(`key`),
	CONSTRAINT `connections_last_message_unique` UNIQUE(`last_message`),
	CONSTRAINT `connections_to_user_from_user_unique` UNIQUE(`to_user`,`from_user`),
	CONSTRAINT `unique_combination` UNIQUE(`to_user`,`from_user`)
);
--> statement-breakpoint
CREATE TABLE `medias` (
	`key` int AUTO_INCREMENT NOT NULL,
	`name` varchar(256) NOT NULL,
	`extension` varchar(50) NOT NULL,
	`message` int,
	`type` enum('profile','photo','video','voice_note') NOT NULL,
	`uuid` varchar(256) NOT NULL,
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `medias_key` PRIMARY KEY(`key`),
	CONSTRAINT `medias_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `medias_uuid_name_type_message_unique` UNIQUE(`uuid`,`name`,`type`,`message`),
	CONSTRAINT `unique_combination` UNIQUE(`uuid`,`name`,`type`,`message`)
);
--> statement-breakpoint
CREATE TABLE `messages` (
	`key` int NOT NULL,
	`text` text,
	`voice_note` varchar(256),
	`connection_ref` int NOT NULL,
	`parent` int,
	`sender` varchar(256) NOT NULL,
	`receiver` varchar(256) NOT NULL,
	`attachment` json,
	`deliver_time` int,
	`seen_time` int,
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `messages_key` PRIMARY KEY(`key`)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`uid` int AUTO_INCREMENT NOT NULL,
	`uuid` varchar(256) NOT NULL,
	`name` text NOT NULL,
	`email` varchar(256) NOT NULL,
	`photo` text,
	`birthdate` date,
	`created_at` int DEFAULT (unix_timestamp()),
	`updated_at` int,
	CONSTRAINT `users_uid` PRIMARY KEY(`uid`),
	CONSTRAINT `users_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `users_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
ALTER TABLE `activities` ADD CONSTRAINT `activities_user_authentication_uuid_fk` FOREIGN KEY (`user`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_to_user_authentication_uuid_fk` FOREIGN KEY (`to_user`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_from_user_authentication_uuid_fk` FOREIGN KEY (`from_user`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `connections` ADD CONSTRAINT `connections_last_message_messages_key_fk` FOREIGN KEY (`last_message`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `medias` ADD CONSTRAINT `medias_message_messages_key_fk` FOREIGN KEY (`message`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `medias` ADD CONSTRAINT `medias_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_connection_ref_connections_key_fk` FOREIGN KEY (`connection_ref`) REFERENCES `connections`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_parent_messages_key_fk` FOREIGN KEY (`parent`) REFERENCES `messages`(`key`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_users_uuid_fk` FOREIGN KEY (`sender`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_receiver_users_uuid_fk` FOREIGN KEY (`receiver`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_email_authentication_email_fk` FOREIGN KEY (`email`) REFERENCES `authentication`(`email`) ON DELETE no action ON UPDATE no action;