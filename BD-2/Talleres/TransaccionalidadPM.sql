Taller4.1.1
En Postgres y MySQL


--Pgadmin:

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Forma 1 no utilizar pero se puede usar schema.nombre de tabla
--Pa saber
-- Limpieza
DROP TABLE IF EXISTS pago CASCADE;
DROP TABLE IF EXISTS producto_pedcli CASCADE;
DROP TABLE IF EXISTS pedidocliente CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

--Creación de usuarios:
CREATE ROLE usuario1 LOGIN PASSWORD 'lticPUCE24';
CREATE ROLE usuario2 LOGIN PASSWORD 'lticPUCE24';
CREATE SCHEMA taller AUTHORIZATION usuario1;

--Por si creé public
ALTER TABLE cliente SET SCHEMA taller;
ALTER TABLE pedidocliente SET SCHEMA taller;
ALTER TABLE producto SET SCHEMA taller;
ALTER TABLE producto_pedcli SET SCHEMA taller;
ALTER TABLE pago SET SCHEMA taller;

--Permisos
GRANT USAGE ON SCHEMA taller TO usuario2;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA taller
TO usuario2;

--Si se crea una nueva tabla hereda permisos
ALTER DEFAULT PRIVILEGES IN SCHEMA taller
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usuario2;


-- Tablas
CREATE TABLE cliente (
  cli_ced_ruc   VARCHAR(13) PRIMARY KEY,
  cli_nombre    VARCHAR(60),
  cli_direccion VARCHAR(60),
  cli_telefono  VARCHAR(15),
  cli_correo    VARCHAR(60)
);

CREATE TABLE pedidocliente (
  ped_numero   INTEGER PRIMARY KEY,
  cli_ced_ruc  VARCHAR(13) NOT NULL REFERENCES cliente(cli_ced_ruc),
  ped_fecha    DATE,
  ped_estado   VARCHAR(28)
);

CREATE TABLE producto (
  prd_codigo     VARCHAR(10) PRIMARY KEY,
  prd_nombre     VARCHAR(60),
  prd_precio     NUMERIC(10,2),
  prd_existencia NUMERIC(10,2) NOT NULL
);

CREATE TABLE producto_pedcli (
  prd_codigo  VARCHAR(10) NOT NULL REFERENCES producto(prd_codigo),
  ped_numero  INTEGER NOT NULL REFERENCES pedidocliente(ped_numero),
  ppc_cantidad NUMERIC(10,2),
  PRIMARY KEY (prd_codigo, ped_numero)
);

CREATE TABLE pago (
  pag_codigo VARCHAR(10) PRIMARY KEY,
  ped_numero INTEGER NOT NULL UNIQUE REFERENCES pedidocliente(ped_numero),
  pag_monto  NUMERIC(10,2),
  pag_fecha  DATE
);

-- Consistencia (regla negocio): existencia no negativa
ALTER TABLE producto
  ADD CONSTRAINT ck_producto_existencia_nonneg CHECK (prd_existencia >= 0);

--DATOS:
INSERT INTO taller.cliente VALUES 
('0102030405001','Juan Pérez','Av. Siempre Viva 123','0991112222','juan.perez@mail.com'),
('0102030405002','Ana Gómez','Calle Principal 456','0993334444','ana.gomez@mail.com'),
('0102030405003','Pedro Sánchez','Av. Amazonas 789','0995556666','pedro.sanchez@mail.com'),
('0102030405004','Luis Torres','Calle 1 234','0997778888','luis.torres@mail.com'),
('0102030405005','Sofía Morales','Calle 2 456','0999990000','sofia.morales@mail.com'),
('0102030405006','Carlos Ruiz','Av. Oriente 789','0981112222','carlos.ruiz@mail.com'),
('0102030405007','María López','Av. Central 123','0983334444','maria.lopez@mail.com'),
('0102030405008','Andrés Vega','Calle Secundaria 456','0985556666','andres.vega@mail.com'),
('0102030405009','Diana Ramírez','Av. Sur 789','0987778888','diana.ramirez@mail.com'),
('0102030405010','Jorge Salazar','Calle Oeste 123','0989990000','jorge.salazar@mail.com');


INSERT INTO taller.producto VALUES
('P001','Lápiz',0.50,100),
('P002','Cuaderno',1.20,200),
('P003','Borrador',0.30,150),
('P004','Bolígrafo',0.80,300),
('P005','Regla',0.60,100),
('P006','Tijera',1.50,50),
('P007','Pegamento',1.00,120),
('P008','Cartulina',0.90,80),
('P009','Marcador',1.20,70),
('P010','Crayones',2.50,60);


INSERT INTO taller.pedidocliente VALUES
(1,'0102030405001', CURRENT_DATE - INTERVAL '10 days','PENDIENTE'),
(2,'0102030405001', CURRENT_DATE - INTERVAL '9 days','PENDIENTE'),
(3,'0102030405001', CURRENT_DATE - INTERVAL '8 days','ENTREGADO'),
(4,'0102030405001', CURRENT_DATE - INTERVAL '7 days','CANCELADO'),
(5,'0102030405001', CURRENT_DATE - INTERVAL '6 days','PENDIENTE'),
(6,'0102030405002', CURRENT_DATE - INTERVAL '5 days','ENTREGADO'),
(7,'0102030405002', CURRENT_DATE - INTERVAL '4 days','PENDIENTE'),
(8,'0102030405002', CURRENT_DATE - INTERVAL '3 days','ENTREGADO'),
(9,'0102030405002', CURRENT_DATE - INTERVAL '2 days','CANCELADO'),
(10,'0102030405002', CURRENT_DATE - INTERVAL '1 days','PENDIENTE');


INSERT INTO taller.producto_pedcli VALUES
('P001',1,10),
('P002',1,5),
('P003',1,2),
('P004',1,8),
('P005',2,3),
('P006',2,1),
('P007',2,4),
('P008',2,6),
('P009',3,10),
('P010',3,5);


INSERT INTO taller.pago VALUES
('PAG001',1,50.00, CURRENT_DATE - INTERVAL '5 days'),
('PAG002',2,70.00, CURRENT_DATE - INTERVAL '4 days'),
('PAG003',3,100.00, CURRENT_DATE - INTERVAL '3 days'),
('PAG004',4,40.00, CURRENT_DATE - INTERVAL '2 days'),
('PAG005',5,60.00, CURRENT_DATE - INTERVAL '1 days');



CREATE TABLE bodega (
  bod_codigo      VARCHAR(4) PRIMARY KEY,
  bod_descripcion VARCHAR(60)
);

CREATE TABLE producto (
  prd_codigo      VARCHAR(12) PRIMARY KEY,
  prd_nombre      VARCHAR(60),
  prd_descripcion VARCHAR(200),
  prd_precio      NUMERIC(8,2),
  prd_existencia  NUMERIC(10,2)
);

CREATE TABLE bodega_producto (
  bod_codigo     VARCHAR(4),
  prd_codigo     VARCHAR(12),
  prb_existencia NUMERIC(10,2),
  CONSTRAINT pk_bodega_producto PRIMARY KEY (bod_codigo, prd_codigo),
  CONSTRAINT fk_bp_bodega   FOREIGN KEY (bod_codigo) REFERENCES bodega(bod_codigo),
  CONSTRAINT fk_bp_producto FOREIGN KEY (prd_codigo) REFERENCES producto(prd_codigo)
);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-
-- (opcional) si ya existen:
DROP SCHEMA IF EXISTS taller CASCADE;
DROP ROLE IF EXISTS usuario2;
DROP ROLE IF EXISTS usuario1;

--Roles
CREATE ROLE usuario1 LOGIN PASSWORD 'lticPUCE24';
CREATE ROLE usuario2 LOGIN PASSWORD 'lticPUCE24';

--Schema dueño: usuario1
CREATE SCHEMA taller AUTHORIZATION usuario1;

--para que usuario1 pueda crear objetos dentro del schema
GRANT USAGE, CREATE ON SCHEMA taller TO usuario1;

--para que usuario2 pueda usarlo
GRANT USAGE ON SCHEMA taller TO usuario2;

--Crear uneva conexión con usuario 1 desde servers mismo host

--En usuario 11111111
SET search_path TO taller;

CREATE TABLE cliente (
  cli_ced_ruc   VARCHAR(13) PRIMARY KEY,
  cli_nombre    VARCHAR(60),
  cli_direccion VARCHAR(60),
  cli_telefono  VARCHAR(15),
  cli_correo    VARCHAR(60)
);

CREATE TABLE pedidocliente (
  ped_numero   INTEGER PRIMARY KEY,
  cli_ced_ruc  VARCHAR(13) NOT NULL REFERENCES cliente(cli_ced_ruc),
  ped_fecha    DATE,
  ped_estado   VARCHAR(28)
);

