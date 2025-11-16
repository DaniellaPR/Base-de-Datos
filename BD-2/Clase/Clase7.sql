--crear tablespaces (nuevo)
--usuario
--script
--meter datos(2 begin)

--Clase 7
--anterior:

EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII','EMPLEADO');
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII','DEPARTAMENTO');

SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('DEPARTAMENTO', 'EMPLEADO');


SELECT SEGMENT_NAME, BLOCKS, BYTES
FROM dba_segments
WHERE segment_type = 'TABLE'
AND OWNER = 'USERDBII'
AND segment_name IN ('DEPARTAMENTO', 'EMPLEADO');

--Ahora si clase

SET SERVEROUTPUT ON;
DECLARE
     total_blocks NUMBER;
     total_bytes NUMBER;
     unused_blocks NUMBER;
     unused_bytes NUMBER;
     last_used_extent_file_id NUMBER;
     last_used_extent_block_id NUMBER;
     last_used_block NUMBER;
BEGIN
     DBMS_SPACE.UNUSED_SPACE(
     segment_owner => 'SYSTEM',
     segment_name => 'EMPLEADO',
     segment_type => 'TABLE',
     total_blocks => total_blocks,
     total_bytes => total_bytes,
     unused_blocks => unused_blocks,
     unused_bytes => unused_bytes,
     last_used_extent_file_id => last_used_extent_file_id,
     last_used_extent_block_id => last_used_extent_block_id,
     last_used_block => last_used_block
     );
     DBMS_OUTPUT.PUT_LINE('Total Blocks: ' || total_blocks);
     DBMS_OUTPUT.PUT_LINE('Total Bytes : ' || total_bytes);
     DBMS_OUTPUT.PUT_LINE('Unused Blocks: ' || unused_blocks);
     DBMS_OUTPUT.PUT_LINE('Unused Bytes : ' || unused_bytes);
END;
/


SELECT AVG_ROW_LEN from USER_TABLES WHERE TABLE_NAME='EMPLEADO';

SELECT table_name, blocks, num_rows, CASE WHEN blocks > 0 THEN num_rows / blocks ELSE 0 END AS tuplas_por_bloque
FROM user_tables
WHERE table_name IN ('EMPLEADO', 'DEPARTAMENTO');

SELECT COUNT(DISTINCT dep_id)
FROM empleado;

SELECT * FROM empleado WHERE dep_id=10;

SELECT COUNT(*) FROM empleado 
WHERE dep_id=10;

select 1000/53 from dual; --selectividad alta indexo, baja no indexo
--seletividad es cuantos valores únicos hay, cardinalidad uantos valores se repiten
--concurrencia usuarios activos
--transaccionalidad número de

CREATE INDEX idx_empelado_nombre ON empleado(emp_nombre);

SELECT index_name, blevel
FROM user_indexes
WHERE table_name = 'EMPLEADO';



---costo estimado del algoritmo
--plan de ejecución

EXPLAIN PLAN FOR
SELECT e.emp_nombre, d.dep_nombre
FROM empleado e
JOIN departamento d ON e.dep_id = d.dep_id;


SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
