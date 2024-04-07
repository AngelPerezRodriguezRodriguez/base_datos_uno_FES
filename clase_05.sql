USE colegio;
/*
Cargamos el esquema y el estado inicial de la B.D. colegio
a través de un único archivo que contiene ambas partes. 

La B.D. sólo contiene relaciones lógicas, es decir, no
tiene restricciones de integridad referencial.
*/



SELECT SYSDATE(), DATABASE(), USER();
-- Obtenemos los datos de una función
-- No son datos de ninguna tabla de la B.D. colegio

SELECT NOW(), SYSDATE(), CURRENT_DATE(), CURRENT_TIME();
/*
* NOW() fecha y hora cuando la sentencia NOW() es ejecutada.
En el ejemplo, la fecha y hora resultan ser iguales:

SELECT NOW() AS 'NOW() BEFORE', 
       SLEEP(5), 
       NOW() AS 'NOW() AFTER;

* SYSDATE() fecha y hora cuando la sentencia SYSDATE() es llamada.
En el ejemplo, la fecha y hora resultan diferentes:

SELECT SYSDATE() AS 'SYSDATE() BEFORE', 
       SLEEP(5), 
       SYSDATE() AS 'SYSDATE() AFTER';

* CURRENT_DATE() fecha del sistema
* CURRENT_TIME() hora del sistema
*/

SELECT 
YEAR(NOW()) AS anio, 
MONTH(NOW()) AS mes, 
DAY(NOW()) AS dia, 
YEAR(NOW()) * DAY(NOW()) AS 'anio x dia';
-- Podemos definir alias para los campos de la proyección

SELECT 
6 * 4, 
7 - 3, 
678 + 7, 
77 / 5;
-- Podemos obtener el resultado de expresiones



SHOW TABLES FROM colegio;

DESC alumnos;

SELECT * FROM alumnos;
-- Proyección: 20 campos
-- Selección: 808 registros

SELECT nombre, ap_paterno, ap_materno, curp
FROM alumnos;
-- Proyección: 4 campos
-- Selección: 808 registros

SELECT 
nombre, 
ap_paterno AS paterno, 
ap_materno AS materno, 
curp
FROM alumnos;



SELECT nombre 
FROM alumnos 
ORDER BY nombre;
-- ORDER BY por defecto es en orden ascendente

SELECT 
DISTINCT nombre 
FROM alumnos 
ORDER BY nombre;

SELECT 
DISTINCT nombre, ap_paterno 
FROM alumnos 
ORDER BY nombre;

SELECT 
DISTINCT nombre, ap_paterno, ap_materno 
FROM alumnos 
ORDER BY nombre;
-- A mayor número de campos proyectados con DISTINCT
-- mayor número de registros seleccionados



SELECT sexo
FROM alumnos
ORDER BY sexo;

SELECT 
DISTINCT sexo 
FROM alumnos 
ORDER BY sexo;

SELECT 
DISTINCT ciudad 
FROM alumnos 
ORDER BY ciudad;



SELECT * 
FROM alumnos 
WHERE sexo = 'f';

SELECT 
DISTINCT nombre 
FROM alumnos 
WHERE sexo = 'f' 
ORDER BY nombre;
-- Obtenemos los nombres de alumnos, sin repetirse, 
-- que son mujeres
-- con los registros ordenados por nombre

SELECT 
DISTINCT nombre 
FROM alumnos 
WHERE sexo = 'f' AND 
ciudad = 'queretaro' 
ORDER BY nombre;
-- ... que viven en 'queretaro'

SELECT nombre, ap_paterno, ap_materno, sexo, ciudad 
FROM alumnos 
WHERE sexo = 'f' AND 
ciudad = 'queretaro' 
ORDER BY nombre;
-- Misma sentencia pero sin DISTINCT

SELECT nombre, ap_paterno, ap_materno, sexo, ciudad 
FROM alumnos 
WHERE sexo = 'f' OR 
ciudad = 'queretaro' 
ORDER BY nombre;



SELECT COUNT(*) 
FROM alumnos;
-- Obtenemos el número de registros de la tabla

SELECT DISTINCT sexo 
FROM alumnos
ORDER BY sexo;

SELECT sexo FROM alumnos 
GROUP BY sexo
ORDER BY sexo;
-- Ambas sentencias anteriores son equivalentes
-- haciendo uso de DISTINCT y GROUP BY de forma separada



SELECT sexo, COUNT(*) 
FROM alumnos 
GROUP BY sexo
ORDER BY sexo;

/*
Pero la potencialidad de GROUP BY recae en las funciones de agregación.
En el ejemplo anterior, si usamos DISTINCT en vez de GROUP BY, 
no podemos utilizar COUNT(*):

SELECT 
DISTINCT sexo, COUNT(*) 
FROM alumnos
ORDER BY sexo;

Error Code: 1140. In aggregated query without GROUP BY, 
expression #1 of SELECT list contains nonaggregated column 'colegio.alumnos.sexo'; 
this is incompatible with sql_mode=only_full_group_by	0.000 sec
*/



SELECT ciudad, count(*) FROM alumnos
GROUP BY ciudad
ORDER BY ciudad;
-- Obtenemos cuántos alumnos hay por ciudad
-- con los registros ordenados por ciudad

SELECT ciudad, count(*) FROM alumnos
GROUP BY ciudad
ORDER BY 2 DESC;
-- ORDER BY puede usar números refiriendo a la posición
-- del campo en nuestra proyección



SELECT ciudad, count(*) FROM alumnos
WHERE sexo = 'f'
GROUP BY ciudad
ORDER BY 2 DESC;
-- Obtenemos cuántas mujeres hay por ciudad
-- con los registros ordenados de mayor a menor por el conteo

SELECT ciudad, COUNT(*) AS no_alumnos
FROM alumnos 
WHERE sexo = 'f'
GROUP BY ciudad
HAVING COUNT(*) >= 10
ORDER BY 2 DESC;
-- ... que superen las diez personas

SELECT ciudad, COUNT(*) AS no_alumnos
FROM alumnos 
WHERE sexo = 'f'
GROUP BY ciudad
HAVING COUNT(*) <= 10
ORDER BY 2 DESC;
-- ... que no sobrepasen las diez personas

SELECT ciudad, COUNT(*)
FROM alumnos
WHERE sexo = 'f'
GROUP BY ciudad
HAVING COUNT(*) <= 10
ORDER BY 2 DESC
LIMIT 5;
-- ... sólo las primeras cinco ciudades



SELECT nombre, ap_paterno, ap_materno, curp
FROM alumnos
WHERE LENGTH(curp) = 18;
-- Alumnos con CURP de 18 caracteres

SELECT nombre, ap_paterno, ap_materno, curp
FROM alumnos
WHERE LENGTH(curp) = 18
ORDER BY 2, 3, 1;
-- ... con los registros ordenados por ap_paterno, ap_materno y nombre

SELECT nombre, ap_paterno, ap_materno, curp
FROM alumnos
WHERE LENGTH(curp) = 18 AND
ciudad = 'queretaro'
ORDER BY 2, 3, 1;
-- ... que viven en 'queretaro'

SELECT nombre, ap_paterno, ap_materno, curp
FROM alumnos
WHERE LENGTH(curp) = 18 AND
ciudad = 'queretaro' AND
sexo = 'm'
ORDER BY 2, 3, 1;
-- ... que son mujeres