/*BDD
pgadmin para workbench
postgres para MySQL //nombre lticpsg//
nueva cadena de conexión

poner create database
/var file sysetm
lib en Linux tiene sistemas operativos tiene todas las librerías de los comandos a ejecutarse,
adentro hay un cd lb de librerías
oracle crea un usuario en el sistema
postegres y MySQL no, debe haber carpeta de pgsql y MySQL*/

/*pgha,conf
postegres sqlcom
vi= editor de seguridad, para escribir una letra escribir conjunto de caracteres. :)
configurar el swap, tamaño 3 veces la memoria ram
priorizar file system en servidor web el: /dev
/home tamaño adecuado
servieor de aplicaciones = /var base dedatos igual , pero emn app no necesitas swap
oracle variable de ambiente pesos home en oracle
en postgres, cd /home/database/.bash_profile (lo que hace es )
ls -la archivos ocultos del con .bash archivo oculto cuando el usuario se conecta y están las variables de ambiente
echo $PSG_HOME es la variable de ambiente de postgres y carpeta principal es root, el home es el root*/

/*VISTAS--------------------------------------------------------------------------
en ejecucion de un SELECT
Tabla virtual con 5 atributos, es una vista, se invoca por cada select
algunas vistas de administración
le interesa ver el resultado, su acceso a la base de datos es menos
acceso a vistas limitado por usuarios, concurrencia más eficiente, concurrencia a una estructura que está en MEMORIA
(create materialized view → para replicar un dato)*/

--Sinstaxis:
-CREATE VIEW nombre_vista AS instrucción_select;

--Instruccion ddl, no necesita commit, solo las bml, data manipulation language.

--Ejercicios:
--1) Fsctura, cliente, detalle factura, producto:
CREATE VIEW v_factura AS SELECT f.fac_numero, c.cli_nombre, f.fac_fecha, df.pro_codigo, p.pro_descripcion, df.dtf_cantidad, df.dtf_precio 
FROM factura f, detalle_factura df, cliente c, producto p
WHERE f.fac_numero = df.fac_numero
AND f.cli_num_documento = c.cli_num_documento
AND df.pro_codigo = p.pro_codigo;

Select * FROM v_factura;

--2) Vista para tomar todas las ordenes de compra con estado pendiente, sacar el numero de orden de la compra, nombre de proveedor, su direccion, telefono, fecha de la orden de compra:
CREATE VIEW v_orden AS SELECT oc.orc_numero, oc.orc_fecha_emicion, p.prd_nombre, p.prd_direccion, p.prd_telefono
FROM orden_compra oc, proveedor p
WHERE oc.prd_cedula_ruc = p.prd_cedula_ruc;
Select * FROM v_factura;

--Donde se almacenan las vistas: memoria del servidor, vista es diferente entre usuarios, por registros mas o menos
DROP VIEW v_factura; //para borrar, todas las vistas en archivo sql.
--Dar permisos para la vista, de select. El usuario quev a ajcutar debe tener permisos a las tablas involucradas.

--DISPARADORES------------------------------------------------------------------------------
--Tabla auditoria no tiene nada ni relaciones está botada, oslo poner información relacionada con el sistema
create table AUDITORIA (
	USUARIOSO	VARCHAR2(20),
	USUARIOBD	VARCHAR2(20),
	TABLA		VARCHAR2(15),
	DIRECCIONIP	VARCHAR2(30),
	FECHATRANS	VARCHAR2(40),
	MAQUINA		VARCHAR2(40),
	DATOOLD		VARCHAR2(500),
	DATONEW		VARCHAR2(500)
)
	tablespace DATOS
/
commit;

--Para concatenar || y luego si queremos un espacio |' '|

--TRIGEGR-----------------------------
CREATE OR REPLACE TRIGGER mod_empleado
AFTER UPDATE ON empleado 
FOR EACH ROW
DECLARE
    usuarioso CHAR(20);
    usuariodb CHAR(20);
    tabla CHAR(15);
    direccionip CHAR(30);
    fecha CHAR(40);
    maquina CHAR(20);
    datoold CHAR(500);
    datonew CHAR(500);
