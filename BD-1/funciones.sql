
-----Usuarios--------
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER dp IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS TEMPORARY TABLESPACE TEMP;
GRANT CONNECT, RESOURCE, DBA TO dp;
CREATE USER ibodeguero IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE DATOS TEMPORARY TABLESPACE TEMP;
GRANT CONNECT, RESOURCE, DBA TO ibodeguero;



------Roles----------------
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

desc empresa;


CREATE ROLE r_empresa;
GRANT SELECT, INSERT, UPDATE, DELETE ON facadmin.empresa TO r_empresa;

CREATE ROLE r_bodeguero;
GRANT SELECT ON facadmin.empresa TO r_bodeguero;
GRANT SELECT, INSERT, UPDATE, DELETE ON facadmin.producto TO r_bodeguero;
GRANT SELECT, INSERT, UPDATE, DELETE ON facadmin.categ_producto TO r_bodeguero;
GRANT SELECT, INSERT, UPDATE, DELETE ON facadmin.prod_bodega TO r_bodeguero;
GRANT SELECT, INSERT, UPDATE, DELETE ON facadmin.bodega TO r_bodeguero;
GRANT SELECT ON facadmin.proveedor TO r_bodeguero;


----------Vistas----------------------
--Las vistas están en memoria, se usan solo si el ingreso va a ser muy poco usado, por ejemplo para el informe de gerentes

CREATE view v_factura AS SELECT f.fac_numero, c.cli_nombre, f.fac_fecha, df.pro_codigo, p.pro_descripcion,df.dtf_cantidad,df.dtf_precio
FROM factura f, detalle_factura df, cliente c,producto p
WHERE f.fac_numero=df.fac_numero
AND f.cli_num_documento=c.cli_num_documento
AND df.pro_codigo=p.pro_codigo;



CREATE view v_OrdenCompra AS SELECT o.orc_numero,o.orc_fecha_emicion, p.prd_cedula_ruc, p.prd_nombre,p.prd_direccion,p.prd_telefono, p.prd_correo
FROM orden_compra o,proveedor p
WHERE o.prd_cedula_ruc=p.prd_cedula_ruc;



------------------Triggers--------------------
CREATE OR REPLACE TRIGGER ins_cliente
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
    datold:=:OLD.cli_num_documento||' '||:OLD.emp_cedula_ruc||' '||:OLD.cli_tipo_documento||' '||:OLD.cli_nombre||' '||:OLD.cli_direccion||' '||:OLD.cli_sector||' '||:OLD.cli_telefono||:OLD.cli_correo;
    datonew:=:NEW.cli_num_documento||' '||:NEW.emp_cedula_ruc||' '||:NEW.cli_tipo_documento||' '||:NEW.cli_nombre||' '||:NEW.cli_direccion||' '||:NEW.cli_sector||' '||:NEW.cli_telefono||:NEW.cli_correo;
    INSERT INTO auditoria VALUES (usuarioso,usuariodb,tabla,direccionip,fecha,maquina,datold,datonew);
END ins_cliente;
/

--Si un sueldo trata de ser mayor a 3000 excepto del gerente o si un sueldo es menor al mínimo dentro de la organización 
CREATE OR REPLACE TRIGGER chequea_sueldo
BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW
WHEN (NEW.emd_cargo <> 'COORDINADOR')
DECLARE 
    v_salmin INTEGER;
    v_salmax INTEGER;
BEGIN
    SELECT MIN(emd_sueldo) INTO v_salmin FROM empleado;
    v_salmax:=3000;
    IF :NEW.emd_sueldo<v_salmin OR :NEW.emd_sueldo>v_salmax THEN 
        RAISE_APPLICATION_ERROR(-20000,'sueldo fuera de rango');
    END IF;
END chequea_sueldo;
/


----------------------Procedimientos/Procedures----------------
CREATE OR REPLACE PROCEDURE consulta_sueldo (v_ci IN empleado.emd_num_documento%TYPE, v_sueldo OUT empleado.emd_sueldo%TYPE) 
AS
BEGIN
    SELECT emd_sueldo INTO v_sueldo FROM facadmin.empleado 
    WHERE emd_num_documento = v_ci;
END;
/

