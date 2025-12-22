--22/12/2025 :3
--levantar 2 BD conectarse con usuario sys rol: DBA

--SYS1
show pdbs;

ALTER PLUGGABLE DATABASE desar OPEN;
ALTER PLUGGABLE DATABASE QA OPEN;

--pasamos al pdb desar --no necesario
ALTER SESSION SET CONTAINER = DESAR;
ALTER SESSION SET CONTAINER = CDB$ROOT;

--Conectarse con el usuario DESAR

--SYS2
show pdbs;

CREATE PLUGGABLE DATABASE COMEE
ADMIN USER ucomee IDENTIFIED BY "lticPUCE24"
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/ORCL/pdbseed/', '/u01/app/oracle/oradata/ORCL/COMEE/');

ALTER PLUGGABLE DATABASE comee OPEN;  --abre pdb
ALTER SESSION SET CONTAINER = COMEE;  --cambiamos a sesión comee (comercio electrónico)

show con_name;
GRANT DBA TO ucomee;

CREATE TABLESPACE DATOS
DATAFILE '/u01/app/oracle/oradata/ORCL/COMEE/DATOS.dbf'
size 1000M
autoextend on next 500M;

CREATE TABLESPACE INDICES
DATAFILE '/u01/app/oracle/oradata/ORCL/COMEE/INDICES.dbf'
size 500M
autoextend on next 500M;

CREATE USER administrador IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS;
--Creamos el usuario administrador de la bd

GRANT CONNECT, RESOURCE, DBA TO administrador WITH ADMIN OPTION;
--CONECTARSE A ADMINISTRADOR

--En adminsitrador
--script
-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;
/

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop table CLIENTE cascade constraints
/

drop index PEDIDOCLIENTE_PAGO_FK
/

drop index CLIENTE_PEDIDOCLIENTE_FK
/

drop table PEDIDOCLIENTE cascade constraints
/

drop table PRODUCTO cascade constraints
/

drop index PRODUCTO_PRDPEDCLI_FK
/

drop index PEDCLI_PRODPEDCLI_FK
/

drop table PRODUCTO_PEDCLI cascade constraints
/

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLI_CED_RUC          VARCHAR2(13)          not null,
   CLI_NOMBRE           VARCHAR2(60),
   CLI_DIRECCION        VARCHAR2(60),
   CLI_TELEFONO         VARCHAR2(10),
   CLI_CORREO           VARCHAR2(60),
   constraint PK_CLIENTE primary key (CLI_CED_RUC)
)
   tablespace DATOS
/


/*==============================================================*/
/* Table: PEDIDOCLIENTE                                         */
/*==============================================================*/
create table PEDIDOCLIENTE (
   PED_NUMERO           NUMBER(12)            not null,
   CLI_CED_RUC          VARCHAR2(13)          not null,
   PED_FECHA            DATE,
   PED_ESTADO           VARCHAR2(20),
   constraint PK_PEDIDOCLIENTE primary key (PED_NUMERO)
)
   tablespace DATOS
/

