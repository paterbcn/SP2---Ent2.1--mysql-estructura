 CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
 CREATE TABLE IF NOT EXISTS `Optica`.`Ciudad` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCiudad`));
CREATE TABLE IF NOT EXISTS `Optica`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idPais`));
CREATE TABLE IF NOT EXISTS `Optica`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `idCiudad` INT NULL,
  `idPais` INT NULL,
  `Fecha de alta` DATE NOT NULL,
  `Telefono` INT NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `Recomendado` INT NULL,
  PRIMARY KEY (`idClientes`),
  INDEX `idciudad_idx` (`idCiudad` ASC) VISIBLE,
  INDEX `idpais_idx` (`idPais` ASC) VISIBLE,
  INDEX `idcliente_idx` (`Recomendado` ASC) VISIBLE,
  CONSTRAINT `FK_clientes-ciudad`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `Optica`.`Ciudad` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_cliente-pais`
    FOREIGN KEY (`idPais`)
    REFERENCES `Optica`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fk_cliente-clientes`
    FOREIGN KEY (`Recomendado`)
    REFERENCES `Optica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`Proveedor` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(100) NOT NULL,
  `Numero` INT NOT NULL,
  `Puerta` VARCHAR(45) NULL,
  `Codigo Postal` INT NOT NULL,
  `Telefono` INT NOT NULL,
  `Fax` INT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `IdCIuidad` INT NULL,
  `IdPais` INT NULL,
  PRIMARY KEY (`idProveedor`),
  INDEX `IdCIuidad_idx` (`IdCIuidad` ASC) VISIBLE,
  INDEX `idPais_idx` (`IdPais` ASC) VISIBLE,
  CONSTRAINT `FK_proveedor-ciudad`
    FOREIGN KEY (`IdCIuidad`)
    REFERENCES `Optica`.`Ciudad` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_proveedor-pais`
    FOREIGN KEY (`IdPais`)
    REFERENCES `Optica`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Departamento` VARCHAR(200) NOT NULL,
  `extension` INT NOT NULL,
  PRIMARY KEY (`idempleado`));
CREATE TABLE IF NOT EXISTS `Optica`.`Ventas` (
  `idVentas` INT NOT NULL AUTO_INCREMENT,
  `Fecha venta` DATE NOT NULL,
  `Idempleado` INT NOT NULL,
  `idcliente` INT NOT NULL,
  PRIMARY KEY (`idVentas`),
  INDEX `idempleado_idx` (`Idempleado` ASC) VISIBLE,
  INDEX `idcliente_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `FK_ventas-empleados`
    FOREIGN KEY (`Idempleado`)
    REFERENCES `Optica`.`empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ventas-clientes`
    FOREIGN KEY (`idcliente`)
    REFERENCES `Optica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`ColoresC` (
  `idColoresC` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idColoresC`));
CREATE TABLE IF NOT EXISTS `Optica`.`ColoresM` (
  `idColor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idColor`));
CREATE TABLE IF NOT EXISTS `Optica`.`Marca gafas` (
  `idMarca gafas` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idMarca gafas`));
CREATE TABLE IF NOT EXISTS `Optica`.`Cristal` (
  `idCristal` INT NOT NULL AUTO_INCREMENT,
  `Graduacion` FLOAT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCristal`));
CREATE TABLE IF NOT EXISTS `Optica`.`Monturas` (
  `idMonturas` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idMonturas`));
CREATE TABLE IF NOT EXISTS `Optica`.`Cristal-Color` (
  `idCriCol` INT NOT NULL AUTO_INCREMENT,
  `idcristal` INT NULL,
  `idColor` INT NULL,
  PRIMARY KEY (`idCriCol`),
  INDEX `idcristal_idx` (`idcristal` ASC) VISIBLE,
  INDEX `idcolor_idx` (`idColor` ASC) VISIBLE,
  CONSTRAINT `FK_cricol-colorc`
    FOREIGN KEY (`idcristal`)
    REFERENCES `Optica`.`Cristal` (`idCristal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_colmon-colorem`
    FOREIGN KEY (`idColor`)
    REFERENCES `Optica`.`ColoresC` (`idColoresC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`Color-Montura` (
  `idColMon` INT NOT NULL AUTO_INCREMENT,
  `IdMontura` INT NULL,
  `IdColor` INT NULL,
  PRIMARY KEY (`idColMon`),
  INDEX `idmontura_idx` (`IdMontura` ASC) VISIBLE,
  INDEX `idcolot_idx` (`IdColor` ASC) VISIBLE,
  CONSTRAINT `idmontura`
    FOREIGN KEY (`IdMontura`)
    REFERENCES `Optica`.`Monturas` (`idMonturas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idcolot`
    FOREIGN KEY (`IdColor`)
    REFERENCES `Optica`.`ColoresM` (`idColor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`Productos` (
  `idProductos` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Precio` FLOAT NOT NULL,
  `idMarca` INT NOT NULL,
  `idCristral` INT NOT NULL,
  `idMontura` INT NOT NULL,
  `IdProveedor` INT NULL,
  PRIMARY KEY (`idProductos`),
  INDEX `idmarca_idx` (`idMarca` ASC) VISIBLE,
  INDEX `idcristal_idx` (`idCristral` ASC) VISIBLE,
  INDEX `idmontura_idx` (`idMontura` ASC) VISIBLE,
  INDEX `idProveedor_idx` (`IdProveedor` ASC) VISIBLE,
  CONSTRAINT `FK_producto-gafas`
    FOREIGN KEY (`idMarca`)
    REFERENCES `Optica`.`Marca gafas` (`idMarca gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_producto-cristal`
    FOREIGN KEY (`idCristral`)
    REFERENCES `Optica`.`Cristal` (`idCristal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_producto-monturas`
    FOREIGN KEY (`idMontura`)
    REFERENCES `Optica`.`Monturas` (`idMonturas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_producto-proveedor`
    FOREIGN KEY (`IdProveedor`)
    REFERENCES `Optica`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE IF NOT EXISTS `Optica`.`DetalleVenta` (
  `idDetalleVenta` INT NOT NULL AUTO_INCREMENT,
  `idventa` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `Cantidad` FLOAT NOT NULL,
  PRIMARY KEY (`idDetalleVenta`),
  INDEX `idventa_idx` (`idventa` ASC) VISIBLE,
  INDEX `idproducto_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `FK_Detventa-ventas`
    FOREIGN KEY (`idventa`)
    REFERENCES `Optica`.`Ventas` (`idVentas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Detventa-producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Optica`.`Productos` (`idProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);