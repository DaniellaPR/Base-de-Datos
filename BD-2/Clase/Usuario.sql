--BASE DE TODO
--Iniciamos con system en oracle

create tablespace AULA
datafile '/u01/app/oracle/oradata/ORCL/AULA.dbf'
size 5G
 autoextend on next 500M
/

create tablespace I_AULA
datafile '/u01/app/oracle/oradata/ORCL/I_AULA.dbf'
size 1G
 autoextend on next 500M
/

ALTER USER system IDENTIFIED BY lticPUCE24;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER userdbII IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE, DBA TO userdbII WITH ADMIN OPTION;

--PRUEBA
CREATE USER prueba IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE TO prueba;
