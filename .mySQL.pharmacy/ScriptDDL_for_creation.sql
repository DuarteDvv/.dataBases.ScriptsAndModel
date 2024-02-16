-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmacy` DEFAULT CHARACTER SET utf8mb3 ;
USE `pharmacy` ;

-- -----------------------------------------------------
-- Table `pharmacy`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`client` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`components`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`components` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`components` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`doctor` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`doctor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `crm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`type_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`type_product` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`type_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`product` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_type_product` INT NOT NULL,
  `designation` VARCHAR(200) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_tipo_produto_idx` (`id_type_product` ASC) VISIBLE,
  CONSTRAINT `fk_produto_tipo_produto`
    FOREIGN KEY (`id_type_product`)
    REFERENCES `pharmacy`.`type_product` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`sell`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`sell` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`sell` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_sell_idx` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_client_sell`
    FOREIGN KEY (`id_client`)
    REFERENCES `pharmacy`.`client` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`sell_has_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`sell_has_product` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`sell_has_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sell_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `how_many` INT NOT NULL,
  PRIMARY KEY (`id`, `sell_id`, `product_id`),
  INDEX `fk_sell_has_product_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_sell_has_product_sell1_idx` (`sell_id` ASC) VISIBLE,
  CONSTRAINT `fk_sell_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pharmacy`.`product` (`id`),
  CONSTRAINT `fk_sell_has_product_sell1`
    FOREIGN KEY (`sell_id`)
    REFERENCES `pharmacy`.`sell` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`doctor_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`doctor_recipe` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`doctor_recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_doctor` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `id_sell` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_doctor_recipe_idx` (`id_doctor` ASC) VISIBLE,
  INDEX `fk_sell_recipe_idx` (`id_sell` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_recipe`
    FOREIGN KEY (`id_doctor`)
    REFERENCES `pharmacy`.`doctor` (`id`),
  CONSTRAINT `fk_sell_recipe`
    FOREIGN KEY (`id_sell`)
    REFERENCES `pharmacy`.`sell_has_product` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`has_components`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`has_components` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`has_components` (
  `id_components` INT NOT NULL,
  `id_product` INT NOT NULL,
  INDEX `fk_product_components_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_components_product_idx` (`id_components` ASC) VISIBLE,
  CONSTRAINT `fk_components_product`
    FOREIGN KEY (`id_components`)
    REFERENCES `pharmacy`.`components` (`id`),
  CONSTRAINT `fk_product_components`
    FOREIGN KEY (`id_product`)
    REFERENCES `pharmacy`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`manufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`manufacturers` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`manufacturers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`has_manufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`has_manufacturers` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`has_manufacturers` (
  `id_product` INT NOT NULL,
  `id_manufacturer` INT NOT NULL,
  INDEX `fk_product_manu_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_manu_product_idx` (`id_manufacturer` ASC) VISIBLE,
  CONSTRAINT `fk_manu_product`
    FOREIGN KEY (`id_manufacturer`)
    REFERENCES `pharmacy`.`manufacturers` (`id`),
  CONSTRAINT `fk_product_manu`
    FOREIGN KEY (`id_product`)
    REFERENCES `pharmacy`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pharmacy`.`phone_number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pharmacy`.`phone_number` ;

CREATE TABLE IF NOT EXISTS `pharmacy`.`phone_number` (
  `id_client` INT NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  INDEX `fk_client_phone` (`id_client` ASC) VISIBLE,
  CONSTRAINT `fk_client_phone`
    FOREIGN KEY (`id_client`)
    REFERENCES `pharmacy`.`client` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
