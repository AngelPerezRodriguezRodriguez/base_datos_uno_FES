USE colegio2459;
/*
SYSDATE()
NOW()

CURRENT_DATE()
CURDATE()

CURRENT_TIME()
CURTIME()


DATE_FORMAT(fecha, %letra_formato)
Extraé el dato de fecha dependiendo del formato definido.

YEAR()
MONTH()
DAY()
QUARTER()
WEEK()
HOUR()
MINUTE()
SECOND()
Extraé el dato de fecha en forma numérica.


EXTRACT(unidad_tiempo FROM fecha)
Extraé el dato de fecha en forma numérica.

DAYOFYEAR()
MONTHNAME()
DAYNAME()
WEEKDAY()
DAYOFWEEK()
Extraé el dato de fecha dependiendo de la función.


DATE_ADD(fecha, INTERVAL numero unidad_tiempo)
DATE_SUB(fecha, INTERVAL numero unidad_tiempo)


DATEDIFF(fecha_mayor, fecha_menor)
La diferencia entre fechas es de días.
FROM_DAYS(numero_dias)
Los días se obtienen en formato fecha.
*/



SELECT 
    SYSDATE(),
    NOW(),
    CURRENT_DATE(),
    CURDATE(),
    CURRENT_TIME(),
    CURTIME();



SELECT 
	DATE_FORMAT(SYSDATE(), '%Y'), -- '2024'
	DATE_FORMAT(SYSDATE(), '%y'), -- '24'
	DATE_FORMAT(SYSDATE(), '%u'), -- '15' semana
	DATE_FORMAT(SYSDATE(), '%j'); -- '104' día
-- Año

SELECT 
	DATE_FORMAT(SYSDATE(), '%c'), -- '4'
	DATE_FORMAT(SYSDATE(), '%m'), -- '04'
	DATE_FORMAT(SYSDATE(), '%M'), -- 'April'
	DATE_FORMAT(SYSDATE(), '%b'); -- 'Apr'
-- Mes

SELECT 
	DATE_FORMAT(SYSDATE(), '%d'), -- '13'
	DATE_FORMAT(SYSDATE(), '%D'), -- '13th'
	DATE_FORMAT(SYSDATE(), '%W'), -- 'Saturday'
	DATE_FORMAT(SYSDATE(), '%a'); -- 'Sat'
-- Día

SELECT 
	DATE_FORMAT(SYSDATE(), '%H'), -- '14'
	DATE_FORMAT(SYSDATE(), '%i'), -- '11'
	DATE_FORMAT(SYSDATE(), '%s'), -- '08'
	DATE_FORMAT(SYSDATE(), '%T'), -- '14:11:08'    formato 24h
	DATE_FORMAT(SYSDATE(), '%r'), -- '02:11:08 PM' formato 12h
	DATE_FORMAT(SYSDATE(), '%p'); -- 'PM'
-- Hora



SELECT 
    SYSDATE(),
    DATE_FORMAT(SYSDATE(), '%Y/%m/%d'),
    DATE_FORMAT(SYSDATE(), 'Hoy es %W %d de %M del %Y');
-- Extraé el dato de fecha dependiendo del formato definido



SHOW VARIABLES LIKE 'lc_time_names';
-- 'lc_time_manes' define en qué leguaje son manejadas las variables
-- de entorno para tiempo. En este caso: 'lc_time_names', 'en_US'

SET lc_time_names = 'es_MX';
-- El cambio sólo permanece hasta que finalicemos la sesión



SELECT DISTINCT
    DATE_FORMAT(fedita, '%Y/%m/%d') AS fecha,
    DATE_FORMAT(fedita,
            'El cambio fue el %W %d de %M del %Y') AS fecha_cambio
FROM
    alumnos
ORDER BY 1;
-- Existen 220 fechas diferentes

SELECT 
    nombre,
    fedita,
    DATE_FORMAT(fedita, '%Y-%m-%d') AS fecha,
    DATE_FORMAT(fedita, '%H:%i:%s') AS hora
FROM
    alumnos
ORDER BY 1;
-- Obtenemos los nombres de los alumnos
-- la fecha de edición separada en fecha y hora

SELECT 
    nombre, fedita
FROM
    alumnos
WHERE
    DATE_FORMAT(fedita, '%Y') = '2017'
ORDER BY 1;
-- ... la fecha de edición en 2017

/*
WHERE YEAR(fedita) = '2017'
WHERE LOCATE('2017', fedita) > 0
*/

SELECT 
    nombre, fedita
FROM
    alumnos
WHERE
    DATE_FORMAT(fedita, '%Y %m') = '2017 09'
ORDER BY 1;
-- ... la fecha de edición en septiembre de 2017



SELECT 
    DATE_FORMAT(fedita, '%Y') AS anio, COUNT(*) AS no_cambios
FROM
    alumnos
GROUP BY DATE_FORMAT(fedita, '%Y')
ORDER BY 1;
-- Obtenemos el número de ediciones realizadas por año

SELECT 
    DATE_FORMAT(fedita, '%Y') AS anio,
    DATE_FORMAT(fedita, '%M') AS mes,
    COUNT(*) AS no_cambios
FROM
    alumnos
GROUP BY DATE_FORMAT(fedita, '%Y') , DATE_FORMAT(fedita, '%M')
ORDER BY 1;
-- ... número de ediciones realizadas por mes

SELECT 
    DATE_FORMAT(fedita, '%Y') AS anio,
    DATE_FORMAT(fedita, '%m') AS no_mes,
    DATE_FORMAT(fedita, '%M') AS mes,
    COUNT(*) AS no_cambios
