USE colegio;
/*
RIGHT JOIN
RIGHT JOIN (WHERE a.key IS NULL)

LEFT JOIN
LEFT JOIN (WHERE b.key IS NULL)

UNION

FULL OUTER JOIN
FULL OUTER JOIN (WHERE a.key IS NULL OR b.key IS NULL)


Estructura de vistas

Tablas pivote
*/



SELECT 
    *
FROM
    salones;
-- 191 registros

SELECT 
    *
FROM
    niveles;
-- 7 registros



SELECT 
    *
FROM
    salones s
        JOIN
    niveles n ON (s.id_nivel = n.id_nivel);
/*
INNER JOIN.
189 registros.
Existen dos salones que no tienen nivel.
*/

SELECT 
    *
FROM
    salones s
        LEFT JOIN
    niveles n ON (s.id_nivel = n.id_nivel);
/*
LEFT JOIN.
191 registros.
Obtenemos todos los salones aunque no tengan nivel.
*/

SELECT 
    *
FROM
    salones s
        LEFT JOIN
    niveles n ON (s.id_nivel = n.id_nivel)
WHERE
    n.id_nivel IS NULL;
/* 
LEFT JOIN (WHERE b.key IS NULL).
2 registros.
Obtenemos todos los salones que no tengan nivel.
*/

SELECT 
    *
FROM
    salones s
        RIGHT JOIN
    niveles n ON (s.id_nivel = n.id_nivel);
/*
RIGHT JOIN.
194 registros.
Obtenemos todos los niveles aunque no tengan salón.
*/

SELECT 
    *
FROM
    salones s
        RIGHT JOIN
    niveles n ON (s.id_nivel = n.id_nivel)
WHERE
    s.id_nivel IS NULL;
/*
RIGHT JOIN (WHERE a.key IS NULL).
5 registros.
Obtenemos todos los niveles que no tengan salón.
*/



SELECT 
    id_grado, nombre AS elemento
FROM
    grados;
-- 17 registros

SELECT 
    id_nivel, nombre AS elemento
FROM
    niveles;
-- 7 registros



/*
UNION es la suma de los renglones de una tabla más los renglones de otra, pero para lograrlo
ambas tablas deben tener el mismo número de campos y de preferencia con las mismas restricciones. 
Los registros se muestran de acuerdo al orden de las tablas en la operación UNION.

El nombre de los campos de la primera tabla en la operación UNION va a definir el nombre 
de los campos que pertenecen a la proyección de la operación.
*/



SELECT 
    id_grado AS numero, nombre AS elemento
FROM
    grados 
UNION SELECT 
    id_nivel, nombre
FROM
    niveles;



SELECT 
    *
FROM
    alumnos;
-- 808 registros

SELECT 
    *
FROM
    profesores;
/*
123 registros.
No podemos hacer un UNION directo entre alumnos y profesores,
pero sí a través de una selección de campos.
*/



SELECT 
    clave_alu AS clave,
    CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
    curp,
    sexo
FROM
    alumnos 
UNION SELECT 
    clave_prof,
    CONCAT_WS(' ', apellido_p, apellido_m, nombres),
    curp,
    sexo
FROM
    profesores
ORDER BY 2;
-- 808 + 123 = 931 registros
-- Obtenemos todas las personas de la B.D. incluyendo alumnos y profesores



SELECT 
    clave_alu AS clave,
    CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
    curp,
    sexo,
    'alumno' AS tipo
FROM
    alumnos 
UNION SELECT 
    clave_prof,
    CONCAT_WS(' ', apellido_p, apellido_m, nombres),
    curp,
    sexo,
    'profesor'
FROM
    profesores
ORDER BY 2;
-- ... definimos quién es alumno y quién es profesor con un nuevo campo



SELECT 
    clave_alu AS clave,
    CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
    curp,
    sexo,
    'alumno' AS tipo
FROM
    alumnos
WHERE
    CONCAT_WS(' ', ap_paterno, ap_materno, nombre) LIKE '%aguilar%' 
