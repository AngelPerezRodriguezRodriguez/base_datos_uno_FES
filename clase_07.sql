USE colegio;
/*
LENGTH()


LOCATE(cadena_localizar, campo)
LOCATE(cadena_localizar, campo, posicion_inicial)


LEFT(campo, numero_caracteres)
RIGHT(campo, numero_caracteres)

MID(campo, posicion_inicial)
MID(campo, posicion_inicial, numero_caracteres)


IF(condicion, entonces, contrario)


UPPER()
UCASE()

LOWER()
LCASE()


BINARY()
Evaluamos la cadena de forma binaria, mas no por caracteres.
Ej. 'aldo' no es lo mismo que 'ALDO'


CONCAT(valores)
CONCAT_WS(valor_entre_valores, valores)


REPLACE(campo, que_remplaza, con_que_remplaza)
Dicha función sí diferencia entre mayúsculas y minúsculas


MD5()
*/



SELECT 
nombre, 
LENGTH(nombre) AS long_nombre
FROM alumnos 
ORDER BY long_nombre DESC;
-- Obtenemos los nombres de los alumnos y su longitud
-- con los registros ordenados en forma descendente por la longitud

SELECT 
nombre, 
LENGTH(nombre) AS long_nombre
FROM alumnos 
WHERE LENGTH(nombre) < 10
ORDER BY long_nombre DESC;
-- ... que la longitud sea menor a diez

SELECT 
nombre, 
LENGTH(nombre) AS long_nombre
FROM alumnos 
WHERE LENGTH(nombre) = 7
ORDER BY long_nombre DESC;
-- ... que la longitud sea igual a siete

SELECT 
LENGTH(nombre) AS long_nombre,
COUNT(*)
FROM alumnos 
GROUP BY LENGTH(nombre) 
ORDER BY long_nombre DESC;
-- Agrupamos por longitud
-- que haga un conteo de acuerdo al agrupamiento



SELECT 
nombre, 
LOCATE('a', nombre) AS primera_a
FROM alumnos
ORDER BY nombre;
-- Obtenemos los nombres de los alumnos
-- localizamos la posición de 'a' en el nombre

SELECT 
nombre, 
LOCATE('a', nombre) AS primera_a
FROM alumnos
WHERE LOCATE('a', nombre) = 0
ORDER BY nombre;
-- ... que no tengan 'a' en el nombre, es decir,
-- ... que no tengan una posición válida (igual a cero)

SELECT 
nombre, 
LOCATE('a', nombre) AS primera_a
FROM alumnos
WHERE LOCATE('a', nombre) = 4
ORDER BY nombre;
-- ... que tengan 'a' en la cuarta posición del nombre



SELECT 
nombre, 
LOCATE('a', nombre, 4)
FROM alumnos;
-- Obtenemos los nombres de los alumnos 
-- localizamos la posición de 'a' a partir de la cuarta posición en el nombre

SELECT 
nombre, 
LOCATE('a', nombre) AS primera_a,
LOCATE('a', nombre, LOCATE('a', nombre) + 1) AS segunda_a
FROM alumnos;
-- ... localizamos la posición de la primera 'a' en el nombre
-- ... localizamos la posición de la segunda 'a' en el nombre

SELECT 
nombre, 
LOCATE('a', nombre) AS primera_a, 
LOCATE('a', nombre, LOCATE('a', nombre) + 1) AS segunda_a
FROM alumnos
WHERE LOCATE('a', nombre, LOCATE('a', nombre) + 1) > 0;
-- ... que tengan una segunda 'a' en el nombre

select 
nombre,
LOCATE('maria', nombre) AS maria
FROM alumnos
WHERE LOCATE('maria', nombre) > 0;
-- .. que tengan 'maria' en el nombre



SELECT 
nombre,
LEFT(nombre, 4),
RIGHT(nombre, 4),
MID(nombre, 4)
FROM alumnos;
-- Obtenemos los nombres de los alumnos
-- los primeros cuatro caracteres del nombre
-- los últimos cuatro caracteres del nombre
-- los siguientes caracteres a partir del cuarto