BEGIN
    SELECT SYS_CONTEXT('userenv', 'os_user') INTO usuarioso FROM dual;
    SELECT USER INTO usuariodb FROM DUAL;
    tabla:='EMPLEADO';
    SELECT SYS_CONTEXT('userenv', 'ip_address') INTO direccionip FROM dual;
    SELECT current_timestamp INTO fecha FROM dual;
    SELECT SYS_CONTEXT('userenv', 'host') INTO maquina FROM dual;
    datoold:=:OLD.emd_num_documento||' '||:OLD.suc_codigo||' '||:OLD.dep_codigo||' '||:OLD.emd_tipo_documento||' '||:OLD.emd_nombre||' '||:OLD.emd_sueldo; //Juntar todos lso atributos para variable old
    datonew:=:NEW.emd_num_documento||' '||:NEW.suc_codigo||' '||:NEW.dep_codigo||' '||:NEW.emd_tipo_documento||' '||:NEW.emd_nombre||' '||:NEW.emd_sueldo;
    INSERT INTO auditoria VALUES (usuarioso, usuariodb, tabla, direccionip, fecha, maquina, datoold, datonew);
END mod_empleado;
/

-----CON ERRORES: SI

NO SE EJECUTA SI HAGO UN INSERT, despues de hacer el update sobre la tabla empleado, recien se ejecuta el disparador.
ALTER TABLE auditoria modify fechatrans varchar2(60);

--
CREATE OR REPLACE TRIGGER mod_empleado
AFTER UPDATE ON empleado
FOR EACH ROW
DECLARE
    usuarioso       CHAR(20);
    usuariodb       CHAR(20);
    tabla           CHAR(15);
    direccionip     CHAR(30);
    fecha           CHAR(60);
    maquina         CHAR(20);
    datold          CHAR(500);
    datonew         CHAR(500);
    
BEGIN
    SELECT sys_context('userenv','os_user') INTO usuarioso FROM dual;
    SELECT USER INTO usuariodb FROM dual;
    tabla:='EMPLEADO';
    SELECT sys_context('userenv','ip_address') INTO direccionip FROM dual;
    SELECT current_timestamp INTO fecha FROM dual;
    SELECT sys_context('userenv','HOST') INTO maquina FROM dual;
    datold:=:OLD.emd_num_documento||' '||:OLD.suc_codigo||' '||:OLD.dep_codigo||' '||:OLD.emd_tipo_documento||' '||:OLD.emd_nombre||' '||:OLD.emd_sueldo;
    datonew:=:NEW.emd_num_documento||' '||:NEW.suc_codigo||' '||:NEW.dep_codigo||' '||:NEW.emd_tipo_documento||' '||:NEW.emd_nombre||' '||:NEW.emd_sueldo;
    INSERT INTO auditoria VALUES (usuarioso,usuariodb,tabla,direccionip,fecha,maquina,datold,datonew);
END mod_empleado;
/
commit;
----------------------------------------------------------------------------------------------------------------------------------
UPDATE empleado SET emp_sueldo =5000.00 WHERE emp_num_documento = '1701000001';



--Segundo----------------------------------------------
CREATE OR REPLACE TRIGGER mod_cliente
AFTER INSERT ON cliente
FOR EACH ROW
DECLARE
    usuarioso       CHAR(20);
    usuariodb       CHAR(20);
    tabla           CHAR(15);
    direccionip     CHAR(30);
    fecha           CHAR(60);
    maquina         CHAR(20);
    datold          CHAR(500);
    datonew         CHAR(500);
    
BEGIN
    SELECT sys_context('userenv','os_user') INTO usuarioso FROM dual;
    SELECT USER INTO usuariodb FROM dual;
    tabla:='CLIENTE';
    SELECT sys_context('userenv','ip_address') INTO direccionip FROM dual;
    SELECT current_timestamp INTO fecha FROM dual;
    SELECT sys_context('userenv','HOST') INTO maquina FROM dual;
    datold:=:OLD.cli_num_documento||' '||:OLD.emp_cedula_ruc||' '||:OLD.cli_nombre||' '||:OLD.cli_direccion||' '||:OLD.cli_sector||' '||:OLD.cli_telefono;
    datonew:=:NEW.cli_num_documento||' '||:NEW.emp_cedula_ruc||' '||:NEW.cli_nombre||' '||:NEW.cli_direccion||' '||:NEW.cli_sector||' '||:NEW.cli_telefono;
    INSERT INTO auditoria VALUES (usuarioso,usuariodb,tabla,direccionip,fecha,maquina,datold,datonew);
