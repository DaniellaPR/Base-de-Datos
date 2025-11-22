--Parte 1: En PRODUCTO crear índice en columna prd_existencia:
CREATE INDEX IDX_prd_existencia ON producto(prd_existencia);
select * from producto;

--Altura del índice usando blevel de user_indexes
SELECT index_name, table_name, blevel, (blevel +1) as hi
FROM user_indexes
WHERE table_name IN ('PRODUCTO');
--Parte 2: OPTIMIZER MODE con first rows:
SHOW PARAMETER OPTIMIZER_MODE;
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS;
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS;
ALTER SYSTEM SET OPTIMIZER_MODE = FIRST_ROWS_10 SCOPE=BOTH;

EXPLAIN PLAN FOR --consulta para explicar plan
SELECT * FROM producto
WHERE prd_precio > 100;

EXEC DBMS_STATS.GATHER_TABLE_STATS('USERDBII','PRODUCTO'); --actualizar estadísticas

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); --mostrar plan
SELECT * FROM producto --consulta normal
WHERE prd_precio > 100;
--Parte 3: Costo calcular
--1. hi
--Hecho arriba=1
--2. tT
SELECT event, total_waits, time_waited_micro --global
FROM v$system_event
WHERE event LIKE 'db_file%read';

SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_transfer_time_ms --especifco para tT
FROM v$system_event
WHERE event = 'db file sequential read';
--3. tS
SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_search_time_ms --Para tS
FROM v$session_event
WHERE event = 'db file scattered read';
--4. b
--estimación bloques leídos por tiempo tT o br y además num rows y bloques
WITH base AS (SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO'))
SELECT table_name, num_rows, blocks,0.32 * blocks AS br
FROM base;

select (30*5)/1.6 as b from dual; --calculo final para b
--5. Costo
SELECT (1*(0.32+0.32)+0.32+(0.32*16)) as costo from dual;
--Resultados:
--num rows=30
--blocks=5
--hi=1
--tT=0.32
--tS=0.32
--br=1.6
--b=93.75
--Costo final= 30.96
--6. Calcular tT obteniendo blocks y considerando un disco HDDD=2ms y la consulta lee 50 bloques
--Tenemos:
--num rows=30
--blocks=50
--hi=3
--tT=0.32
--tS=2
--br=1.6
--b=93.75
--Costo final= 30.96
--Costo estimado:
--1. Nuevo calculo para b:
WITH base AS (SELECT table_name, num_rows
FROM user_tables
WHERE table_name IN ('PRODUCTO'))
SELECT table_name, num_rows,0.32 * 50 AS br
FROM base;

select (30*50)/1.6 as b from dual;

SELECT (3*(0.32+2)+2+(0.32*93.75)) as costo from dual;
