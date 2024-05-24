SHOW DATABASES;
-- Investigar las B.D. por defecto

SHOW VARIABLES LIKE '%dir%';
/*
# Variable_name, Value
basedir, C:\Program Files\MySQL\MySQL Server 8.0\

Ingresamos desde una terminal:

cd C:\Program Files\MySQL\MySQL Server 8.0\bin
mysql -h localhost -u root -p
SHOW databases;
SHOW TABLES FROM information schema;
SHOW VARIABLES;
quit
cls

# Variable_name, Value
datadir, C:\ProgramData\MySQL\MySQL Server 8.0\Data\

Cambiar la dirección de los datos nos permite tener independencia física.
Ahora podemos apreciar los tres niveles del S.G.B.D.

* Tenemos un directorio con los datos físicos de los actores
* Tenemos al actor represetado de forma lógica como una tabla
* Podemos ver de forma tabular a los actores
*/



/*
* Cargamos el esquema de la B.D. sakila
* Cargamos el estado inicial de la B.D. sakila
*/

CREATE DATABASE IF NOT EXISTS biblioteca;
DROP DATABASE biblioteca;

CREATE DATABASE IF NOT EXISTS biblioteca;
/*
Cuando usamos IF NOT EXIST y existe la B.D. obtenemos un warning.
Cuando tenemos un script vamos a automatizar una B.D.

Si surge un error, se detiene el script.
Si surge un warning, la ejecución del script continua.
*/

SHOW TABLES FROM biblioteca;

USE biblioteca;



CREATE TABLE escritor (
    id_escritor INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NULL,
    alias VARCHAR(30) NULL DEFAULT 'N/A',
    PRIMARY KEY (id_escritor)
);
/*
Nuestra tabla tiene cuatro constraints diferentes y seis en total: 
NOT NULL, AUTO_INCREMENT, DEFAULT, PRIMARY KEY. NULL no cuenta como constraint.

Si no usamos explícitamente el constraint NULL, se define como dicta el M.D.R. (NULL).
Ningún dato es requerido (NULL) hasta que explícitamente lo definamos (NOT NULL).
*/



CREATE TABLE libro (
    id_libro INT NOT NULL AUTO_INCREMENT,
    id_escritor INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    contenido TEXT NULL, -- ASCII
    PRIMARY KEY (id_libro),
    FOREIGN KEY (id_escritor)
        REFERENCES escritor (id_escritor)
		-- Un libro puede tener uno o muchos escritores (1 - N)
        ON DELETE CASCADE ON UPDATE CASCADE
		-- Restricciones de integridad referencial
);

SHOW TABLES;

SHOW INDEX FROM libro;
-- En el diagrama E - R se muestra como una pestaña de la entidad

SHOW COLUMNS FROM escritor;
DESCRIBE escritor;
DESC escritor;
-- Las tres instrucciones son equivalentes
-- Muestra los campos y sus constraints

SHOW CREATE TABLE escritor;
/*
Muestra la sintaxis con la que fue creado el objeto tabla:

CREATE TABLE `escritor` (
  `id_escritor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `alias` varchar(30) DEFAULT 'N/A',
  PRIMARY KEY (`id_escritor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

ENGINE, CHARSET y COLLATE son cuestiones por default que las agrega el S.G.B.D.

ENGINE: con qué motor se va guarda la B.D.
CHARSET y COLLATE: permite escribir eñes, acentos, etc.
*/



CREATE TABLE escritor_02 LIKE escritor;
-- Copia la estructura de una tabla ya existente pero no copia los datos

CREATE TEMPORARY TABLE escritor_03 LIKE escritor;
SHOW TABLES;
/*
Una tabla temporal es una estructura que puede guardar datos, pero que existe
hasta que se cierra la sesión. No aparece en la estructura del esquema
porque no es parte de la misma, es decir, no es una tabla persistente.
*/