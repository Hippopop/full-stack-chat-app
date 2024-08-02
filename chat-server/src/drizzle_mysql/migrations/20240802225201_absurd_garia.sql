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
CREATE TABLE `messages` (
	`uuid` varchar(256) NOT NULL,
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
	CONSTRAINT `messages_uuid_unique` UNIQUE(`uuid`)
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
ALTER TABLE `messages` ADD CONSTRAINT `messages_parent_messages_uuid_fk` FOREIGN KEY (`parent`) REFERENCES `messages`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_users_uuid_fk` FOREIGN KEY (`sender`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_receiver_users_uuid_fk` FOREIGN KEY (`receiver`) REFERENCES `users`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_uuid_authentication_uuid_fk` FOREIGN KEY (`uuid`) REFERENCES `authentication`(`uuid`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_email_authentication_email_fk` FOREIGN KEY (`email`) REFERENCES `authentication`(`email`) ON DELETE no action ON UPDATE no action;