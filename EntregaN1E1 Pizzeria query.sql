use pizzeria;

-- Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.
select p.nombre as producto , cp.nombre as categoria , c.diahora as "fecha venta" , lo.Nombre
from comanda c
join detallecomanda d
	on c.idcomanda = d.Idcomanda
join productos p
	on d.idproducto = p.idProducto
join catproducto cp
	on p.idcategoria = cp.idCatPro
join tienda ti
	on c.Idtienda = ti.idtienda
join localidad lo
	on ti.idLocalidad = lo.idLocalidad
where cp.nombre = "Bebidas" and lo.idLocalidad = 2

-- Llista quantes comandes ha efectuat un determinat empleat/da.

select concat (e.nombre , " ",e.Apellido ) as Empleado , count(*) as "Numero Comandas"
from comanda c
join empleados e
	on c.Idempleado = e.idempleado
where e.idempleado = 1;
