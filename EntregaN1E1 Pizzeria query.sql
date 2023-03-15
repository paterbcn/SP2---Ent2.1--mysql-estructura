use pizzeria;

-- Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.
select p.nombre as producto , cp.nombre as categoria , c.diahora as "fecha venta"
from comanda c
join detallecomanda d
	on c.idcomanda = d.Idcomanda
join productos p
	on d.idproducto = p.idProducto
join catproducto cp
	on p.idcategoria = cp.idCatPro
where cp.nombre = "Bebidas"