/*==============================================================*/
/* Index: CLIENTE_PEDIDOCLIENTE_FK                              */
/*==============================================================*/
create index CLIENTE_PEDIDOCLIENTE_FK on PEDIDOCLIENTE (
   CLI_CED_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PRODUCTO_PEDCLI                                       */
/*==============================================================*/
create table PRODUCTO_PEDCLI (
   PRD_CODIGO           VARCHAR2(10)          not null,
   PED_NUMERO           NUMBER(12)            not null,
   PPC_CANTIDAD         NUMBER(12,2)
)
   tablespace DATOS
/

/*==============================================================*/
/* Index: PEDCLI_PRODPEDCLI_FK                                  */
/*==============================================================*/
create index PEDCLI_PRODPEDCLI_FK on PRODUCTO_PEDCLI (
   PED_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PRODUCTO_PRDPEDCLI_FK                                 */
/*==============================================================*/
create index PRODUCTO_PRDPEDCLI_FK on PRODUCTO_PEDCLI (
   PRD_CODIGO ASC
)
tablespace INDICES
/



INSERT INTO CLIENTE VALUES ('0102030405001', 'Juan Pérez', 'Av. Siempre Viva 123', '0991112222', 'juan.perez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405002', 'Ana Gómez', 'Calle Principal 456', '0993334444', 'ana.gomez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405003', 'Pedro Sánchez', 'Av. Amazonas 789', '0995556666', 'pedro.sanchez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405004', 'Luis Torres', 'Calle 1 234', '0997778888', 'luis.torres@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405005', 'Sofía Morales', 'Calle 2 456', '0999990000', 'sofia.morales@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405006', 'Carlos Ruiz', 'Av. Oriente 789', '0981112222', 'carlos.ruiz@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405007', 'María López', 'Av. Central 123', '0983334444', 'maria.lopez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405008', 'Andrés Vega', 'Calle Secundaria 456', '0985556666', 'andres.vega@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405009', 'Diana Ramírez', 'Av. Sur 789', '0987778888', 'diana.ramirez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405010', 'Jorge Salazar', 'Calle Oeste 123', '0989990000', 'jorge.salazar@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405011', 'Paola Ortiz', 'Av. Norte 234', '0971112222', 'paola.ortiz@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405012', 'David Cordero', 'Av. Centro 345', '0973334444', 'david.cordero@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405013', 'Camila Herrera', 'Calle Este 456', '0975556666', 'camila.herrera@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405014', 'Ricardo Vaca', 'Av. Central 567', '0977778888', 'ricardo.vaca@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405015', 'Laura Fernández', 'Calle Nueva 678', '0979990000', 'laura.fernandez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405016', 'Felipe Benítez', 'Av. Lateral 123', '0961112222', 'felipe.benitez@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405017', 'Isabel Castillo', 'Av. Esquina 234', '0963334444', 'isabel.castillo@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405018', 'Diego Mendoza', 'Calle Norte 345', '0965556666', 'diego.mendoza@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405019', 'Rosa Guzmán', 'Av. Sur 456', '0967778888', 'rosa.guzman@mail.com');
INSERT INTO CLIENTE VALUES ('0102030405020', 'Tomás Paredes', 'Calle Céntrica 567', '0969990000', 'tomas.paredes@mail.com');
select * from cliente;
commit;


INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (1, '0102030405001', SYSDATE - 10, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (2, '0102030405001', SYSDATE - 9, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (3, '0102030405001', SYSDATE - 8, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (4, '0102030405001', SYSDATE - 7, 'CANCELADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (5, '0102030405001', SYSDATE - 6, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (6, '0102030405002', SYSDATE - 5, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (7, '0102030405002', SYSDATE - 4, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (8, '0102030405002', SYSDATE - 3, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (9, '0102030405002', SYSDATE - 2, 'CANCELADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (10, '0102030405002', SYSDATE - 1, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (11, '0102030405003', SYSDATE - 10, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (12, '0102030405003', SYSDATE - 9, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (13, '0102030405003', SYSDATE - 8, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (14, '0102030405004', SYSDATE - 7, 'CANCELADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (15, '0102030405004', SYSDATE - 6, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (16, '0102030405004', SYSDATE - 5, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (17, '0102030405005', SYSDATE - 4, 'PENDIENTE');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (18, '0102030405005', SYSDATE - 3, 'ENTREGADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (19, '0102030405005', SYSDATE - 2, 'CANCELADO');
INSERT INTO PEDIDOCLIENTE (PED_NUMERO, CLI_CED_RUC, PED_FECHA, PED_ESTADO) VALUES (20, '0102030405005', SYSDATE - 1, 'PENDIENTE');

INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P001', 1, 10.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P002', 1, 5.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P003', 1, 2.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P004', 1, 8.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P005', 2, 3.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P006', 2, 1.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P007', 2, 4.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P008', 2, 6.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P009', 3, 10.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P010', 3, 5.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P011', 3, 2.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P012', 3, 8.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P013', 4, 3.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P014', 4, 1.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P015', 4, 4.00);
INSERT INTO PRODUCTO_PEDCLI (PRD_CODIGO, PED_NUMERO, PPC_CANTIDAD) VALUES ('P016', 4, 6.00);

commit;



--Cpnetarse con con el segundo servidor SYS1 a MOBA
cd /u01/app/oracle/homes/OraDB21Home1/network/admin/
vi tnsnames.ora
--Dentro:
LISTENER_ORCL =
  (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))


ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )


DESAR =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.9.168)(PORT = 1521))
    (CONNECT_DATA =
       (SERVER = DEDICATED)
       (SERVICE_NAME = DESAR)
    )
 )


QA =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.9.168)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = QA)
    )
  )

GYQ =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.8.169)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = COMEE)
    )
  )


--En servidor 2

LISTENER_ORCL =
  (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))


ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )


QYT =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.9.168)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = DESAR)
    )
  )


--GRABAR: :wq
--ESCRIBIR: i

--Salir y verificar: tnsping qyt
--Hacer ping al otro server: ping 172.16.9.168


--En u desar
CREATE DATABASE LINK link_gyq
CONNECT TO administrador IDENTIFIED BY lticPUCE24
USING 'GYQ';

SELECT * FROM cliente@link_gyq;

--INTEGRIDAD REFERNENCIAL CON DSIAPRADORES, NO EDITAR CONSTRAINT. 

--Modelo completo
--Saar disparador mismo u desar
create trigger TDB_PRODUCTO before delete
on PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PRODUCTO_PEDCLI"
    cursor cfk1_producto_pedcli(var_prd_codigo varchar) is
       select 1
       from   PRODUCTO_PEDCLI@link_gyq
       where  PRD_CODIGO = var_prd_codigo
        and   var_prd_codigo is not null;

begin
    --  Cannot delete parent "PRODUCTO" if children still exist in "PRODUCTO_PEDCLI"
    open  cfk1_producto_pedcli(:old.PRD_CODIGO);
    fetch cfk1_producto_pedcli into dummy;
    found := cfk1_producto_pedcli%FOUND;
    close cfk1_producto_pedcli;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRODUCTO_PEDCLI". En el server de GYQ Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

--Ver que productos tiene
select * from producto;
DELETE FROM producto WHERE prd_codigo = 'P001';

--disparadores relacionados en cada servidor, correr en cada servidor donde este la tabla. Procedimientos almacenados.
--Actualizar registro en guayaquil hacer referencia a la de guayaquil
--Distribucion para tener BD en servidor de coemrcio electronico y tabla en transaccionalidad
--En comercio electrónico se debe distribuir o replicar:
--Se debe replicar: automatica o manual. Todos los objetos se replican en cada servidor.
--Para comercio solo ciertas tablas se replican.
--Ditribución y con disparadore ayudan a este segundo tipo de replicación. Si modifican la existenci aen una tabla en SYS 1, también se modifica en el 2do.
--Disparador de after para replicación, despues de haber insertado registro, insertar en el otro. Igual con update y delete.

