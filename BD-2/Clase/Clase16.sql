--Distribución
--Base de datos distribuidas
--Desventaja: Complejidad

Show pdbs;
--confirmar conexión con cdb root
alter session set container = CDB$ROOT;
--levanta prod, comee,
ALTER PLUGGABLE DATABASE desar OPEN;
ALTER PLUGGABLE DATABASE QA OPEN;

--ya existían
CREATE PLUGGABLE DATABASE QA
ADMIN USER uqa IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/QA/');

CREATE PLUGGABLE DATABASE DESAR
ADMIN USER udesar IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/DESAR/');

--conectarse desde cdb A QA O DESAR

--EN DESAR
