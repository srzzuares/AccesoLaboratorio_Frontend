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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`periodo` (
  `idPeriodo` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Inicio` DATE NOT NULL,
  `Fecha_Final` DATE NOT NULL,
  `Estatus` ENUM('activo', 'inactivo') NOT NULL,
  PRIMARY KEY (`idPeriodo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrera` (
  `idCarrera` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(150) NULL DEFAULT NULL,
  `Abreviatura` VARCHAR(10) NULL DEFAULT NULL,
  `Nivel` ENUM('tsu', 'ingenieria') NULL DEFAULT NULL,
  `Estatus` ENUM('activo', 'inactivo') NULL DEFAULT NULL,
  PRIMARY KEY (`idCarrera`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupos` (
  `idGrupos` INT NOT NULL AUTO_INCREMENT COMMENT 'Id generado de manera automatica en la insercion una nueva entrada',
  `Estatus` ENUM('activo', 'inactivo') NOT NULL COMMENT 'Estatus del grupo',
  `Grado` VARCHAR(2) NOT NULL COMMENT 'Grado del grupo',
  `Grupo` VARCHAR(1) NOT NULL,
  `periodo_idPeriodo` INT NOT NULL,
  `carrera_idCarrera` INT NOT NULL,
  PRIMARY KEY (`idGrupos`, `periodo_idPeriodo`, `carrera_idCarrera`),
  INDEX `fk_grupos_periodo1_idx` (`periodo_idPeriodo` ASC) VISIBLE,
  INDEX `fk_grupos_carrera1_idx` (`carrera_idCarrera` ASC) VISIBLE,
  CONSTRAINT `fk_grupos_periodo1`
    FOREIGN KEY (`periodo_idPeriodo`)
    REFERENCES `mydb`.`periodo` (`idPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_carrera1`
    FOREIGN KEY (`carrera_idCarrera`)
    REFERENCES `mydb`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`datos_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`datos_persona` (
  `idDatos_persona` INT NOT NULL AUTO_INCREMENT COMMENT 'Id generado de manera automatica en la insercion una nueva entrada',
  `Titulo_Profesional` VARCHAR(10) NULL DEFAULT NULL COMMENT 'Titulo de la persona, en caso de poseerlo',
  `Apellido_P` VARCHAR(45) NOT NULL COMMENT 'Apellido partero de la persona (Obligatorio)',
  `Apellido_M` VARCHAR(45) NOT NULL COMMENT 'Apellido materno de la persona (Opcional)',
  `Nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre/s de la persona',
  `Genero` ENUM('F', 'M') NOT NULL COMMENT 'Genero de la persona(Opcional)',
  `Fecha_Nacimiento` DATE NOT NULL,
  `Estatus` ENUM('activo', 'inactivo') NULL DEFAULT 'activo' COMMENT 'Estatus de la persona',
  `Foto` VARCHAR(45) NULL,
  PRIMARY KEY (`idDatos_persona`),
  UNIQUE INDEX `idDatos_persona_UNIQUE` (`idDatos_persona` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Datos generales de todo el personal del planel y del alumnado';


-- -----------------------------------------------------
-- Table `mydb`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumnos` (
  `idAlumnos` INT NOT NULL AUTO_INCREMENT COMMENT 'Id generado de manera automatica en la insercion una nueva entrada',
  `Matricula` VARCHAR(10) NOT NULL COMMENT 'Matricula del alumno',
  `Estatus` ENUM('activo', 'inactivo') NULL DEFAULT 'activo' COMMENT 'Estatus de la persona',
  `grupos_idGrupos` INT NOT NULL,
  `datos_persona_idDatos_persona` INT NOT NULL,
  PRIMARY KEY (`idAlumnos`, `grupos_idGrupos`, `datos_persona_idDatos_persona`),
  INDEX `fk_alumnos_grupos1_idx` (`grupos_idGrupos` ASC) VISIBLE,
  INDEX `fk_alumnos_datos_persona1_idx` (`datos_persona_idDatos_persona` ASC) VISIBLE,
  CONSTRAINT `fk_alumnos_grupos1`
    FOREIGN KEY (`grupos_idGrupos`)
    REFERENCES `mydb`.`grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumnos_datos_persona1`
    FOREIGN KEY (`datos_persona_idDatos_persona`)
    REFERENCES `mydb`.`datos_persona` (`idDatos_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Datos generales de los alumnos';


-- -----------------------------------------------------
-- Table `mydb`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personal` (
  `idPersonal` INT NOT NULL AUTO_INCREMENT,
  `Numero_Trabajador` VARCHAR(150) NOT NULL,
  `Tipo` ENUM('laboratorista', 'maestro') NOT NULL DEFAULT 'maestro',
  `Estatus` ENUM('activo', 'inactivo') NOT NULL,
  `carrera_idCarrera` INT NOT NULL,
  `datos_persona_idDatos_persona` INT NOT NULL,
  PRIMARY KEY (`idPersonal`, `carrera_idCarrera`, `datos_persona_idDatos_persona`),
  INDEX `fk_personal_carrera1_idx` (`carrera_idCarrera` ASC) VISIBLE,
  INDEX `fk_personal_datos_persona1_idx` (`datos_persona_idDatos_persona` ASC) VISIBLE,
  CONSTRAINT `fk_personal_carrera1`
    FOREIGN KEY (`carrera_idCarrera`)
    REFERENCES `mydb`.`carrera` (`idCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_datos_persona1`
    FOREIGN KEY (`datos_persona_idDatos_persona`)
    REFERENCES `mydb`.`datos_persona` (`idDatos_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`laboratorio` (
  `idLaboratorio` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Ubicacion` VARCHAR(45) NOT NULL,
  `Cantidad` VARCHAR(45) NOT NULL,
  `personal_idPersonal` INT NOT NULL,
  PRIMARY KEY (`idLaboratorio`, `personal_idPersonal`),
  INDEX `fk_laboratorio_personal1_idx` (`personal_idPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_laboratorio_personal1`
    FOREIGN KEY (`personal_idPersonal`)
    REFERENCES `mydb`.`personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`recursos_laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recursos_laboratorio` (
  `idRecursos_Laboratorio` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `No_Serie` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Estado` ENUM('activo', 'inactivo') NOT NULL,
  `laboratorio_idLaboratorio` INT NOT NULL,
  PRIMARY KEY (`idRecursos_Laboratorio`, `laboratorio_idLaboratorio`),
  INDEX `fk_recursos_laboratorio_laboratorio1_idx` (`laboratorio_idLaboratorio` ASC) VISIBLE,
  CONSTRAINT `fk_recursos_laboratorio_laboratorio1`
    FOREIGN KEY (`laboratorio_idLaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idLaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bitacora` (
  `idBitacora` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Entrada` DATE NOT NULL,
  `Fecha_Salida` DATE NOT NULL,
  `Bitacoracol` VARCHAR(45) NOT NULL,
  `personal_idPersonal` INT NOT NULL,
  `laboratorio_idLaboratorio` INT NOT NULL,
  `recursos_laboratorio_idRecursos_Laboratorio` INT NOT NULL,
  `alumnos_idAlumnos` INT NOT NULL,
  PRIMARY KEY (`idBitacora`, `personal_idPersonal`, `laboratorio_idLaboratorio`, `recursos_laboratorio_idRecursos_Laboratorio`, `alumnos_idAlumnos`),
  INDEX `fk_bitacora_personal1_idx` (`personal_idPersonal` ASC) VISIBLE,
  INDEX `fk_bitacora_laboratorio1_idx` (`laboratorio_idLaboratorio` ASC) VISIBLE,
  INDEX `fk_bitacora_recursos_laboratorio1_idx` (`recursos_laboratorio_idRecursos_Laboratorio` ASC) VISIBLE,
  INDEX `fk_bitacora_alumnos1_idx` (`alumnos_idAlumnos` ASC) VISIBLE,
  CONSTRAINT `fk_bitacora_personal1`
    FOREIGN KEY (`personal_idPersonal`)
    REFERENCES `mydb`.`personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacora_laboratorio1`
    FOREIGN KEY (`laboratorio_idLaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idLaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacora_recursos_laboratorio1`
    FOREIGN KEY (`recursos_laboratorio_idRecursos_Laboratorio`)
    REFERENCES `mydb`.`recursos_laboratorio` (`idRecursos_Laboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bitacora_alumnos1`
    FOREIGN KEY (`alumnos_idAlumnos`)
    REFERENCES `mydb`.`alumnos` (`idAlumnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clases` (
  `idClases` INT NOT NULL AUTO_INCREMENT,
  `Dia` ENUM('lunes', 'martes', 'miercoles', 'viernes', 'sabado') NULL DEFAULT NULL,
  `Hora_Inicio` DATE NULL DEFAULT NULL,
  `Hora_Final` DATE NULL DEFAULT NULL,
  `Actividad` VARCHAR(45) NULL DEFAULT NULL,
  `Materia` VARCHAR(45) NULL DEFAULT NULL,
  `Estatus` ENUM('activo', 'inactivo') NULL DEFAULT NULL,
  `periodo_idPeriodo` INT NOT NULL,
  `grupos_idGrupos` INT NOT NULL,
  `personal_idPersonal` INT NOT NULL,
  `laboratorio_idLaboratorio` INT NOT NULL,
  PRIMARY KEY (`idClases`, `periodo_idPeriodo`, `grupos_idGrupos`, `personal_idPersonal`, `laboratorio_idLaboratorio`),
  INDEX `fk_clases_periodo1_idx` (`periodo_idPeriodo` ASC) VISIBLE,
  INDEX `fk_clases_grupos1_idx` (`grupos_idGrupos` ASC) VISIBLE,
  INDEX `fk_clases_personal1_idx` (`personal_idPersonal` ASC) VISIBLE,
  INDEX `fk_clases_laboratorio1_idx` (`laboratorio_idLaboratorio` ASC) VISIBLE,
  CONSTRAINT `fk_clases_periodo1`
    FOREIGN KEY (`periodo_idPeriodo`)
    REFERENCES `mydb`.`periodo` (`idPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clases_grupos1`
    FOREIGN KEY (`grupos_idGrupos`)
    REFERENCES `mydb`.`grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clases_personal1`
    FOREIGN KEY (`personal_idPersonal`)
    REFERENCES `mydb`.`personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clases_laboratorio1`
    FOREIGN KEY (`laboratorio_idLaboratorio`)
    REFERENCES `mydb`.`laboratorio` (`idLaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`login` (
  `idlogin` INT NOT NULL AUTO_INCREMENT,
  `nameUser` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `personal_idPersonal` INT NOT NULL,
  PRIMARY KEY (`idlogin`, `personal_idPersonal`),
  UNIQUE INDEX `id_UNIQUE` (`idlogin` ASC) VISIBLE,
  UNIQUE INDEX `nameUser_UNIQUE` (`nameUser` ASC) VISIBLE,
  INDEX `fk_login_personal_idx` (`personal_idPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_login_personal`
    FOREIGN KEY (`personal_idPersonal`)
    REFERENCES `mydb`.`personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