END mod_cliente;
/
commit;
UPDATE cliente SET cli_nombre ='Rosa Melano' WHERE cli_num_documento = '1709889903';
commit;
SELECT * FROM auditoria;
SELECT * FROM cliente;
---------------------------------------------------------------------
--INSERT INTO CLIENTE VALUES() no sea mayor al promedio, se valida antes de insertar before.
--raise application error
RAISE_APPLICATION_ERROR(-20000,'Elsueldo es el aceptado');
--No se registra el insert
--IF condition THEN
--	Instruccion;
--ELSIF
--	Instruccion;
--END IF


--Deber sueldo basico o maximo 3000------------------------------------

CREATE OR REPLACE TRIGGER chequea_sueldo
AFTER INSERT OR UPDATE ON empleado
FOR EACH ROW
WHEN (NEW.emd_cargo <> 'COORDINADOR')
DECLARE
    v_salmin       INTEGER;
    v_salmax       INTEGER;
BEGIN
    SELECT MIN(emd_sueldo) INTO v_salmin FROM empleado;
    v_salmax:=5000;
    IF :NEW.emd_sueldo < v_salmin OR :NEW.emd_sueldo > v_salmax THEN 
        RAISE_APPLICATION_ERROR(-20000,'Sueldo fuera de rango');
    END IF;
END chequea_sueldo;
/
commit;

--insertar registro de empleado o modificar existente:

------------CREACION DE UN PROCEDIMIENTO ALMACENADO-------------------------------
CREATE OR REPLACE PROCEDURE nombreSP (var1 IN tipo, var2 OUT tipo) --IN (es una variable de entrada) OUT (es de salida)
AS --Declarar variables usamos as begin
BEGIN
END;
/
exec nombreSP

---------Funcion anónima no tiene nombre, solo se declara esciribr con DECLARE
DECLARE
	var1	tipo
	var2	tipo
BEGIN
	EXEC nombreSP(varIN, varOUT)
END;
/


--Antes de mensaje:
SET SERVEROUTPUT ON;
--Mnesajes a consola acumulable
DBMS_OUT_PUT_LINE('mensaje'||varout);

--Ejercicio con procedure-------------------------

CREATE OR REPLACE PROCEDURE consulta_sueldo (v_ci IN empleado.emd_num_documento%TYPE, v_sueldo OUT empleado.emd_sueldo%TYPE)
AS
BEGIN
    SELECT emd_sueldo INTO v_sueldo FROM facadmin.empleado
    WHERE emd_num_documento = v_ci;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    sal_emple empleado.emd_sueldo%TYPE;
BEGIN
    consulta_sueldo('1702000002', sal_emple);
    DBMS_OUTPUT.PUT_LINE('Salario es '||sal_emple);
END;
/

SELECT emd_num_documento, emd_sueldo FROM empleado;
-------------------------------------------------

--Procedimiento almacenado que permita validar la cedula

--------------------------------------------------
--Tbala historica de la tabla facturas y SP que reciba año como parametron y tomar todas las facturas de ese año y las va a mandar a ese historico y eliminar de facturacion //cierres de año


create table H_FACTURA (
    FAC_NUMERO          NUMBER(15),
    SUC_CODIGO          VARCHAR2(8),
    CLI_NUM_DOCUMENTO   VARCHAR2(13),
    FAC_FECHA           DATE,
    FAC_MONTO           NUMBER(12,2),
    FAC_RESPONSABLE     VARCHAR2(60)
)
    TABLESPACE DATOS
/

create table H_DET_FACTURA (
    FAC_NUMERO          NUMBER(20),
    PRO_CODIGO          VARCHAR2(20),
    DTF_CANTIDAD        NUMBER(12, 2),
    DTF_PRECIO          NUMBER(15,2),
    DTF_UNI_MEDIDA      VARCHAR2(3)
)
    TABLESPACE DATOS
/


--Insertar egistros a cada tabla:

