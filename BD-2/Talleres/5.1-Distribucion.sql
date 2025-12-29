Taller5.1Distribucion
--
SHOW pdbs;
--Verificar que estamos conectados en Multitenant haciendo un SELECT de la vista del sistema v$database o v$pdbs , nos debe responder yes en CDB:
SELECT * FROM v$database;
SELECT * FROM v$pdbs;
SELECT cdb FROM v$database;

SHOW con_name; --como en clase, debería decir root o sino:
ALTER SESSION SET CONTAINER = CDB$ROOT;
SHOW con_name;
--Usar root o seed plantilla para crear pdbs
ALTER SESSION SET CONTAINER = CDB$ROOT;

--Crear pdbs
CREATE PLUGGABLE DATABASE DESAR
ADMIN USER udesar IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/DESAR/');

CREATE PLUGGABLE DATABASE QA
ADMIN USER uqa IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/QA/');

CREATE PLUGGABLE DATABASE COME
ADMIN USER ucome IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/COME/');

--Abrir PDBS:
ALTER PLUGGABLE DATABASE DESAR OPEN;
ALTER PLUGGABLE DATABASE QA OPEN;
ALTER PLUGGABLE DATABASE COME OPEN;
SHOW PDBs;

--Cambiar de contenedor
ALTER SESSION SET CONTAINER = DESAR;
SHOW con_name;
--dar dba al admin del pdb
grant dba to udesar;
 drop tablespace DATOSE INCLUDING CONTENTS;
  drop tablespace INDICESE INCLUDING CONTENTS;
  DROP USER u_desar;
  DROP USER u_desar CASCADE; --si esta conectado
--del script del proyecto crear tablespaces:
CREATE TABLESPACE DATOSE DATAFILE '/u01/app/oracle/oradata/ORCL/DESAR/DATOSE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE TABLESPACE INDICESE DATAFILE '/u01/app/oracle/oradata/ORCL/DESAR/INDICESE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/
--crear usuario que manejará desar
CREATE USER u_desar IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOSE;
GRANT CONNECT, RESOURCE, DBA TO u_desar WITH ADMIN OPTION;

--conectarse como u_desar :3

--para qa
ALTER SESSION SET CONTAINER = QA;
SHOW con_name;
SELECT * FROM dba_users;

grant dba to uqa;

CREATE TABLESPACE DATOSE DATAFILE '/u01/app/oracle/oradata/ORCL/QA/DATOSE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE TABLESPACE INDICESE DATAFILE '/u01/app/oracle/oradata/ORCL/QA/INDICESE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE USER u_qa IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOSE;
GRANT CONNECT, RESOURCE, DBA TO u_qa WITH ADMIN OPTION;

rollback;
--conectarse con qa uwu

--para come
ALTER SESSION SET CONTAINER = COME;
SHOW con_name;

grant dba to ucome;

CREATE TABLESPACE DATOSE DATAFILE '/u01/app/oracle/oradata/ORCL/COME/DATOSE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE TABLESPACE INDICESE DATAFILE '/u01/app/oracle/oradata/ORCL/COME/INDICESE.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE USER u_come IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOSE;
GRANT CONNECT, RESOURCE, DBA TO u_come WITH ADMIN OPTION;

--conectarse con come, si quieres awa

--PRUEBAS:
SELECT tablespace_name, status
FROM dba_tablespaces;

SHOW CON_NAME;
SELECT tablespace_name FROM dba_tablespaces;

--Para conexión
--EN root
ALTER SESSION SET CONTAINER = CDB$ROOT;
--Abrir pdbs
SHOW PDBS;
ALTER PLUGGABLE DATABASE DESAR OPEN;
ALTER PLUGGABLE DATABASE QA OPEN;
ALTER PLUGGABLE DATABASE COME OPEN;

--CONEXIONES
--Crear link desde DESAR
ALTER SESSION SET CONTAINER = DESAR;

CREATE DATABASE LINK link_qa
CONNECT TO u_qa IDENTIFIED BY lticPUCE24
USING 'qa';

CREATE DATABASE LINK link_come
CONNECT TO u_come IDENTIFIED BY lticPUCE24
USING 'come';

--Crear link desde QA
ALTER SESSION SET CONTAINER = QA;

CREATE DATABASE LINK link_desar
CONNECT TO u_desar IDENTIFIED BY lticPUCE24
USING 'desar';

CREATE DATABASE LINK link_come
CONNECT TO u_come IDENTIFIED BY lticPUCE24
USING 'come';

--Crear link desde COME
ALTER SESSION SET CONTAINER = COME;

CREATE DATABASE LINK link_desar
CONNECT TO u_desar IDENTIFIED BY lticPUCE24
USING 'desar';

CREATE DATABASE LINK link_qa
CONNECT TO u_qa IDENTIFIED BY lticPUCE24
USING 'qa';

