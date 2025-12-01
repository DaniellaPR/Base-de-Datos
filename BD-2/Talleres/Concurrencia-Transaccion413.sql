--TALLER 4.1.3
--Concurrencia y transaccionalidad

--PRIMERA FORMA - INSERTANDO EN LA APP
--Crear trigger que valide la facturación en el pago:
CREATE OR REPLACE TRIGGER T_VALIDA_FACTURACION_PAGO
BEFORE INSERT ON PAGO
FOR EACH ROW
DECLARE
    v_monto_calculado PAGO.PAG_MONTO%TYPE;
BEGIN
    :NEW.PAG_FECHA := SYSDATE;
    P_FACTURAR_CARRITO_2PL( P_PED_NUMERO => :NEW.PED_NUMERO, P_PAG_MONTO  => v_monto_calculado);
    :NEW.PAG_MONTO := v_monto_calculado;
END;
/


--Crear procedimiento almacenado
CREATE OR REPLACE PROCEDURE P_FACTURAR_CARRITO_2PL (
        P_PED_NUMERO IN PAGO.PED_NUMERO%TYPE,
        P_PAG_MONTO OUT PAGO.PAG_MONTO%TYPE --lo retorna como out al total
    ) IS
        v_pago_existe NUMBER;
        v_total_productos NUMBER;
        v_estado PEDIDOCLIENTE.PED_ESTADO%TYPE;
    BEGIN
        SELECT PED_ESTADO INTO v_estado  --valida
        FROM PEDIDOCLIENTE
        WHERE PED_NUMERO = P_PED_NUMERO
        FOR UPDATE;  --bloqueo hasta commit, osea en 2 fases
    
        IF v_estado <> 'PENDIENTE' THEN --debe estar en pendiente
            RAISE_APPLICATION_ERROR(-20001, 'El pedido no está en estado PENDIENTE.');
        END IF;
    
        SELECT COUNT(*) INTO v_pago_existe --no debe estar pagado
        FROM PAGO
        WHERE PED_NUMERO = P_PED_NUMERO;
        
        IF v_pago_existe > 0 THEN 
            RAISE_APPLICATION_ERROR(-20002, 'El pedido ya tiene un pago registrado.');
        END IF;
    
        SELECT COUNT(*) --debe tener productos
        INTO v_total_productos
        FROM PRODUCTO_PEDCLI
        WHERE PED_NUMERO = P_PED_NUMERO;
    
        IF v_total_productos = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El pedido no tiene productos en el carrito.');
        END IF;
    
        SELECT SUM(ppc.PPC_CANTIDAD * p.PRD_PRECIO)  --calcula el monto
        INTO P_PAG_MONTO
        FROM PRODUCTO_PEDCLI ppc
        JOIN PRODUCTO p ON ppc.PRD_CODIGO = p.PRD_CODIGO
        WHERE ppc.PED_NUMERO = P_PED_NUMERO;
    
        --FASE DE EXPANSIÓN:
        FOR r IN (SELECT p.PRD_CODIGO, p.PRD_EXISTENCIA, ppc.PPC_CANTIDAD
                  FROM PRODUCTO_PEDCLI ppc
                  JOIN PRODUCTO p ON ppc.PRD_CODIGO = p.PRD_CODIGO
                  WHERE  ppc.PED_NUMERO = P_PED_NUMERO FOR UPDATE OF p.PRD_EXISTENCIA) 
        LOOP
            
            IF r.PRD_EXISTENCIA < r.PPC_CANTIDAD THEN --valida stock
                RAISE_APPLICATION_ERROR(-20004, 'El producto no tiene stock'||r.PRD_CODIGO);
            END IF;
    
            UPDATE PRODUCTO SET PRD_EXISTENCIA = PRD_EXISTENCIA - r.PPC_CANTIDAD  --actualiza existencia
            WHERE  PRD_CODIGO = r.PRD_CODIGO;
        END LOOP;
    
        --FASE DE CONTRACCIÓN - como los datos maneja app no hay insert
        --APP hace commit para liberar:
        UPDATE PEDIDOCLIENTE SET PED_ESTADO = 'CANCELADO' --actualiza el estado de pedido
        WHERE PED_NUMERO = P_PED_NUMERO;
    --controlar con exeption:
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error en P_FACTURAR_CARRITO_2PL: ' || SQLERRM);
END P_FACTURAR_CARRITO_2PL;
/


desc pago;


--SEGUNDA FORMA
--Crear procedimiento - aquí se insertan los datos dentro del procedimiento
CREATE OR REPLACE PROCEDURE P_REGISTRA_PAGO_2PL ( P_PAG_CODIGO IN PAGO.PAG_CODIGO%TYPE, P_PED_NUMERO IN PAGO.PED_NUMERO%TYPE)
    IS
        v_monto_calculado PAGO.PAG_MONTO%TYPE;
    BEGIN
        SAVEPOINT inicio_transaccion;
        P_FACTURAR_CARRITO_2PL(P_PED_NUMERO => P_PED_NUMERO, P_PAG_MONTO  => v_monto_calculado); --llama al procedimiento anterior
    
        --inserta el pago ya con el monto calculado
        INSERT INTO PAGO VALUES (P_PAG_CODIGO, P_PED_NUMERO, v_monto_calculado, SYSDATE);
    
        --Fase de contracción: se libera con commit dentro del procedimiento
        COMMIT;
    --Maneja la excepción
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO inicio_transaccion;
            RAISE_APPLICATION_ERROR(-20007, 'Error en P_REGISTRA_PAGO_2PL: ' || SQLERRM);
END P_REGISTRA_PAGO_2PL;
/

SELECT * FROM PEDIDOCLIENTE ORDER BY ped_numero;
SELECT * FROM PRODUCTO_PEDCLI ORDER BY ped_numero, prd_codigo;
SELECT * FROM PRODUCTO ORDER BY prd_codigo;
SELECT * FROM PAGO ORDER BY pag_codigo;

DELETE FROM PAGO WHERE ped_numero = 1;
commit;

--Prueba forma 1:
INSERT INTO PAGO VALUES ('PAG100', 1, NULL, NULL);
COMMIT;

--verificamos
SELECT * FROM PAGO WHERE pag_codigo ='PAG100';
SELECT * FROM PEDIDOCLIENTE WHERE ped_numero =1;
SELECT * FROM PRODUCTO WHERE prd_codigo IN (SELECT prd_codigo FROM PRODUCTO_PEDCLI WHERE ped_numero=1);

--Prueba forma 2
BEGIN
    P_REGISTRA_PAGO_2PL('PAG200', 1);
END;
/
