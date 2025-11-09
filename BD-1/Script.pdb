-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;
/

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger TDB_BODEGA
/

drop trigger TIB_BODEGA
/

drop trigger TUB_BODEGA
/

drop trigger TDB_CATEGORIA_PRODUCTO
/

drop trigger TUB_CATEGORIA_PRODUCTO
/

drop trigger TDB_CIUDAD
/

drop trigger TIB_CIUDAD
/

drop trigger TUB_CIUDAD
/

drop trigger TDB_CLIENTE
/

drop trigger TIB_CLIENTE
/

drop trigger TUB_CLIENTE
/

drop trigger TIB_CLIENTE_EMPLEADO
/

drop trigger TUB_CLIENTE_EMPLEADO
/

drop trigger TIB_COMISION_VENTA
/

drop trigger TUB_COMISION_VENTA
/

drop trigger TDB_DEPARTAMENTO
/

drop trigger TIB_DEPARTAMENTO
/

drop trigger TUA_DEPARTAMENTO
/

drop trigger TUB_DEPARTAMENTO
/

drop trigger TIB_DETALLE_FACTURA
/

drop trigger TUB_DETALLE_FACTURA
/

drop trigger TDB_EMPLEADO
/

drop trigger TIB_EMPLEADO
/

drop trigger TUB_EMPLEADO
/

drop trigger TDB_EMPRESA
/

drop trigger TUA_EMPRESA
/

drop trigger TDB_FACTURA
/

drop trigger TIB_FACTURA
/

drop trigger TUB_FACTURA
/

drop trigger TDB_FORMA_PAGO
/

drop trigger TUB_FORMA_PAGO
/

drop trigger TIB_FRM_PAGO_FACTURA
/

drop trigger TUB_FRM_PAGO_FACTURA
/

drop trigger TIB_MOVIMIENTO_BODEGA
/

drop trigger TUB_MOVIMIENTO_BODEGA
/

drop trigger TDB_ORDEN_COMPRA
/

drop trigger TIB_ORDEN_COMPRA
/

drop trigger TUB_ORDEN_COMPRA
/

drop trigger TIB_PRODUCTO_PROMOCION
/

drop trigger TUB_PRODUCTO_PROMOCION
/

drop trigger TIB_PRODUCTO_PROVEEDOR
/

drop trigger TUB_PRODUCTO_PROVEEDOR
/

drop trigger TDB_PRODUCTO
/

drop trigger TIB_PRODUCTO
/

drop trigger TUB_PRODUCTO
/

drop trigger TIB_PRODUCTO_BODEGA
/

drop trigger TUB_PRODUCTO_BODEGA
/

drop trigger TIB_PRODUCTO_ORDEN_COMPRA
/

drop trigger TUB_PRODUCTO_ORDEN_COMPRA
/

drop trigger TDB_PROMOCION
/

drop trigger TUB_PROMOCION
/

drop trigger TIB_PROMOC_SUCURSAL
/

drop trigger TUB_PROMOC_SUCURSAL
/

drop trigger TDB_PROVEEDOR
/

drop trigger TUB_PROVEEDOR
/

drop trigger TDB_PROVINCIA
/

drop trigger TUB_PROVINCIA
/

drop trigger TDB_SUCURSAL
/

drop trigger TIB_SUCURSAL
/

drop trigger TUB_SUCURSAL
/

drop trigger TDB_TRANSACCION
/

drop trigger TUB_TRANSACCION
/

drop trigger TIB_UNIDAD_ALTERNATIVA
/

drop trigger TUB_UNIDAD_ALTERNATIVA
/

drop trigger TDB_UNIDAD_MEDIDA
/

drop trigger TUB_UNIDAD_MEDIDA
/

drop index SUCURSAL_BODEGA_FK
/

drop table BODEGA cascade constraints
/

drop table CATEG_PRODUCTO cascade constraints
/

drop index PROVINCIA_CIUDAD_FK
/

drop table CIUDAD cascade constraints
/

drop index EMPRESA_CLIENTE_FK
/

drop table CLIENTE cascade constraints
/

drop index CLIENTE_CLI_EMPLE_FK
/

drop index EMPLEADO_CLIE_EMP_FK
/

drop table CLIENTE_EMPLEADO cascade constraints
/

drop index FACTURA_COMIS_VENTA2_FK
/

drop index EMPLE_COMI_VENTA_FK
/

drop table COMISION_VENTA cascade constraints
/

drop index EMPRESA_DEPARTA_FK
/

drop table DEPARTAMENTO cascade constraints
/

drop index FACTURA_DETA_FAC_FK
/

drop index PRODUCTO_DETA_FACT_FK
/

drop table DETALLE_FACTURA cascade constraints
/

drop index DEPARTA_EMPLEADO_FK
/

drop index SUCURSAL_EMPLEADO_FK
/

drop table EMPLEADO cascade constraints
/

drop table EMPRESA cascade constraints
/

drop index CLIENTE_FACTURA_FK
/

drop index SUCURSAL_FACTURA_FK
/

drop table FACTURA cascade constraints
/

drop table FORMA_PAGO cascade constraints
/

drop index FACTURA_FRM_PAGO_FAC_FK
/

drop index FOR_PAGO_FRM_PAG_FAC_FK
/

drop table FRM_PAGO_FACTURA cascade constraints
/

drop index PROD_MOVI_BOD_FK
/

drop index TRANS_MOV_BODE_FK
/

drop table MOVIMIENTO_BODEGA cascade constraints
/

drop index PROVEEDOR_ORDEN_COMPRA_FK
/

drop index SUCURSAL_ORDEN_COMPRA_FK
/

drop table ORDEN_COMPRA cascade constraints
/

drop index PROD_PROD_PROMO_FK
/

drop table PRD_PROMOCION cascade constraints
/

drop index PRODUCTO_PROD_PROVEE_FK
/

drop index PROVEE_TIENE_PRD_PROV_FK
/

drop table PRD_PROVEEDOR cascade constraints
/

drop index CATEG_PROD_PRODUCTO_FK
/

drop table PRODUCTO cascade constraints
/

drop index BODEGA_PRD_BODEGA_FK
/

drop index PRODUCTO_PRD_BODEGA_FK
/

drop table PROD_BODEGA cascade constraints
/

drop index ORD_COMP_PRD_ORD_COMP_FK
/

drop index PRODUCTO_PRO_ORD_COM_FK
/

drop table PROD_ORDEN_COMPRA cascade constraints
/

drop table PROMOCION cascade constraints
/

drop index PROMOCION_PROM_SUC_FK
/

drop index SUCURSAL_PROMO_SUUC_FK
/

drop table PROMOC_SUCURSAL cascade constraints
/

drop table PROVEEDOR cascade constraints
/

drop table PROVINCIA cascade constraints
/

drop index CIUDAD_SUCURSAL_FK
/

drop index EMPRESA_SUCURSAL_FK
/

drop table SUCURSAL cascade constraints
/

drop table TRANSACCION cascade constraints
/

drop index PROD_UNI_MED_ALT_FK
/

drop index UNID_MED_UNID_ALTER_FK
/

drop table UNIDAD_ALTERNATIVA cascade constraints
/

drop table UNIDAD_MEDIDA cascade constraints
/


/*==============================================================*/
/* Table: BODEGA                                                */
/*==============================================================*/
create table BODEGA (
   BOD__CODIGO          VARCHAR2(3)           not null
      constraint CKC_BOD__CODIGO_BODEGA check (BOD__CODIGO = upper(BOD__CODIGO)),
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_BODEGA check (SUC_CODIGO = upper(SUC_CODIGO)),
   BOD_DESCRIPCION      VARCHAR2(60)        
      constraint CKC_BOD_DESCRIPCION_BODEGA check (BOD_DESCRIPCION is null or (BOD_DESCRIPCION = upper(BOD_DESCRIPCION))),
   constraint PK_BODEGA primary key (BOD__CODIGO)
)
   tablespace DATOS
/

comment on table BODEGA is
'Tabla que contiene la información general de una bodega'
/

comment on column BODEGA.BOD__CODIGO is
'Código único de la bodega'
/

comment on column BODEGA.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column BODEGA.BOD_DESCRIPCION is
'Descripción o nombre de la bodega'
/

/*==============================================================*/
/* Index: SUCURSAL_BODEGA_FK                                    */
/*==============================================================*/
create index SUCURSAL_BODEGA_FK on BODEGA (
   SUC_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: CATEG_PRODUCTO                                        */
/*==============================================================*/
create table CATEG_PRODUCTO (
   CAT_CODIGO           VARCHAR2(4)           not null
      constraint CKC_CAT_CODIGO_CATEG_PR check (CAT_CODIGO = upper(CAT_CODIGO)),
   CAT_DESCRIPCION      VARCHAR2(60)        
      constraint CKC_CAT_DESCRIPCION_CATEG_PR check (CAT_DESCRIPCION is null or (CAT_DESCRIPCION = upper(CAT_DESCRIPCION))),
   constraint PK_CATEG_PRODUCTO primary key (CAT_CODIGO)
)
   tablespace DATOS
/

comment on table CATEG_PRODUCTO is
'Tabla que contiene las categorías que a las que pertenece un producto'
/

comment on column CATEG_PRODUCTO.CAT_CODIGO is
'Código único de la categoría del producto'
/

comment on column CATEG_PRODUCTO.CAT_DESCRIPCION is
'Descripción o nombre de la categoría'
/

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   CIU_NUMERO           NUMBER(3)             not null
      constraint CKC_CIU_NUMERO_CIUDAD check (CIU_NUMERO between 1 and 225),
   PRV_NUMERO           NUMBER(2)             not null
      constraint CKC_PRV_NUMERO_CIUDAD check (PRV_NUMERO between 1 and 27),
   CIU_NOMBRE           VARCHAR2(60)        
      constraint CKC_CIU_NOMBRE_CIUDAD check (CIU_NOMBRE is null or (CIU_NOMBRE = upper(CIU_NOMBRE))),
   constraint PK_CIUDAD primary key (CIU_NUMERO)
)
   tablespace DATOS
/

comment on table CIUDAD is
'Tabla que contiene información de las ciudades en las que funciona la empresa'
/

comment on column CIUDAD.CIU_NUMERO is
'Código único identificador de la ciudad'
/

comment on column CIUDAD.PRV_NUMERO is
'Código único identificador de la provincia'
/

comment on column CIUDAD.CIU_NOMBRE is
'Nombre de la ciudad'
/

/*==============================================================*/
/* Index: PROVINCIA_CIUDAD_FK                                   */
/*==============================================================*/
create index PROVINCIA_CIUDAD_FK on CIUDAD (
   PRV_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLI_NUM_DOCUMENTO    VARCHAR2(13)          not null,
   EMP_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_EMP_CEDULA_RUC_CLIENTE check (EMP_CEDULA_RUC = upper(EMP_CEDULA_RUC)),
   CLI_TIPO_DOCUMENTO   VARCHAR2(1)         
      constraint CKC_CLI_TIPO_DOCUMENT_CLIENTE check (CLI_TIPO_DOCUMENTO is null or (CLI_TIPO_DOCUMENTO in ('C','P') and CLI_TIPO_DOCUMENTO = upper(CLI_TIPO_DOCUMENTO))),
   CLI_NOMBRE           VARCHAR2(60)        
      constraint CKC_CLI_NOMBRE_CLIENTE check (CLI_NOMBRE is null or (CLI_NOMBRE = upper(CLI_NOMBRE))),
   CLI_DIRECCION        VARCHAR2(100)       
      constraint CKC_CLI_DIRECCION_CLIENTE check (CLI_DIRECCION is null or (CLI_DIRECCION = upper(CLI_DIRECCION))),
   CLI_SECTOR           VARCHAR2(60)        
      constraint CKC_CLI_SECTOR_CLIENTE check (CLI_SECTOR is null or (CLI_SECTOR = upper(CLI_SECTOR))),
   CLI_TELEFONO         VARCHAR2(13)        
      constraint CKC_CLI_TELEFONO_CLIENTE check (CLI_TELEFONO is null or (CLI_TELEFONO = upper(CLI_TELEFONO))),
   CLI_CORREO           VARCHAR2(50),
   constraint PK_CLIENTE primary key (CLI_NUM_DOCUMENTO)
)
   tablespace DATOS
/

comment on table CLIENTE is
'Tabla que contiene la información general de los clientes'
/

comment on column CLIENTE.CLI_NUM_DOCUMENTO is
'Cédula o RUC o pasaporte del cliente'
/

comment on column CLIENTE.EMP_CEDULA_RUC is
'Atributo que garantiza un registro único, contiene la cedula o ruc de la empresa'
/

comment on column CLIENTE.CLI_TIPO_DOCUMENTO is
'Es el tipo del número de documento del cliente este puede ser C=Cédula o RUC, P=Pasaporte'
/

comment on column CLIENTE.CLI_NOMBRE is
'Nombre completo del cliente'
/

comment on column CLIENTE.CLI_DIRECCION is
'Dirección física del cliente'
/

comment on column CLIENTE.CLI_SECTOR is
'Sector de vivienda del cliente'
/

comment on column CLIENTE.CLI_TELEFONO is
'Número telefónico del cliente'
/

comment on column CLIENTE.CLI_CORREO is
'Correo del cliente'
/

