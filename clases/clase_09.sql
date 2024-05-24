USE colegio2459;
/*
Producto cartesiano
JOIN con comas (INNER JOIN)
JOIN con palabra reservada (ON, USING y NATURAL)

INNER JOIN

RIGHT JOIN
RIGHT JOIN (WHERE a.key IS NULL)

LEFT JOIN
LEFT JOIN (WHERE b.key IS NULL)


El producto cartesiano es la multiplicación de todos los renglones de una tabla
por todos los renglones de otra, y la suma de los campos de la primera y la segunda.
No nos da información real, pero es la base para la futura operación JOIN.

Para el producto cartesiano no importa el orden en que realicemos la multiplicación. 
Pero como buena práctica hay que poner como primera tabla la que será el eje
de las relaciones. Nuestras operaciones o consultas, en algún momento se van a ir 
degradando al trabajar con un gran número de renglones.

La operación que debemos realizar para que se cumpla el modelo relacional es el JOIN.
El JOIN es el producto cartesiano más la igualdad de la PK y la FK.
Obtenemos información válida, ej. a qué pago pertenece qué alumno.
*/



SELECT 
    *
FROM
    salones;
-- 191 registros

SELECT 
    *
FROM
    cursos;
-- 4 registros

SELECT 
    *
FROM
    grados;
-- 17 registros

SELECT 
    *
FROM
    niveles;
-- 7 registros



SELECT 
    *
FROM
    salones,
    cursos
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 = 764 registros
--   6 + 5 =  11 campos

SELECT 
    *
FROM
    salones,
    cursos,
    grados
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 x 17 = 12988 registros
--   6 + 5 +  2 =    13 campos

SELECT 
    *
FROM
    salones,
    cursos,
    grados,
    niveles
ORDER BY 1;
-- Producto cartesiano
-- 191 x 4 x 17 x 7 = 90916 registros
--   6 + 5 +  2 + 2 =    15 campos

SELECT 
    *
FROM
    salones,
    cursos,
    grados,
    niveles
WHERE
    id_salon = 1;
-- ... cada salón aparece 4 x 17 x 7 = 476 veces



SELECT 
    *
FROM
    salones s,
    cursos c
WHERE
    s.id_curso = c.id_curso
ORDER BY 1;
/*
INNER JOIN.
191 registros.

Para que el producto cartesiano se convierta en un JOIN igualamos la PK y la FK.
El número máximo de registros de un JOIN depende de la tabla eje, pero pueden ser menos.
También podemos renombrar las tablas.
 */

SELECT 
    *
FROM
    salones s,
    cursos c,
    grados g
WHERE
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
ORDER BY 1;
-- INNER JOIN
-- 191 registros

SELECT 
    *
FROM
    salones s,
    cursos c,
    grados g,
    niveles n
WHERE
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
        AND s.id_nivel = n.id_nivel
ORDER BY 1;
/*
INNER JOIN.
Pasamos de 191 registros a 198.

Existen salones que no tienen un nivel:

SELECT 
    *
FROM
    salones
WHERE
    id_nivel = 0;

Cero no existe en la tabla niveles, es decir, no es un id_nivel válido.

Obtener los salones y a qué curso, grado y nivel pertenecen (sentencia actual INNER JOIN)
no es lo mismo que obtener todos los salones (sentencia diferente LEFT JOIN).
*/

SELECT 
    *
FROM
    salones
WHERE
    id_nivel NOT IN (SELECT 
            id_nivel
        FROM
            niveles)
ORDER BY 1;
-- ... actúa como un LEFT JOIN (WHERE b.key IS NULL)
-- ... obtenemos los registros faltantes

SELECT 
    *
FROM
    salones
WHERE
    id_nivel NOT IN (1 , 2, 3, 4, 5, 6, 7)
ORDER BY 1;
-- ... misma sentencia que la anterior



/*
Las subconsultas pueden ocuparse en cualquier parte de una consulta SQL.
Si no conocemos los valores válidos o son demasiados, realizamos una subconsulta.
Las subconsultas forman parte de una consulta de nivel superior. 

Si en la subconsulta se define más de un campo, IN no sabe qué valores evaluar.
Nuestra subconsulta SELECT obtiene una lista de valores que serán parámetros de 
nuestra consulta principal SELECT.
*/



SELECT 
    *
FROM
    salones s,
    cursos c,
    grados g,
    niveles n
WHERE
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
        AND s.id_nivel = n.id_nivel
ORDER BY 1;

SELECT 
    s.id_salon AS s_salon,
    s.observaciones AS s_observaciones,
    c.id_curso AS c_curso,
    c.nombre AS c_nombre
FROM
    salones s,
    cursos c
WHERE
    s.id_curso = c.id_curso;

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
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado;

