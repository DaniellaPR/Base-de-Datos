--Base de datos-Clase 8
--todo lo anterior de la clase 7-8 +
--Taller 2.1.1 ------------------------------------------------------------------------------
SELECT event, total_waits, time_waited_micro
FROM v$system_event --Vista con "v_ejemplo" y "$" significa del sistema de la base de datos  
WHERE event LIKE 'db file%read';

SELECT (SUM(time_waited_micro) / SUM(total_waits)) / 1000 AS avg_transfer_time_ms
FROM v$system_event
WHERE event = 'db file sequential read';

SELECT * FROM departamento;

SELECT e.emp_nombre, d.dep_nombre
FROM empleado e
JOIN departamento d ON e.dep_id=d.dep_id
WHERE d.dep_nombre='BICRYZAATPWYJGOECNGOGDWSHBXOHAXRVNKCVPIZSRLGNSJWFH';


SELECT sid, event, total_waits, time_waited_micro
FROM v$session_event
WHERE event LIKE 'db file%read'
AND sid IN (SELECT sid FROM v$session WHERE username='USERDBII');



---Taller 2.2 ---------------------------------------------------------------------
SELECT blevel
FROM user_indexes
WHERE index_name='idx_empelado_nobre';

INSERT INTO empleado VALUES(1001, 8, 'PLABLO CARRERA', 50, 2500);
commit;


SELECT LEAF_BLOCKS
from USER_INDEXES
WHERE index_name='idx_empelado_nombre';


SELECT event, total_waits, time_waited_micro, time_waited_micro/total_waits AS avg_read_tie_ms
FROM v$system_event
WHERE event LIKE 'db file%read';


SELECT file#, phyrds, readtim as avr_read_time_ms FROM v$filestat; --falta division


SELECT phyrds from v$filestat;