SELECT 
nombre,
LEFT(nombre, 4),
RIGHT(nombre, 4),
MID(nombre, 4, 4)
FROM alumnos;
-- ... los siguientes cuatro caracteres a partir del cuarto



SELECT 
nombre,
LOCATE(' ', nombre)
FROM alumnos;
-- Obtenemos los nombres de los alumnos
-- localizamos la posición de ' ' en el nombre

SELECT 
nombre,
LOCATE(' ', nombre)
FROM alumnos
WHERE LOCATE(' ', nombre) > 0;
-- ... que tengan dos nombres, es decir,
-- ... que tengan ' ' en el nombre, es decir,
-- ... que tengan una posición válida (mayor que cero)



SELECT 
nombre,
sexo,
IF(
	sexo = 'f', 
    'femenino', 
    'no'
)
FROM alumnos;
-- Mostramos los nombres de los alumnos, su sexo y
-- la descripción de la codificación del sexo femenino

SELECT 
nombre,
sexo,
IF(
	sexo = 'f', 
    'femenino', 
	IF(
		sexo = 'm', 
        'masculino', 
        'no definido'
	)
) AS desc_sexo
FROM alumnos;
-- ... la descripción de la codificación del sexo


SELECT
nombre,
MID(nombre, 1, LOCATE(' ', nombre) - 1) AS primer_nombre,
MID(nombre, LOCATE(' ', nombre) + 1) AS segundo_nombre
FROM alumnos;
-- La intención es separar los nombres de los alumnos en dos columnas
-- pero surgen problemas cuando los alumnos sólo tienen un nombre

SELECT
nombre,
IF(
	LOCATE(' ', nombre) > 0, 
    MID(nombre, 1, LOCATE(' ', nombre) - 1),
    nombre
) AS primer_nombre, 
IF(
	LOCATE(' ', nombre) > 0, 
    MID(nombre, LOCATE(' ', nombre) + 1),
    NULL
) AS segundo_nombre
FROM alumnos;
-- ... con la condición IF se logra el cometido
-- ... aquellos que no tienen un segundo nombre se define un valor NULL



SELECT 
nombre,
UPPER(nombre),
UCASE(nombre),
LOWER(nombre),
LCASE(nombre)
FROM alumnos;
-- Funciones para mayúsculas y minúsculas


SELECT * FROM alumnos
ORDER BY nombre;

SELECT * FROM alumnos
WHERE nombre = 'aldo';
-- No de distinguen mayúsculas de minúsculas

SELECT * FROM alumnos
WHERE BINARY nombre = 'aldo';
-- ... ahora sí se distinguen, pues la evaluación es binaria
-- ... pero no hay alumnos llamados 'aldo' con minúscula

SELECT * FROM alumnos
WHERE BINARY LOWER(nombre) = 'aldo';
-- ... pero sí los hay si antes transformamos el nombre a minúsculas



SELECT
nombre,
ap_paterno,
ap_materno
FROM alumnos;

SELECT
CONCAT(
	nombre,
	ap_paterno,
	ap_materno
) AS nombre_completo
FROM alumnos;
-- Concatenamos los campos de conforman el nombre
-- pero hacen falta espacios entre los mismos

SELECT
CONCAT(
	nombre, ' ',
	ap_paterno, ' ',
	ap_materno
) AS nombre_completo
FROM alumnos;
-- ... concatenando cadenas en blanco se logra el cometido

SELECT
CONCAT_WS(
	' ',
	nombre,
	ap_paterno,
	ap_materno
) AS nombre_completo
FROM alumnos;
-- ... pero lo podemos conseguir de una forma más elegante con CONCAT_WS