SELECT 
    s.id_salon AS s_salon,
    s.observaciones AS s_observaciones,
    c.id_curso AS c_curso,
    c.nombre AS c_nombre,
    g.nombre AS g_nombre,
    n.nombre AS n_nombre
FROM
    salones s,
    cursos c,
    grados g,
    niveles n
WHERE
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
        AND s.id_nivel = n.id_nivel
ORDER BY 1;
-- Para que parezca un reporte hay que realizar una proyección adecuada
-- Filtramos los campos que nos interesan de cada tabla



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
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
        AND s.id_nivel = n.id_nivel
        AND n.nombre = 'secundaria'
ORDER BY 4;
-- INNER JOIN
-- Obtenemos los salones de secundaria

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
    s.id_curso = c.id_curso
        AND s.id_grado = g.id_grado
        AND s.id_nivel = n.id_nivel
        AND n.nombre = 'secundaria'
        AND g.nombre = '3o'
ORDER BY 4;
-- ... obtenemos los salones de tercero de secundaria



SELECT 
    *
FROM
    salones
WHERE
    id_nivel IN (1 , 2, 3, 4, 5, 6, 7);
-- Actúa como un INNER JOIN
-- Obtenemos los salones que tienen un nivel válido

SELECT 
    *
FROM
    salones
WHERE
    id_nivel IN (SELECT id_nivel niveles);
-- ... misma sentencia que la anterior

SELECT 
    *
FROM
    salones
WHERE
    id_nivel NOT IN (1 , 2, 3, 4, 5, 6, 7);
-- Actúa como un LEFT JOIN (WHERE b.key IS NULL)
-- Obtenemos los salones que no tienen un nivel válido

SELECT 
    *
FROM
    salones
WHERE
    id_nivel NOT IN (SELECT 
            id_nivel
        FROM
            niveles);
-- ... misma sentencia que la anterior

SELECT 
    *
FROM
    salones
WHERE
    id_nivel IN (SELECT 
            id_nivel
        FROM
            niveles
        WHERE
            id_nivel > 2);
-- Obtenemos los salones que tienen un nivel mayor que dos



SELECT 
    COUNT(*)
FROM
    pagos;
-- 4642 registros

SELECT 
    COUNT(*)
FROM
    alumnos;
-- 808 registros

SELECT 
    COUNT(*)
FROM
    cursos;
-- 4 registros



SELECT 
    COUNT(*)
FROM
    pagos,
    alumnos;
/*
Producto cartesiano.
808 x 4642 = 3750736 registros.
Usamos COUNT porque son demasiados registros para el buffer.
*/

SELECT 
    *
FROM
    pagos,
    alumnos
LIMIT 10;
-- ... si es necesario ver la estructura, limitamos los renglones



SELECT 
    *
FROM
    pagos p,
    alumnos a
WHERE
    p.clave_alu = a.clave_alu
ORDER BY 1;
-- INNER JOIN
-- 4642 registros

SELECT 
    *
FROM
    pagos p,
    alumnos a,
    cursos c
WHERE
    p.clave_alu = a.clave_alu
        AND p.id_curso = c.id_curso
ORDER BY 1;
/*
INNER JOIN.
4641 registros.
Existe un pago que no tiene curso.
*/

SELECT 
    *
FROM
    pagos
WHERE
    id_curso NOT IN (SELECT 
            id_curso
        FROM
            cursos);
-- ... actúa como un LEFT JOIN (WHERE b.key IS NULL)
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
    p.clave_alu = a.clave_alu
        AND p.id_curso = c.id_curso
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
    p.clave_alu = a.clave_alu
        AND p.id_curso = c.id_curso
        AND p.pago < 2000
        AND a.sexo = 'f'
ORDER BY 1;
-- INNER JOIN
-- Obtenemos las mujeres con pagos menores a dos mil

SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    p.pago AS p_pago,
    p.fecha_pago AS p_fecha_pago,
    c.abreviatura AS c_abreviatura
FROM
    (SELECT 
        *
    FROM
        pagos
    WHERE
        pago < 2000) p,
    (SELECT 
        *
    FROM
        alumnos
    WHERE
        sexo = 'f') a,
    cursos c
WHERE
    p.clave_alu = a.clave_alu
        AND p.id_curso = c.id_curso
ORDER BY 1;
-- ... misma sentencia que la anterior



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
 
 
 
SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    p.pago AS p_pago,
    p.fecha_pago AS p_fecha_pago,
    c.abreviatura AS c_abreviatura
FROM
    pagos p
        JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        JOIN
    cursos c ON (p.id_curso = c.id_curso)
ORDER BY 1;
/* 
INNER JOIN.
4641 registros.

Sentencia equivalente:

SELECT 
    *
FROM
    alumnos a,
    pagos p,
    cursos c
WHERE
    p.clave_alu = a.clave_alu
        AND p.id_curso = c.id_curso
ORDER BY 1;
*/

