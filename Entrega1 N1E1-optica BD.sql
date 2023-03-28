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
  `Fechaalta` DATE NOT NULL,
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
  `RazonSocial` VARCHAR(200) NOT NULL,
  `Calle` VARCHAR(100) NOT NULL,
  `Numero` INT NOT NULL,
  `Puerta` VARCHAR(45) NULL,
  `CodPost` INT NOT NULL,
  `Telefono` INT NOT NULL,
  `Fax` INT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `IdCIuidad` INT NOT NULL,
  `IdPais` INT NOT NULL,
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
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `Fechaventa` DATE NOT NULL,
  `Idempleado` INT NOT NULL,
  `idcliente` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
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
  `idMarcaGaf` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idMarcaGaf`));
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
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Precio` FLOAT NOT NULL,
  `idMarca` INT NOT NULL,
  `idCristral` INT NOT NULL,
  `idMontura` INT NOT NULL,
  `IdProveedor` INT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `idmarca_idx` (`idMarca` ASC) VISIBLE,
  INDEX `idcristal_idx` (`idCristral` ASC) VISIBLE,
  INDEX `idmontura_idx` (`idMontura` ASC) VISIBLE,
  INDEX `idProveedor_idx` (`IdProveedor` ASC) VISIBLE,
  CONSTRAINT `FK_producto-gafas`
    FOREIGN KEY (`idMarca`)
    REFERENCES `Optica`.`Marca gafas` (`idMarcaGaf`)
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
    REFERENCES `Optica`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Detventa-producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Optica`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `optica`.`ciudad` (`Nombre`) VALUES ('barcelona');
INSERT INTO `optica`.`ciudad` (`Nombre`) VALUES ('madrid');
INSERT INTO `optica`.`ciudad` (`Nombre`) VALUES ('sevilla');

INSERT INTO `optica`.`pais` (`Nombre`) VALUES ('españa');
INSERT INTO `optica`.`pais` (`Nombre`) VALUES ('francia');
INSERT INTO `optica`.`pais` (`Nombre`) VALUES ('portugal');

INSERT INTO `optica`.`empleado` (`Nombre`, `Departamento`, `extension`) VALUES ('empleado1', 'ventas', '1');
INSERT INTO `optica`.`empleado` (`Nombre`, `Departamento`, `extension`) VALUES ('empleado2', 'compras', '2');
INSERT INTO `optica`.`empleado` (`Nombre`, `Departamento`, `extension`) VALUES ('empleado3', 'ventas', '3');

INSERT INTO `optica`.`marca gafas` (`Nombre`) VALUES ('marca1');
INSERT INTO `optica`.`marca gafas` (`Nombre`) VALUES ('marca2');
INSERT INTO `optica`.`marca gafas` (`Nombre`) VALUES ('marca3');

INSERT INTO `optica`.`coloresc` (`Nombre`) VALUES ('rojo');
INSERT INTO `optica`.`coloresc` (`Nombre`) VALUES ('verde');
INSERT INTO `optica`.`coloresc` (`Nombre`) VALUES ('amarillo');

INSERT INTO `optica`.`coloresm` (`Nombre`) VALUES ('plata');
INSERT INTO `optica`.`coloresm` (`Nombre`) VALUES ('oro');
INSERT INTO `optica`.`coloresm` (`Nombre`) VALUES ('cobre');

INSERT INTO `optica`.`cristal` (`Graduacion`, `Nombre`) VALUES ('5.0', 'cristal1');
INSERT INTO `optica`.`cristal` (`Graduacion`, `Nombre`) VALUES ('9.2', 'cristal2');
INSERT INTO `optica`.`cristal` (`Graduacion`, `Nombre`) VALUES ('8.1', 'cristal3');


INSERT INTO `optica`.`monturas` (`Nombre`) VALUES ('metalica');
INSERT INTO `optica`.`monturas` (`Nombre`) VALUES ('pasta');
INSERT INTO `optica`.`monturas` (`Nombre`) VALUES ('flotante');

INSERT INTO `optica`.`cristal-color` (`idcristal`, `idColor`) VALUES ('1', '1');
INSERT INTO `optica`.`cristal-color` (`idcristal`, `idColor`) VALUES ('1', '2');
INSERT INTO `optica`.`cristal-color` (`idcristal`, `idColor`) VALUES ('2', '3');
INSERT INTO `optica`.`cristal-color` (`idcristal`, `idColor`) VALUES ('2', '1');
INSERT INTO `optica`.`cristal-color` (`idcristal`, `idColor`) VALUES ('3', '3');

INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('1', '2');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('1', '3');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('2', '2');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('2', '3');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('3', '1');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('3', '2');
INSERT INTO `optica`.`color-montura` (`IdMontura`, `IdColor`) VALUES ('3', '3');

INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`, `Recomendado`) VALUES ('cliente1', 'calle 1 , 18', '1', '1', '2023/01/01', '66666666', 'cus@cu.com', '2');
INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`, `Recomendado`) VALUES ('cliente2', 'calle 3 , 20', '2', '1', '2022/01/02', '9999999', 'cis2@email.com', '1');
INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`, `Recomendado`) VALUES ('cliente2', 'calle 4 , 20', '3', '1', '2022/05/05', '7777777', 'cis3@email.com', '1');

INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`) VALUES ('Cliente1', 'Calle 1 ,181', '1', '1', '2022-01-01', '6666666', 'aa@email.com');
INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`, `Recomendado`) VALUES ('cliente2', 'calle 2, 100', '2', '1', '2022-01-02', '9999999', 'aa@email.com', '1');
INSERT INTO `optica`.`clientes` (`Nombre`, `direccion`, `idCiudad`, `idPais`, `Fechaalta`, `Telefono`, `email`, `Recomendado`) VALUES ('cliente3', 'calle 3, 200', '3', '1', '2023-01-01', '7777777', 'bb@email.com', '2');

INSERT INTO `optica`.`proveedor` (`RazonSocial`, `Calle`, `Numero`, `Puerta`, `CodPost`, `Telefono`, `Fax`, `NIF`, `IdCIuidad`, `IdPais`) VALUES ('proveedor1', 'calle1', '99', '1', '08001', '999999', '555555', '54545x', '2', '1');
INSERT INTO `optica`.`proveedor` (`RazonSocial`, `Calle`, `Numero`, `Puerta`, `CodPost`, `Telefono`, `Fax`, `NIF`, `IdCIuidad`, `IdPais`) VALUES ('proveedor2', 'calle2', '100', '2', '08002', '666666', '444444', '54545c', '3', '1');
INSERT INTO `optica`.`proveedor` (`RazonSocial`, `Calle`, `Numero`, `Puerta`, `CodPost`, `Telefono`, `Fax`, `NIF`, `IdCIuidad`, `IdPais`) VALUES ('proveedor3', 'calle4', '22', '3', '08003', '77777', '45454', '54585x', '1', '1');

INSERT INTO `optica`.`productos` (`Nombre`, `Precio`, `idMarca`, `idCristral`, `idMontura`, `IdProveedor`) VALUES ('Producto1', '10', '1', '1', '1', '1');
INSERT INTO `optica`.`productos` (`Nombre`, `Precio`, `idMarca`, `idCristral`, `idMontura`, `IdProveedor`) VALUES ('producto2', '5', '2', '2', '2', '2');
INSERT INTO `optica`.`productos` (`Nombre`, `Precio`, `idMarca`, `idCristral`, `idMontura`, `IdProveedor`) VALUES ('producto3', '3', '3', '3', '3', '3');

INSERT INTO `optica`.`ventas` (`Fechaventa`, `Idempleado`, `idcliente`) VALUES ('2023-01-01', '1', '1');
INSERT INTO `optica`.`ventas` (`Fechaventa`, `Idempleado`, `idcliente`) VALUES ('2023-01-02', '2', '2');
INSERT INTO `optica`.`ventas` (`Fechaventa`, `Idempleado`, `idcliente`) VALUES ('2023-01-03', '3', '3');

INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('1', '1', '10');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('1', '2', '5');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('2', '3', '5');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('2', '1', '3');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('3', '1', '20');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('3', '2', '5');
INSERT INTO `optica`.`detalleventa` (`idventa`, `idProducto`, `Cantidad`) VALUES ('1', '3', '2');
