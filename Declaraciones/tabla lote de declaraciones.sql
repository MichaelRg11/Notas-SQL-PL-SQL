drop table gi_g_declaraciones_lote;
/
drop sequence sq_gi_g_declaraciones_lote;
/
drop trigger gi_g_declaraciones_lote_iu;
/
create table gi_g_declaraciones_lote(
  id_dclrcion_lote  number        constraint  gi_g_dclrcn_lte_id_nvd_tp_pk     primary key
                                  constraint  gi_g_dclrcn_lte_id_nvd_tp_nn     not null,
  
  id_usrio_rgstro   number        constraint  gi_g_dclrcn_lte_id_usr_rgst_fk
                                    references sg_g_usuarios (id_usrio)
                                  constraint  gi_g_dclrcn_lte_id_fnc_rgst_nn   not null,

  id_prcso_crga     number,

  cdgo_clnte        number        constraint  gi_g_dclrcn_lte_cod_clnt_fk
                                    references df_s_clientes (cdgo_clnte)
                                  constraint  gi_g_dclrcn_lte_cod_clnt_nn      not null,

  nmbre_lote        varchar2(100)  constraint  gi_g_dclrcn_lte_nmbre_lte_nn    not null,
  
  dscrpcion_lote    varchar2(300)  constraint  gi_g_dclrcn_lte_dcrpcn_lte_nn   not null,

  fcha_rgstro       timestamp(6) default sysdate  
                                  constraint gi_g_dclrcn_lte_fchrgstro_nn      not null
);
/
create sequence sq_gi_g_declaraciones_lote;
/
create or replace trigger gi_g_declaraciones_lote_iu
    for insert or update on gi_g_declaraciones_lote
    compound trigger
    d number;
   
        before each row is
        begin
            if inserting then
                if :new.id_dclrcion_lote is null then
                    d := sq_gi_g_declaraciones_lote.nextval();
                    :new.id_dclrcion_lote := d;
                end if;
            end if;
        end before each row;
end;
/
-- tabla gi_g_intermedia_dian
create table gi_g_intermedia_dian (
  id_intrmdia_dian      number                  constraint gi_g_intrmd_dn_id_intrmd_dn_pk primary key
                                                constraint gi_g_intrmd_dn_id_intrmd_dn_nn not null,
  -- Datos del etl
  id_prcso_crga         number(15, 0)           constraint gi_g_intrmd_dn_id_prcs_crg_fk
                                                  references et_g_procesos_carga (id_prcso_crga)
                                                constraint gi_g_intrmd_dn_id_prcs_crg_nn not null,

  id_prcso_intrmdia     number(15, 0)           constraint gi_g_intrmd_dn_id_prc_int_fk
                                                  references et_g_procesos_intermedia (id_prcso_intrmdia)
                                                constraint gi_g_intrmd_dn_id_prc_int_nn not null,

  nmero_lnea            number                  constraint gi_g_intrmd_dn_nmero_lnea_nn not null,
  -- Fin datos del etl
  vgncia_grvble         number                  constraint gi_g_intrmd_dn_vgnca_grvble_nn not null,

  prdo_grvble           number                  constraint gi_g_intrmd_dn_prdo_grvble_nn  not null,

  tpo_idntfccion        varchar2(200)           constraint gi_g_intrmd_dn_tpo_idntfccn_nn not null,

  idntfccion            varchar2(20)            constraint gi_g_intrmd_dn_idntfccion_nn not null,

  rzon_scial            varchar2(500)           constraint gi_g_intrmd_dn_rzon_scial_nn not null,

  drccion_sccnal        varchar2(500)           constraint gi_g_intrmd_dn_drccn_sccnal_nn not null,

  cnsctvo_dclrcion      number                  constraint gi_g_intrmd_dn_cnsctvo_dclr_nn not null,

  fcha_rcdo             varchar2(20)            constraint gi_g_intrmd_dn_fcha_rcdo_nn not null,

  pgo_ttal_icac         number                  constraint gi_g_intrmd_dn_pgo_ttl_icac_nn not null,

  intrses_icac          number                  constraint gi_g_intrmd_dn_intrses_icac_nn not null,

  sncnes_icac           number                  constraint gi_g_intrmd_dn_sncnes_icac_nn not null,

  ttal_ingrsos_brto     number                  constraint gi_g_intrmd_dn_ttl_ingr_brt_nn not null,

  dvlcnes_rbjas_dsc     number                  constraint gi_g_intrmd_dn_dvl_rbjs_dsc_nn not null,

  mnos_ingrsos_x_exp    number                  constraint gi_g_intrmd_dn_mn_ing_x_exp_nn not null,

  mnos_ingrsos_x_vnta   number                  constraint gi_g_intrmd_dn_mn_ing_x_vta_nn not null,

  ingrsos_exntos        number                  constraint gi_g_intrmd_dn_ingrss_exnts_nn not null,

  ttal_ingrsos_grvble   number                  constraint gi_g_intrmd_dn_ttal_ing_grv_nn not null,

  ttal_impsto_ica       number                  constraint gi_g_intrmd_dn_ttl_imps_ica_nn not null,

  rtncnes_o_autortncnes number                  constraint gi_g_intrmd_dn_rtn_o_autort_nn not null,

  sldo_pgar             number                  constraint gi_g_intrmd_dn_sldo_pgar_nn not null,

  id_dclrcion           number,

  indcdor_prcsdo        varchar2(1) default 'N' constraint gi_g_intrmd_dn_indcdr_prcsd_ck check (indcdor_prcsdo in ('S', 'N'))
);
comment on table gi_g_intermedia_dian is 'Entidad que almacena la información de la Dian para posteriormente cargarla al sistema.';
/
create sequence sq_gi_g_intermedia_dian;
/
create or replace editionable trigger gi_g_intermedia_dian_iu for
  insert on gi_g_intermedia_dian
compound trigger
  d number;
  before each row is begin
    if inserting then
      if :new.id_intrmdia_dian is null then
        d := sq_gi_g_intermedia_dian.nextval();
        :new.id_intrmdia_dian := d;
      end if;

    end if;
  end before each row;
end;
/
-- Se crea el proceso de carga
insert into gn_d_codigos_proceso (cdgo_prcso, dscrpcion, id_crga) values ('DCL', 'LOTE DE DECLARACION DE LA DIAN', 44/*Depende del id carga que se asigne al crear la carga en el etl*/);
/
-- Agregar nuevas columnas a la tabla et_g_procesos_intermedia
set serveroutput on;
declare 
  v_dml varchar(1000);
begin
  for i in 51..100 loop
    null;
    v_dml := 'alter table et_g_procesos_intermedia add CLUMNA' || i || ' varchar(500)';
    execute immediate v_dml;
    dbms_output.put_line('Se creo la columna: ' || i);
  end loop;
end;
/
-- Eliminar columnas de la tabla et_g_procesos_intermedia
set serveroutput on;
declare 
  v_dml varchar(1000);
begin
  for i in 51..100 loop
    null;
    v_dml := 'alter table et_g_procesos_intermedia drop column CLUMNA' || i;
    execute immediate v_dml;
    dbms_output.put_line('Se elimina la columna: ' || i);
  end loop;
end;

