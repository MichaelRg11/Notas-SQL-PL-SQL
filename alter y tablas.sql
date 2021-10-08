-- Primeros pasos para agregar el proceso prc_rg_documento_rpt
create table re_g_documentos_encbzdo_rpt(	
	id_dcmnto_encbzdo_rpt 			number 			constraint re_g_doc_enc_rpt_id_dc_en_r_pk 	primary key
													constraint re_g_doc_enc_rpt_id_dc_en_r_nn 	not null,
	id_dcmnto 						number 			constraint re_g_doc_enc_rpt_id_dcmnto_nn 	not null
													constraint re_g_doc_enc_rpt_id_dcmnto_fk 	references re_g_documentos (id_dcmnto), 
	nmbre_rzon_scial_rspsble_p 		varchar2(200), 
	cdgo_idntfccion_tpo_rspsble_p 	varchar2(3), 
	idntfccion_rspsble_p 			varchar2(20), 
	vgncia_sldo 					varchar2(1000), 
	vgncia_sldo_ttal 				varchar2(1000), 
	lynda_pnts_pgo 					varchar2(1000), 
	artclo 							varchar2(1000), 
	nmro_dcmnto_rcdo 				varchar2(30), 
	fcha_rcbdo 						date, 
	vlor_dcmnto 					varchar2(30), 
	nmbre_bnco 						varchar2(200)
);
create index re_g_dcm_enc_rtp_id_dcmnto_in on re_g_documentos_encbzdo_rpt (id_dcmnto);
create sequence sq_re_g_documentos_encbzdo_rpt;
  
create table re_g_documentos_rtp_23001(
	id_dcmnto_rpt 			number 			constraint re_g_docmnto_rpt_id_dcm_rpt_pk primary key
											constraint re_g_docmnto_rpt_id_dcm_rpt_nn not null, 
	id_dcmnto 				number 			constraint re_g_docmnto_rpt_id_dcmnto_nn not null
											constraint re_g_docmnto_rpt_id_dcmnto_fk references re_g_documentos (id_dcmnto), 
	dscrpcion_vgncia 		varchar2(20) 	constraint re_g_docmnto_rpt_dscrp_vngc_nn not null, 
	orden_agrpcion 			number 			default 1
											constraint re_g_docmnto_rpt_ordn_agrpc_nn not null, 
	dscrpcion_cncpto 		varchar2(100) 	constraint re_g_docmnto_rpt_dscr_cncpt_nn not null, 
	vlor_cptal 				number 			constraint re_g_docmnto_rpt_vlor_cptal_nn not null, 
	vlor_intres 			number 			default 0 
											constraint re_g_docmnto_rpt_vlor_intre_nn not null, 
	vlor_dscnto 			number 			default 0 
											constraint re_g_docmnto_rpt_vlor_dscnt_nn not null, 
	vlor_ttal 				number 			default 0 
											constraint re_g_docmnto_rpt_vlor_ttal_nn not null, 
	vlor_cptal_gnral 		number 			default 0 
											constraint re_g_docmnto_rpt_vlor_cp_gn_nn not null, 
	vlor_intres_gnral 		number 			default 0 
											constraint re_g_docmnto_rpt_vlor_in_gn_nn not null, 
	vlor_dscnto_gnral 		number 			default 0 
											constraint re_g_docmnto_rpt_vlor_ds_gn_nn not null, 
	vlor_ttal_gnral 		number 			default 0 
											constraint re_g_docmnto_rpt_vlor_tt_gn_nn not null
) ;

create index re_g_dcmnts_rtp_id_dcmnto_in on re_g_documentos_rtp_23001 (id_dcmnto) ;
create sequence sq_re_g_documentos_rtp_23001;

ALTER TABLE re_g_documentos_detalle ADD dscrpcion_vgncia VARCHAR2(20);
ALTER TABLE re_g_documentos_detalle ADD orden_agrpcion NUMBER;

-- Luego se debe agregar el reporte y la query de este

-- primer alter
alter table re_g_documentos add txto_trfa_ultma_lqdccion varchar2(100);
alter table re_g_documentos add bse_grvble_ultma_lqdccion varchar2(100);

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
