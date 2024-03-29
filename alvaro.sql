-- primer alter
alter table re_g_documentos add txto_trfa_ultma_lqdccion varchar2(100);
alter table re_g_documentos add bse_grvble_ultma_lqdccion varchar2(100);


/* 

*/

--Tabla df_s_vehiculos_categoria
drop table df_s_vehiculos_categoria CASCADE CONSTRAINTS;
/
CREATE TABLE DF_S_VEHICULOS_CATEGORIA(
CDGO_VHCLO_CTGTRIA VARCHAR2(3) CONSTRAINT DF_S_VH_CTG_CDGO_VH_CTGRIA_PK PRIMARY KEY
                               CONSTRAINT DF_S_VH_CTG_CDGO_VH_CTGRIA_NN NOT NULL,
DSCRPCION_VHCLO_CTGTRIA VARCHAR2(50) CONSTRAINT DF_S_VH_CTG_NMBR_VH_CTGRIA_NN CHECK ("DSCRPCION_VHCLO_CTGTRIA" IS NOT NULL)
);
/
COMMENT ON COLUMN DF_S_VEHICULOS_CATEGORIA.CDGO_VHCLO_CTGTRIA IS 'Código categoría del vehiculo';
COMMENT ON COLUMN DF_S_VEHICULOS_CATEGORIA.DSCRPCION_VHCLO_CTGTRIA IS 'Nombre categoría del vehiculo';
COMMENT ON TABLE DF_S_VEHICULOS_CATEGORIA IS 'Categorías de Vehículos. Ej Clase: Camioneta( Cat: de pasajeros/de carga/doble cabina)';

--Tabla DF_S_VEHICULOS_COMBUSTIBLE
drop table DF_S_VEHICULOS_COMBUSTIBLE CASCADE CONSTRAINTS;
/
CREATE TABLE DF_S_VEHICULOS_COMBUSTIBLE(
CDGO_VHCLO_CMBSTBLE VARCHAR2(3) CONSTRAINT DF_S_VH_CTG_CDGO_VH_CMBSTBLE_PK PRIMARY KEY
                                CONSTRAINT DF_S_VH_CTG_CDGO_VH_CMBSTBLE_NN NOT NULL,
DSCRPCION_VHCULO_CMBSTBLE VARCHAR2(50) CONSTRAINT DF_S_VH_CTG_NMBR_VH_CMBSTBLE_NN CHECK ("DSCRPCION_VHCULO_CMBSTBLE" IS NOT NULL)
);

-- Tabla DF_S_VEHICULOS_COMBUSTIBLE
drop table DF_S_VEHICULOS_MARCA CASCADE CONSTRAINTS;
/
CREATE TABLE DF_S_VEHICULOS_MARCA(
CDGO_VHCLO_MRCA      VARCHAR2(10)  CONSTRAINT DF_S_VH_MRCA_CDG_VHCLO_MRCA_PK PRIMARY KEY
                                  CONSTRAINT DF_S_VH_MRCA_CDG_VHCLO_MRCA_NN NOT NULL,
DSCRPCION_VHCLO_MRCA VARCHAR2(50) CONSTRAINT DF_S_VH_MRCA_NMB_VHCLO_MRCA_NN CHECK ("DSCRPCION_VHCLO_MRCA" IS NOT NULL),
MNSTRIO              VARCHAR2(1)  CONSTRAINT "DF_S_VH_MRCA_MINISTERIO_NN" CHECK (mnstrio IS NOT NULL) ENABLE
                                  CONSTRAINT "DF_S_VH_MRCA_MINISTERIO_CK" CHECK (mnstrio in ('S',('N'))) ENABLE
);

COMMENT ON COLUMN "GENESYS"."DF_S_VEHICULOS_MARCA"."CDGO_VHCLO_MRCA" IS 'C¿digo marca del vehiculo';
COMMENT ON COLUMN "GENESYS"."DF_S_VEHICULOS_MARCA"."DSCRPCION_VHCLO_MRCA" IS 'Nombre marca del vehiculo';
COMMENT ON COLUMN "GENESYS"."DF_S_VEHICULOS_MARCA"."MNSTRIO" IS 'Marcas del ministerio';
COMMENT ON TABLE "GENESYS"."DF_S_VEHICULOS_MARCA"  IS 'Marcas de Veh¿culos';

commit;

-- Tabla DF_S_VEHICULOS_CLASE
drop table DF_S_VEHICULOS_CLASE CASCADE CONSTRAINTS;
/
CREATE TABLE DF_S_VEHICULOS_CLASE(
CDGO_VHCLO_CLSE VARCHAR2(3)       CONSTRAINT DF_S_VH_CLSE_CDGO_VH_CLSE_PK PRIMARY KEY
                                  CONSTRAINT DF_S_VH_CLSE_CDGO_VH_CLSE_NN NOT NULL,
DSCRPCION_VHCLO_CLSE VARCHAR2(50) CONSTRAINT DF_S_VH_CLSE_NMBR_VH_CLSE_NN CHECK ("DSCRPCION_VHCLO_CLSE" IS NOT NULL)
);

COMMENT ON COLUMN "GENESYS"."DF_S_VEHICULOS_CLASE"."CDGO_VHCLO_CLSE" IS 'Codigo clase de vehiculo';
COMMENT ON COLUMN "GENESYS"."DF_S_VEHICULOS_CLASE"."DSCRPCION_VHCLO_CLSE" IS 'Nombre clase de vehiculo';
COMMENT ON TABLE "GENESYS"."DF_S_VEHICULOS_CLASE"  IS 'Clases de Veh¿culos';

--Alters 
alter table re_g_documentos_ad_persona add NMBRE_RZON_SCIAL varchar2(100);
alter table re_g_documentos_ad_persona add CDGO_IDNTFCCION_TPO varchar2(3);


--antiguo reporte 20