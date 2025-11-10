--BASE DE DATOS - Clase 6-7
create tablespace AULA_I
datafile '/u01/app/oracle/oradata/ORCL/AULA_I.dbf'
size 1G
 autoextend on next 500M
/
--script de departamento y empleado
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


drop trigger TDB_DEPARTAMENTO
/

drop trigger TUB_DEPARTAMENTO
/

drop trigger TIB_EMPLEADO
/

drop trigger TUB_EMPLEADO
/

drop table DEPARTAMENTO cascade constraints
/

drop index EMPLE_DEPARTAMENTO_FK
/

drop table EMPLEADO cascade constraints
/



/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
create table DEPARTAMENTO (
   DEP_ID               INTEGER               not null,
   DEP_NOMBRE           VARCHAR2(50),
   constraint PK_DEPARTAMENTO primary key (DEP_ID)
)
   tablespace AULA
/

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EMP_ID               INTEGER               not null,
   DEP_ID               INTEGER               not null,
   EMP_NOMBRE           VARCHAR2(50),
   EMP_EDAD             INTEGER,
   EMP_SALARIO          NUMBER(10,2),
   constraint PK_EMPLEADO primary key (EMP_ID)
)
   tablespace AULA
/

/*==============================================================*/
/* Index: EMPLE_DEPARTAMENTO_FK                                 */
/*==============================================================*/
create index EMPLE_DEPARTAMENTO_FK on EMPLEADO (
   DEP_ID ASC
)
tablespace AULA_I
/


create trigger TDB_DEPARTAMENTO before delete
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "EMPLEADO"
    cursor cfk1_empleado(var_dep_id integer) is
       select 1
       from   EMPLEADO
       where  DEP_ID = var_dep_id
        and   var_dep_id is not null;

begin
    --  Cannot delete parent "DEPARTAMENTO" if children still exist in "EMPLEADO"
    open  cfk1_empleado(:old.DEP_ID);
    fetch cfk1_empleado into dummy;
    found := cfk1_empleado%FOUND;
    close cfk1_empleado;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "EMPLEADO". Cannot delete parent "DEPARTAMENTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_DEPARTAMENTO before update
of DEP_ID
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "EMPLEADO"
    cursor cfk1_empleado(var_dep_id integer) is
       select 1
       from   EMPLEADO
       where  DEP_ID = var_dep_id
        and   var_dep_id is not null;

begin
    --  Cannot modify parent code in "DEPARTAMENTO" if children still exist in "EMPLEADO"
    if (updating('DEP_ID') and :old.DEP_ID != :new.DEP_ID) then
       open  cfk1_empleado(:old.DEP_ID);
       fetch cfk1_empleado into dummy;
       found := cfk1_empleado%FOUND;
       close cfk1_empleado;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "EMPLEADO". Cannot modify parent code in "DEPARTAMENTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_EMPLEADO before insert
on EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "DEPARTAMENTO"
    cursor cpk1_empleado(var_dep_id integer) is
       select 1
       from   DEPARTAMENTO
       where  DEP_ID = var_dep_id
        and   var_dep_id is not null;

begin
    --  Parent "DEPARTAMENTO" must exist when inserting a child in "EMPLEADO"
    if :new.DEP_ID is not null then
       open  cpk1_empleado(:new.DEP_ID);
       fetch cpk1_empleado into dummy;
       found := cpk1_empleado%FOUND;
       close cpk1_empleado;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "DEPARTAMENTO". Cannot create child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_EMPLEADO before update
of EMP_ID,
   DEP_ID
on EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "DEPARTAMENTO"
    cursor cpk1_empleado(var_dep_id integer) is
       select 1
       from   DEPARTAMENTO
       where  DEP_ID = var_dep_id
        and   var_dep_id is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "DEPARTAMENTO" must exist when updating a child in "EMPLEADO"
    if (:new.DEP_ID is not null) and (seq = 0) then
       open  cpk1_empleado(:new.DEP_ID);
       fetch cpk1_empleado into dummy;
       found := cpk1_empleado%FOUND;
       close cpk1_empleado;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "DEPARTAMENTO". Cannot update child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


--clase ----------------NO PONER---
BEGIN
    FOR i in 1..1000 LOOP
        INSERT INTO empleado VALUES(i, dbms_random.value(1,10), dbms_random.string('U',50),
        dbms_randoms.value(10,75), dbms_random.value(1000,5000);
    END LOOP;
END;
/
--NO VALE LO DE ARRIBA --NO PONER---
    
    

BEGIN
	FOR i in 1..10 LOOP
		INSERT INTO departamento VALUES(i,dbms_random.string('U',50));
		IF mod(i,500)=0 THEN
			commit;
		END IF;
	END LOOP;
END;
/

SELECT * FROM departamento;
desc departamento;

BEGIN
    FOR i in 1..1000 LOOP
        INSERT INTO empleado VALUES(i,dbms_random.value(1,10), dbms_random.string('U',20),dbms_random.value(18,65),dbms_random.value(450,2500));
        IF mod(i,500)=0 THEN
            commit;
        END IF;
    END LOOP;
END;
/
 
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII', 'EMPLEADO');
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII', 'DEPARTAMENTO');

select table_name, num_rows, blocks
from user_tables
where table_name IN ('DEPARTAMENTO', 'EMPLEADO');

DEPARTAMENTO	10	5
EMPLEADO	1000	13

select table_name, num_rows, blocks
from dba_tables
where table_name IN ('DEPARTAMENTO', 'EMPLEADO');

DEPARTAMENTO		
DEPARTAMENTO	10	5
EMPLEADO	1000	13

--SELECT DEL TALLER

SELECT SEGMENT_NAME, BLOCKS, BYTES
FROM dba_segments
WHERE SEGMENT_TYPE='TABLE' 
AND OWNER= 'USERDBII'
AND segment_name IN ('DEPARTAMENTO', 'EMPLEADO');



DEPARTAMENTO	8	65536
EMPLEADO	16	131072
