create or replace procedure prc_gn_documento (p_id_acto                 number
                                            , p_cdgo_clnte              number
                                            , p_id_prcsos_jrdco_dcmnto  number
                                            , p_json                    varchar2
                                            , o_cdgo_rspsta             out number
                                            , o_mnsje_rspsta            out varchar2) as
  v_id_usrio_apex             number;
  v_id_rprte                  number;
  v_gn_d_reportes             gn_d_reportes%rowtype;
  v_blob                      blob;
begin
  --SI NO EXISTE UNA SESSION EN APEX, LA CREAMOS
  if v('APP_SESSION') is null then
    v_id_usrio_apex := pkg_gn_generalidades.fnc_cl_defniciones_cliente(p_cdgo_clnte                => p_cdgo_clnte,
                                                                       p_cdgo_dfncion_clnte_ctgria => 'CLN',
                                                                       p_cdgo_dfncion_clnte        => 'USR');

    apex_session.create_session(p_app_id   => 66000,
                                p_page_id  => 2,
                                p_username => v_id_usrio_apex);
  else
    --dbms_output.put_line('EXISTE SESION'||v('APP_SESSION'));
    apex_session.attach(p_app_id     => 66000,
                        p_page_id    => 2,
                        p_session_id => v('APP_SESSION'));
  end if;

  begin
    apex_util.set_session_state('P71_JSON', p_json);
  end;
  --BUSCAMOS LOS DATOS DE PLANTILLA DE REPORTES

  select distinct c.id_rprte
    into v_id_rprte
    from cb_g_procesos_jrdco_dcmnto a
    join cb_g_prcsos_jrdc_dcmnt_plnt b
      on b.id_prcsos_jrdco_dcmnto = a.id_prcsos_jrdco_dcmnto
    join gn_d_plantillas c
      on c.id_acto_tpo = a.id_acto_tpo
     and c.id_plntlla = b.id_plntlla
   where a.id_prcsos_jrdco_dcmnto = p_id_prcsos_jrdco_dcmnto;

  begin
    select r.*
      into v_gn_d_reportes
      from gn_d_reportes r
     where r.id_rprte = v_ID_RPRTE;
  end;

  --SETEAMOS EN SESSION LOS ITEMS NECESARIOS PARA GENERAR EL ARCHIVO
  apex_util.set_session_state('P2_XML',
                              '<data><id_prcsos_jrdco_dcmnto>' ||
                              p_id_prcsos_jrdco_dcmnto ||
                              '</id_prcsos_jrdco_dcmnto></data>');
  apex_util.set_session_state('F_CDGO_CLNTE', p_cdgo_clnte);
  --dbms_output.put_line('llego generar blob');
  --GENERAMOS EL DOCUMENTO
  v_blob := apex_util.get_print_document(p_application_id     => 66000,
                                         p_report_query_name  => v_gn_d_reportes.nmbre_cnslta,
                                         p_report_layout_name => v_gn_d_reportes.nmbre_plntlla,
                                         p_report_layout_type => v_gn_d_reportes.cdgo_frmto_plntlla,
                                         p_document_format    => v_gn_d_reportes.cdgo_frmto_tpo);

  pkg_cb_proceso_juridico.prc_ac_acto(p_file_blob => v_blob,
                                      p_id_acto   => p_id_acto);

  --CERRARMOS LA SESSION Y ELIMINADOS TODOS LOS DATOS DE LA MISMA
  if v_id_usrio_apex is not null then
    apex_session.delete_session(p_session_id => v('APP_SESSION'));
  end if;

exception
  when others then
    if v_id_usrio_apex is not null then
      apex_session.delete_session(p_session_id => v('APP_SESSION'));
    end if;
    o_cdgo_rspsta := 10;
    o_mnsje_rspsta := 'No se pudo Generar el Archivo del Documento Juridico. ' || p_id_prcsos_jrdco_dcmnto || ' ' || sqlerrm;
    
    insert into muerto (c_001, n_001, t_001) values (o_mnsje_rspsta, o_cdgo_rspsta, systimestamp);
    return;
end;