--4.1.3 Concurrencia
--En MySQL y PostgreSQL

--MySQL:

--==Actualización Persdida===============--
--En usuario 1
SET autocommit=0;START TRANSACTION;
SELECT cli_nombre FROM cliente WHERE cli_ced_ruc='0102030405001';
UPDATE cliente SET cli_nombre='Juan Perez A' WHERE cli_ced_ruc='0102030405001';
--NO se hace COMMIT

--En suaurio 2
SET autocommit=0;START TRANSACTION;
UPDATE cliente SET cli_nombre='Juan Perez B' WHERE cli_ced_ruc='0102030405001'; --espera

--En 1
COMMIT;

--EN 2
COMMIT;
SELECT cli_nombre FROM cliente WHERE cli_ced_ruc='0102030405001';


--====Lectura dsucia==============--
--Sesión usuario1
SET autocommit=0;START TRANSACTION;
UPDATE producto SET prd_existencia=prd_existencia-1 WHERE prd_codigo='P001';
--NO COMMIT

--Sesión usuario2
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
SELECT prd_existencia FROM producto WHERE prd_codigo='P001'; --puede ver sucio
COMMIT;

--Sesión usuario1
ROLLBACK;


--============Kectura no repetible==========----
--Sesión usuario1
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET autocommit=0;START TRANSACTION;
SELECT prd_existencia FROM producto WHERE prd_codigo='P001';

--Sesión usuario2
SET autocommit=0;START TRANSACTION;
UPDATE producto SET prd_existencia=prd_existencia-2 WHERE prd_codigo='P001';
COMMIT;

--Sesión usuario1
SELECT prd_existencia FROM producto WHERE prd_codigo='P001'; --puede cambiar
COMMIT;


--====Tecnica pesimista-bloqueos-----------
--===========LOCKS(MYSQL):1REGISTRO===========
SET autocommit=0;START TRANSACTION;
SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo='P001' FOR UPDATE;
--mantener abierto para ver bloqueo en otra sesión

--===========LOCKS(MYSQL):MULTIPLES===========
SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo IN('P001','P006') FOR UPDATE;


--===========TRIGGER(MYSQL):EVITAR_DOBLE_PAGO===========
--Dra permisos desde root:
SET GLOBAL log_bin_trust_function_creators = 1;

--Ahora si ejecutar:
DELIMITER $$

DROP TRIGGER IF EXISTS t_valida_pago $$
CREATE TRIGGER t_valida_pago
BEFORE INSERT ON pago
FOR EACH ROW
BEGIN
IF EXISTS(SELECT 1 FROM pago WHERE ped_numero=NEW.ped_numero) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El pedido ya fue pagado';
END IF;
END $$

DELIMITER ;

--===========2PL(MYSQL):SP_REGISTRA_PEDIDO=========== NO USAR ESTE, PROBLEMAS CON MENSAJES:
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_registra_pedido $$
CREATE PROCEDURE sp_registra_pedido(
p_ped_num INT,
p_pag_cod VARCHAR(10),
p_monto DECIMAL(10,2)
)
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE v_prd VARCHAR(10);
DECLARE v_cant DECIMAL(10,2);
DECLARE v_exist DECIMAL(10,2);

DECLARE cur CURSOR FOR
SELECT prd_codigo,ppc_cantidad FROM producto_pedcli WHERE ped_numero=p_ped_num;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
SAVEPOINT sp_ini;

--fase1(expansion):bloquea y valida todo
INSERT INTO pago(pag_codigo,ped_numero,pag_monto,pag_fecha)
VALUES(p_pag_cod,p_ped_num,p_monto,CURDATE());

OPEN cur;
read_loop:LOOP
FETCH cur INTO v_prd,v_cant;
IF done=1 THEN LEAVE read_loop; END IF;

SELECT prd_existencia INTO v_exist
FROM producto
WHERE prd_codigo=v_prd
FOR UPDATE;

IF v_exist<v_cant THEN
ROLLBACK TO sp_ini;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=CONCAT('Sin stock:',v_prd);
END IF;
END LOOP;
CLOSE cur;

--fase2(contraccion):aplica cambios y libera al final
SET done=0;
OPEN cur;
apply_loop:LOOP
FETCH cur INTO v_prd,v_cant;
IF done=1 THEN LEAVE apply_loop; END IF;

UPDATE producto SET prd_existencia=prd_existencia-v_cant WHERE prd_codigo=v_prd;
END LOOP;
CLOSE cur;

