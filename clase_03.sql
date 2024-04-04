USE biblioteca;

DESC libro;

SHOW INDEX FROM libro;

DESC escritor;

SHOW INDEX FROM escritor;



CREATE UNIQUE INDEX alias_UNIQUE 
ON escritor_02(alias);
    
SHOW INDEX 
FROM escritor_02;

DROP INDEX alias_UNIQUE 
ON escritor_02;

SHOW INDEX 
FROM escritor_02;



ALTER TABLE escritor_02 
ADD INDEX nombre_completo_idx(nombre, apellido);

SHOW INDEX FROM escritor_02;

ALTER TABLE escritor_02 
DROP INDEX nombre_completo_idx;

SHOW INDEX FROM escritor_02;

/*
Podemos eliminar el index con un DROP a través de UN ALTER,
como lo hicimos en el ejemplo, o con un DROP directamente:

DROP INDEX nombre_completo_idx ON escritor_02;
*/



/*
MODIFY 
* Misma entrada en el diccionario de datos

CHANGE
* Diferente entrada en el diccionario de datos
* Borramos el campo original y creamos uno nuevo
* Volvemos a definir el objeto
*/



/*
ALTER TABLE escritor_02 
DROP PRIMARY KEY;
Error, no podemos eliminar una PK porque es un objeto AUTO_INCREMENT
*/

ALTER TABLE escritor_02 
MODIFY id_escritor INT NOT NULL;
-- Primero hay que eliminar el AUTO_INCREMENT

DESC escritor_02;

ALTER TABLE escritor_02 
DROP PRIMARY KEY;
-- Para finalmente poder eliminar la PK

DESC escritor_02;

ALTER TABLE escritor_02 
MODIFY id_escritor INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(id_escritor);
-- Devolvemos la PK y el AUTO_INCREMENT

DESC escritor_02;



ALTER TABLE escritor_02 
ADD COLUMN ciudad VARCHAR(30) NULL;
-- Agregamos la columna al final de la tabla

DESC escritor_02;

ALTER TABLE escritor_02
CHANGE apellido ap_paterno VARCHAR(50) NOT NULL,
ADD COLUMN ap_materno VARCHAR(50) NULL AFTER ap_paterno;

DESC escritor_02;

ALTER TABLE escritor_02
ADD COLUMN cd VARCHAR(3) NULL FIRST;
-- Colocamos la columna al principio de la tabla

DESC escritor_02;

ALTER TABLE escritor_02
DROP COLUMN cd,
MODIFY COLUMN ciudad VARCHAR(30) NULL;

DESC escritor_02;

/*
DROP COLUMN cd 
ON escritor_02; 
Error de sintaxis al eliminar la columna directamente con un DROP
*/

ALTER TABLE escritor_02
MODIFY ciudad VARCHAR(30) NULL AFTER direccion;

DESC escritor_02;



SHOW INDEX FROM libro;
-- No nos muestra la llave foránea. Para poder verla tenemos
-- que realizar una consulta del diccionario de datos.

SELECT
	TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    referenced_table_name,
    referenced_column_name
FROM
	information_schema.key_column_usage
    -- diccionario de datos: information_schema
    -- columna: key_column_usage
WHERE
	referenced_table_schema = 'biblioteca' AND 
    referenced_table_name = 'escritor';
-- Si quisiéramos eliminar la referencia tenemos que borrar el índice llamado libro_ibfk_1
-- nombre dado por el S.G.B.D. cuando creamos la tabla

SELECT * FROM information_schema.TABLES
WHERE table_schema = 'biblioteca';

SHOW TABLES FROM biblioteca;
-- Estas últimas dos consultas son las mismas



RENAME TABLE escritor_02 TO escritor_dos;

SHOW TABLES FROM biblioteca;

RENAME TABLE escritor_dos TO escritor_02;



CREATE DATABASE biblioteca2024;

SHOW TABLES FROM biblioteca2024;

RENAME TABLE biblioteca.escritor_02 TO biblioteca2024.escritor_02;
-- Movimos la tabla de B.D.
-- Atención a la palabra reservada TO

SHOW TABLES FROM biblioteca;

SHOW TABLES FROM biblioteca2024;



CREATE TABLE biblioteca.escritor_02 LIKE biblioteca2024.escritor_02;
-- Atención a la palabra reservada LIKE

SHOW TABLES FROM biblioteca;

SHOW TABLES FROM biblioteca2024;



SELECT DATABASE();

SELECT * FROM escritor;

DESC escritor;

INSERT INTO escritor VALUES
(NULL, 'Carlos', 'Monsiváis', 'CDMX', 'MONSO');

SELECT * FROM escritor;

INSERT INTO escritor VALUES
(NULL, 'Gabriel', 'García', NULL, NULL);

SELECT * FROM escritor;

/*
INSERT INTO escritor VALUES
('Carlos', 'Monsiváis', 'CDMX', 'Monsi');
Error, el número de campos utilizados no es el mismo que el requerido

INSERT INTO escritor VALUES
(null, null, 'Monsiváis', 'CDMX', 'Monsi');
Error, el campo 'nombre' es NOT NULL
*/



SELECT * FROM libro;

DESC libro;

INSERT INTO libro VALUES
(NULL, 1, 'Confrontaciones', NULL),
(NULL, 2, '100 Años de Soledad', NULL),
(NULL, 2, 'El Amor en Tiempos de Cólera', 'Algo');

SELECT * FROM libro;

/*
INSERT INTO libro VALUES
(null, 100, 'Equis', null);
Error, no podemos insertar un hijo que no tenga un padre
*/

DELETE FROM escritor 
WHERE id_escritor = 1;
-- Aplicación de la integridad referencial en cascada

SELECT * FROM escritor;

SELECT * FROM libro;

UPDATE escritor SET id_escritor = 200 
WHERE id_escritor = 2;

SELECT * FROM escritor;

SELECT * FROM libro;