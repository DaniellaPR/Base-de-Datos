--Base de Datos - Taller 2.3
--Optimizar Base de Datos

--Mostrar estado de optimizer mode
SHOW PARAMETER OPTIMIZER_MODE;
--Si se quiere alterarla para poner en ALL ROWS:
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS;

Select COUNT(*) from producto;

SELECT * FROM producto
WHERE prd_precio > 150;

--Configuración del OPTIMIZER_MODE a nivel de sistema:
ALTER SYSTEM SET OPTIMIZER_MODE = FIRST_ROWS_10 SCOPE=BOTH;  --entonces solo las primeras 10 filas

--Consulta en modo FIRST_ROWS:
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS;

EXPLAIN PLAN FOR
SELECT * FROM producto
WHERE prd_precio > 150;

--Para ver el efecto del cambio del OPTIMIZER_MODE usar EXPLAIN PLAN
EXPLAIN PLAN FOR
SELECT * FROM bodega_producto
WHERE prb_existencia > 0.60;

--Muestra el plan de ejecución actual para la consulta, incluyendo el costo estimado y la cantidad de I/O que se realizará .
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--El CBO utiliza estadísticas de las tablas e índices para determinar el mejor plan de ejecución.
--estadísticas actualizadas
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII', 'producto');
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII', 'bodega');
EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII', 'bodega_producto');
