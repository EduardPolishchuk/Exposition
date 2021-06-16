-- MySQL Script generated by MySQL Workbench
-- Wed Jun  2 03:56:27 2021
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
-- Table `mydb`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`role` ;

CREATE TABLE IF NOT EXISTS `mydb`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


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
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


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
  PRIMARY KEY (`id`),
  CHECK (max_places >= current_places)
  );


-- -----------------------------------------------------
-- Table `mydb`.`user_has_exposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_has_exposition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_has_exposition` (
  `user_id` INT NOT NULL,
  `exposition_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `exposition_id`),
  INDEX `fk_user_has_exposition_exposition1_idx` (`exposition_id` ASC) VISIBLE,
  INDEX `fk_user_has_exposition_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_exposition_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_exposition_exposition1`
    FOREIGN KEY (`exposition_id`)
    REFERENCES `mydb`.`exposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


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


-- -----------------------------------------------------
-- Table `mydb`.`exposition_description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`exposition_description` ;

CREATE TABLE IF NOT EXISTS `mydb`.`exposition_description` (
  `exposition_id` INT NOT NULL,
  `description` VARCHAR(1024) NULL,
  `image_url` VARCHAR(45) NULL,
  INDEX `fk_exposition_description_exposition1_idx` (`exposition_id` ASC) VISIBLE,
  PRIMARY KEY (`exposition_id`),
  CONSTRAINT `fk_exposition_description_exposition1`
    FOREIGN KEY (`exposition_id`)
    REFERENCES `mydb`.`exposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`canceled_exposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`canceled_exposition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`canceled_exposition` (
  `id` INT NOT NULL,
  `date` DATE NOT NULL,
  `theme` VARCHAR(255) NOT NULL,
  `price` INT UNSIGNED NOT NULL,
  `current_places` INT UNSIGNED NULL DEFAULT 0,
  `max_places` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO hall (name,places) VALUES ('RED',120);
INSERT INTO hall (name,places) VALUES ('BLUE',80);
INSERT INTO hall (name,places) VALUES ('GREEN',50);