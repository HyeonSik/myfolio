-- MySQL Script generated by MySQL Workbench
-- Fri Jan 23 22:14:37 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema myfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema myfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myfolio` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `myfolio` ;

-- -----------------------------------------------------
-- Table `myfolio`.`USER_TB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myfolio`.`USER_TB` (
  `USER_ID` VARCHAR(40) NOT NULL,
  `USER_NAME` VARCHAR(20) NULL,
  `USER_PW` VARCHAR(45) NOT NULL,
  `USER_CREATE_TIME` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `USER_ID_UNIQUE` (`USER_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myfolio`.`TEMPLATE_TB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myfolio`.`TEMPLATE_TB` (
  `TEMPLATE_ID` INT NOT NULL,
  `TEMPLATE_TITLE` VARCHAR(50) NOT NULL,
  `TEMPLATE_OWNER_USER_ID` VARCHAR(20) NULL,
  `TEMPLATE_DESCRIPTION` VARCHAR(200) NULL,
  PRIMARY KEY (`TEMPLATE_ID`),
  UNIQUE INDEX `TEMPLATE_ID_UNIQUE` (`TEMPLATE_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myfolio`.`PORTFOLIO_TB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myfolio`.`PORTFOLIO_TB` (
  `PORTFOLIO_ID` INT NOT NULL AUTO_INCREMENT,
  `PORTFOLIO_TITLE` VARCHAR(50) NULL,
  `PORTFOLIO_CONTENT_TAG` MEDIUMTEXT NULL,
  `TEMPLATE_ID` INT NOT NULL,
  `USER_ID` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`PORTFOLIO_ID`),
  UNIQUE INDEX `PORTFOLIO_ID_UNIQUE` (`PORTFOLIO_ID` ASC),
  INDEX `fk_PORTFOLIO_TB_TEMPLATE_TB1_idx` (`TEMPLATE_ID` ASC),
  INDEX `fk_PORTFOLIO_TB_USER_TB1_idx` (`USER_ID` ASC),
  CONSTRAINT `fk_PORTFOLIO_TB_TEMPLATE_TB1`
    FOREIGN KEY (`TEMPLATE_ID`)
    REFERENCES `myfolio`.`TEMPLATE_TB` (`TEMPLATE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PORTFOLIO_TB_USER_TB1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `myfolio`.`USER_TB` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
