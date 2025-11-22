--Taller 2.2 en motores: PostgreSQL y MySQL
--PostgreSQL ------------------------------------------------------------------------
--Script del power designer:
drop index BODEGA_PK;

drop table BODEGA;

drop index PRODUCTO_PK;

drop table PRODUCTO;

drop index BODEGA_PROD_BOD_FK;

drop index PROD_PRODBODEGA_FK;

drop table PRODUCTO_BODEGA;

drop tablespace PGTABLE;

drop tablespace PGTABLE_I;

create tablespace PGTABLE
   location '/var/lib/pgsql/15/tablespaces';

create tablespace PGTABLE_I
   location '/var/lib/pgsql/15/tablespaces';

/*==============================================================*/
/* Table: BODEGA                                                */
/*==============================================================*/
create table BODEGA (
   BOD_CODIGO           VARCHAR(4)           not null,
   BOD_DESCRIPCION      VARCHAR(60)          null,
   constraint PK_BODEGA primary key (BOD_CODIGO)
)
tablespace PGTABLE;

comment on table BODEGA is
'ENtidad que lamacena información de la bodega.';

/*==============================================================*/
/* Index: BODEGA_PK                                             */
/*==============================================================*/
create unique index BODEGA_PK on BODEGA (
BOD_CODIGO
)
tablespace PGTABLE_I;

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRD_CODIGO           VARCHAR(12)          not null,
   PRD_DESCRIPCION      VARCHAR(60)          null,
   PRD_PRECIO           NUMERIC(8,2)         null,
   constraint PK_PRODUCTO primary key (PRD_CODIGO)
)
tablespace PGTABLE;

comment on table PRODUCTO is
'Entidad que almacena los productos.
';

/*==============================================================*/
/* Index: PRODUCTO_PK                                           */
/*==============================================================*/
create unique index PRODUCTO_PK on PRODUCTO (
PRD_CODIGO
)
tablespace PGTABLE_I;

/*==============================================================*/
/* Table: PRODUCTO_BODEGA                                       */
/*==============================================================*/
create table PRODUCTO_BODEGA (
   PRD_CODIGO           VARCHAR(12)          not null,
   BOD_CODIGO           VARCHAR(4)           not null,
   PRB_EXISTENCIA       NUMERIC(10,2)        null
)
tablespace PGTABLE;

comment on table PRODUCTO_BODEGA is
'Entidad que almacena información del producto y bodega.';

/*==============================================================*/
/* Index: PROD_PRODBODEGA_FK                                    */
/*==============================================================*/
create  index PROD_PRODBODEGA_FK on PRODUCTO_BODEGA (
PRD_CODIGO
)
tablespace PGTABLE_I;

/*==============================================================*/
/* Index: BODEGA_PROD_BOD_FK                                    */
/*==============================================================*/
create  index BODEGA_PROD_BOD_FK on PRODUCTO_BODEGA (
BOD_CODIGO
)
tablespace PGTABLE_I;

--script arreglado para que corra:
-- ============================================================
-- DROPs (con IF EXISTS por si quieres correr varias veces)
-- ============================================================
DROP INDEX IF EXISTS BODEGA_PK;
DROP INDEX IF EXISTS PRODUCTO_PK;
DROP INDEX IF EXISTS BODEGA_PROD_BOD_FK;
DROP INDEX IF EXISTS PROD_PRODBODEGA_FK;

DROP TABLE IF EXISTS PRODUCTO_BODEGA;
DROP TABLE IF EXISTS PRODUCTO;
DROP TABLE IF EXISTS BODEGA;

DROP TABLESPACE IF EXISTS PGTABLE_I;
DROP TABLESPACE IF EXISTS PGTABLE;

-- ============================================================
-- TABLESPACES
-- ============================================================
CREATE TABLESPACE PGTABLE
   LOCATION '/var/lib/pgsql/15/tablespaces';

CREATE TABLESPACE PGTABLE_I
   LOCATION '/var/lib/pgsql/15/tablespaces';

