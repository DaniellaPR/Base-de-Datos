--TAREA EMPIEZA

--CREAR EN RANDOM BITMAP

CREATE BITMAP INDEX RANDOM_EMPNO_BMX ON test_random(empno);

BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
ownname => 'USERDBII',
 tabname => 'test_random',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO');
END;
/


SELECT SUBSTR(segment_name,1,30) segment_name, BYTES/1024/1024 "Size in MB"
FROM user_segments
WHERE segment_name in ('TEST_NORMAL','NORMAL_EMPNO_BMX');

SELECT segment_name, blocks
FROM dba_segments
WHERE segment_name = 'TEST_RANDOM' AND segment_type = 'TABLE';

SELECT table_name, blocks
FROM dba_tables
WHERE table_name = 'TEST_RANDOM';

SET AUTOTRACE ON

SELECT * FROM test_random WHERE empno = 1252608;
SELECT * FROM test_random WHERE empno = 880580;
SELECT * FROM test_random WHERE empno = 1361071;


--CREAR BTREE

DROP INDEX random_empno_bmx;
CREATE INDEX random_empno_idx ON test_random(empno);

BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
  ownname => 'USERDBII',
  tabname => 'TEST_RANDOM',
  estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
  cascade => TRUE,
  method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/

SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_RANDOM','RANDOM_EMPNO_IDX')
ORDER BY segment_name;

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name = 'RANDOM_EMPNO_IDX';

SET AUTOTRACE ON

SELECT * FROM test_random WHERE empno = 1252608;
SELECT * FROM test_random WHERE empno = 880580;
SELECT * FROM test_random WHERE empno = 1361071;




--TABLA NORMAL:

--BITMAP

CREATE BITMAP INDEX normal_empno_bmx ON test_normal(empno);BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
ownname => 'USERDBII',
 tabname => 'test_normal',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO');
END;
/

SELECT SUBSTR(segment_name,1,30) segment_name, BYTES/1024/1024 "Size in
MB"
FROM user_segments
WHERE segment_name in ('TEST_NORMAL','NORMAL_EMPNO_BMX');

SELECT index_name, clustering_factor FROM user_indexes WHERE index_name =
'NORMAL_EMPNO_BMX';

SELECT segment_name, blocks
FROM dba_segments
WHERE segment_name = 'TEST_NORMAL' AND segment_type = 'TABLE';

SELECT table_name, blocks
FROM dba_tables
WHERE table_name = 'TEST_NORMAL';

SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_NORMAL','NORMAL_EMPNO_BMX');

SELECT index_name, index_type, clustering_factor
FROM user_indexes
WHERE index_name='NORMAL_EMPNO_BMX';

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name='NORMAL_EMPNO_BMX';


SET AUTOTRACE ON

SELECT * FROM test_normal WHERE empno BETWEEN 100000 AND 200000;
SELECT * FROM test_normal WHERE empno BETWEEN 1000000 AND 1100000;
SELECT * FROM test_normal WHERE empno BETWEEN 1800000 AND 1999999;


--B-TREE
DROP INDEX NORMAL_EMPNO_BMX;

CREATE INDEX NORMAL_EMPNO_IDX ON test_normal(empno);

BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
 ownname => 'USERDBII',
 tabname => 'test_normal',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/

SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_NORMAL','NORMAL_EMPNO_IDX')
ORDER BY segment_name;

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name = 'NORMAL_EMPNO_IDX';

SET AUTOTRACE ON

SELECT * FROM test_normal WHERE empno BETWEEN 100000 AND 200000;
SELECT * FROM test_normal WHERE empno BETWEEN 1000000 AND 1100000;
SELECT * FROM test_normal WHERE empno BETWEEN 1800000 AND 1999999;





--AHORA CON LA TABLA TEST_RANDOM Y UN RANGO PARA EMPNO

--BITMAP

BEGIN
  FOR r IN (SELECT index_name FROM user_ind_columns
            WHERE table_name='TEST_RANDOM' AND column_name='EMPNO') LOOP
    EXECUTE IMMEDIATE 'DROP INDEX '||r.index_name;
  END LOOP;
END;
/
CREATE INDEX RANDOM_EMPNO_BMX ON test_random(empno);

BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
 ownname => 'USERDBII',
 tabname => 'test_random',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/

SET AUTOTRACE ON

SELECT * FROM test_random WHERE empno BETWEEN 100000 AND 200000;
SELECT * FROM test_random WHERE empno BETWEEN 1000000 AND 1100000;
SELECT * FROM test_random WHERE empno BETWEEN 1800000 AND 1999999;


--B-TREE

DROP INDEX RANDOM_EMPNO_BMX;
CREATE INDEX RANDOM_EMPNO_IDX ON test_random(empno);

BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
 ownname => 'USERDBII',
 tabname => 'test_random',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/

SET AUTOTRACE ON

SELECT * FROM test_random WHERE empno BETWEEN 100000 AND 200000;
SELECT * FROM test_random WHERE empno BETWEEN 1000000 AND 1100000;
SELECT * FROM test_random WHERE empno BETWEEN 1800000 AND 1999999;