UPDATE pedidocliente SET ped_estado='PAGADO' WHERE ped_numero=p_ped_num;
COMMIT;
END $$

DELIMITER ;

----------------------------------------------------------------------------ESTE TAMPOCO
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_registra_pedido $$
CREATE PROCEDURE sp_registra_pedido(
  IN p_ped_num INT,
  IN p_pag_cod VARCHAR(10),
  IN p_monto   DECIMAL(10,2)
)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_prd VARCHAR(10);
  DECLARE v_cant DECIMAL(10,2);
  DECLARE v_exist DECIMAL(10,2);

  -- Cursor con los productos del pedido
  DECLARE cur CURSOR FOR
    SELECT prd_codigo, ppc_cantidad
    FROM producto_pedcli
    WHERE ped_numero = p_ped_num;

  -- Handler fin de cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

  -- Handler de error: rollback total
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;
  SAVEPOINT sp_ini;

  -------------------------------------------------
  -- FASE 1: expansión (bloquea y valida)
  -------------------------------------------------

  INSERT INTO pago(pag_codigo, ped_numero, pag_monto, pag_fecha)
  VALUES (p_pag_cod, p_ped_num, p_monto, CURDATE());

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;

    SELECT prd_existencia
    INTO v_exist
    FROM producto
    WHERE prd_codigo = v_prd
    FOR UPDATE;

    IF v_exist < v_cant THEN
      ROLLBACK TO sp_ini;
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Sin stock suficiente: ', v_prd);
    END IF;
  END LOOP;
  CLOSE cur;

  -------------------------------------------------
  -- FASE 2: contracción (aplica cambios)
  -------------------------------------------------

  SET done = 0;
  OPEN cur;
  apply_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE apply_loop;
    END IF;

    UPDATE producto
    SET prd_existencia = prd_existencia - v_cant
    WHERE prd_codigo = v_prd;
  END LOOP;
  CLOSE cur;

  UPDATE pedidocliente
  SET ped_estado = 'PAGADO'
  WHERE ped_numero = p_ped_num;

  COMMIT;
END $$

DELIMITER ;
---------------------------------------------------------------------------------------------------QUIZAS ESTE
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_registra_pedido $$
CREATE PROCEDURE sp_registra_pedido(
  IN p_ped_num INT,
  IN p_pag_cod VARCHAR(10),
  IN p_monto   DECIMAL(10,2)
)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_prd VARCHAR(10);
  DECLARE v_cant DECIMAL(10,2);
  DECLARE v_exist DECIMAL(10,2);

  DECLARE cur CURSOR FOR
    SELECT prd_codigo, ppc_cantidad
    FROM producto_pedcli
    WHERE ped_numero = p_ped_num;

  DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;
  SAVEPOINT sp_ini;

  -- FASE 1: expansión (bloqueo + validación)
  INSERT INTO pago(pag_codigo, ped_numero, pag_monto, pag_fecha)
  VALUES (p_pag_cod, p_ped_num, p_monto, CURDATE());

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;

    SELECT prd_existencia
    INTO v_exist
    FROM producto
    WHERE prd_codigo = v_prd
    FOR UPDATE;

    IF v_exist < v_cant THEN
      ROLLBACK TO sp_ini;
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sin stock suficiente para el pedido';
    END IF;
  END LOOP;
  CLOSE cur;

  -- FASE 2: contracción (aplica cambios)
  SET done = 0;
  OPEN cur;
  apply_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE apply_loop;
    END IF;

    UPDATE producto
    SET prd_existencia = prd_existencia - v_cant
    WHERE prd_codigo = v_prd;
  END LOOP;
  CLOSE cur;

  UPDATE pedidocliente
  SET ped_estado = 'PAGADO'
  WHERE ped_numero = p_ped_num;

  COMMIT;
END $$

DELIMITER ;

------------------------------------------------------------------------------------------


------para probwrlo
--crear detalle del pedido 21
INSERT INTO producto_pedcli VALUES('P001',21,10),('P006',21,1);

--ok
CALL sp_registra_pedido(21,'PAG021',20.00);

--repetir pago(debe fallar por trigger/unique)
CALL sp_registra_pedido(21,'PAGXXX',20.00);


