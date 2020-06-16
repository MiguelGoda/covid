-- -----------------------------------------------------
-- Schema covid
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `covid` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `covid` ;

-- -----------------------------------------------------
-- Table `covid`.`tipo_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`tipo_persona` (
  `id_tipo_persona` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_persona` VARCHAR(45) NULL,
  `descripcion_tipo_persona` VARCHAR(200) NULL,
  PRIMARY KEY (`id_tipo_persona`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `covid`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`tipo_usuario` (
  `id_tipo_usuario` INT(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_tipo_usuario` VARCHAR(45) NULL,
  `descripcion_tipo_usuario` VARCHAR(200) NULL,
  PRIMARY KEY (`id_tipo_usuario`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `covid`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`categoria` (
  `id_categoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NULL,
  `descripcion_categoria` VARCHAR(200) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `covid`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`persona` (
  `id_persona` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_persona` INT(11) unsigned DEFAULT NULL,
  `ap_paterno` VARCHAR(100) NOT NULL,
  `ap_materno` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `CI` VARCHAR(15) NOT NULL,
  `celular` INT(8) NOT NULL,
  `domicilio` VARCHAR(500) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL DEFAULT 'M F',
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `CI_UNIQUE` (`CI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`tipo_control`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`tipo_control` (
  `id_tipo_control` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_control` VARCHAR(45) NULL,
  `descripcion_tipo_control` VARCHAR(200) NULL,
  PRIMARY KEY (`id_tipo_control`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `covid`.`categoria_control`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`categoria_control` (
  `id_categoria_control` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria_control` VARCHAR(45) NULL,
  `descripcion_categoria_control` VARCHAR(200) NULL,
  PRIMARY KEY (`id_categoria_control`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`sintomas`
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `covid`.`sintomas` (
--   `id_sintomas` INT(11) NOT NULL AUTO_INCREMENT,
--   `fiebre` TINYINT NOT NULL DEFAULT 1,
--   `dolor _cabeza` TINYINT NOT NULL DEFAULT 1,
--   `tos_seca` TINYINT NOT NULL DEFAULT 1,
--   `dolor_garganta` TINYINT NOT NULL DEFAULT 1,
--   `dificultad_respirar` TINYINT NOT NULL DEFAULT 1,
--   `dolor_cuerpo` TINYINT NOT NULL DEFAULT 1,
--   `embarazo` TINYINT NOT NULL DEFAULT 1,
--   `alergias` VARCHAR(200) NULL,
--   PRIMARY KEY (`id_sintomas`))
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`usuarios` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_usuario` INT(11) unsigned DEFAULT NULL,
  `nick` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`distritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`distritos` (
  `id_distrito` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) DEFAULT NULL,
  `nombre_distritos` VARCHAR(100) NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  PRIMARY KEY (`id_distrito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`control`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`control` (
  `id_control` INT(11) NOT NULL AUTO_INCREMENT,
  `id_sintomas` INT(11)  DEFAULT NULL,
  `id_usuario` INT(11) DEFAULT NULL,
  `id_persona` INT(11) DEFAULT NULL,
  `id_categoria_control` INT(11) DEFAULT NULL,
  `tipo_control` INT(11) DEFAULT NULL,
  `id_distrito` INT(11) DEFAULT  NULL,
  `fecha_control` TIMESTAMP NULL DEFAULT current_timestamp,
  `observaciones` VARCHAR(500) NULL,
  `fiebre` TINYINT NOT NULL DEFAULT 1,
  `dolor _cabeza` TINYINT NOT NULL DEFAULT 1,
  `tos_seca` TINYINT NOT NULL DEFAULT 1,
  `dolor_garganta` TINYINT NOT NULL DEFAULT 1,
  `dificultad_respirar` TINYINT NOT NULL DEFAULT 1,
  `dolor_cuerpo` TINYINT NOT NULL DEFAULT 1,
  `embarazo` TINYINT NOT NULL DEFAULT 1,
  `alergias` VARCHAR(200) NULL,
  PRIMARY KEY (`id_control`))
ENGINE = InnoDB;

