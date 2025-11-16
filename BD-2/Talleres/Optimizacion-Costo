Base de Datos - Taller 2.2
--Cálculos

--Costos estimados utilizando índices
--1: Altura del índice h_i o blevel + 1

SELECT index_name, table_name, blevel, (blevel + 1) AS hi
FROM user_indexes
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--insertar mas registros en productos
BEGIN
  FOR i IN 1001..11000 LOOP
    INSERT INTO producto (prd_codigo, prd_descripcion, prd_precio)
    VALUES ('P' || TO_CHAR(i,'FM000000'), 'Producto extra ' || i, ROUND(DBMS_RANDOM.VALUE(10,500),2));
  END LOOP;
END;
/

SELECT MAX(prd_codigo) AS max_codigo FROM producto;

--2: Tiempo de lectura en tabla tT
--2.1: Número de bloques de cada tabla
SELECT table_name,  num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--2.2: Latencia o tiempo promedio de lectura
SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_transfer_time_ms
FROM v$system_event
WHERE event = 'db file sequential read';

--2.3 bloques por tiempo:
WITH base AS (SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO'))
SELECT table_name, num_rows, blocks,3.7904114 * blocks AS tT_ms 
FROM base;


--3: Tiempo de búsqueda eb el índice
--3.1: indices y bloques hoja
SELECT index_name, table_name, blevel, leaf_blocks
FROM user_indexes
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--3.2: ts o tiempo promedio de lectura por bloque
SELECT event, total_waits, time_waited_micro,time_waited_micro/total_waits AS avg_read_time_us, (time_waited_micro/total_waits)/1000 AS avg_read_time_ms
FROM v$system_event
WHERE event IN ('db file sequential read', 'db file scattered read');

--3.3 Verificación a nivel de archivo
SELECT file#, phyrds, readtim,(readtim/phyrds)*10 AS avg_read_time_ms
FROM v$filestat;

SELECT phyrds from v$filestat;

-- 3.3 Verificación a nivel de archivo (con control de divisor = 0)
SELECT file#,
       phyrds,
       readtim,
       CASE
         WHEN phyrds > 0 THEN (readtim / phyrds) * 10
         ELSE NULL
       END AS avg_read_time_ms
FROM v$filestat
WHERE phyrds > 0;


--4. Numero de bloques leídos por la tabla:
--4.1Actualizar estadísticas de todas las tablas del usuario actual
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PRODUCTO');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA_PRODUCTO');

--4.2 calculo de numero de filas y blqoues de user_Tables
SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--4.3 consulta especifica 
--bloques de la tabla leídos para la consulta:
SELECT p.prd_descripcion, b.bod_descripcion, bp.prb_existencia
FROM producto p
JOIN bodega_producto bp ON p.prd_codigo = bp.prd_codigo
JOIN bodega b ON bp.bod_codigo = b.bod_codigo
WHERE b.bod_descripcion = 'Bodega Uno';

--Costos estimados utilizando índices
--1: Altura del índice h_i o blevel + 1

SELECT index_name, table_name, blevel, (blevel + 1) AS hi
FROM user_indexes
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--insertar mas registros en productos
BEGIN
  FOR i IN 1001..11000 LOOP
    INSERT INTO producto (prd_codigo, prd_descripcion, prd_precio)
    VALUES ('P' || TO_CHAR(i,'FM000000'), 'Producto extra ' || i, ROUND(DBMS_RANDOM.VALUE(10,500),2));
  END LOOP;
END;
/

SELECT MAX(prd_codigo) AS max_codigo FROM producto;

--2: Tiempo de lectura en tabla tT
--2.1: Número de bloques de cada tabla
SELECT table_name,  num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--2.2: Latencia o tiempo promedio de lectura
SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_transfer_time_ms
FROM v$system_event
WHERE event = 'db file sequential read';

--2.3 bloques por tiempo:
WITH base AS (SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO'))
SELECT table_name, num_rows, blocks,3.7904114 * blocks AS tT_ms 
FROM base;


--3: Tiempo de búsqueda eb el índice
--3.1: indices y bloques hoja
SELECT index_name, table_name, blevel, leaf_blocks
FROM user_indexes
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--3.2: ts o tiempo promedio de lectura por bloque
SELECT event, total_waits, time_waited_micro,time_waited_micro/total_waits AS avg_read_time_us, (time_waited_micro/total_waits)/1000 AS avg_read_time_ms
FROM v$system_event
WHERE event IN ('db file sequential read', 'db file scattered read');

--3.3 Verificación a nivel de archivo
SELECT file#, phyrds, readtim,(readtim/phyrds)*10 AS avg_read_time_ms
FROM v$filestat;

SELECT phyrds from v$filestat;

-- 3.3 Verificación a nivel de archivo (con control de divisor = 0)
SELECT file#,
       phyrds,
       readtim,
       CASE
         WHEN phyrds > 0 THEN (readtim / phyrds) * 10
         ELSE NULL
       END AS avg_read_time_ms
FROM v$filestat
WHERE phyrds > 0;


--4. Numero de bloques leídos por la tabla:
--4.1Actualizar estadísticas de todas las tablas del usuario actual
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PRODUCTO');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA_PRODUCTO');

--4.2 calculo de numero de filas y blqoues de user_Tables
SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--4.3 consulta especifica 
--bloques de la tabla leídos para la consulta, info de la tabla
SELECT p.prd_descripcion, b.bod_descripcion, bp.prb_existencia
FROM producto p
JOIN bodega_producto bp ON p.prd_codigo = bp.prd_codigo
JOIN bodega b ON bp.bod_codigo = b.bod_codigo
WHERE b.bod_descripcion = 'Bodega Uno';

--4.4.1 Filas recuperadas por la consulta específica
SELECT COUNT(*) AS filas_recuperadas
FROM producto p
JOIN bodega_producto bp ON p.prd_codigo = bp.prd_codigo
JOIN bodega b ON bp.bod_codigo = b.bod_codigo
WHERE b.bod_descripcion = 'Bodega Uno';

--4.4.2 Total de filas y bloques de la tabla base
SELECT num_rows, blocks
FROM user_tables
WHERE table_name = 'BODEGA_PRODUCTO';

--Proporción = filas_recuperadas/num_rows = 1000/5000=0.2
--4.4.3 Calculamos b
SELECT 1000 / 5000 AS proporcion FROM dual;

-- 5 Costo final
-- 5.1 Costo SIN índice
SELECT ((2 + 1)*(75.808228+46.3374167)) AS costo_sin_indice
FROM dual;

-- 5.2 Costo CON índice
SELECT (2 *(75.808228+46.3374167) + 46.3374167+(75.808228*4)) AS costo_con_indice
FROM dual;
