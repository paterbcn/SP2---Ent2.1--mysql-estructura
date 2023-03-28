CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ;
CREATE TABLE IF NOT EXISTS `Pizzeria`.`CatProducto` (
  `idCatPro` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCatPro`));
CREATE TABLE IF NOT EXISTS `Pizzeria`.`subCatePro` (
  `idsubCatePro` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `idCat` INT NOT NULL,
  PRIMARY KEY (`idsubCatePro`),
  INDEX `FK_SubCat-catpro_idx` (`idCat` ASC) VISIBLE,
  CONSTRAINT `FK_SubCat-catpro`
    FOREIGN KEY (`idCat`)
    REFERENCES `Pizzeria`.`CatProducto` (`idCatPro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Descripcion` MEDIUMTEXT NOT NULL,
  `Precio` FLOAT NOT NULL,
  `Imagen` BLOB NULL,
  `IdCategoria` INT NOT NULL,
  `idsubCatePro` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `idcategoria_idx` (`IdCategoria` ASC) VISIBLE,
  INDEX `FK_producto-subcateg_idx` (`idsubCatePro` ASC) VISIBLE,
  CONSTRAINT `FK_producto-categoria`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `Pizzeria`.`CatProducto` (`idCatPro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_producto-subcateg`
    FOREIGN KEY (`idsubCatePro`)
    REFERENCES `Pizzeria`.`subCatePro` (`idsubCatePro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Localidad` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idLocalidad`));
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Provincias` (
  `idProvincias` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idProvincias`));
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(150) NOT NULL,
  `Apellido` VARCHAR(150) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `IdLocalidad` INT NOT NULL,
  `idProvincia` INT NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idclientes`),
  INDEX `idprovincia_idx` (`idProvincia` ASC) VISIBLE,
  INDEX `idlocalidad_idx` (`IdLocalidad` ASC) VISIBLE,
  CONSTRAINT `FK_cliente-provincia`
    FOREIGN KEY (`idProvincia`)
    REFERENCES `Pizzeria`.`Provincias` (`idProvincias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_cliente-localidad`
    FOREIGN KEY (`IdLocalidad`)
    REFERENCES `Pizzeria`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Tienda` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Direccion` VARCHAR(300) NOT NULL,
  `idLocalidad` INT NOT NULL,
  `idprovincia` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  INDEX `idlocalida_idx` (`idLocalidad` ASC) VISIBLE,
  INDEX `idprovinca_idx` (`idprovincia` ASC) VISIBLE,
  CONSTRAINT `FK_tienda-localidad`
    FOREIGN KEY (`idLocalidad`)
    REFERENCES `Pizzeria`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_tienda-provincia`
    FOREIGN KEY (`idprovincia`)
    REFERENCES `Pizzeria`.`Provincias` (`idProvincias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Empleados` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `idTienda` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `NIF` VARCHAR(100) NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idempleado`),
  INDEX `idtienda_idx` (`idTienda` ASC) VISIBLE,
  CONSTRAINT `FK_empleado-tienda`
    FOREIGN KEY (`idTienda`)
    REFERENCES `Pizzeria`.`Tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Cocineros` (
  `idCocinero` INT NOT NULL AUTO_INCREMENT,
  `IdEmpleado` INT NOT NULL,
  PRIMARY KEY (`idCocinero`),
  INDEX `idempleado_idx` (`IdEmpleado` ASC) VISIBLE,
  CONSTRAINT `FK-cocinero-empleado`
    FOREIGN KEY (`IdEmpleado`)
    REFERENCES `Pizzeria`.`Empleados` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Repartidores` (
  `idRepartidores` INT NOT NULL AUTO_INCREMENT,
  `Idempleado` INT NOT NULL,
  PRIMARY KEY (`idRepartidores`),
  INDEX `idempleado_idx` (`Idempleado` ASC) VISIBLE,
  CONSTRAINT `FK_repartidores-empleados`
    FOREIGN KEY (`Idempleado`)
    REFERENCES `Pizzeria`.`Empleados` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Comanda` (
  `idComanda` INT NOT NULL AUTO_INCREMENT,
  `diahora` DATETIME NOT NULL DEFAULT NOW(),
  `idcliente` INT NOT NULL,
  `Idtienda` INT NOT NULL,
  `Entrega` TINYINT NOT NULL,
  `Ptotal` FLOAT NOT NULL,
  `Idempleado` INT NULL,
  PRIMARY KEY (`idComanda`),
  INDEX `idtienda_idx` (`Idtienda` ASC) VISIBLE,
  INDEX `idcliente_idx` (`idcliente` ASC) VISIBLE,
  INDEX `FK_comanda-empleado_idx` (`Idempleado` ASC) VISIBLE,
  CONSTRAINT `FK_comanda-tienda`
    FOREIGN KEY (`Idtienda`)
    REFERENCES `Pizzeria`.`Tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_comanda-cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `Pizzeria`.`Clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_comanda-empleado`
    FOREIGN KEY (`Idempleado`)
    REFERENCES `Pizzeria`.`Empleados` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`DetalleComanda` (
  `idDetcom` INT NOT NULL AUTO_INCREMENT,
  `Idcomanda` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`idDetcom`),
  INDEX `idcomanda_idx` (`Idcomanda` ASC) VISIBLE,
  INDEX `idproducto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `FK_detallecomanda-comanda`
    FOREIGN KEY (`Idcomanda`)
    REFERENCES `Pizzeria`.`Comanda` (`idComanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detallecomanda-producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Pizzeria`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`DetalleDeEntrega` (
  `idDetEnt` INT NOT NULL AUTO_INCREMENT,
  `idComanda` INT NOT NULL,
  `IdRepartidor` INT NOT NULL,
  `DiaHora` DATETIME NOT NULL,
  `Informacion` MEDIUMTEXT NULL,
  PRIMARY KEY (`idDetEnt`),
  INDEX `idcomanda_idx` (`idComanda` ASC) VISIBLE,
  INDEX `idrepartidor_idx` (`IdRepartidor` ASC) VISIBLE,
  CONSTRAINT `FK_detalleentrega-comanda`
    FOREIGN KEY (`idComanda`)
    REFERENCES `Pizzeria`.`Comanda` (`idComanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detalleentrega-repartidor`
    FOREIGN KEY (`IdRepartidor`)
    REFERENCES `Pizzeria`.`Repartidores` (`idRepartidores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;






INSERT INTO `pizzeria`.`provincias` (`Nombre`) VALUES ('barcelona');
INSERT INTO `pizzeria`.`provincias` (`Nombre`) VALUES ('tarragona');
INSERT INTO `pizzeria`.`provincias` (`Nombre`) VALUES ('Lleida');

INSERT INTO `pizzeria`.`localidad` (`Nombre`) VALUES ('Loc1');
INSERT INTO `pizzeria`.`localidad` (`Nombre`) VALUES ('loc2');
INSERT INTO `pizzeria`.`localidad` (`Nombre`) VALUES ('loc3');

INSERT INTO `pizzeria`.`catproducto` (`Nombre`) VALUES ('Hamburguesas');
INSERT INTO `pizzeria`.`catproducto` (`Nombre`) VALUES ('pizzas');
INSERT INTO `pizzeria`.`catproducto` (`Nombre`) VALUES ('bebidas');

INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('Margarita', '2');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('tropicana', '2');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('real', '2');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('pollo', '1');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('ternera', '1');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('refresco', '3');
INSERT INTO `pizzeria`.`subcatepro` (`Nombre`, `idCat`) VALUES ('alcohol', '3');

INSERT INTO `pizzeria`.`productos` (`Nombre`, `Descripcion`, `Precio`, `IdCategoria`, `idsubCatePro`) VALUES ('Producto1', 'descricion', '10', '1', '1');
INSERT INTO `pizzeria`.`productos` (`Nombre`, `Descripcion`, `Precio`, `IdCategoria`, `idsubCatePro`) VALUES ('prodcuto2', 'descripcion', '3', '2', '1');
INSERT INTO `pizzeria`.`productos` (`Nombre`, `Descripcion`, `Precio`, `IdCategoria`, `idsubCatePro`) VALUES ('producto3', 'descripcion', '1', '3', '2');

INSERT INTO `pizzeria`.`tienda` (`Nombre`, `Direccion`, `idLocalidad`, `idprovincia`) VALUES ('tienda1', 'calle 1', '1', '1');
INSERT INTO `pizzeria`.`tienda` (`Nombre`, `Direccion`, `idLocalidad`, `idprovincia`) VALUES ('tienda2', 'calle 2', '2', '2');
INSERT INTO `pizzeria`.`tienda` (`Nombre`, `Direccion`, `idLocalidad`, `idprovincia`) VALUES ('tienda3', 'calle3', '3', '3');

INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('1', 'Nemp1', 'Apemp1', '465515x', '666666');
INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('1', 'Nemp2', 'Apemp2', '645464x', '888888');
INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('2', 'Nemp3', 'Apemp3', '4545454s', '777777');
INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('2', 'Nemp4', 'Apemp4', '65656s', '999989');
INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('3', 'Nemp5', 'Apemp5', '87878a', '1212312');
INSERT INTO `pizzeria`.`empleados` (`idTienda`, `Nombre`, `Apellido`, `NIF`, `Telefono`) VALUES ('3', 'Nemp6', 'Apemp6', '456454q', '45645');

INSERT INTO `pizzeria`.`cocineros` (`IdEmpleado`) VALUES ('1');
INSERT INTO `pizzeria`.`cocineros` (`IdEmpleado`) VALUES ('3');
INSERT INTO `pizzeria`.`cocineros` (`IdEmpleado`) VALUES ('5');

INSERT INTO `pizzeria`.`repartidores` (`Idempleado`) VALUES ('2');
INSERT INTO `pizzeria`.`repartidores` (`Idempleado`) VALUES ('4');
INSERT INTO `pizzeria`.`repartidores` (`Idempleado`) VALUES ('6');

INSERT INTO `pizzeria`.`clientes` (`Nombre`, `Apellido`, `Direccion`, `IdLocalidad`, `idProvincia`, `Telefono`) VALUES ('Na1', 'Ap1', 'calle 1 , 100', '1', '2', '666666');
INSERT INTO `pizzeria`.`clientes` (`Nombre`, `Apellido`, `Direccion`, `IdLocalidad`, `idProvincia`, `Telefono`) VALUES ('Na2', 'Ap2', 'calle 2 , 100', '2', '1', '66666');
INSERT INTO `pizzeria`.`clientes` (`Nombre`, `Apellido`, `Direccion`, `IdLocalidad`, `idProvincia`, `Telefono`) VALUES ('Na3', 'Ap3', 'calle 3 , 100', '3', '2', '999999');

INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-01 13:20:00', '1', '1', '0', '10', '1');
INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-01 14:20:00', '2', '2', '1', '30', '3');
INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-02 14:20:00', '3', '3', '1', '30', '5');

INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-01 13:50:00', '1', '1', '0', '10', '1');
INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-01 14:50:00', '2', '2', '1', '30', '3');
INSERT INTO `pizzeria`.`comanda` (`diahora`, `idcliente`, `Idtienda`, `Entrega`, `Ptotal`, `Idempleado`) VALUES ('2022-01-02 14:50:00', '3', '3', '1', '20', '5');

INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('1', '1', '2');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('1', '2', '2');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('2', '2', '1');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('2', '3', '1');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('3', '1', '1');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('3', '2', '2');
INSERT INTO `pizzeria`.`detallecomanda` (`Idcomanda`, `idProducto`, `Cantidad`) VALUES ('3', '3', '1');

INSERT INTO `pizzeria`.`detalledeentrega` (`idComanda`, `IdRepartidor`, `DiaHora`, `Informacion`) VALUES ('2', '1', '2022-01-01 15:50:00', 'AAAAAAAAA');
INSERT INTO `pizzeria`.`detalledeentrega` (`idComanda`, `IdRepartidor`, `DiaHora`, `Informacion`) VALUES ('3', '2', '2022-01-02 15:50:00', 'BBBBBBBBB');