vistas solo par la {
select para la creacion de la vista
informes gerenciales más común. Saturan el servidor. en que proceso y cuantos lo ejecutan.
sistema OLTP (Procesamiento de transacciones en línea)


PROCEDIMIENTOS ALMACENADS. Ejecucion del paso del historico, funciones, cursores.
pasar factura al histórico de factura.
Dif entre históricos y la tabla normal → no hay integridad referencial.


------------------------------------------------------CURSOR------------------------------------
create OR REPLACE PROCEDURE Historico_Factura(año IN NUMBER)
IS
    v_total_org NUMBER;
    v_total_des Number;
    v_facnumero factura.fac_numero%TYPE;
    CURSOR c_factura IS SELECT fac_numero FROM factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
BEGIN
    SELECT COUNT(*) INTO v_total_org FROM factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
    INSERT INTO h_factura SELECT * FROM factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
    SELECT COUNT(*) INTO v_total_des FROM h_factura WHERE EXTRACT(YEAR FROM h_factura.fac_fecha)=año;
    OPEN c_factura;
    LOOP
        FETCH c_factura INTO v_facnumero;
        EXIT WHEN c_factura%NOTFOUND;
        INSERT INTO h_det_factura SELECT * FROM detalle_factura WHERE detalle_factura.fac_numero= v_facnumero;
        --DELETE FROM detalle_factura WHERE detalle_fac_numero= v_facnumero;
    END LOOP;
    IF v_total_org = v_total_des THEN
            DBMS_OUTPUT.PUT_LINE('SI '|| v_total_org||'es igual a '||v_total_des);
        --DELETE FROM factura  WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
        --COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'No se realizó la actualización correcta');
    END IF;
END;
/

--SET_SERVER_OUTPUT ON;
--EXEC HISTORICO_FACTURA(2024);
--SELECT * FROM h_factura;     //ese es un cursor implícito porque me despliega en pantalla el contenido, el otro tipo es explícito porque no presenta en pantalla la informacion, se queda en memoria}
--CURSOR nombre_cursor IS INSTRUCTION_SELECT
--FETCH nombre_cursos INTO variable; //todo lo del primer registro te lo pone en variables
--Cuantas vbariables se consideran por registro: necesita 6 variables porque son 6 atributos seleccionados
--SECLECT fac_numero from factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=2024;

-----------------------------------------------------------------------------------------------
PROCEDIMIENTO ALMACENADO PARA COMISIONES
-----------------------------------------------------------------------------------------------

--Trigger after inserciones declarar rentas internas, insertar dev after generar nota de crédito, en otros países devuelven el dinero

CRATE OR REPLACE FUNTION nombre_funcion (v_variable IN TIPO_DATO)
RETURN TIPO_DATO_RETORNA [NUMBER] [BOOL] [CHAR]
IS
    v_variable1 TIPO_DATO;
    v_variable2 TIPO_DATO;
    ...
BEGIN
    process...
END;
/

--Función normal es esta, función anónima para llamar a la función
CREATE OR REPLACE FUNCTION valida_par (num1 IN NUMBER)
RETURN BOOLEAN
IS
    v_saldo NUMBER;
BEGIN
    v_saldo:=MOD(num1,2); --RESIDUO
    IF (v_saldo=0) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/
---Esto si va en sqldeveloper:
--Se almacena en la base ded atos. funcionnormales no aninonimas, triggers y procediimientos structurados

--Investigar swap
--uwu:Pasos para subir el script completo con registr y triggers y procedimientos y funciones:
1. tablespaces crear 2
2. usuario primero: alter de arriba, luego alter session, luego crear user de arribs, ultimos create y grsnt
3. abrir con el usuario:
4. script 2 veces
5. Datos
6. Triggers
7. Procedimientos
8. Funciones
--uwu

--Funcion an´´onima:
CREATE OR REPLACE FUNCTION valida_par (num1 IN NUMBER)
RETURN BOOLEAN
IS
    v_saldo NUMBER;
BEGIN
    v_saldo:=MOD(num1,2); --RESIDUO
    IF (v_saldo=0) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

---------Ejercicio------------
SET SERVEROUTPUT ON TRUE;
DECLARE
    num NUMBER:=8;
