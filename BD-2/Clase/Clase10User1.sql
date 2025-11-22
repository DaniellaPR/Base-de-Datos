--Usuario 1 (userdbii)
desc user_constraints;

--Revisa los constrains que existan
SELECT CONSTRAINT_NAME, SEARCH_CONDITION
FROM user_constraints
WHERE TABLE_NAME = 'PRODUCTO'
AND CONSTRAINT_TYPE = 'C';

--Añadimos un constraint para no permitir que las existencias sean menres a 0 
ALTER TABLE producto ADD CONSTRAINT chk_existencia_positiva CHECK (prd_existencia >=0);
--Luego de hacer el constraint vamos a bd2

SELECT * FROM producto;


SET SERVEROUTPUT ON;

--este proceso se ejecuta primero y se queda en espera,por el dbms_lock.sleep(40), en esos segundos voy de nuevo a bd2
BEGIN 
    UPDATE producto SET prd_existencia= prd_existencia -30 WHERE prd_codigo = 'P001';
    DBMS_LOCK.SLEEP(40);
    commit;
    DBMS_OUTPUT.PUTLINE('Usuario modifico procuto');
END;
/

UPDATE producto SET prd_existencia= prd_existencia +80 WHERE prd_codigo = 'P001';

SELECT * FROM cliente;
//Vistas de transacciones 
desc v$sql;

SELECT sql_text, sql_fulltext, parsing_schema_id, parsing_schema_name 
from v$sql
WHERE sql_text LIKE '%producto%'
AND sql_text LIKE '%UPDATE%';

GRANT INSERT, SELECT, UPDATE ON USERDBII.CLIENTE TO bd2;



UPDATE cliente set cli_nombre='Si Juan Perez' WHERE cli_ced_ruc=0102030405001;
commit;
