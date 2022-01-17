declare 
  v_documento clob;
  v_id_usrio_apex number;
  v_gn_d_reportes gn_d_reportes%rowtype;
  v_cdgo_clnte number := 10; -- cambiar
  v_blob blob;
  v_id_rprte number;
  v_json varchar2(1000);
  o_cdgo_rspsta number;
  o_mnsje_rspsta varchar2(2000);
  
begin
  
  --SI NO EXISTE UNA SESSION EN APEX, LA CREAMOS
  if v('APP_SESSION') is null then
    v_id_usrio_apex := pkg_gn_generalidades.fnc_cl_defniciones_cliente(p_cdgo_clnte                => v_cdgo_clnte,
                                                                       p_cdgo_dfncion_clnte_ctgria => 'CLN',
                                                                       p_cdgo_dfncion_clnte        => 'USR');
    apex_session.create_session(p_app_id   => 66000,
                                p_page_id  => 2,
                                p_username => v_id_usrio_apex);
  else
    dbms_output.put_line('EXISTE SESION'||v('APP_SESSION'));
    apex_session.attach(p_app_id     => 66000,
                        p_page_id    => 2,
                        p_session_id => v('APP_SESSION'));
  end if;
  
  -- se recorren los datos 
  for c_prcso_jrdco in (select b.id_prcsos_jrdco_dcmnto, a.id_acto, b.id_prcsos_jrdco from gn_g_actos a
                          join cb_g_procesos_jrdco_dcmnto b on a.id_acto = b.id_acto
                          where a.id_acto = 7982271) loop

    --
    begin
          select distinct c.id_rprte
            into v_id_rprte
            from cb_g_procesos_jrdco_dcmnto a
            join cb_g_prcsos_jrdc_dcmnt_plnt b
              on b.id_prcsos_jrdco_dcmnto = a.id_prcsos_jrdco_dcmnto
            join gn_d_plantillas c
              on c.id_acto_tpo = a.id_acto_tpo
             and c.id_plntlla = b.id_plntlla
           where a.id_prcsos_jrdco_dcmnto = c_prcso_jrdco.id_prcsos_jrdco_dcmnto;
      exception
        when others then
            o_cdgo_rspsta := 5;
            o_mnsje_rspsta := 'No se pudo encontrar reporte. ';
            insert into muerto (c_001, n_001, t_001) values (o_mnsje_rspsta, o_cdgo_rspsta, systimestamp);
            --apex_session.delete_session(p_session_id => v('APP_SESSION'));
            continue;
      end;
      
      --BUSCAMOS LOS DATOS DE PLANTILLA DE REPORTES
      begin
          select r.* into v_gn_d_reportes 
              from gn_d_reportes r
             where r.id_rprte = v_id_rprte;
      exception
        when others then
            o_cdgo_rspsta := 10;
            o_mnsje_rspsta := 'No se pudo encontrar reporte parametrizado. ';
            insert into muerto (c_001, n_001, t_001) values (o_mnsje_rspsta, o_cdgo_rspsta, systimestamp);
            --apex_session.delete_session(p_session_id => v('APP_SESSION'));
            continue;
      end;
    
    -- Seteamos datos en session 
    select json_object('ID_PRCSOS_JRDCO_DCMNTO' value c_prcso_jrdco.id_prcsos_jrdco_dcmnto ) into v_json from dual;
    dbms_output.put_line('Antes de setear los item en session');
    
    apex_util.set_session_state('F_CDGO_CLNTE', v_cdgo_clnte); dbms_output.put_line('Seteo F_CDGO_CLNTE: ' || v_json);
    apex_util.set_session_state('P71_JSON', '{"ID_PRCSOS_JRDCO_DCMNTO":"' || c_prcso_jrdco.id_prcsos_jrdco_dcmnto || '"}'); dbms_output.put_line('Seteo P71_JSON');
    apex_util.set_session_state('P2_XML', '<data><id_prcsos_jrdco_dcmnto>' || c_prcso_jrdco.id_prcsos_jrdco_dcmnto || '</id_prcsos_jrdco_dcmnto></data>'); dbms_output.put_line('Seteo P2_XML');
    
    dbms_output.put_line('Despues de setear los item en session');
    dbms_output.put_line('Antes de generar el blob');
    v_blob := apex_util.get_print_document(p_application_id     => 66000,
                                             p_report_query_name  => v_gn_d_reportes.nmbre_cnslta,
                                             p_report_layout_name => v_gn_d_reportes.nmbre_plntlla,
                                             p_report_layout_type => v_gn_d_reportes.cdgo_frmto_plntlla,
                                             p_document_format    => v_gn_d_reportes.cdgo_frmto_tpo);
    dbms_output.put_line('Despues de generar el blob');
    -- Se actualiza la tabla de documentos
    pkg_cb_proceso_juridico.prc_ac_acto(p_file_blob => v_blob,
                                        p_id_acto   => c_prcso_jrdco.id_acto);
    
    insert into muerto(n_001, v_001, t_001) values (21, 'id_prcsos_jrdco: ' || c_prcso_jrdco.id_prcsos_jrdco, systimestamp); commit;
    
    null;
  end loop;
end;