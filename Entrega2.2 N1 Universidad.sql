use universidad;

-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select   apellido1 , apellido2 , nombre 
from persona p
where p.tipo = "alumno"
order by apellido1 asc , apellido2 asc , nombre asc;
-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre , apellido1 , apellido2, telefono, tipo
from persona p
where p.telefono is null and p.tipo = "alumno";
-- Retorna el llistat dels alumnes que van néixer en 1999.
select nombre , apellido1 , apellido2 , fecha_nacimiento,tipo
from persona
where year(fecha_nacimiento) = 1999 and tipo = "alumno";
-- Retorna el llistat de professors/es que no han donat d'alta el seu número de 
-- telèfon en la base de dades i a més el seu NIF acaba en K.
select *
from persona
where tipo = "profesor" and telefono is null and nif like "%k";
-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el 
-- tercer curs del grau que té l'identificador 7.
select a.nombre as asignatura , a.curso , a.cuatrimestre , g.nombre as grado
from asignatura a
join grado g
	on a.id_grado = g.id
where a.cuatrimestre = 1 and a.curso = 3 and g.id = 7;
-- Retorna un llistat dels professors/es juntament amb el nom del departament al 
-- qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, 
-- segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de 
-- menor a major pels cognoms i el nom.
select  pe.apellido1 , pe.apellido2 ,pe.nombre, de.nombre 
from persona pe
join profesor pr
	on pe.id = pr.id_profesor
join departamento de
	on pr.id_departamento = de.id
order by pe.apellido1 asc , pe.apellido2 asc , pe.nombre;
-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
select concat(pe.nombre , " " , pe.apellido1 , " " , pe.apellido2) as alumno , ce.anyo_inicio , ce.anyo_fin , ag.nombre as asinatura
from persona pe
join alumno_se_matricula_asignatura al
	on pe.id = al.id_alumno
join asignatura ag
	on al.id_asignatura = ag.id
join curso_escolar ce
	on al.id_curso_escolar = ce.id
where nif = "26902806M";
-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna 
-- assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select de.nombre  as departamento , ag.nombre as asignatura , gr.nombre
from departamento de
join profesor pr
	on de.id = pr.id_departamento
join persona pe
	on pr.id_profesor =  pe.id
join asignatura ag
	on pr.id_profesor = ag.id_profesor
join grado gr
	on ag.id_grado = gr.id
where gr.id = 4;
-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select concat(pe.nombre , " " , pe.apellido1 , " " , pe.apellido2) as alumno , concat(cu.anyo_inicio,"/",cu.anyo_fin) as "curso escolar"
from persona pe
join alumno_se_matricula_asignatura al
	on pe.id = al.id_alumno
join curso_escolar cu
	on al.id_curso_escolar = cu.id
where cu.anyo_inicio = 2018
group by cu.anyo_inicio
















