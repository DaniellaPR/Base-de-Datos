//usuario ya existente 
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER simulacroAd identified by lticPUCE24 DEFAULT TABLESPACE DATOS;
GRANT CONNECT, RESOURCE, DBA TO simulacroad WITH ADMIN OPTION;


CREATE USER simulacroC1 identified by lticPUCE24 DEFAULT TABLESPACE DATOS;
GRANT CONNECT, RESOURCE, DBA TO simulacroc1;


CREATE USER simulacroC2 identified by lticPUCE24 DEFAULT TABLESPACE DATOS;
GRANT CONNECT, RESOURCE, DBA TO simulacroc2;


GRANT EXECUTE ON DBMS_LOCK to simulacroad;

//Usuario administrador
select * FROM PRODUCTO;
DESC UNIDAD_MEDIDA;
INSERT INTO UNIDAD_MEDIDA VALUES('000000','UNIDAD1');
INSERT INTO UNIDAD_MEDIDA VALUES('000001','UNIDAD2');
INSERT INTO UNIDAD_MEDIDA VALUES('000002','UNIDAD3');

DESC PRODUCTO;
INSERT INTO PRODUCTO VALUES ('0000000000000','000000','0000000000000','COMIDA',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000001','000000','0000000000000','COMIDA2',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000002','000000','0000000000000','COMIDA3',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000003','000000','0000000000000','COMIDA4',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000004','000000','0000000000000','COMIDA5',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000005','000000','0000000000000','COMIDA6',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000006','000000','0000000000000','COMIDA7',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000007','000000','0000000000000','COMIDA8',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000008','000000','0000000000000','COMIDA9',10,20,15,'S',2,100);
INSERT INTO PRODUCTO VALUES ('0000000000009','000000','0000000000000','COMIDA10',10,20,15,'S',2,100);

DESC CLIENTE;
INSERT INTO CLIENTE VALUES ('0000000000000','NOMBRE1','DIRECCION1','0000000000','correo','000000');
INSERT INTO CLIENTE VALUES ('0000000000001','NOMBRE2','DIRECCION2','0000000000','correo','000000');
INSERT INTO CLIENTE VALUES ('0000000000002','NOMBRE3','DIRECCION3','0000000000','correo','000000');

DESC CARRITO;
INSERT INTO CARRITO VALUES ('0000000000000','0000000000000','12/12/12',SYSDATE);
INSERT INTO CARRITO VALUES ('0000000000001','0000000000001','12/12/12',SYSDATE);
INSERT INTO CARRITO VALUES ('0000000000002','0000000000002','12/12/12',SYSDATE);

DESC PROD_CARRITO;
INSERT INTO PROD_CARRITO VALUES('0000000000000','0000000000000',50);
INSERT INTO PROD_CARRITO VALUES('0000000000001','0000000000000',100);
INSERT INTO PROD_CARRITO VALUES('0000000000002','0000000000000',150);

INSERT INTO PROD_CARRITO VALUES('0000000000000','0000000000001',50);
INSERT INTO PROD_CARRITO VALUES('0000000000001','0000000000001',100);
INSERT INTO PROD_CARRITO VALUES('0000000000002','0000000000001',150);

INSERT INTO PROD_CARRITO VALUES('0000000000000','0000000000002',50);
INSERT INTO PROD_CARRITO VALUES('0000000000001','0000000000002',100);
INSERT INTO PROD_CARRITO VALUES('0000000000002','0000000000002',150);

SELECT * FROM  producto;

UPDATE producto SET prd_existencia= prd_existencia+100 
        WHERE prd_codigo = '0000000000000';
        
commit;



//Luego de ingresar los datos, cuidado con ejecutar la linea que añade existencias
desc carrito;
desc cliente;
desc producto;
desc prod_carrito;
desc factura;
desc detalle_factura;

//Genera el trigger que verifica que no se pase del limite minimo de existencias
CREATE OR replace trigger t_actualiza_producto
BEFORE INSERT OR UPDATE ON PRODUCTO FOR EACH ROW
BEGIN
    IF :NEW.prd_existencia<:OLD.prd_stock_min THEN
        RAISE_APPLICATION_ERROR(-20003,'Error al actualizar en productos');
    END IF;
