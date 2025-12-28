--4.1.2 TALLER ACID
--En MySQL y PostgreSQL

--MySQL:
--===========0.PREPARACION(MYSQL)===========
--(ejecutarcomo root)
DROP DATABASE IF EXISTS taller;
CREATE DATABASE taller;
USE taller;

DROP USER IF EXISTS 'usuario1'@'%';
DROP USER IF EXISTS 'usuario2'@'%';
CREATE USER 'usuario1'@'%' IDENTIFIED BY 'Lt1cPUCE_2024!';
CREATE USER 'usuario2'@'%' IDENTIFIED BY 'Lt1cPUCE_2024!';
GRANT ALL PRIVILEGES ON taller.* TO 'usuario1'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE ON taller.* TO 'usuario2'@'%';
FLUSH PRIVILEGES;

--===========1.TABLAS===========
DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS producto_pedcli;
DROP TABLE IF EXISTS pedidocliente;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente(
cli_ced_ruc VARCHAR(13) PRIMARY KEY,
cli_nombre VARCHAR(60),
cli_direccion VARCHAR(60),
cli_telefono VARCHAR(15),
cli_correo VARCHAR(60)
)ENGINE=InnoDB;

CREATE TABLE pedidocliente(
ped_numero INT PRIMARY KEY,
cli_ced_ruc VARCHAR(13) NOT NULL,
ped_fecha DATE,
ped_estado VARCHAR(28),
CONSTRAINT fk_pedido_cliente FOREIGN KEY(cli_ced_ruc) REFERENCES cliente(cli_ced_ruc)
)ENGINE=InnoDB;

CREATE TABLE producto(
prd_codigo VARCHAR(10) PRIMARY KEY,
prd_nombre VARCHAR(60),
prd_precio DECIMAL(10,2),
prd_existencia DECIMAL(10,2) NOT NULL,
CONSTRAINT ck_producto_existencia_nonneg CHECK(prd_existencia>=0)
)ENGINE=InnoDB;

CREATE TABLE producto_pedcli(
prd_codigo VARCHAR(10) NOT NULL,
ped_numero INT NOT NULL,
ppc_cantidad DECIMAL(10,2),
PRIMARY KEY(prd_codigo,ped_numero),
CONSTRAINT fk_ppc_producto FOREIGN KEY(prd_codigo) REFERENCES producto(prd_codigo),
CONSTRAINT fk_ppc_pedido FOREIGN KEY(ped_numero) REFERENCES pedidocliente(ped_numero)
)ENGINE=InnoDB;

CREATE TABLE pago(
pag_codigo VARCHAR(10) PRIMARY KEY,
ped_numero INT NOT NULL UNIQUE,
pag_monto DECIMAL(10,2),
pag_fecha DATE,
CONSTRAINT fk_pago_pedido FOREIGN KEY(ped_numero) REFERENCES pedidocliente(ped_numero)
)ENGINE=InnoDB;

--===========2.DATOS(MINIMO)===========
INSERT INTO cliente VALUES
('0102030405001','Juan Pérez','Av. Siempre Viva 123','0991112222','juan.perez@mail.com');

INSERT INTO producto VALUES
('P001','Lápiz',0.50,100),
('P006','Tijera',1.50,50);

INSERT INTO pedidocliente VALUES
(21,'0102030405001',CURDATE(),'PENDIENTE');

--===========O mejor usar estos===============--------------
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


--=======================================================
--===========ATOMICIDAD(MYSQL)===========
USE taller;
SET autocommit=0;
START TRANSACTION;

SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo IN('P001','P006');

--venta posible
UPDATE producto SET prd_existencia=prd_existencia-10 WHERE prd_codigo='P001';

--venta imposible(forzar error por regla de negocio manual)
--si no tienes SP aún,simula el error:
UPDATE producto SET prd_existencia=prd_existencia-9999 WHERE prd_codigo='P006';

--si tu motor deja hacerlo,forzamos rollback manual:
ROLLBACK;

SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo IN('P001','P006');


--===========CONSISTENCIA(MYSQL):SP===========
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_actualiza_existencia $$
CREATE PROCEDURE sp_actualiza_existencia(p_prd VARCHAR(10),p_cant DECIMAL(10,2))
BEGIN
DECLARE v_exist DECIMAL(10,2);
START TRANSACTION;
SELECT prd_existencia INTO v_exist
FROM producto
WHERE prd_codigo=p_prd
FOR UPDATE;

IF v_exist<p_cant THEN
ROLLBACK;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=CONCAT('No hay existencia suficiente:',p_prd);
END IF;

UPDATE producto SET prd_existencia=v_exist-p_cant WHERE prd_codigo=p_prd;
COMMIT;
END $$

DELIMITER ;

--En usuario 22222222222222
--===========PRUEBA(CONSISTENCIA)===========
CALL sp_actualiza_existencia('P001',10);
CALL sp_actualiza_existencia('P006',9999); --debe fallar y no cambiar nada
SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo IN('P001','P006');



--===========AISLAMIENTO(MYSQL):USUARIO1===========
USE taller;
SET autocommit=0;
START TRANSACTION;

SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo='P001';
UPDATE producto SET prd_existencia=prd_existencia-10 WHERE prd_codigo='P001';

--NO COMMIT AUN
SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo='P001';


--===========AISLAMIENTO(MYSQL):USUARIO2===========
USE taller;
SELECT prd_codigo,prd_existencia FROM producto WHERE prd_codigo='P001'; --lee valor anterior
START TRANSACTION;
UPDATE producto SET prd_existencia=prd_existencia-5 WHERE prd_codigo='P001'; --queda esperando


--En usuario 11111111111111
COMMIT; --libera lock



---EN POSTGRESQL ===========================================================================================
--===========0.PREPARACION(POSTGRES)===========
--(con superuser,ej:postgres)
DROP ROLE IF EXISTS usuario1;
DROP ROLE IF EXISTS usuario2;
CREATE ROLE usuario1 LOGIN PASSWORD 'lticPUCE24';
CREATE ROLE usuario2 LOGIN PASSWORD 'lticPUCE24';

DROP SCHEMA IF EXISTS taller CASCADE;
CREATE SCHEMA taller AUTHORIZATION usuario1;

GRANT USAGE ON SCHEMA taller TO usuario2;

--===========1.TABLAS===========
SET search_path TO taller;

CREATE TABLE cliente(
cli_ced_ruc VARCHAR(13) PRIMARY KEY,
cli_nombre VARCHAR(60),
cli_direccion VARCHAR(60),
cli_telefono VARCHAR(15),
cli_correo VARCHAR(60)
);

CREATE TABLE pedidocliente(
ped_numero INTEGER PRIMARY KEY,
cli_ced_ruc VARCHAR(13) NOT NULL REFERENCES cliente(cli_ced_ruc),
ped_fecha DATE,
ped_estado VARCHAR(28)
);

CREATE TABLE producto(
prd_codigo VARCHAR(10) PRIMARY KEY,
prd_nombre VARCHAR(60),
prd_precio NUMERIC(10,2),
prd_existencia NUMERIC(10,2) NOT NULL,
CONSTRAINT ck_producto_existencia_nonneg CHECK(prd_existencia>=0)
);

CREATE TABLE producto_pedcli(
prd_codigo VARCHAR(10) NOT NULL REFERENCES producto(prd_codigo),
ped_numero INTEGER NOT NULL REFERENCES pedidocliente(ped_numero),
ppc_cantidad NUMERIC(10,2),
PRIMARY KEY(prd_codigo,ped_numero)
);

CREATE TABLE pago(
pag_codigo VARCHAR(10) PRIMARY KEY,
ped_numero INTEGER NOT NULL UNIQUE REFERENCES pedidocliente(ped_numero),
pag_monto NUMERIC(10,2),
pag_fecha DATE
);

--permisos usuario2
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA taller TO usuario2;
ALTER DEFAULT PRIVILEGES IN SCHEMA taller GRANT SELECT,INSERT,UPDATE,DELETE ON TABLES TO usuario2;

--===========2.DATOS(MINIMO)===========
INSERT INTO cliente VALUES('0102030405001','Juan Pérez','Av. Siempre Viva 123','0991112222','juan.perez@mail.com');
INSERT INTO producto VALUES('P001','Lápiz',0.50,100),('P006','Tijera',1.50,50);
INSERT INTO pedidocliente VALUES(21,'0102030405001',CURRENT_DATE,'PENDIENTE');

--------------Datos aca también
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

--INICIOOOOOOOOOO

--===========ATOMICIDAD(POSTGRES):ANONIMO===========
BEGIN;
DO $$
BEGIN
UPDATE taller.producto SET prd_existencia=prd_existencia-10 WHERE prd_codigo='P001';
--forzar error por check (o por excepción manual)
IF (SELECT prd_existencia FROM taller.producto WHERE prd_codigo='P006')<9999 THEN
RAISE EXCEPTION 'No hay stock suficiente para P006';
END IF;
UPDATE taller.producto SET prd_existencia=prd_existencia-9999 WHERE prd_codigo='P006';
END $$;
COMMIT;
--si hubo error,no llega a COMMIT
ROLLBACK;

SELECT prd_codigo,prd_existencia FROM taller.producto WHERE prd_codigo IN('P001','P006');


--
--===========CONSISTENCIA(POSTGRES):FUNCION===========
CREATE OR REPLACE FUNCTION taller.actualiza_existencia(p_prd VARCHAR,p_cant NUMERIC)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE v_exist NUMERIC;
BEGIN
SELECT prd_existencia INTO v_exist
FROM taller.producto
WHERE prd_codigo=p_prd
FOR UPDATE;

IF v_exist<p_cant THEN
RAISE EXCEPTION 'No hay existencia suficiente:%',p_prd;
END IF;

UPDATE taller.producto
SET prd_existencia=v_exist-p_cant
WHERE prd_codigo=p_prd;
END $$;

GRANT EXECUTE ON FUNCTION taller.actualiza_existencia(VARCHAR,NUMERIC) TO usuario2;



--En usuario2 comprobar
BEGIN;
SELECT taller.actualiza_existencia('P001',10);
COMMIT;

BEGIN;
SELECT taller.actualiza_existencia('P006',9999);
ROLLBACK;





----AISLAMINETO
--Usuario1
BEGIN;
SET search_path TO taller;
UPDATE producto SET prd_existencia=prd_existencia-10 WHERE prd_codigo='P001';
--sin commit


--Uusario 2
BEGIN;
SET search_path TO taller;
SELECT prd_existencia FROM producto WHERE prd_codigo='P001'; --ve valor anterior
UPDATE producto SET prd_existencia=prd_existencia-5 WHERE prd_codigo='P001'; --queda esperando

--U1
COMMIT;


