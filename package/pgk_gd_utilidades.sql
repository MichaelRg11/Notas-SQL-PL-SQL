/
create table gd_g_dummy(
  id_dmmy number,
  file_blob blob
);
/
insert into gd_g_dummy(id_dmmy, file_blob) values(1, empty_blob());
/
create or replace PACKAGE pkg_gd_utilidades IS
  
  function fnc_vl_archvo_exstnte (p_directorio varchar2, p_nmbre_archvo varchar2)
    return varchar2;

  function fnc_vl_archvo_blqdo (p_directorio varchar2, p_nmbre_archvo varchar2)
    return varchar2;

  procedure prc_co_archco_dsco (p_directorio    varchar2    default null
                              , p_nmbre_archvo  varchar2    default null
                              , p_bfile         bfile       default null
                              , o_archvo_blob   out blob
                              , o_cdgo_rspsta   out number
                              , o_mnsje_rspsta  out varchar2);
                              
  procedure prc_co_archco_dsco_id (p_id_dcmnto      number
                                 , o_archvo_blob    out blob
                                 , o_cdgo_rspsta    out number
                                 , o_mnsje_rspsta   out varchar2);
                                 
  procedure prc_rg_dcmnto_dsco (p_blob          in blob
                              , p_dir           in varchar2
                              , p_filename      in varchar2
                              , o_cdgo_rspsta   out number
                              , o_mnsje_rspsta  out varchar2);

  procedure prc_el_archvo_dsco (p_directorio    varchar2
                              , p_nmbre_archvo  varchar2
                              , o_cdgo_rspsta   out number
                              , o_mnsje_rspsta  out varchar2);

END pkg_gd_utilidades;