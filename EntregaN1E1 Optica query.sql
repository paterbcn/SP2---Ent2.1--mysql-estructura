select c.Nombre as "nombre cliente" ,v.fecha_venta , e.Nombre as "empleado" 
from clientes c
join ventas v
	on c.idClientes = v.idcliente
join empleado e
	on v.Idempleado = e.idempleado
