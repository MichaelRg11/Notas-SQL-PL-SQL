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
,p_default_application_id=>70000
,p_default_owner=>'GENESYS'
);
end;
/
 
prompt APPLICATION 70000 - Tributo
--
-- Application Export:
--   Application:     70000
--   Name:            Tributo
--   Date and Time:   15:29 Monday January 3, 2022
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250157159266078
--

prompt --application/pages/delete_00257
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>257);
end;
/
prompt --application/pages/page_00257
begin
wwv_flow_api.create_page(
 p_id=>257
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>unistr('Creaci\00F3n de lote')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Creaci\00F3n de lote')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20220103152115'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(151984825996089595)
,p_plug_name=>'Create Form'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164070834422707671)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(151987226446089627)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164075504857707680)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151987676863089633)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(151987226446089627)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(164103654258707764)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151989932866089641)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(151987226446089627)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(28371685100244501)
,p_branch_name=>'Ir a pagaina 255'
,p_branch_action=>'f?p=&APP_ID.:255:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(151989932866089641)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151985115653089596)
,p_name=>'P257_ID_DCLRCION_LOTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(151984825996089595)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151985551445089603)
,p_name=>'P257_NMBRE_LOTE'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(151984825996089595)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nombre lote'
,p_source=>'NMBRE_LOTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(164103392707707754)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151985943017089624)
,p_name=>'P257_DSCRPCION_LOTE'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(151984825996089595)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observaci\00F3n')
,p_source=>'DSCRPCION_LOTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>300
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(164103392707707754)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151994211798228701)
,p_name=>'P257_CDGO_CLNTE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(151984825996089595)
,p_use_cache_before_default=>'NO'
,p_item_default=>'&F_CDGO_CLNTE.'
,p_source=>'CDGO_CLNTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151994378903228702)
,p_name=>'P257_ID_USRIO_RGSTRO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(151984825996089595)
,p_use_cache_before_default=>'NO'
,p_item_default=>'&F_ID_USRIO.'
,p_source=>'ID_USRIO_RGSTRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(151987761593089633)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(151987676863089633)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(151988478735089638)
,p_event_id=>wwv_flow_api.id(151987761593089633)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(151990711921089642)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process form Create Form'
,p_attribute_02=>'GI_G_DECLARACIONES_LOTE'
,p_attribute_03=>'GI_G_DCLRCNES_LOTE'
,p_attribute_04=>'ID_DCLRCION_LOTE'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>unistr('\00A1Proceso realizado exitosamente!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(151991154866089643)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(151987676863089633)
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