UNION SELECT 
    clave_prof,
    CONCAT_WS(' ', apellido_p, apellido_m, nombres),
    curp,
    sexo,
    'profesor'
FROM
    profesores
WHERE
    CONCAT_WS(' ', apellido_p, apellido_m, nombres) LIKE '%aguilar%'
ORDER BY 2;
-- ... que se apelliden 'aguilar'



SELECT 
    *
FROM
    (SELECT 
        clave_alu AS clave,
            CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
            curp,
            sexo,
            'alumno' AS tipo
    FROM
        alumnos UNION SELECT 
        clave_prof,
            CONCAT_WS(' ', apellido_p, apellido_m, nombres),
            curp,
            sexo,
            'profesor'
    FROM
        profesores) p
WHERE
    persona LIKE '%AGUILAR%'
ORDER BY 2;
-- ... misma sentencia que la anterior pero a través de una subconsulta
-- ... cualquier tabla derivada debe tener su propio alias



SELECT 
    sexo, COUNT(*) AS no_personas
FROM
    (SELECT 
        clave_alu AS clave,
            CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
            curp,
            sexo,
            'alumno' AS tipo
    FROM
        alumnos UNION SELECT 
        clave_prof,
            CONCAT_WS(' ', apellido_p, apellido_m, nombres),
            curp,
            sexo,
            'profesor'
    FROM
        profesores) p
GROUP BY sexo
ORDER BY 1;
-- Obtenemos cuántas personas hay por sexo
-- con los registros ordenados por el sexo



SELECT 
    *
FROM
    (SELECT 
        clave_alu AS clave,
            CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
            curp,
            sexo,
            'alumno' AS tipo
    FROM
        alumnos UNION SELECT 
        clave_prof,
            CONCAT_WS(' ', apellido_p, apellido_m, nombres),
            curp,
            sexo,
            'profesor'
    FROM
        profesores) pe
        LEFT JOIN
    (SELECT 
        clave_alu AS clave,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) pa ON (pe.clave = pa.clave)
ORDER BY 2;
/* 
LEFT JOIN.
931 registros.
Obtenemos de todas las personas, su número y total de pagos.
*/



SELECT 
    pe.clave,
    pe.persona,
    pe.curp,
    pe.sexo,
    pe.tipo,
    IFNULL(pa.no_pagos, 0) AS no_pagos,
    IFNULL(pa.total_pagos, 0) AS total_pagos
FROM
    (SELECT 
        clave_alu AS clave,
            CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
            curp,
            sexo,
            'alumno' AS tipo
    FROM
        alumnos UNION SELECT 
        clave_prof,
            CONCAT_WS(' ', apellido_p, apellido_m, nombres),
            curp,
            sexo,
            'profesor'
    FROM
        profesores) pe
        LEFT JOIN
    (SELECT 
        clave_alu AS clave,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) pa ON (pe.clave = pa.clave)
ORDER BY 2;
-- ... para que parezca un reporte hay que realizar una proyección adecuada



SELECT 
    *
FROM
    (SELECT 
        pe.clave,
            pe.persona,
            pe.curp,
            pe.sexo,
            pe.tipo,
            IFNULL(pa.no_pagos, 0) AS no_pagos,
            IFNULL(pa.total_pagos, 0) AS total_pagos
    FROM
        (SELECT 
        clave_alu AS clave,
            CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
            curp,
            sexo,
            'alumno' AS tipo
    FROM
        alumnos UNION SELECT 
        clave_prof,
            CONCAT_WS(' ', apellido_p, apellido_m, nombres),
            curp,
            sexo,
            'profesor'
    FROM
        profesores) pe
    LEFT JOIN (SELECT 
        clave_alu AS clave,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) pa ON (pe.clave = pa.clave)) t
WHERE
    total_pagos > 20000
ORDER BY 2;
/*
Obtenemos de todas las personas, su número de pagos y total de pagos mayor que 20,000.

Campos con funciones de agregación que en otro momento filtramos con un HAVING,
ahora que forman parte de una subconsulta y ya no existe un agrupamiento, 
podemos tomar dichos campos como normales y ser filtrados con WHERE.
*/



