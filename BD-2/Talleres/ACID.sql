--Taller 4.2 Pedido Cliente

---ATOMICIDAD
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER bd2 IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE TO bd2;

--CREACIÓN DE ROLES:
CREATE ROLE bodeguero;
GRANT INSERT, SELECT, UPDATE ON USERDBII.PRODUCTO TO BODEGUERO;
GRANT bodeguero TO bd2;


SELECT * FROM user_tables;
SELECT * FROM tab;

SELECT * 
FROM producto
WHERE prd_codigo = 'P001';


--Bloqueo pesimista hasta commit o rollback
SELECT * FROM producto WHERE prd_codigo = 'P001' FOR UPDATE;

SHOW USER;

--===========Ir a usuario 2===============
select * from user_tables;
--usuario bd2 hacemos 1
UPDATE usuario1.producto
SET prd_existencia = prd_existencia + 100
WHERE prd_codigo = 'P001';
--=========================================

ROLLBACK;

--============Ir a usuario 2===============
SELECT * FROM producto WHERE prd_codigo = 'P001';
--=========================================





--CONSISTENCIA
--procedimiento almacenado para actualizar la existencia
--insertar pago cuando el lcleinte recibe productos disparador.
CREATE OR REPLACE PROCEDURE actualiza_existencia(
    p_id_producto IN producto.prd_codigo%TYPE,
    p_cantidad    IN NUMBER
) IS
    v_existencia producto.prd_existencia%TYPE;
BEGIN
    SELECT prd_existencia INTO v_existencia
    FROM producto
    WHERE prd_codigo = p_id_producto FOR UPDATE;

    IF v_existencia < p_cantidad THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay existencia suficiente para el producto ' || p_id_producto);
    END IF;

    UPDATE producto SET prd_existencia = v_existencia-p_cantidad
    WHERE prd_codigo = p_id_producto;
END actualiza_existencia;
/

GRANT EXECUTE ON actualiza_existencia TO bd2;

--============user bd2=======================
--se llama al procedimiento desde el segundo usuario
--Funciónanónima en bd2 si intenta actualizar existencia
SET SERVEROUTPUT ON;
BEGIN
    userdbii.actualiza_existencia('P001', 10);
END;
/

SELECT prd_codigo, prd_existencia
FROM userdbii.producto
WHERE prd_codigo = 'P001';


--Función anónima para comprobar atomicidad
SET SERVEROUTPUT ON;
DECLARE
BEGIN
    userdbii.actualiza_existencia('P001', 10);
    userdbii.actualiza_existencia('P006', 9999);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en la factura: ' || SQLERRM);
        ROLLBACK;
END;
/

SELECT prd_codigo, prd_existencia
FROM userdbii.producto
WHERE prd_codigo IN ('P001', 'P006');
--===========================================

--Aislamiento
--revisar existencia
SELECT prd_codigo, prd_existencia
FROM producto
WHERE prd_codigo = 'P001';

--Función donde espera 40 segundos
SET SERVEROUTPUT ON;
DECLARE
    v_existencia producto.prd_existencia%TYPE;
BEGIN
    SELECT prd_existencia INTO v_existencia
    FROM producto
    WHERE prd_codigo = 'P001' FOR UPDATE;
    v_existencia := v_existencia - 10;

    UPDATE producto
    SET prd_existencia = v_existencia
    WHERE prd_codigo ='P001';
    DBMS_OUTPUT.PUT_LINE('Existencia modificada, esperando 40 segundos antes del COMMIT...');
    DBMS_LOCK.SLEEP(40); 
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('COMMIT realizado.');
END;
/

commit;


--principal disparador para que no pague pago

CREATE OR REPLACE NONEDITIONABLE TRIGGER t_valida_pago
BEFORE INSERT ON PAGO FOR EACH ROW
DECLARE
    v_existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM pago
    WHERE ped_numero = :NEW.ped_numero;
    if v_existe >0 THEN
        RAISE_APPLICATION_ERROR(-2002, 'El pedidO ya fue pagado');
    END IF;
END;
/
commit;

