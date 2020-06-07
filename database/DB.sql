-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema covid
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema covid
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `covid` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `covid` ;

-- -----------------------------------------------------
-- Table `covid`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`persona` (
  `id_persona` INT(11) NOT NULL,
  `ap_paterno` VARCHAR(45) NOT NULL,
  `ap_materno` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `CI` VARCHAR(15) NOT NULL,
  `celular` INT(8) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL DEFAULT 'M F',
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `CI_UNIQUE` (`CI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`sintomas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`sintomas` (
  `id_sintomas` INT(11) NOT NULL,
  `fiebre` TINYINT NOT NULL DEFAULT 1,
  `dolor _cabeza` TINYINT NOT NULL DEFAULT 1,
  `tos_seca` TINYINT NOT NULL DEFAULT 1,
  `dolor_garganta` TINYINT NOT NULL DEFAULT 1,
  `dificultad_respirar` TINYINT NOT NULL DEFAULT 1,
  `dolor_cuerpo` TINYINT NOT NULL DEFAULT 1,
  `embarazo` TINYINT NOT NULL DEFAULT 1,
  `alergias` VARCHAR(200) NULL,
  `fecha_sintomas` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `persona_id_persona` INT(11) NOT NULL,
  PRIMARY KEY (`id_sintomas`, `persona_id_persona`),
  INDEX `fk_sintomas_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  CONSTRAINT `fk_sintomas_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `covid`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`usuarios` (
  `id_usuario` INT(11) NOT NULL,
  `ap_pa_us` VARCHAR(45) NOT NULL,
  `ap_ma_us` VARCHAR(45) NOT NULL,
  `nombre_us` VARCHAR(45) NOT NULL,
  `CI` VARCHAR(45) NOT NULL,
  `cel` VARCHAR(45) NOT NULL,
  `nick` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `CI_UNIQUE` (`CI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`categoria` (
  `id_categoria` INT(11) NOT NULL,
  `nombre_categoria` VARCHAR(45) NULL,
  `descripcion_categoria` VARCHAR(200) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`llamada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`llamada` (
  `id_llamada` INT(11) NOT NULL,
  `fecha_llamada` TIMESTAMP NOT NULL,
  `categoria_id_categoria` INT(11) NOT NULL,
  `persona_id_persona` INT(11) NOT NULL,
  `usuarios_id_usuario` INT(11) NOT NULL,
  `cantidad_familia` INT(11) NOT NULL,
  `sintomas_id_sintomas` INT(11) NOT NULL,
  PRIMARY KEY (`id_llamada`, `categoria_id_categoria`, `persona_id_persona`, `usuarios_id_usuario`, `sintomas_id_sintomas`),
  INDEX `fk_llamada_categoria1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  INDEX `fk_llamada_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  INDEX `fk_llamada_usuarios1_idx` (`usuarios_id_usuario` ASC) VISIBLE,
  INDEX `fk_llamada_sintomas1_idx` (`sintomas_id_sintomas` ASC) VISIBLE,
  CONSTRAINT `fk_llamada_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `covid`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_llamada_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `covid`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_llamada_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `covid`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_llamada_sintomas1`
    FOREIGN KEY (`sintomas_id_sintomas`)
    REFERENCES `covid`.`sintomas` (`id_sintomas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`distritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`distritos` (
  `id_distrito` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_distrito` VARCHAR(45) NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  PRIMARY KEY (`id_distrito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`control`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`control` (
  `id_control` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_control` TIMESTAMP NULL DEFAULT current_timestamp,
  `persona_id_persona` INT(11) NOT NULL,
  `usuarios_id_usuario` INT(11) NOT NULL,
  `categoria_id_categoria` INT(11) NOT NULL,
  `distritos_id_distrito` INT(11) NOT NULL,
  PRIMARY KEY (`id_control`, `persona_id_persona`, `usuarios_id_usuario`, `categoria_id_categoria`, `distritos_id_distrito`),
  INDEX `fk_control_persona1_idx` (`persona_id_persona` ASC) VISIBLE,
  INDEX `fk_control_usuarios1_idx` (`usuarios_id_usuario` ASC) VISIBLE,
  INDEX `fk_control_categoria1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  INDEX `fk_control_distritos1_idx` (`distritos_id_distrito` ASC) VISIBLE,
  CONSTRAINT `fk_control_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `covid`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `covid`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `covid`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_distritos1`
    FOREIGN KEY (`distritos_id_distrito`)
    REFERENCES `covid`.`distritos` (`id_distrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
