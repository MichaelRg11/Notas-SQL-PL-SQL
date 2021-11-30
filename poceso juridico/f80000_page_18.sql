prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.03.31'
,p_release=>'19.1.0.00.15'
,p_default_workspace_id=>71778384177293184
,p_default_application_id=>80000
,p_default_owner=>'GENESYS'
);
end;
/
 
prompt APPLICATION 80000 - Gestión de Cobro
--
-- Application Export:
--   Application:     80000
--   Name:            Gestión de Cobro
--   Date and Time:   16:25 Tuesday November 30, 2021
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250147824739065
--

prompt --application/pages/delete_00018
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>18);
end;
/
prompt --application/pages/page_00018
begin
wwv_flow_api.create_page(
 p_id=>18
,p_user_interface_id=>wwv_flow_api.id(17431055073919422)
,p_name=>'Proceso Masivo de Etapas'
,p_page_mode=>'MODAL'
,p_step_title=>'Proceso Masivo de Etapas'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20211126102830'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51687621402979903)
,p_plug_name=>'Proceso Masivo de Etapas'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51688674358979913)
,p_plug_name=>'dialog footer'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51833020686661901)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(51688674358979913)
,p_button_name=>'Cancelar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-window-x'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51687863706979905)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(51688674358979913)
,p_button_name=>'BTN_PRCSAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Procesar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-cog'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51687790520979904)
,p_name=>'P18_ID_FLJO_TREA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(51687621402979903)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51688123746979908)
,p_name=>'P18_JSON'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(51687621402979903)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51701496729123262)
,p_name=>'P18_ID_PLNTLLA'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(51687621402979903)
,p_prompt=>'Plantilla'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.dscrpcion,',
'       a.id_plntlla',
'  from gn_d_plantillas a',
' where exists (select b.id_acto_tpo ',
'                 from gn_d_actos_tipo_tarea b',
'                where b.id_acto_tpo = a.id_acto_tpo',
'                  and id_fljo_trea = :P18_id_fljo_trea);'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17408658834919398)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147020686935824423)
,p_name=>'P18_ID_ACTO_TPO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(51687621402979903)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(147021764190824434)
,p_computation_sequence=>10
,p_computation_item=>'P18_ID_ACTO_TPO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_acto_tpo',
'  from gn_d_plantillas a',
' where exists (select b.id_acto_tpo ',
'                 from gn_d_actos_tipo_tarea b',
'                where b.id_acto_tpo = a.id_acto_tpo',
'                  and id_fljo_trea = :P18_ID_FLJO_TREA);'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(51688274740979909)
,p_computation_sequence=>10
,p_computation_item=>'P18_JSON'
,p_computation_point=>'BEFORE_HEADER'
,p_computation=>':P10_JSONMASIVO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51833296149661903)
,p_name=>unistr('al presionar el bot\00F3n cancelar')
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51833020686661901)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51833314664661904)
,p_event_id=>wwv_flow_api.id(51833296149661903)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147020961574824426)
,p_name=>'Al dar Click en BTN_PRCSAR'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51687863706979905)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147021061515824427)
,p_event_id=>wwv_flow_api.id(147020961574824426)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const peticionServerProcess = (proc, json) => {',
'    return apex.server.process(proc, json);',
'}',
'',
'const proceso = async () => {',
'  console.time(''loop'');',
'  let popup = apex.util.showSpinner()//apex.widget.waitPopup();',
'  const { data } = await peticionServerProcess(''Generar_Documentos_Masivos'', { ',
'                                                  x01: apex.item(''P18_ID_PLNTLLA'').getValue(),',
'                                                  f01: localStorage.getItem(''jsonGenerarDocumento'')',
'                                              });',
'  console.log(data);',
'  popup.remove();',
'  apex.message.showPageSuccess(''Generado con exito!'');',
'  console.timeEnd(''loop''); // Muestra por consola: "loop: 63ms"',
'}',
'',
unistr('apex.message.confirm(`Se generar\00E1n ${JSON.parse(localStorage.getItem(''jsonGenerarDocumento'')).length} documentos. Este proceso tardar\00E1 algunos minutos.`, function( okPressed ) { '),
'    if( okPressed ) {',
'        proceso();',
'    }',
'});',
'',
'//apex.submit({request: "procesarGeneracionActo"});'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51688429553979911)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'cerrar dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51688384263979910)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Generar_Documentos_Masivos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_cdgo_rspsta      number;',
'    v_mnsje_rspsta     varchar2(1000);',
'    v_id_lte_gnrado    number;',
'    v_json             clob;',
'    v_errsql           varchar2(2000);',
'    v_id_plntlla       number := APEX_APPLICATION.G_X01;',
'begin',
'    for i in 1..APEX_APPLICATION.g_f01.count loop',
'       v_json := v_json || APEX_APPLICATION.g_f01(i);',
'    end loop;',
'    apex_json.open_object;        -- {',
'    pkg_cb_proceso_juridico.prc_rg_lote_impresion_documentos(p_cdgo_clnte   => :F_CDGO_CLNTE,',
'                                                             p_cdgo_prcso   => ''GCB'',',
'                                                             p_id_acto_tpo  => :P18_ID_ACTO_TPO,',
'                                                             p_id_usrio     => :F_ID_USRIO,',
unistr('                                                             p_obsrvcion    => ''Lote de impresion asignado de forma autom\00E1tica durante la generaci\00F3n de actos.'','),
'                                                             o_lte_gnrdo    => v_id_lte_gnrado,',
'                                                             o_cdgo_rspsta  => v_cdgo_rspsta,',
'                                                             o_mnsje_rspsta => v_mnsje_rspsta);',
'    if v_cdgo_rspsta <> 0 then',
'      /*apex_json.write(''data'', ''mensaje de error: '' || v_mnsje_rspsta);',
'      apex_json.close_object;*/',
'        raise_application_error(-20001, v_mnsje_rspsta);',
'    end if;',
'    ',
unistr('    -- Generaci\00F3n masiva de actos'),
'    pkg_cb_proceso_juridico.prc_rg_dcmnto_msvo_prcso_jrdco ( p_id_plntlla    => v_id_plntlla,--:P18_ID_PLNTLLA,',
'                                                             p_json_procesos => v_json , ',
'                                                             p_id_usrio      => :F_ID_USRIO,',
'                                                             p_cdgo_clnte   => :F_CDGO_CLNTE,',
'                                                             p_id_lte_imprsion => v_id_lte_gnrado);',
'    ',
unistr('    apex_json.write(''data'', ''despues del Generaci\00F3n masiva de actos'' || v_mnsje_rspsta);'),
'    apex_json.close_object;',
'    ',
'    exception',
'      when others then',
'        v_errsql := SQLERRM;',
'        apex_json.write(''data'', ''mensaje de error: '' || v_errsql);',
'        apex_json.close_object;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Proceso realizado de forma exitosa!!'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
