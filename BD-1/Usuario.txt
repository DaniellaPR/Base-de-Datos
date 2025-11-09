--Tablespaces
create tablespace DATOS
datafile '/u01/app/oracle/oradata/ORCL/DATOS.dbf'
size 2G
 autoextend on next 500M
/

create tablespace INDICES
datafile '/u01/app/oracle/oradata/ORCL/INDICES.dbf'
size 500M
 autoextend on next 500M
/


--Para usuario:
ALTER USER system IDENTIFIED BY lticPUCE24;
CREATE USER facadmin IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
SELECT * FROM dba_users;
GRANT CONNECT, RESOURCE, DBA TO facadmin WITH ADMIN OPTION;
