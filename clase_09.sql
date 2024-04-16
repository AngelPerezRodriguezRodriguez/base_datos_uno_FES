USE colegio;
/*
El producto cartesiano es la multiplicación de todos los renglones de una tabla
por todos los renglones de otra, y la suma de los campos de la primera y la segunda.
No nos da información real pero es la base para la futura operación JOIN.

Para el producto cartesiano no importa el orden en que realicemos la multiplicación. 
Pero como buena práctica hay que poner como primera tabla la que será el eje
de las relaciones. Nuestras operaciones o consultas, en algún momento se van a ir 
degradando al trabajar con un gran número de renglones.

La operación que debemos realizar para que se cumpla el modelo relacional es el JOIN.
El JOIN es el producto cartesiano más la igualdad de la llave primaria y foránea.
Obtenemos información válida, ej. a qué pago pertenece qué alumno.
*/



SELECT *
FROM salones;
-- 191 registros

SELECT *
FROM cursos;
-- 4 registros

SELECT *
FROM grados;
-- 17 registros

SELECT *
FROM niveles;
-- 7 registros



SELECT * 
FROM 
salones, 
cursos
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 = 764 registros
--   6 + 5 =  11 campos

SELECT * 
FROM 
salones, 
cursos,
grados
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 x 17 = 12988 registros
--   6 + 5 +  2 =    13 campos

SELECT * 
FROM 
salones, 
cursos,
grados,
niveles
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 x 17 x 7 = 90916 registros
--   6 + 5 +  2 + 2 =    15 campos

SELECT * 
FROM 
salones, 
cursos, 
grados, 
niveles
WHERE id_salon = 1;
-- Cada salón aparece 4 x 17 x 7 = 476 veces



SELECT * 
FROM 
salones s, 
cursos c
WHERE s.id_curso = c.id_curso 
ORDER BY 1;
/*
 * Obtenemos 191 registros

 * Para que el producto cartesiano se convierta en un JOIN igualamos PK y FK
 * El número máximo de registros de un JOIN depende de la tabla eje, pero pueden ser menos
 * También podemos renombrar las tablas
 */

SELECT *
FROM
salones s,
cursos c,
grados g
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado
ORDER BY 1;
-- Obtenemos 191 registros

SELECT *
FROM
salones s,
cursos c,
grados g,
niveles n
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado AND
s.id_nivel = n.id_nivel
ORDER BY 1;
/*
Obtenemos 198 registros.

Existen salones que no tienen un nivel:

SELECT * FROM salones
WHERE id_nivel = 0;

Cero no existe en la tabla niveles, es decir,
no es un id_nivel válido.

Listamos los salones y a qué curso, grado y nivel pertenecen (sentencia actual INNER JOIN)
no es lo mismo que
listamos todos los salones (sentencia diferente).
*/

SELECT *
FROM
salones
WHERE
id_nivel NOT IN(
	SELECT id_nivel 
    FROM niveles
)
ORDER BY 1;
-- ... obtenemos los registros faltantes

SELECT *
FROM
salones
WHERE
id_nivel NOT IN(1, 2, 3, 4, 5, 6, 7)
ORDER BY 1;
-- ... misma sentencia que la anterior

/*
Las subconsultas pueden ocuparse en cualquier parte de una consulta SQL.
Si no conocemos los valores válidos o son demasiados, realizamos una subconsulta.
Si en la subconsulta se define más de un campo, IN no sabe qué valores evaluar.

Nuestra subconsulta SELECT obtiene una lista de valores que serán parámetros de 
nuestra consulta principal SELECT. Las subconsultas forman parte de una 
consulta de nivel superior. 
*/



SELECT *
FROM
salones s,
cursos c,
grados g,
niveles n
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado AND
s.id_nivel = n.id_nivel
ORDER BY 1;


SELECT 
s.id_salon AS s_salon, 
s.observaciones AS s_observaciones,  
c.id_curso AS c_curso, 
c.nombre AS c_nombre
FROM 
salones s, 
cursos c
WHERE s.id_curso = c.id_curso;

SELECT 
s.id_salon AS s_salon, 
s.observaciones AS s_observaciones,  
c.id_curso AS c_curso, 
c.nombre AS c_nombre, 
g.nombre AS g_nombre
FROM 
salones s, 
cursos c, 
grados g
WHERE 
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado;

SELECT
s.id_salon AS s_salon, 
s.observaciones AS s_observaciones,  
c.id_curso AS c_curso, 
c.nombre AS c_nombre, 
g.nombre AS g_nombre,
n. nombre AS n_nombre
FROM
salones s,
cursos c,
grados g,
niveles n
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado AND
s.id_nivel = n.id_nivel
ORDER BY 1;
-- Para que parezca un reporte hay que realizar una proyección adecuada,
-- pues tenemos muchos campos. Filtramos los campos que nos interesan por tabla



