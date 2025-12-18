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
--18/12/2025
--EN DESAR

--Taller 6-2
//VERIFICAR EN SQLDEVELOPER que existan instancias qa y desar o sino crear
--Levantar 2 servidores en linux, en el primero:
--abrir moba xterm
>lsnrctl status (instancias creadas desar y qa)
>cd + seleccionar lo que queremos pegar direccion + clic derecho  //ir a carpeta network en home1 en orabd21home1 en hoes en oracle en app en u01  
>cd admin
>ls
>ls -l

//Editar documento tnsnames.ora lo primero en un servidor adminsitrador eliminar nano y edit, solo vi para ser utilizado. Editor de texto seguro en linux
>vi tnsnames.ora
//duplicar lo de ORCL cambiar instancia ORCL a desar o qa, cambiar IP por la segunda base de datos levantada, nombre del servicio desar. y tmbién con qa

//Ya en oracledb
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER PLUGGABLE DATABASE desar OPEN;
ALTER PLUGGABLE DATABASE QA OPEN;

--creamos usuario que será dueño de los pdb
SHOW CON_NAME; --va a decir en que pdb estamos
ALTER SESSION SET CONTAINER = DESAR;
SHOW CON_NAME; 
--
grant dba to udesar;
CREATE TABLESPACE DATOS DATAFILE '/u01/app/oracle/oradata/ORCL/DESAR/DATOS.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE TABLESPACE INDICES DATAFILE '/u01/app/oracle/oradata/ORCL/DESAR/INDICES.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

SELECT * FROM DBA_TABLESPACES;

CREATE USER u_desar IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS;
--usuario dentro de desar = u_desar, el admin para desar = udesar
GRANT CONNECT, RESOURCE, DBA TO u_desar WITH ADMIN OPTION;
--Crear cadena de conexión conectandose con u_prod como usuario, contraseña y no poner CID sino Nombre del servicio DESAR
--parte fisica en linux, logica base de datos

--uNA VEZ ABIERTA COLOCAR SCRIPT:
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


drop trigger TDB_CLIENTE
/

drop trigger TUB_CLIENTE
/

drop trigger TIB_PAGOS
/

drop trigger TUB_PAGOS
/

drop trigger TDB_PEDIDOCLIENTE
/

drop trigger TIB_PEDIDOCLIENTE
/

drop trigger TUB_PEDIDOCLIENTE
/

drop trigger TDB_PRODUCTO
/

drop trigger TUB_PRODUCTO
/

drop trigger TIB_PRODUCTO_PEDCLI
/

drop trigger TUB_PRODUCTO_PEDCLI
/

drop table CLIENTE cascade constraints
/

drop index PEDIDOCLIENTE_PAGO_FK
/

drop table PAGOS cascade constraints
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
/* Table: PAGOS                                                 */
/*==============================================================*/
create table PAGOS (
   PAG_CODIGO           VARCHAR2(15)          not null,
   PED_NUMERO           NUMBER(12)            not null,
   PAG_MONTO            NUMBER(12,2),
   PAG_FECHA            DATE,
   constraint PK_PAGOS primary key (PAG_CODIGO)
)
   tablespace DATOS
/

/*==============================================================*/
/* Index: PEDIDOCLIENTE_PAGO_FK                                 */
/*==============================================================*/
create index PEDIDOCLIENTE_PAGO_FK on PAGOS (
   PED_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRD_CODIGO           VARCHAR2(10)          not null,
   PRD_NOMBRE           CHAR(30),
   PRD_CATEGORIA	NUMBER(10)	      not null,
   PRD_PRECIO           NUMBER(12,2),
   PRD_EXISTENCIA       NUMBER(10),
   constraint CKC_PRD_EXISTENCIA_PRODUCTO check (PRD_EXISTENCIA is null or (PRD_EXISTENCIA >= '0')),
   constraint PK_PRODUCTO primary key (PRD_CODIGO)
)
   tablespace DATOS
/

SeLECT * FROM TAB; --VERIFICAR las dos tablas.


--LO MISMO PARA LA OTRA INSANCIA QA
ALTER SESSION SET CONTAINER = QA;
SHOW CON_NAME; 
--
grant dba to uqa; --usuario creado en clase anterior
CREATE TABLESPACE DATOS DATAFILE '/u01/app/oracle/oradata/ORCL/QA/DATOS.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

CREATE TABLESPACE INDICES DATAFILE '/u01/app/oracle/oradata/ORCL/QA/INDICES.dbf'
SIZE 500M
AUTOEXTEND ON NEXT 500M
/

SELECT * FROM DBA_TABLESPACES;

CREATE USER u_qa IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS;
--usuario dentro de desar = u_qa, el admin para QA = uqa
GRANT CONNECT, RESOURCE, DBA TO u_qa WITH ADMIN OPTION;

--CONECTARSE A u_qa
--script:
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

SELECT * FROM TAB;
--DESAR = QUITO
--QA = GUAYAQUIL

--EN QA INDSERTAR DATOS
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
select * from producto_pedcli;




--datos poner en DESAR:

INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG001', 1, 50.00, SYSDATE - 5);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG002', 2, 70.00, SYSDATE - 4);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG003', 3, 100.00, SYSDATE - 3);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG004', 4, 40.00, SYSDATE - 2);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG005', 5, 60.00, SYSDATE - 1);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG006', 6, 50.00, SYSDATE - 6);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG007', 7, 70.00, SYSDATE - 7);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG008', 8, 100.00, SYSDATE - 8);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG009', 9, 40.00, SYSDATE - 9);
INSERT INTO PAGOS (PAG_CODIGO, PED_NUMERO, PAG_MONTO, PAG_FECHA) VALUES ('PAG010', 10, 60.00, SYSDATE - 10);
commit;
select * from pagos;
desc producto;
ALTER TABLE PRODUCTO DROP COLUMN PRD_CATEGORIA;
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P001', 'Lápiz', 0.50, 100);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P002', 'Cuaderno', 1.20, 200);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P003', 'Borrador', 0.30, 150);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P004', 'Bolígrafo', 0.80, 300);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P005', 'Regla', 0.60, 100);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P006', 'Tijera', 1.50, 50);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P007', 'Pegamento', 1.00, 120);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P008', 'Cartulina', 0.90, 80);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P009', 'Marcador', 1.20, 70);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P010', 'Crayones', 2.50, 60);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P011', 'Sacapuntas', 0.40, 250);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P012', 'Hojas', 0.10, 500);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P013', 'Carpeta', 1.80, 40);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P014', 'Plumones', 2.00, 35);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P015', 'Corrector', 1.10, 90);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P016', 'Cuadro', 3.00, 15);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P017', 'Libro', 5.00, 20);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P018', 'Bloc', 1.90, 30);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P019', 'Cinta Adhesiva', 0.70, 300);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P020', 'Papel Bond', 2.80, 70);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P021', 'Calculadora', 12.00, 15);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P022', 'USB', 10.00, 50);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P023', 'Disco Duro', 70.00, 10);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P024', 'Mouse', 5.00, 40);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P025', 'Teclado', 8.00, 20);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P026', 'Monitor', 120.00, 5);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P027', 'CPU', 350.00, 5);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P028', 'Silla', 85.00, 10);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P029', 'Escritorio', 150.00, 3);
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_NOMBRE, PRD_PRECIO, PRD_EXISTENCIA) VALUES ('P030', 'Mochila', 25.00, 25);
commit;
select * from producto;



--HASTA AQUI PARA MAÑANA, GUAPA
  