CREATE OR REPLACE PROCEDURE Historico_Factura(año IN NUMBER) 
--Ingresa un dato llamado año de tipo numerico
IS 
    v_total_org NUMBER; 
    v_total_des NUMBER;
    v_facnumero factura.fac_numero%TYPE;
    CURSOR c_factura IS SELECT fac_numero FROM factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
BEGIN
    SELECT COUNT(*) INTO v_total_org FROM factura   
    --Cuenta todos los registros en factura y los pone en v_total_org 
    WHERE EXTRACT(YEAR FROM factura.fac_fecha) = año; 
    --donde se cumple que el año extraido de fac_fecha sea igual a la variable año que pasaron
    INSERT INTO h_factura SELECT * FROM factura WHERE EXTRACT (YEAR FROM factura.fac_fecha)=año; --Inserta en h_factura tolo que se cumpla con la condicion SELECT * FROM....
    
    SELECT COUNT(*) INTO v_total_des FROM h_factura
    WHERE EXTRACT(YEAR FROM h_factura.fac_fecha) =año;
    
    OPEN c_factura;
    LOOP
        FETCH c_factura INTO v_facnumero;
        EXIT WHEN c_factura%NOTFOUND; --Cuando ya no encuentra datos, sale
        INSERT INTO h_detalle_factura SELECT * FROM detalle_factura WHERE detalle_factura.fac_numero=v_facnumero;
        DELETE FROM detalle_factura WHERE detalle_factura.fac_numero=v_facnumero;
    END LOOP;
    IF v_total_org=v_total_des THEN 
        DBMS_OUTPUT.PUT_LINE('SI '||v_total_org||' es igual a'||v_total_des);
 --       DELETE FROM factura WHERE EXTRACT(YEAR FROM factura.fac_fecha)=año;
        --commit;
    ELSE
        RAISE_APPLICATION_ERROR(-20004,'No se realizo la actualizacion correcta');
    END IF;   
    
    
END;
/


CREATE OR REPLACE PROCEDURE Confirmar_Cedula(cedula IN VARCHAR2, validez OUT BOOLEAN) 
--Ingresa un dato llamado cedula de tipo VARCHAR2 
IS 
    v_auxiliar VARCHAR2(13);
    v_condicion BOOLEAN;
    v_verificador INTEGER;
    v_contador INTEGER; 
    v_total INTEGER;
BEGIN
    v_verificador:=0;
    v_contador:=1;
    v_condicion:=false;
    v_total:=0;
    v_auxiliar:= SUBSTR(cedula,1,2);
    --Verificamos que pertenezca a auna de las 24 provincias
    IF v_auxiliar NOT IN ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24') THEN
            RAISE_APPLICATION_ERROR(-20001,'cedula invalida');
    END IF;
    
    --loop para sumar los 9 digitos antes del digito verificador
    FOR i IN 1 .. 9 LOOP
            IF v_contador=1 THEN
                v_contador:=2;
            ELSE v_contador:=1;
            END IF;
            v_total:= TO_NUMBER(SUBSTR(cedula,i,1))*v_contador;
            IF(v_total>=10) THEN
                v_auxiliar:=TO_CHAR(v_total);
                v_total:=TO_NUMBER(SUBSTR(v_auxiliar,1,1))+TO_NUMBER(SUBSTR(v_auxiliar,2,1));
            END IF;
            v_verificador:=v_verificador+v_total; 
    END LOOP;
    
    --truncamos y obtenemos la decena superior a nuestra suma
    v_total:=TRUNC(v_verificador/10) *10 + 10;     
    --Obtenemos el codigo verificador para esa cedula
    v_verificador:=v_total-v_verificador;
    --Si no coincide manda excepcion y la variable validez es falsa
    IF v_verificador <> TO_NUMBER(SUBSTR(cedula,10,1)) THEN
        validez:=false;
        RAISE_APPLICATION_ERROR(-20003,'digito verificador invalido');
    END IF;                
    
    --Si no se sale por las excepciones entonces estara bien y su validez será verdadera
    validez:=true;

END;
/

---------------Ejecutables-----------------------------
--Procedura consulta_sueldo
SET SERVEROUTPUT ON;
DECLARE 
    sal_emp empleado.emd_sueldo%TYPE;
    
BEGIN
    consulta_sueldo('1703000003',sal_emp);
    DBMS_OUTPUT.PUT_LINE('El salario del empleado es '||sal_emp);
END;
/