-- ============================================================
-- Table: BODEGA
-- ============================================================
CREATE TABLE BODEGA (
   BOD_CODIGO      VARCHAR(4)   NOT NULL,
   BOD_DESCRIPCION VARCHAR(60)  NULL,
   CONSTRAINT PK_BODEGA PRIMARY KEY (BOD_CODIGO)
)
TABLESPACE PGTABLE;

COMMENT ON TABLE BODEGA IS
'Entidad que almacena información de la bodega.';

-- Índice adicional (realmente no es necesario, pero si lo quieres dejar:)
CREATE UNIQUE INDEX BODEGA_PK ON BODEGA (
   BOD_CODIGO
)
TABLESPACE PGTABLE_I;

-- ============================================================
-- Table: PRODUCTO
-- ============================================================
CREATE TABLE PRODUCTO (
   PRD_CODIGO      VARCHAR(12)   NOT NULL,
   PRD_DESCRIPCION VARCHAR(60)   NULL,
   PRD_PRECIO      NUMERIC(8,2)  NULL,
   CONSTRAINT PK_PRODUCTO PRIMARY KEY (PRD_CODIGO)
)
TABLESPACE PGTABLE;

COMMENT ON TABLE PRODUCTO IS
'Entidad que almacena los productos.';

CREATE UNIQUE INDEX PRODUCTO_PK ON PRODUCTO (
   PRD_CODIGO
)
TABLESPACE PGTABLE_I;

-- ============================================================
-- Table: PRODUCTO_BODEGA
-- ============================================================
CREATE TABLE PRODUCTO_BODEGA (
   PRD_CODIGO     VARCHAR(12)   NOT NULL,
   BOD_CODIGO     VARCHAR(4)    NOT NULL,
   PRB_EXISTENCIA NUMERIC(10,2) NULL,
   -- PK compuesta para evitar duplicados del mismo producto en la misma bodega
   CONSTRAINT PK_PRODUCTO_BODEGA PRIMARY KEY (PRD_CODIGO, BOD_CODIGO),
   -- FKs
   CONSTRAINT FK_PB_PRODUCTO FOREIGN KEY (PRD_CODIGO)
       REFERENCES PRODUCTO (PRD_CODIGO),
   CONSTRAINT FK_PB_BODEGA FOREIGN KEY (BOD_CODIGO)
       REFERENCES BODEGA (BOD_CODIGO)
)
TABLESPACE PGTABLE;

COMMENT ON TABLE PRODUCTO_BODEGA IS
'Entidad que almacena información del producto y bodega.';

-- Índices para acelerar joins por las FKs
CREATE INDEX PROD_PRODBODEGA_FK ON PRODUCTO_BODEGA (
   PRD_CODIGO
)
TABLESPACE PGTABLE_I;

CREATE INDEX BODEGA_PROD_BOD_FK ON PRODUCTO_BODEGA (
   BOD_CODIGO
)
TABLESPACE PGTABLE_I;




--Para crear tablespaces tuve que hacerlo desde el SO, con mkdir en el pwd: /var/lib/pgsql/15/tablespace y /var/lib/pgsql/15/tablespacesII

--Tablespaces:
CREATE TABLESPACE PGTABLE
   LOCATION '/var/lib/pgsql/15/tablespaces';

CREATE TABLESPACE PGTABLE_I
   LOCATION '/var/lib/pgsql/15/tablespacesII';

--script:
-- ============================================================
-- LIMPIEZA (así puedes correrlo varias veces)
-- ============================================================
DROP TABLE IF EXISTS PRODUCTO_BODEGA;
DROP TABLE IF EXISTS PRODUCTO;
DROP TABLE IF EXISTS BODEGA;

-- ============================================================
-- Table: BODEGA
-- ============================================================
CREATE TABLE BODEGA (
   BOD_CODIGO      VARCHAR(4)   NOT NULL,
   BOD_DESCRIPCION VARCHAR(60)  NULL,
   CONSTRAINT PK_BODEGA PRIMARY KEY (BOD_CODIGO)
);