--------------------------------------------------------------------------------------ESTE SI YA, ANTERIOR NO VALIDA QUE YA SE HAYA PAGADO
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_registra_pedido $$
CREATE PROCEDURE sp_registra_pedido(
  IN p_ped_num INT,
  IN p_pag_cod VARCHAR(10),
  IN p_monto   DECIMAL(10,2)
)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_prd VARCHAR(10);
  DECLARE v_cant DECIMAL(10,2);
  DECLARE v_exist DECIMAL(10,2);

  DECLARE cur CURSOR FOR
    SELECT prd_codigo, ppc_cantidad
    FROM producto_pedcli
    WHERE ped_numero = p_ped_num;

  DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;

  -------------------------------------------------
  -- FASE 1: expansión (solo bloquea y valida)
  -------------------------------------------------

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;

    SELECT prd_existencia
    INTO v_exist
    FROM producto
    WHERE prd_codigo = v_prd
    FOR UPDATE;

    IF v_exist < v_cant THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sin stock suficiente para el pedido';
    END IF;
  END LOOP;
  CLOSE cur;

  -------------------------------------------------
  -- FASE 2: contracción (aplica cambios)
  -------------------------------------------------

  SET done = 0;
  OPEN cur;
  apply_loop: LOOP
    FETCH cur INTO v_prd, v_cant;
    IF done = 1 THEN
      LEAVE apply_loop;
    END IF;

    UPDATE producto
    SET prd_existencia = prd_existencia - v_cant
    WHERE prd_codigo = v_prd;
  END LOOP;
  CLOSE cur;

  -- Inserta el pago SOLO si todo fue válido
  INSERT INTO pago(pag_codigo, ped_numero, pag_monto, pag_fecha)
  VALUES (p_pag_cod, p_ped_num, p_monto, CURDATE());

  UPDATE pedidocliente
  SET ped_estado = 'PAGADO'
  WHERE ped_numero = p_ped_num;

  COMMIT;
END $$

DELIMITER ;

------------------------------------------------------------------------------------------------


COMPROBACION:
SELECT * FROM pago WHERE ped_numero = 12; -- verifica si tiene pago con filas
SELECT p.ped_numero
FROM pedidocliente p
LEFT JOIN pago g ON g.ped_numero = p.ped_numero
WHERE g.ped_numero IS NULL; -- da uno que no haya pagado

CALL sp_registra_pedido(18, 'PAG500', 50.00);
CALL sp_registra_pedido(11, 'PAG300', 50.00);
CALL sp_registra_pedido(1, 'PAG301', 50.00); -- debería dar erroq pq ya fue pagado
CALL sp_registra_pedido(12, 'PAG400', 99999); -- aunque sea monto grande,e so no se valida







--En PostgreSQL

--===========LOCKS(POSTGRES):1REGISTRO===========
BEGIN;
SET search_path TO taller;
SELECT * FROM producto WHERE prd_codigo='P001' FOR UPDATE;
--dejar abierto y probar update en otra sesión

--===========LOCKS(POSTGRES):MULTIPLES===========
SELECT * FROM producto WHERE prd_codigo IN('P001','P006') FOR UPDATE;


--===========TRIGGER(POSTGRES):EVITAR_DOBLE_PAGO===========
CREATE OR REPLACE FUNCTION taller.f_valida_pago()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
IF EXISTS(SELECT 1 FROM taller.pago WHERE ped_numero=NEW.ped_numero) THEN
RAISE EXCEPTION 'El pedido ya fue pagado';
END IF;
RETURN NEW;
END $$;

DROP TRIGGER IF EXISTS t_valida_pago ON taller.pago;
CREATE TRIGGER t_valida_pago
BEFORE INSERT ON taller.pago
FOR EACH ROW
EXECUTE FUNCTION taller.f_valida_pago();


