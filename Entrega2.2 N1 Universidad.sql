-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT
	apellido1,
	apellido2,
	nombre
FROM
	persona p
WHERE
	p.tipo = "alumno"
ORDER BY
	apellido1 ASC,
	apellido2 ASC,
	nombre ASC;

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT
	nombre,
	apellido1,
	apellido2,
	telefono,
	tipo
FROM
	persona p
WHERE
	p.telefono IS NULL
	AND p.tipo = "alumno";

-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT
	nombre,
	apellido1,
	apellido2,
	fecha_nacimiento,
	tipo
FROM
	persona
WHERE
	year(fecha_nacimiento) = 1999
	AND tipo = "alumno";

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de 
-- telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT
	*
FROM
	persona
WHERE
	tipo = "profesor"
	AND telefono IS NULL
	AND nif LIKE "%k";

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el 
-- tercer curs del grau que té l'identificador 7.
SELECT
	a.nombre AS asignatura,
	a.curso,
	a.cuatrimestre,
	g.nombre AS grado
FROM
	asignatura a
	JOIN grado g ON a.id_grado = g.id
WHERE
	a.cuatrimestre = 1
	AND a.curso = 3
	AND g.id = 7;

-- Retorna un llistat dels professors/es juntament amb el nom del departament al 
-- qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, 
-- segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de 
-- menor a major pels cognoms i el nom.
SELECT
	pe.apellido1,
	pe.apellido2,
	pe.nombre,
	de.nombre
FROM
	persona pe
	JOIN profesor pr ON pe.id = pr.id_profesor
	JOIN departamento de ON pr.id_departamento = de.id
ORDER BY
	pe.apellido1 ASC,
	pe.apellido2 ASC,
	pe.nombre;

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT
	concat(
		pe.nombre,
		" ",
		pe.apellido1,
		" ",
		pe.apellido2
	) AS alumno,
	ce.anyo_inicio,
	ce.anyo_fin,
	ag.nombre AS asinatura
FROM
	persona pe
	JOIN alumno_se_matricula_asignatura al ON pe.id = al.id_alumno
	JOIN asignatura ag ON al.id_asignatura = ag.id
	JOIN curso_escolar ce ON al.id_curso_escolar = ce.id
WHERE
	nif = "26902806M";

-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna 
-- assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT
	de.nombre AS departamento,
	ag.nombre AS asignatura,
	gr.nombre
FROM
	departamento de
	JOIN profesor pr ON de.id = pr.id_departamento
	JOIN persona pe ON pr.id_profesor = pe.id
	JOIN asignatura ag ON pr.id_profesor = ag.id_profesor
	JOIN grado gr ON ag.id_grado = gr.id
WHERE
	gr.id = 4;

-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT
	concat(
		pe.nombre,
		" ",
		pe.apellido1,
		" ",
		pe.apellido2
	) AS alumno,
	concat(cu.anyo_inicio, "/", cu.anyo_fin) AS "curso escolar"
FROM
	persona pe
	JOIN alumno_se_matricula_asignatura al ON pe.id = al.id_alumno
	JOIN curso_escolar cu ON al.id_curso_escolar = cu.id
WHERE
	cu.anyo_inicio = 2018
group BY
	pe.apellido1;

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT
	de.nombre AS departamento,
	pe.apellido1,
	pe.apellido2,
	pe.nombre
FROM
	persona pe
	LEFT JOIN profesor pr ON pe.id = pr.id_profesor
	LEFT JOIN departamento de ON pr.id_departamento = de.id
WHERE
	pe.tipo = "profesor"
ORDER BY
	departamento ASC,
	pe.apellido1 ASC,
	pe.apellido2 ASC,
	pe.nombre ASC;

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT
	de.nombre AS departamento,
	pe.apellido1,
	pe.apellido2,
	pe.nombre
FROM
	persona pe
	LEFT JOIN profesor pr ON pe.id = pr.id_profesor
	LEFT JOIN departamento de ON pr.id_departamento = de.id
WHERE
	pe.tipo = "profesor"
	AND de.nombre IS NULL
ORDER BY
	departamento ASC,
	pe.apellido1 ASC,
	pe.apellido2 ASC,
	pe.nombre ASC;

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT
	de.nombre
