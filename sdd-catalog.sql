CREATE TABLE `modules` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`module` VARCHAR(50) NOT NULL,
	`base_path` VARCHAR(50) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `operations` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(50) NOT NULL,
	`path` VARCHAR(50) NOT NULL,
	`http_method` VARCHAR(10) NOT NULL,
	`permit_all` TINYINT NOT NULL DEFAULT 0,
	`module_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `roles` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(30) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `granted_permissions` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`role_id` INTEGER NOT NULL,
	`operation_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `users` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(50) NOT NULL,
	`username` VARCHAR(50) NOT NULL UNIQUE,
	`password` VARCHAR(128) NOT NULL,
	`email` VARCHAR(255) NOT NULL UNIQUE,
	`role_id` INTEGER NOT NULL,
	`account_non_expired` TINYINT NOT NULL DEFAULT 1,
	`account_non_locked` TINYINT NOT NULL DEFAULT 1,
	`credentials_non_expired` TINYINT NOT NULL DEFAULT 1,
	`enabled` TINYINT NOT NULL DEFAULT 1,
	`color_profile` VARCHAR(7) NOT NULL,
	`is_email_valid` TINYINT NOT NULL DEFAULT 0,
	PRIMARY KEY(`id`)
);


CREATE TABLE `jwt_registers` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`user_id` INTEGER NOT NULL,
	`token_jwt` VARCHAR(2048) NOT NULL,
	`expiration` DATETIME NOT NULL,
	`enable` TINYINT NOT NULL,
	`reference_site` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `init_skids` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`skid_type` VARCHAR(45) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `street_types` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`street_type` VARCHAR(45) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `classes` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(2) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `turbo_types` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`type` VARCHAR(30) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `makers` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `levels` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`level` VARCHAR(10) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `cars` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`maker_id` INTEGER NOT NULL,
	`model` VARCHAR(50) NOT NULL,
	`car_year` VARCHAR(4) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `drivers` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`drive` INTEGER NOT NULL,
	`direction` INTEGER NOT NULL,
	`dawn_force` INTEGER NOT NULL,
	`control_traction` TINYINT NOT NULL DEFAULT 0,
	`init_skid_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `tires` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`street_type_id` INTEGER NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `suspensions` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`street_type_id` INTEGER NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `turbos` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`turbo_type_id` INTEGER NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `gears` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`gear_value` INTEGER NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `engines` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`bhp` INTEGER NOT NULL,
	`liters` DECIMAL NOT NULL,
	`model` VARCHAR(30) NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `auxiliaries` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`auxiliar` VARCHAR(50) NOT NULL,
	`level_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `car_configurations` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`card_id` INTEGER NOT NULL,
	`engine_id` INTEGER NOT NULL,
	`class_id` INTEGER NOT NULL,
	`induction_level` INTEGER NOT NULL,
	`ecu_level` INTEGER NOT NULL,
	`injection_level` INTEGER NOT NULL,
	`escape_level` INTEGER NOT NULL,
	`turbo_id` INTEGER NOT NULL,
	`nitro_level` INTEGER NOT NULL,
	`suspension_id` INTEGER NOT NULL,
	`brake_level` INTEGER NOT NULL,
	`tire_id` INTEGER NOT NULL,
	`embrague_level` INTEGER NOT NULL,
	`gear_id` INTEGER NOT NULL,
	`differential_level` INTEGER NOT NULL,
	`top_speed` INTEGER NOT NULL,
	`one_hundred` DECIMAL NOT NULL,
	`power` INTEGER NOT NULL,
	`par` INTEGER NOT NULL,
	`four_hundred` DECIMAL NOT NULL,
	`driver_id` INTEGER NOT NULL,
	`auxiliar_one` INTEGER NOT NULL,
	`auxiliar_two` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `user_car_configurations` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`user_id` INTEGER NOT NULL,
	`car_config_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `user_car_favorites` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`user_id` INTEGER NOT NULL,
	`user_car_config_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


ALTER TABLE `operations`
ADD FOREIGN KEY(`module_id`) REFERENCES `modules`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `operations`
ADD FOREIGN KEY(`id`) REFERENCES `granted_permissions`(`operation_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `granted_permissions`
ADD FOREIGN KEY(`role_id`) REFERENCES `roles`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `users`
ADD FOREIGN KEY(`role_id`) REFERENCES `roles`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `jwt_registers`
ADD FOREIGN KEY(`user_id`) REFERENCES `users`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `cars`
ADD FOREIGN KEY(`maker_id`) REFERENCES `makers`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `drivers`
ADD FOREIGN KEY(`init_skid_id`) REFERENCES `init_skids`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `tires`
ADD FOREIGN KEY(`street_type_id`) REFERENCES `street_types`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `tires`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `suspensions`
ADD FOREIGN KEY(`street_type_id`) REFERENCES `street_types`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `suspensions`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `turbos`
ADD FOREIGN KEY(`turbo_type_id`) REFERENCES `turbo_types`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `turbos`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `gears`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `engines`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `auxiliaries`
ADD FOREIGN KEY(`level_id`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`card_id`) REFERENCES `cars`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`engine_id`) REFERENCES `engines`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`class_id`) REFERENCES `classes`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`induction_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`ecu_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`injection_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`escape_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`turbo_id`) REFERENCES `turbos`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`nitro_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`suspension_id`) REFERENCES `suspensions`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`brake_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`tire_id`) REFERENCES `tires`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`embrague_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`differential_level`) REFERENCES `levels`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`auxiliar_one`) REFERENCES `auxiliaries`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`auxiliar_two`) REFERENCES `auxiliaries`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `car_configurations`
ADD FOREIGN KEY(`gear_id`) REFERENCES `gears`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `user_car_configurations`
ADD FOREIGN KEY(`user_id`) REFERENCES `users`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `user_car_favorites`
ADD FOREIGN KEY(`user_id`) REFERENCES `users`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `user_car_favorites`
ADD FOREIGN KEY(`user_car_config_id`) REFERENCES `user_car_configurations`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `user_car_configurations`
ADD FOREIGN KEY(`car_config_id`) REFERENCES `car_configurations`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;