/*==============================================================*/
/* Index: EMPRESA_CLIENTE_FK                                    */
/*==============================================================*/
create index EMPRESA_CLIENTE_FK on CLIENTE (
   EMP_CEDULA_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: CLIENTE_EMPLEADO                                      */
/*==============================================================*/
create table CLIENTE_EMPLEADO (
   CLI_NUM_DOCUMENTO    VARCHAR2(13)          not null,
   EMD_NUM_DOCUMENTO    VARCHAR2(10)          not null,
   constraint PK_CLIENTE_EMPLEADO primary key (CLI_NUM_DOCUMENTO, EMD_NUM_DOCUMENTO)
)
   tablespace DATOS
/

comment on table CLIENTE_EMPLEADO is
'Cleintes de un empleado de ventas'
/

comment on column CLIENTE_EMPLEADO.CLI_NUM_DOCUMENTO is
'Cédula o RUC o pasaporte del cliente'
/

comment on column CLIENTE_EMPLEADO.EMD_NUM_DOCUMENTO is
'Número de cédula de identidad o pasaporte del empleado  '
/

/*==============================================================*/
/* Index: EMPLEADO_CLIE_EMP_FK                                  */
/*==============================================================*/
create index EMPLEADO_CLIE_EMP_FK on CLIENTE_EMPLEADO (
   EMD_NUM_DOCUMENTO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: CLIENTE_CLI_EMPLE_FK                                  */
/*==============================================================*/
create index CLIENTE_CLI_EMPLE_FK on CLIENTE_EMPLEADO (
   CLI_NUM_DOCUMENTO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: COMISION_VENTA                                        */
/*==============================================================*/
create table COMISION_VENTA (
   COM_NUMERO           NUMBER(15)            not null,
   EMD_NUM_DOCUMENTO    VARCHAR2(10)          not null,
   FAC_NUMERO           NUMBER(15)            not null,
   COM_FECHA_PAGO       DATE,
   COM_MONTO            NUMBER(12,2)        
      constraint CKC_COM_MONTO_COMISION check (COM_MONTO is null or (COM_MONTO >= 0)),
   constraint PK_COMISION_VENTA primary key (COM_NUMERO)
)
   tablespace DATOS
/

comment on table COMISION_VENTA is
'Tabla que contiene las comisiones asignadas a los vendedores'
/

comment on column COMISION_VENTA.COM_NUMERO is
'Secuencial que representa el número único de la comisión de venta'
/

comment on column COMISION_VENTA.EMD_NUM_DOCUMENTO is
'Número de cédula de identidad o pasaporte del empleado  '
/

comment on column COMISION_VENTA.FAC_NUMERO is
'Secuencial que representa el número de factura que garantiza registro único'
/

comment on column COMISION_VENTA.COM_FECHA_PAGO is
'Fecha de pago de la comisión'
/

comment on column COMISION_VENTA.COM_MONTO is
'Monto de la comisión'
/

/*==============================================================*/
/* Index: EMPLE_COMI_VENTA_FK                                   */
/*==============================================================*/
create index EMPLE_COMI_VENTA_FK on COMISION_VENTA (
   EMD_NUM_DOCUMENTO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: FACTURA_COMIS_VENTA2_FK                               */
/*==============================================================*/
create index FACTURA_COMIS_VENTA2_FK on COMISION_VENTA (
   FAC_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: DEPARTAMENTO                                         */
/*==============================================================*/
create table DEPARTAMENTO (
   DEP_CODIGO           VARCHAR2(6)           not null
      constraint CKC_DEP_CODIGO_DEPARETA check (DEP_CODIGO = upper(DEP_CODIGO)),
   EMP_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_EMP_CEDULA_RUC_DEPARETA check (EMP_CEDULA_RUC = upper(EMP_CEDULA_RUC)),
   DEP_DESCRIPCION      VARCHAR2(40)        
      constraint CKC_DEP_DESCRIPCION_DEPARETA check (DEP_DESCRIPCION is null or (DEP_DESCRIPCION = upper(DEP_DESCRIPCION))),
   constraint PK_DEPARTAMENTO primary key (DEP_CODIGO)
)
   tablespace DATOS
/

comment on table DEPARTAMENTO is
'Tabla que contiene los departamentos a los que pertenecen los empleados'
/

comment on column DEPARTAMENTO.DEP_CODIGO is
'Código único del departamento'
/

comment on column DEPARTAMENTO.EMP_CEDULA_RUC is
'Atributo que garantiza un registro único, contiene la cedula o ruc de la empresa'
/

comment on column DEPARTAMENTO.DEP_DESCRIPCION is
'Descripción o nombre del departamento'
/

/*==============================================================*/
/* Index: EMPRESA_DEPARTA_FK                                    */
/*==============================================================*/
create index EMPRESA_DEPARTA_FK on DEPARTAMENTO (
   EMP_CEDULA_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: DETALLE_FACTURA                                       */
/*==============================================================*/
create table DETALLE_FACTURA (
   FAC_NUMERO           NUMBER(15)            not null,
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_DETALLE_ check (PRO_CODIGO = upper(PRO_CODIGO)),
   DTF_CANTIDAD         NUMBER(12,2)        
      constraint CKC_DTF_CANTIDAD_DETALLE_ check (DTF_CANTIDAD is null or (DTF_CANTIDAD >= 1)),
   DTF_PRECIO           NUMBER(15,2)        
      constraint CKC_DTF_PRECIO_DETALLE_ check (DTF_PRECIO is null or (DTF_PRECIO >= 0.01)),
   DTF_UNI_MEDIDA       VARCHAR2(3)         
      constraint CKC_DTF_UNI_MEDIDA_DETALLE_ check (DTF_UNI_MEDIDA is null or (DTF_UNI_MEDIDA = upper(DTF_UNI_MEDIDA))),
   constraint PK_DETALLE_FACTURA primary key (FAC_NUMERO, PRO_CODIGO)
)
   tablespace DATOS
/

comment on table DETALLE_FACTURA is
'Contiene los productos de una factura'
/

comment on column DETALLE_FACTURA.FAC_NUMERO is
'Secuencial que representa el número de factura que garantiza registro único'
/

comment on column DETALLE_FACTURA.PRO_CODIGO is
'Código único del producto'
/

comment on column DETALLE_FACTURA.DTF_CANTIDAD is
'Cantidad del producto que se a vendido en la factura'
/

comment on column DETALLE_FACTURA.DTF_PRECIO is
'Precio del producto al momento de la venta'
/

comment on column DETALLE_FACTURA.DTF_UNI_MEDIDA is
'Unidad de medida del producto con la cual se realiza la factura'
/

/*==============================================================*/
/* Index: PRODUCTO_DETA_FACT_FK                                 */
/*==============================================================*/
create index PRODUCTO_DETA_FACT_FK on DETALLE_FACTURA (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: FACTURA_DETA_FAC_FK                                   */
/*==============================================================*/
create index FACTURA_DETA_FAC_FK on DETALLE_FACTURA (
   FAC_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EMD_NUM_DOCUMENTO    VARCHAR2(10)          not null,
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_EMPLEADO check (SUC_CODIGO = upper(SUC_CODIGO)),
   DEP_CODIGO           VARCHAR2(6)           not null
      constraint CKC_DEP_CODIGO_EMPLEADO check (DEP_CODIGO = upper(DEP_CODIGO)),
   EMD_TIPO_DOCUMENTO   VARCHAR2(1)         
      constraint CKC_EMD_TIPO_DOCUMENT_EMPLEADO check (EMD_TIPO_DOCUMENTO is null or (EMD_TIPO_DOCUMENTO in ('C','P') and EMD_TIPO_DOCUMENTO = upper(EMD_TIPO_DOCUMENTO))),
   EMD_NOMBRE           VARCHAR2(60)        
      constraint CKC_EMD_NOMBRE_EMPLEADO check (EMD_NOMBRE is null or (EMD_NOMBRE = upper(EMD_NOMBRE))),
   EMD_DIRECCION        VARCHAR2(100)       
      constraint CKC_EMD_DIRECCION_EMPLEADO check (EMD_DIRECCION is null or (EMD_DIRECCION = upper(EMD_DIRECCION))),
   EMD_TELEFONO         VARCHAR2(13)        
      constraint CKC_EMD_TELEFONO_EMPLEADO check (EMD_TELEFONO is null or (EMD_TELEFONO = upper(EMD_TELEFONO))),
   EMD_CORREO           VARCHAR2(50),
   EMD_CARGO            VARCHAR2(50)        
      constraint CKC_EMD_CARGO_EMPLEADO check (EMD_CARGO is null or (EMD_CARGO = upper(EMD_CARGO))),
   EMD_FECHA_NACIM      DATE,
   EMD_GENERO           VARCHAR2(1)         
      constraint CKC_EMD_GENERO_EMPLEADO check (EMD_GENERO is null or (EMD_GENERO in ('M','F') and EMD_GENERO = upper(EMD_GENERO))),
   EMD_ESTADO_CIVIL     VARCHAR2(1)         
      constraint CKC_EMD_ESTADO_CIVIL_EMPLEADO check (EMD_ESTADO_CIVIL is null or (EMD_ESTADO_CIVIL in ('C','D','V','U','S') and EMD_ESTADO_CIVIL = upper(EMD_ESTADO_CIVIL))),
   EMD_SUELDO           NUMBER(12,2)        
      constraint CKC_EMD_SUELDO_EMPLEADO check (EMD_SUELDO is null or (EMD_SUELDO >= 0)),
   EMD_TIPO_SANGRE      VARCHAR2(3)         
      constraint CKC_EMD_TIPO_SANGRE_EMPLEADO check (EMD_TIPO_SANGRE is null or (EMD_TIPO_SANGRE in ('A+','A-','B+','B-','AB+','AB-','O+','O-') and EMD_TIPO_SANGRE = upper(EMD_TIPO_SANGRE))),
   EMD_CONTACTO_EMER    VARCHAR2(60)        
      constraint CKC_EMD_CONTACTO_EMER_EMPLEADO check (EMD_CONTACTO_EMER is null or (EMD_CONTACTO_EMER = upper(EMD_CONTACTO_EMER))),
   constraint PK_EMPLEADO primary key (EMD_NUM_DOCUMENTO)
)
   tablespace DATOS
/

comment on table EMPLEADO is
'Tabla que contiene la información general de los empleados'
/

comment on column EMPLEADO.EMD_NUM_DOCUMENTO is
'Número de cédula de identidad o pasaporte del empleado  '
/

comment on column EMPLEADO.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column EMPLEADO.DEP_CODIGO is
'Código único del departamento'
/

comment on column EMPLEADO.EMD_TIPO_DOCUMENTO is
'Es el tipo del número de documento del empleado este puede ser C=Cédula o P=Pasaporte'
/

comment on column EMPLEADO.EMD_NOMBRE is
'Nombre completo del empleado'
/

comment on column EMPLEADO.EMD_DIRECCION is
'Dirección del empleado'
/

comment on column EMPLEADO.EMD_TELEFONO is
'Número telefónico del empleado'
/

comment on column EMPLEADO.EMD_CORREO is
'Correo electrónico del empleado'
/

comment on column EMPLEADO.EMD_CARGO is
'Cargo o posición del empleado'
/

comment on column EMPLEADO.EMD_FECHA_NACIM is
'Fecha de nacimiento del empleado'
/

comment on column EMPLEADO.EMD_GENERO is
'Genero del empleado puede ser M=Masculino, F=Femenino'
/

comment on column EMPLEADO.EMD_ESTADO_CIVIL is
'Estado civil del empleado puede ser S=Soltero, C=casado, D=Divorciado, V=Viudo, U=Unión Libre'
/

comment on column EMPLEADO.EMD_SUELDO is
'Sueldo o salario del empleado'
/

comment on column EMPLEADO.EMD_TIPO_SANGRE is
'Tipo de sangre del empleado puede ser A+ A- B+ B- AB+ AB- O+ O-'
/

comment on column EMPLEADO.EMD_CONTACTO_EMER is
'Contacto de emergencia del empleado'
/

/*==============================================================*/
/* Index: SUCURSAL_EMPLEADO_FK                                  */
/*==============================================================*/
create index SUCURSAL_EMPLEADO_FK on EMPLEADO (
   SUC_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: DEPARTA_EMPLEADO_FK                                   */
/*==============================================================*/
create index DEPARTA_EMPLEADO_FK on EMPLEADO (
   DEP_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA (
   EMP_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_EMP_CEDULA_RUC_EMPRESA check (EMP_CEDULA_RUC = upper(EMP_CEDULA_RUC)),
   EMP_NOMBRE           VARCHAR2(60)        
      constraint CKC_EMP_NOMBRE_EMPRESA check (EMP_NOMBRE is null or (EMP_NOMBRE = upper(EMP_NOMBRE))),
   EMP_DIRECION         VARCHAR2(100)       
      constraint CKC_EMP_DIRECION_EMPRESA check (EMP_DIRECION is null or (EMP_DIRECION = upper(EMP_DIRECION))),
   EMP_TELEFONO         VARCHAR2(13),
   EMP_CORREO           VARCHAR2(60),
   EMP_REPRESENTANTE    VARCHAR2(60)        
      constraint CKC_EMP_REPRESENTANTE_EMPRESA check (EMP_REPRESENTANTE is null or (EMP_REPRESENTANTE = upper(EMP_REPRESENTANTE))),
   EMP_VALOR_IVA        NUMBER(4,2)         
      constraint CKC_EMP_VALOR_IVA_EMPRESA check (EMP_VALOR_IVA is null or (EMP_VALOR_IVA >= 0)),
   EMP_CODIGO_SRI       VARCHAR2(10)        
      constraint CKC_EMP_CODIGO_SRI_EMPRESA check (EMP_CODIGO_SRI is null or (EMP_CODIGO_SRI = upper(EMP_CODIGO_SRI))),
   EMP_PORCENTAJE_UTIL  NUMBER(5,2)          default 0
      constraint CKC_EMP_PORCENTAJE_UT_EMPRESA check (EMP_PORCENTAJE_UTIL is null or (EMP_PORCENTAJE_UTIL >= 0)),
   EMP_PORCENTAJE_COMI  NUMBER(5,2)          default 0
      constraint CKC_EMP_PORCENTAJE_CO_EMPRESA check (EMP_PORCENTAJE_COMI is null or (EMP_PORCENTAJE_COMI >= 0)),
   constraint PK_EMPRESA primary key (EMP_CEDULA_RUC)
)
   tablespace DATOS
/

comment on table EMPRESA is
'Tabla que contiene información general de la empresa'
/

comment on column EMPRESA.EMP_CEDULA_RUC is
'Atributo que garantiza un registro único, contiene la cedula o ruc de la empresa'
/

comment on column EMPRESA.EMP_NOMBRE is
'Contiene el nombre de la empresa'
/

comment on column EMPRESA.EMP_DIRECION is
'Dirección del empleado'
/

comment on column EMPRESA.EMP_TELEFONO is
'Telefono del empleado'
/

comment on column EMPRESA.EMP_CORREO is
'Correo del empleado'
/

comment on column EMPRESA.EMP_REPRESENTANTE is
'Representantes de la empresa'
/

comment on column EMPRESA.EMP_VALOR_IVA is
'Valor de IVA manejado por la empresa'
/

comment on column EMPRESA.EMP_CODIGO_SRI is
'Código SRI emitido por el SRI para la empresa'
/

comment on column EMPRESA.EMP_PORCENTAJE_UTIL is
'Porcentaje Util que maneja la empresa'
/

comment on column EMPRESA.EMP_PORCENTAJE_COMI is
'Porcentajes de comisiones'
/

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   FAC_NUMERO           NUMBER(15)            not null,
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_FACTURA check (SUC_CODIGO = upper(SUC_CODIGO)),
   CLI_NUM_DOCUMENTO    VARCHAR2(13)          not null,
   FAC_FECHA            DATE,
   FAC_MONTO            NUMBER(12,2)        
      constraint CKC_FAC_MONTO_FACTURA check (FAC_MONTO is null or (FAC_MONTO >= 0)),
   FAC_RESPONSABLE      VARCHAR2(60)        
      constraint CKC_FAC_RESPONSABLE_FACTURA check (FAC_RESPONSABLE is null or (FAC_RESPONSABLE = upper(FAC_RESPONSABLE))),
   constraint PK_FACTURA primary key (FAC_NUMERO)
)
   tablespace DATOS
/

comment on table FACTURA is
'Tabla que contiene las facturas que se han realizado a los clientes'
/

comment on column FACTURA.FAC_NUMERO is
'Secuencial que representa el número de factura que garantiza registro único'
/

comment on column FACTURA.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column FACTURA.CLI_NUM_DOCUMENTO is
'Cédula o RUC o pasaporte del cliente'
/

comment on column FACTURA.FAC_FECHA is
'Fecha de emisión de la factura'
/

comment on column FACTURA.FAC_MONTO is
'Monto total de la factura'
/

comment on column FACTURA.FAC_RESPONSABLE is
'Nombre del empleado responsable de la factura'
/

/*==============================================================*/
/* Index: SUCURSAL_FACTURA_FK                                   */
/*==============================================================*/
create index SUCURSAL_FACTURA_FK on FACTURA (
   SUC_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: CLIENTE_FACTURA_FK                                    */
/*==============================================================*/
create index CLIENTE_FACTURA_FK on FACTURA (
   CLI_NUM_DOCUMENTO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: FORMA_PAGO                                            */
/*==============================================================*/
create table FORMA_PAGO (
   FRP_CODIGO           VARCHAR2(2)           not null,
   FRP_DESCRIPCION      VARCHAR2(60)        
      constraint CKC_FRP_DESCRIPCION_FORMA_PA check (FRP_DESCRIPCION is null or (FRP_DESCRIPCION = upper(FRP_DESCRIPCION))),
   constraint PK_FORMA_PAGO primary key (FRP_CODIGO)
)
   tablespace DATOS
/

comment on table FORMA_PAGO is
'Tabla que contiene las formas de pago con las cuales se puede liquidar una factura en la empresa'
/

comment on column FORMA_PAGO.FRP_CODIGO is
'Código único de la forma de pago'
/

comment on column FORMA_PAGO.FRP_DESCRIPCION is
'Descripción o nombre de la forma de pago (efectivo, tarjeta, etc.)'
/

/*==============================================================*/
/* Table: FRM_PAGO_FACTURA                                      */
/*==============================================================*/
create table FRM_PAGO_FACTURA (
   FAC_NUMERO           NUMBER(15)            not null,
   FRP_CODIGO           VARCHAR2(2)           not null,
   FPF_MONTO            NUMBER(12,2)        
      constraint CKC_FPF_MONTO_FRM_PAGO check (FPF_MONTO is null or (FPF_MONTO >= 1)),
   constraint PK_FRM_PAGO_FACTURA primary key (FAC_NUMERO, FRP_CODIGO)
)
   tablespace DATOS
/

comment on table FRM_PAGO_FACTURA is
'Formas de pago que puede tener una factura'
/

comment on column FRM_PAGO_FACTURA.FAC_NUMERO is
'Secuencial que representa el número de factura que garantiza registro único'
/

comment on column FRM_PAGO_FACTURA.FRP_CODIGO is
'Código único de la forma de pago'
/

comment on column FRM_PAGO_FACTURA.FPF_MONTO is
'Monto abonado con esa forma de pago escogida puede ser parcial o el total de la factura'
/

/*==============================================================*/
/* Index: FOR_PAGO_FRM_PAG_FAC_FK                               */
/*==============================================================*/
create index FOR_PAGO_FRM_PAG_FAC_FK on FRM_PAGO_FACTURA (
   FRP_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: FACTURA_FRM_PAGO_FAC_FK                               */
/*==============================================================*/
create index FACTURA_FRM_PAGO_FAC_FK on FRM_PAGO_FACTURA (
   FAC_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: MOVIMIENTO_BODEGA                                     */
/*==============================================================*/
create table MOVIMIENTO_BODEGA (
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_MOVIMIEN check (PRO_CODIGO = upper(PRO_CODIGO)),
   TRS_CODIGO           VARCHAR2(3)           not null
      constraint CKC_TRS_CODIGO_MOVIMIEN check (TRS_CODIGO = upper(TRS_CODIGO)),
   MVB_FECHA            DATE,
   MVB_CANTIDAD         NUMBER(10,2)        
      constraint CKC_MVB_CANTIDAD_MOVIMIEN check (MVB_CANTIDAD is null or (MVB_CANTIDAD >= 1)),
   MVB_PRECIO           NUMBER(15,2)        
      constraint CKC_MVB_PRECIO_MOVIMIEN check (MVB_PRECIO is null or (MVB_PRECIO >= 0.01)),
   MVB_UNI_MEDIDA       VARCHAR2(3)         
      constraint CKC_MVB_UNI_MEDIDA_MOVIMIEN check (MVB_UNI_MEDIDA is null or (MVB_UNI_MEDIDA = upper(MVB_UNI_MEDIDA))),
   MVB_OBSERVACION      VARCHAR2(200)       
      constraint CKC_MVB_OBSERVACION_MOVIMIEN check (MVB_OBSERVACION is null or (MVB_OBSERVACION = upper(MVB_OBSERVACION))),
   constraint PK_MOVIMIENTO_BODEGA primary key (PRO_CODIGO, TRS_CODIGO)
)
   tablespace DATOS
/

comment on table MOVIMIENTO_BODEGA is
'Movimientos del Inventario'
/

comment on column MOVIMIENTO_BODEGA.PRO_CODIGO is
'Código único del producto'
/

comment on column MOVIMIENTO_BODEGA.TRS_CODIGO is
'Código único de la transacción'
/

comment on column MOVIMIENTO_BODEGA.MVB_FECHA is
'Fecha en la que hace el movimineto de la bodega'
/

comment on column MOVIMIENTO_BODEGA.MVB_CANTIDAD is
'Cantidad del producto que se moviliza en el inventario'
/

comment on column MOVIMIENTO_BODEGA.MVB_PRECIO is
'Precio del producto al momento del movimineto del inventario'
/

comment on column MOVIMIENTO_BODEGA.MVB_UNI_MEDIDA is
'Unidad de medida con la que se realiza el movimiento en el inventario'
/

comment on column MOVIMIENTO_BODEGA.MVB_OBSERVACION is
'Observaciones generales respecto al movimineto del inventario'
/

/*==============================================================*/
/* Index: TRANS_MOV_BODE_FK                                     */
/*==============================================================*/
create index TRANS_MOV_BODE_FK on MOVIMIENTO_BODEGA (
   TRS_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PROD_MOVI_BOD_FK                                      */
/*==============================================================*/
create index PROD_MOVI_BOD_FK on MOVIMIENTO_BODEGA (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: ORDEN_COMPRA                                          */
/*==============================================================*/
create table ORDEN_COMPRA (
   ORC_NUMERO           NUMBER(15)            not null,
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_ORDEN_CO check (SUC_CODIGO = upper(SUC_CODIGO)),
   PRD_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_PRD_CEDULA_RUC_ORDEN_CO check (PRD_CEDULA_RUC = upper(PRD_CEDULA_RUC)),
   ORC_FECHA_EMICION    DATE,
   ORC_FECHA_ENTREGA    DATE,
   ORC_MONTO_TOTAL      NUMBER(12,2)        
      constraint CKC_ORC_MONTO_TOTAL_ORDEN_CO check (ORC_MONTO_TOTAL is null or (ORC_MONTO_TOTAL >= 0)),
   ORC_RESPONSABLE      VARCHAR2(60)        
      constraint CKC_ORC_RESPONSABLE_ORDEN_CO check (ORC_RESPONSABLE is null or (ORC_RESPONSABLE = upper(ORC_RESPONSABLE))),
   constraint PK_ORDEN_COMPRA primary key (ORC_NUMERO)
)
   tablespace DATOS
/

comment on table ORDEN_COMPRA is
'Tabla que contiene las ordenes de compra enviadas a los proveedores'
/

comment on column ORDEN_COMPRA.ORC_NUMERO is
'Secuencial que representa el número único de la orden de compra'
/

comment on column ORDEN_COMPRA.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column ORDEN_COMPRA.PRD_CEDULA_RUC is
'Cédula o RUC del proveedor'
/

comment on column ORDEN_COMPRA.ORC_FECHA_EMICION is
'Fecha de emisión de la orden de compra'
/

comment on column ORDEN_COMPRA.ORC_FECHA_ENTREGA is
'Fecha de entrega programada para que el proveedor entregue los productos a la empresa'
/

comment on column ORDEN_COMPRA.ORC_MONTO_TOTAL is
'Monto total de la orden de compra'
/

comment on column ORDEN_COMPRA.ORC_RESPONSABLE is
'Nombre del empleado responsable de la orden de compra'
/

/*==============================================================*/
/* Index: SUCURSAL_ORDEN_COMPRA_FK                              */
/*==============================================================*/
create index SUCURSAL_ORDEN_COMPRA_FK on ORDEN_COMPRA (
   SUC_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PROVEEDOR_ORDEN_COMPRA_FK                             */
/*==============================================================*/
create index PROVEEDOR_ORDEN_COMPRA_FK on ORDEN_COMPRA (
   PRD_CEDULA_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PRD_PROMOCION                                         */
/*==============================================================*/
create table PRD_PROMOCION (
   PRM_CODIGO           VARCHAR2(8)           not null,
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_PRD_PROM check (PRO_CODIGO = upper(PRO_CODIGO)),
   PRP_PORCENTAJE_DESC  NUMBER(5,2),
   constraint PK_PRD_PROMOCION primary key (PRM_CODIGO, PRO_CODIGO)
)
   tablespace DATOS
/

comment on table PRD_PROMOCION is
'Contiene los productos en los que se aplica la promoción'
/

comment on column PRD_PROMOCION.PRM_CODIGO is
'Código único de la promoción'
/

comment on column PRD_PROMOCION.PRO_CODIGO is
'Código único del producto'
/

comment on column PRD_PROMOCION.PRP_PORCENTAJE_DESC is
'Porcentaje de descuento que se aplica al producto de una promoción'
/

/*==============================================================*/
/* Index: PROD_PROD_PROMO_FK                                    */
/*==============================================================*/
create index PROD_PROD_PROMO_FK on PRD_PROMOCION (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PRD_PROVEEDOR                                         */
/*==============================================================*/
create table PRD_PROVEEDOR (
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_PRD_PROV check (PRO_CODIGO = upper(PRO_CODIGO)),
   PRD_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_PRD_CEDULA_RUC_PRD_PROV check (PRD_CEDULA_RUC = upper(PRD_CEDULA_RUC)),
   constraint PK_PRD_PROVEEDOR primary key (PRO_CODIGO, PRD_CEDULA_RUC)
)
   tablespace DATOS
/

comment on table PRD_PROVEEDOR is
'Productos que puede distribuir un proveedor'
/

comment on column PRD_PROVEEDOR.PRO_CODIGO is
'Código único del producto'
/

comment on column PRD_PROVEEDOR.PRD_CEDULA_RUC is
'Cédula o RUC del proveedor'
/

/*==============================================================*/
/* Index: PROVEE_TIENE_PRD_PROV_FK                              */
/*==============================================================*/
create index PROVEE_TIENE_PRD_PROV_FK on PRD_PROVEEDOR (
   PRD_CEDULA_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PRODUCTO_PROD_PROVEE_FK                               */
/*==============================================================*/
create index PRODUCTO_PROD_PROVEE_FK on PRD_PROVEEDOR (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_PRODUCTO check (PRO_CODIGO = upper(PRO_CODIGO)),
   CAT_CODIGO           VARCHAR2(4)           not null
      constraint CKC_CAT_CODIGO_PRODUCTO check (CAT_CODIGO = upper(CAT_CODIGO)),
   PRO_DESCRIPCION     VARCHAR2(60)        
      constraint CKC_PRO_DESCRIPCION_PRODUCTO check (PRO_DESCRIPCION is null or (PRO_DESCRIPCION = upper(PRO_DESCRIPCION))),
   PRO_PRC_COM_ACT      NUMBER(12,2)        
      constraint CKC_PRO_PRC_COM_ACT_PRODUCTO check (PRO_PRC_COM_ACT is null or (PRO_PRC_COM_ACT >= 0)),
   PRO_PRC_VEN_ACT      NUMBER(12,2)        
      constraint CKC_PRO_PRC_VEN_ACT_PRODUCTO check (PRO_PRC_VEN_ACT is null or (PRO_PRC_VEN_ACT >= 0)),
   PRO_PRC_COM_ANT      NUMBER(12,2)        
      constraint CKC_PRO_PRC_COM_ANT_PRODUCTO check (PRO_PRC_COM_ANT is null or (PRO_PRC_COM_ANT >= 0)),
   PRO_PRC_VEN_ANT      NUMBER(12,2)        
      constraint CKC_PRO_PRC_VEN_ANT_PRODUCTO check (PRO_PRC_VEN_ANT is null or (PRO_PRC_VEN_ANT >= 0)),
   PRO_COD_BARRAS       VARCHAR2(13)        
      constraint CKC_PRO_COD_BARRAS_PRODUCTO check (PRO_COD_BARRAS is null or (PRO_COD_BARRAS = upper(PRO_COD_BARRAS))),
   PRO_COLOR            VARCHAR2(15)        
      constraint CKC_PRO_COLOR_PRODUCTO check (PRO_COLOR is null or (PRO_COLOR = upper(PRO_COLOR))),
   PRO_UNIDAD_BASICA    VARCHAR2(3)         
      constraint CKC_PRO_UNIDAD_BASICA_PRODUCTO check (PRO_UNIDAD_BASICA is null or (PRO_UNIDAD_BASICA = upper(PRO_UNIDAD_BASICA))),
   PRO_TALLA            VARCHAR2(10)        
      constraint CKC_PRO_TALLA_PRODUCTO check (PRO_TALLA is null or (PRO_TALLA = upper(PRO_TALLA))),
   PRO_MARCA            VARCHAR2(30)        
      constraint CKC_PRO_MARCA_PRODUCTO check (PRO_MARCA is null or (PRO_MARCA = upper(PRO_MARCA))),
   PRO_PORC_UTIL        NUMBER(5,2)         
      constraint CKC_PRO_PORC_UTIL_PRODUCTO check (PRO_PORC_UTIL is null or (PRO_PORC_UTIL >= 0)),
   PRO_PAGA_IVA         VARCHAR2(1)         
      constraint CKC_PRO_PAGA_IVA_PRODUCTO check (PRO_PAGA_IVA is null or (PRO_PAGA_IVA in ('S','N') and PRO_PAGA_IVA = upper(PRO_PAGA_IVA))),
   PRO_PESO             NUMBER(5,2)         
      constraint CKC_PRO_PESO_PRODUCTO check (PRO_PESO is null or (PRO_PESO >= 0)),
   PRO_PORC_COMI        NUMBER(5,2)         
      constraint CKC_PRO_PORC_COMI_PRODUCTO check (PRO_PORC_COMI is null or (PRO_PORC_COMI >= 0)),
   constraint PK_PRODUCTO primary key (PRO_CODIGO)
)
   tablespace DATOS
/

comment on table PRODUCTO is
'Tabla que contiene los productos que comercializa la empresa'
/

comment on column PRODUCTO.PRO_CODIGO is
'Código único del producto'
/

comment on column PRODUCTO.CAT_CODIGO is
'Código único de la categoría del producto'
/

comment on column PRODUCTO.PRO_DESCRIPCION is
'Descripción o nombre del producto'
/

comment on column PRODUCTO.PRO_PRC_COM_ACT is
'Precio de compra actual del producto'
/

comment on column PRODUCTO.PRO_PRC_VEN_ACT is
'Precio de venta actual del producto'
/

comment on column PRODUCTO.PRO_PRC_COM_ANT is
'Precio de compra anterior del producto'
/

comment on column PRODUCTO.PRO_PRC_VEN_ANT is
'Precio de venta anterior del producto'
/

comment on column PRODUCTO.PRO_COD_BARRAS is
'Código de barras del producto'
/

comment on column PRODUCTO.PRO_COLOR is
'Color del producto'
/

comment on column PRODUCTO.PRO_UNIDAD_BASICA is
'Unidad básica del producto'
/

comment on column PRODUCTO.PRO_TALLA is
'Talla o tamaño del producto'
/

comment on column PRODUCTO.PRO_MARCA is
'Marca del producto'
/

comment on column PRODUCTO.PRO_PORC_UTIL is
'Porcentaje de utilidad del producto'
/

comment on column PRODUCTO.PRO_PAGA_IVA is
'Indicador si el producto paga IVA permite solo S=Si paga y N=No paga'
/

comment on column PRODUCTO.PRO_PESO is
'Peso del producto'
/

comment on column PRODUCTO.PRO_PORC_COMI is
'Porcentaje de comisión que la empresa paga a los vendedores por venta de este'
/

/*==============================================================*/
/* Index: CATEG_PROD_PRODUCTO_FK                                */
/*==============================================================*/
create index CATEG_PROD_PRODUCTO_FK on PRODUCTO (
   CAT_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PROD_BODEGA                                           */
/*==============================================================*/
create table PROD_BODEGA (
   BOD__CODIGO          VARCHAR2(3)           not null
      constraint CKC_BOD__CODIGO_PROD_BOD check (BOD__CODIGO = upper(BOD__CODIGO)),
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_PROD_BOD check (PRO_CODIGO = upper(PRO_CODIGO)),
   PRB_EXISTENCIA       NUMBER(10,2)        
      constraint CKC_PRB_EXISTENCIA_PROD_BOD check (PRB_EXISTENCIA is null or (PRB_EXISTENCIA >= 0)),
   constraint PK_PROD_BODEGA primary key (BOD__CODIGO, PRO_CODIGO)
)
   tablespace DATOS
/

comment on table PROD_BODEGA is
'Productos de cada bodega con sus existencias'
/

comment on column PROD_BODEGA.BOD__CODIGO is
'Código único de la bodega'
/

comment on column PROD_BODEGA.PRO_CODIGO is
'Código único del producto'
/

comment on column PROD_BODEGA.PRB_EXISTENCIA is
'Existencia del producto en la bodega'
/

/*==============================================================*/
/* Index: PRODUCTO_PRD_BODEGA_FK                                */
/*==============================================================*/
create index PRODUCTO_PRD_BODEGA_FK on PROD_BODEGA (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: BODEGA_PRD_BODEGA_FK                                  */
/*==============================================================*/
create index BODEGA_PRD_BODEGA_FK on PROD_BODEGA (
   BOD__CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PROD_ORDEN_COMPRA                                     */
/*==============================================================*/
create table PROD_ORDEN_COMPRA (
   ORC_NUMERO           NUMBER(15)            not null,
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_PROD_ORD check (PRO_CODIGO = upper(PRO_CODIGO)),
   POC_CANTIDAD         NUMBER(10,2)        
      constraint CKC_POC_CANTIDAD_PROD_ORD check (POC_CANTIDAD is null or (POC_CANTIDAD >= 1)),
   POC_UNI_MEDIDA       VARCHAR2(3)         
      constraint CKC_POC_UNI_MEDIDA_PROD_ORD check (POC_UNI_MEDIDA is null or (POC_UNI_MEDIDA = upper(POC_UNI_MEDIDA))),
   POC_PRECIO           NUMBER(15,2)        
      constraint CKC_POC_PRECIO_PROD_ORD check (POC_PRECIO is null or (POC_PRECIO >= 0.01)),
   constraint PK_PROD_ORDEN_COMPRA primary key (ORC_NUMERO, PRO_CODIGO)
)
   tablespace DATOS
/

comment on table PROD_ORDEN_COMPRA is
'Contriene los productos de uan orden de compra'
/

comment on column PROD_ORDEN_COMPRA.ORC_NUMERO is
'Secuencial que representa el número único de la orden de compra'
/

comment on column PROD_ORDEN_COMPRA.PRO_CODIGO is
'Código único del producto'
/

comment on column PROD_ORDEN_COMPRA.POC_CANTIDAD is
'Cantidad del producto solicitada en la orden de compra'
/

comment on column PROD_ORDEN_COMPRA.POC_UNI_MEDIDA is
'Unidad de medida del producto quye se esta solicitando'
/

comment on column PROD_ORDEN_COMPRA.POC_PRECIO is
'Precio del producto en el momento de la compra'
/

/*==============================================================*/
/* Index: PRODUCTO_PRO_ORD_COM_FK                               */
/*==============================================================*/
create index PRODUCTO_PRO_ORD_COM_FK on PROD_ORDEN_COMPRA (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: ORD_COMP_PRD_ORD_COMP_FK                              */
/*==============================================================*/
create index ORD_COMP_PRD_ORD_COMP_FK on PROD_ORDEN_COMPRA (
   ORC_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PROMOCION                                             */
/*==============================================================*/
create table PROMOCION (
   PRM_CODIGO           VARCHAR2(8)           not null,
   PRM_DESCRIPCION      VARCHAR2(100)       
      constraint CKC_PRM_DESCRIPCION_PROMOCIO check (PRM_DESCRIPCION is null or (PRM_DESCRIPCION = upper(PRM_DESCRIPCION))),
   PRM_PORCENTAJE_DESC  NUMBER(5,2)         
      constraint CKC_PRM_PORCENTAJE_DE_PROMOCIO check (PRM_PORCENTAJE_DESC is null or (PRM_PORCENTAJE_DESC >= 0)),
   PRM_FECHA_INI        DATE,
   PRM_FECHA_FIN        DATE,
   PRM_CONDICION        VARCHAR2(200)       
      constraint CKC_PRM_CONDICION_PROMOCIO check (PRM_CONDICION is null or (PRM_CONDICION = upper(PRM_CONDICION))),
   constraint PK_PROMOCION primary key (PRM_CODIGO)
)
   tablespace DATOS
/

comment on table PROMOCION is
'Tabla que contiene las promociones que se designan a los productos'
/

comment on column PROMOCION.PRM_CODIGO is
'Código único de la promoción'
/

comment on column PROMOCION.PRM_DESCRIPCION is
'Descripción o nombre de la promoción'
/

comment on column PROMOCION.PRM_PORCENTAJE_DESC is
'Porcentaje de descuento de la promoción'
/

comment on column PROMOCION.PRM_FECHA_INI is
'Fecha de inicio de la promoción'
/

comment on column PROMOCION.PRM_FECHA_FIN is
'Fecha de finalizaciópn de la promoción'
/

comment on column PROMOCION.PRM_CONDICION is
'Codicindes establecidas parea que se aplique la promoción'
/

/*==============================================================*/
/* Table: PROMOC_SUCURSAL                                       */
/*==============================================================*/
create table PROMOC_SUCURSAL (
   PRM_CODIGO           VARCHAR2(8)           not null,
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_PROMOC_S check (SUC_CODIGO = upper(SUC_CODIGO)),
   PRM_CONDICION        VARCHAR2(200)       
      constraint CKC_PRM_CONDICION_PROMOC_S check (PRM_CONDICION is null or (PRM_CONDICION = upper(PRM_CONDICION))),
   constraint PK_PROMOC_SUCURSAL primary key (PRM_CODIGO, SUC_CODIGO)
)
   tablespace DATOS
/

comment on table PROMOC_SUCURSAL is
'Promociones aplicables a las sucursales'
/

comment on column PROMOC_SUCURSAL.PRM_CODIGO is
'Código único de la promoción'
/

comment on column PROMOC_SUCURSAL.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column PROMOC_SUCURSAL.PRM_CONDICION is
'Condición de la promoción especifica para la sucursal'
/

/*==============================================================*/
/* Index: SUCURSAL_PROMO_SUUC_FK                                */
/*==============================================================*/
create index SUCURSAL_PROMO_SUUC_FK on PROMOC_SUCURSAL (
   SUC_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PROMOCION_PROM_SUC_FK                                 */
/*==============================================================*/
create index PROMOCION_PROM_SUC_FK on PROMOC_SUCURSAL (
   PRM_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR (
   PRD_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_PRD_CEDULA_RUC_PROVEEDO check (PRD_CEDULA_RUC = upper(PRD_CEDULA_RUC)),
   PRD_NOMBRE           VARCHAR2(60)        
      constraint CKC_PRD_NOMBRE_PROVEEDO check (PRD_NOMBRE is null or (PRD_NOMBRE = upper(PRD_NOMBRE))),
   PRD_DIRECCION        VARCHAR2(100)       
      constraint CKC_PRD_DIRECCION_PROVEEDO check (PRD_DIRECCION is null or (PRD_DIRECCION = upper(PRD_DIRECCION))),
   PRD_TELEFONO         VARCHAR2(13),
   PRD_CORREO           VARCHAR2(60),
   PRD_CONTACTO         VARCHAR2(60)        
      constraint CKC_PRD_CONTACTO_PROVEEDO check (PRD_CONTACTO is null or (PRD_CONTACTO = upper(PRD_CONTACTO))),
   PRD_TIPO_PAGO        NUMBER(2)           
      constraint CKC_PRD_TIPO_PAGO_PROVEEDO check (PRD_TIPO_PAGO is null or (PRD_TIPO_PAGO in (0,15,30,45,60))),
   constraint PK_PROVEEDOR primary key (PRD_CEDULA_RUC)
)
   tablespace DATOS
/

comment on table PROVEEDOR is
'Tabla que contiene los proveedores de productos a la empresa'
/

comment on column PROVEEDOR.PRD_CEDULA_RUC is
'Cédula o RUC del proveedor'
/

comment on column PROVEEDOR.PRD_NOMBRE is
'Nombre del proveedor'
/

comment on column PROVEEDOR.PRD_DIRECCION is
'Dirección física del proveedor'
/

comment on column PROVEEDOR.PRD_TELEFONO is
'Número telefónico del proveedor'
/

comment on column PROVEEDOR.PRD_CORREO is
'Correo electrónico del proveedor'
/

comment on column PROVEEDOR.PRD_CONTACTO is
'Persona de contacto del proveedor'
/

comment on column PROVEEDOR.PRD_TIPO_PAGO is
'Tiempo establecido por el proveedor para el pago de sus facturas, puede ser 0=A la entrega, 15= 15 dias despues, 30=30 días despues, 45=45 días despues, 60=60 días despues el valor por deecto es 60'
/

/*==============================================================*/
/* Table: PROVINCIA                                             */
/*==============================================================*/
create table PROVINCIA (
   PRV_NUMERO           NUMBER(2)             not null
      constraint CKC_PRV_NUMERO_PROVINCI check (PRV_NUMERO between 1 and 27),
   PRV_DESCRIPCION      VARCHAR2(60)        
      constraint CKC_PRV_DESCRIPCION_PROVINCI check (PRV_DESCRIPCION is null or (PRV_DESCRIPCION = upper(PRV_DESCRIPCION))),
   constraint PK_PROVINCIA primary key (PRV_NUMERO)
)
   tablespace DATOS
/

comment on table PROVINCIA is
'Tabla que contiene las provincias del Ecuador'
/

comment on column PROVINCIA.PRV_NUMERO is
'Código único identificador de la provincia'
/

comment on column PROVINCIA.PRV_DESCRIPCION is
'Nombre o descripción de la provincia'
/

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL (
   SUC_CODIGO           VARCHAR2(8)           not null
      constraint CKC_SUC_CODIGO_SUCURSAL check (SUC_CODIGO = upper(SUC_CODIGO)),
   EMP_CEDULA_RUC       VARCHAR2(13)          not null
      constraint CKC_EMP_CEDULA_RUC_SUCURSAL check (EMP_CEDULA_RUC = upper(EMP_CEDULA_RUC)),
   CIU_NUMERO           NUMBER(3)             not null
      constraint CKC_CIU_NUMERO_SUCURSAL check (CIU_NUMERO between 1 and 225),
   SUC_NOMBRE           VARCHAR2(60)        
      constraint CKC_SUC_NOMBRE_SUCURSAL check (SUC_NOMBRE is null or (SUC_NOMBRE = upper(SUC_NOMBRE))),
   SUC_DIRECCION        VARCHAR2(100)       
      constraint CKC_SUC_DIRECCION_SUCURSAL check (SUC_DIRECCION is null or (SUC_DIRECCION = upper(SUC_DIRECCION))),
   SUC_TELEFONO         VARCHAR2(13),
   SUC_CORREO           VARCHAR2(60),
   SUC_RESPONSABLE      VARCHAR2(60)        
      constraint CKC_SUC_RESPONSABLE_SUCURSAL check (SUC_RESPONSABLE is null or (SUC_RESPONSABLE = upper(SUC_RESPONSABLE))),
   SUC_CODIGO_SRI       VARCHAR2(10)        
      constraint CKC_SUC_CODIGO_SRI_SUCURSAL check (SUC_CODIGO_SRI is null or (SUC_CODIGO_SRI = upper(SUC_CODIGO_SRI))),
   SUC_NUM_FACTURA      NUMBER(15)          
      constraint CKC_SUC_NUM_FACTURA_SUCURSAL check (SUC_NUM_FACTURA is null or (SUC_NUM_FACTURA >= 0)),
   constraint PK_SUCURSAL primary key (SUC_CODIGO)
)
   tablespace DATOS
/

comment on table SUCURSAL is
'Tabla que contiene información general de la sucursal'
/

comment on column SUCURSAL.SUC_CODIGO is
'Código de sucursal que garantiza un registro único '
/

comment on column SUCURSAL.EMP_CEDULA_RUC is
'Atributo que garantiza un registro único, contiene la cedula o ruc de la empresa'
/

comment on column SUCURSAL.CIU_NUMERO is
'Código único identificador de la ciudad'
/

comment on column SUCURSAL.SUC_NOMBRE is
'Nombre de la sucursal'
/

comment on column SUCURSAL.SUC_DIRECCION is
'Dirección física de la sucursal'
/

comment on column SUCURSAL.SUC_TELEFONO is
'Número telefónico de contacto de la sucursal'
/

comment on column SUCURSAL.SUC_CORREO is
'Correo electrónico de la sucursal'
/

comment on column SUCURSAL.SUC_RESPONSABLE is
'Persona responsable o encargada de la sucursal'
/

comment on column SUCURSAL.SUC_CODIGO_SRI is
'Código asignado por SRI de la sucursal'
/

comment on column SUCURSAL.SUC_NUM_FACTURA is
'Número de factura on el cual se emitira la siguiente fatura en la sucursal sumandole mas 1'
/

/*==============================================================*/
/* Index: EMPRESA_SUCURSAL_FK                                   */
/*==============================================================*/
create index EMPRESA_SUCURSAL_FK on SUCURSAL (
   EMP_CEDULA_RUC ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: CIUDAD_SUCURSAL_FK                                    */
/*==============================================================*/
create index CIUDAD_SUCURSAL_FK on SUCURSAL (
   CIU_NUMERO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: TRANSACCION                                           */
/*==============================================================*/
create table TRANSACCION (
   TRS_CODIGO           VARCHAR2(3)           not null
      constraint CKC_TRS_CODIGO_TRANSACC check (TRS_CODIGO = upper(TRS_CODIGO)),
   TRS_DESCRIPCION      VARCHAR2(60)        
      constraint CKC_TRS_DESCRIPCION_TRANSACC check (TRS_DESCRIPCION is null or (TRS_DESCRIPCION = upper(TRS_DESCRIPCION))),
   TRS_TIPO             VARCHAR2(2)         
      constraint CKC_TRS_TIPO_TRANSACC check (TRS_TIPO is null or (TRS_TIPO in ('IV','EV','IN','EN') and TRS_TIPO = upper(TRS_TIPO))),
   constraint PK_TRANSACCION primary key (TRS_CODIGO)
)
   tablespace DATOS
/

comment on table TRANSACCION is
'Tabla que contiene los tipos de transacciones que se pueden realizar en la gestión de lso inventarios'
/

comment on column TRANSACCION.TRS_CODIGO is
'Código único de la transacción'
/

comment on column TRANSACCION.TRS_DESCRIPCION is
'Descripción de la transacción'
/

comment on column TRANSACCION.TRS_TIPO is
'Tipo de transacción el tipo puede ser IV=Ingreso valorado, EV=Egreso valorado, IN=Ingreso no valorado, EN=Egreso no valorado '
/

/*==============================================================*/
/* Table: UNIDAD_ALTERNATIVA                                    */
/*==============================================================*/
create table UNIDAD_ALTERNATIVA (
   PRO_CODIGO           VARCHAR2(20)          not null
      constraint CKC_PRO_CODIGO_UNIDAD_A check (PRO_CODIGO = upper(PRO_CODIGO)),
   UNM_CODIGO           VARCHAR2(3)           not null
      constraint CKC_UNM_CODIGO_UNIDAD_A check (UNM_CODIGO = upper(UNM_CODIGO)),
   UMA_FACTOR_CONV      NUMBER(10,2),
   constraint PK_UNIDAD_ALTERNATIVA primary key (PRO_CODIGO, UNM_CODIGO)
)
   tablespace DATOS
/

comment on table UNIDAD_ALTERNATIVA is
'Contiene las unidades de medida alternativas con las que se puede egresar un producto'
/

comment on column UNIDAD_ALTERNATIVA.PRO_CODIGO is
'Código único del producto'
/

comment on column UNIDAD_ALTERNATIVA.UNM_CODIGO is
'Código único de la unidad de medida'
/

/*==============================================================*/
/* Index: UNID_MED_UNID_ALTER_FK                                */
/*==============================================================*/
create index UNID_MED_UNID_ALTER_FK on UNIDAD_ALTERNATIVA (
   UNM_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Index: PROD_UNI_MED_ALT_FK                                   */
/*==============================================================*/
create index PROD_UNI_MED_ALT_FK on UNIDAD_ALTERNATIVA (
   PRO_CODIGO ASC
)
tablespace INDICES
/

/*==============================================================*/
/* Table: UNIDAD_MEDIDA                                         */
/*==============================================================*/
create table UNIDAD_MEDIDA (
   UNM_CODIGO           VARCHAR2(3)           not null
      constraint CKC_UNM_CODIGO_UNIDAD_M check (UNM_CODIGO = upper(UNM_CODIGO)),
   UNM_DESCRIPCION      VARCHAR2(40)        
      constraint CKC_UNM_DESCRIPCION_UNIDAD_M check (UNM_DESCRIPCION is null or (UNM_DESCRIPCION = upper(UNM_DESCRIPCION))),
   constraint PK_UNIDAD_MEDIDA primary key (UNM_CODIGO)
)
   tablespace DATOS
/

comment on table UNIDAD_MEDIDA is
'Tabla que contiene las unidades de medida de los productos'
/

comment on column UNIDAD_MEDIDA.UNM_CODIGO is
'Código único de la unidad de medida'
/

comment on column UNIDAD_MEDIDA.UNM_DESCRIPCION is
'Descripción o nombre de la unidad de medida'
/


create trigger TDB_BODEGA before delete
on BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PROD_BODEGA"
    cursor cfk1_prod_bodega(var_bod__codigo varchar) is
       select 1
       from   PROD_BODEGA
       where  BOD__CODIGO = var_bod__codigo
        and   var_bod__codigo is not null;

begin
    --  Cannot delete parent "BODEGA" if children still exist in "PROD_BODEGA"
    open  cfk1_prod_bodega(:old.BOD__CODIGO);
    fetch cfk1_prod_bodega into dummy;
    found := cfk1_prod_bodega%FOUND;
    close cfk1_prod_bodega;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROD_BODEGA". Cannot delete parent "BODEGA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_BODEGA before insert
on BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_bodega(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;

begin
    --  Parent "SUCURSAL" must exist when inserting a child in "BODEGA"
    if :new.SUC_CODIGO is not null then
       open  cpk1_bodega(:new.SUC_CODIGO);
       fetch cpk1_bodega into dummy;
       found := cpk1_bodega%FOUND;
       close cpk1_bodega;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot create child in "BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_BODEGA before update
of BOD__CODIGO,
   SUC_CODIGO
on BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_bodega(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PROD_BODEGA"
    cursor cfk1_prod_bodega(var_bod__codigo varchar) is
       select 1
       from   PROD_BODEGA
       where  BOD__CODIGO = var_bod__codigo
        and   var_bod__codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "SUCURSAL" must exist when updating a child in "BODEGA"
    if (:new.SUC_CODIGO is not null) and (seq = 0) then
       open  cpk1_bodega(:new.SUC_CODIGO);
       fetch cpk1_bodega into dummy;
       found := cpk1_bodega%FOUND;
       close cpk1_bodega;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot update child in "BODEGA".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "BODEGA" if children still exist in "PROD_BODEGA"
    if (updating('BOD__CODIGO') and :old.BOD__CODIGO != :new.BOD__CODIGO) then
       open  cfk1_prod_bodega(:old.BOD__CODIGO);
       fetch cfk1_prod_bodega into dummy;
       found := cfk1_prod_bodega%FOUND;
       close cfk1_prod_bodega;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROD_BODEGA". Cannot modify parent code in "BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_CATEGORIA_PRODUCTO before delete
on CATEG_PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PRODUCTO"
    cursor cfk1_producto(var_cat_codigo varchar) is
       select 1
       from   PRODUCTO
       where  CAT_CODIGO = var_cat_codigo
        and   var_cat_codigo is not null;

begin
    --  Cannot delete parent "CATEG_PRODUCTO" if children still exist in "PRODUCTO"
    open  cfk1_producto(:old.CAT_CODIGO);
    fetch cfk1_producto into dummy;
    found := cfk1_producto%FOUND;
    close cfk1_producto;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRODUCTO". Cannot delete parent "CATEG_PRODUCTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CATEGORIA_PRODUCTO before update
of CAT_CODIGO
on CATEG_PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "PRODUCTO"
    cursor cfk1_producto(var_cat_codigo varchar) is
       select 1
       from   PRODUCTO
       where  CAT_CODIGO = var_cat_codigo
        and   var_cat_codigo is not null;

begin
    --  Cannot modify parent code in "CATEG_PRODUCTO" if children still exist in "PRODUCTO"
    if (updating('CAT_CODIGO') and :old.CAT_CODIGO != :new.CAT_CODIGO) then
       open  cfk1_producto(:old.CAT_CODIGO);
       fetch cfk1_producto into dummy;
       found := cfk1_producto%FOUND;
       close cfk1_producto;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRODUCTO". Cannot modify parent code in "CATEG_PRODUCTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_CIUDAD before delete
on CIUDAD for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "SUCURSAL"
    cursor cfk1_sucursal(var_ciu_numero number) is
       select 1
       from   SUCURSAL
       where  CIU_NUMERO = var_ciu_numero
        and   var_ciu_numero is not null;

begin
    --  Cannot delete parent "CIUDAD" if children still exist in "SUCURSAL"
    open  cfk1_sucursal(:old.CIU_NUMERO);
    fetch cfk1_sucursal into dummy;
    found := cfk1_sucursal%FOUND;
    close cfk1_sucursal;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "SUCURSAL". Cannot delete parent "CIUDAD".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CIUDAD before insert
on CIUDAD for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PROVINCIA"
    cursor cpk1_ciudad(var_prv_numero number) is
       select 1
       from   PROVINCIA
       where  PRV_NUMERO = var_prv_numero
        and   var_prv_numero is not null;

begin
    --  Parent "PROVINCIA" must exist when inserting a child in "CIUDAD"
    if :new.PRV_NUMERO is not null then
       open  cpk1_ciudad(:new.PRV_NUMERO);
       fetch cpk1_ciudad into dummy;
       found := cpk1_ciudad%FOUND;
       close cpk1_ciudad;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PROVINCIA". Cannot create child in "CIUDAD".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CIUDAD before update
of CIU_NUMERO,
   PRV_NUMERO
on CIUDAD for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PROVINCIA"
    cursor cpk1_ciudad(var_prv_numero number) is
       select 1
       from   PROVINCIA
       where  PRV_NUMERO = var_prv_numero
        and   var_prv_numero is not null;
    --  Declaration of UpdateParentRestrict constraint for "SUCURSAL"
    cursor cfk1_sucursal(var_ciu_numero number) is
       select 1
       from   SUCURSAL
       where  CIU_NUMERO = var_ciu_numero
        and   var_ciu_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PROVINCIA" must exist when updating a child in "CIUDAD"
    if (:new.PRV_NUMERO is not null) and (seq = 0) then
       open  cpk1_ciudad(:new.PRV_NUMERO);
       fetch cpk1_ciudad into dummy;
       found := cpk1_ciudad%FOUND;
       close cpk1_ciudad;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PROVINCIA". Cannot update child in "CIUDAD".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "CIUDAD" if children still exist in "SUCURSAL"
    if (updating('CIU_NUMERO') and :old.CIU_NUMERO != :new.CIU_NUMERO) then
       open  cfk1_sucursal(:old.CIU_NUMERO);
       fetch cfk1_sucursal into dummy;
       found := cfk1_sucursal%FOUND;
       close cfk1_sucursal;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "SUCURSAL". Cannot modify parent code in "CIUDAD".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_CLIENTE before delete
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "FACTURA"
    cursor cfk1_factura(var_cli_num_documento varchar) is
       select 1
       from   FACTURA
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;
    --  Declaration of DeleteParentRestrict constraint for "CLIENTE_EMPLEADO"
    cursor cfk2_cliente_empleado(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE_EMPLEADO
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;

begin
    --  Cannot delete parent "CLIENTE" if children still exist in "FACTURA"
    open  cfk1_factura(:old.CLI_NUM_DOCUMENTO);
    fetch cfk1_factura into dummy;
    found := cfk1_factura%FOUND;
    close cfk1_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "FACTURA". Cannot delete parent "CLIENTE".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "CLIENTE" if children still exist in "CLIENTE_EMPLEADO"
    open  cfk2_cliente_empleado(:old.CLI_NUM_DOCUMENTO);
    fetch cfk2_cliente_empleado into dummy;
    found := cfk2_cliente_empleado%FOUND;
    close cfk2_cliente_empleado;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "CLIENTE_EMPLEADO". Cannot delete parent "CLIENTE".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CLIENTE before insert
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_cliente(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;

begin
    --  Parent "EMPRESA" must exist when inserting a child in "CLIENTE"
    if :new.EMP_CEDULA_RUC is not null then
       open  cpk1_cliente(:new.EMP_CEDULA_RUC);
       fetch cpk1_cliente into dummy;
       found := cpk1_cliente%FOUND;
       close cpk1_cliente;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot create child in "CLIENTE".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CLIENTE before update
of CLI_NUM_DOCUMENTO,
   EMP_CEDULA_RUC
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_cliente(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;
    --  Declaration of UpdateParentRestrict constraint for "FACTURA"
    cursor cfk1_factura(var_cli_num_documento varchar) is
       select 1
       from   FACTURA
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;
    --  Declaration of UpdateParentRestrict constraint for "CLIENTE_EMPLEADO"
    cursor cfk2_cliente_empleado(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE_EMPLEADO
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "EMPRESA" must exist when updating a child in "CLIENTE"
    if (:new.EMP_CEDULA_RUC is not null) and (seq = 0) then
       open  cpk1_cliente(:new.EMP_CEDULA_RUC);
       fetch cpk1_cliente into dummy;
       found := cpk1_cliente%FOUND;
       close cpk1_cliente;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot update child in "CLIENTE".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "CLIENTE" if children still exist in "FACTURA"
    if (updating('CLI_NUM_DOCUMENTO') and :old.CLI_NUM_DOCUMENTO != :new.CLI_NUM_DOCUMENTO) then
       open  cfk1_factura(:old.CLI_NUM_DOCUMENTO);
       fetch cfk1_factura into dummy;
       found := cfk1_factura%FOUND;
       close cfk1_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "FACTURA". Cannot modify parent code in "CLIENTE".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "CLIENTE" if children still exist in "CLIENTE_EMPLEADO"
    if (updating('CLI_NUM_DOCUMENTO') and :old.CLI_NUM_DOCUMENTO != :new.CLI_NUM_DOCUMENTO) then
       open  cfk2_cliente_empleado(:old.CLI_NUM_DOCUMENTO);
       fetch cfk2_cliente_empleado into dummy;
       found := cfk2_cliente_empleado%FOUND;
       close cfk2_cliente_empleado;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "CLIENTE_EMPLEADO". Cannot modify parent code in "CLIENTE".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CLIENTE_EMPLEADO before insert
on CLIENTE_EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "EMPLEADO"
    cursor cpk1_cliente_empleado(var_emd_num_documento varchar) is
       select 1
       from   EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "CLIENTE"
    cursor cpk2_cliente_empleado(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;

begin
    --  Parent "EMPLEADO" must exist when inserting a child in "CLIENTE_EMPLEADO"
    if :new.EMD_NUM_DOCUMENTO is not null then
       open  cpk1_cliente_empleado(:new.EMD_NUM_DOCUMENTO);
       fetch cpk1_cliente_empleado into dummy;
       found := cpk1_cliente_empleado%FOUND;
       close cpk1_cliente_empleado;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "EMPLEADO". Cannot create child in "CLIENTE_EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CLIENTE" must exist when inserting a child in "CLIENTE_EMPLEADO"
    if :new.CLI_NUM_DOCUMENTO is not null then
       open  cpk2_cliente_empleado(:new.CLI_NUM_DOCUMENTO);
       fetch cpk2_cliente_empleado into dummy;
       found := cpk2_cliente_empleado%FOUND;
       close cpk2_cliente_empleado;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot create child in "CLIENTE_EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CLIENTE_EMPLEADO before update
of CLI_NUM_DOCUMENTO,
   EMD_NUM_DOCUMENTO
on CLIENTE_EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "EMPLEADO"
    cursor cpk1_cliente_empleado(var_emd_num_documento varchar) is
       select 1
       from   EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "CLIENTE"
    cursor cpk2_cliente_empleado(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "EMPLEADO" must exist when updating a child in "CLIENTE_EMPLEADO"
    if (:new.EMD_NUM_DOCUMENTO is not null) and (seq = 0) then
       open  cpk1_cliente_empleado(:new.EMD_NUM_DOCUMENTO);
       fetch cpk1_cliente_empleado into dummy;
       found := cpk1_cliente_empleado%FOUND;
       close cpk1_cliente_empleado;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "EMPLEADO". Cannot update child in "CLIENTE_EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CLIENTE" must exist when updating a child in "CLIENTE_EMPLEADO"
    if (:new.CLI_NUM_DOCUMENTO is not null) and (seq = 0) then
       open  cpk2_cliente_empleado(:new.CLI_NUM_DOCUMENTO);
       fetch cpk2_cliente_empleado into dummy;
       found := cpk2_cliente_empleado%FOUND;
       close cpk2_cliente_empleado;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot update child in "CLIENTE_EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_COMISION_VENTA before insert
on COMISION_VENTA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "EMPLEADO"
    cursor cpk1_comision_venta(var_emd_num_documento varchar) is
       select 1
       from   EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_comision_venta(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    --  Parent "EMPLEADO" must exist when inserting a child in "COMISION_VENTA"
    if :new.EMD_NUM_DOCUMENTO is not null then
       open  cpk1_comision_venta(:new.EMD_NUM_DOCUMENTO);
       fetch cpk1_comision_venta into dummy;
       found := cpk1_comision_venta%FOUND;
       close cpk1_comision_venta;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "EMPLEADO". Cannot create child in "COMISION_VENTA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when inserting a child in "COMISION_VENTA"
    if :new.FAC_NUMERO is not null then
       open  cpk2_comision_venta(:new.FAC_NUMERO);
       fetch cpk2_comision_venta into dummy;
       found := cpk2_comision_venta%FOUND;
       close cpk2_comision_venta;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "FACTURA". Cannot create child in "COMISION_VENTA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_COMISION_VENTA before update
of COM_NUMERO,
   EMD_NUM_DOCUMENTO,
   FAC_NUMERO
on COMISION_VENTA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "EMPLEADO"
    cursor cpk1_comision_venta(var_emd_num_documento varchar) is
       select 1
       from   EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_comision_venta(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "EMPLEADO" must exist when updating a child in "COMISION_VENTA"
    if (:new.EMD_NUM_DOCUMENTO is not null) and (seq = 0) then
       open  cpk1_comision_venta(:new.EMD_NUM_DOCUMENTO);
       fetch cpk1_comision_venta into dummy;
       found := cpk1_comision_venta%FOUND;
       close cpk1_comision_venta;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "EMPLEADO". Cannot update child in "COMISION_VENTA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when updating a child in "COMISION_VENTA"
    if (:new.FAC_NUMERO is not null) and (seq = 0) then
       open  cpk2_comision_venta(:new.FAC_NUMERO);
       fetch cpk2_comision_venta into dummy;
       found := cpk2_comision_venta%FOUND;
       close cpk2_comision_venta;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "FACTURA". Cannot update child in "COMISION_VENTA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_DEPARTAMENTO before delete
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "EMPLEADO"
    cursor cfk1_empleado(var_dep_codigo varchar) is
       select 1
       from   EMPLEADO
       where  DEP_CODIGO = var_dep_codigo
        and   var_dep_codigo is not null;

begin
    --  Cannot delete parent "DEPARTAMENTO" if children still exist in "EMPLEADO"
    open  cfk1_empleado(:old.DEP_CODIGO);
    fetch cfk1_empleado into dummy;
    found := cfk1_empleado%FOUND;
    close cfk1_empleado;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "EMPLEADO". Cannot delete parent "DEPARTAMENTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_DEPARTAMENTO before insert
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_departamento(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;

begin
    --  Parent "EMPRESA" must exist when inserting a child in "DEPARTAMENTO"
    if :new.EMP_CEDULA_RUC is not null then
       open  cpk1_departamento(:new.EMP_CEDULA_RUC);
       fetch cpk1_departamento into dummy;
       found := cpk1_departamento%FOUND;
       close cpk1_departamento;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot create child in "DEPARTAMENTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUA_DEPARTAMENTO after update
of DEP_CODIGO,
   EMP_CEDULA_RUC
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
begin
    IntegrityPackage.NextNestLevel;
    --  Modify parent code of "DEPARTAMENTO" for all children in "EMPLEADO"
    if (updating('DEP_CODIGO') and :old.DEP_CODIGO != :new.DEP_CODIGO) then
       update EMPLEADO
        set   DEP_CODIGO = :new.DEP_CODIGO
       where  DEP_CODIGO = :old.DEP_CODIGO;
    end if;

    IntegrityPackage.PreviousNestLevel;

--  Errors handling
exception
    when integrity_error then
       begin
       IntegrityPackage.InitNestLevel;
       raise_application_error(errno, errmsg);
       end;
end;
/


create trigger TUB_DEPARTAMENTO before update
of DEP_CODIGO,
   EMP_CEDULA_RUC
on DEPARTAMENTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_departamento(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "EMPRESA" must exist when updating a child in "DEPARTAMENTO"
    if (:new.EMP_CEDULA_RUC is not null) and (seq = 0) then
       open  cpk1_departamento(:new.EMP_CEDULA_RUC);
       fetch cpk1_departamento into dummy;
       found := cpk1_departamento%FOUND;
       close cpk1_departamento;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot update child in "DEPARTAMENTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_DETALLE_FACTURA before insert
on DETALLE_FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_detalle_factura(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_detalle_factura(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    --  Parent "PRODUCTO" must exist when inserting a child in "DETALLE_FACTURA"
    if :new.PRO_CODIGO is not null then
       open  cpk1_detalle_factura(:new.PRO_CODIGO);
       fetch cpk1_detalle_factura into dummy;
       found := cpk1_detalle_factura%FOUND;
       close cpk1_detalle_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "DETALLE_FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when inserting a child in "DETALLE_FACTURA"
    if :new.FAC_NUMERO is not null then
       open  cpk2_detalle_factura(:new.FAC_NUMERO);
       fetch cpk2_detalle_factura into dummy;
       found := cpk2_detalle_factura%FOUND;
       close cpk2_detalle_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "FACTURA". Cannot create child in "DETALLE_FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_DETALLE_FACTURA before update
of FAC_NUMERO,
   PRO_CODIGO
on DETALLE_FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_detalle_factura(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_detalle_factura(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PRODUCTO" must exist when updating a child in "DETALLE_FACTURA"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk1_detalle_factura(:new.PRO_CODIGO);
       fetch cpk1_detalle_factura into dummy;
       found := cpk1_detalle_factura%FOUND;
       close cpk1_detalle_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "DETALLE_FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when updating a child in "DETALLE_FACTURA"
    if (:new.FAC_NUMERO is not null) and (seq = 0) then
       open  cpk2_detalle_factura(:new.FAC_NUMERO);
       fetch cpk2_detalle_factura into dummy;
       found := cpk2_detalle_factura%FOUND;
       close cpk2_detalle_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "FACTURA". Cannot update child in "DETALLE_FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_EMPLEADO before delete
on EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "COMISION_VENTA"
    cursor cfk1_comision_venta(var_emd_num_documento varchar) is
       select 1
       from   COMISION_VENTA
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of DeleteParentRestrict constraint for "CLIENTE_EMPLEADO"
    cursor cfk2_cliente_empleado(var_emd_num_documento varchar) is
       select 1
       from   CLIENTE_EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;

begin
    --  Cannot delete parent "EMPLEADO" if children still exist in "COMISION_VENTA"
    open  cfk1_comision_venta(:old.EMD_NUM_DOCUMENTO);
    fetch cfk1_comision_venta into dummy;
    found := cfk1_comision_venta%FOUND;
    close cfk1_comision_venta;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "COMISION_VENTA". Cannot delete parent "EMPLEADO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "EMPLEADO" if children still exist in "CLIENTE_EMPLEADO"
    open  cfk2_cliente_empleado(:old.EMD_NUM_DOCUMENTO);
    fetch cfk2_cliente_empleado into dummy;
    found := cfk2_cliente_empleado%FOUND;
    close cfk2_cliente_empleado;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "CLIENTE_EMPLEADO". Cannot delete parent "EMPLEADO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_EMPLEADO before insert
on EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_empleado(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "DEPARTAMENTO"
    cursor cpk2_empleado(var_dep_codigo varchar) is
       select 1
       from   DEPARTAMENTO
       where  DEP_CODIGO = var_dep_codigo
        and   var_dep_codigo is not null;

begin
    --  Parent "SUCURSAL" must exist when inserting a child in "EMPLEADO"
    if :new.SUC_CODIGO is not null then
       open  cpk1_empleado(:new.SUC_CODIGO);
       fetch cpk1_empleado into dummy;
       found := cpk1_empleado%FOUND;
       close cpk1_empleado;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot create child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "DEPARTAMENTO" must exist when inserting a child in "EMPLEADO"
    if :new.DEP_CODIGO is not null then
       open  cpk2_empleado(:new.DEP_CODIGO);
       fetch cpk2_empleado into dummy;
       found := cpk2_empleado%FOUND;
       close cpk2_empleado;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "DEPARTAMENTO". Cannot create child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_EMPLEADO before update
of EMD_NUM_DOCUMENTO,
   SUC_CODIGO,
   DEP_CODIGO
on EMPLEADO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_empleado(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "DEPARTAMENTO"
    cursor cpk2_empleado(var_dep_codigo varchar) is
       select 1
       from   DEPARTAMENTO
       where  DEP_CODIGO = var_dep_codigo
        and   var_dep_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "COMISION_VENTA"
    cursor cfk1_comision_venta(var_emd_num_documento varchar) is
       select 1
       from   COMISION_VENTA
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;
    --  Declaration of UpdateParentRestrict constraint for "CLIENTE_EMPLEADO"
    cursor cfk2_cliente_empleado(var_emd_num_documento varchar) is
       select 1
       from   CLIENTE_EMPLEADO
       where  EMD_NUM_DOCUMENTO = var_emd_num_documento
        and   var_emd_num_documento is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "SUCURSAL" must exist when updating a child in "EMPLEADO"
    if (:new.SUC_CODIGO is not null) and (seq = 0) then
       open  cpk1_empleado(:new.SUC_CODIGO);
       fetch cpk1_empleado into dummy;
       found := cpk1_empleado%FOUND;
       close cpk1_empleado;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot update child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "DEPARTAMENTO" must exist when updating a child in "EMPLEADO"
    if (:new.DEP_CODIGO is not null) and (seq = 0) then
       open  cpk2_empleado(:new.DEP_CODIGO);
       fetch cpk2_empleado into dummy;
       found := cpk2_empleado%FOUND;
       close cpk2_empleado;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "DEPARTAMENTO". Cannot update child in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "EMPLEADO" if children still exist in "COMISION_VENTA"
    if (updating('EMD_NUM_DOCUMENTO') and :old.EMD_NUM_DOCUMENTO != :new.EMD_NUM_DOCUMENTO) then
       open  cfk1_comision_venta(:old.EMD_NUM_DOCUMENTO);
       fetch cfk1_comision_venta into dummy;
       found := cfk1_comision_venta%FOUND;
       close cfk1_comision_venta;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "COMISION_VENTA". Cannot modify parent code in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "EMPLEADO" if children still exist in "CLIENTE_EMPLEADO"
    if (updating('EMD_NUM_DOCUMENTO') and :old.EMD_NUM_DOCUMENTO != :new.EMD_NUM_DOCUMENTO) then
       open  cfk2_cliente_empleado(:old.EMD_NUM_DOCUMENTO);
       fetch cfk2_cliente_empleado into dummy;
       found := cfk2_cliente_empleado%FOUND;
       close cfk2_cliente_empleado;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "CLIENTE_EMPLEADO". Cannot modify parent code in "EMPLEADO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_EMPRESA before delete
on EMPRESA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "SUCURSAL"
    cursor cfk1_sucursal(var_emp_cedula_ruc varchar) is
       select 1
       from   SUCURSAL
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;
    --  Declaration of DeleteParentRestrict constraint for "CLIENTE"
    cursor cfk2_cliente(var_emp_cedula_ruc varchar) is
       select 1
       from   CLIENTE
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;
    --  Declaration of DeleteParentRestrict constraint for "DEPARTAMENTO"
    cursor cfk3_departamento(var_emp_cedula_ruc varchar) is
       select 1
       from   DEPARTAMENTO
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;

begin
    --  Cannot delete parent "EMPRESA" if children still exist in "SUCURSAL"
    open  cfk1_sucursal(:old.EMP_CEDULA_RUC);
    fetch cfk1_sucursal into dummy;
    found := cfk1_sucursal%FOUND;
    close cfk1_sucursal;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "SUCURSAL". Cannot delete parent "EMPRESA".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "EMPRESA" if children still exist in "CLIENTE"
    open  cfk2_cliente(:old.EMP_CEDULA_RUC);
    fetch cfk2_cliente into dummy;
    found := cfk2_cliente%FOUND;
    close cfk2_cliente;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "CLIENTE". Cannot delete parent "EMPRESA".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "EMPRESA" if children still exist in "DEPARTAMENTO"
    open  cfk3_departamento(:old.EMP_CEDULA_RUC);
    fetch cfk3_departamento into dummy;
    found := cfk3_departamento%FOUND;
    close cfk3_departamento;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "DEPARTAMENTO". Cannot delete parent "EMPRESA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUA_EMPRESA after update
of EMP_CEDULA_RUC
on EMPRESA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
begin
    IntegrityPackage.NextNestLevel;
    --  Modify parent code of "EMPRESA" for all children in "SUCURSAL"
    if (updating('EMP_CEDULA_RUC') and :old.EMP_CEDULA_RUC != :new.EMP_CEDULA_RUC) then
       update SUCURSAL
        set   EMP_CEDULA_RUC = :new.EMP_CEDULA_RUC
       where  EMP_CEDULA_RUC = :old.EMP_CEDULA_RUC;
    end if;

    --  Modify parent code of "EMPRESA" for all children in "CLIENTE"
    if (updating('EMP_CEDULA_RUC') and :old.EMP_CEDULA_RUC != :new.EMP_CEDULA_RUC) then
       update CLIENTE
        set   EMP_CEDULA_RUC = :new.EMP_CEDULA_RUC
       where  EMP_CEDULA_RUC = :old.EMP_CEDULA_RUC;
    end if;

    --  Modify parent code of "EMPRESA" for all children in "DEPARTAMENTO"
    if (updating('EMP_CEDULA_RUC') and :old.EMP_CEDULA_RUC != :new.EMP_CEDULA_RUC) then
       update DEPARTAMENTO
        set   EMP_CEDULA_RUC = :new.EMP_CEDULA_RUC
       where  EMP_CEDULA_RUC = :old.EMP_CEDULA_RUC;
    end if;

    IntegrityPackage.PreviousNestLevel;

--  Errors handling
exception
    when integrity_error then
       begin
       IntegrityPackage.InitNestLevel;
       raise_application_error(errno, errmsg);
       end;
end;
/


create trigger TDB_FACTURA before delete
on FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "DETALLE_FACTURA"
    cursor cfk1_detalle_factura(var_fac_numero number) is
       select 1
       from   DETALLE_FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;
    --  Declaration of DeleteParentRestrict constraint for "COMISION_VENTA"
    cursor cfk2_comision_venta(var_fac_numero number) is
       select 1
       from   COMISION_VENTA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;
    --  Declaration of DeleteParentRestrict constraint for "FRM_PAGO_FACTURA"
    cursor cfk3_frm_pago_factura(var_fac_numero number) is
       select 1
       from   FRM_PAGO_FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    --  Cannot delete parent "FACTURA" if children still exist in "DETALLE_FACTURA"
    open  cfk1_detalle_factura(:old.FAC_NUMERO);
    fetch cfk1_detalle_factura into dummy;
    found := cfk1_detalle_factura%FOUND;
    close cfk1_detalle_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "DETALLE_FACTURA". Cannot delete parent "FACTURA".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "FACTURA" if children still exist in "COMISION_VENTA"
    open  cfk2_comision_venta(:old.FAC_NUMERO);
    fetch cfk2_comision_venta into dummy;
    found := cfk2_comision_venta%FOUND;
    close cfk2_comision_venta;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "COMISION_VENTA". Cannot delete parent "FACTURA".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "FACTURA" if children still exist in "FRM_PAGO_FACTURA"
    open  cfk3_frm_pago_factura(:old.FAC_NUMERO);
    fetch cfk3_frm_pago_factura into dummy;
    found := cfk3_frm_pago_factura%FOUND;
    close cfk3_frm_pago_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "FRM_PAGO_FACTURA". Cannot delete parent "FACTURA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_FACTURA before insert
on FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_factura(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "CLIENTE"
    cursor cpk2_factura(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;

begin
    --  Parent "SUCURSAL" must exist when inserting a child in "FACTURA"
    if :new.SUC_CODIGO is not null then
       open  cpk1_factura(:new.SUC_CODIGO);
       fetch cpk1_factura into dummy;
       found := cpk1_factura%FOUND;
       close cpk1_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot create child in "FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CLIENTE" must exist when inserting a child in "FACTURA"
    if :new.CLI_NUM_DOCUMENTO is not null then
       open  cpk2_factura(:new.CLI_NUM_DOCUMENTO);
       fetch cpk2_factura into dummy;
       found := cpk2_factura%FOUND;
       close cpk2_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot create child in "FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_FACTURA before update
of FAC_NUMERO,
   SUC_CODIGO,
   CLI_NUM_DOCUMENTO
on FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_factura(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "CLIENTE"
    cursor cpk2_factura(var_cli_num_documento varchar) is
       select 1
       from   CLIENTE
       where  CLI_NUM_DOCUMENTO = var_cli_num_documento
        and   var_cli_num_documento is not null;
    --  Declaration of UpdateParentRestrict constraint for "DETALLE_FACTURA"
    cursor cfk1_detalle_factura(var_fac_numero number) is
       select 1
       from   DETALLE_FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;
    --  Declaration of UpdateParentRestrict constraint for "COMISION_VENTA"
    cursor cfk2_comision_venta(var_fac_numero number) is
       select 1
       from   COMISION_VENTA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;
    --  Declaration of UpdateParentRestrict constraint for "FRM_PAGO_FACTURA"
    cursor cfk3_frm_pago_factura(var_fac_numero number) is
       select 1
       from   FRM_PAGO_FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "SUCURSAL" must exist when updating a child in "FACTURA"
    if (:new.SUC_CODIGO is not null) and (seq = 0) then
       open  cpk1_factura(:new.SUC_CODIGO);
       fetch cpk1_factura into dummy;
       found := cpk1_factura%FOUND;
       close cpk1_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot update child in "FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CLIENTE" must exist when updating a child in "FACTURA"
    if (:new.CLI_NUM_DOCUMENTO is not null) and (seq = 0) then
       open  cpk2_factura(:new.CLI_NUM_DOCUMENTO);
       fetch cpk2_factura into dummy;
       found := cpk2_factura%FOUND;
       close cpk2_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "CLIENTE". Cannot update child in "FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "FACTURA" if children still exist in "DETALLE_FACTURA"
    if (updating('FAC_NUMERO') and :old.FAC_NUMERO != :new.FAC_NUMERO) then
       open  cfk1_detalle_factura(:old.FAC_NUMERO);
       fetch cfk1_detalle_factura into dummy;
       found := cfk1_detalle_factura%FOUND;
       close cfk1_detalle_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "DETALLE_FACTURA". Cannot modify parent code in "FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "FACTURA" if children still exist in "COMISION_VENTA"
    if (updating('FAC_NUMERO') and :old.FAC_NUMERO != :new.FAC_NUMERO) then
       open  cfk2_comision_venta(:old.FAC_NUMERO);
       fetch cfk2_comision_venta into dummy;
       found := cfk2_comision_venta%FOUND;
       close cfk2_comision_venta;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "COMISION_VENTA". Cannot modify parent code in "FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "FACTURA" if children still exist in "FRM_PAGO_FACTURA"
    if (updating('FAC_NUMERO') and :old.FAC_NUMERO != :new.FAC_NUMERO) then
       open  cfk3_frm_pago_factura(:old.FAC_NUMERO);
       fetch cfk3_frm_pago_factura into dummy;
       found := cfk3_frm_pago_factura%FOUND;
       close cfk3_frm_pago_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "FRM_PAGO_FACTURA". Cannot modify parent code in "FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_FORMA_PAGO before delete
on FORMA_PAGO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "FRM_PAGO_FACTURA"
    cursor cfk1_frm_pago_factura(var_frp_codigo varchar) is
       select 1
       from   FRM_PAGO_FACTURA
       where  FRP_CODIGO = var_frp_codigo
        and   var_frp_codigo is not null;

begin
    --  Cannot delete parent "FORMA_PAGO" if children still exist in "FRM_PAGO_FACTURA"
    open  cfk1_frm_pago_factura(:old.FRP_CODIGO);
    fetch cfk1_frm_pago_factura into dummy;
    found := cfk1_frm_pago_factura%FOUND;
    close cfk1_frm_pago_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "FRM_PAGO_FACTURA". Cannot delete parent "FORMA_PAGO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_FORMA_PAGO before update
of FRP_CODIGO
on FORMA_PAGO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "FRM_PAGO_FACTURA"
    cursor cfk1_frm_pago_factura(var_frp_codigo varchar) is
       select 1
       from   FRM_PAGO_FACTURA
       where  FRP_CODIGO = var_frp_codigo
        and   var_frp_codigo is not null;

begin
    --  Cannot modify parent code in "FORMA_PAGO" if children still exist in "FRM_PAGO_FACTURA"
    if (updating('FRP_CODIGO') and :old.FRP_CODIGO != :new.FRP_CODIGO) then
       open  cfk1_frm_pago_factura(:old.FRP_CODIGO);
       fetch cfk1_frm_pago_factura into dummy;
       found := cfk1_frm_pago_factura%FOUND;
       close cfk1_frm_pago_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "FRM_PAGO_FACTURA". Cannot modify parent code in "FORMA_PAGO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_FRM_PAGO_FACTURA before insert
on FRM_PAGO_FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "FORMA_PAGO"
    cursor cpk1_frm_pago_factura(var_frp_codigo varchar) is
       select 1
       from   FORMA_PAGO
       where  FRP_CODIGO = var_frp_codigo
        and   var_frp_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_frm_pago_factura(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    --  Parent "FORMA_PAGO" must exist when inserting a child in "FRM_PAGO_FACTURA"
    if :new.FRP_CODIGO is not null then
       open  cpk1_frm_pago_factura(:new.FRP_CODIGO);
       fetch cpk1_frm_pago_factura into dummy;
       found := cpk1_frm_pago_factura%FOUND;
       close cpk1_frm_pago_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "FORMA_PAGO". Cannot create child in "FRM_PAGO_FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when inserting a child in "FRM_PAGO_FACTURA"
    if :new.FAC_NUMERO is not null then
       open  cpk2_frm_pago_factura(:new.FAC_NUMERO);
       fetch cpk2_frm_pago_factura into dummy;
       found := cpk2_frm_pago_factura%FOUND;
       close cpk2_frm_pago_factura;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "FACTURA". Cannot create child in "FRM_PAGO_FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_FRM_PAGO_FACTURA before update
of FAC_NUMERO,
   FRP_CODIGO
on FRM_PAGO_FACTURA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "FORMA_PAGO"
    cursor cpk1_frm_pago_factura(var_frp_codigo varchar) is
       select 1
       from   FORMA_PAGO
       where  FRP_CODIGO = var_frp_codigo
        and   var_frp_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "FACTURA"
    cursor cpk2_frm_pago_factura(var_fac_numero number) is
       select 1
       from   FACTURA
       where  FAC_NUMERO = var_fac_numero
        and   var_fac_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "FORMA_PAGO" must exist when updating a child in "FRM_PAGO_FACTURA"
    if (:new.FRP_CODIGO is not null) and (seq = 0) then
       open  cpk1_frm_pago_factura(:new.FRP_CODIGO);
       fetch cpk1_frm_pago_factura into dummy;
       found := cpk1_frm_pago_factura%FOUND;
       close cpk1_frm_pago_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "FORMA_PAGO". Cannot update child in "FRM_PAGO_FACTURA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "FACTURA" must exist when updating a child in "FRM_PAGO_FACTURA"
    if (:new.FAC_NUMERO is not null) and (seq = 0) then
       open  cpk2_frm_pago_factura(:new.FAC_NUMERO);
       fetch cpk2_frm_pago_factura into dummy;
       found := cpk2_frm_pago_factura%FOUND;
       close cpk2_frm_pago_factura;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "FACTURA". Cannot update child in "FRM_PAGO_FACTURA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_MOVIMIENTO_BODEGA before insert
on MOVIMIENTO_BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "TRANSACCION"
    cursor cpk1_movimiento_bodega(var_trs_codigo varchar) is
       select 1
       from   TRANSACCION
       where  TRS_CODIGO = var_trs_codigo
        and   var_trs_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_movimiento_bodega(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    --  Parent "TRANSACCION" must exist when inserting a child in "MOVIMIENTO_BODEGA"
    if :new.TRS_CODIGO is not null then
       open  cpk1_movimiento_bodega(:new.TRS_CODIGO);
       fetch cpk1_movimiento_bodega into dummy;
       found := cpk1_movimiento_bodega%FOUND;
       close cpk1_movimiento_bodega;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "TRANSACCION". Cannot create child in "MOVIMIENTO_BODEGA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when inserting a child in "MOVIMIENTO_BODEGA"
    if :new.PRO_CODIGO is not null then
       open  cpk2_movimiento_bodega(:new.PRO_CODIGO);
       fetch cpk2_movimiento_bodega into dummy;
       found := cpk2_movimiento_bodega%FOUND;
       close cpk2_movimiento_bodega;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "MOVIMIENTO_BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_MOVIMIENTO_BODEGA before update
of PRO_CODIGO,
   TRS_CODIGO
on MOVIMIENTO_BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "TRANSACCION"
    cursor cpk1_movimiento_bodega(var_trs_codigo varchar) is
       select 1
       from   TRANSACCION
       where  TRS_CODIGO = var_trs_codigo
        and   var_trs_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_movimiento_bodega(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "TRANSACCION" must exist when updating a child in "MOVIMIENTO_BODEGA"
    if (:new.TRS_CODIGO is not null) and (seq = 0) then
       open  cpk1_movimiento_bodega(:new.TRS_CODIGO);
       fetch cpk1_movimiento_bodega into dummy;
       found := cpk1_movimiento_bodega%FOUND;
       close cpk1_movimiento_bodega;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "TRANSACCION". Cannot update child in "MOVIMIENTO_BODEGA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when updating a child in "MOVIMIENTO_BODEGA"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk2_movimiento_bodega(:new.PRO_CODIGO);
       fetch cpk2_movimiento_bodega into dummy;
       found := cpk2_movimiento_bodega%FOUND;
       close cpk2_movimiento_bodega;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "MOVIMIENTO_BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_ORDEN_COMPRA before delete
on ORDEN_COMPRA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PROD_ORDEN_COMPRA"
    cursor cfk1_prod_orden_compra(var_orc_numero number) is
       select 1
       from   PROD_ORDEN_COMPRA
       where  ORC_NUMERO = var_orc_numero
        and   var_orc_numero is not null;

begin
    --  Cannot delete parent "ORDEN_COMPRA" if children still exist in "PROD_ORDEN_COMPRA"
    open  cfk1_prod_orden_compra(:old.ORC_NUMERO);
    fetch cfk1_prod_orden_compra into dummy;
    found := cfk1_prod_orden_compra%FOUND;
    close cfk1_prod_orden_compra;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROD_ORDEN_COMPRA". Cannot delete parent "ORDEN_COMPRA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_ORDEN_COMPRA before insert
on ORDEN_COMPRA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_orden_compra(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PROVEEDOR"
    cursor cpk2_orden_compra(var_prd_cedula_ruc varchar) is
       select 1
       from   PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;

begin
    --  Parent "SUCURSAL" must exist when inserting a child in "ORDEN_COMPRA"
    if :new.SUC_CODIGO is not null then
       open  cpk1_orden_compra(:new.SUC_CODIGO);
       fetch cpk1_orden_compra into dummy;
       found := cpk1_orden_compra%FOUND;
       close cpk1_orden_compra;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot create child in "ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROVEEDOR" must exist when inserting a child in "ORDEN_COMPRA"
    if :new.PRD_CEDULA_RUC is not null then
       open  cpk2_orden_compra(:new.PRD_CEDULA_RUC);
       fetch cpk2_orden_compra into dummy;
       found := cpk2_orden_compra%FOUND;
       close cpk2_orden_compra;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PROVEEDOR". Cannot create child in "ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_ORDEN_COMPRA before update
of ORC_NUMERO,
   SUC_CODIGO,
   PRD_CEDULA_RUC
on ORDEN_COMPRA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_orden_compra(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PROVEEDOR"
    cursor cpk2_orden_compra(var_prd_cedula_ruc varchar) is
       select 1
       from   PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;
    --  Declaration of UpdateParentRestrict constraint for "PROD_ORDEN_COMPRA"
    cursor cfk1_prod_orden_compra(var_orc_numero number) is
       select 1
       from   PROD_ORDEN_COMPRA
       where  ORC_NUMERO = var_orc_numero
        and   var_orc_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "SUCURSAL" must exist when updating a child in "ORDEN_COMPRA"
    if (:new.SUC_CODIGO is not null) and (seq = 0) then
       open  cpk1_orden_compra(:new.SUC_CODIGO);
       fetch cpk1_orden_compra into dummy;
       found := cpk1_orden_compra%FOUND;
       close cpk1_orden_compra;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot update child in "ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROVEEDOR" must exist when updating a child in "ORDEN_COMPRA"
    if (:new.PRD_CEDULA_RUC is not null) and (seq = 0) then
       open  cpk2_orden_compra(:new.PRD_CEDULA_RUC);
       fetch cpk2_orden_compra into dummy;
       found := cpk2_orden_compra%FOUND;
       close cpk2_orden_compra;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PROVEEDOR". Cannot update child in "ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "ORDEN_COMPRA" if children still exist in "PROD_ORDEN_COMPRA"
    if (updating('ORC_NUMERO') and :old.ORC_NUMERO != :new.ORC_NUMERO) then
       open  cfk1_prod_orden_compra(:old.ORC_NUMERO);
       fetch cfk1_prod_orden_compra into dummy;
       found := cfk1_prod_orden_compra%FOUND;
       close cfk1_prod_orden_compra;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROD_ORDEN_COMPRA". Cannot modify parent code in "ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO_PROMOCION before insert
on PRD_PROMOCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prd_promocion(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PROMOCION"
    cursor cpk2_prd_promocion(var_prm_codigo varchar) is
       select 1
       from   PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    --  Parent "PRODUCTO" must exist when inserting a child in "PRD_PROMOCION"
    if :new.PRO_CODIGO is not null then
       open  cpk1_prd_promocion(:new.PRO_CODIGO);
       fetch cpk1_prd_promocion into dummy;
       found := cpk1_prd_promocion%FOUND;
       close cpk1_prd_promocion;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "PRD_PROMOCION".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROMOCION" must exist when inserting a child in "PRD_PROMOCION"
    if :new.PRM_CODIGO is not null then
       open  cpk2_prd_promocion(:new.PRM_CODIGO);
       fetch cpk2_prd_promocion into dummy;
       found := cpk2_prd_promocion%FOUND;
       close cpk2_prd_promocion;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PROMOCION". Cannot create child in "PRD_PROMOCION".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO_PROMOCION before update
of PRM_CODIGO,
   PRO_CODIGO
on PRD_PROMOCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prd_promocion(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PROMOCION"
    cursor cpk2_prd_promocion(var_prm_codigo varchar) is
       select 1
       from   PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PRODUCTO" must exist when updating a child in "PRD_PROMOCION"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk1_prd_promocion(:new.PRO_CODIGO);
       fetch cpk1_prd_promocion into dummy;
       found := cpk1_prd_promocion%FOUND;
       close cpk1_prd_promocion;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "PRD_PROMOCION".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROMOCION" must exist when updating a child in "PRD_PROMOCION"
    if (:new.PRM_CODIGO is not null) and (seq = 0) then
       open  cpk2_prd_promocion(:new.PRM_CODIGO);
       fetch cpk2_prd_promocion into dummy;
       found := cpk2_prd_promocion%FOUND;
       close cpk2_prd_promocion;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PROMOCION". Cannot update child in "PRD_PROMOCION".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO_PROVEEDOR before insert
on PRD_PROVEEDOR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PROVEEDOR"
    cursor cpk1_prd_proveedor(var_prd_cedula_ruc varchar) is
       select 1
       from   PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_prd_proveedor(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    --  Parent "PROVEEDOR" must exist when inserting a child in "PRD_PROVEEDOR"
    if :new.PRD_CEDULA_RUC is not null then
       open  cpk1_prd_proveedor(:new.PRD_CEDULA_RUC);
       fetch cpk1_prd_proveedor into dummy;
       found := cpk1_prd_proveedor%FOUND;
       close cpk1_prd_proveedor;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PROVEEDOR". Cannot create child in "PRD_PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when inserting a child in "PRD_PROVEEDOR"
    if :new.PRO_CODIGO is not null then
       open  cpk2_prd_proveedor(:new.PRO_CODIGO);
       fetch cpk2_prd_proveedor into dummy;
       found := cpk2_prd_proveedor%FOUND;
       close cpk2_prd_proveedor;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "PRD_PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO_PROVEEDOR before update
of PRO_CODIGO,
   PRD_CEDULA_RUC
on PRD_PROVEEDOR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PROVEEDOR"
    cursor cpk1_prd_proveedor(var_prd_cedula_ruc varchar) is
       select 1
       from   PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_prd_proveedor(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PROVEEDOR" must exist when updating a child in "PRD_PROVEEDOR"
    if (:new.PRD_CEDULA_RUC is not null) and (seq = 0) then
       open  cpk1_prd_proveedor(:new.PRD_CEDULA_RUC);
       fetch cpk1_prd_proveedor into dummy;
       found := cpk1_prd_proveedor%FOUND;
       close cpk1_prd_proveedor;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PROVEEDOR". Cannot update child in "PRD_PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when updating a child in "PRD_PROVEEDOR"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk2_prd_proveedor(:new.PRO_CODIGO);
       fetch cpk2_prd_proveedor into dummy;
       found := cpk2_prd_proveedor%FOUND;
       close cpk2_prd_proveedor;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "PRD_PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_PRODUCTO before delete
on PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PRD_PROVEEDOR"
    cursor cfk1_prd_proveedor(var_pro_codigo varchar) is
       select 1
       from   PRD_PROVEEDOR
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "PROD_ORDEN_COMPRA"
    cursor cfk2_prod_orden_compra(var_pro_codigo varchar) is
       select 1
       from   PROD_ORDEN_COMPRA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "UNIDAD_ALTERNATIVA"
    cursor cfk3_unidad_alternativa(var_pro_codigo varchar) is
       select 1
       from   UNIDAD_ALTERNATIVA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "DETALLE_FACTURA"
    cursor cfk4_detalle_factura(var_pro_codigo varchar) is
       select 1
       from   DETALLE_FACTURA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "PRD_PROMOCION"
    cursor cfk5_prd_promocion(var_pro_codigo varchar) is
       select 1
       from   PRD_PROMOCION
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "PROD_BODEGA"
    cursor cfk6_prod_bodega(var_pro_codigo varchar) is
       select 1
       from   PROD_BODEGA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "MOVIMIENTO_BODEGA"
    cursor cfk7_movimiento_bodega(var_pro_codigo varchar) is
       select 1
       from   MOVIMIENTO_BODEGA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    --  Cannot delete parent "PRODUCTO" if children still exist in "PRD_PROVEEDOR"
    open  cfk1_prd_proveedor(:old.PRO_CODIGO);
    fetch cfk1_prd_proveedor into dummy;
    found := cfk1_prd_proveedor%FOUND;
    close cfk1_prd_proveedor;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRD_PROVEEDOR". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "PROD_ORDEN_COMPRA"
    open  cfk2_prod_orden_compra(:old.PRO_CODIGO);
    fetch cfk2_prod_orden_compra into dummy;
    found := cfk2_prod_orden_compra%FOUND;
    close cfk2_prod_orden_compra;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROD_ORDEN_COMPRA". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "UNIDAD_ALTERNATIVA"
    open  cfk3_unidad_alternativa(:old.PRO_CODIGO);
    fetch cfk3_unidad_alternativa into dummy;
    found := cfk3_unidad_alternativa%FOUND;
    close cfk3_unidad_alternativa;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "UNIDAD_ALTERNATIVA". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "DETALLE_FACTURA"
    open  cfk4_detalle_factura(:old.PRO_CODIGO);
    fetch cfk4_detalle_factura into dummy;
    found := cfk4_detalle_factura%FOUND;
    close cfk4_detalle_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "DETALLE_FACTURA". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "PRD_PROMOCION"
    open  cfk5_prd_promocion(:old.PRO_CODIGO);
    fetch cfk5_prd_promocion into dummy;
    found := cfk5_prd_promocion%FOUND;
    close cfk5_prd_promocion;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRD_PROMOCION". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "PROD_BODEGA"
    open  cfk6_prod_bodega(:old.PRO_CODIGO);
    fetch cfk6_prod_bodega into dummy;
    found := cfk6_prod_bodega%FOUND;
    close cfk6_prod_bodega;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROD_BODEGA". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PRODUCTO" if children still exist in "MOVIMIENTO_BODEGA"
    open  cfk7_movimiento_bodega(:old.PRO_CODIGO);
    fetch cfk7_movimiento_bodega into dummy;
    found := cfk7_movimiento_bodega%FOUND;
    close cfk7_movimiento_bodega;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "MOVIMIENTO_BODEGA". Cannot delete parent "PRODUCTO".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO before insert
on PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "CATEG_PRODUCTO"
    cursor cpk1_producto(var_cat_codigo varchar) is
       select 1
       from   CATEG_PRODUCTO
       where  CAT_CODIGO = var_cat_codigo
        and   var_cat_codigo is not null;

begin
    --  Parent "CATEG_PRODUCTO" must exist when inserting a child in "PRODUCTO"
    if :new.CAT_CODIGO is not null then
       open  cpk1_producto(:new.CAT_CODIGO);
       fetch cpk1_producto into dummy;
       found := cpk1_producto%FOUND;
       close cpk1_producto;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "CATEG_PRODUCTO". Cannot create child in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO before update
of PRO_CODIGO,
   CAT_CODIGO
on PRODUCTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "CATEG_PRODUCTO"
    cursor cpk1_producto(var_cat_codigo varchar) is
       select 1
       from   CATEG_PRODUCTO
       where  CAT_CODIGO = var_cat_codigo
        and   var_cat_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PRD_PROVEEDOR"
    cursor cfk1_prd_proveedor(var_pro_codigo varchar) is
       select 1
       from   PRD_PROVEEDOR
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PROD_ORDEN_COMPRA"
    cursor cfk2_prod_orden_compra(var_pro_codigo varchar) is
       select 1
       from   PROD_ORDEN_COMPRA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "UNIDAD_ALTERNATIVA"
    cursor cfk3_unidad_alternativa(var_pro_codigo varchar) is
       select 1
       from   UNIDAD_ALTERNATIVA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "DETALLE_FACTURA"
    cursor cfk4_detalle_factura(var_pro_codigo varchar) is
       select 1
       from   DETALLE_FACTURA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PRD_PROMOCION"
    cursor cfk5_prd_promocion(var_pro_codigo varchar) is
       select 1
       from   PRD_PROMOCION
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PROD_BODEGA"
    cursor cfk6_prod_bodega(var_pro_codigo varchar) is
       select 1
       from   PROD_BODEGA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "MOVIMIENTO_BODEGA"
    cursor cfk7_movimiento_bodega(var_pro_codigo varchar) is
       select 1
       from   MOVIMIENTO_BODEGA
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "CATEG_PRODUCTO" must exist when updating a child in "PRODUCTO"
    if (:new.CAT_CODIGO is not null) and (seq = 0) then
       open  cpk1_producto(:new.CAT_CODIGO);
       fetch cpk1_producto into dummy;
       found := cpk1_producto%FOUND;
       close cpk1_producto;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "CATEG_PRODUCTO". Cannot update child in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "PRD_PROVEEDOR"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk1_prd_proveedor(:old.PRO_CODIGO);
       fetch cfk1_prd_proveedor into dummy;
       found := cfk1_prd_proveedor%FOUND;
       close cfk1_prd_proveedor;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRD_PROVEEDOR". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "PROD_ORDEN_COMPRA"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk2_prod_orden_compra(:old.PRO_CODIGO);
       fetch cfk2_prod_orden_compra into dummy;
       found := cfk2_prod_orden_compra%FOUND;
       close cfk2_prod_orden_compra;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROD_ORDEN_COMPRA". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "UNIDAD_ALTERNATIVA"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk3_unidad_alternativa(:old.PRO_CODIGO);
       fetch cfk3_unidad_alternativa into dummy;
       found := cfk3_unidad_alternativa%FOUND;
       close cfk3_unidad_alternativa;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "UNIDAD_ALTERNATIVA". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "DETALLE_FACTURA"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk4_detalle_factura(:old.PRO_CODIGO);
       fetch cfk4_detalle_factura into dummy;
       found := cfk4_detalle_factura%FOUND;
       close cfk4_detalle_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "DETALLE_FACTURA". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "PRD_PROMOCION"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk5_prd_promocion(:old.PRO_CODIGO);
       fetch cfk5_prd_promocion into dummy;
       found := cfk5_prd_promocion%FOUND;
       close cfk5_prd_promocion;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRD_PROMOCION". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "PROD_BODEGA"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk6_prod_bodega(:old.PRO_CODIGO);
       fetch cfk6_prod_bodega into dummy;
       found := cfk6_prod_bodega%FOUND;
       close cfk6_prod_bodega;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROD_BODEGA". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PRODUCTO" if children still exist in "MOVIMIENTO_BODEGA"
    if (updating('PRO_CODIGO') and :old.PRO_CODIGO != :new.PRO_CODIGO) then
       open  cfk7_movimiento_bodega(:old.PRO_CODIGO);
       fetch cfk7_movimiento_bodega into dummy;
       found := cfk7_movimiento_bodega%FOUND;
       close cfk7_movimiento_bodega;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "MOVIMIENTO_BODEGA". Cannot modify parent code in "PRODUCTO".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO_BODEGA before insert
on PROD_BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prod_bodega(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "BODEGA"
    cursor cpk2_prod_bodega(var_bod__codigo varchar) is
       select 1
       from   BODEGA
       where  BOD__CODIGO = var_bod__codigo
        and   var_bod__codigo is not null;

begin
    --  Parent "PRODUCTO" must exist when inserting a child in "PROD_BODEGA"
    if :new.PRO_CODIGO is not null then
       open  cpk1_prod_bodega(:new.PRO_CODIGO);
       fetch cpk1_prod_bodega into dummy;
       found := cpk1_prod_bodega%FOUND;
       close cpk1_prod_bodega;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "PROD_BODEGA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "BODEGA" must exist when inserting a child in "PROD_BODEGA"
    if :new.BOD__CODIGO is not null then
       open  cpk2_prod_bodega(:new.BOD__CODIGO);
       fetch cpk2_prod_bodega into dummy;
       found := cpk2_prod_bodega%FOUND;
       close cpk2_prod_bodega;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "BODEGA". Cannot create child in "PROD_BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO_BODEGA before update
of BOD__CODIGO,
   PRO_CODIGO
on PROD_BODEGA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prod_bodega(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "BODEGA"
    cursor cpk2_prod_bodega(var_bod__codigo varchar) is
       select 1
       from   BODEGA
       where  BOD__CODIGO = var_bod__codigo
        and   var_bod__codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PRODUCTO" must exist when updating a child in "PROD_BODEGA"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk1_prod_bodega(:new.PRO_CODIGO);
       fetch cpk1_prod_bodega into dummy;
       found := cpk1_prod_bodega%FOUND;
       close cpk1_prod_bodega;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "PROD_BODEGA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "BODEGA" must exist when updating a child in "PROD_BODEGA"
    if (:new.BOD__CODIGO is not null) and (seq = 0) then
       open  cpk2_prod_bodega(:new.BOD__CODIGO);
       fetch cpk2_prod_bodega into dummy;
       found := cpk2_prod_bodega%FOUND;
       close cpk2_prod_bodega;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "BODEGA". Cannot update child in "PROD_BODEGA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PRODUCTO_ORDEN_COMPRA before insert
on PROD_ORDEN_COMPRA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prod_orden_compra(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "ORDEN_COMPRA"
    cursor cpk2_prod_orden_compra(var_orc_numero number) is
       select 1
       from   ORDEN_COMPRA
       where  ORC_NUMERO = var_orc_numero
        and   var_orc_numero is not null;

begin
    --  Parent "PRODUCTO" must exist when inserting a child in "PROD_ORDEN_COMPRA"
    if :new.PRO_CODIGO is not null then
       open  cpk1_prod_orden_compra(:new.PRO_CODIGO);
       fetch cpk1_prod_orden_compra into dummy;
       found := cpk1_prod_orden_compra%FOUND;
       close cpk1_prod_orden_compra;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "PROD_ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "ORDEN_COMPRA" must exist when inserting a child in "PROD_ORDEN_COMPRA"
    if :new.ORC_NUMERO is not null then
       open  cpk2_prod_orden_compra(:new.ORC_NUMERO);
       fetch cpk2_prod_orden_compra into dummy;
       found := cpk2_prod_orden_compra%FOUND;
       close cpk2_prod_orden_compra;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "ORDEN_COMPRA". Cannot create child in "PROD_ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PRODUCTO_ORDEN_COMPRA before update
of ORC_NUMERO,
   PRO_CODIGO
on PROD_ORDEN_COMPRA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk1_prod_orden_compra(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "ORDEN_COMPRA"
    cursor cpk2_prod_orden_compra(var_orc_numero number) is
       select 1
       from   ORDEN_COMPRA
       where  ORC_NUMERO = var_orc_numero
        and   var_orc_numero is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "PRODUCTO" must exist when updating a child in "PROD_ORDEN_COMPRA"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk1_prod_orden_compra(:new.PRO_CODIGO);
       fetch cpk1_prod_orden_compra into dummy;
       found := cpk1_prod_orden_compra%FOUND;
       close cpk1_prod_orden_compra;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "PROD_ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "ORDEN_COMPRA" must exist when updating a child in "PROD_ORDEN_COMPRA"
    if (:new.ORC_NUMERO is not null) and (seq = 0) then
       open  cpk2_prod_orden_compra(:new.ORC_NUMERO);
       fetch cpk2_prod_orden_compra into dummy;
       found := cpk2_prod_orden_compra%FOUND;
       close cpk2_prod_orden_compra;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "ORDEN_COMPRA". Cannot update child in "PROD_ORDEN_COMPRA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_PROMOCION before delete
on PROMOCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "PROMOC_SUCURSAL"
    cursor cfk1_promoc_sucursal(var_prm_codigo varchar) is
       select 1
       from   PROMOC_SUCURSAL
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "PRD_PROMOCION"
    cursor cfk2_prd_promocion(var_prm_codigo varchar) is
       select 1
       from   PRD_PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    --  Cannot delete parent "PROMOCION" if children still exist in "PROMOC_SUCURSAL"
    open  cfk1_promoc_sucursal(:old.PRM_CODIGO);
    fetch cfk1_promoc_sucursal into dummy;
    found := cfk1_promoc_sucursal%FOUND;
    close cfk1_promoc_sucursal;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROMOC_SUCURSAL". Cannot delete parent "PROMOCION".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PROMOCION" if children still exist in "PRD_PROMOCION"
    open  cfk2_prd_promocion(:old.PRM_CODIGO);
    fetch cfk2_prd_promocion into dummy;
    found := cfk2_prd_promocion%FOUND;
    close cfk2_prd_promocion;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRD_PROMOCION". Cannot delete parent "PROMOCION".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PROMOCION before update
of PRM_CODIGO
on PROMOCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "PROMOC_SUCURSAL"
    cursor cfk1_promoc_sucursal(var_prm_codigo varchar) is
       select 1
       from   PROMOC_SUCURSAL
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PRD_PROMOCION"
    cursor cfk2_prd_promocion(var_prm_codigo varchar) is
       select 1
       from   PRD_PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    --  Cannot modify parent code in "PROMOCION" if children still exist in "PROMOC_SUCURSAL"
    if (updating('PRM_CODIGO') and :old.PRM_CODIGO != :new.PRM_CODIGO) then
       open  cfk1_promoc_sucursal(:old.PRM_CODIGO);
       fetch cfk1_promoc_sucursal into dummy;
       found := cfk1_promoc_sucursal%FOUND;
       close cfk1_promoc_sucursal;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROMOC_SUCURSAL". Cannot modify parent code in "PROMOCION".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PROMOCION" if children still exist in "PRD_PROMOCION"
    if (updating('PRM_CODIGO') and :old.PRM_CODIGO != :new.PRM_CODIGO) then
       open  cfk2_prd_promocion(:old.PRM_CODIGO);
       fetch cfk2_prd_promocion into dummy;
       found := cfk2_prd_promocion%FOUND;
       close cfk2_prd_promocion;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRD_PROMOCION". Cannot modify parent code in "PROMOCION".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PROMOC_SUCURSAL before insert
on PROMOC_SUCURSAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_promoc_sucursal(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PROMOCION"
    cursor cpk2_promoc_sucursal(var_prm_codigo varchar) is
       select 1
       from   PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    --  Parent "SUCURSAL" must exist when inserting a child in "PROMOC_SUCURSAL"
    if :new.SUC_CODIGO is not null then
       open  cpk1_promoc_sucursal(:new.SUC_CODIGO);
       fetch cpk1_promoc_sucursal into dummy;
       found := cpk1_promoc_sucursal%FOUND;
       close cpk1_promoc_sucursal;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot create child in "PROMOC_SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROMOCION" must exist when inserting a child in "PROMOC_SUCURSAL"
    if :new.PRM_CODIGO is not null then
       open  cpk2_promoc_sucursal(:new.PRM_CODIGO);
       fetch cpk2_promoc_sucursal into dummy;
       found := cpk2_promoc_sucursal%FOUND;
       close cpk2_promoc_sucursal;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PROMOCION". Cannot create child in "PROMOC_SUCURSAL".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PROMOC_SUCURSAL before update
of PRM_CODIGO,
   SUC_CODIGO
on PROMOC_SUCURSAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "SUCURSAL"
    cursor cpk1_promoc_sucursal(var_suc_codigo varchar) is
       select 1
       from   SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PROMOCION"
    cursor cpk2_promoc_sucursal(var_prm_codigo varchar) is
       select 1
       from   PROMOCION
       where  PRM_CODIGO = var_prm_codigo
        and   var_prm_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "SUCURSAL" must exist when updating a child in "PROMOC_SUCURSAL"
    if (:new.SUC_CODIGO is not null) and (seq = 0) then
       open  cpk1_promoc_sucursal(:new.SUC_CODIGO);
       fetch cpk1_promoc_sucursal into dummy;
       found := cpk1_promoc_sucursal%FOUND;
       close cpk1_promoc_sucursal;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "SUCURSAL". Cannot update child in "PROMOC_SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PROMOCION" must exist when updating a child in "PROMOC_SUCURSAL"
    if (:new.PRM_CODIGO is not null) and (seq = 0) then
       open  cpk2_promoc_sucursal(:new.PRM_CODIGO);
       fetch cpk2_promoc_sucursal into dummy;
       found := cpk2_promoc_sucursal%FOUND;
       close cpk2_promoc_sucursal;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PROMOCION". Cannot update child in "PROMOC_SUCURSAL".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_PROVEEDOR before delete
on PROVEEDOR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "ORDEN_COMPRA"
    cursor cfk1_orden_compra(var_prd_cedula_ruc varchar) is
       select 1
       from   ORDEN_COMPRA
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;
    --  Declaration of DeleteParentRestrict constraint for "PRD_PROVEEDOR"
    cursor cfk2_prd_proveedor(var_prd_cedula_ruc varchar) is
       select 1
       from   PRD_PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;

begin
    --  Cannot delete parent "PROVEEDOR" if children still exist in "ORDEN_COMPRA"
    open  cfk1_orden_compra(:old.PRD_CEDULA_RUC);
    fetch cfk1_orden_compra into dummy;
    found := cfk1_orden_compra%FOUND;
    close cfk1_orden_compra;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "ORDEN_COMPRA". Cannot delete parent "PROVEEDOR".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "PROVEEDOR" if children still exist in "PRD_PROVEEDOR"
    open  cfk2_prd_proveedor(:old.PRD_CEDULA_RUC);
    fetch cfk2_prd_proveedor into dummy;
    found := cfk2_prd_proveedor%FOUND;
    close cfk2_prd_proveedor;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PRD_PROVEEDOR". Cannot delete parent "PROVEEDOR".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PROVEEDOR before update
of PRD_CEDULA_RUC
on PROVEEDOR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "ORDEN_COMPRA"
    cursor cfk1_orden_compra(var_prd_cedula_ruc varchar) is
       select 1
       from   ORDEN_COMPRA
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;
    --  Declaration of UpdateParentRestrict constraint for "PRD_PROVEEDOR"
    cursor cfk2_prd_proveedor(var_prd_cedula_ruc varchar) is
       select 1
       from   PRD_PROVEEDOR
       where  PRD_CEDULA_RUC = var_prd_cedula_ruc
        and   var_prd_cedula_ruc is not null;

begin
    --  Cannot modify parent code in "PROVEEDOR" if children still exist in "ORDEN_COMPRA"
    if (updating('PRD_CEDULA_RUC') and :old.PRD_CEDULA_RUC != :new.PRD_CEDULA_RUC) then
       open  cfk1_orden_compra(:old.PRD_CEDULA_RUC);
       fetch cfk1_orden_compra into dummy;
       found := cfk1_orden_compra%FOUND;
       close cfk1_orden_compra;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "ORDEN_COMPRA". Cannot modify parent code in "PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "PROVEEDOR" if children still exist in "PRD_PROVEEDOR"
    if (updating('PRD_CEDULA_RUC') and :old.PRD_CEDULA_RUC != :new.PRD_CEDULA_RUC) then
       open  cfk2_prd_proveedor(:old.PRD_CEDULA_RUC);
       fetch cfk2_prd_proveedor into dummy;
       found := cfk2_prd_proveedor%FOUND;
       close cfk2_prd_proveedor;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PRD_PROVEEDOR". Cannot modify parent code in "PROVEEDOR".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_PROVINCIA before delete
on PROVINCIA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "CIUDAD"
    cursor cfk1_ciudad(var_prv_numero number) is
       select 1
       from   CIUDAD
       where  PRV_NUMERO = var_prv_numero
        and   var_prv_numero is not null;

begin
    --  Cannot delete parent "PROVINCIA" if children still exist in "CIUDAD"
    open  cfk1_ciudad(:old.PRV_NUMERO);
    fetch cfk1_ciudad into dummy;
    found := cfk1_ciudad%FOUND;
    close cfk1_ciudad;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "CIUDAD". Cannot delete parent "PROVINCIA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_PROVINCIA before update
of PRV_NUMERO
on PROVINCIA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "CIUDAD"
    cursor cfk1_ciudad(var_prv_numero number) is
       select 1
       from   CIUDAD
       where  PRV_NUMERO = var_prv_numero
        and   var_prv_numero is not null;

begin
    --  Cannot modify parent code in "PROVINCIA" if children still exist in "CIUDAD"
    if (updating('PRV_NUMERO') and :old.PRV_NUMERO != :new.PRV_NUMERO) then
       open  cfk1_ciudad(:old.PRV_NUMERO);
       fetch cfk1_ciudad into dummy;
       found := cfk1_ciudad%FOUND;
       close cfk1_ciudad;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "CIUDAD". Cannot modify parent code in "PROVINCIA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_SUCURSAL before delete
on SUCURSAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "ORDEN_COMPRA"
    cursor cfk1_orden_compra(var_suc_codigo varchar) is
       select 1
       from   ORDEN_COMPRA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "EMPLEADO"
    cursor cfk2_empleado(var_suc_codigo varchar) is
       select 1
       from   EMPLEADO
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "BODEGA"
    cursor cfk3_bodega(var_suc_codigo varchar) is
       select 1
       from   BODEGA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "FACTURA"
    cursor cfk4_factura(var_suc_codigo varchar) is
       select 1
       from   FACTURA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of DeleteParentRestrict constraint for "PROMOC_SUCURSAL"
    cursor cfk5_promoc_sucursal(var_suc_codigo varchar) is
       select 1
       from   PROMOC_SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;

begin
    --  Cannot delete parent "SUCURSAL" if children still exist in "ORDEN_COMPRA"
    open  cfk1_orden_compra(:old.SUC_CODIGO);
    fetch cfk1_orden_compra into dummy;
    found := cfk1_orden_compra%FOUND;
    close cfk1_orden_compra;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "ORDEN_COMPRA". Cannot delete parent "SUCURSAL".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "SUCURSAL" if children still exist in "EMPLEADO"
    open  cfk2_empleado(:old.SUC_CODIGO);
    fetch cfk2_empleado into dummy;
    found := cfk2_empleado%FOUND;
    close cfk2_empleado;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "EMPLEADO". Cannot delete parent "SUCURSAL".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "SUCURSAL" if children still exist in "BODEGA"
    open  cfk3_bodega(:old.SUC_CODIGO);
    fetch cfk3_bodega into dummy;
    found := cfk3_bodega%FOUND;
    close cfk3_bodega;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "BODEGA". Cannot delete parent "SUCURSAL".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "SUCURSAL" if children still exist in "FACTURA"
    open  cfk4_factura(:old.SUC_CODIGO);
    fetch cfk4_factura into dummy;
    found := cfk4_factura%FOUND;
    close cfk4_factura;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "FACTURA". Cannot delete parent "SUCURSAL".';
       raise integrity_error;
    end if;

    --  Cannot delete parent "SUCURSAL" if children still exist in "PROMOC_SUCURSAL"
    open  cfk5_promoc_sucursal(:old.SUC_CODIGO);
    fetch cfk5_promoc_sucursal into dummy;
    found := cfk5_promoc_sucursal%FOUND;
    close cfk5_promoc_sucursal;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "PROMOC_SUCURSAL". Cannot delete parent "SUCURSAL".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_SUCURSAL before insert
on SUCURSAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_sucursal(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "CIUDAD"
    cursor cpk2_sucursal(var_ciu_numero number) is
       select 1
       from   CIUDAD
       where  CIU_NUMERO = var_ciu_numero
        and   var_ciu_numero is not null;

begin
    --  Parent "EMPRESA" must exist when inserting a child in "SUCURSAL"
    if :new.EMP_CEDULA_RUC is not null then
       open  cpk1_sucursal(:new.EMP_CEDULA_RUC);
       fetch cpk1_sucursal into dummy;
       found := cpk1_sucursal%FOUND;
       close cpk1_sucursal;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot create child in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CIUDAD" must exist when inserting a child in "SUCURSAL"
    if :new.CIU_NUMERO is not null then
       open  cpk2_sucursal(:new.CIU_NUMERO);
       fetch cpk2_sucursal into dummy;
       found := cpk2_sucursal%FOUND;
       close cpk2_sucursal;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "CIUDAD". Cannot create child in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_SUCURSAL before update
of SUC_CODIGO,
   EMP_CEDULA_RUC,
   CIU_NUMERO
on SUCURSAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "EMPRESA"
    cursor cpk1_sucursal(var_emp_cedula_ruc varchar) is
       select 1
       from   EMPRESA
       where  EMP_CEDULA_RUC = var_emp_cedula_ruc
        and   var_emp_cedula_ruc is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "CIUDAD"
    cursor cpk2_sucursal(var_ciu_numero number) is
       select 1
       from   CIUDAD
       where  CIU_NUMERO = var_ciu_numero
        and   var_ciu_numero is not null;
    --  Declaration of UpdateParentRestrict constraint for "ORDEN_COMPRA"
    cursor cfk1_orden_compra(var_suc_codigo varchar) is
       select 1
       from   ORDEN_COMPRA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "EMPLEADO"
    cursor cfk2_empleado(var_suc_codigo varchar) is
       select 1
       from   EMPLEADO
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "BODEGA"
    cursor cfk3_bodega(var_suc_codigo varchar) is
       select 1
       from   BODEGA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "FACTURA"
    cursor cfk4_factura(var_suc_codigo varchar) is
       select 1
       from   FACTURA
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;
    --  Declaration of UpdateParentRestrict constraint for "PROMOC_SUCURSAL"
    cursor cfk5_promoc_sucursal(var_suc_codigo varchar) is
       select 1
       from   PROMOC_SUCURSAL
       where  SUC_CODIGO = var_suc_codigo
        and   var_suc_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "EMPRESA" must exist when updating a child in "SUCURSAL"
    if (:new.EMP_CEDULA_RUC is not null) and (seq = 0) then
       open  cpk1_sucursal(:new.EMP_CEDULA_RUC);
       fetch cpk1_sucursal into dummy;
       found := cpk1_sucursal%FOUND;
       close cpk1_sucursal;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "EMPRESA". Cannot update child in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "CIUDAD" must exist when updating a child in "SUCURSAL"
    if (:new.CIU_NUMERO is not null) and (seq = 0) then
       open  cpk2_sucursal(:new.CIU_NUMERO);
       fetch cpk2_sucursal into dummy;
       found := cpk2_sucursal%FOUND;
       close cpk2_sucursal;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "CIUDAD". Cannot update child in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "SUCURSAL" if children still exist in "ORDEN_COMPRA"
    if (updating('SUC_CODIGO') and :old.SUC_CODIGO != :new.SUC_CODIGO) then
       open  cfk1_orden_compra(:old.SUC_CODIGO);
       fetch cfk1_orden_compra into dummy;
       found := cfk1_orden_compra%FOUND;
       close cfk1_orden_compra;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "ORDEN_COMPRA". Cannot modify parent code in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "SUCURSAL" if children still exist in "EMPLEADO"
    if (updating('SUC_CODIGO') and :old.SUC_CODIGO != :new.SUC_CODIGO) then
       open  cfk2_empleado(:old.SUC_CODIGO);
       fetch cfk2_empleado into dummy;
       found := cfk2_empleado%FOUND;
       close cfk2_empleado;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "EMPLEADO". Cannot modify parent code in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "SUCURSAL" if children still exist in "BODEGA"
    if (updating('SUC_CODIGO') and :old.SUC_CODIGO != :new.SUC_CODIGO) then
       open  cfk3_bodega(:old.SUC_CODIGO);
       fetch cfk3_bodega into dummy;
       found := cfk3_bodega%FOUND;
       close cfk3_bodega;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "BODEGA". Cannot modify parent code in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "SUCURSAL" if children still exist in "FACTURA"
    if (updating('SUC_CODIGO') and :old.SUC_CODIGO != :new.SUC_CODIGO) then
       open  cfk4_factura(:old.SUC_CODIGO);
       fetch cfk4_factura into dummy;
       found := cfk4_factura%FOUND;
       close cfk4_factura;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "FACTURA". Cannot modify parent code in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;

    --  Cannot modify parent code in "SUCURSAL" if children still exist in "PROMOC_SUCURSAL"
    if (updating('SUC_CODIGO') and :old.SUC_CODIGO != :new.SUC_CODIGO) then
       open  cfk5_promoc_sucursal(:old.SUC_CODIGO);
       fetch cfk5_promoc_sucursal into dummy;
       found := cfk5_promoc_sucursal%FOUND;
       close cfk5_promoc_sucursal;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "PROMOC_SUCURSAL". Cannot modify parent code in "SUCURSAL".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_TRANSACCION before delete
on TRANSACCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "MOVIMIENTO_BODEGA"
    cursor cfk1_movimiento_bodega(var_trs_codigo varchar) is
       select 1
       from   MOVIMIENTO_BODEGA
       where  TRS_CODIGO = var_trs_codigo
        and   var_trs_codigo is not null;

begin
    --  Cannot delete parent "TRANSACCION" if children still exist in "MOVIMIENTO_BODEGA"
    open  cfk1_movimiento_bodega(:old.TRS_CODIGO);
    fetch cfk1_movimiento_bodega into dummy;
    found := cfk1_movimiento_bodega%FOUND;
    close cfk1_movimiento_bodega;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "MOVIMIENTO_BODEGA". Cannot delete parent "TRANSACCION".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_TRANSACCION before update
of TRS_CODIGO
on TRANSACCION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "MOVIMIENTO_BODEGA"
    cursor cfk1_movimiento_bodega(var_trs_codigo varchar) is
       select 1
       from   MOVIMIENTO_BODEGA
       where  TRS_CODIGO = var_trs_codigo
        and   var_trs_codigo is not null;

begin
    --  Cannot modify parent code in "TRANSACCION" if children still exist in "MOVIMIENTO_BODEGA"
    if (updating('TRS_CODIGO') and :old.TRS_CODIGO != :new.TRS_CODIGO) then
       open  cfk1_movimiento_bodega(:old.TRS_CODIGO);
       fetch cfk1_movimiento_bodega into dummy;
       found := cfk1_movimiento_bodega%FOUND;
       close cfk1_movimiento_bodega;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "MOVIMIENTO_BODEGA". Cannot modify parent code in "TRANSACCION".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_UNIDAD_ALTERNATIVA before insert
on UNIDAD_ALTERNATIVA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent "UNIDAD_MEDIDA"
    cursor cpk1_unidad_alternativa(var_unm_codigo varchar) is
       select 1
       from   UNIDAD_MEDIDA
       where  UNM_CODIGO = var_unm_codigo
        and   var_unm_codigo is not null;
    --  Declaration of InsertChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_unidad_alternativa(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    --  Parent "UNIDAD_MEDIDA" must exist when inserting a child in "UNIDAD_ALTERNATIVA"
    if :new.UNM_CODIGO is not null then
       open  cpk1_unidad_alternativa(:new.UNM_CODIGO);
       fetch cpk1_unidad_alternativa into dummy;
       found := cpk1_unidad_alternativa%FOUND;
       close cpk1_unidad_alternativa;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "UNIDAD_MEDIDA". Cannot create child in "UNIDAD_ALTERNATIVA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when inserting a child in "UNIDAD_ALTERNATIVA"
    if :new.PRO_CODIGO is not null then
       open  cpk2_unidad_alternativa(:new.PRO_CODIGO);
       fetch cpk2_unidad_alternativa into dummy;
       found := cpk2_unidad_alternativa%FOUND;
       close cpk2_unidad_alternativa;
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot create child in "UNIDAD_ALTERNATIVA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_UNIDAD_ALTERNATIVA before update
of PRO_CODIGO,
   UNM_CODIGO
on UNIDAD_ALTERNATIVA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent "UNIDAD_MEDIDA"
    cursor cpk1_unidad_alternativa(var_unm_codigo varchar) is
       select 1
       from   UNIDAD_MEDIDA
       where  UNM_CODIGO = var_unm_codigo
        and   var_unm_codigo is not null;
    --  Declaration of UpdateChildParentExist constraint for the parent "PRODUCTO"
    cursor cpk2_unidad_alternativa(var_pro_codigo varchar) is
       select 1
       from   PRODUCTO
       where  PRO_CODIGO = var_pro_codigo
        and   var_pro_codigo is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent "UNIDAD_MEDIDA" must exist when updating a child in "UNIDAD_ALTERNATIVA"
    if (:new.UNM_CODIGO is not null) and (seq = 0) then
       open  cpk1_unidad_alternativa(:new.UNM_CODIGO);
       fetch cpk1_unidad_alternativa into dummy;
       found := cpk1_unidad_alternativa%FOUND;
       close cpk1_unidad_alternativa;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "UNIDAD_MEDIDA". Cannot update child in "UNIDAD_ALTERNATIVA".';
          raise integrity_error;
       end if;
    end if;

    --  Parent "PRODUCTO" must exist when updating a child in "UNIDAD_ALTERNATIVA"
    if (:new.PRO_CODIGO is not null) and (seq = 0) then
       open  cpk2_unidad_alternativa(:new.PRO_CODIGO);
       fetch cpk2_unidad_alternativa into dummy;
       found := cpk2_unidad_alternativa%FOUND;
       close cpk2_unidad_alternativa;
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in "PRODUCTO". Cannot update child in "UNIDAD_ALTERNATIVA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TDB_UNIDAD_MEDIDA before delete
on UNIDAD_MEDIDA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for "UNIDAD_ALTERNATIVA"
    cursor cfk1_unidad_alternativa(var_unm_codigo varchar) is
       select 1
       from   UNIDAD_ALTERNATIVA
       where  UNM_CODIGO = var_unm_codigo
        and   var_unm_codigo is not null;

begin
    --  Cannot delete parent "UNIDAD_MEDIDA" if children still exist in "UNIDAD_ALTERNATIVA"
    open  cfk1_unidad_alternativa(:old.UNM_CODIGO);
    fetch cfk1_unidad_alternativa into dummy;
    found := cfk1_unidad_alternativa%FOUND;
    close cfk1_unidad_alternativa;
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in "UNIDAD_ALTERNATIVA". Cannot delete parent "UNIDAD_MEDIDA".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_UNIDAD_MEDIDA before update
of UNM_CODIGO
on UNIDAD_MEDIDA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for "UNIDAD_ALTERNATIVA"
    cursor cfk1_unidad_alternativa(var_unm_codigo varchar) is
       select 1
       from   UNIDAD_ALTERNATIVA
       where  UNM_CODIGO = var_unm_codigo
        and   var_unm_codigo is not null;

begin
    --  Cannot modify parent code in "UNIDAD_MEDIDA" if children still exist in "UNIDAD_ALTERNATIVA"
    if (updating('UNM_CODIGO') and :old.UNM_CODIGO != :new.UNM_CODIGO) then
       open  cfk1_unidad_alternativa(:old.UNM_CODIGO);
       fetch cfk1_unidad_alternativa into dummy;
       found := cfk1_unidad_alternativa%FOUND;
       close cfk1_unidad_alternativa;
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in "UNIDAD_ALTERNATIVA". Cannot modify parent code in "UNIDAD_MEDIDA".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create table AUDITORIA(
        USUARIOSO           VARCHAR2(20),
        USUARIODB           VARCHAR2(20),
        TABLA               VARCHAR2(20),
        DIRECCIONIP         VARCHAR2(30),
        FECHA               VARCHAR2(40),
        MAQUINA             VARCHAR2(20),
        DATOOLD             VARCHAR2(500),
        DATONEW             VARCHAR2(500)
)
        tablespace DATOS
/

create table H_FACTURA (
   FAC_NUMERO           NUMBER(15),            
   SUC_CODIGO           VARCHAR2(8),           
   CLI_NUM_DOCUMENTO    VARCHAR2(13),         
   FAC_FECHA            DATE,
   FAC_MONTO            NUMBER(12,2),       
   FAC_RESPONSABLE      VARCHAR2(60)  
)
   tablespace DATOS
/

create table H_DETALLE_FACTURA (
   FAC_NUMERO           NUMBER(15),
   PRO_CODIGO           VARCHAR2(20),
   DTF_CANTIDAD         NUMBER(12,2),
   DTF_PRECIO           NUMBER(15,2),
   DTF_UNI_MEDIDA       VARCHAR2(3)
)
   tablespace DATOS
/
