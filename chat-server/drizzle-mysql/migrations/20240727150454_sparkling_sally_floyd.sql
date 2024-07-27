CREATE TABLE `authentication` (
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	`password` text NOT NULL,
	`key` int AUTO_INCREMENT NOT NULL,
	`phone` varchar(256),
	`uuid` varchar(256) NOT NULL,
	`email` varchar(256) NOT NULL,
	`tokens` json NOT NULL DEFAULT ('[]'),
	CONSTRAINT `authentication_key` PRIMARY KEY(`key`),
	CONSTRAINT `authentication_phone_unique` UNIQUE(`phone`),
	CONSTRAINT `authentication_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `authentication_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
CREATE TABLE `messages` (
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	`text` text,
	`seen_time` timestamp,
	`deliver_time` timestamp,
	`voice_note` varchar(256),
	`attachment` json,
	`uuid` varchar(256) NOT NULL,
	`sender` varchar(256) NOT NULL,
	`receiver` varchar(256) NOT NULL,
	`parent` varchar(256),
	CONSTRAINT `messages_uuid_unique` UNIQUE(`uuid`)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`created_at` timestamp DEFAULT (now()),
	`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3),
	`photo` text,
	`name` text NOT NULL,
	`birthdate` date,
	`uid` int AUTO_INCREMENT NOT NULL,
	`uuid` varchar(256) NOT NULL,
	`email` varchar(256) NOT NULL,
	CONSTRAINT `users_uid` PRIMARY KEY(`uid`),
	CONSTRAINT `users_uuid_unique` UNIQUE(`uuid`),
	CONSTRAINT `users_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_users_uuid_fk` FOREIGN KEY (`sender`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_receiver_users_uuid_fk` FOREIGN KEY (`receiver`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_parent_messages_uuid_fk` FOREIGN KEY (`parent`) REFERENCES `messages`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_email_authentication_email_fk` FOREIGN KEY (`email`) REFERENCES `authentication`(`email`) ON DELETE no action ON UPDATE no action;