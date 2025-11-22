--usuario 2 (db2)
select * from userdbii.producto;
-- como tenemos el constraint no debería de hacer el commit, pq el producto con codigo P001 no tiene 500 existencias, que es lo que trata de hacer
BEGIN 
	UPDATE producto SET PRD_EXISTENCIA = PRD_EXISTENCIA- 500 WHERE prd_codigo = 'P001';
	UPDATE producto SET prd_existencia = PRD_EXISTENCIA-20 WHERE prd_codigo = 'P002';
	COMMIT;
EXCEPTION 
    WHEN OTHER 
        THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('ERROR: '|| SQL_ERROR || ' Rollback automatico ejecutado');
END;
/
--Vemos que no se hicieron cambios aunque ya le hicimos commit en el proceso
SELECT * FROM USERDBII.producto WHERE prd_codigo='P001';
--Volvemos a userdbii

--Ejecuto
UPDATE USERDBII.producto SET prd_existencia = prd_existencia -200 WHERE prd_codigo ='P001';
--Se queda bloqueado pq necesita que termine primero la otra transaccion y luego daría error

SELECT * FROM USERDBII.cliente;
desc userdbii.cliente;

UPDATE USERDBII.cliente SET cli_nombre = 'No Juan Pérez' WHERE cli_ced_ruc= 0102030405001;
    commit;
