-- MySQL Workbench Forward Engineering

-- Temporarily disable unique checks and foreign key checks
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------

-- Create the 'pharmacy' schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS `pharmacy` DEFAULT CHARACTER SET utf8 ;
USE `pharmacy` ;

-- -----------------------------------------------------
-- Table 'type_product' for storing types of products
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`type_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'product' for storing information about products
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_type_product` INT NOT NULL,
  `designation` VARCHAR(200) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_type_product_idx` (`id_type_product` ASC),
  CONSTRAINT `fk_product_type_product`
    FOREIGN KEY (`id_type_product`)
    REFERENCES `pharmacy`.`type_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'components' for storing information about components
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`components` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'has_components' to represent the many-to-many relationship between products and components
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`has_components` (
  `id_components` INT NOT NULL,
  `id_product` INT NOT NULL,
  PRIMARY KEY (`id_components`, `id_product`),
  INDEX `fk_has_components_product_idx` (`id_product` ASC),
  INDEX `fk_has_components_components_idx` (`id_components` ASC),
  CONSTRAINT `fk_has_components_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `pharmacy`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_components_components`
    FOREIGN KEY (`id_components`)
    REFERENCES `pharmacy`.`components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'manufacturers' for storing information about manufacturers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`manufacturers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'has_manufacturers' to represent the many-to-many relationship between products and manufacturers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`has_manufacturers` (
  `id_product` INT NOT NULL,
  `id_manufacturer` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_manufacturer`),
  INDEX `fk_has_manufacturers_product_idx` (`id_product` ASC),
  INDEX `fk_has_manufacturers_manufacturers_idx` (`id_manufacturer` ASC),
  CONSTRAINT `fk_has_manufacturers_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `pharmacy`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_manufacturers_manufacturers`
    FOREIGN KEY (`id_manufacturer`)
    REFERENCES `pharmacy`.`manufacturers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'client' for storing information about clients
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(14) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'phone_number' for storing phone numbers associated with clients
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`phone_number` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_client`),
  CONSTRAINT `fk_phone_number_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `pharmacy`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'sell' for storing information about sales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`sell` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sell_client_idx` (`id_client` ASC),
  CONSTRAINT `fk_sell_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `pharmacy`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'sell_has_product' to represent the many-to-many relationship between sales and products
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`sell_has_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sell_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `how_many` INT NOT NULL,
  PRIMARY KEY (`id`, `sell_id`, `product_id`),
  INDEX `fk_sell_has_product_product1_idx` (`product_id` ASC),
  INDEX `fk_sell_has_product_sell1_idx` (`sell_id` ASC),
  CONSTRAINT `fk_sell_has_product_sell1`
    FOREIGN KEY (`sell_id`)
    REFERENCES `pharmacy`.`sell` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sell_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pharmacy`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'doctor' for storing information about doctors
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`doctor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `crm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table 'doctor_recipe' for storing information about doctor's prescriptions linked to sales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`doctor_recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_doctor` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `id_sell` INT NOT NULL,
  INDEX `fk_doctor_recipe_idx` (`id_doctor` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_sell_recipe_idx` (`id_sell` ASC),
  CONSTRAINT `fk_doctor_recipe`
    FOREIGN KEY (`id_doctor`)
    REFERENCES `pharmacy`.`doctor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sell_recipe`
    FOREIGN KEY (`id_sell`)
    REFERENCES `pharmacy`.`sell_has_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Restore previous SQL mode, foreign key checks, and unique checks
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

