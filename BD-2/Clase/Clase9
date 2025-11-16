Base de Datos II- Clase 9

--En userdbII
--Máquina virtual: ALTER USER SYSTEM IDENTIFIED BY lticPUCE24;
--Script



--Script
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

drop trigger TIB_PAGO
/

drop trigger TUB_PAGO
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

drop index PEDCLI_PAGO2_FK
/

drop table PAGO cascade constraints
/

drop index CLI_PEDCLI2_FK
/

drop table PEDIDOCLIENTE cascade constraints
/

drop table PRODUCTO cascade constraints
/

drop index PROD_PROD_PEDCLI_FK
/

drop index PEDCLI_PROD_PEDCLI_FK
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
   CLI_TELEFONO         VARCHAR2(15),
   CLI_CORREO           VARCHAR2(60),
   constraint PK_CLIENTE primary key (CLI_CED_RUC)
)
   tablespace AULA
/

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   PAG_CODIGO           VARCHAR2(10)          not null,
   PED_NUMERO           VARCHAR2(10)          not null,
   PAG_MONTO            NUMBER(10,2),
   PAG_FECHA            DATE,
   constraint PK_PAGO primary key (PAG_CODIGO)
)
   tablespace AULA
/

/*==============================================================*/
/* Index: PEDCLI_PAGO2_FK                                       */
/*==============================================================*/
create index PEDCLI_PAGO2_FK on PAGO (
   PED_NUMERO ASC
)
tablespace I_AULA
/

/*==============================================================*/
/* Table: PEDIDOCLIENTE                                         */
/*==============================================================*/
create table PEDIDOCLIENTE (
   PED_NUMERO           VARCHAR2(10)          not null,
   CLI_CED_RUC          VARCHAR2(13)          not null,
   PED_FECHA            DATE,
   PED_ESTADO           VARCHAR2(28),
   constraint PK_PEDIDOCLIENTE primary key (PED_NUMERO)
)
   tablespace AULA
/

/*==============================================================*/
/* Index: CLI_PEDCLI2_FK                                        */
/*==============================================================*/
create index CLI_PEDCLI2_FK on PEDIDOCLIENTE (
   CLI_CED_RUC ASC
)
tablespace I_AULA
/

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRD_CODIGO           VARCHAR2(10)          not null,
   PRD_NOMBRE           VARCHAR2(60),
   PRD_PRECIO           NUMBER(10,2),
   PRD_EXISTENCIA       NUMBER(10,2),
   constraint PK_PRODUCTO primary key (PRD_CODIGO)
)
   tablespace AULA
/

/*==============================================================*/
/* Table: PRODUCTO_PEDCLI                                       */
/*==============================================================*/
create table PRODUCTO_PEDCLI (
   PRD_CODIGO           VARCHAR2(10)          not null,
   PED_NUMERO           VARCHAR2(10)          not null,
   PPC_CANTIDAD         NUMBER(10,2),
   constraint PK_PRODUCTO_PEDCLI primary key (PRD_CODIGO, PED_NUMERO)
)
   tablespace AULA
/

/*==============================================================*/
/* Index: PEDCLI_PROD_PEDCLI_FK                                 */
/*==============================================================*/
create index PEDCLI_PROD_PEDCLI_FK on PRODUCTO_PEDCLI (
   PED_NUMERO ASC
)
tablespace I_AULA
/

/*==============================================================*/
/* Index: PROD_PROD_PEDCLI_FK                                   */
/*==============================================================*/
create index PROD_PROD_PEDCLI_FK on PRODUCTO_PEDCLI (
   PRD_CODIGO ASC
)
tablespace I_AULA
/