SELECT
id_salon,
observaciones AS s_observaciones,
abreviatura AS c_abreviatura,
g.nombre AS g_nombre,
n.nombre AS n_nombre
FROM
salones s,
cursos c,
grados g,
niveles n
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado AND
s.id_nivel = n.id_nivel AND
n.nombre = 'secundaria'
ORDER BY 4;
-- El filtro debe de definirse por los datos que nos piden
-- Listamos los salones de secundaria

SELECT
id_salon,
observaciones AS s_observaciones,
abreviatura AS c_abreviatura,
g.nombre AS g_nombre,
n.nombre AS n_nombre
FROM
salones s,
cursos c,
grados g,
niveles n
WHERE
s.id_curso = c.id_curso AND
s.id_grado = g.id_grado AND
s.id_nivel = n.id_nivel AND
n.nombre = 'secundaria' AND
g.nombre = '3o'
ORDER BY 4;
-- ... listamos los salones de tercero de secundaria



SELECT *
FROM salones
WHERE id_nivel IN(1, 2, 3, 4, 5, 6, 7);
-- Listamos los salones que tienen un nivel válido

SELECT *
FROM salones
WHERE id_nivel IN(
	SELECT id_nivel 
    niveles
);
-- ... misma sentencia que la anterior

SELECT *
FROM salones
WHERE id_nivel NOT IN(1, 2, 3, 4, 5, 6, 7);
-- Listamos los salones que no tienen un nivel válido

SELECT *
FROM salones
WHERE id_nivel NOT IN(
	SELECT id_nivel 
    FROM niveles
);
-- ... misma sentencia que la anterior

SELECT *
FROM salones
WHERE id_nivel IN(
	SELECT id_nivel 
    FROM niveles 
    WHERE id_nivel > 2
);
-- Listamos los salones que tienen un nivel mayor que dos



SELECT COUNT(*)
FROM pagos;
-- 4642 registros

SELECT COUNT(*)
FROM alumnos;
-- 808 registros

SELECT COUNT(*)
FROM cursos;
-- 4 registros



SELECT COUNT(*)
FROM 
pagos,
alumnos;
-- 808 x 4642 = 3750736
-- Usamos COUNT porque son demasiados registros para el buffer


SELECT * 
FROM 
pagos,
alumnos 
LIMIT 10;
-- Si es necesario ver la estructura, limitamos los renglones



SELECT *
FROM 
pagos p,
alumnos a
WHERE
p.clave_alu = a.clave_alu
ORDER BY 1;
-- Obtenemos 4642 registros

SELECT *
FROM 
pagos p,
alumnos a,
cursos c
WHERE
p.clave_alu = a.clave_alu AND
p.id_curso = c.id_curso
ORDER BY 1;
-- Obtenemos 4641 registros
-- Existe un pago que no tiene curso

SELECT *
FROM 
pagos
WHERE
id_curso NOT IN (
	SELECT id_curso 
    FROM cursos
);
-- ... obtenemos el registro faltante



SELECT
a.clave_alu AS a_clave_alu,
a.ap_paterno AS a_ap_paterno,
a.ap_materno AS a_ap_materno,
a.nombre AS a_nombre,
p.pago AS p_pago,
p.fecha_pago AS p_fecha_pago,
c.abreviatura AS c_abreviatura
FROM 
pagos p,
alumnos a,
cursos c
WHERE
p.clave_alu = a.clave_alu AND
p.id_curso = c.id_curso
ORDER BY 1;
-- ... para que parezca un reporte hay que realizar una proyección adecuada

SELECT
a.clave_alu AS a_clave_alu,
a.ap_paterno AS a_ap_paterno,
a.ap_materno AS a_ap_materno,
a.nombre AS a_nombre,
p.pago AS p_pago,
p.fecha_pago AS p_fecha_pago,
c.abreviatura AS c_abreviatura
FROM 
pagos p,
alumnos a,
cursos c
WHERE
p.clave_alu = a.clave_alu AND
p.id_curso = c.id_curso AND
p.pago < 2000 AND
a.sexo = 'f'
ORDER BY 1;
-- Listamos las mujeres con pagos menores a dos mil

SELECT
a.clave_alu AS a_clave_alu,
a.ap_paterno AS a_ap_paterno,
a.ap_materno AS a_ap_materno,
a.nombre AS a_nombre,
p.pago AS p_pago,
p.fecha_pago AS p_fecha_pago,
c.abreviatura AS c_abreviatura
FROM 
(SELECT * FROM pagos WHERE pago < 2000) p,
(SELECT * FROM alumnos WHERE sexo = 'f') a,
cursos c
WHERE
p.clave_alu = a.clave_alu AND
p.id_curso = c.id_curso
ORDER BY 1;
/*
Podemos hacer uso de consultas anidadas para que la consulta principal sea más ágil,
es decir, conseguimos que el tiempo de ejecución sea menor.

Sin consultas anidadas 

 * Realizamos el producto cartesiano:
   4642 pagos x 808 alumnos x 4 cursos
 * Aplicamos los filtros 
 * Igualamos PK y FK

Con consultas anidadas 

 * Realizamos el producto cartesiano con filtros aplicados:
   728 pagos x 283 alumnos x 4 cursos
 * Igualamos PK y FK
 */