--===========2PL(POSTGRES):PROCEDURE===========
CREATE OR REPLACE PROCEDURE taller.p_registra_pedido(
p_ped_num INTEGER,
p_pag_cod VARCHAR,
p_monto NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE r RECORD;
v_exist NUMERIC;
BEGIN
--fase1(expansion):adquirir locks
INSERT INTO taller.pago(pag_codigo,ped_numero,pag_monto,pag_fecha)
VALUES(p_pag_cod,p_ped_num,p_monto,CURRENT_DATE);

FOR r IN
SELECT prd_codigo,ppc_cantidad FROM taller.producto_pedcli WHERE ped_numero=p_ped_num
LOOP
SELECT prd_existencia INTO v_exist
FROM taller.producto
WHERE prd_codigo=r.prd_codigo
FOR UPDATE;

IF v_exist<r.ppc_cantidad THEN
RAISE EXCEPTION 'Sin stock:%',r.prd_codigo;
END IF;
END LOOP;

--fase2(contraccion):aplicar cambios
FOR r IN
SELECT prd_codigo,ppc_cantidad FROM taller.producto_pedcli WHERE ped_numero=p_ped_num
LOOP
UPDATE taller.producto
SET prd_existencia=prd_existencia-r.ppc_cantidad
WHERE prd_codigo=r.prd_codigo;
END LOOP;

UPDATE taller.pedidocliente SET ped_estado='PAGADO' WHERE ped_numero=p_ped_num;
END $$;

GRANT EXECUTE ON PROCEDURE taller.p_registra_pedido(INTEGER,VARCHAR,NUMERIC) TO usuario2;



--PRUEBAS
INSERT INTO taller.producto_pedcli VALUES('P001',21,10),('P006',21,1);

BEGIN;
CALL taller.p_registra_pedido(21,'PAG021',20.00);
COMMIT;

--doble pago(debe fallar)
BEGIN;
CALL taller.p_registra_pedido(21,'PAGXXX',20.00);
ROLLBACK;






-- Cambio de trigger?
CREATE OR REPLACE FUNCTION taller.f_valida_pago()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
IF EXISTS (
  SELECT 1
  FROM taller.pago
  WHERE ped_numero = NEW.ped_numero
    AND id_pago <> NEW.id_pago
) THEN
  RAISE EXCEPTION 'El pedido ya fue pagado';
END IF;
RETURN NEW;
END $$;

CREATE CONSTRAINT TRIGGER t_valida_pago
AFTER INSERT ON taller.pago
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION taller.f_valida_pago();

DELETE FROM taller.pago WHERE ped_numero = 21;

UPDATE taller.pedidocliente
SET ped_estado = 'PENDIENTE'
WHERE ped_numero = 21;


commit;


-- Prueba para trigger:
BEGIN;
INSERT INTO taller.pago(pag_codigo, ped_numero, pag_monto, pag_fecha)
VALUES ('PAG021', 11, 20.00, CURRENT_DATE);
COMMIT; -- Con 11 debería dar error pq solo hay 10 en pedidocliente, con menos de 10 correcto

select * from pedidocliente;





--Nuevo procedimiento que si sirve:
DROP PROCEDURE IF EXISTS taller.p_registra_pedido;
CREATE PROCEDURE taller.p_registra_pedido(
  p_ped_num INTEGER,
  p_pag_cod TEXT,
  p_monto   NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
  r RECORD;
  v_exist NUMERIC;
BEGIN
  -- fase 1: expansión (locks y validaciones)
  INSERT INTO taller.pago(pag_codigo, ped_numero, pag_monto, pag_fecha)
  VALUES (p_pag_cod, p_ped_num, p_monto, CURRENT_DATE);

  FOR r IN
    SELECT prd_codigo, ppc_cantidad
    FROM taller.producto_pedcli
    WHERE ped_numero = p_ped_num
  LOOP
    SELECT prd_existencia
    INTO v_exist
    FROM taller.producto
    WHERE prd_codigo = r.prd_codigo
    FOR UPDATE;

    IF v_exist < r.ppc_cantidad THEN
      RAISE EXCEPTION 'Sin stock para el producto %', r.prd_codigo;
    END IF;
  END LOOP;

  -- fase 2: contracción (aplicar cambios)
  FOR r IN
    SELECT prd_codigo, ppc_cantidad
    FROM taller.producto_pedcli
    WHERE ped_numero = p_ped_num
  LOOP
    UPDATE taller.producto
    SET prd_existencia = prd_existencia - r.ppc_cantidad
    WHERE prd_codigo = r.prd_codigo;
  END LOOP;

  UPDATE taller.pedidocliente
  SET ped_estado = 'PAGADO'
  WHERE ped_numero = p_ped_num;
END;
$$;

--Verificar que existe:
SELECT
  p.proname,
  p.prokind,
  pg_get_function_identity_arguments(p.oid)
FROM pg_proc p
JOIN pg_namespace n ON n.oid = p.pronamespace
WHERE n.nspname = 'taller'
  AND p.proname = 'p_registra_pedido';
--Prueba de procedimiento:

COMMIT;

CALL taller.p_registra_pedido(22, 'PAG022', 20.00);
commit;
CALL taller.p_registra_pedido(21, 'PAG000', 20.00);





---





