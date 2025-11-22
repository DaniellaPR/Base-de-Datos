--Base de Datos II - clase 11

select * from user_tables;
select * from tab;

--tecnica pesimista
--granularidades de bloqueo

--1. Actualizar la existencia de los productos (Factura) (Producto ped cli)
--2. Cambiar el estado del pedido (Entregado) (Pedcli)
--3. Insertamos un pago
--4 Actualizar el estado a cancelado


Select * from producto;
select * from producto where prd_codigo = 'P001' FOR UPDATE;
SHOW USER;

--otro usuario:
UPDATE USERDBII.producto SET prd_existencia =prd_existencia +100 where prd_codigo = 'P001';
select * from producto;

--EN EL user A
rollback;
--Transaccionalidad corta update, sino usar esta técnica pesimista 

select * from producto where prd_existencia > 150 FOR UPDATE;

--protocolo de bloqueo en dos fases expansión de bloqueo y contracción libera los bloqueos

--procedimiento almacenado para actualizar la existencia
--insertar pago cuando el lcleinte recibe productos disparador.
CREATE OR REPLACE PROCEDURE actualiza_existencia(v_id_producto VARCHAR, v_cantidad NUMBER)IS
BEGIN
    DECLARE 
        v_existencia NUMBER;
    BEGIN
        SELECT prd_existencia INTO V_existencia 
        FROM userdbII.producto 
        WHERE prd_codigo=v_id_prodcuto FOR UPDATE;
        v_existencia:= v_existencia-v_cantidad;
        UPDATE userdbII.producto SET prd_existencia=v_existencia
        WHERE prd_codigo=v_id_poducto;
    END;
    Commit;
    EXCEPTION
        WHEN OTHERS THEN
            rollback;
            DBMS_OUTPUT.PUT_LINE('Error al actualizar la existencia'||SQLERPM);
END actualiza_existencia;
/

//Hay que darle permisos al usuario 2 para que pueda ejecutar
        
--en el otro 
SET SERVEROUTPUT ON;
begin
    actualiza_existencia('P001', 150);
END;
/

--principal disparador para que no pague pago

CREATE OR REPLACE NONEDITIONABLE TRGIGER t_valida_pago
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

--procedimiento para registrar el pedido
CREATE OR REPLACE PROCEDURE p_regitra_pedido(
    v_ced_cliente CLIENTE..cli_ced_ruc%TYPE,
    v_pag_codigo pagos.pag_codigo&TYPE,
    v_pedido_num PEDIDOCLIENTE.ped_numero%TYPE,
    v_productos SYS_REFCURSOR,
    v_motno PAGOS.pag_monto%TYPE,
    v_fechapago PAGOS.pag_fecha%TYPE
    ) IS
        v_existencia PRODUCTO.prd_existencia&Type := 0;
        v_codigo PRODUCTO.prd_codigo&TYPE;
        v_cantidad PRODICTO_PEDCLI.ppc_cantidad%TYPE :=0;
    BEGIN
        SAVEPOINT inicia_pedido;
        IF v_productos%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-2002, 'No hay productos en el pedido');
        END IF;
        INSERT INTO pagos (pag_codigo, ped_numero, pag_monto, pag_fecha)
        VALUES(v_pag_codigo, v_pedido_numero, v_monto, v_fecha_pago);
        LOOP FETCH v_productos INTO V_CODIGO, V_CANTIDAD;
            EXIT WHEN v_productos%NOTFOUND;
            SELECT prd_existencia INTO v_eistencia FROM producto WHERE prd_codigo= v_codigo;
            UPDATE producto SER prd_Existencia = prd_exitencia - v_cantidad WHERE prd_codigo = v:codigo;
    END;
    /
    


