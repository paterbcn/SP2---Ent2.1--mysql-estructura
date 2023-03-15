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
  `Imagen` BLOB NOT NULL,
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
    ON UPDATE NO ACTION);
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
  `idempleados` INT NOT NULL AUTO_INCREMENT,
  `idTienda` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `NIF` VARCHAR(100) NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idempleados`),
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
  CONSTRAINT `idempleado`
    FOREIGN KEY (`IdEmpleado`)
    REFERENCES `Pizzeria`.`Empleados` (`idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Repartidores` (
  `idRepartidores` INT NOT NULL AUTO_INCREMENT,
  `Idempleado` INT NOT NULL,
  PRIMARY KEY (`idRepartidores`, `Idempleado`),
  INDEX `idempleado_idx` (`Idempleado` ASC) VISIBLE,
  CONSTRAINT `FK_repartidores-empleados`
    FOREIGN KEY (`Idempleado`)
    REFERENCES `Pizzeria`.`Empleados` (`idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
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
    REFERENCES `Pizzeria`.`Empleados` (`idempleados`)
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
    ON UPDATE NO ACTION);




