--Taller 4.1.2
--Actividad 1: Transaccionalidad ACID
--1. Atomicidad:
--Revisamos existencias de bodega para el producto 1 y 2
SELECT * FROM bodega_producto
WHERE bod_codigo ='B001'
AND prd_codigo IN('P0001', 'P0002');

B001	P0001	563,02
B001	P0002	994,1

--en usuario bd2 se realiza el procedimiento que da error
--se descuentan 10 unidades del producto 1 que no daría error
--se intenta descontar 100000 del segundo que da error
--si falla nada se modifica
SET SERVEROUTPUT ON;
DECLARE
  v_bodega   userdbii.bodega_producto.bod_codigo%TYPE := 'B001';
  v_prd1     userdbii.bodega_producto.prd_codigo%TYPE := 'P0001';
  v_prd2     userdbii.bodega_producto.prd_codigo%TYPE := 'P0002';
  v_cant1    NUMBER := 10;
  v_cant2    NUMBER := 100000;
  v_ex1      userdbii.bodega_producto.prb_existencia%TYPE;
  v_ex2      userdbii.bodega_producto.prb_existencia%TYPE;
BEGIN
  SELECT prb_existencia INTO v_ex1
  FROM userdbii.bodega_producto
  WHERE bod_codigo = v_bodega AND prd_codigo = v_prd1;

  SELECT prb_existencia INTO v_ex2
  FROM userdbii.bodega_producto
  WHERE bod_codigo = v_bodega AND prd_codigo = v_prd2;

  DBMS_OUTPUT.PUT_LINE('Existencia inicial '||v_prd1||': '||v_ex1);
  DBMS_OUTPUT.PUT_LINE('Existencia inicial '||v_prd2||': '||v_ex2);

  SAVEPOINT sp_inicio_factura; --gracias a este no se modifica nada si da error

  --1.Descontamos el primer producto
  UPDATE userdbii.bodega_producto
  SET prb_existencia = prb_existencia - v_cant1
  WHERE bod_codigo = v_bodega AND prd_codigo = v_prd1;

  DBMS_OUTPUT.PUT_LINE('Se descontó '||v_cant1||' unidades de '||v_prd1);

  --2.Se intenta descontar unidades pero la existencia no alcanza para el 2do producto
  IF v_ex2 < v_cant2 THEN
    RAISE_APPLICATION_ERROR(-20001, 'No hay tantos productos en '||v_prd2||' (se piden ='||v_cant2||', solo hay ='||v_ex2||')');
  END IF;

  --Si no, actualizaría el segundo producto
  UPDATE userdbii.bodega_producto SET prb_existencia =prb_existencia-v_cant2
  WHERE bod_codigo= v_bodega AND prd_codigo =v_prd2;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Factura registrada correctamente (COMMIT)');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK TO sp_inicio_factura; --si da error se hace rollback usando el punto seguro
    DBMS_OUTPUT.PUT_LINE('ERROR en la factura: '||SQLERRM);
END;
/


--volver a revisar en usuario 1:
SELECT * FROM bodega_producto
WHERE bod_codigo ='B001'
AND prd_codigo IN('P0001', 'P0002');  --dio el mismo resultado que arriba



--2. Consistencia
--constraint para que no sean negativos
ALTER TABLE bodega_producto ADD CONSTRAINT chk_existencia_no_negativa CHECK (prb_existencia>=0);

--trigger para 2 capas que validen la misma regla
CREATE OR REPLACE TRIGGER trg_valida_existencia_bp
BEFORE INSERT OR UPDATE ON bodega_producto FOR EACH ROW
BEGIN
  IF :NEW.prb_existencia < 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'La existencia no puede ser negativa en BODEGA_PRODUCTO');
  END IF;
END;


--en bd2
--probar consistencia restando número muy alto
--no hace update ni commit pq van a exception
SET SERVEROUTPUT ON;
DECLARE
  v_bodega   bodega_producto.bod_codigo%TYPE := 'B001';
  v_producto bodega_producto.prd_codigo%TYPE := 'P0003';
BEGIN
  UPDATE userdbii.bodega_producto
  SET prb_existencia = prb_existencia -999999
  WHERE bod_codigo= v_bodega
  AND prd_codigo = v_producto;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('No hace commit pq debe detectar las capas');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('ERROR detectado por constraint/trigger: '||SQLERRM);
END;
/



--en userdbII
--verificar de nuevo:
SELECT * FROM bodega_producto
WHERE bod_codigo = 'B001'
AND prd_codigo = 'P0003';





--3. Aislamiento
--se modifica el registro mientras espera 40 segundos
--mientras pasa el tiempo, verificar con conusltas de lectura y escritura en segundo usuario
SET SERVEROUTPUT ON;
DECLARE
  v_bodega   bodega_producto.bod_codigo%TYPE := 'B001';
  v_producto bodega_producto.prd_codigo%TYPE := 'P0001';
BEGIN
  UPDATE bodega_producto
  SET prb_existencia = prb_existencia-20
  WHERE bod_codigo =v_bodega
  AND prd_codigo = v_producto;

  DBMS_OUTPUT.PUT_LINE('Inician 40 segundos');
  DBMS_LOCK.SLEEP(40);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('USERDBII: COMMIT realizado, se liberan bloqueos.');
END;
/



--en bd2 o segundo usuario mientras pasan 40 segundos
--1 Lectura lee antes de commmit
SELECT prb_existencia
FROM userdbii.bodega_producto
WHERE bod_codigo = 'B001'
AND prd_codigo ='P0001';

--2. Intento de modificar registro, se queda bloqueado hasta commit despues de 40 segundos
SET SERVEROUTPUT ON;
DECLARE
  v_bodega   userdbii.bodega_producto.bod_codigo%TYPE := 'B001';
  v_producto userdbii.bodega_producto.prd_codigo%TYPE := 'P0001';
BEGIN
  UPDATE userdbii.bodega_producto
  SET prb_existencia=prb_existencia-200
  WHERE bod_codigo=v_bodega
  AND prd_codigo=v_producto;
    
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('BD2: COMMIT realizado.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('BD2: Error y ROLLBACK: '||SQLERRM);
END;
/


--se comprueban datos despues del tiempo y además ya no está bloqueado
SELECT * FROM userdbii.bodega_producto
WHERE bod_codigo = 'B001'
AND prd_codigo = 'P0001';



--4. Durabilidad
--con commit
UPDATE bodega_producto SET prb_existencia = prb_existencia + 5
WHERE bod_codigo ='B001'
AND prd_codigo ='P0004';

COMMIT;

SELECT * FROM bodega_producto
WHERE bod_codigo ='B001'
AND prd_codigo ='P0004';  --si se cayera la bdd, gracias a redo logs el cambio y guardado con commit se mantienen


--Con rollback
SELECT * FROM bodega_producto
WHERE bod_codigo = 'B001'
AND prd_codigo = 'P0004';

UPDATE bodega_producto SET prb_existencia=prb_existencia +999
WHERE bod_codigo ='B001'
AND prd_codigo ='P0004';

ROLLBACK;


