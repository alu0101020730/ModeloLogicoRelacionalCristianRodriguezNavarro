-- MySQL Script generated by MySQL Workbench
-- Tue Nov 10 16:25:06 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZONA` (
  `NUMERO_ZONA` INT NOT NULL,
  `AREA` INT NULL,
  `VIVERO_UBICACION` INT NOT NULL,
  PRIMARY KEY (`NUMERO_ZONA`, `VIVERO_UBICACION`),
  INDEX `fk_ZONA_VIVERO1_idx` (`VIVERO_UBICACION` ASC) VISIBLE,
  CONSTRAINT `fk_ZONA_VIVERO1`
    FOREIGN KEY (`VIVERO_UBICACION`)
    REFERENCES `mydb`.`VIVERO` (`UBICACION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VIVERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VIVERO` (
  `UBICACION` INT NOT NULL,
  `HORA_APERTURA` TIME NULL,
  `HORA_CIERRE` TIME NULL,
  `NUMERO_ZONA` INT NOT NULL,
  PRIMARY KEY (`UBICACION`),
  INDEX `NUMERO_ZONA_idx` (`NUMERO_ZONA` ASC) VISIBLE,
  CONSTRAINT `NUMERO_ZONA`
    FOREIGN KEY (`NUMERO_ZONA`)
    REFERENCES `mydb`.`ZONA` (`NUMERO_ZONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO` (
  `COD.BARRAS` INT NOT NULL,
  `PRECIO` VARCHAR(45) NULL,
  `PRODUCTOcol` VARCHAR(45) NULL,
  `NUMERO_ZONA` INT NOT NULL,
  PRIMARY KEY (`COD.BARRAS`),
  INDEX `NUMERO_ZONA_idx` (`NUMERO_ZONA` ASC) VISIBLE,
  CONSTRAINT `NUMERO_ZONA`
    FOREIGN KEY (`NUMERO_ZONA`)
    REFERENCES `mydb`.`ZONA` (`NUMERO_ZONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table4`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table4` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table5`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table5` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE` (
  `DNI` INT NOT NULL,
  `CUENTA FIDELIZACION` VARCHAR(2) NULL,
  `ID_PEDIDO_ACTIVO` INT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `ID_PEDIDO_ACTIVO_idx` (`ID_PEDIDO_ACTIVO` ASC) VISIBLE,
  CONSTRAINT `ID_PEDIDO_ACTIVO`
    FOREIGN KEY (`ID_PEDIDO_ACTIVO`)
    REFERENCES `mydb`.`PEDIDO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEADO` (
  `DNI` INT NOT NULL,
  `COD.SEGURIDAD_SOCIAL` VARCHAR(45) NOT NULL,
  `TIPO_CONTRATO` VARCHAR(45) NULL,
  `NOMBRE` VARCHAR(45) NULL,
  `FECHA_INI` DATE NULL,
  `FECHA_FIN` DATE NULL,
  `NUMERO_ZONA` INT NOT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `NUMERO_ZONA_idx` (`NUMERO_ZONA` ASC) VISIBLE,
  CONSTRAINT `NUMERO_ZONA`
    FOREIGN KEY (`NUMERO_ZONA`)
    REFERENCES `mydb`.`ZONA` (`NUMERO_ZONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEDIDO` (
  `ID` INT NOT NULL,
  `FECHA` DATE NULL,
  `ID_PRODUCTO` INT NOT NULL,
  `CANTIDAD` INT NULL,
  `CLIENTE_DNI` INT NOT NULL,
  `EMPLEADO_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `ID_PRODUCTO`, `CLIENTE_DNI`, `EMPLEADO_DNI`),
  INDEX `ID_PRODUCTO_idx` (`ID_PRODUCTO` ASC) VISIBLE,
  INDEX `fk_PEDIDO_CLIENTE1_idx` (`CLIENTE_DNI` ASC) VISIBLE,
  INDEX `fk_PEDIDO_EMPLEADO1_idx` (`EMPLEADO_DNI` ASC) VISIBLE,
  CONSTRAINT `ID_PRODUCTO`
    FOREIGN KEY (`ID_PRODUCTO`)
    REFERENCES `mydb`.`PRODUCTO` (`COD.BARRAS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_DNI`)
    REFERENCES `mydb`.`CLIENTE` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_DNI`)
    REFERENCES `mydb`.`EMPLEADO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLEADO_has_ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEADO_has_ZONA` (
  `EMPLEADO_DNI` INT NOT NULL,
  `ZONA_NUMERO_ZONA` INT NOT NULL,
  `ZONA_VIVERO_UBICACION` INT NOT NULL,
  PRIMARY KEY (`EMPLEADO_DNI`, `ZONA_NUMERO_ZONA`, `ZONA_VIVERO_UBICACION`),
  INDEX `fk_EMPLEADO_has_ZONA_ZONA1_idx` (`ZONA_NUMERO_ZONA` ASC, `ZONA_VIVERO_UBICACION` ASC) VISIBLE,
  INDEX `fk_EMPLEADO_has_ZONA_EMPLEADO1_idx` (`EMPLEADO_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEADO_has_ZONA_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_DNI`)
    REFERENCES `mydb`.`EMPLEADO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_has_ZONA_ZONA1`
    FOREIGN KEY (`ZONA_NUMERO_ZONA` , `ZONA_VIVERO_UBICACION`)
    REFERENCES `mydb`.`ZONA` (`NUMERO_ZONA` , `VIVERO_UBICACION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ZONA_has_PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZONA_has_PRODUCTO` (
  `ZONA_NUMERO_ZONA` INT NOT NULL,
  `ZONA_VIVERO_UBICACION` INT NOT NULL,
  `PRODUCTO_COD.BARRAS` INT NOT NULL,
  PRIMARY KEY (`ZONA_NUMERO_ZONA`, `ZONA_VIVERO_UBICACION`, `PRODUCTO_COD.BARRAS`),
  INDEX `fk_ZONA_has_PRODUCTO_PRODUCTO1_idx` (`PRODUCTO_COD.BARRAS` ASC) VISIBLE,
  INDEX `fk_ZONA_has_PRODUCTO_ZONA1_idx` (`ZONA_NUMERO_ZONA` ASC, `ZONA_VIVERO_UBICACION` ASC) VISIBLE,
  CONSTRAINT `fk_ZONA_has_PRODUCTO_ZONA1`
    FOREIGN KEY (`ZONA_NUMERO_ZONA` , `ZONA_VIVERO_UBICACION`)
    REFERENCES `mydb`.`ZONA` (`NUMERO_ZONA` , `VIVERO_UBICACION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ZONA_has_PRODUCTO_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_COD.BARRAS`)
    REFERENCES `mydb`.`PRODUCTO` (`COD.BARRAS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_has_PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO_has_PEDIDO` (
  `PRODUCTO_COD.BARRAS` INT NOT NULL,
  `PEDIDO_ID` INT NOT NULL,
  `PEDIDO_ID_PRODUCTO` INT NOT NULL,
  PRIMARY KEY (`PRODUCTO_COD.BARRAS`, `PEDIDO_ID`, `PEDIDO_ID_PRODUCTO`),
  INDEX `fk_PRODUCTO_has_PEDIDO_PEDIDO1_idx` (`PEDIDO_ID` ASC, `PEDIDO_ID_PRODUCTO` ASC) VISIBLE,
  INDEX `fk_PRODUCTO_has_PEDIDO_PRODUCTO1_idx` (`PRODUCTO_COD.BARRAS` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTO_has_PEDIDO_PRODUCTO1`
    FOREIGN KEY (`PRODUCTO_COD.BARRAS`)
    REFERENCES `mydb`.`PRODUCTO` (`COD.BARRAS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTO_has_PEDIDO_PEDIDO1`
    FOREIGN KEY (`PEDIDO_ID` , `PEDIDO_ID_PRODUCTO`)
    REFERENCES `mydb`.`PEDIDO` (`ID` , `ID_PRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
