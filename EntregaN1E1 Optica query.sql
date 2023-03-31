
-- Llista el total de compres d’un client/a.
SELECT
	v.idVenta AS Factura,
	c.nombre AS Cliente,
	v.fechaventa AS "Fecha Factura"
FROM
	clientes c
	JOIN ventas v ON c.idClientes = v.idcliente;

-- Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT
	e.nombre AS Empleado,
	p.nombre AS Producto
FROM
	empleado e
	JOIN ventas v ON e.idempleado = v.idempleado
	JOIN detalleventa d ON v.idventa = d.idventa
	JOIN productos p ON d.idproducto = p.idproducto
where
	year (v.fechaventa) = "2023";

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
SELECT
	a.nombre AS Articulo,
	p.razonsocial AS Proveedor,
	v.fechaventa AS "Fecha de Venta"
FROM
	productos a
	JOIN proveedor p ON a.idproveedor = p.idproveedor
	JOIN detalleventa d ON a.idproducto = d.idproducto
	JOIN ventas v ON d.idventa = v.idventa;