/*
Una de las características que nos debe proporcionar un S.G.B.D. son las herramientas 
para conseguir la independencia lógica de una B.D.

Imaginemos que sí tenemos una tabla personas, pero con el tiempo fue separada en
alumnos y profesores. Por lo tanto, nuestra aplicación que utiliza la tabla personas en 
una sentencia deja de funcionar.

Entre otras cosas que nos pueden ayudar a la independencia lógica son las vistas. 
Poseen la estructura de una tabla pero sin campos o datos propios, dichos elementos 
se consiguen a través de la proyección de una o más consultas.

Si ya tenemos una consulta bien elaborada para personas, en vez de que los programadores
ejecuten directamente la sentencia con el operador UNION para obtener la lista de personas, 
pueden ejecutar la misma sentencia pero como una estructura llamada vista.

Las vistas no deben contener ORDER BY.

Sirven para ocultar información a personas sin privilegios, también para simplificar 
consultas, sobre todo si las ocupamos frecuentemente. Las vistas pueden ser tan sencillas
como queramos.
*/



CREATE OR REPLACE VIEW personas AS
    SELECT 
        clave_alu AS clave,
        CONCAT_WS(' ', ap_paterno, ap_materno, nombre) AS persona,
        curp,
        sexo,
        'alumno' AS tipo
    FROM
        alumnos 
    UNION SELECT 
        clave_prof,
        CONCAT_WS(' ', apellido_p, apellido_m, nombres),
        curp,
        sexo,
        'profesor'
    FROM
        profesores;
-- Obtenemos una vista de todas las personas de la B.D.



SELECT 
    *
FROM
    personas;

DESC personas;

SELECT 
    *
FROM
    personas
WHERE
    sexo = 'f';



SELECT 
    *
FROM
    (SELECT 
        clave,
            persona,
            curp,
            sexo,
            tipo,
            IFNULL(no_pagos, 0) AS no_pagos,
            IFNULL(total_pagos, 0) AS total_pagos
    FROM
        personas p
    LEFT JOIN (SELECT 
        clave_alu,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) g ON (p.clave = g.clave_alu)) x
WHERE
    total_pagos > 20000
ORDER BY 2;
-- Obtenemos de todas las personas, su número de pagos y total de pagos mayor que 20,000
-- pero a través de la vista que contiene todas las personas de la B.D.



CREATE OR REPLACE VIEW personas_sueldo AS
    SELECT 
        *
    FROM
        (SELECT 
            clave,
                persona,
                curp,
                sexo,
                tipo,
                IFNULL(no_pagos, 0) AS no_pagos,
                IFNULL(total_pagos, 0) AS total_pagos
        FROM
            personas p
        LEFT JOIN (SELECT 
            clave_alu,
                id_curso,
                COUNT(pago) AS no_pagos,
                SUM(pago) AS total_pagos
        FROM
            pagos
        GROUP BY clave_alu , id_curso) g ON (p.clave = g.clave_alu)) x
    WHERE
        total_pagos > 20000;
-- ... misma sentencia que la anterior pero a través de una vista

SELECT 
    *
FROM
    personas_sueldo;



CREATE OR REPLACE VIEW estudiantes AS
    SELECT 
        *
    FROM
        alumnos;
-- Esta vista es simplemente un alias

SELECT 
    *
FROM
    estudiantes;



CREATE OR REPLACE VIEW mujeres AS
    SELECT 
        *
    FROM
        estudiantes
    WHERE
        sexo = 'f';

SELECT 
    *
FROM
    mujeres;

CREATE OR REPLACE VIEW hombres AS
    SELECT 
        *
    FROM
        estudiantes
    WHERE
        sexo = 'm';

SELECT 
    *
FROM
    hombres;



/*
DROP VIEW estudiantes;

Para que una vista funcione necesita de todos los elementos que la conforman. Si eliminamos 
la vista estudiantes, no eliminamos ningún registro de la tabla alumnos, pero no podremos 
hacer uso de la vista mujeres y hombres que dependen de dicha vista.

No existe un ALTER VIEW para la estructura, para ello existe el mismo CREATE OR REPLACE VIEW, 
porque como hemos dicho, los campos no le pertenecen.
*/



