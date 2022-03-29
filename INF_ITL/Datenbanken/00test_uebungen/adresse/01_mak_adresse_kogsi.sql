-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema adresse
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `adresse` ;

-- -----------------------------------------------------
-- Schema adresse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `adresse` DEFAULT CHARACTER SET utf8 ;
USE `adresse` ;

-- -----------------------------------------------------
-- Table `adresse`.`ort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`ort` (
  `ort_id` INT NOT NULL AUTO_INCREMENT,
  `ort_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ort_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`plz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`plz` (
  `plz_id` INT NOT NULL AUTO_INCREMENT,
  `ort_id` INT NULL,
  `plz_nr` INT NOT NULL,
  PRIMARY KEY (`plz_id`),
  INDEX `fk_plz_ort_idx` (`ort_id` ASC),
  CONSTRAINT `fk_plz_ort`
    FOREIGN KEY (`ort_id`)
    REFERENCES `adresse`.`ort` (`ort_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`strasse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`strasse` (
  `str_id` INT NOT NULL AUTO_INCREMENT,
  `str_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`str_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`plz_strasse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`plz_strasse` (
  `plst_id` INT NOT NULL AUTO_INCREMENT,
  `str_id` INT NOT NULL,
  `plz_id` INT NOT NULL,
  INDEX `fk_plz_has_strasse_strasse1_idx` (`str_id` ASC),
  INDEX `fk_plz_strasse_plz1_idx` (`plz_id` ASC),
  PRIMARY KEY (`plst_id`),
  CONSTRAINT `fk_plz_has_strasse_strasse1`
    FOREIGN KEY (`str_id`)
    REFERENCES `adresse`.`strasse` (`str_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plz_strasse_plz1`
    FOREIGN KEY (`plz_id`)
    REFERENCES `adresse`.`plz` (`plz_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `adresse`.`ort`
-- -----------------------------------------------------
START TRANSACTION;
USE `adresse`;
INSERT INTO `adresse`.`ort` (`ort_id`, `ort_name`) VALUES (DEFAULT, 'Linz');
INSERT INTO `adresse`.`ort` (`ort_id`, `ort_name`) VALUES (DEFAULT, 'Wien');
INSERT INTO `adresse`.`ort` (`ort_id`, `ort_name`) VALUES (DEFAULT, 'Gramastetten');
INSERT INTO `adresse`.`ort` (`ort_id`, `ort_name`) VALUES (DEFAULT, 'Salzburg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `adresse`.`plz`
-- -----------------------------------------------------
START TRANSACTION;
USE `adresse`;
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 1, 4020);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 1, 4030);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 1, 4040);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 3, 4040);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 2, 1010);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, 2, 1100);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, NULL, 4209);
INSERT INTO `adresse`.`plz` (`plz_id`, `ort_id`, `plz_nr`) VALUES (DEFAULT, NULL, 9562);

COMMIT;


-- -----------------------------------------------------
-- Data for table `adresse`.`strasse`
-- -----------------------------------------------------
START TRANSACTION;
USE `adresse`;
INSERT INTO `adresse`.`strasse` (`str_id`, `str_name`) VALUES (DEFAULT, 'Salzburger Straße');
INSERT INTO `adresse`.`strasse` (`str_id`, `str_name`) VALUES (DEFAULT, 'Stadtstraße');
INSERT INTO `adresse`.`strasse` (`str_id`, `str_name`) VALUES (DEFAULT, 'Neue Straße');

COMMIT;


-- -----------------------------------------------------
-- Data for table `adresse`.`plz_strasse`
-- -----------------------------------------------------
START TRANSACTION;
USE `adresse`;
INSERT INTO `adresse`.`plz_strasse` (`plst_id`, `str_id`, `plz_id`) VALUES (DEFAULT, 1, 1);
INSERT INTO `adresse`.`plz_strasse` (`plst_id`, `str_id`, `plz_id`) VALUES (DEFAULT, 2, 3);
INSERT INTO `adresse`.`plz_strasse` (`plst_id`, `str_id`, `plz_id`) VALUES (DEFAULT, 2, 4);
INSERT INTO `adresse`.`plz_strasse` (`plst_id`, `str_id`, `plz_id`) VALUES (DEFAULT, 1, 5);

COMMIT;

