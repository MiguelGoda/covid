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
-- Table `covid`.`tipo_registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`tipo_registro` (
  `id_tipo_registro` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_registro` VARCHAR(45) NULL,
  `descripcion_tipo_registro` VARCHAR(200) NULL,
  PRIMARY KEY (`id_tipo_registro`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `covid`.`nivel_enfermedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`nivel_enfermedad` (
  `id_nivel_enfermedad` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_nivel_enfermedad` VARCHAR(45) NULL,
  `descripcion_nivel_enfermedad` VARCHAR(200) NULL,
  PRIMARY KEY (`id_nivel_enfermedad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`sintomas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`sintomas` (
  `id_sintomas` INT(11) NOT NULL AUTO_INCREMENT,
  `id_persona` INT(11) DEFAULT NULL,
  `dolor _cabeza` TINYINT NOT NULL DEFAULT 1,
  `estornudos` TINYINT NOT NULL DEFAULT 1,
  `fiebre` TINYINT NOT NULL DEFAULT 1,
  `fatiga` TINYINT NOT NULL DEFAULT 1,
  `tos_seca` TINYINT NOT NULL DEFAULT 1,
  `dificultad_respirar` TINYINT NOT NULL DEFAULT 1,
  `dolor_cuerpo` TINYINT NOT NULL DEFAULT 1,
  `sin_olores` TINYINT NOT NULL DEFAULT 1,
  `dolor_garganta` TINYINT NOT NULL DEFAULT 1,
  `embarazo` TINYINT NOT NULL DEFAULT 1,
  `alergias` VARCHAR(200) NULL,
  PRIMARY KEY (`id_sintomas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`usuarios` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_usuario` INT(11) unsigned DEFAULT NULL,
  `id_persona` INT(11) unsigned DEFAULT NULL,
  `username` VARCHAR(45) NOT NULL,
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
-- Table `covid`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`registro` (
  `id_registro` INT(11) NOT NULL AUTO_INCREMENT,
  `id_sintomas` INT(11)  DEFAULT NULL,
  `id_usuario` INT(11) DEFAULT NULL,
  `id_persona` INT(11) DEFAULT NULL,
  `id_nivel_enfermedad` INT(11) DEFAULT NULL,
  `tipo_registro` INT(11) DEFAULT NULL,
  `id_distrito` INT(11) DEFAULT  NULL,
  `fecha_registro` TIMESTAMP NULL DEFAULT current_timestamp,
  `observaciones` VARCHAR(500) NULL,
  PRIMARY KEY (`id_registro`))
ENGINE = InnoDB;



SELECT tipo_persona.id_tipo_persona, tipo_persona.nombre_tipo_persona, P.id_persona , CONCAT(P.nombre, ' ', P.ap_paterno, ' ', P.ap_materno) as nombre_completo  FROM tipo_persona RIGHT JOIN persona P ON tipo_persona.id_tipo_persona = P.id_tipo_persona where P.id_tipo_persona = 2 ;

insert into usuarios values ( null, 2, 'goda', 'asd', 17);

select * from usuarios;

truncate usuarios;

describe usuarios;

alter table usuarios add id_persona int(11) ;

ALTER TABLE usuarios modify `password` varchar(250);

