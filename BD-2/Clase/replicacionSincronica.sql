--Conectarse con mobaXterm
--Conectarse al sqldeveloper con sys, rol:DBA
--Levantar 2 bases de datos
--Principal: QYT
--Standby: GYQ

--PRINCIIPAL:
--Server 1 - MOBA - QUITO
(solo en quito para replicación y principal)
lsnrctl start
sqlplus / as sysdba

archive log list;
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;  --abrir en modomultiusuario considerada como server principal
shutdown immediate;
startup
archive log list;
alter system set log_archive_config='DG_CONFIG=(QYT,GYQ)' SCOPE=BOTH;
alter system set log_archive_dest_2='SERVICE=GYQ ASYNC VALID FOR=(ONLINE_LOGFILE,PRIMARY_ROLE) DB_UNIQUE_NAME=GYQ' SCOPE=BOTH; --paraa que se amemoria y físico scope
alter system set fal_server=GYQ SCOPE=BOTH;

replica trigger database hacer integridad refrerencial distribuida solo de la tabla 