FROM
	departamento de
	LEFT JOIN profesor pr ON de.id = pr.id_departamento
WHERE
	pr.id_departamento IS NULL;

-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT
	concat(
		pe.nombre,
		" ",
		pe.apellido1,
		" ",
		pe.apellido2
	) AS Profesor,
	ag.nombre AS asignatura
FROM
	persona pe
	LEFT JOIN profesor pr ON pe.id = pr.id_profesor
	LEFT JOIN asignatura ag ON pr.id_profesor = ag.id_profesor
WHERE
	pe.tipo = "profesor"
	AND ag.id_profesor IS NULL;

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT
	de.nombre AS departamento,
	ag.nombre AS asignatura
FROM
	departamento de
	LEFT JOIN profesor pr ON de.id = pr.id_departamento
	LEFT JOIN asignatura ag ON pr.id_profesor = ag.id_profesor
WHERE
	ag.id IS NULL;

-- Retorna el nombre total d'alumnes que hi ha.
SELECT
	count(*) AS "numero de alumnos"
FROM
	persona
WHERE
	tipo = "alumno";

-- Calcula quants alumnes van néixer en 1999.
SELECT
	count(*) AS "numero de alumnos"
FROM
	persona
WHERE
	tipo = "alumno"
	AND year(fecha_nacimiento) = "1999";

-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, 
-- una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major 
-- a menor pel nombre de professors/es.
SELECT
	de.nombre AS departemento,
	count(*) AS "numero de profesores"
FROM
	departamento de
	JOIN profesor pr ON de.id = pr.id_departamento
group BY
	de.nombre;

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadASCun d'ells. Tingui en compte que 
-- poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT
	de.nombre AS departemento,
	count(pr.id_profesor) AS "numero profesores"
FROM
	departamento de
	LEFT JOIN profesor pr ON de.id = pr.id_departamento
group BY
	de.nombre;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadASCun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT
	gr.nombre AS grado,
	count(ag.id) AS "numero de asignaturas"
FROM
	grado gr
	LEFT JOIN asignatura ag ON gr.id = ag.id_grado
group BY
	gr.id;

--Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures 
--que té cadASCun, dels graus que tinguin més de 40 assignatures associades.
SELECT
	g.nombre,
	count(a.nombre) AS "numero asignaturas"
FROM
	universidad.grado g
	JOIN asignatura a ON a.id_grado = g.id
group BY
	g.nombre
having
	count(a.nombre) > 40;

--Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
--El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT
	g.nombre AS grado,
	a.tipo AS "tipo de asignaturaa",
	sum(a.creditos) AS "total creditos"
FROM
	universidad.grado g
	JOIN asignatura a ON a.id_grado = g.id
group BY
	g.nombre,
	a.tipo;

--Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadASCun dels cursos escolars. 
--El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT
	ce.anyo_inicio,
	count(al.id) AS "numero alumnos matriculados"
FROM
	universidad.persona al
	JOIN alumno_se_matricula_asignatura am ON am.id_alumno = al.id
	JOIN curso_escolar ce ON ce.id = am.id_curso_escolar
group BY
	ce.anyo_inicio;

-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no 
--imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
--El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT
	pe.id,
	pe.nombre,
	pe.apellido1,
	pe.apellido2,
	count(a.nombre)
FROM
	universidad.profesor pr
	LEFT JOIN asignatura a ON a.id_profesor = pr.id_profesor
	JOIN persona pe ON pe.id = pr.id_profesor
group BY
	pe.id,
	pe.nombre,
	pe.apellido1,
	pe.apellido2;

--Retorna totes les dades de l'alumne/a més jove.
SELECT
	*
FROM
	universidad.persona
WHERE
	fecha_nacimiento = (
		SELECT
			max(fecha_nacimiento)
		FROM
			universidad.persona
		WHERE
			tipo = "alumno"
	);

--Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT
	concat(
		pe.nombre,
		" ",
		pe.apellido1,
		" ",
		pe.apellido2
	) AS Profesor,
	dp.nombre AS departamento
FROM
	universidad.persona pe
	JOIN profesor pr ON pr.id_profesor = pe.id
	LEFT JOIN asignatura ag ON ag.id_profesor = pr.id_profesor
	LEFT JOIN departamento dp ON dp.id = pr.id_departamento
WHERE
	ag.id_profesor IS NULL;









