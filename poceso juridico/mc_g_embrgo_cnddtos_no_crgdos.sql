create table mc_g_embrgo_cnddtos_no_crgdos (
  id_embrgo_cnddto_no_crgdos number             constraint  mc_g_mbg_cdt_cgs_id_mbg_cdt_pk   primary key
                                                  constraint  mc_g_mbg_cdt_cgs_id_mbg_cdt_nn   not null,
  id_lte                     number             constraint  mc_g_mbg_cdt_cgs_id_lte_nn   not null,
  cdgo_clnte                 number             constraint  mc_g_mbg_cdt_cgs_cdgo_clnte_nn   not null,
  idntfccion_sjto            varchar2(30 byte)  constraint  mc_g_mbg_cdt_cgs_idtfc_sjt_nn   not null,
  vgncia_dsde                number,
  vgncia_hsta                number,
  fcha                       timestamp(6),
  obsrvcion                  varchar2(2000 byte)
)
/
create sequence sq_mc_g_embrgo_cnddtos_no_crgdos;
/
create or replace trigger mc_g_embrgo_cnddtos_no_crgdos_iu
    for insert or update on mc_g_embrgo_cnddtos_no_crgdos
    compound trigger
    d number;
   
        before each row is
        begin
            if inserting then
                if :new.ID_EMBRGO_CNDDTO_NO_CRGDOS is null then
                    d := sq_mc_g_embrgo_cnddtos_no_crgdos.nextval();
                    :new.ID_EMBRGO_CNDDTO_NO_CRGDOS := d;
                end if;
            end if;
        end before each row;
end;