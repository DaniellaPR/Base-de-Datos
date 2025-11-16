--Base de datos - taller 2.1.1
--Optimización tiempos

--Taller Tarea:

--Medir el tiempo de transferencia para un blqoue
--Consulta para obtener estadísticas de lectura de bloques
-- Actividad 1: ver eventos de lectura a nivel de sistema
SELECT event, total_waits, time_waited_micro
FROM v$system_event
WHERE event LIKE 'db file%read';

--estimación sdel tiempo de transferencia promedio de un bloque en ms
SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_transfer_time_ms
FROM v$system_event
WHERE event = 'db file sequential read';

--Meir el tiempo ttal de búsqueda
 file stat

--Promedio de espera para la búsqueda:
SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_search_time_ms
FROM v$session_event
WHERE event = 'db file scattered read';

--Consulta entre las tablas relacionadas que provoca lecturas de bloque
SELECT p.prd_descripcion, b.bod_descripcion, bp.prb_existencia
FROM producto p
JOIN bodega_producto bp ON p.prd_codigo = bp.prd_codigo
JOIN bodega b ON bp.bod_codigo = b.bod_codigo
WHERE b.bod_descripcion = 'Bodega Uno';

--Monitoreo en tiempo real:
SELECT sid, event, total_waits, time_waited_micro
FROM v$session_event
WHERE event LIKE 'db file%read'
AND sid IN (SELECT sid FROM v$session WHERE username = USER);
