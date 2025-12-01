--Base de Datos - clase 13
--Arquitectura de base de datos
--conectarse con system
SHOW PDBs;

SELECT * FROM v$database;
SELECT * FROM v$pdbs;
SELECT cdb FROM v$database;

SHOW con_name; --consulte en que pdb estamos trabajando con show name

--si necseitamos cambiar de contenedor
ALTER SESSION SET CONTAINER = CDB$ROOT;

--Crear pdb desde seed usando el pdb matriz seed oslo plantilla de lectura para crear nuevos
CREATE PLUGGABLE DATABASE DESAR  --ubicacion de desar abajo
ADMIN USER udesar IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/DESAR/');


CREATE PLUGGABLE DATABASE QA
ADMIN USER uqa IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/QA/');

CREATE PLUGGABLE DATABASE SISA
ADMIN USER usysa IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/SYSA/');

CREATE PLUGGABLE DATABASE COME
ADMIN USER ucome IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/COME/');


--1/12/2025
--En máquina virtual:
show pdbs --en SQL
--Conectarse al cdb
ALTER SESSION SET CONTAINER = CDB$ROOT;
CREATE PLUGABLE DATABASE qa ADMIN USER adm_qa IDENTIFIED BY "lticPUCE24" FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/QA/qa/');