BEGIN
    IF valida_par(num) THEN
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' es par.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' no es par.');
    END IF;
END;
/
-------oto
SET SERVEROUTPUT ON TRUE;
DECLARE
    num NUMBER:=8;
BEGIN
    num:=&dato;
    IF valida_par(num) THEN
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' es par.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' no es par.');
    END IF;
END;
/
---------------------------------

SET SERVEROUTPUT ON TRUE;
CREATE OR REPLACE FUNCTION llama_par
RETURN BOOLEAN
IS
    num NUMBER:=9;
BEGIN
    IF valida_par(num) THEN
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' es par.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El numero '||num||' no es par.');
    END IF;
END;
/
---------------------------------------

--FUNCIONES PARA VALIDAR CÉDULA:
--1-------VALIDA LARGO DE CEDULA 10 NUM---------------------------------
CREATE OR REPLACE FUNCTION f_valida_long(v_cedula IN VARCHAR2)
RETURN BOOLEAN
IS

BEGIN
    IF LENGTH(v_cedula)=10 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/
--2-----------VALIDA LA PROVINCIA----------------------------
CREATE OR REPLACE FUNCTION f_valida_prov (v_cedula IN VARCHAR2)
RETURN BOOLEAN
IS

BEGIN
    IF TO_NUMBER(SUBSTR(v_cedula,1,2)) BETWEEN 1 AND 24 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/
--3---------VALIDA DIGITO 3RO----------------------------
CREATE OR REPLACE FUNCTION f_valida_dig3 (v_cedula IN VARCHAR2)
RETURN BOOLEAN
IS

BEGIN
    IF TO_NUMBER(SUBSTR(v_cedula,3,1)) BETWEEN 0 AND 5 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/
--4----VERIFICAR DIGITO----------------------------------
CREATE OR REPLACE FUNCTION f_valida_digito (v_cedula IN VARCHAR2)
RETURN NUMBER
IS
    v_total NUMBER;
    v_bandera NUMBER;
    v_valor NUMBER;
BEGIN
    FOR i in 1..9 LOOP
        if V_BANDERA =0 THEN
            v_valor:=TO_NUMBER(SUBSTR(v_cedula,i,1))*2;
            IF v_valor >9 THEN
                v_total:= TO_NUMBER(SUBSTR(TO_CHAR(v_valor),1,1))+TO_NUMBER(SUBSTR(TO_CHAR(v_valor),1,1));
            ELSE
                v_total:=v_total+v_valor;
            END IF;
            v_bandera:=1;
        ELSE
            v_total:=v_total+TO_NUMBER(SUBSTR(v_cedula,i,1));
            v_bandera:=0;
        END IF;
    END LOOP;
    RETURN v_valor;
END;
/
--5----------VALIDAR CEDULA----------------------------------------
CREATE OR REPLACE FUNCTION f_valida_cedula (v_cedula IN VARCHAR2)
RETURN VARCHAR2
IS
    v_suma Number;
    v_digver NUMBER;
BEGIN
    IF NOT (f_valida_long(v_cedula)) THEN
        RETURN 'No vale, no tiene 10 numeros';
    ELSE
        IF NOT (f_valida_prov(v_cedula)) THEN
            RETURN 'No vale, PROVINCIA NO VALIDA';
        ELSE
            IF NOT (f_valida_dig3(v_cedula)) THEN
                RETURN 'No vale, no está en rango el 3er digito';
            ELSE
            v_suma:=f_valida_digito(v_cedula);
                v_digver:=((TO_NUMBER(SUBSTR(TO_CHAR(v_suma),1,1))+1)*10);
                IF v_digver = TO_NUMBER(SUBSTR(TO_CHAR(v_cedula,10,1))) THEN
                    RETURN 'No vale, mentira, si vale';
                ELSE
                    RETURN 'No vale, digito verificador';
                END IF;
            END IF;
        END IF;
    END IF;
END;
/
-------------------------------------------------------------------------
SET SERVEROUTPUT ON TRUE;
DECLARE
DEGIN
	DBMS_OUTPUT.OUT_LINE(f_valida_cedula(1350519375));
END;
/
--------------------------------------------------------------------------











