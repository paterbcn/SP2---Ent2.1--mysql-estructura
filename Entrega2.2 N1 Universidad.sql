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
group by pe.apellido1;
-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select de.nombre as departamento  , pe.apellido1 , pe.apellido2, pe.nombre
from persona pe
left join profesor pr
	on pe.id = pr.id_profesor
left join departamento de
	on pr.id_departamento = de.id
where pe.tipo ="profesor"
order by departamento asc , pe.apellido1 asc , pe.apellido2 asc , pe.nombre asc ;
-- Retorna un llistat amb els professors/es que no estan associats a un departament.
select de.nombre as departamento  , pe.apellido1 , pe.apellido2, pe.nombre
from persona pe
left join profesor pr
	on pe.id = pr.id_profesor
left join departamento de
	on pr.id_departamento = de.id
where pe.tipo ="profesor" and de.nombre is null
order by departamento asc , pe.apellido1 asc , pe.apellido2 asc , pe.nombre asc ;
-- Retorna un llistat amb els departaments que no tenen professors/es associats.
select de.nombre
from departamento de
left join profesor pr
	on de.id= pr.id_departamento
where pr.id_departamento is null;
-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select concat(pe.nombre , " " , pe.apellido1 , " " , pe.apellido2) as Profesor , ag.nombre as asignatura
from persona pe
left join profesor pr
	on pe.id = pr.id_profesor
left join asignatura ag
	on pr.id_profesor = ag.id_profesor
where pe.tipo ="profesor" and ag.id_profesor is null;
-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select de.nombre as departamento , ag.nombre as asignatura
from departamento de
left join profesor pr
	on de.id= pr.id_departamento
left join asignatura ag
	on pr.id_profesor = ag.id_profesor
where ag.id is null;
-- Retorna el nombre total d'alumnes que hi ha.
select count(*) as "numero de alumnos"
from persona
where tipo ="alumno";
-- Calcula quants alumnes van néixer en 1999.
select count(*) as "numero de alumnos"
from persona
where tipo ="alumno" and year(fecha_nacimiento)="1999";
-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, 
-- una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major 
-- a menor pel nombre de professors/es.
select de.nombre as departemento , count(*) as "numero de profesores"
from departamento de
join profesor pr
	ON de.id = pr.id_departamento
group by de.nombre;

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que 
-- poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.

select de.nombre as departemento , count(pr.id_profesor) as "numero profesores"
from departamento de
left join profesor pr
	ON de.id = pr.id_departamento
group by de.nombre;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select gr.nombre as grado , count(ag.id) as "numero de asignaturas" 
from grado gr
left join asignatura ag
	on gr.id = ag.id_grado
group by gr.id






















