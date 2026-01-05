//En el usuario QYT

EXPLAIN PLAN FOR
SELECT SUM(prd_existencia), COUNT(prd_codigo)
FROM producto
WHERE prd_categoria =4;

SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);

//Con esto analizamos la tabla producto

SELECT count(*) FROM producto;

//que el total de 1000000 de productos registrados aleatoriamente

//Creamos ahora otra tabla
/*==============================================================*/
/* Table: PRODUCTO_PART */
/*==============================================================*/
create table PRODUCTO_PART (
PRD_CODIGO VARCHAR2(10) not null,
PRD_NOMBRE CHAR(30),
PRD_CATEGORIA NUMBER(10) not null,
PRD_PRECIO NUMBER(12,2),
PRD_EXISTENCIA NUMBER(10),
constraint CKC_PRD_EXISTENCIA_PRODPART check (PRD_EXISTENCIA is null or (PRD_EXISTENCIA >= '0')),
constraint PK_PRODUCTOPART primary key (PRD_CODIGO)
)
PARTITION BY RANGE (PRD_CATEGORIA)
(
PARTITION CAT_01 VALUES LESS THAN (2),
PARTITION CAT_02 VALUES LESS THAN (3),
PARTITION CAT_03 VALUES LESS THAN (4),
PARTITION CAT_04 VALUES LESS THAN (5),
PARTITION CAT_05 VALUES LESS THAN (6),
PARTITION CAT_06 VALUES LESS THAN (7),
PARTITION CAT_07 VALUES LESS THAN (8),
PARTITION CAT_08 VALUES LESS THAN (9),
PARTITION CAT_09 VALUES LESS THAN (10),
PARTITION CAT_10 VALUES LESS THAN (11),
PARTITION CAT_FUTURAS VALUES LESS THAN (MAXVALUE)
)
tablespace AULA
/

//la tabla producto tiene prd_codigo,prd_nombre,prd_categoria,prd_precio,prd_existencoa
INSERT INTO producto_part SELECT prd_codigo,prd_nombre,prd_categoria,prd_precio,prd_existencoa FROM producto;
commit;


//Ahora hacemos la comparación con la tabla particionada
EXPLAIN PLAN FOR
SELECT SUM(prd_existencia), COUNT(prd_codigo)
FROM producto_part
WHERE prd_categoria =4;

SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);

//Consulta paralela en tabla no paralela 589
EXPLAIN PLAN FOR
SELECT /*PARALLEL(producto,4)*/ SUM(prd_existencia), COUNT(prd_codigo)
FROM producto
WHERE prd_categoria =4;
SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);



//Consulta no pararlela en una tabla no particionada 589
EXPLAIN PLAN FOR
SELECT SUM(prd_existencia), COUNT(prd_codigo)
FROM producto
WHERE prd_categoria =4;
SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);
//Consulta sobre la tabla

//Consulta paralela en una
EXPLAIN PLAN FOR
SELECT SUM(prd_existencia), COUNT(prd_codigo)
FROM producto_part
WHERE prd_categoria =4;
SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);

//Consulta paralela en una tabla particionada
EXPLAIN PLAN FOR
SELECT /*PARALLEL(producto_part,4)*/ SUM(prd_existencia), COUNT(prd_codigo)
FROM producto_part
WHERE prd_categoria =4;
SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);

//Consulta no paralela en una tabla particionada
EXPLAIN PLAN FOR
SELECT SUM(prd_existencia), COUNT(prd_codigo)
FROM producto_part
WHERE prd_categoria =4;
SELECT * FROM TABLE(dbms_XPLAIN.DISPLAY);

//PArticionar las tablas nos permite ejecutar consultas mas baratas usando query normales
