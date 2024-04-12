USE biblioteca;
/*
LOAD DATA LOCAL INFILE
'<ruta_archivo>'
INTO TABLE escritor
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n';


INSERT INTO tabla <SELECT>;
Inserciones a través de una consulta.

INSERT INTO tabla VALUES (valores);
Inserciones masivas.

INSERT INTO tabla (campos) VALUES (valores_campos);
Inserciones masivas.

INSERT INTO tabla SET (campo = valor);
Insersiones únicas.


UPDATE tabla SET campo = valor;
Actualiza todas las tuplas.


DELETE FROM tabla;
Borra todas las tuplas.


TRUNCATE TABLE tabla;
Vacía la tabla, reiniciamos el AUTO_INCREMENT y borra los índices.
*/



SELECT * FROM libro;

SELECT * FROM escritor;

DELETE FROM escritor
WHERE id_escritor != 200;
-- Podemos utilizar != ó <>

SELECT * FROM escritor;

DESC escritor;

INSERT INTO escritor VALUES
(NULL, 'JUAN', 'RULFO');
-- Primera forma de insertar datos

INSERT INTO escritor 
(id_escritor, nombre, apellido) VALUES
(NULL, 'INES', 'DE LA CRUZ');
-- Segunda forma de insertar datos

SELECT * FROM escritor;

INSERT INTO escritor SET
apellido = 'PONIATOWSKA',
nombre = 'ELENA';
-- Tercera forma de insertar datos
-- No podemos hacer una inserción masiva

INSERT INTO escritor SET
apellido = 'AZUELA',
nombre = 'MARIANO';

SELECT * FROM escritor;

INSERT INTO escritor
(alias, apellido, nombre, id_escritor, direccion) VALUES
('DIABLO', 'VELAZCO', 'XAVIER', 400, 'CDMX'),
('YO ROBOT', 'ASIMOV', 'ISSAC', NULL, 'CA');
/*
Cuando definimos id_escritor como 400, se convierte en el nuevo índice superior,
es decir, AUTO_INCREMENT tomará ese número como punto de partida.
*/

SELECT * FROM escritor;



LOAD DATA LOCAL INFILE
'<ruta_archivo>'
INTO TABLE escritor
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n';
/*
Con archivos csv, txt, prm, etc. podremos insertar datos de una forma más rápida.
Por lo tanto, vamos a insertar datos con el documento escritores.csv

* Definimos la ruta del archivo. Para Windows cambiamos '/' por '//'
* La tabla donde queremos hacer la inserción
* El limitador de campos
* El limitador que encierra el valor de los campos
* El limitador de la tupla. En Windows es '\r\n' en vez de sólo '\n'
*/



/*
Dado que Workbench no nos permite dicha sentencia por restricciones de seguridad
hay que hacerlo mediante la interfaz. En la barra de herramientas del record set:

* Seleccionamos la opción 'import records from an external file'
* Importamos el archivo 'escritores'
*/



SELECT * FROM escritor;

SELECT * FROM escritor;

INSERT INTO escritor SET
nombre = 'MANUEL',
apellido = 'ACUÑA',
direccion = 'CDMX',
alias = '';
/*
Cada vez que hay un intento o error de inserción en 
AUTO_INCREMENTAL, se contabiliza para el incremento del mismo.

Saltamos del id_escritor 401 al 403 porque el id_escritor 402 
fue la inserción que hicimos a través de la interfaz.
*/



UPDATE escritor SET
direccion = '';
-- Afecta a todas las tuplas de la tabla

SELECT * FROM escritor;

UPDATE escritor SET
direccion = NULL;

SELECT * FROM escritor;

UPDATE escritor SET
direccion = 'MX',
alias = 'NO SE'
WHERE id_escritor >= 300 AND id_escritor <= 305;
-- Actualizamos en un rango en específico de tuplas

SELECT * FROM escritor;

UPDATE escritor SET
nombre = 'ROBERTO',
alias = 'ROBERT',
apellido = 'ABOLAÑO',
direccion = 'CL'
WHERE id_escritor = 403;

SELECT * FROM escritor;



CREATE TABLE escritor_tmp LIKE escritor;
-- Creamos una copia del esquema de la tabla

INSERT INTO escritor_tmp 
SELECT * FROM escritor;
-- Insertamos una copia del estado en la copia del esquema
-- Insertamos valores en la tabla a través de una consulta

SELECT * FROM escritor_tmp;

DELETE FROM escritor
WHERE alias = 'no se';
-- No se diferencia mayúsculas de minúsculas

SELECT * FROM escritor;



DELETE FROM escritor;
-- Se aplica integridad referencial en la tabla 'libros'
-- Por lo tanto, la tabla 'libros' está vacía

SELECT * FROM escritor;

SELECT * FROM libro;

DESC escritor;

INSERT INTO escritor
(id_escritor, nombre, apellido) VALUES
(NULL, 'ALFONSO', 'REYES');
-- Vaciar la tabla con un DELETE no reinicia el AUTO_INCREMENT
-- Continua a partir del último valor, es decir, 403

SELECT * FROM escritor;

TRUNCATE TABLE escritor;
-- Vaciamos la tabla, reiniciamos AUTO_INCREMENT y borramos los índices
-- Pero, no podemos truncar una tabla referenciada como 'escritor' y 'libro'

INSERT INTO escritor
SELECT * FROM escritor_tmp;
-- Volvemos a llenar la tabla 'escritor' para ocupar 'escritor_tmp'



SELECT * FROM escritor_tmp;

DELETE FROM escritor_tmp;

INSERT INTO escritor_tmp
(id_escritor, nombre, apellido) VALUES
(NULL, 'JUAN', 'RULFO');
-- Como mencionamos, continua a partir del último valor, es decir, 403

SELECT * FROM escritor_tmp;

TRUNCATE TABLE escritor_tmp;
-- Al no ser una tabla referenciada podemos usar TRUNCATE

SELECT * FROM escritor_tmp;

INSERT INTO escritor_tmp
(id_escritor, nombre, apellido) VALUES
(NULL, 'JUAN', 'RULFO');
-- Notamos el reinicio en AUTO_INCREMENT

SELECT * FROM escritor;



UPDATE escritor SET
direccion = ''
WHERE id_escritor = 404;

SELECT * FROM escritor;

SELECT * FROM escritor
WHERE direccion = '';

SELECT * FROM escritor
WHERE direccion IS NULL;

SELECT * FROM escritor
WHERE direccion = 'n/a' OR alias = 'n/a';
-- No se diferencia mayúsculas de minúsculas