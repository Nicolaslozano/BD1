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
-- -----------------------------------------------------
-- Schema terminalautomotriz
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provedor` (
  `idProvedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Provedor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Insumo` (
  `idInsumo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`idInsumo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InsumoXProvedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InsumoXProvedor` (
  `Insumo_idInsumo` INT NOT NULL,
  `Provedor_idProvedor` INT NOT NULL,
  INDEX `fk_InsumoXProvedor_Insumo1_idx` (`Insumo_idInsumo` ASC) VISIBLE,
  INDEX `fk_InsumoXProvedor_Provedor1_idx` (`Provedor_idProvedor` ASC) VISIBLE,
  CONSTRAINT `fk_InsumoXProvedor_Insumo1`
    FOREIGN KEY (`Insumo_idInsumo`)
    REFERENCES `mydb`.`Insumo` (`idInsumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InsumoXProvedor_Provedor1`
    FOREIGN KEY (`Provedor_idProvedor`)
    REFERENCES `mydb`.`Provedor` (`idProvedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modelo` (
  `idModelo` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Modelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idModelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LineaMontaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LineaMontaje` (
  `idLineaMontaje` INT NOT NULL AUTO_INCREMENT,
  `Modelo_idModelo` INT NOT NULL,
  `CapacidadProduccion` INT NULL,
  PRIMARY KEY (`idLineaMontaje`),
  INDEX `fk_LineaMontaje_Modelo1_idx` (`Modelo_idModelo` ASC) VISIBLE,
  CONSTRAINT `fk_LineaMontaje_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `mydb`.`Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estacion` (
  `idEstacion` INT NOT NULL AUTO_INCREMENT,
  `LineaMontaje_idLineaMontaje` INT NOT NULL,
  `Nombre_Estacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstacion`),
  INDEX `fk_Estacion_LineaMontaje1_idx` (`LineaMontaje_idLineaMontaje` ASC) VISIBLE,
  CONSTRAINT `fk_Estacion_LineaMontaje1`
    FOREIGN KEY (`LineaMontaje_idLineaMontaje`)
    REFERENCES `mydb`.`LineaMontaje` (`idLineaMontaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InsumoxProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InsumoxProduccion` (
  `Estacion_idEstacion` INT NOT NULL,
  `Insumo_idInsumo` INT NOT NULL,
  `cantidad` INT NULL,
  INDEX `fk_InsumoxProduccion_Estacion_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  INDEX `fk_InsumoxProduccion_Insumo1_idx` (`Insumo_idInsumo` ASC) VISIBLE,
  CONSTRAINT `fk_InsumoxProduccion_Estacion`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InsumoxProduccion_Insumo1`
    FOREIGN KEY (`Insumo_idInsumo`)
    REFERENCES `mydb`.`Insumo` (`idInsumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Auto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Auto` (
  `Numero_Chasis` INT NOT NULL AUTO_INCREMENT,
  `Modelo_idModelo` INT NULL,
  `Terminado` TINYINT NULL,
  `Patente` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero_Chasis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AutoXEstacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AutoXEstacion` (
  `Estacion_idEstacion` INT NOT NULL,
  `Auto_idChasis` INT NOT NULL,
  `Fecha_ingreso` DATE NULL,
  `Fecha_salida` DATE NULL,
  INDEX `fk_AutoXEstacion_Estacion1_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  INDEX `fk_AutoXEstacion_Auto1_idx` (`Auto_idChasis` ASC) VISIBLE,
  CONSTRAINT `fk_AutoXEstacion_Estacion1`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AutoXEstacion_Auto1`
    FOREIGN KEY (`Auto_idChasis`)
    REFERENCES `mydb`.`Auto` (`Numero_Chasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Concesionaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Concesionaria` (
  `idConcesionaria` INT NOT NULL AUTO_INCREMENT,
  `nombreConcesionaria` VARCHAR(45) NULL,
  `numeroVentas` INT NULL,
  PRIMARY KEY (`idConcesionaria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `FechaEstimada` DATE NULL,
  `Concesionaria_idConcesionaria` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Concesionaria1_idx` (`Concesionaria_idConcesionaria` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Concesionaria1`
    FOREIGN KEY (`Concesionaria_idConcesionaria`)
    REFERENCES `mydb`.`Concesionaria` (`idConcesionaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DetallePedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetallePedido` (
  `Cantidad` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL AUTO_INCREMENT,
  `Modelo_idModelo` INT NOT NULL,
  INDEX `fk_DetallePedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_DetallePedido_Modelo1_idx` (`Modelo_idModelo` ASC) VISIBLE,
  CONSTRAINT `fk_DetallePedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetallePedido_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `mydb`.`Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
/* ------------------------------------------------------------------------------------------------------------------------------------ */

-- ALTA PROVEDOR
DELIMITER $$
CREATE PROCEDURE altaProvedor(IN  _Nombre_Provedor varchar(45))
BEGIN
DECLARE i INT;
DECLARE cont INT;
DECLARE flag INT;
SET flag = 0;
SET cont = (SELECT COUNT(idProvedor) FROM Provedor);
SET i = 0;
WHILE(i <= cont ) DO
      if(STRCMP(_Nombre_Provedor,(SELECT Nombre_Provedor FROM Provedor WHERE idProvedor = i)) = 0) THEN 
         CALL mensajeErrorAltas;
         SET flag = 1;
      END IF;
      SET i=i+1;
END WHILE;
IF (flag = 0) THEN INSERT INTO Provedor (Nombre_Provedor) VALUES (_Nombre_Provedor);
END IF;
END $$
DELIMITER ;

-- BAJA PROVEDOR
DELIMITER $$
CREATE PROCEDURE bajaProvedor(IN _idProvedor INT)
BEGIN
IF ((SELECT idProvedor FROM Provedor WHERE idProvedor = _idProvedor) IS NULL) THEN
    CALL MensajeErrorBajas();
END IF ;
DELETE FROM Provedor WHERE idProvedor = _idProvedor;
END $$
DELIMITER ;

-- MODIFICACION PROVEDOR
DELIMITER $$
CREATE PROCEDURE modificarProvedor(IN _idProvedor INT, IN  _Nombre_Provedor VARCHAR(45))
BEGIN
IF ((SELECT idProvedor FROM Provedor WHERE idProvedor = _idProvedor) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Provedor SET Provedor.Nombre_Provedor = _Nombre_Provedor WHERE(idProvedor=_idProvedor);
END$$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA AUTO
DELIMITER $$
CREATE PROCEDURE altaAuto ( IN _Modelo_idModelo INT)
BEGIN
DECLARE patente VARCHAR(45);
CALL Generador_patente(@patente);
INSERT INTO Auto(Modelo_idModelo,Patente,Terminado) VALUES (_Modelo_idModelo,@patente,0);
END $$
DELIMITER ;

-- BAJA AUTO
DELIMITER $$
CREATE PROCEDURE bajaAuto (IN _Numero_Chasis int)
BEGIN 
IF((SELECT Numero_Chasis FROM Auto WHERE Numero_Chasis = _Numero_Chasis) IS NULL) THEN
    CALL MensajeErrorBajas();
END IF;
DELETE FROM Auto WHERE Numero_Chasis = _Numero_Chasis;
END $$
DELIMITER ;

-- MODIFICACION AUTO
DELIMITER $$
CREATE PROCEDURE modificarAuto (IN _Numero_Chasis INT, IN _Modelo_idModelo INT, IN _Terminado TINYINT)
BEGIN
IF ((SELECT Numero_Chasis FROM Auto WHERE Numero_Chasis = _Numero_Chasis) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Auto SET Auto.Numero_Chasis = _Numero_Chasis WHERE (Numero_Chasis = _Numero_Chasis);
UPDATE Auto SET Auto.Modelo_idModelo = _Modelo_idModelo WHERE (Numero_Chasis = _Numero_Chasis);
UPDATE Auto SET Auto.Terminado = _Terminado WHERE (Numero_Chasis = _Numero_Chasis);
END $$
DELIMITER ;

--                                         ---------------------------------------------------                               


-- ALTA INSUMO
DELIMITER $$
CREATE PROCEDURE altaInsumo(IN  _descripcion VARCHAR(45), _precio INT)
BEGIN
DECLARE i INT;
DECLARE cont INT;
DECLARE flag INT;
SET flag = 0;
SET cont = (SELECT COUNT(idInsumo) FROM Insumo);
SET i = 0;

while(i <= cont ) DO
      IF(strcmp(_descripcion,(Select descripcion from Insumo where idInsumo = i)) = 0) THEN 
         CALL mensajeErrorAltas;
         SET flag = 1;
      END IF;
      SET i=i+1;
END while;
IF (flag = 0) THEN INSERT INTO Insumo (descripcion,precio ) VALUES (_descripcion,_precio);
END IF;
END $$
DELIMITER ;

-- BAJA INSUMO
DELIMITER $$
CREATE PROCEDURE bajaInsumo(IN _idInsumo INT)
BEGIN
IF ((SELECT idInsumo FROM Insumo WHERE idInsumo = _idInsumo) IS NULL) THEN
    CALL MensajeErrorBajas;
END IF;
DELETE FROM Insumo WHERE idInsumo = _idInsumo;
END $$
DELIMITER ;

-- MODIFICACION INSUMO
DELIMITER $$
CREATE PROCEDURE modificarInsumo(IN _idInsumo INT, IN  _descripcion VARCHAR(45),IN _precio INT)
BEGIN
IF ((SELECT idInsumo FROM Insumo WHERE idInsumo = _idInsumo) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Insumo SET Insumo.precio = _precio WHERE (idInsumo=_idInsumo);
UPDATE Insumo SET Insumo.descripcion = _descripcion WHERE (idInsumo=_idInsumo);
END$$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA CONCESIONARIA
DELIMITER $$
CREATE PROCEDURE altaConcesionaria(IN  _nombre_concesionaria VARCHAR(45), IN _numero_ventas INT)
BEGIN
DECLARE i INT;
DECLARE cont INT;
DECLARE flag INT;

SET flag = 0;
SET cont = (SELECT COUNT(idConcesionaria) FROM Concesionaria);
SET i = 0;

WHILE(i <= cont ) DO
      IF(strcmp(_nombre_concesionaria,(SELECT nombreConcesionaria FROM Concesionaria WHERE idConcesionaria = i))= 0) THEN 
         CALL mensajeErrorAltas;
         SET flag = 1;
      END IF;
      set i=i+1;
END WHILE;
IF (flag = 0) THEN INSERT INTO Concesionaria (nombreConcesionaria, numeroVentas) VALUES (_Nombre_concesionaria,_numero_ventas);
END IF;
END $$
DELIMITER ;

-- BAJA CONCESIONARIA
DELIMITER $$
CREATE PROCEDURE bajaConcesionaria (IN _idConcesionaria INT)
BEGIN
IF((SELECT idConcesionaria FROM Concesionaria WHERE idConcesionaria = _idConcesionaria) IS NULL) THEN
    CALL mensajeErrorBajas;
END IF;
DELETE FROM Concesionaria WHERE Concesionaria.idConcesionaria = _idConcesionaria;
END $$
DELIMITER ;

-- MODIFICACION CONCESIONARIA
DELIMITER $$
CREATE PROCEDURE modificarConcesionaria(IN _idConcesionaria INT, IN  _nombre_concesionaria VARCHAR(45),IN _numero_ventas INT)
BEGIN
IF ((SELECT idConcesionaria FROM Concesionaria WHERE idConcesionaria = _idConcesionaria) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Concesionaria SET Concesionaria.nombreConcesionaria = _nombre_concesionaria WHERE (idConcesionaria = _idConcesionaria);
UPDATE Concesionaria SET Concesionaria.numeroVentas = _numero_ventas WHERE (idConcesionaria = _idConcesionaria);
END $$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA PEDIDO
DELIMITER $$
CREATE PROCEDURE altaPedido(IN _Concesionaria_idConcesionaria INT, IN _idModelo INT, IN _cantidad INT)
BEGIN
INSERT INTO Pedido (Concesionaria_idConcesionaria) VALUES (_Concesionaria_idConcesionaria);
CALL altaPedidoDetalle(_idModelo,_cantidad);

SET @i = 0 ;

WHILE (@i<_cantidad) DO
SET @i=@i+1;
CALL altaAuto(_idModelo);
END WHILE;

END $$
DELIMITER ;

-- BAJA PEDIDO
DELIMITER $$
CREATE PROCEDURE bajaPedido (IN _idPedido INT)
BEGIN
IF ((SELECT idPedido FROM Pedido WHERE idPedido = _idPedido) IS NULL) THEN
     CALL MensajeErrorBajas();
END IF ;
DELETE FROM Pedido WHERE idPedido = _idPedido;
END $$
DELIMITER ;


-- MODIFICACION PEDIDO
DELIMITER $$
CREATE PROCEDURE modificarPedido (IN _idPedido INT, IN _FechaEstimada DATE, IN _Consecionaria_idConsecionaria INT)
BEGIN
IF ((SELECT idPedido FROM Pedido WHERE idPedido = _idPedido) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Pedido SET FechaEstimada = _FechaEstimada WHERE (idPedido = _idPedido);
END$$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA ESTACION	
DELIMITER $$
CREATE PROCEDURE altaEstacion( IN _LineaMontaje_idLineaMontaje INT, IN _Nombre_Estacion VARCHAR(45))
BEGIN
INSERT INTO Estacion (LineaMontaje_idLineaMontaje, Nombre_Estacion) VALUES (_LineaMontaje_idLineaMontaje, _Nombre_Estacion);
END $$
DELIMITER ;

-- Baja ESTACION
DELIMITER $$
CREATE PROCEDURE bajaEstacion(IN _idEstacion INT)
BEGIN
IF ((SELECT idEstacion FROM Estacion WHERE idEstacion = _idEstacion) IS NULL) THEN
     CALL MensajeErrorBajas();
END IF ;
DELETE FROM Estacion WHERE idEstacion = _idEstacion;
END $$
DELIMITER ;

-- MODIFICACION ESTACION
DELIMITER $$
CREATE PROCEDURE modificarEstacion(IN _idEstacion INT, IN _Linea_Montaje_idLineaMontaje INT, IN _Nombre_Estacion VARCHAR(45))
BEGIN
IF ((SELECT idEstacion FROM Estacion WHERE idEstacion = _idEstacion) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Estacion SET Nombre_Estacion = _Nombre_Estacion WHERE (idEstacion = _idEstacion);
END$$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA MODELO
DELIMITER $$
CREATE PROCEDURE altaModelo(IN  _Nombre_Modelo VARCHAR(45))
BEGIN
DECLARE i INT;
DECLARE cont INT;
DECLARE flag INT;

SET flag = 0;
SET cont = (SELECT COUNT(idModelo) FROM Modelo);
SET i = 0;

WHILE(i <= cont ) DO
      if(strcmp(_Nombre_Modelo,(SELECT Nombre_Modelo FROM Modelo WHERE idModelo = i)) = 0) THEN 
         CALL mensajeErrorAltas;
         SET flag = 1;
      END IF;
      set i=i+1;
END WHILE;
IF (flag = 0) THEN INSERT INTO Modelo (Nombre_Modelo) VALUES (_Nombre_Modelo);
END IF;
END $$
DELIMITER ;

-- BAJA MODELO
DELIMITER $$
CREATE PROCEDURE bajaModelo(IN _idModelo INT)
BEGIN
IF ((SELECT idModelo FROM Modelo WHERE idModelo = _idModelo) IS NULL) THEN
     CALL MensajeErrorBajas();
END IF ;
DELETE FROM Modelo where Modelo.idModelo = _idModelo;
END $$
DELIMITER ;

-- MODIFICACION MODELO
DELIMITER $$
CREATE PROCEDURE modificarModelo(IN _idModelo INT, IN _Nombre_Modelo VARCHAR(45))
BEGIN
IF ((SELECT idModelo FROM Modelo WHERE idModelo = _idModelo) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE Modelo SET Modelo.Nombre_Modelo = _Nombre_Modelo WHERE (idModelo=_idModelo);
END $$
DELIMITER;

--                                         ---------------------------------------------------
       
-- ALTA L. DE MONTAJE
DELIMITER $$
CREATE PROCEDURE altaLineaMontaje(IN  _modelo_idModelo INT, IN _capacidad_produccion INT)
BEGIN
DECLARE i INT;
DECLARE cont INT;
DECLARE flag INT;
SET flag = 0;
SET cont = (SELECT COUNT(Modelo_idModelo) FROM LineaMontaje);
SET i = 0;
WHILE(i <= cont ) DO
      IF(_modelo_idModelo = (SELECT Modelo_idModelo FROM LineaMontaje WHERE Modelo_idModelo=i)) THEN 
         CALL mensajeErrorAltas;
         SET flag = 1;
      END IF;
      SET i=i+1;
END WHILE;
if (flag = 0) THEN INSERT INTO LineaMontaje (modelo_idModelo, CapacidadProduccion) VALUES (_modelo_idModelo,_capacidad_produccion);
END IF;
END $$
DELIMITER ;

-- BAJA L. DE MONTAJE
DELIMITER $$
CREATE PROCEDURE bajaLineaMontaje(IN _idLineaMontaje INT)
BEGIN
IF ((SELECT idLineaMontaje FROM LineaMontaje WHERE idLineaMontaje = _idLineaMontaje) IS NULL)THEN
     CALL mensajeErrorBajas();
END IF ;
DELETE FROM LineaMontaje WHERE LineaMontaje.idLineaMontaje = _idLineaMontaje;
END $$
DELIMITER ;

-- MODIFICACION L. DE MONTAJE
DELIMITER $$
CREATE PROCEDURE modificarLineaMontaje(IN _idLineaMontaje INT,IN _capacidad_produccion INT)
BEGIN
IF ((SELECT idLineaMontaje FROM LineaMontaje WHERE idLineaMontaje = _idLineaMontaje) IS NULL) THEN
     CALL mensajeErrorModificacion();
END IF ;
UPDATE LineaMontaje SET LineaMontaje.CapacidadProduccion = _capacidad_produccion WHERE (_idLineaMontaje = _idLineaMontaje);
END $$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA PEDIDO DETALLE
DELIMITER $$
CREATE PROCEDURE altaPedidoDetalle ( IN _idModelo INT, IN _cantidad INT)
BEGIN
INSERT INTO DetallePedido (Modelo_idModelo, cantidad) VALUES (_idModelo, _cantidad);
END $$
DELIMITER ;

-- BAJA PEDIDOD DETALLE
DELIMITER $$
CREATE PROCEDURE bajaPedidoDetalle (IN _idPedido INT)
BEGIN
DELETE FROM PedidoDetalle WHERE PedidoDetalle.idPedido = _idPedido;
END $$
DELIMITER ;

-- MODIFICACION PEDIDO DETALLE
DELIMITER $$
CREATE PROCEDURE modificarPedidoDetalle (IN _idPedido INT, IN _idModelo INT, IN _cantidad INT)
BEGIN
UPDATE Pedido SET cantidad = _cantidad WHERE (idPedido = _idPedido);
END$$
DELIMITER ;

--                                         ---------------------------------------------------

-- ALTA AUTOXESTACION
DELIMITER $$
CREATE PROCEDURE altaAutoxEstacion (IN _Estacion_idEstacion INT, IN _Auto_idChasis INT, IN _Fecha_ingreso DATE)
BEGIN

IF EXISTS (SELECT Fecha_ingreso FROM AutoxEstacion e WHERE e.Estacion_idEstacion = _Estacion_idEstacion and e.Auto_idChasis = _Auto_idChasis) THEN
BEGIN
      IF (_Fecha_ingreso != (SELECT Fecha_ingreso FROM AutoxEstacion WHERE Auto_idChasis = _Auto_idChasis AND Estacion_idEstacion = _Estacion_idEstacion ORDER BY Fecha_ingreso DESC LIMIT 1)) THEN
        BEGIN
           INSERT INTO AutoXEstacion (Estacion_idEstacion, Auto_idChasis, Fecha_ingreso, Fecha_salida) VALUES (_Estacion_idEstacion,_Auto_idChasis,_Fecha_ingreso, null);
        END ;
      END IF;
END ;
ELSE
BEGIN 
INSERT INTO AutoXEstacion (Estacion_idEstacion, Auto_idChasis, Fecha_ingreso, Fecha_salida) VALUES (_Estacion_idEstacion,_Auto_idChasis,_Fecha_ingreso, null);
END ;
END IF;
END $$
DELIMITER ;

-- MODIFICACION AUTOXESTACION
DELIMITER $$
CREATE PROCEDURE modificarAutoxEstacion (IN _Estacion_idEstacion INT, IN _Auto_idChasis INT, _Fecha_salida DATE)
BEGIN
UPDATE AutoXEstacion SET Fecha_salida = _Fecha_salida WHERE (Auto_idChasis = _Auto_idChasis) AND (Estacion_idEstacion = _Estacion_idEstacion);
END$$
DELIMITER ;

/* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& */

DELIMITER $$
CREATE PROCEDURE mensajeErrorAltas()
BEGIN
 SELECT 'Estas intentando crear algo que ya existe' AS 'Error';
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE mensajeErrorBajas()
BEGIN
 SELECT 'Estas intentado eliminar algo que no existe' AS 'Error';
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE mensajeErrorModificacion()
BEGIN
 SELECT 'Lo que estas intentando moficar,no existe' AS 'Error';
END $$
DELIMITER ;


/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

DELIMITER $$
CREATE PROCEDURE iniciarFabricacion(IN _Patente varchar(45))
BEGIN
DECLARE _auxChasis INT;
DECLARE _auxModelo INT;
DECLARE _auxIdEstacion INT;

SET _auxChasis = (SELECT Numero_Chasis FROM Auto WHERE Auto.Patente=_Patente);
SET _auxModelo = (SELECT Modelo_idModelo FROM Auto WHERE Auto.Patente=_Patente);
SET _auxIdEstacion = (SELECT e.idEstacion FROM LineaMontaje l INNER JOIN Estacion e ON l.idLineaMontaje=e.LineaMontaje_idLineaMontaje WHERE e.Nombre_Estacion='Mecanica de Motor' and  l.Modelo_idModelo=_auxModelo);

CALL altaAutoxEstacion(_auxIdEstacion,_auxChasis,CURRENT_DATE());

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE Generador_patente(out patente varchar(20))
BEGIN

SET patente = NULL;

WHILE (patente IS NULL) DO 
SELECT CONCAT(
        FLOOR(RAND() * 10),
        FLOOR(RAND() * 10),
        FLOOR(RAND() * 10),
      "-",
      FLOOR(RAND() * 10),
      FLOOR(RAND() * 10),
      FLOOR(RAND() * 10)
      ) INTO patente;

END WHILE;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SiguienteEstacion (IN _patente VARCHAR(25))
BEGIN 
DECLARE _auxChasis INT;
DECLARE _auxFecha_ingreso DATE;
DECLARE _auxIdEstacion INT;

SET _auxChasis = (SELECT Numero_Chasis FROM Auto WHERE Auto.Patente=_Patente);
SET _auxFecha_ingreso = (SELECT Fecha_ingreso FROM AutoxEstacion WHERE Auto_idChasis = _auxChasis ORDER BY Fecha_ingreso DESC LIMIT 1);
SET _auxIdEstacion = (SELECT Estacion_idEstacion FROM AutoxEstacion WHERE Fecha_ingreso = _auxFecha_ingreso and Auto_idChasis = _auxChasis ORDER BY Estacion_idEstacion DESC LIMIT 1);

CALL modificarAutoxEstacion (_auxIdEstacion, _auxChasis, CURRENT_DATE());
CALL altaAutoxEstacion(_auxIdEstacion + 1,_auxChasis,CURRENT_DATE());

END $$
DELIMITER ;

-- SELECT Fecha_ingreso FROM AutoxEstacion WHERE Auto_idChasis = 1 AND Estacion_idEstacion = 1 ORDER BY Fecha_ingreso DESC; 
-- drop schema mydb;

/* ************************************************************************************************************************************ */

CALL altaModelo('Ka');
CALL altaModelo('Supra');
CALL altaModelo('Ram');

CALL altaAuto(1);

CALL altaLineaMontaje (1,4);
CALL altaLineaMontaje (2,5);
CALL altaLineaMontaje (3,3);
                                                                            
                                                                             
CALL altaConcesionaria ('Ford',5);
CALL altaConcesionaria ('Tuyota',20);
CALL altaConcesionaria ('Furros',12);
CALL altaConcesionaria ('Padre Nacho',99);
                                                                             
CALL altaInsumo('tornillos',30);
CALL modificarInsumo(1,'bujias',50);    

CALL altaProvedor('GetulioCompany');
CALL modificarProvedor(1,'GetuliosCompany');

CALL altaEstacion(1,'Mecanica de Motor');
CALL altaEstacion(1,'Mecanica de Rodaje');
CALL altaEstacion(1,'Electricidad');
/*CALL altaEstacion(1,'Ensambldo de Chapa');
CALL altaEstacion(1,'Pintura');
CALL altaEstacion(1,'Prueba');*/

CALL altaEstacion(2,'Mecanica de Motor');
CALL altaEstacion(2,'Mecanica de Rodaje');
CALL altaEstacion(2,'Electricidad');
/*CALL altaEstacion(2,'Ensambldo de Chapa');
CALL altaEstacion(2,'Pintura');
CALL altaEstacion(2,'Prueba');*/

CALL altaEstacion(3,'Mecanica de Motor');
CALL altaEstacion(3,'Mecanica de Rodaje');
CALL altaEstacion(3,'Electricidad');
/*CALL altaEstacion(3,'Ensambldo de Chapa');
CALL altaEstacion(3,'Pintura');
CALL altaEstacion(3,'Prueba');*/

CALL altaPedido(1,1,5);

/*
SELECT Patente FROM Auto;
CALL iniciarFabricacion ('016-706');
CALL iniciarFabricacion ('408-318');
CALL iniciarFabricacion ('407-685');
SELECT * FROM AutoxEstacion;
CALL SiguienteEstacion ('016-706');
*/