COMMENT ON TABLE BODEGA IS
'Entidad que almacena información de la bodega.';

-- Índice adicional (realmente no hace falta, la PK ya crea uno)
CREATE UNIQUE INDEX BODEGA_PK ON BODEGA (
   BOD_CODIGO
);

-- ============================================================
-- Table: PRODUCTO
-- ============================================================
CREATE TABLE PRODUCTO (
   PRD_CODIGO      VARCHAR(12)   NOT NULL,
   PRD_DESCRIPCION VARCHAR(60)   NULL,
   PRD_PRECIO      NUMERIC(8,2)  NULL,
   CONSTRAINT PK_PRODUCTO PRIMARY KEY (PRD_CODIGO)
);

COMMENT ON TABLE PRODUCTO IS
'Entidad que almacena los productos.';

CREATE UNIQUE INDEX PRODUCTO_PK ON PRODUCTO (
   PRD_CODIGO
);

-- ============================================================
-- Table: PRODUCTO_BODEGA
-- ============================================================
CREATE TABLE PRODUCTO_BODEGA (
   PRD_CODIGO     VARCHAR(12)   NOT NULL,
   BOD_CODIGO     VARCHAR(4)    NOT NULL,
   PRB_EXISTENCIA NUMERIC(10,2) NULL,
   -- PK compuesta para evitar duplicados del mismo producto en la misma bodega
   CONSTRAINT PK_PRODUCTO_BODEGA PRIMARY KEY (PRD_CODIGO, BOD_CODIGO),
   -- FKs
   CONSTRAINT FK_PB_PRODUCTO FOREIGN KEY (PRD_CODIGO)
       REFERENCES PRODUCTO (PRD_CODIGO),
   CONSTRAINT FK_PB_BODEGA FOREIGN KEY (BOD_CODIGO)
       REFERENCES BODEGA (BOD_CODIGO)
);

COMMENT ON TABLE PRODUCTO_BODEGA IS
'Entidad que almacena información del producto y bodega.';

-- Índices para acelerar joins por las FKs
CREATE INDEX PROD_PRODBODEGA_FK ON PRODUCTO_BODEGA (
   PRD_CODIGO
);

CREATE INDEX BODEGA_PROD_BOD_FK ON PRODUCTO_BODEGA (
   BOD_CODIGO
);

--Inserción de datos:
--En caso de cagarla: TRUNCATE TABLE PRODUCTO_BODEGA, PRODUCTO, BODEGA CASCADE;

--Insertar en bodega
INSERT INTO BODEGA (BOD_CODIGO, BOD_DESCRIPCION)
SELECT
    'B' || lpad(i::text, 3, '0')    AS bod_codigo,
    'Bodega ' || i                  AS bod_descripcion
FROM generate_series(1, 10) AS s(i);

--Insertar producto
INSERT INTO PRODUCTO (PRD_CODIGO, PRD_DESCRIPCION, PRD_PRECIO)
SELECT
    'PRD' || lpad(i::text, 4, '0')                     AS prd_codigo,
    'Producto ' || i                                   AS prd_descripcion,
    ROUND((random() * 490 + 10)::numeric, 2)           AS prd_precio
FROM generate_series(1, 1000) AS s(i);

--Insertar producto_bodega
INSERT INTO PRODUCTO_BODEGA (PRD_CODIGO, BOD_CODIGO, PRB_EXISTENCIA)
SELECT
    'PRD' || lpad(i::text, 4, '0')                        AS prd_codigo,
    'B' || lpad((( (i - 1) % 10 ) + 1)::text, 3, '0')     AS bod_codigo,
    ROUND((random() * 500)::numeric, 2)                   AS prb_existencia
FROM generate_series(1, 1000) AS s(i);


SELECT COUNT(*) FROM BODEGA;
SELECT COUNT(*) FROM PRODUCTO;
SELECT COUNT(*) FROM PRODUCTO_BODEGA;