SELECT 
    *
FROM
    pagos p
        JOIN
    alumnos a USING (clave_alu)
        JOIN
    cursos c USING (id_curso)
ORDER BY 1;
/*
... misma sentencia que la anterior.

Utilizamos USING cuando la PK y la FK se llaman iguales.
Debemos definir explícitamente el nombre de dicho campo.

Hay una sola proyección de la PK, no se muestra la FK 
pero se puede utilizar. Sin ON O USING realizamos un producto cartesiano.
*/

SELECT 
    *
FROM
    pagos p
        NATURAL JOIN
    alumnos a
        JOIN
    cursos c USING (id_curso)
ORDER BY 1;
/*
... misma sentencia que la anterior.

Utilizamos NATURAL cuando la PK y la FK se llaman iguales.
El propio manejador infiere cuál es la PK y la FK.

A diferencia de USING, sólo lo podemos utilizar una vez.
Si en el ejemplo anterior utilizamos NATURAL en vez de USING, el manejador 
no sabe inferir cuál es la PK ni la FK. Por lo tanto, debemos remplazar 
el segundo NATURAL ya sea con ON o USING.
*/



SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    p.pago AS p_pago,
    p.fecha_pago AS p_fecha_pago,
    c.abreviatura AS c_abreviatura
FROM
    pagos p
        RIGHT JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        LEFT JOIN
    cursos c ON (p.id_curso = c.id_curso)
ORDER BY 1;
/*
RIGHT JOIN y LEFT JOIN.
4968 registros.
Obtenemos todos los alumnos aunque no tengan un pago.

Pasamos de 4641 registros a 4968.
Es decir, ahora también contemplamos a los alumnos que no tengan un pago.

RIGHT muestra los registros de la relación derecha 
aunque no tenga correspondencia con la relación izquierda.

LEFT muestra los registros de la relación izquierda 
aunque no tenga correspondencia con la relación derecha.
*/

SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    p.pago AS p_pago,
    p.fecha_pago AS p_fecha_pago,
    c.abreviatura AS c_abreviatura
FROM
    pagos p
        RIGHT JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        LEFT JOIN
    cursos c ON (p.id_curso = c.id_curso)
WHERE
    p.clave_alu IS NULL
ORDER BY 1;
/*
RIGHT JOIN (WHERE a.key IS NULL).
326 registros.
Obtenemos todos los alumnos que no tengan un pago.
*/

SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    no_pagos,
    total_pagos,
    c.abreviatura AS c_abreviatura
FROM
    (SELECT 
        clave_alu,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) p
        RIGHT JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        LEFT JOIN
    cursos c ON (p.id_curso = c.id_curso)
ORDER BY 1;
/*
LEFT JOIN.
808 registros.
Obtenemos el total y el número de pagos de todos los alumnos registrados.

482 registros de la subconsulta de la tabla pagos. La proyección de dicha subconsulta 
limita la proyección de la consulta principal respecto a la misma tabla.

Si utilizamos subconsultas en un JOIN, la proyección de dichas subconsultas
deben incluir el campo utilizado en la clausula ON, USING o NATURAL.
*/


SELECT 
    a.clave_alu AS a_clave_alu,
    a.ap_paterno AS a_ap_paterno,
    a.ap_materno AS a_ap_materno,
    a.nombre AS a_nombre,
    IFNULL(no_pagos, 0) AS no_pagos,
    IFNULL(total_pagos, 0) AS total_pagos,
    IFNULL(c.abreviatura, 'SIN CURSO') AS c_abreviatura
FROM
    (SELECT 
        clave_alu,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) p
        RIGHT JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        LEFT JOIN
    cursos c ON (p.id_curso = c.id_curso)
ORDER BY 1;
-- ... para que parezca un reporte hay que realizar una proyección adecuada
-- ... remplazamos los valores NULL con la función IFNULL

SELECT 
    a.clave_alu,
    CONCAT_WS(' ',
            a.ap_paterno,
            a.ap_materno,
            a.nombre) AS alumno,
    IFNULL(no_pagos, 0) AS no_pagos,
    IFNULL(total_pagos, 0) AS total_pagos,
    IFNULL(c.abreviatura, 'SIN CURSO') AS c_abreviatura
FROM
    (SELECT 
        clave_alu,
            id_curso,
            COUNT(pago) AS no_pagos,
            SUM(pago) AS total_pagos
    FROM
        pagos
    GROUP BY clave_alu , id_curso) p
        RIGHT JOIN
    alumnos a ON (p.clave_alu = a.clave_alu)
        LEFT JOIN
    cursos c ON (p.id_curso = c.id_curso)
ORDER BY 1;
-- ... concatenamos el nombre completo de los alumnos