SELECT
CONCAT_WS(
	' ',
	nombre,
	ap_paterno,
	ap_materno
) AS nombre_completo,
LENGTH(
	CONCAT_WS(
		' ',
		nombre,
		ap_paterno,
		ap_materno
	)
) AS long_nombre_completo
FROM alumnos
ORDER BY long_nombre_completo DESC, nombre_completo DESC
LIMIT 15;
-- Obtenemos la concatenación de su nombre completo
-- la longitud de su nombre completo
-- con los registros ordenados por la longitud y la concatenación
-- sólo los primeros 15 nombres completos más largos



SELECT nombre, REPLACE(nombre, 'A', '4')
FROM alumnos;
-- Remplazamos 'A' por '4'
-- Si queremos un replace simultaneo, se tienen que anidar

SELECT nombre, 
REPLACE(
	REPLACE(
		REPLACE(
			REPLACE(
				nombre, 
				'A', 
				'4'
			), 
			'E', 
			'3'
		),
		'I',
		'1'
	),
    'O',
    '0'
) AS vocales_numeros
FROM alumnos;
-- ... remplazamos 'E' por '3'
-- ... remplazamos 'I' por '1'
-- ... remplazamos 'O' por '0'



SELECT
nombre,
ap_paterno,
ap_materno,
email
FROM alumnos
WHERE LOCATE('@', email) = 0;
-- Obtenemos información de los alumnos
-- que no tengan un email válido, es decir,
-- que no tengan '@' en el email, es decir,
-- que no tengan una posición válida (igual a cero)

SELECT
nombre,
ap_paterno,
ap_materno,
email,
CONCAT(
	LEFT(nombre, 1), 
	REPLACE(ap_paterno, ' ', '_'), 
	'@gmail.com'
) AS nuevo_email
FROM alumnos;
-- ... para dichos alumnos generamos un correo
-- ... con la primera letra de su nombre
-- ... su apellido paterno
-- ... y un dominio de correo

SELECT
nombre,
ap_paterno,
ap_materno,
email,
LOWER(
	CONCAT(
		LEFT(nombre, 1), 
		REPLACE(ap_paterno, ' ', '_'),
		'@gmail.com'
    )
) AS nuevo_email
FROM alumnos;
-- ... un correo con sólo minúsculas



/*
UPDATE donde se ocupan ambos apellidos de ap_paterno:

UPDATE alumnos 
SET email = 
LOWER(
	CONCAT(
		LEFT(nombre, 1), 
		'_', 
		REPLACE(ap_paterno, ' ', '_'), 
		'@gmail.com'
    )
)
WHERE locate('@', email) = 0;



UPDATE donde se ocupa el primer apellido de ap_paterno:

UPDATE alumnos 
SET email = 
LOWER(
	CONCAT(
		LEFT(nombre, 1), 
		'_', 
		IF(
			LOCATE(' ', ap_paterno), 
			MID(ap_paterno, 1, LOCATE(' ', ap_paterno) - 1), 
			ap_paterno
		), 
		'@gmail.com'
	)
)
WHERE locate('@', email) = 0;
*/



SELECT
nombre,
ap_paterno,
ap_materno,
email,
LOWER(
	CONCAT(
		LEFT(nombre, 1), 
		REPLACE(ap_paterno, ' ', '_'),
		'@gmail.com'
    )
) AS nuevo_email,
MD5(
	CONCAT(
		nombre, 
		ap_paterno, 
		ap_materno, 
		sysdate()
	)
) AS contrasenia
FROM alumnos
ORDER BY nombre, ap_paterno, ap_materno;
-- ... una contraseña con base a MD5 con los campos del nombre y la fecha actual

SELECT
nombre,
ap_paterno,
ap_materno,
email,
LOWER(
	CONCAT(
		LEFT(nombre, 1), 
		REPLACE(ap_paterno, ' ', '_'),
		'@gmail.com'
    )
) AS nuevo_email,
RIGHT(
	MD5(
		CONCAT(
			nombre, 
			ap_paterno, 
			ap_materno, 
			sysdate()
        )
    ), 
    18
) AS contrasenia
FROM alumnos
ORDER BY nombre, ap_paterno, ap_materno;
-- ... una contraseña con base a los últimos dieciocho caracteres de la cadena MD5