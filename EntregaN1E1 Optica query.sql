use optica;

-- Llista el total de compres d’un client/a.
select  v.idVenta as Factura,  c.nombre As Cliente , v.fechaventa as "Fecha Factura"
from clientes c
join ventas v
	on c.idClientes = v.idcliente;
    
-- Llista les diferents ulleres que ha venut un empleat durant un any.

select e.nombre as Empleado , p.nombre as Producto
from empleado e
join ventas v
	on e.idempleado = v.idempleado
join detalleventa d
	on v.idventa = d.idventa
join productos p
	on d.idproducto = p.idproducto
where year(v.fechaventa) = "2022";

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

select a.nombre as Articulo , p.razonsocial as Proveedor , v.fechaventa As "Fecha de Venta"
from productos a 
join proveedor p
	on a.idproveedor = p.idproveedor
join detalleventa d
	on a.idproducto = d.idproducto
join ventas v
	on d.idventa = v.idventa