SELECT 
    *
FROM
    salones s
        LEFT JOIN
    niveles n ON (s.id_nivel = n.id_nivel) 
UNION SELECT 
    *
FROM
    salones s
        RIGHT JOIN
    niveles n ON (s.id_nivel = n.id_nivel);
/*
FULL OUTER JOIN.
196 registros.
Obtenemos todos los salones aunque no tengan nivel y todos los niveles aunque no tengan salón.
*/



SELECT 
    s.id_salon,
    s.id_grado,
    s.id_nivel AS s_id_nivel,
    s.observaciones,
    s.tipo_grupo,
    s.id_curso,
    n.id_nivel AS n_id_nivel,
    n.nombre
FROM
    salones s
        LEFT JOIN
    niveles n ON (s.id_nivel = n.id_nivel)
WHERE
    n.id_nivel IS NULL 
UNION SELECT 
    *
FROM
    salones s
        RIGHT JOIN
    niveles n ON (s.id_nivel = n.id_nivel)
WHERE
    s.id_nivel IS NULL;
-- FULL OUTER JOIN (WHERE a.key IS NULL OR b.key IS NULL)
-- Obtenemos todos los salones que no tengan nivel y todos los niveles que no tengan salón



SELECT 
    *
FROM
    (SELECT 
        s.id_salon,
            s.id_grado,
            s.id_nivel AS s_id_nivel,
            s.observaciones,
            s.tipo_grupo,
            s.id_curso,
            n.id_nivel AS n_id_nivel,
            n.nombre
    FROM
        salones s
    LEFT JOIN niveles n ON (s.id_nivel = n.id_nivel) UNION SELECT 
        *
    FROM
        salones s
    RIGHT JOIN niveles n ON (s.id_nivel = n.id_nivel)) x
WHERE
    s_id_nivel IS NULL OR n_id_nivel IS NULL;
-- ... misma sentencia que la anterior pero a través de una subconsulta



SELECT 
    *
FROM
    alumno_salon;
-- Tabla relación del alumno y los salones en los que ha estado



SELECT 
    abreviatura, sexo, COUNT(*) AS no_alumnos
FROM
    alumnos a
        JOIN
    alumno_salon AS sa ON (a.clave_alu = sa.clave_alu)
        JOIN
    cursos AS c ON (c.id_curso = sa.id_curso)
GROUP BY abreviatura , sexo;
-- Obtenemos cuántos alumnos hay por sexo y ciclo escolar



/*
Una de las cuestiones principales de mostrar datos es una correcta visualización.
Para construir la sentencia de una tabla pivote vamos a rotar y agrupar, es decir, 
lo que tenemos como registro lo vamos a definir como columna.

En la B.D. es más viable el incremento en ciclos escolares que en sexo.
Por lo tanto, nuestro elemento a rotar, el que no va a cambiar, va a ser sexo. Es
recomendable usar la tabla pivote en tablas que no tengan muchos valores a rotar.

Así que vamos a construir una tabla que tenga 
por columnas cada posible valor de sexo (rotar) y
por registros los ciclos escolares (agrupar).
*/



SELECT 
    abreviatura,
    SUM(IF(sexo = 'f', no_alumnos, 0)) AS femenino,
    SUM(IF(sexo = 'm', no_alumnos, 0)) AS masculino,
    SUM(IF(sexo = '', no_alumnos, 0)) AS no_definido
FROM
    (SELECT 
        abreviatura, sexo, COUNT(*) AS no_alumnos
    FROM
        alumnos a
    JOIN alumno_salon AS sa ON (a.clave_alu = sa.clave_alu)
    JOIN cursos AS c ON (c.id_curso = sa.id_curso)
    GROUP BY abreviatura , sexo) x
GROUP BY abreviatura;
/*
La consulta anidada es la misma que queremos rotar desde un inicio.
La rotación es la proyección de la consulta principal y
la agrupación es el GROUP BY de la consulta principal.
*/