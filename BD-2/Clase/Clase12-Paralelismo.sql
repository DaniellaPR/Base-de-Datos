--Paralelismo clase 12
--Hay 2 formas generarPago haciendo insert en app o pasando los datos a procedimineto almacenado para que haga el insert.
--se manjea transaccionalidad
--1. Validar que el pago no existe
--2. Validar el pedido tenga productos
--3. Validar que la información se ingresa por interface
--4. Calcular el monto del pedido o factura
--5. Seleccionar productos del pedido para actualizar existencia
--6. Actualizar estado de pedido como cancelado
--7. Ingresar el pago (cabecera y detalle de factura mismo de producto_pedcli)
desc pago;
desc producto_pedcli;
desc producto;
desc pedidocliente;

--PRIMER CASO
--Crear disparador:
CREATE OR REPLACE TRIGGER t_valida_integridad_pago
BEFORE INSERT ON PAGO
FOR EACH ROW
DECLARE
    v_montocalculado PAGO.pag_monto%TYPE;
BEGIN
    :NEW.pag_fecha := SYSDATE;
    pa_registra_pago(:NEW.ped_numero, v_montocalculado);
    :NEW.pag_monto := v_montocalculado;
END;
/

--Crear procedimiento almacenado:
CREATE OR REPLACE PROCEDURE p_registra_pago (v.ped_numero IN PAGOS.ped_numero%TYPE, v.pag_monto OUT PAGOS.pag_monto%TYPE)
IS v_pago_existe NUMBER;
   v_total_prd NUMBER;
   c_producto SYS_REFCURSOR; --cursor de producto
   v_codigo PRODUCTO.prd_codigo%TYPE;
   v_cantidad PRODUCTO_PEDCLI.ppc_cantidad%TYPE;
   v_existencia PRODUCTO.prd_existencia%TYPE;
   v_estado PEDIDOCLIENTE.ped_estado%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_pago_existe
    FROM pago
    WHERE ped_numero = v_ped_numero; --variable que manda el disparador
    IF v_pago_existe >0 THEN
        RAISE_application_error(-2001, 'El pago está hecho');
    END IF;
    
    SELECT COUNT(*) INTO v_total_prd
    FROM PRODUCTO_PEDCLI
    WHERE ped_numero = v_ped_numero; --variable que manda el disparador
    IF v_total_prd >0 THEN
        RAISE_application_error(-2001, 'No hay productos en el pedido');
    END IF;

  SELECT SUM(ppc.ppc_cantidad * p.prd_precio) INTO v_pag_monto
  FROM PRODUCTO_PEDCLI ppc, producto p
  WHERE ppc.prd_codigo = p.prd_codigo
  GROUP BY ppc.ped_numero
  HAVING ppc.ped_numero =v_ped_numero; --calcula el monto

  OPEN c_poducto FOR SELECT PRD_CODIGO, PPC_CANTIDAD from PRODUCTO_PEDCLI
  WHERE ped_numero = v_ped_numero; --abrir o crear cursor
    
    --hacer que funcion con lazo
    LOOP FETCH c_producto INTO v_codigo, v_cantidad;
        EXIT WHEN c_producto%NOTFOUND;
        SELECT prd_existencia INTO v_existencia
        FROM producto
        WHERE prd_codigo = v_codigo FOR UPDATE; --existencia del producto y bloqueo registro
        
        UPDATE producto SET prd_existencia= prd_existencia-v_cantidad
        WHERE prd_codigo = v_codigo;
    END LOOP;


    --actualizar estado del pedido
    SELECT ped_estado INTO v_estado FROM PEDIDOCLIENTE
    WHERE ped_numero = ped_estado FOR UPDATE;
        
    UPDATE pedidocliente SET ped_estado = 'CANCELADO'
    WHERE ped_numero =v_ped_numero;
    
    
    --Insert aplicación para oingresar el pago controlar con exeption
    EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-2001, 'Error al registrar el pago' || SQLERRM || 'Línea: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);

END pa_registra_pago;
/

--Consulta APARTE
SELECT SUM(ppc.ppc_cantidad * p.prd_precio) AS monto
FROM PRODUCTO_PEDCLI ppc, producto p
WHERE ppc.prd_codigo = p.prd_codigo
GROUP BY ppc.ped_numero
HAVING ppc.ped_numero =1;

--Se vuelve a compilar el disparador después del procedimiento.
--Luego insertar

SELECT * FROM PAGO;
DELETE FROM pago;
COMMIT;
SELECT * FROM PRODUCTO; --verificar existencias

INSERT INTO pago VALLUES('PAG001', 1, null, null);
SELECT * FROM PRODUCTO;
COMMIT; --si no da error hacer commit en  app


--Pruebas si usuario quita más de lo que existe
UPDATE producto_pedclie SET ppc_cantidad=120
WHERE prd_codigo = 'P008'
AND ped_numero=2;
COMMIT;
INSERT INTO pago VALLUES('PAG002', 2, null, null);


--SEGUNDO CASO
--Crear procedimiento:










