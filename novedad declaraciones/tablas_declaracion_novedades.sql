drop table gi_g_dclrcnes_nvdad_dtlle;
/
drop table gi_g_dclrcnes_nvdad;
/
drop table gi_d_dclrcnes_nvdad_tpo;
/
drop sequence sq_gi_d_dclrcnes_nvdad_tpo;
/
drop sequence sq_gi_g_dclrcnes_nvdad;
/
drop sequence sq_gi_g_dclrcnes_nvdad_dtlle;
/
create table gi_d_dclrcnes_nvdad_tpo(
  id_nvdad_tpo  number        constraint  gi_g_dclr_nvd_tp_id_nvd_tp_pk   primary key
                              constraint  gi_g_dclr_nvd_tp_id_nvd_tp_nn   not null,
                              
  cdgo_tpo      varchar2(10)  constraint  gi_g_dclr_nvd_tp_cdg_tpo_tp_nn  not null,
  
  dscrpcion_tpo varchar2(250) constraint  gi_g_dclr_nvd_tp_dcrpcn_tp_nn   not null
);
/
create sequence sq_gi_d_dclrcnes_nvdad_tpo;
/
create or replace trigger gi_d_dclrcnes_nvdad_tpo_iu
    for insert or update on gi_d_dclrcnes_nvdad_tpo
    compound trigger
    d number;
   
        before each row is
        begin
            if inserting then
                if :new.id_nvdad_tpo is null then
                    d := sq_gi_d_dclrcnes_nvdad_tpo.nextval();
                    :new.id_nvdad_tpo := d;
                end if;
            end if;
        end before each row;
end;
/
insert into gi_d_dclrcnes_nvdad_tpo(cdgo_tpo, dscrpcion_tpo) values('MVD', 'Modificacion de la vigencia en una declaración.');
/
create table gi_g_dclrcnes_nvdad (
  id_nvdad      number                      constraint  gi_g_dclr_nvdad_id_nvdad_pk             primary key
                                            constraint  gi_g_dclr_nvdad_id_nvdad_nn             not null,
                                          
  id_dclrcion    number                      constraint  gi_g_dclr_nvdad_id_dclrcne_fk  
                                              references  gi_g_declaraciones (id_dclrcion)
                                            constraint  gi_g_dclr_nvdad_id_dclrcne_nn           not null,
                                          
  id_nvdad_tpo  number                      constraint  gi_g_dclr_nvdad_id_nvdad_tp_fk  
                                              references  gi_d_dclrcnes_nvdad_tpo (id_nvdad_tpo)
                                            constraint  gi_g_dclr_nvdad_id_nvdad_tp_nn          not null,
                                          
  fcha_nvdad  timestamp    default sysdate  constraint  gi_g_dclr_nvdad_fcha_nvdad_nn           not null,
  
  cdgo_estdo  varchar2(10) default 'PS'     constraint  gi_g_dclr_cdgo_estdo_ck check (cdgo_estdo in ('PS','AP', 'CN')),
  
  user_dgta   varchar2(100)                 constraint gi_g_dclr_nvdad_user_dgta_nn not null,
  
  fcha_dgta   timestamp(6)                  constraint gi_g_dclr_nvdad_fcha_dgta_nn not null,
  
  user_mdfca varchar2(100),
  
  fcha_mdfca  timestamp(6)                  
);
/
create sequence sq_gi_g_dclrcnes_nvdad;
/
create or replace trigger gi_g_dclrcnes_nvdad_iu
    for insert or update on gi_g_dclrcnes_nvdad
    compound trigger
    d number;
   
        before each row is
        begin
            if inserting then
                if :new.id_nvdad is null then
                    d := sq_gi_g_dclrcnes_nvdad.nextval();
                    :new.id_nvdad := d;
                end if;
                :new.user_dgta := coalesce( sys_context('APEX$SESSION','app_user'), regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*'), sys_context('userenv','session_user'));
                :new.fcha_dgta := systimestamp;
            end if;
            if updating then
                :new.user_mdfca := coalesce(sys_context('APEX$SESSION','app_user'), regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*'), sys_context('userenv','session_user'));
                :new.fcha_mdfca := systimestamp;
            end if;
        end before each row;
end;
/
create table gi_g_dclrcnes_nvdad_dtlle (
  id_nvdad_dtlle                  number        constraint  gi_g_dclr_nvd_dtll_id_nv_dt_pk   primary key
                                                constraint  gi_g_dclr_nvd_dtll_id_nv_dt_nn   not null,
                                                
  id_nvdad                        number        constraint  gi_g_dclr_nvd_dtll_id_nvdad_fk  
                                                  references  gi_g_dclrcnes_nvdad (id_nvdad)
                                                constraint  gi_g_dclr_nvd_dtlle_id_nvd_nn    not null,
                                                
  vgncia_antrior                  number        constraint  gi_g_dclr_nvd_dt_vgnc_ant_fk
                                                  references df_s_vigencias (vgncia),
                                                  
  id_prdo_antrior                 number        constraint  gi_g_dclr_nvd_dt_id_prd_ant_fk
                                                  references df_i_periodos (id_prdo),
                                                  
  id_dclrcion_vgncia_frmlrio_ant  number        constraint  gi_g_dclr_nvd_dtll_id_fr_an_fk
                                                  references gi_d_dclrcnes_vgncias_frmlr (id_dclrcion_vgncia_frmlrio),
                                                  
  vgncia_nvo                      number        constraint  gi_g_dclr_nvd_dt_vgncia_nvo_fk
                                                  references df_s_vigencias (vgncia),
                                                  
  id_prdo_nvo                     number        constraint  gi_g_dclr_nv_dt_id_prdo_nvo_fk
                                                  references df_i_periodos (id_prdo),

  id_dclrcion_vgncia_frmlrio_nvo  number        constraint  gi_g_dclr_nvd_dtll_id_fr_nv_fk
                                                  references gi_d_dclrcnes_vgncias_frmlr (id_dclrcion_vgncia_frmlrio)
);
/
create sequence sq_gi_g_dclrcnes_nvdad_dtlle;
/
create or replace trigger gi_g_dclrcnes_nvdad_dtlle_iu
    for insert or update on gi_g_dclrcnes_nvdad_dtlle
    compound trigger
    d number;
   
        before each row is
        begin
            if inserting then
                if :new.id_nvdad_dtlle is null then
                    d := sq_gi_g_dclrcnes_nvdad_dtlle.nextval();
                    :new.id_nvdad_dtlle := d;
                end if;
            end if;
        end before each row;
end;
/
