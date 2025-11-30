--Taller 4.1.1.1 - CON bodega tarea
--En sesión 1
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER bd2 IDENTIFIED BY lticPUCE24 DEFAULT TABLESPACE AULA;
GRANT CONNECT, RESOURCE TO bd2;

CREATE ROLE bodeguero;
GRANT INSERT, SELECT, UPDATE ON USERDBII.BODEGA TO BODEGUERO;
GRANT bodeguero TO bd2;

--se ven los contraints que existen
desc user_constraints;
select * from bodega;

SELECT CONSTRAINT_NAME, SEARCH_CONDITION
FROM user_constraints
WHERE TABLE_NAME = 'BODEGA';

--ahora update a un dato de bodega y ver resultados:
UPDATE BODEGA SET BOD_DESCRIPCION= BOD_DESCRIPCION||' - Modificado USERDBII'
WHERE  BOD_CODIGO ='B001';

--ver con usuario bd2

SELECT * FROM BODEGA
WHERE BOD_CODIGO ='B001';

--para bloqueo de sesión
SET SERVEROUTPUT ON;
BEGIN
    UPDATE BODEGA SET BOD_DESCRIPCION= 'Bodega Dos - Bloqueo USERDBII'
    WHERE  BOD_CODIGO = 'B001';
    --transacción "colgada" por 40 segundos
    DBMS_LOCK.SLEEP(40);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Se modificó la bodega B001 y se hizo guardaron');
END;
/


--EN BD2:
SELECT * FROM TAB;
select * from userdbii.BODEGA;

SELECT * FROM USERDBII.BODEGA
WHERE BOD_CODIGO ='B001';


--Mientras está colgada la transacción por 40 segundos
UPDATE USERDBII.BODEGA SET BOD_DESCRIPCION ='Bodega Uno - cambio BD2'
WHERE  BOD_CODIGO='B001';

SELECT * FROM USERDBII.BODEGA
WHERE BOD_CODIGO= 'B001';

--regresar a usuario 1 y ver bloqueo, luego desbloqueat con:
commit;
