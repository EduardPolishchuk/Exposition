-- MySQL Script generated by MySQL Workbench
-- Tue Jun 22 17:28:13 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `balance` DECIMAL(65) UNSIGNED NULL DEFAULT 0,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`hall` ;

CREATE TABLE IF NOT EXISTS `mydb`.`hall` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `places` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`exposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`exposition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`exposition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `theme` VARCHAR(255) NOT NULL,
  `price` INT UNSIGNED NOT NULL,
  `current_places` INT UNSIGNED NULL DEFAULT 0,
  `max_places` INT UNSIGNED NOT NULL,
  `theme_uk` VARCHAR(255) NOT NULL,
  `description` VARCHAR(1024) NULL,
  `description_uk` VARCHAR(1024) NULL,
  `image_url` VARCHAR(1024) NULL,
  `is_canceled` BOOLEAN DEFAULT 0,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`exposition_has_hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`exposition_has_hall` ;

CREATE TABLE IF NOT EXISTS `mydb`.`exposition_has_hall` (
  `exposition_id` INT NOT NULL,
  `hall_id` INT NOT NULL,
  `date` DATE NULL,
  INDEX `fk_exposition_has_hall_hall1_idx` (`hall_id` ASC) VISIBLE,
  INDEX `fk_exposition_has_hall_exposition1_idx` (`exposition_id` ASC) VISIBLE,
  PRIMARY KEY (`hall_id`, `exposition_id`),
  CONSTRAINT `fk_exposition_has_hall_exposition1`
    FOREIGN KEY (`exposition_id`)
    REFERENCES `mydb`.`exposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exposition_has_hall_hall1`
    FOREIGN KEY (`hall_id`)
    REFERENCES `mydb`.`hall` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	UNIQUE (hall_id, date)
	);


DROP TABLE IF EXISTS `mydb`.`user_has_exposition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_has_exposition` (
  `user_id` INT NOT NULL,
  `exposition_id` INT NOT NULL,
  `tickets_count` INT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`, `exposition_id`),
  INDEX `fk_user_has_exposition1_exposition1_idx` (`exposition_id` ASC) VISIBLE,
  INDEX `fk_user_has_exposition1_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_exposition1_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_exposition1_exposition1`
    FOREIGN KEY (`exposition_id`)
    REFERENCES `mydb`.`exposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO hall (id,name,places) VALUES (1,'RED',120);
INSERT INTO hall (id,name,places) VALUES (2,'BLUE',80);
INSERT INTO hall (id,name,places) VALUES (3,'GREEN',50);

INSERT INTO exposition(date, theme, price, current_places, max_places, theme_uk, description, description_uk, image_url)
VALUES ('2021-09-09', 'Theme1', 200, 0, 250, 'Тема1', 'Description', 'Опис',
        'https://media.timeout.com/images/105775321/750/422/image.jpg'),
       ('2021-09-10', 'Theme2', 300, 0, 250, 'Тема2', 'Description', 'Опис',
        'https://www.yorkarts.org/wp-content/uploads/2020/01/raphaelexhibitoverview-1024x683.jpg'),
       ('2021-09-11', 'Theme3', 200, 0, 250, 'Тема3', 'Description', 'Опис',
        'https://lh3.ggpht.com/0dB2Ojff44mllgbLB78mrSBo6AJh4tLujPh2cJu2jDskTNDFXn2l555vafs'),
       ('2021-09-12', 'Theme4', 500, 0, 250, 'Тема4', 'Description', 'Опис',
        'https://media.timeout.com/images/105775729/750/422/image.jpg'),
       ('2021-09-13', 'Theme5', 400, 0, 250, 'Тема5', 'Description', 'Опис',
        'https://media.timeout.com/images/105775321/750/422/image.jpghttps://observer.com/wp-content/uploads/sites/2/2020/03/Screen-Shot-2020-03-13-at-2.12.14-PM.png'),
       ('2021-09-14', 'Theme6', 300, 0, 250, 'Тема6', 'Description', 'Опис',
        'https://www.yorkarts.org/wp-content/uploads/2020/01/raphaelexhibitoverview-1024x683.jpg'),
       ('2021-09-15', 'Theme7', 200, 0, 250, 'Тема1', 'Description', 'Опис',
        'https://media.timeout.com/images/105775321/750/422/image.jpg'),
       ('2021-09-16', 'Theme8', 300, 0, 250, 'Тема2', 'Description', 'Опис',
        'https://www.yorkarts.org/wp-content/uploads/2020/01/raphaelexhibitoverview-1024x683.jpg'),
       ('2021-09-17', 'Theme9', 200, 0, 250, 'Тема3', 'Description', 'Опис',
        'https://lh3.ggpht.com/0dB2Ojff44mllgbLB78mrSBo6AJh4tLujPh2cJu2jDskTNDFXn2l555vafs');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (1, 1, '2021-09-09');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (1, 2, '2021-09-09');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (1, 3, '2021-09-09');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (2, 1, '2021-09-10');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (2, 2,'2021-09-10');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (2, 3, '2021-09-10');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (3, 1, '2021-09-11');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (3, 2, '2021-09-11');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (3, 3, '2021-09-11');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (4, 1, '2021-09-12');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (4, 2, '2021-09-12');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (4, 3, '2021-09-12');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (5, 1, '2021-09-13');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (5, 2, '2021-09-13');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (5, 3, '2021-09-13');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (6, 1, '2021-09-14');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (6, 2, '2021-09-14');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (6, 3, '2021-09-14');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (7, 1, '2021-09-15');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (7, 2, '2021-09-15');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (7, 3, '2021-09-15');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (8, 1, '2021-09-16');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (8, 2, '2021-09-16');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (8, 3, '2021-09-16');

INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (9, 1, '2021-09-17');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (9, 2, '2021-09-17');
INSERT INTO exposition_has_hall(exposition_id, hall_id, date) VALUES (9, 3, '2021-09-17');


INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('admin','admin@gmail.com','1',0,'Ivanov','Ivan','admin');
INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('qwe','qwe@gmail.com','1',0,'Foster','Mary','user');
INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('qweqwe','qweqwe@gmail.com','1',0,'Williams','Bob','user');
INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('qwerty','qwerty@gmail.com','1',0,'Weaver','Roby','user');
INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('ytrewq','ytrewq@gmail.com','1',0,'Petrov','Petr','user');
INSERT INTO user(login, email, password, balance, last_name, first_name, role) VALUES ('user','user@gmail.com','1',0,'Alekseev','Aleksei','user');