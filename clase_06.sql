USE colegio;

SELECT COUNT(*), SUM(peso), AVG(peso), MAX(peso), MIN(peso) 
FROM alumnos;

SELECT sexo, COUNT(*), SUM(peso), AVG(peso), MAX(peso), MIN(peso) 
FROM alumnos 
GROUP BY sexo
ORDER BY 1;

SELECT sexo, COUNT(*), SUM(peso), AVG(peso), MAX(peso), MIN(peso) 
FROM alumnos 
WHERE ciudad = 'queretaro'
GROUP BY sexo
ORDER BY 1;

SELECT 
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
AVG(peso) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min 
FROM alumnos 
GROUP BY sexo
ORDER BY 1;

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
ORDER BY 1, 2;

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
ORDER BY 5 DESC;

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
ORDER BY 5 DESC;

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
ORDER BY 5 DESC;

SELECT 
ciudad,
sexo AS sexo_bio, 
COUNT(*) AS no_alu, 
SUM(peso) AS suma_peso, 
format(AVG(peso), 2) AS prom_peso, 
MAX(peso) AS peso_max, 
MIN(peso) AS peso_min,
format(AVG(peso) * 1000, 2) AS prom_peso_g
FROM alumnos 
WHERE peso > 0
GROUP BY ciudad, sexo
HAVING prom_peso >= 40 AND
prom_peso <= 50
ORDER BY 5 DESC;

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
fedita LIKE '2017%'
ORDER BY imc;

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
fedita LIKE '2017%'
ORDER BY imc;

SELECT *
FROM alumnos
WHERE
NOT sexo = 'f'
ORDER BY imc;

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

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre BETWEEN 'pedro' AND 'wendy';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre BETWEEN 'algo' AND 'patito23';

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

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'ALDO';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'ALDO%';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '%ALDO';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '%ALDO%';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE 'M%';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '____';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '_a__';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '_a%';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
nombre LIKE '% %';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
NOT nombre LIKE '% %';

SELECT 
nombre, 
ap_paterno, 
ap_materno, 
peso, 
estatura
FROM alumnos
WHERE 
fedita LIKE '2017%';