--Empieza el taller:
--1:
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio, b.bod_codigo, b.bod_descripcion, pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo;

--Plan estimación
EXPLAIN
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio, b.bod_codigo, b.bod_descripcion, pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo;

--Plan avanzado tiempo real
EXPLAIN ANALYZE
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio,
       b.bod_codigo, b.bod_descripcion,
       pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo;

--2.
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio, b.bod_codigo, b.bod_descripcion, pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo
WHERE b.bod_descripcion = 'Bodega 1';

--Estimacion de plan
EXPLAIN
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio, b.bod_codigo, b.bod_descripcion, pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo
WHERE b.bod_descripcion = 'Bodega 1';

--Plan con tiempos
EXPLAIN ANALYZE
SELECT p.prd_codigo, p.prd_descripcion, p.prd_precio, b.bod_codigo, b.bod_descripcion, pb.prb_existencia
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo
WHERE b.bod_descripcion = 'Bodega 1';

--Count
--3. Count para filas recuperadas
SELECT COUNT(*) AS filas_recuperadas
FROM producto p
JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
JOIN bodega b ON b.bod_codigo = pb.bod_codigo
WHERE b.bod_descripcion = 'Bodega 1';


--4.Estadísticas de tablas: filas (reltuples) y bloques (relpages)
SELECT relname AS table_name, reltuples::bigint  AS num_rows_est, relpages AS blocks
FROM pg_class
WHERE relname IN ('producto','bodega','producto_bodega');

--5. Proporción y bloques leídos (b) para la consulta
WITH stats AS (
    SELECT
		reltuples::numeric AS num_rows_est,
        relpages::numeric  AS blocks
    FROM pg_class
    WHERE relname = 'producto_bodega'
),
sel AS (
    SELECT COUNT(*)::numeric AS filas_recuperadas
    FROM producto p
    JOIN producto_bodega pb ON p.prd_codigo = pb.prd_codigo
    JOIN bodega b          ON b.bod_codigo = pb.bod_codigo
    WHERE b.bod_descripcion = 'Bodega 1'
)
SELECT
    sel.filas_recuperadas,
    stats.num_rows_est,
    stats.blocks,
    sel.filas_recuperadas / stats.num_rows_est             AS proporcion_filas,
    (sel.filas_recuperadas / stats.num_rows_est)*stats.blocks AS bloques_leidos_b
FROM sel, stats;

--proporción = filas recuperadas / num_rows
--b = proporción × BLOCKS

--tT: tiempo estimado de leer la tabla asumiendo 1 ms por bloque
SELECT
    relname AS table_name,
    relpages AS blocks,
    relpages * 1.0 AS tT_ms   --1.0 ms por bloque
FROM pg_class
WHERE relname = 'producto_bodega';


--bloques aproximados del índice producto
SELECT
    i.relname AS index_name,
    pg_relation_size(i.oid)/current_setting('block_size')::int AS index_blocks
FROM pg_class t
JOIN pg_index ix ON ix.indrelid = t.oid
JOIN pg_class i  ON i.oid = ix.indexrelid
WHERE t.relname = 'producto'
AND ix.indisprimary;

--sacar hi
SELECT (bt_metap('pk_producto_bodega')).level + 1 AS hi;

CREATE EXTENSION pageinspect; --Este va primero antes de hi

--Costos
--Costo_sin_indice = (hi + 1) * (tT + tS)
--Costo_con_indice = hi * (tT + tS) + tS + tT * b

WITH params AS (
    SELECT
        2.0::numeric   AS hi,
        7.0::numeric   AS tT_ms,
        5.0::numeric   AS tS_ms,
        0.7::numeric   AS b
)
SELECT
    (hi + 1) * (tT_ms + tS_ms) AS costo_sin_indice,
    (hi * (tT_ms + tS_ms) + tS_ms + tT_ms * b) AS costo_con_indice
FROM params;


--Gracias

