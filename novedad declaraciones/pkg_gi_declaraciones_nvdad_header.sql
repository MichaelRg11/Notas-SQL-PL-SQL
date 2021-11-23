create or replace package pkg_gi_declaraciones_nvdad as
  
  procedure prc_rg_dclrcion_nvdad (p_id_dclrcion number
                                 , p_id_dclrcion_vgncia_frmlrio_ant number
                                 , p_vgncia_antrior number
                                 , p_id_prdo_antrior number
                                 , p_id_dclrcion_vgncia_frmlrio_nvo number
                                 , p_vgncia_nvo number
                                 , p_id_prdo_nvo number
                                 , p_id_nvdad_tpo number
                                 , o_id_nvdad out number
                                 , o_mnsje_rspsta out varchar2
                                 , o_cdgo_rspsta out number);

  procedure prc_ap_dclrcion_nvdad_vgncia(p_id_nvdad number
                                       , p_cdgo_clnte number
                                       , o_mnsje_rspsta out varchar2
                                       , o_cdgo_rspsta out number);
  
  procedure pr_ac_dclrcion_nvdad (p_id_nvdad number
                                , p_stado_nvdad varchar2
                                , p_cdgo_clnte number
                                , o_mnsje_rspsta out varchar2
                                , o_cdgo_rspsta out number);
end pkg_gi_declaraciones_nvdad;