SELECT * FROM USER_TABLES;
desc producto;
desc pedidocliente;
desc cliente;
desc producto_pedcli;
desc pedido;
CREATE OR REPLACE PROCEDURE p_registra_pedido(
    v_ced_cliente CLIENTE.cli_ced_ruc%TYPE,
    v_pag_codigo pago.pag_codigo%TYPE,
    v_pedido_numero PEDIDOCLIENTE.ped_numero%TYPE,
    v_productos SYS_REFCURSOR,
    v_monto PAGO.pag_monto%TYPE,
    v_fecha_pago PAGO.pag_fecha%TYPE
    ) IS
        v_existencia PRODUCTO.prd_existencia%Type := 0;
        v_codigo PRODUCTO.prd_codigo%TYPE;
        v_cantidad PRODUCTO_PEDCLI.ppc_cantidad%TYPE :=0;
    BEGIN
        SAVEPOINT inicia_pedido;
        IF v_productos%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-2002, 'No hay productos en el pedido');
        END IF;
        INSERT INTO pago (pag_codigo, ped_numero, pag_monto, pag_fecha)
        VALUES(v_pag_codigo, v_pedido_numero, v_monto, v_fecha_pago);
        LOOP FETCH v_productos INTO V_CODIGO, V_CANTIDAD;
            EXIT WHEN v_productos%NOTFOUND;
            SELECT prd_existencia INTO v_eistencia FROM producto WHERE prd_codigo= v_codigo;
            UPDATE producto SET prd_existencia = prd_exitencia - v_cantidad WHERE prd_codigo = v_codigo;
        END LOOP;
    END;
    /
    
    
rollback;
CREATE OR REPLACE PROCEDURE p_registra_pedido(
    v_ced_cliente  IN cliente.cli_ced_ruc%TYPE,
    v_pag_codigo   IN pago.pag_codigo%TYPE,
    v_pedido_num   IN pedidocliente.ped_numero%TYPE,
    v_productos    IN SYS_REFCURSOR,         -- (prd_codigo, cantidad)
    v_monto        IN pago.pag_monto%TYPE,
    v_fecha_pago   IN pago.pag_fecha%TYPE
) IS
    v_existencia   producto.prd_existencia%TYPE := 0;
    v_codigo       producto.prd_codigo%TYPE;
    v_cantidad     NUMBER := 0;
    v_tiene_prod   BOOLEAN := FALSE;
BEGIN
    SAVEPOINT inicia_pedido;

    -- Insertar pago (el trigger t_valida_pago impide doble pago)
    INSERT INTO pago (pag_codigo, ped_numero, pag_monto, pag_fecha)
    VALUES (v_pag_codigo, v_pedido_num, v_monto, v_fecha_pago);

    -- Recorrer los productos del pedido
    LOOP
        FETCH v_productos INTO v_codigo, v_cantidad;
        EXIT WHEN v_productos%NOTFOUND;

        v_tiene_prod := TRUE;

        -- Leer existencia CON BLOQUEO
        SELECT prd_existencia
        INTO v_existencia
        FROM producto
        WHERE prd_codigo = v_codigo
        FOR UPDATE;

        -- Actualizar existencia
        UPDATE producto
        SET prd_existencia = v_existencia - v_cantidad
        WHERE prd_codigo = v_codigo;

        -- Insertar detalle del pedido
        INSERT INTO producto_pedcli (prd_codigo, ped_numero, ppc_cantidad)
        VALUES (v_codigo, v_pedido_num, v_cantidad);
    END LOOP;

    -- Si el cursor no tenía productos
    IF NOT v_tiene_prod THEN
        ROLLBACK TO inicia_pedido;
        RAISE_APPLICATION_ERROR(-2002, 'No hay productos en el pedido');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO inicia_pedido;
        RAISE;
END p_registra_pedido;
/


--Crear pedido
INSERT INTO pedidocliente (ped_numero, cli_ced_ruc, ped_fecha, ped_estado) VALUES (21, '0102030405001', SYSDATE, 'PENDIENTE');
COMMIT;


select * from pedidocliente
