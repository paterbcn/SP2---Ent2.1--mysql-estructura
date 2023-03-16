-- Llista el nom de tots els productes que hi ha en la taula producto.
select nombre
from producto;
-- Llista els noms i els preus de tots els productes de la taula producto.
select nombre , precio
from producto;
-- Llista totes les columnes de la taula producto.
select *
from producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
select nombre , precio  , precio * 1.05
from producto;
--  Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
-- Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
select nombre , format(precio ,2) as "Precio €" , format(precio * 1.05,2) as "Precio USS" 
from producto;
-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
select upper(nombre) , precio
from producto;
-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
select lower(nombre) , precio
from producto;
-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en
-- majúscules els dos primers caràcters del nom del fabricant.
select nombre , concat (upper(substring(nombre , 1,2 )) ,substring(nombre , 3 ))
 from fabricante;
 -- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
 select nombre , round(precio)
 from producto;
  -- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu 
 -- per a mostrar-lo sense cap xifra decimal.
 select nombre , truncate(precio,0)
 from producto;
 -- Llista el codi dels fabricants que tenen productes en la taula producto.
 select p.nombre , f.codigo as "codigo fabricante"
 from producto p
 join fabricante f
	on p.codigo_fabricante =  f.codigo;
-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
select  f.codigo as "codigo fabricante",count(*)
 from producto p
 join fabricante f 
	on p.codigo_fabricante =  f.codigo
group by f.codigo;
-- Llista els noms dels fabricants ordenats de manera ascendent.
select nombre
from fabricante
order by nombre asc;
-- Llista els noms dels fabricants ordenats de manera descendent.
select nombre
from fabricante
order by nombre desc;
-- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, 
-- en segon lloc, pel preu de manera descendent.
select *
from producto
order by nombre asc , precio desc;
-- Retorna una llista amb les 5 primeres files de la taula fabricante.
select *
from fabricante
limit 5;
-- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. 
-- La quarta fila també s'ha d'incloure en la resposta.
select *
from fabricante
limit 3,3









 




