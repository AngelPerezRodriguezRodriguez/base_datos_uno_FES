USE colegio;
/*
COUNT(*)
SUM()
AVG()
MAX()
MIN()

BETWEEN 
IN
LIKE 

FORMAT(numero, no_decimales)
*/



SELECT 
COUNT(*), 
SUM(peso), 
AVG(peso), 
MAX(peso), 
MIN(peso) 
FROM alumnos;
-- Usamos funciones de agregación en la tabla alumnos

SELECT 
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
GROUP BY sexo
ORDER BY sexo;
-- Usamos funciones de agregación en los alumnos 
-- con base a la agrupación por sexo
-- con los registros ordenados por sexo

SELECT 
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min  
FROM alumnos 
WHERE ciudad = 'queretaro'
GROUP BY sexo
ORDER BY sexo;
-- ... que viven en 'queretaro'



SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
ORDER BY ciudad, sexo;
-- Usamos funciones de agregación en los alumnos 
-- con base a la agrupación por ciudad y sexo
-- que pesen más que cero
-- con los registros ordenados por ciudad y sexo

SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
ORDER BY prom_peso DESC;
-- ... con los registros ordenados en forma descendente por el promedio del peso

SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
HAVING prom_peso <= 50
ORDER BY prom_peso DESC;
-- ... con el promedio del peso menor o igual a cincuenta

SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
HAVING prom_peso >= 40 AND
prom_peso <= 50
ORDER BY prom_peso DESC;
-- ... con el promedio del peso mayor o igual a 40 pero menor o igual a cincuenta

SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min,
format(AVG(peso) * 1000, 2) AS prom_peso_g
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
HAVING prom_peso >= 40 AND
prom_peso <= 50
ORDER BY prom_peso DESC;
-- ... con el promedio del peso expresado en gramos y con dos decimales



SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura, 
peso / estatura * estatura AS imc
FROM alumnos
WHERE
peso IS NOT NULL AND
peso > 0 AND
estatura IS NOT NULL AND
estatura > 0
ORDER BY imc;
-- Obtenemos el índice de masa corporal de los alumnos
-- con el peso y estatura mayor que cero y diferente de NULL

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura, 
peso / estatura * estatura AS imc,
fedita
FROM alumnos
WHERE
peso IS NOT NULL AND
peso > 0 AND
estatura IS NOT NULL AND
estatura > 0 AND
fedita >= '2017-01-01 00:00:00' AND
fedita <= '2017-12-31 23:59:59'
ORDER BY imc;
-- ... donde la última fecha de edición de los datos sea de 2017

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura, 
peso / estatura * estatura AS imc,
fedita
FROM alumnos
WHERE
peso IS NOT NULL AND
peso > 0 AND
estatura IS NOT NULL AND
estatura > 0 AND NOT
(fedita >= '2017-01-01 00:00:00' AND
fedita <= '2017-12-31 23:59:59')
ORDER BY imc;
-- ... donde la última fecha de edición de los datos no sea de 2017



/*
También se pueden utilizar otras opciones:

year(fedita) = 2017
fedita LIKE '2017%'
fedita BETWEEN '2017-01-01 00:00:00' AND '2017-12-31 23:59:59'
*/



SELECT *
FROM alumnos
WHERE
NOT sexo = 'f';
-- Obtenemos los nombres de alumnos
-- que no sean mujeres

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
peso >= 90 AND 
peso <= 100
ORDER BY peso DESC;
-- Obtenemos información de los alumnos
-- con el peso mayor o igual que noventa y menor o igual a cien

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
peso BETWEEN 90 AND 100
ORDER BY peso DESC;
-- ... misma sentencia pero con BETWEEN

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
NOT (peso >= 90 AND 
peso <= 100)
ORDER BY peso DESC;
-- ... con el peso menor o igual que noventa y mayor o igual a cien

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
NOT peso BETWEEN 90 AND 100
ORDER BY peso DESC;
-- ... misma sentencia pero con BETWEEN

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre BETWEEN 'pedro' AND 'wendy';
-- Obtenemos información de los alumnos
-- con el nombre entre 'pedro' y 'wendy'



SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre ='mariana' OR
nombre = 'gabriela' OR 
nombre ='pamela' OR
nombre = 'carolina';
-- Obtenemos información de los alumnos
-- que cumpla con una lista de nombres

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre IN ('mariana', 'gabriela', 'pamela', 'carolina')
ORDER BY nombre;
-- ... misma sentencia pero con IN

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre ='mariana' OR
nombre = 'gabriela' OR 
nombre ='pamela' OR
nombre = 'carolina';
-- ... que no cumpla con una lista de nombres

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
NOT nombre IN ('mariana', 'gabriela', 'pamela', 'carolina')
ORDER BY nombre;
-- ... misma sentencia pero con IN



SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'aldo';
-- Obtenemos información de los alumnos
-- que cumpla en el nombre sólo con 'aldo'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'aldo%';
-- ... que cumpla al principio del nombre con 'aldo'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '%aldo';
-- ... que cumpla al final del nombre con 'aldo'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '%aldo%';
-- ... que cumpla en el nombre con 'aldo'



SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'm%';
-- ... que cumpla al principio del nombre con la letra 'm'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '____';
-- ... que cumpla en el nombre sólo con cuatro espacios

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '_a__';
-- ... que cumpla en el nombre sólo con cuatro espacios
-- ... y en su segunda posición con la letra 'a'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '_a%';
-- ... que cumpla en el nombre en su segunda posición con la letra 'a'

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '% %';
-- ... que cumpla con dos nombres

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
NOT nombre LIKE '% %';
-- -- ... que cumpla con un sólo nombre