CREATE TABLE producto (
  prd_codigo     VARCHAR(10) PRIMARY KEY,
  prd_nombre     VARCHAR(60),
  prd_precio     NUMERIC(10,2),
  prd_existencia NUMERIC(10,2) NOT NULL,
  CONSTRAINT ck_producto_existencia_nonneg CHECK (prd_existencia >= 0)
);

CREATE TABLE producto_pedcli (
  prd_codigo   VARCHAR(10) NOT NULL REFERENCES producto(prd_codigo),
  ped_numero   INTEGER NOT NULL REFERENCES pedidocliente(ped_numero),
  ppc_cantidad NUMERIC(10,2),
  PRIMARY KEY (prd_codigo, ped_numero)
);

CREATE TABLE pago (
  pag_codigo VARCHAR(10) PRIMARY KEY,
  ped_numero INTEGER NOT NULL UNIQUE REFERENCES pedidocliente(ped_numero),
  pag_monto  NUMERIC(10,2),
  pag_fecha  DATE
);

--Permisos para el usuario 2
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA taller TO usuario2;

ALTER DEFAULT PRIVILEGES IN SCHEMA taller GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usuario2;

--Datos
INSERT INTO taller.cliente VALUES 
('0102030405001','Juan Pérez','Av. Siempre Viva 123','0991112222','juan.perez@mail.com'),
('0102030405002','Ana Gómez','Calle Principal 456','0993334444','ana.gomez@mail.com'),
('0102030405003','Pedro Sánchez','Av. Amazonas 789','0995556666','pedro.sanchez@mail.com'),
('0102030405004','Luis Torres','Calle 1 234','0997778888','luis.torres@mail.com'),
('0102030405005','Sofía Morales','Calle 2 456','0999990000','sofia.morales@mail.com'),
('0102030405006','Carlos Ruiz','Av. Oriente 789','0981112222','carlos.ruiz@mail.com'),
('0102030405007','María López','Av. Central 123','0983334444','maria.lopez@mail.com'),
('0102030405008','Andrés Vega','Calle Secundaria 456','0985556666','andres.vega@mail.com'),
('0102030405009','Diana Ramírez','Av. Sur 789','0987778888','diana.ramirez@mail.com'),
('0102030405010','Jorge Salazar','Calle Oeste 123','0989990000','jorge.salazar@mail.com');


INSERT INTO taller.producto VALUES
('P001','Lápiz',0.50,100),
('P002','Cuaderno',1.20,200),
('P003','Borrador',0.30,150),
('P004','Bolígrafo',0.80,300),
('P005','Regla',0.60,100),
('P006','Tijera',1.50,50),
('P007','Pegamento',1.00,120),
('P008','Cartulina',0.90,80),
('P009','Marcador',1.20,70),
('P010','Crayones',2.50,60);


INSERT INTO taller.pedidocliente VALUES
(1,'0102030405001', CURRENT_DATE - INTERVAL '10 days','PENDIENTE'),
(2,'0102030405001', CURRENT_DATE - INTERVAL '9 days','PENDIENTE'),
(3,'0102030405001', CURRENT_DATE - INTERVAL '8 days','ENTREGADO'),
(4,'0102030405001', CURRENT_DATE - INTERVAL '7 days','CANCELADO'),
(5,'0102030405001', CURRENT_DATE - INTERVAL '6 days','PENDIENTE'),
(6,'0102030405002', CURRENT_DATE - INTERVAL '5 days','ENTREGADO'),
(7,'0102030405002', CURRENT_DATE - INTERVAL '4 days','PENDIENTE'),
(8,'0102030405002', CURRENT_DATE - INTERVAL '3 days','ENTREGADO'),
(9,'0102030405002', CURRENT_DATE - INTERVAL '2 days','CANCELADO'),
(10,'0102030405002', CURRENT_DATE - INTERVAL '1 days','PENDIENTE');


INSERT INTO taller.producto_pedcli VALUES
('P001',1,10),
('P002',1,5),
('P003',1,2),
('P004',1,8),
('P005',2,3),
('P006',2,1),
('P007',2,4),
('P008',2,6),
('P009',3,10),
('P010',3,5);


INSERT INTO taller.pago VALUES
('PAG001',1,50.00, CURRENT_DATE - INTERVAL '5 days'),
('PAG002',2,70.00, CURRENT_DATE - INTERVAL '4 days'),
('PAG003',3,100.00, CURRENT_DATE - INTERVAL '3 days'),
('PAG004',4,40.00, CURRENT_DATE - INTERVAL '2 days'),
('PAG005',5,60.00, CURRENT_DATE - INTERVAL '1 days');