create trigger TDB_CLIENTE before delete
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PEDIDOCLIENTE"
    cursor cfk1_pedidocliente(var_cli_ced_ruc varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  CLI_CED_RUC = var_cli_ced_ruc
        and   var_cli_ced_ruc is not null;

begin
    --  Cannot delete parent "CLIENTE" if children still exist in "PEDIDOCLIENTE"
    open  cfk1_pedidocliente(:old.CLI_CED_RUC);
    fetch cfk1_pedidocliente into dummy;
    found := cfk1_pedidocliente%FOUND;
    close cfk1_pedidocliente;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PEDIDOCLIENTE". Cannot delete parent "CLIENTE".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CLIENTE before update
of CLI_CED_RUC
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "PEDIDOCLIENTE"
    cursor cfk1_pedidocliente(var_cli_ced_ruc varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  CLI_CED_RUC = var_cli_ced_ruc
        and   var_cli_ced_ruc is not null;

begin
    --  Cannot modify parent code in "CLIENTE" if children still exist in "PEDIDOCLIENTE"
    if (updating('CLI_CED_RUC') and :old.CLI_CED_RUC != :new.CLI_CED_RUC) then
       open  cfk1_pedidocliente(:old.CLI_CED_RUC);
       fetch cfk1_pedidocliente into dummy;
       found := cfk1_pedidocliente%FOUND;
       close cfk1_pedidocliente;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PEDIDOCLIENTE". Cannot modify parent code in "CLIENTE".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PAGO before insert
on PAGO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PEDIDOCLIENTE"
    cursor cpk1_pago(var_ped_numero varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;

begin
    --  Parent "PEDIDOCLIENTE" must exist when inserting a child in "PAGO"
    if :new.PED_NUMERO is not null then
       open  cpk1_pago(:new.PED_NUMERO);
       fetch cpk1_pago into dummy;
       found := cpk1_pago%FOUND;
       close cpk1_pago;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PEDIDOCLIENTE". Cannot create child in "PAGO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PAGO before update
of PAG_CODIGO,
   PED_NUMERO
on PAGO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PEDIDOCLIENTE"
    cursor cpk1_pago(var_ped_numero varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PEDIDOCLIENTE" must exist when updating a child in "PAGO"
    if (:new.PED_NUMERO is not null) and (seq = 0) then
       open  cpk1_pago(:new.PED_NUMERO);
       fetch cpk1_pago into dummy;
       found := cpk1_pago%FOUND;
       close cpk1_pago;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PEDIDOCLIENTE". Cannot update child in "PAGO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_PEDIDOCLIENTE before delete
on PEDIDOCLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PAGO"
    cursor cfk1_pago(var_ped_numero varchar) is
       select 1
       from   PAGO
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;
    --  Declaration of DeleteParentRestrict constraint for "PRODUCTO_PEDCLI"
    cursor cfk2_producto_pedcli(var_ped_numero varchar) is
       select 1
       from   PRODUCTO_PEDCLI
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;

begin
    --  Cannot delete parent "PEDIDOCLIENTE" if children still exist in "PAGO"
    open  cfk1_pago(:old.PED_NUMERO);
    fetch cfk1_pago into dummy;
    found := cfk1_pago%FOUND;
    close cfk1_pago;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PAGO". Cannot delete parent "PEDIDOCLIENTE".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PEDIDOCLIENTE" if children still exist in "PRODUCTO_PEDCLI"
    open  cfk2_producto_pedcli(:old.PED_NUMERO);
    fetch cfk2_producto_pedcli into dummy;
    found := cfk2_producto_pedcli%FOUND;
    close cfk2_producto_pedcli;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRODUCTO_PEDCLI". Cannot delete parent "PEDIDOCLIENTE".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PEDIDOCLIENTE before insert
on PEDIDOCLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "CLIENTE"
    cursor cpk1_pedidocliente(var_cli_ced_ruc varchar) is
       select 1
       from   CLIENTE
       where  CLI_CED_RUC = var_cli_ced_ruc
        and   var_cli_ced_ruc is not null;

begin
    --  Parent "CLIENTE" must exist when inserting a child in "PEDIDOCLIENTE"
    if :new.CLI_CED_RUC is not null then
       open  cpk1_pedidocliente(:new.CLI_CED_RUC);
       fetch cpk1_pedidocliente into dummy;
       found := cpk1_pedidocliente%FOUND;
       close cpk1_pedidocliente;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot create child in "PEDIDOCLIENTE".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PEDIDOCLIENTE before update
of PED_NUMERO,
   CLI_CED_RUC
on PEDIDOCLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "CLIENTE"
    cursor cpk1_pedidocliente(var_cli_ced_ruc varchar) is
       select 1
       from   CLIENTE
       where  CLI_CED_RUC = var_cli_ced_ruc
        and   var_cli_ced_ruc is not null;
    --  Declaration of UpdateParentRestrict constraint for "PAGO"
    cursor cfk1_pago(var_ped_numero varchar) is
       select 1
       from   PAGO
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;
    --  Declaration of UpdateParentRestrict constraint for "PRODUCTO_PEDCLI"
    cursor cfk2_producto_pedcli(var_ped_numero varchar) is
       select 1
       from   PRODUCTO_PEDCLI
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "CLIENTE" must exist when updating a child in "PEDIDOCLIENTE"
    if (:new.CLI_CED_RUC is not null) and (seq = 0) then
       open  cpk1_pedidocliente(:new.CLI_CED_RUC);
       fetch cpk1_pedidocliente into dummy;
       found := cpk1_pedidocliente%FOUND;
       close cpk1_pedidocliente;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot update child in "PEDIDOCLIENTE".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PEDIDOCLIENTE" if children still exist in "PAGO"
    if (updating('PED_NUMERO') and :old.PED_NUMERO != :new.PED_NUMERO) then
       open  cfk1_pago(:old.PED_NUMERO);
       fetch cfk1_pago into dummy;
       found := cfk1_pago%FOUND;
       close cfk1_pago;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PAGO". Cannot modify parent code in "PEDIDOCLIENTE".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PEDIDOCLIENTE" if children still exist in "PRODUCTO_PEDCLI"
    if (updating('PED_NUMERO') and :old.PED_NUMERO != :new.PED_NUMERO) then
       open  cfk2_producto_pedcli(:old.PED_NUMERO);
       fetch cfk2_producto_pedcli into dummy;
       found := cfk2_producto_pedcli%FOUND;
       close cfk2_producto_pedcli;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRODUCTO_PEDCLI". Cannot modify parent code in "PEDIDOCLIENTE".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


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
       from   PRODUCTO_PEDCLI
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
       errmsg := 'Children still exist in "PRODUCTO_PEDCLI". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO before update
of PRD_CODIGO
on PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "PRODUCTO_PEDCLI"
    cursor cfk1_producto_pedcli(var_prd_codigo varchar) is
       select 1
       from   PRODUCTO_PEDCLI
       where  PRD_CODIGO = var_prd_codigo
        and   var_prd_codigo is not null;

begin
    --  Cannot modify parent code in "PRODUCTO" if children still exist in "PRODUCTO_PEDCLI"
    if (updating('PRD_CODIGO') and :old.PRD_CODIGO != :new.PRD_CODIGO) then
       open  cfk1_producto_pedcli(:old.PRD_CODIGO);
       fetch cfk1_producto_pedcli into dummy;
       found := cfk1_producto_pedcli%FOUND;
       close cfk1_producto_pedcli;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRODUCTO_PEDCLI". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO_PEDCLI before insert
on PRODUCTO_PEDCLI for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PEDIDOCLIENTE"
    cursor cpk1_producto_pedcli(var_ped_numero varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_producto_pedcli(var_prd_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRD_CODIGO = var_prd_codigo
        and   var_prd_codigo is not null;

begin
    --  Parent "PEDIDOCLIENTE" must exist when inserting a child in "PRODUCTO_PEDCLI"
    if :new.PED_NUMERO is not null then
       open  cpk1_producto_pedcli(:new.PED_NUMERO);
       fetch cpk1_producto_pedcli into dummy;
       found := cpk1_producto_pedcli%FOUND;
       close cpk1_producto_pedcli;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PEDIDOCLIENTE". Cannot create child in "PRODUCTO_PEDCLI".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when inserting a child in "PRODUCTO_PEDCLI"
    if :new.PRD_CODIGO is not null then
       open  cpk2_producto_pedcli(:new.PRD_CODIGO);
       fetch cpk2_producto_pedcli into dummy;
       found := cpk2_producto_pedcli%FOUND;
       close cpk2_producto_pedcli;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "PRODUCTO_PEDCLI".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO_PEDCLI before update
of PRD_CODIGO,
   PED_NUMERO
on PRODUCTO_PEDCLI for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PEDIDOCLIENTE"
    cursor cpk1_producto_pedcli(var_ped_numero varchar) is
       select 1
       from   PEDIDOCLIENTE
       where  PED_NUMERO = var_ped_numero
        and   var_ped_numero is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_producto_pedcli(var_prd_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRD_CODIGO = var_prd_codigo
        and   var_prd_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PEDIDOCLIENTE" must exist when updating a child in "PRODUCTO_PEDCLI"
    if (:new.PED_NUMERO is not null) and (seq = 0) then
       open  cpk1_producto_pedcli(:new.PED_NUMERO);
       fetch cpk1_producto_pedcli into dummy;
       found := cpk1_producto_pedcli%FOUND;
       close cpk1_producto_pedcli;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PEDIDOCLIENTE". Cannot update child in "PRODUCTO_PEDCLI".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when updating a child in "PRODUCTO_PEDCLI"
    if (:new.PRD_CODIGO is not null) and (seq = 0) then
       open  cpk2_producto_pedcli(:new.PRD_CODIGO);
       fetch cpk2_producto_pedcli into dummy;
       found := cpk2_producto_pedcli%FOUND;
       close cpk2_producto_pedcli;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "PRODUCTO_PEDCLI".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



--CREACIÓN DEL USUARIO:
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER bd2 IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE TO bd2;

--CREACIÓN DE ROLES:
--Matriz de roles
CREATE ROLE bodeguero;
GRANT INSERT, SELECT, UPDATE ON USERDBII.PRODUCTO TO BODEGUERO;
GRANT bodeguero TO bd2;

--- conectarse a bd2 ---
--verificar acceso a tablas


--- en userdbII ---
SELECT * FROM TAB;
select * from cliente;
select * from producto;
-- INSERCIÓN DE CLIENTES Y PRODUCTOS --

UPDATE PRODUCTO SET prd_existencia = prd_existencia+50
WHERE prd_codigo = 'P001';
--si tenía 100, este usuario si puede ver suma
--otro usuario no hasta hacer commit:



--- en bd2 ---
select * from userdbii.producto;

--Se registra existencia de productos
--Se registra el pago
--Se genera registro