FROM
    alumnos
GROUP BY DATE_FORMAT(fedita, '%Y') , DATE_FORMAT(fedita, '%m') , DATE_FORMAT(fedita, '%M')
ORDER BY 1 , 2;
-- ... con los registros ordenados de acuerdo al calendario



SELECT 
    nombre,
    fedita,
    YEAR(fedita) AS anio,
    MONTH(fedita) AS mes,
    DAY(fedita) AS dia,
    QUARTER(fedita) AS trimestre,
    WEEK(fedita) AS semana,
    HOUR(fedita) AS hora,
    MINUTE(fedita) AS minuto,
    SECOND(fedita) AS segundo
FROM
    alumnos
ORDER BY 1;
-- Extraé el dato de fecha en forma numérica

SELECT 
    nombre,
    fedita,
    EXTRACT(YEAR FROM fedita) AS anio,
    EXTRACT(MONTH FROM fedita) AS mes,
    EXTRACT(DAY FROM fedita) AS dia,
    EXTRACT(QUARTER FROM fedita) AS trimestre,
    EXTRACT(WEEK FROM fedita) AS semana,
    EXTRACT(HOUR FROM fedita) AS hora,
    EXTRACT(MINUTE FROM fedita) AS minuto,
    EXTRACT(SECOND FROM fedita) AS segundo
FROM
    alumnos
ORDER BY 1;
-- Extraé el dato de fecha en forma numérica

SELECT 
    nombre,
    fedita,
    EXTRACT(DAY_HOUR FROM fedita) AS dia_hora,
    EXTRACT(DAY_MINUTE FROM fedita) AS dia_minuto,
    EXTRACT(DAY_SECOND FROM fedita) AS dia_segundo,
    EXTRACT(HOUR_MINUTE FROM fedita) AS hora_minuto,
    EXTRACT(HOUR_SECOND FROM fedita) AS hora_segundo,
    EXTRACT(MINUTE_SECOND FROM fedita) AS minuto_segundo
FROM
    alumnos
ORDER BY 1;
-- Se pueden definir hasta dos extracciones,
-- más de dos requieren de una anidación



SELECT 
	nombre,
	fedita,
	DAYOFYEAR(fedita), -- 326
	MONTHNAME(fedita), -- 'noviembre'
	DAYNAME(fedita),   -- 'lunes'
	WEEKDAY(fedita),   -- Lunes = 0
	DAYOFWEEK(fedita)  -- Domingo = 1
FROM 
	alumnos
ORDER BY 1;
-- Extraé el dato de fecha dependiendo de la función



SELECT 
    '2023-12-31 23:59:59' AS fecha,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 YEAR) AS add_anio,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 MONTH) AS add_mes,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 DAY) AS add_dia,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 HOUR) AS add_hora,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 MINUTE) AS add_minuto,
    DATE_ADD('2023-12-31 23:59:59',
        INTERVAL 1 SECOND) AS add_segundo;

SELECT 
    '2023-12-31 23:59:59' AS fecha,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 YEAR) AS add_anio,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 MONTH) AS add_mes,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 DAY) AS add_dia,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 HOUR) AS add_hora,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 MINUTE) AS add_minuto,
    DATE_SUB('2023-12-31 23:59:59',
        INTERVAL 1 SECOND) AS add_segundo;



SELECT 
    SYSDATE() AS hora_mexico,
    DATE_ADD(SYSDATE(), INTERVAL 7 HOUR) AS hora_espania;

SELECT 
    nombre,
    fedita,
    DATE_ADD(fedita, INTERVAL 3 MONTH) AS cad_3meses,
    DATE_ADD(fedita, INTERVAL 3 MONTH) AS cad_1trimestre
FROM
    alumnos;



SET @fecha_covid = '2020-03-13 15:23:45';

SELECT @fecha_covid;



SELECT 
    @fecha_covid,
    SYSDATE() AS fecha_actual,
    DATEDIFF(SYSDATE(), @fecha_covid) AS interv_dias,
    DATEDIFF(SYSDATE(), @fecha_covid) / 365 AS interv_anio,
    DATEDIFF(SYSDATE(), @fecha_covid) / 7 AS interv_semanas,
    DATEDIFF(SYSDATE(), @fecha_covid) * 24 AS interv_horas,
    DATEDIFF(SYSDATE(), @fecha_covid) * 24 * 60 AS interv_minutos,
    DATEDIFF(SYSDATE(), @fecha_covid) * 24 * 60 * 60 AS interv_segundos;
-- La diferencia entre fechas es de días

SELECT 
    fedita,
    SYSDATE() AS fecha_actual,
    DATEDIFF(SYSDATE(), fedita) AS interv_dias
FROM
    alumnos;



SET @fecha_nacimiento = '1998-10-19';

SELECT 
    DATEDIFF(SYSDATE(), @fecha_nacimiento) AS dias_angel,
    FROM_DAYS(DATEDIFF(SYSDATE(), @fecha_nacimiento)) tiempo_angel;
-- Los días se obtienen en formato fecha

SELECT 
    CONCAT_WS(' ',
            'Llevas',
            YEAR(FROM_DAYS(DATEDIFF(SYSDATE(), @fecha_nacimiento))),
            'años,',
            MONTH(FROM_DAYS(DATEDIFF(SYSDATE(), @fecha_nacimiento))),
            'meses y',
            DAY(FROM_DAYS(DATEDIFF(SYSDATE(), @fecha_nacimiento))),
            'días con vida') AS tiempo_angel;