--Realizar transacción
BEGIN;
SET search_path TO taller;

SELECT prd_codigo, prd_existencia
FROM producto
WHERE prd_codigo = 'P001';

UPDATE producto
SET prd_existencia = prd_existencia - 10
WHERE prd_codigo = 'P001';

--En usuario 2
BEGIN;
SET search_path TO taller;

UPDATE producto
SET prd_existencia = prd_existencia - 5
WHERE prd_codigo = 'P001';

--se puede usar SET lock_timeout = '5s'; para que no se quede colgando infinitamente pero es opcional
--de todas formas se libera con commit desde usuario 1

--En usuario 111111111111
commit; --:D



--MySQL:

--Este no vale no hice primera forma ----------------------------------------------------------------------------------------------------------------
--Ni segunda, hacer caso solo desde donde si vale, muy abajo, mas abajo
--Script:
-- Asegura InnoDB
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS producto_pedcli;
DROP TABLE IF EXISTS pedidocliente;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE cliente (
  cli_ced_ruc   VARCHAR(13) PRIMARY KEY,
  cli_nombre    VARCHAR(60),
  cli_direccion VARCHAR(60),
  cli_telefono  VARCHAR(15),
  cli_correo    VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE pedidocliente (
  ped_numero   INT PRIMARY KEY,
  cli_ced_ruc  VARCHAR(13) NOT NULL,
  ped_fecha    DATE,
  ped_estado   VARCHAR(28),
  CONSTRAINT fk_ped_cliente FOREIGN KEY (cli_ced_ruc) REFERENCES cliente(cli_ced_ruc)
) ENGINE=InnoDB;

CREATE TABLE producto (
  prd_codigo     VARCHAR(10) PRIMARY KEY,
  prd_nombre     VARCHAR(60),
  prd_precio     DECIMAL(10,2),
  prd_existencia DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE producto_pedcli (
  prd_codigo  VARCHAR(10) NOT NULL,
  ped_numero  INT NOT NULL,
  ppc_cantidad DECIMAL(10,2),
  PRIMARY KEY (prd_codigo, ped_numero),
  CONSTRAINT fk_ppc_prod FOREIGN KEY (prd_codigo) REFERENCES producto(prd_codigo),
  CONSTRAINT fk_ppc_ped  FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;

CREATE TABLE pago (
  pag_codigo VARCHAR(10) PRIMARY KEY,
  ped_numero INT NOT NULL UNIQUE,
  pag_monto  DECIMAL(10,2),
  pag_fecha  DATE,
  CONSTRAINT fk_pago_ped FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;

-- En MySQL 8+ funciona CHECK pero históricamente se ignoraba en versiones viejas.
-- Si tu profe usa MySQL 8, perfecto:
ALTER TABLE producto
  ADD CONSTRAINT ck_producto_existencia_nonneg CHECK (prd_existencia >= 0);


--Desde aqui--------------------------------------------------------------------------------------------------------------------------------------------------

--Conectarse a moba y poner:

mysql -u root -p
select user();  --verificar que sea un root
CREATE DATABASE IF NOT EXISTS taller;
use taller;

CREATE USER 'usuario1'@'%' IDENTIFIED BY 'lticPUCE24';
CREATE USER 'usuario2'@'%' IDENTIFIED BY 'Lt1cPUCE_2024!';

GRANT ALL PRIVILEGES ON taller.* TO 'usuario1'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON taller.* TO 'usuario2'@'%';

FLUSH PRIVILEGES;

--lo de arriba vale pero puedes empezar desde aquí y poner lo de abajo
--script
CREATE DATABASE IF NOT EXISTS taller;
USE taller;

DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS producto_pedcli;
DROP TABLE IF EXISTS pedidocliente;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
  cli_ced_ruc   VARCHAR(13) PRIMARY KEY,
  cli_nombre    VARCHAR(60),
  cli_direccion VARCHAR(60),
  cli_telefono  VARCHAR(15),
  cli_correo    VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE pedidocliente (
  ped_numero   INT PRIMARY KEY,
  cli_ced_ruc  VARCHAR(13) NOT NULL,
  ped_fecha    DATE,
  ped_estado   VARCHAR(28),
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (cli_ced_ruc) REFERENCES cliente(cli_ced_ruc)
) ENGINE=InnoDB;

CREATE TABLE producto (
  prd_codigo     VARCHAR(10) PRIMARY KEY,
  prd_nombre     VARCHAR(60),
  prd_precio     DECIMAL(10,2),
  prd_existencia DECIMAL(10,2) NOT NULL,
  CONSTRAINT ck_producto_existencia_nonneg CHECK (prd_existencia >= 0)
) ENGINE=InnoDB;

CREATE TABLE producto_pedcli (
  prd_codigo   VARCHAR(10) NOT NULL,
  ped_numero   INT NOT NULL,
  ppc_cantidad DECIMAL(10,2),
  PRIMARY KEY (prd_codigo, ped_numero),
  CONSTRAINT fk_ppc_producto
    FOREIGN KEY (prd_codigo) REFERENCES producto(prd_codigo),
  CONSTRAINT fk_ppc_pedido
    FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;

CREATE TABLE pago (
  pag_codigo VARCHAR(10) PRIMARY KEY,
  ped_numero INT NOT NULL UNIQUE,
  pag_monto  DECIMAL(10,2),
  pag_fecha  DATE,
  CONSTRAINT fk_pago_pedido
    FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;


--lo de abajo
CREATE USER 'usuario1'@'%' IDENTIFIED BY 'lticPUCE24';
CREATE USER 'usuario2'@'%' IDENTIFIED BY 'Lt1cPUCE_2024!';

GRANT ALL PRIVILEGES ON taller.* TO 'usuario1'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON taller.* TO 'usuario2'@'%';

FLUSH PRIVILEGES;

--termino lo de abajo
--Esta mal, no %, con localhost crear...

--Si está creado ningún usuario, verificar:
SELECT user, host, plugin
FROM mysql.user
WHERE user IN ('usuario1','usuario2');

CREATE USER IF NOT EXISTS 'usuario1'@'localhost' IDENTIFIED BY 'lticPUCE24';
CREATE USER IF NOT EXISTS 'usuario2'@'localhost' IDENTIFIED BY 'Lt1cPUCE_2024!';

GRANT ALL PRIVILEGES ON taller.* TO 'usuario1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON taller.* TO 'usuario2'@'localhost';

FLUSH PRIVILEGES;

--Si existía hacer:
ALTER USER 'usuario1'@'localhost' IDENTIFIED BY 'lticPUCE24';
ALTER USER 'usuario2'@'localhost' IDENTIFIED BY 'Lt1cPUCE_2024!';
FLUSH PRIVILEGES;

--Salir de MySQL y  en pesta;as del MOBA diferentes hacer>
--pestaña1: mysql -u usuario1 -p -D taller
--pestaña2: mysql -u usuario2 -p -D taller

--En usuario1
SELECT USER();
USE taller;

-- Recomendado para que no se te quede una transacción colgada
SET autocommit = 0;

-- Verifica modo aislamiento (solo para ver)
SELECT @@transaction_isolation;

--En usuario2
SELECT USER();
USE taller;

SET autocommit = 0;
SELECT @@transaction_isolation;


--Usuario1
START TRANSACTION;

-- Toma una fila y la bloquea para escritura (porque la estás actualizando)
UPDATE producto
SET prd_existencia = prd_existencia - 5
WHERE prd_codigo = 'P001';

-- NO HAGAS COMMIT todavía

--En usuario 2

START TRANSACTION;

UPDATE producto
SET prd_existencia = prd_existencia - 2
WHERE prd_codigo = 'P001';

SHOW FULL PROCESSLIST;

--En usuario1
COMMIT;


------------------------------------------------*-*-*-*-*-*-*-------------------------------------------------------------------------------------------------
AHORA SI TODO:

--Conectarse a moba
--Si está creado ningún usuario, verificar:
SELECT user, host, plugin
FROM mysql.user
WHERE user IN ('usuario1','usuario2');

CREATE USER IF NOT EXISTS 'usuario1'@'localhost' IDENTIFIED BY 'lticPUCE24';
CREATE USER IF NOT EXISTS 'usuario2'@'localhost' IDENTIFIED BY 'Lt1cPUCE_2024!';

GRANT ALL PRIVILEGES ON taller.* TO 'usuario1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON taller.* TO 'usuario2'@'localhost';

FLUSH PRIVILEGES;

--Si existía hacer:
ALTER USER 'usuario1'@'localhost' IDENTIFIED BY 'lticPUCE24';
ALTER USER 'usuario2'@'localhost' IDENTIFIED BY 'Lt1cPUCE_2024!';
FLUSH PRIVILEGES;

--Salir de MySQL y  en pesta;as del MOBA diferentes hacer>
--pestaña1: mysql -u usuario1 -p -D taller -A
--pestaña2: mysql -u usuario2 -p -D taller -A

--En usuario1
SELECT USER();
USE taller;

--Creación de tablas:
CREATE DATABASE IF NOT EXISTS taller;
USE taller;

DROP TABLE IF EXISTS producto;

CREATE TABLE producto (
  prd_codigo VARCHAR(10) PRIMARY KEY,
  prd_nombre VARCHAR(60),
  prd_precio DECIMAL(10,2),
  prd_existencia DECIMAL(10,2) NOT NULL,
  CONSTRAINT ck_producto_existencia CHECK (prd_existencia >= 0)
) ENGINE=InnoDB;

INSERT INTO producto VALUES
('P001','Lápiz',0.50,100),
('P002','Cuaderno',1.20,200),
('P003','Borrador',0.30,150);

COMMIT;


-------------------------------------------------------------------*-*-*--*-*-------------------------------------------------
--Si se tiene diferentes conexiones o remotas, no locales, no localhost, sino %,en root se debería crear:

DROP USER IF EXISTS 'usuario1'@'localhost';
DROP USER IF EXISTS 'usuario2'@'localhost';
FLUSH PRIVILEGES;


ALTER USER 'usuario1'@'%' IDENTIFIED WITH mysql_native_password BY 'Lt1cPUCE_2024!';
ALTER USER 'usuario2'@'%' IDENTIFIED WITH mysql_native_password BY 'Lt1cPUCE_2024!';
FLUSH PRIVILEGES;


SELECT user, host, plugin
FROM mysql.user
WHERE user IN ('usuario1','usuario2')
ORDER BY user, host;

--Asegurarse que ambos tengan grants
SHOW GRANTS FOR 'usuario2'@'%';

--Dar permisos
GRANT SELECT, INSERT, UPDATE, DELETE ON taller.* TO 'usuario2'@'%';
FLUSH PRIVILEGES;


--CONECTARSE A WORKBENCH con:
Host: IP 
Usuario: usuario1 o usuario2
Contraseña puesta
Schema: taller

--Script desde el schema en usuario 1 con datos puestos y comprobación
--Con suerte no se pierde la conexión...
-- Asegúrate de estar en el schema correcto
CREATE DATABASE IF NOT EXISTS taller;
USE taller;

-- Limpieza (en orden por FKs)
DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS producto_pedcli;
DROP TABLE IF EXISTS pedidocliente;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;

-- Tablas
CREATE TABLE cliente (
  cli_ced_ruc   VARCHAR(13) PRIMARY KEY,
  cli_nombre    VARCHAR(60),
  cli_direccion VARCHAR(60),
  cli_telefono  VARCHAR(15),
  cli_correo    VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE pedidocliente (
  ped_numero   INT PRIMARY KEY,
  cli_ced_ruc  VARCHAR(13) NOT NULL,
  ped_fecha    DATE,
  ped_estado   VARCHAR(28),
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (cli_ced_ruc) REFERENCES cliente(cli_ced_ruc)
) ENGINE=InnoDB;

CREATE TABLE producto (
  prd_codigo     VARCHAR(10) PRIMARY KEY,
  prd_nombre     VARCHAR(60),
  prd_precio     DECIMAL(10,2),
  prd_existencia DECIMAL(10,2) NOT NULL,
  CONSTRAINT ck_producto_existencia_nonneg CHECK (prd_existencia >= 0)
) ENGINE=InnoDB;

CREATE TABLE producto_pedcli (
  prd_codigo   VARCHAR(10) NOT NULL,
  ped_numero   INT NOT NULL,
  ppc_cantidad DECIMAL(10,2),
  PRIMARY KEY (prd_codigo, ped_numero),
  CONSTRAINT fk_ppc_producto
    FOREIGN KEY (prd_codigo) REFERENCES producto(prd_codigo),
  CONSTRAINT fk_ppc_pedido
    FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;

CREATE TABLE pago (
  pag_codigo VARCHAR(10) PRIMARY KEY,
  ped_numero INT NOT NULL UNIQUE,
  pag_monto  DECIMAL(10,2),
  pag_fecha  DATE,
  CONSTRAINT fk_pago_pedido
    FOREIGN KEY (ped_numero) REFERENCES pedidocliente(ped_numero)
) ENGINE=InnoDB;

-- =========================
-- DATOS (TODOS los que enviaste)
-- =========================

INSERT INTO cliente VALUES
('0102030405001', 'Juan Pérez', 'Av. Siempre Viva 123', '0991112222', 'juan.perez@mail.com'),
('0102030405002', 'Ana Gómez', 'Calle Principal 456', '0993334444', 'ana.gomez@mail.com'),
('0102030405003', 'Pedro Sánchez', 'Av. Amazonas 789', '0995556666', 'pedro.sanchez@mail.com'),
('0102030405004', 'Luis Torres', 'Calle 1 234', '0997778888', 'luis.torres@mail.com'),
('0102030405005', 'Sofía Morales', 'Calle 2 456', '0999990000', 'sofia.morales@mail.com'),
('0102030405006', 'Carlos Ruiz', 'Av. Oriente 789', '0981112222', 'carlos.ruiz@mail.com'),
('0102030405007', 'María López', 'Av. Central 123', '0983334444', 'maria.lopez@mail.com'),
('0102030405008', 'Andrés Vega', 'Calle Secundaria 456', '0985556666', 'andres.vega@mail.com'),
('0102030405009', 'Diana Ramírez', 'Av. Sur 789', '0987778888', 'diana.ramirez@mail.com'),
('0102030405010', 'Jorge Salazar', 'Calle Oeste 123', '0989990000', 'jorge.salazar@mail.com'),
('0102030405011', 'Paola Ortiz', 'Av. Norte 234', '0971112222', 'paola.ortiz@mail.com'),
('0102030405012', 'David Cordero', 'Av. Centro 345', '0973334444', 'david.cordero@mail.com'),
('0102030405013', 'Camila Herrera', 'Calle Este 456', '0975556666', 'camila.herrera@mail.com'),
('0102030405014', 'Ricardo Vaca', 'Av. Central 567', '0977778888', 'ricardo.vaca@mail.com'),
('0102030405015', 'Laura Fernández', 'Calle Nueva 678', '0979990000', 'laura.fernandez@mail.com'),
('0102030405016', 'Felipe Benítez', 'Av. Lateral 123', '0961112222', 'felipe.benitez@mail.com'),
('0102030405017', 'Isabel Castillo', 'Av. Esquina 234', '0963334444', 'isabel.castillo@mail.com'),
('0102030405018', 'Diego Mendoza', 'Calle Norte 345', '0965556666', 'diego.mendoza@mail.com'),
('0102030405019', 'Rosa Guzmán', 'Av. Sur 456', '0967778888', 'rosa.guzman@mail.com'),
('0102030405020', 'Tomás Paredes', 'Calle Céntrica 567', '0969990000', 'tomas.paredes@mail.com');

INSERT INTO producto (prd_codigo, prd_nombre, prd_precio, prd_existencia) VALUES
('P001', 'Lápiz', 0.50, 100),
('P002', 'Cuaderno', 1.20, 200),
('P003', 'Borrador', 0.30, 150),
('P004', 'Bolígrafo', 0.80, 300),
('P005', 'Regla', 0.60, 100),
('P006', 'Tijera', 1.50, 50),
('P007', 'Pegamento', 1.00, 120),
('P008', 'Cartulina', 0.90, 80),
('P009', 'Marcador', 1.20, 70),
('P010', 'Crayones', 2.50, 60),
('P011', 'Sacapuntas', 0.40, 250),
('P012', 'Hojas', 0.10, 500),
('P013', 'Carpeta', 1.80, 40),
('P014', 'Plumones', 2.00, 35),
('P015', 'Corrector', 1.10, 90),
('P016', 'Cuadro', 3.00, 15),
('P017', 'Libro', 5.00, 20),
('P018', 'Bloc', 1.90, 30),
('P019', 'Cinta Adhesiva', 0.70, 300),
('P020', 'Papel Bond', 2.80, 70),
('P021', 'Calculadora', 12.00, 15),
('P022', 'USB', 10.00, 50),
('P023', 'Disco Duro', 70.00, 10),
('P024', 'Mouse', 5.00, 40),
('P025', 'Teclado', 8.00, 20),
('P026', 'Monitor', 120.00, 5),
('P027', 'CPU', 350.00, 5),
('P028', 'Silla', 85.00, 10),
('P029', 'Escritorio', 150.00, 3),
('P030', 'Mochila', 25.00, 25);

INSERT INTO pedidocliente (ped_numero, cli_ced_ruc, ped_fecha, ped_estado) VALUES
(1, '0102030405001', CURDATE() - INTERVAL 10 DAY, 'PENDIENTE'),
(2, '0102030405001', CURDATE() - INTERVAL 9 DAY,  'PENDIENTE'),
(3, '0102030405001', CURDATE() - INTERVAL 8 DAY,  'ENTREGADO'),
(4, '0102030405001', CURDATE() - INTERVAL 7 DAY,  'CANCELADO'),
(5, '0102030405001', CURDATE() - INTERVAL 6 DAY,  'PENDIENTE'),
(6, '0102030405002', CURDATE() - INTERVAL 5 DAY,  'ENTREGADO'),
(7, '0102030405002', CURDATE() - INTERVAL 4 DAY,  'PENDIENTE'),
(8, '0102030405002', CURDATE() - INTERVAL 3 DAY,  'ENTREGADO'),
(9, '0102030405002', CURDATE() - INTERVAL 2 DAY,  'CANCELADO'),
(10,'0102030405002', CURDATE() - INTERVAL 1 DAY,  'PENDIENTE'),
(11,'0102030405003', CURDATE() - INTERVAL 10 DAY, 'PENDIENTE'),
(12,'0102030405003', CURDATE() - INTERVAL 9 DAY,  'PENDIENTE'),
(13,'0102030405003', CURDATE() - INTERVAL 8 DAY,  'ENTREGADO'),
(14,'0102030405004', CURDATE() - INTERVAL 7 DAY,  'CANCELADO'),
(15,'0102030405004', CURDATE() - INTERVAL 6 DAY,  'PENDIENTE'),
(16,'0102030405004', CURDATE() - INTERVAL 5 DAY,  'ENTREGADO'),
(17,'0102030405005', CURDATE() - INTERVAL 4 DAY,  'PENDIENTE'),
(18,'0102030405005', CURDATE() - INTERVAL 3 DAY,  'ENTREGADO'),
(19,'0102030405005', CURDATE() - INTERVAL 2 DAY,  'CANCELADO'),
(20,'0102030405005', CURDATE() - INTERVAL 1 DAY,  'PENDIENTE');

INSERT INTO producto_pedcli (prd_codigo, ped_numero, ppc_cantidad) VALUES
('P001', 1, 10.00),
('P002', 1, 5.00),
('P003', 1, 2.00),
('P004', 1, 8.00),
('P005', 2, 3.00),
('P006', 2, 1.00),
('P007', 2, 4.00),
('P008', 2, 6.00),
('P009', 3, 10.00),
('P010', 3, 5.00),
('P011', 3, 2.00),
('P012', 3, 8.00),
('P013', 4, 3.00),
('P014', 4, 1.00),
('P015', 4, 4.00),
('P016', 4, 6.00);

INSERT INTO pago (pag_codigo, ped_numero, pag_monto, pag_fecha) VALUES
('PAG001', 1, 50.00, CURDATE() - INTERVAL 5 DAY),
('PAG002', 2, 70.00, CURDATE() - INTERVAL 4 DAY),
('PAG003', 3, 100.00, CURDATE() - INTERVAL 3 DAY),
('PAG004', 4, 40.00, CURDATE() - INTERVAL 2 DAY),
('PAG005', 5, 60.00, CURDATE() - INTERVAL 1 DAY),
('PAG006', 6, 50.00, CURDATE() - INTERVAL 6 DAY),
('PAG007', 7, 70.00, CURDATE() - INTERVAL 7 DAY),
('PAG008', 8, 100.00, CURDATE() - INTERVAL 8 DAY),
('PAG009', 9, 40.00, CURDATE() - INTERVAL 9 DAY),
('PAG010',10, 60.00, CURDATE() - INTERVAL 10 DAY);

-- Verificación rápida
SELECT COUNT(*) AS clientes FROM cliente;
SELECT COUNT(*) AS productos FROM producto;
SELECT COUNT(*) AS pedidos FROM pedidocliente;
SELECT COUNT(*) AS detalle FROM producto_pedcli;
SELECT COUNT(*) AS pagos FROM pago;

--USUARIO 1
--Transaccion
USE taller;
SET autocommit = 0;
SELECT @@transaction_isolation;

START TRANSACTION;

UPDATE producto
SET prd_existencia = prd_existencia - 3
WHERE prd_codigo = 'P001';

SELECT prd_codigo, prd_existencia
FROM producto
WHERE prd_codigo = 'P001';


--USUSRIO2
START TRANSACTION;
UPDATE producto
SET prd_existencia = prd_existencia - 5
WHERE prd_codigo = 'P001';

SHOW FULL PROCESSLIST;

--En usuario 1
COMMIT;

	

