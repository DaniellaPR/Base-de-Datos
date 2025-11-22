Base de Datos - Taller 2.1 
Optimización en Costos

--Iniciar con script para tablas en userdbII:
-- LIMPIEZA (por si ya existen)
DROP TABLE BODEGA_PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE BODEGA CASCADE CONSTRAINTS;
/

-- TABLA BODEGA
CREATE TABLE BODEGA (
  BOD_CODIGO      VARCHAR2(4)    NOT NULL,
  BOD_DESCRIPCION VARCHAR2(60),
  CONSTRAINT PK_BODEGA PRIMARY KEY (BOD_CODIGO)
);
/

-- TABLA PRODUCTO
CREATE TABLE PRODUCTO (
  PRD_CODIGO      VARCHAR2(12)   NOT NULL,
  PRD_DESCRIPCION VARCHAR2(60),
  PRD_PRECIO      NUMBER(8,2),
  CONSTRAINT PK_PRODUCTO PRIMARY KEY (PRD_CODIGO)
);
/

-- TABLA INTERMEDIA
CREATE TABLE BODEGA_PRODUCTO (
  BOD_CODIGO     VARCHAR2(4)  NOT NULL,
  PRD_CODIGO     VARCHAR2(12) NOT NULL,
  PRB_EXISTENCIA NUMBER(10,2),
  CONSTRAINT PK_BODEGA_PRODUCTO PRIMARY KEY (BOD_CODIGO, PRD_CODIGO),
  CONSTRAINT FK_BP_BODEGA  FOREIGN KEY (BOD_CODIGO) REFERENCES BODEGA(BOD_CODIGO),
  CONSTRAINT FK_BP_PRODUCTO FOREIGN KEY (PRD_CODIGO) REFERENCES PRODUCTO(PRD_CODIGO)
);
/

-- (Opcional, pero bonito para el informe)
COMMENT ON TABLE BODEGA IS 'Entidad que almacena información de las bodegas';
COMMENT ON TABLE PRODUCTO IS 'Entidad que almacena los productos';
COMMENT ON TABLE BODEGA_PRODUCTO IS 'Relación N:N entre bodega y producto';
/


--Taller
SELECT * FROM dba_tablespaces;

--Inserción de las 5 bodegas
INSERT INTO bodega VALUES ('B001','Bodega Uno');
INSERT INTO bodega VALUES ('B002','Bodega Dos');
INSERT INTO bodega VALUES ('B003','Bodega Tres');
INSERT INTO bodega VALUES ('B004','Bodega Cuatro');
INSERT INTO bodega VALUES ('B005','Bodega Cinco');


SELECT * FROM producto;
--Añadir los 1000 productos
BEGIN
  FOR i IN 1..1000 LOOP
    INSERT INTO producto (prd_codigo, prd_descripcion, prd_precio) 
    VALUES ('P' || TO_CHAR(i,'FM0000'),'Producto ' || i, ROUND(DBMS_RANDOM.VALUE(10,500),2));
  END LOOP;
END;
/

SELECT * FROM bodega_producto;
--LLenar la tabla de producto x bodega
BEGIN
  FOR b IN (SELECT bod_codigo FROM bodega) LOOP
    FOR p IN (SELECT prd_codigo FROM producto) LOOP
      INSERT INTO bodega_producto (bod_codigo, prd_codigo, prb_existencia) 
      VALUES (b.bod_codigo, p.prd_codigo, ROUND(DBMS_RANDOM.VALUE(0,1000),2));
    END LOOP;
  END LOOP;
END;
/

SELECT COUNT(*) FROM bodega_producto;


--Inicio del taller
SET SERVEROUTPUT ON;

--estadísticas de las tablas
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PRODUCTO');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA');
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'BODEGA_PRODUCTO');


--Select para saber los bloques y tuplas
SELECT table_name, num_rows, blocks
FROM user_tables
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--Select para consultar en user_tables
SELECT table_name, num_rows, blocks
FROM dba_tables
WHERE owner = USER
AND table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');

--La función anónima que también se puede utilizar:
SET SERVEROUTPUT ON;
DECLARE
   total_blocks       NUMBER;
   total_bytes        NUMBER;
   unused_blocks      NUMBER;
   unused_bytes       NUMBER;
   lf_id  NUMBER;
   lb_id  NUMBER;
   lb     NUMBER;
BEGIN
   DBMS_SPACE.UNUSED_SPACE(
      segment_owner     => USER,
      segment_name      => 'BODEGA_PRODUCTO',
      segment_type      => 'TABLE',
      total_blocks      => total_blocks,
      total_bytes       => total_bytes,
      unused_blocks     => unused_blocks,
      unused_bytes      => unused_bytes,
      last_used_extent_file_id  => lf_id,
      last_used_extent_block_id => lb_id,
      last_used_block          => lb
   );

   DBMS_OUTPUT.PUT_LINE('Tabla: BODEGA_PRODUCTO');
   DBMS_OUTPUT.PUT_LINE('Total Blocks: ' || total_blocks);
   DBMS_OUTPUT.PUT_LINE('Total Bytes : ' || total_bytes);
   DBMS_OUTPUT.PUT_LINE('Unused Blocks: ' || unused_blocks);
   DBMS_OUTPUT.PUT_LINE('Unused Bytes : ' || unused_bytes);
END;
/

--Consultar el espacio en el disco como en función anónima
SELECT segment_name, segment_type, blocks, bytes
FROM dba_segments
WHERE owner = USER
AND segment_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');


--2. Número de tuplas y tupals por bloque:
SELECT AVG_ROW_LEN
FROM user_tables
WHERE table_name = 'bodega_producto';
--no sale nada hay que actualizar estadísticas:
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PRODUCTO');

SELECT table_name, avg_row_len
FROM user_tables
WHERE table_name = 'PRODUCTO';


SELECT table_name, num_rows, blocks, 
CASE WHEN blocks > 0 THEN num_rows / blocks ELSE 0 END AS tuplas_por_bloque
FROM user_tables
WHERE table_name IN ('PRODUCTO', 'BODEGA', 'BODEGA_PRODUCTO');





--Actividad 3. 
--bodegas distintas
SELECT COUNT(DISTINCT bod_codigo) AS bodegas_usadas
FROM bodega_producto;

--productos distintos
SELECT COUNT(DISTINCT prd_codigo) AS productos_usados
FROM bodega_producto;


--Actividad 4.
--índice
CREATE INDEX IDX_PRODUCTO_DESC ON PRODUCTO (PRD_DESCRIPCION);

--Consulta de altura
SELECT index_name, table_name, blevel, num_rows
FROM user_indexes
WHERE table_name = 'PRODUCTO';

SELECT index_name, table_name, blevel, num_rows
FROM user_indexes
WHERE table_name IN ('PRODUCTO','BODEGA','BODEGA_PRODUCTO');


--5. Costo estimado
EXPLAIN PLAN FOR
SELECT p.prd_descripcion, b.bod_descripcion, bp.prb_existencia
FROM producto p
JOIN bodega_producto bp ON p.prd_codigo = bp.prd_codigo
JOIN bodega b ON bp.bod_codigo = b.bod_codigo;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
