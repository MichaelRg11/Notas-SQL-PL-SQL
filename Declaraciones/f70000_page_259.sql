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
--   Date and Time:   15:31 Monday January 3, 2022
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250157159266078
--

prompt --application/pages/delete_00259
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>259);
end;
/
prompt --application/pages/page_00259
begin
wwv_flow_api.create_page(
 p_id=>259
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>'Seleccion de candidatos mediante carga de archivos'
,p_page_mode=>'MODAL'
,p_step_title=>'Seleccion de candidatos mediante carga de archivos'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(164065555011707626)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20220103153111'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(295052855270075639)
,p_plug_name=>'Cargue y procesamiento de archivo'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(152109842674191043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(295052855270075639)
,p_button_name=>'BTN_INSRTAR_ARCHVO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Insertar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P259_ID_PRCSO_CRGA'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(152110237123191045)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(295052855270075639)
,p_button_name=>'BTN_PRCSAR_ARCHVO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Procesar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P259_ID_PRCSO_CRGA'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-upload-alt'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(28371768571244502)
,p_branch_name=>'Ir a la pagina 255'
,p_branch_action=>'f?p=&APP_ID.:255:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(152110237123191045)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151994624983228705)
,p_name=>'P259_ID_PRCSO_LOTE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152110648250191046)
,p_name=>'P259_ARCHVO_DCLRCION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_prompt=>'Archivo de candidatos'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(164103055760707744)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152111072281191049)
,p_name=>'P259_CDGO_ARCHVO_TPO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_item_default=>'EX'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152111488664191049)
,p_name=>'P259_ID_CRGA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_item_default=>'39'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152111834424191050)
,p_name=>'P259_LNEAS_ENCBZDO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_item_default=>'2'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152112203789191050)
,p_name=>'P259_ID_PRCSO_CRGA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(295052855270075639)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(152113077726191053)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'PLUGIN_NL.AMIS.SCHEFFER.PROCESS.EXCEL2COLLECTION'
,p_process_name=>'Procesar_Archivo_Excel'
,p_attribute_01=>'P259_ARCHVO_DCLRCION'
,p_attribute_02=>'ETLEXC'
,p_attribute_04=>';'
,p_attribute_05=>'"'
,p_attribute_07=>'Y'
,p_attribute_08=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(152109842674191043)
,p_process_when=>'P259_CDGO_ARCHVO_TPO'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'EX'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(152113425986191053)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Guardar_Carga_Excel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_temp_files apex_application_temp_files%rowtype;',
'    v_count      number;',
'    filecounts   exception;',
'begin',
'',
'    select * ',
'      into v_temp_files',
'      from apex_application_temp_files',
'     where name = :P259_ARCHVO_DCLRCION;',
'     ',
'     select count(*)',
'       into v_count',
'       from et_g_procesos_carga',
'      where cdgo_clnte = :F_CDGO_CLNTE',
'        and file_name  = v_temp_files.filename;',
'      ',
'      if ( v_count > 0 ) then',
'           raise filecounts;',
'      end if;',
'       ',
'    insert into et_g_procesos_carga ( id_crga , cdgo_clnte , id_impsto , vgncia , file_blob , file_name  , file_mimetype ',
'                                     , cdgo_prcso_estdo , id_adtria , lneas_encbzdo , id_impsto_sbmpsto , id_prdo , id_usrio ) ',
'                             values ( :P259_ID_CRGA, :F_CDGO_CLNTE, null, null, v_temp_files.blob_content , v_temp_files.filename, v_temp_files.mime_type',
'                                    , ''SE'', null, :P259_LNEAS_ENCBZDO, null, null, :F_ID_USRIO ) returning id_prcso_crga into :P259_ID_PRCSO_CRGA;',
'',
'exception ',
'     when filecounts then',
'          :P259_ID_PRCSO_CRGA := null;',
'          raise_application_error(-20003 , ''El archivo '' ||  v_temp_files.filename || '' ya se encuentra procesado.'');',
'     when others then ',
'          :P259_ID_PRCSO_CRGA := null;',
'          raise_application_error(-20002 , ''No fue posible cargar el archivo.'' );',
'end;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(152109842674191043)
,p_process_when=>'P259_CDGO_ARCHVO_TPO'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'EX'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(152113820615191054)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Procesar_Excel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    o_cdgo_rspsta    number;',
'    o_mnsje_rspsta   varchar2(1000);',
'begin',
'    ',
'    pk_etl.prc_carga_intermedia_from_dir(p_cdgo_clnte    => TO_NUMBER(:F_CDGO_CLNTE)',
'                                       , p_id_prcso_crga => TO_NUMBER(:P259_ID_PRCSO_CRGA));',
'           ',
'    pk_etl.prc_carga_gestion(p_cdgo_clnte    => TO_NUMBER(:F_CDGO_CLNTE)',
'                           , p_id_prcso_crga => TO_NUMBER(:P259_ID_PRCSO_CRGA));',
'                           ',
'    update gi_g_declaraciones_lote set id_prcso_crga = TO_NUMBER(:P259_ID_PRCSO_CRGA)',
'    where id_dclrcion_lote = TO_NUMBER(:P259_ID_PRCSO_LOTE); ',
'    ',
'    commit;',
'    ',
'    /*pkg_gn_generalidades.prc_rg_seleccion_cnddts_archvo(p_cdgo_clnte         => :F_CDGO_CLNTE,',
'                                                        p_id_prcso_crga      => :P259_ID_PRCSO_CRGA,',
'                                                        p_id_lte             => :P259_ID_PRCSO_LOTE,',
'                                                        p_id_crga            => :P259_ID_CRGA,',
'                                                        o_cdgo_rspsta        => o_cdgo_rspsta,',
'                                                        o_mnsje_rspsta       => o_mnsje_rspsta);*/',
'    ',
'    if o_cdgo_rspsta <> 0 then',
'        raise_application_error(-20001, o_mnsje_rspsta);',
'    end if;',
'    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(152110237123191045)
,p_process_when=>'P259_ID_PRCSO_CRGA'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Proceso realizado exitosamente!'
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