--EN TABLA NORMAL-Paso 5

--BITMAP

BEGIN
  FOR r IN (SELECT index_name FROM user_ind_columns
            WHERE table_name='TEST_NORMAL' AND column_name='SAL') LOOP
    EXECUTE IMMEDIATE 'DROP INDEX '||r.index_name;
  END LOOP;
END;
/

CREATE BITMAP INDEX NORMAL_SAL_BMX ON test_normal(sal);

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'USERDBII',
    tabname => 'TEST_NORMAL',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    cascade => TRUE,
    method_opt => 'FOR ALL COLUMNS SIZE AUTO'
  );
END;
/

SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_NORMAL','NORMAL_SAL_BMX')
ORDER BY segment_name;

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name = 'NORMAL_SAL_BMX';

--valores de SAL que existan:
WITH s AS (
  SELECT DISTINCT sal FROM test_normal
  ORDER BY dbms_random.value
)
SELECT sal FROM s FETCH FIRST 3 ROWS ONLY;

--Maximo y minimo
SELECT MIN(sal) AS min_sal, MAX(sal) AS max_sal FROM test_normal;


SET AUTOTRACE ON

-- Igualdades
SELECT * FROM test_normal WHERE sal = 1530;
SELECT * FROM test_normal WHERE sal = 2306;
SELECT * FROM test_normal WHERE sal = 4357;

-- Rangos
SELECT * FROM test_normal WHERE sal BETWEEN 1000 AND 1500;
SELECT * FROM test_normal WHERE sal BETWEEN 2000 AND 2999;
SELECT * FROM test_normal WHERE sal BETWEEN 3000 AND 5000;


--B-TREE:

DROP INDEX NORMAL_SAL_BMX;
CREATE INDEX NORMAL_SAL_IDX ON test_normal(sal);
bEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
 ownname => 'USERDBII',
 tabname => 'test_normal',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/

SET AUTOTRACE ON

-- Igualdades
SELECT * FROM test_normal WHERE sal = 1530;
SELECT * FROM test_normal WHERE sal = 2306;
SELECT * FROM test_normal WHERE sal = 4357;

-- Rangos
SELECT * FROM test_normal WHERE sal BETWEEN 1000 AND 1500;
SELECT * FROM test_normal WHERE sal BETWEEN 2000 AND 2999;
SELECT * FROM test_normal WHERE sal BETWEEN 3000 AND 5000;





--PASO 6 (BAJA CARDINALIDAD)

--BITMAP:

BEGIN
  FOR r IN (SELECT index_name FROM user_ind_columns
            WHERE table_name='TEST_NORMAL' AND column_name='DEPTNO') LOOP
    EXECUTE IMMEDIATE 'DROP INDEX '||r.index_name;
  END LOOP;
END;
/

DESC test_normal;
ALTER TABLE test_normal ADD grupo CHAR(1);

DECLARE
  v_rand NUMBER;
BEGIN
  FOR i IN 1..2000000 LOOP
    v_rand := DBMS_RANDOM.VALUE;
    UPDATE test_normal
    SET grupo = CASE
      WHEN v_rand < 0.33 THEN 'A'
      WHEN v_rand < 0.66 THEN 'B'
      ELSE 'C'
    END
    WHERE empno = i;
    IF MOD(i, 10000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
/


CREATE BITMAP INDEX NORMAL_DEPTNO_BMX ON test_normal(grupo);
BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
ownname => 'USERDBII',
 tabname => 'test_normal',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO');
END;
/

SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_NORMAL','NORMAL_DEPTNO_BMX')
ORDER BY segment_name;

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name = 'NORMAL_DEPTNO_BMX';



SET AUTOTRACE ON

-- Igualdad
SELECT * FROM test_normal WHERE grupo = 'A';
-- Rango
SELECT * FROM test_normal WHERE grupo IN ('A', 'B');


--B-REE

DROP INDEX NORMAL_DEPTNO_BMX;
CREATE INDEX NORMAL_GRUPO_IDX ON test_normal(grupo);


BEGIN
 DBMS_STATS.GATHER_TABLE_STATS(
 ownname => 'USERDBII',
 tabname => 'test_normal',
 estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
 cascade => TRUE,
 method_opt => 'FOR ALL COLUMNS SIZE AUTO'
 );
END;
/


SELECT segment_name, bytes/1024/1024 AS Size_MB
FROM user_segments
WHERE segment_name IN ('TEST_NORMAL','NORMAL_GRUPO_IDX')
ORDER BY segment_name;

SELECT index_name, index_type, clustering_factor, blevel, leaf_blocks, distinct_keys
FROM user_indexes
WHERE index_name = 'NORMAL_GRUPO_IDX';


SET AUTOTRACE ON

--Igualdad
SELECT * FROM test_normal WHERE grupo = 'A';

--“Rango”
SELECT * FROM test_normal WHERE grupo IN ('A', 'B');



--PASO 7: :c
no hay
