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

--PRUEBA no hacer caso
CREATE USER prueba IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE TO prueba;



--Conectar a la base de datos userdbII. Borrar desde aquí

CREATE TABLE test_normal (
    empno NUMBER(10),
    ename VARCHAR2(30),
    sal NUMBER(10)
    )
    tablespace I_AULA
    /
--Conectar a la base de datos prueba

SELECT * FROM TAB;
DESC test_normal
--Para tener permisos se da al rol y le asignábamos el rol

--parte de la tareaaaaaaaaaa
BEGIN
  FOR i IN 1..2000000 LOOP
    INSERT INTO test_normal VALUES (i, DBMS_RANDOM.STRING('U',30), DBMS_RANDOM.VALUE(1000,5000));
    IF MOD(i, 10000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
END;
/

SELECT COUNT(*) FROM test_normal;






--PRIMERA PARTE CON BASE - BITMAP
--Luego
CREATE BITMAP INDEX normal_empno_bmx ON test_normal(empno);
SELECT SYS_CONTEXT('USERENV','SID') FROM DUAL;

INSERT INTO test_normal (empno, ename, sal)
VALUES (1000000, 'EJEMPLO', 2500);

--En otra session del mismo usuario | abrir con contraseña
SELECT SYS_CONTEXT('USERENV','SID') FROM DUAL;

INSERT INTO test_normal (empno, ename, sal)
VALUES (1000000, 'AAABBBCCCDDDEEEFFFGGGHHH', 2500); --clave primaria en tabla no hay,, e pueden poner dos 100000, a pesar de que hay 2 o 5 millones de datos, se pueden repetir

--En la primera anterior
SELECT 'SID=' || s1.sid || ' IS BLOCKING SID=' || s2.sid AS blocking_status
FROM v$lock l1, v$session s1, v$lock l2, v$session s2
WHERE s1.sid=l1.sid AND s2.sid=l2.sid
AND l1.BLOCK=1 AND l2.request > 0
AND l1.id1 = l2.id1
AND l2.id2 = l2.id2;

--Para matar sesión buscar serial
SELECT sid, serial#, username, program
FROM v$session
WHERE sid = <SID_BLOQUEADA>;  --recordar que aquí va la SID de la sesión B

--Ahpí sale el serial que vamos a utilizar

ALTER SYSTEM KILL SESSION '287,44643';  --se murió la sesión

--verificar cual quedó?
SELECT sid, status, username, program
FROM v$session
WHERE sid IN ( /* pon aquí SID de A y SID de B */ );


--Tarea aquí

--Creamos la tabla cliente similar a la de clase
CREATE TABLE CLIENTE (
   CLI_NUM_DOCUMENTO    VARCHAR2(13)  NOT NULL,
   EMP_CEDULA_RUC       VARCHAR2(13)  NOT NULL
     CONSTRAINT CKC_EMP_CEDULA_RUC_CLIENTE CHECK (EMP_CEDULA_RUC = UPPER(EMP_CEDULA_RUC)),
   CLI_TIPO_DOCUMENTO   VARCHAR2(1)
     CONSTRAINT CKC_CLI_TIPO_DOCUMENT_CLIENTE CHECK (
       CLI_TIPO_DOCUMENTO IS NULL OR
       (CLI_TIPO_DOCUMENTO IN ('C','P') AND CLI_TIPO_DOCUMENTO = UPPER(CLI_TIPO_DOCUMENTO))
     ),
   CLI_NOMBRE           VARCHAR2(60)
     CONSTRAINT CKC_CLI_NOMBRE_CLIENTE    CHECK (CLI_NOMBRE    IS NULL OR CLI_NOMBRE    = UPPER(CLI_NOMBRE)),
   CLI_DIRECCION        VARCHAR2(100)
     CONSTRAINT CKC_CLI_DIRECCION_CLIENTE CHECK (CLI_DIRECCION IS NULL OR CLI_DIRECCION = UPPER(CLI_DIRECCION)),
   CLI_SECTOR           VARCHAR2(60)
     CONSTRAINT CKC_CLI_SECTOR_CLIENTE    CHECK (CLI_SECTOR    IS NULL OR CLI_SECTOR    = UPPER(CLI_SECTOR)),
   CLI_TELEFONO         VARCHAR2(13)
     CONSTRAINT CKC_CLI_TELEFONO_CLIENTE  CHECK (CLI_TELEFONO  IS NULL OR CLI_TELEFONO  = UPPER(CLI_TELEFONO)),
   CLI_CORREO           VARCHAR2(50),
   CONSTRAINT PK_CLIENTE PRIMARY KEY (CLI_NUM_DOCUMENTO)
)
TABLESPACE AULA;
/
comment on table CLIENTE is 
'Tabla que contiene la información general de los clientes'
/
comment on column CLIENTE.CLI_NUM_DOCUMENTO is
'Cédula o RUC o pasaporte del cliente'
/
comment on column CLIENTE.EMP_CEDULA_RUC is
'Atributo que garantiza un registro único, contiene la cedula o ruc de la empresa'
/
comment on column CLIENTE.CLI_TIPO_DOCUMENTO is
'Es el tipo del número de documento del cliente este puede ser C=Cédula o RUC, P=Pasaporte'
/
comment on column CLIENTE.CLI_NOMBRE is
'Nombre completo del cliente'
/
comment on column CLIENTE.CLI_DIRECCION is
'Dirección física del cliente'
/
comment on column CLIENTE.CLI_SECTOR is
'Sector de vivienda del cliente'
/
comment on column CLIENTE.CLI_TELEFONO is
'Número telefónico del cliente'
/
comment on column CLIENTE.CLI_CORREO is
'Correo del cliente'
/

--Después se ingresan los datos, solo puse hasta 500 mil debido a las capacidades de mi computador
--Se usó nuevo código para la probabilidad del tipo de documento
--Se hacen commits igual que el ejemplo del taller cada 10 mil.
DECLARE
  v_tope PLS_INTEGER := 500000;
BEGIN
  FOR i IN 1..v_tope LOOP
    INSERT INTO CLIENTE(CLI_NUM_DOCUMENTO, EMP_CEDULA_RUC, CLI_TIPO_DOCUMENTO,CLI_NOMBRE, CLI_DIRECCION, CLI_SECTOR, CLI_TELEFONO, CLI_CORREO) 
    VALUES (
      LPAD(TO_CHAR(i), 13, '0'),
      LPAD(TO_CHAR(MOD(i, 9999999999999)+1), 13, '0'),
      CASE WHEN MOD(i,5)=0 THEN 'P' ELSE 'C' END,  -- Están en probabilidad 80% C / 20% P
      'NOMBRE_'||TO_CHAR(i),
      'DIRECCION_'||TO_CHAR(i),
      'SECTOR_'||TO_CHAR(i),
      LPAD(TO_CHAR(MOD(i*37, 9999999999999)+1), 13, '0'),
      'X'||TO_CHAR(i)||'@MAIL.COM'
    );

    IF MOD(i,10000)=0 THEN COMMIT; END IF;
  END LOOP;
  COMMIT;
END;
/

--Creamos el bitmap en el tipo de documento por baja cardinalidad ya sea solo C o P
CREATE BITMAP INDEX CLI_TIPO_DOC_BMX ON CLIENTE (CLI_TIPO_DOCUMENTO) TABLESPACE I_AULA;

--Se selecciona el índice que se desea ver (PK y tipo de documento) para compararr el tipo de índice
SELECT index_name, index_type, tablespace_name FROM user_indexes
WHERE  table_name = 'CLIENTE';

--Vemos la sid actual de la sesión
SELECT SYS_CONTEXT('USERENV', 'SID') AS SID_ACTUAL FROM DUAL;

--Se hace el insert del valor
INSERT INTO CLIENTE (CLI_NUM_DOCUMENTO, EMP_CEDULA_RUC, CLI_TIPO_DOCUMENTO, CLI_NOMBRE, CLI_DIRECCION, CLI_SECTOR, CLI_TELEFONO, CLI_CORREO)
VALUES ('0000000500001', '0000000000001', 'C', 'NOMBRE_EJEMPLO', 'DIRECCION_EJEMPLO', 'SECTOR_EJEMPLO', '0000000000001', 'EJEMPLO1@GMAIL.COM');

--Se hace una segunda sesión, SE BLOQUEA
--Vemos la SID que bloquea a que SID
SELECT 'SID='||s1.sid||' BLOQUEA A SID='||s2.sid AS blocking_status
FROM v$lock l1, v$session s1, v$lock l2, v$session s2
WHERE s1.sid = l1.sid AND s2.sid = l2.sid
  AND l1.block = 1 
  AND l2.request > 0
  AND l1.id1 = l2.id1 
  AND l1.id2 = l2.id2;

--Observamos el serial de las SID de las sesiones 1 y 2
SELECT sid, serial#, username, program, status, blocking_session, event, wait_class FROM v$session WHERE  sid IN (41,304);

--Se libera la sesión bloqueada, osea la 2
ALTER SYSTEM KILL SESSION '304,2930';


--SEGUNDA PARTE CON BASE - B-TREE
select * from dba_indices
where index_name LIKE ('%NORMAL%');

CREATE INDEX NORMAL_EMPNO_IDX ON test_normal(empno);

SELECT SUBSTR(segment_name,1,30) segment_name, BYTES/1024/1024 "Tamaño en MB" FROM user_segments
WHERE segment_name IN ('TEST_NORMAL', 'NORMAL_EMPNO_IDX');
--ÍNDICES B-TREE OPCOS VALORES REPETIDOS



SELECT index_name, clustering_factor FROM user_indexes
where index_name = 'NORMAL_EMPNO_IDX';

SET AUTOTRACE ON
SELECT * FROM test_normal WHERE empno=&empno;

SELECT * FROM dba_tablespaces;

CREATE TABLE test_random(
    empno number(10),
    ename varchar2(30),
    sal number(10)
    )
    tablespace aula
/

SELECT * FROM test_normal;
SELECT * FROM test_normal ORDER BY dbms_random.value;
--Para insertar de un select
INSERT INTO test_random SELECT * FROM test_normal ORDER BY dbms_random.value;
COMMIT;

SELECT * FROM test_random;
SELECT COUNT(*) FROM test_random;
