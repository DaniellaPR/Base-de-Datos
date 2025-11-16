--Conectar a la base de datos userdbII.

CREATE TABLE test_normal (
    empno NUMBER(10),
    ename VARCHAR2(30),
    sal NUMBER(10)
    )
    tablespace I_AULA
    /
--Conectar a la base de datos prueba

SELECT * FROM TAB;
DESC test_normal
--Para tener permisos se da al rol y le asignábamos el rol


BEGIN
  FOR i IN 1..2000000 LOOP
    INSERT INTO test_normal VALUES (i, DBMS_RANDOM.STRING('U',30), DBMS_RANDOM.VALUE(1000,5000));
    IF MOD(i, 10000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
END;
/

SELECT COUNT(*) FROM test_normal;  --para contar registros, debería mostrar los dos millones

--PRIMERA PARTE CON BASE - BITMAP
--Luego
CREATE BITMAP INDEX normal_empno_bmx ON test_normal(empno);
SELECT SYS_CONTEXT('USERENV','SID') FROM DUAL;

INSERT INTO test_normal (empno, ename, sal)
VALUES (1000000, 'EJEMPLO', 2500);

--En otra session del mismo usuario | abrir con contraseña
SELECT SYS_CONTEXT('USERENV','SID') FROM DUAL;

INSERT INTO test_normal (empno, ename, sal)
VALUES (1000000, 'AAABBBCCCDDDEEEFFFGGGHHH', 2500); --clave primaria en tabla no hay,, e pueden poner dos 100000, a pesar de que hay 2 o 5 millones de datos, se pueden repetir

--En la primera anterior
SELECT 'SID=' || s1.sid || ' IS BLOCKING SID=' || s2.sid AS blocking_status
FROM v$lock l1, v$session s1, v$lock l2, v$session s2
WHERE s1.sid=l1.sid AND s2.sid=l2.sid
AND l1.BLOCK=1 AND l2.request > 0
AND l1.id1 = l2.id1
AND l2.id2 = l2.id2;

--Para matar sesión buscar serial
SELECT sid, serial#, username, program
FROM v$session
WHERE sid = <SID_BLOQUEADA>;  --recordar que aquí va la SID de la sesión B

--Ahpí sale el serial que vamos a utilizar

ALTER SYSTEM KILL SESSION '287,44643';  --se murió la sesión

--verificar cual quedó
SELECT sid, status, username, program
FROM v$session
WHERE sid IN ( /* pon aquí SID de A y SID de B */ );