END;
/
commit;

SELECT NVL(MAX(fac_numero),0)+1 FROM FACTURA;






//Procedimiento de generar factura  

SET SERVEROUTPUT ON;



CREATE OR REPLACE PROCEDURE p_genera_factura (    
    v_cod_carrito carrito.crr_ced_ruc_cli%type,
    v_ced_cliente cliente.cli_ci_ruc%type
    )
IS c_producto SYS_REFCURSOR; --cursor de producto
   v_codigo PRODUCTO.prd_codigo%TYPE;
   v_cantidad prod_carrito.pca_cantidad%TYPE;
   v_existencia PRODUCTO.prd_existencia%TYPE;
   v_stock_minimo PRODUCTO.prd_stock_min%type;
   v_fac_numero FACTURA.fac_numero%type;
BEGIN
    SAVEPOINT inicio_transaccion;  


  OPEN c_producto FOR SELECT PRD_CODIGO, PCA_CANTIDAD from prod_carrito
  WHERE crr_ced_ruc_cli = v_cod_carrito; 
    
    --hacer que funcion con lazo
    LOOP FETCH c_producto INTO v_codigo, v_cantidad;
        EXIT WHEN c_producto%NOTFOUND;
        
        SELECT prd_existencia INTO v_existencia
        FROM producto
        WHERE prd_codigo = v_codigo FOR UPDATE; --existencia del producto y bloqueo registro
      
        UPDATE producto SET prd_existencia= v_existencia-v_cantidad
        WHERE prd_codigo = v_codigo;
        
        DBMS_LOCK.SLEEP(40);  
    END LOOP;
    close c_producto;
    
    --Creamos el encabezado de factura
    SELECT NVL(MAX(fac_numero),0)+1 INTO v_fac_numero FROM FACTURA;
    INSERT INTO FACTURA VALUES(v_fac_numero,v_ced_cliente,SYSDATE,'V');
   
    
    --Creamos el detalle factura, detalle factura () tiene ahí los nombres de las columnas tal como se llaman, no como las llamamos en el select
    INSERT INTO DETALLE_FACTURA (fac_numero,prd_codigo,dfa_cantidad,dfa_precio_uni,dfa_costo_uni)
    SELECT v_fac_numero,pc.prd_codigo,pc.pca_cantidad,p.prd_precio_venta,pc.pca_cantidad * p.prd_precio_venta as costo
    FROM PROD_CARRITO pc
    JOIN PRODUCTO p ON p.prd_codigo=pc.prd_codigo
    WHERE pc.crr_ced_ruc_cli = v_cod_carrito;
    
    --Borramos los registros del carrito y productos del carrito--
    DELETE fROM prod_carrito WHERE crr_ced_ruc_cli=v_cod_carrito;
    DELETE fROM carrito WHERE crr_ced_ruc_cli=v_cod_carrito;
    

    --actualizar estado de la factura      
    UPDATE factura SET fac_estado = 'A'
    WHERE fac_numero =v_fac_numero;
      
    COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK TO inicio_transaccion;
        RAISE_APPLICATION_ERROR(-20001, 'Error al registrar la factura' || SQLERRM || 'Línea: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);       
        RAISE;

END p_genera_factura;

/

//Creamos roles para darle a los usuarios clientes
CREATE ROLE C##ROL_CLIENTE;
GRANT SELECT ON CLIENTE TO C##ROL_CLIENTE;
GRANT SELECT, INSERT ON FACTURA TO C##ROL_CLIENTE;
GRANT SELECT, INSERT ON DETALLE_FACTURA TO C##ROL_CLIENTE;
GRANT SELECT ON PRODUCTO TO C##ROL_CLIENTE;
GRANT SELECT, UPDATE, DELETE ON PROD_CARRITO TO C##ROL_CLIENTE;
GRANT EXECUTE ON p_genera_factura TO C##ROL_CLIENTE;

GRANT C##ROL_CLIENTE TO simulacroc1;
GRANT C##ROL_CLIENTE TO simulacroc2;



//En cliente 1
EXEC simulacroad.p_genera_factura('0000000000000', '0000000000000');


//En cliente 2
EXEC simulacroad.p_genera_factura('0000000000001', '0000000000001');

