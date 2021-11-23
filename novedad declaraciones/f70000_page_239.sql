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
--   Date and Time:   11:31 Friday November 19, 2021
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250147824739065
--

prompt --application/pages/delete_00239
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>239);
end;
/
prompt --application/pages/page_00239
begin
wwv_flow_api.create_page(
 p_id=>239
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>'Declaraciones novedad de declaraciones'
,p_step_title=>'Declaraciones novedad de declaraciones'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const peticionServerProcess = (proc, json = {}) => {',
'  return apex.server.process(proc, json);',
'}',
'',
'',
'const selectItem = async () => {',
'  let table = apex.region("tablaDetalle").widget().interactiveGrid("getViews").grid.getSelectedRecords();',
'  let array = table[0]',
'  ',
'  console.log(array);',
'  ',
'  localStorage.setItem(''array'', JSON.stringify(array));',
'  ',
'  let declaracion = {',
'    idDeclaracion: array[1],',
'    idImpuesto: array[2],',
'    idPeriodo: array[10],',
'    idFormulario: array[18],',
'    idDeclaracionTipo: array[19],',
'    idVigencia: array[9],',
'    estadoDeclaracion: array[5],',
'    nombreImpuesto: array[6],',
'    nombreSubImpuesto: array[7],',
'    fechaPresentacion: array[11],',
'    identificacionSujeto: array[12],',
'    razonSocial: array[14],',
'    idVigenciaFormulario: array[20],',
'    numeroDeclaracion: array[4],',
'    idSujetoImpuesto: array[21],',
'  };',
'  ',
'  let resp = await peticionServerProcess(''set_state'', {',
'                                                x01: declaracion.idDeclaracion,',
'                                                x02: declaracion.idPeriodo,',
'                                                x03: declaracion.idFormulario,',
'                                                x04: declaracion.idDeclaracionTipo,',
'                                                x05: declaracion.idVigencia,',
'                                                x06: declaracion.estadoDeclaracion,',
'                                                x07: declaracion.nombreImpuesto,',
'                                                x08: declaracion.nombreSubImpuesto,',
'                                                x09: declaracion.fechaPresentacion,',
'                                                x10: declaracion.identificacionSujeto,',
'                                                x11: declaracion.razonSocial,',
'                                                x12: declaracion.idImpuesto,',
'                                                x13: declaracion.idVigenciaFormulario,',
'                                                x14: declaracion.numeroDeclaracion,',
'                                                x15: declaracion.idSujetoImpuesto',
'                                              });',
'  ',
'  console.log(resp);',
'  let region = apex.region(''formulario'');',
'  region.refresh();',
'  location.reload();',
'}'))
,p_step_template=>wwv_flow_api.id(164066127703707633)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20211118145438'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8425984645408048)
,p_plug_name=>'<b>Detalle novedad</b>'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P239_ID_NVDAD'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16880572245892424)
,p_plug_name=>'Novedades de Declaraciones'
,p_parent_plug_id=>wwv_flow_api.id(8425984645408048)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164080387335707690)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from V_GI_G_DCLRCNES_NVDAD',
'where id_nvdad = :P239_ID_NVDAD'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962484913877049)
,p_name=>'ID_NVDAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_NVDAD'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>170
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962623241877050)
,p_name=>'ID_DCLRCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_DCLRCION'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962690892877051)
,p_name=>'CDGO_ESTDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CDGO_ESTDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962795144877052)
,p_name=>'FCHA_NVDAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FCHA_NVDAD'
,p_data_type=>'TIMESTAMP'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Fecha de generaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD-MON-YYYY'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962828661877053)
,p_name=>'CDGO_TPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CDGO_TPO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Tipo novedad'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>10
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16962938520877054)
,p_name=>'DSCRPCION_TPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION_TPO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Descripci\00F3n novedad')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>250
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963067579877055)
,p_name=>'VGNCIA_ANT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA_ANT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vigencia anterior'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>91
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963203698877056)
,p_name=>'VGNCIA_NVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA_NVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nueva vigencia'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>91
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963324733877057)
,p_name=>'NMRO_CNSCTVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMRO_CNSCTVO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('Numero declaraci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963397772877058)
,p_name=>'NMBRE_DCLRCION_USO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_DCLRCION_USO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Estado declaraci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>1000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963477932877059)
,p_name=>'NMBRE_IMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_IMPSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Impuesto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963553031877060)
,p_name=>'NMBRE_IMPSTO_SBMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_IMPSTO_SBMPSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Sub. impuesto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963725510877061)
,p_name=>'NMBRE_RZON_SCIAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_RZON_SCIAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Raz\00F3n social')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16963740136877062)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>25
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17030446629622938)
,p_name=>'STADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STADO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Estado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>9
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(16961400904877038)
,p_internal_uid=>16961400904877038
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(16984263077998777)
,p_interactive_grid_id=>wwv_flow_api.id(16961400904877038)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(16984370234998777)
,p_report_id=>wwv_flow_api.id(16984263077998777)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16984883974998781)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(16962484913877049)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16985397218998786)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(16962623241877050)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16985853504998789)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(16962690892877051)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16986330592998792)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(16962795144877052)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16986863717998794)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(16962828661877053)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16987410791998796)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(16962938520877054)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16987862968998798)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(16963067579877055)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16988339108998800)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(16963203698877056)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16988874238998803)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(16963324733877057)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16989341851998805)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(16963397772877058)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16989879489998807)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(16963477932877059)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16990383730998809)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(16963553031877060)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16990850568998811)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(16963725510877061)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16991327791998814)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(16963740136877062)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17050480608779300)
,p_view_id=>wwv_flow_api.id(16984370234998777)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(17030446629622938)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(149167507867264115)
,p_plug_name=>unistr('<b>Declaraci\00F3n</b>')
,p_region_name=>'formulario'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'V_GI_G_DECLARACIONES'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(149168882530264128)
,p_plug_name=>'opciones'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<br>',
'<h5><b>',
'        <i><center>Opciones <i class="fa fa-gears" aria-hidden="true"></i></center>',
'        </i> ',
'    </b>',
'</h5>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199426509328615056)
,p_plug_name=>'Ayuda'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<br>',
'<h5>',
'    <b>',
'        <i>',
'            <center>Ayuda <i class="fa fa-question-circle" aria-hidden="true"></i></center>',
' ',
'    </b>',
'</h5>',
unistr('Funci\00F3n que permite'),
'<br>',
unistr('editar la vigencia de las declaraciones presentadas ante la administraci\00F3n.'),
'<br>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8492478105153922)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'regresar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Regresar'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:240:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(149168974092264129)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'Consultar_editar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103654258707764)
,p_button_image_alt=>unistr('Consultar declaraci\00F3n')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:242:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(149686584725069209)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'procesar_nvdad'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Crear Novedad'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-save'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8425141882408040)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'aplicar_nvdad'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Aplicar Novedad'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P239_ID_NVDAD'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-check-square-o'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8425369157408042)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'cancelar_nvdad'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Cancelar Novedad'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P239_ID_NVDAD'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-times-circle-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8069524473000308)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(149168882530264128)
,p_button_name=>'Detalle_declaracion'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--noUI:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103654258707764)
,p_button_image_alt=>unistr('Detalle Declaraci\00F3n')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:133:&SESSION.::&DEBUG.:RP,133:P133_ID_DCLRCION:&P239_ID_DCLRCION.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8068846633000301)
,p_name=>'P239_VGNCIA_ANTRIOR'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Vigencia anterior'
,p_source=>'VGNCIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_column=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8069798496000310)
,p_name=>'P239_NMRO_DCLRCION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>unistr('Numero de la Declaraci\00F3n')
,p_source=>'NMRO_CNSCTVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8425618708408045)
,p_name=>'P239_ID_NVDAD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(149168882530264128)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8425757862408046)
,p_name=>'P239_ID_PRDO_ANT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_PRDO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8425873407408047)
,p_name=>'P239_ID_VGNCIA_FRMLRIO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_DCLRCION_VGNCIA_FRMLRIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8493620547153934)
,p_name=>'P239_ID_STADO_NVDAD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(149168882530264128)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8494353747153941)
,p_name=>'P239_ID_SJTO_IMPSTO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_SJTO_IMPSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8495105607153949)
,p_name=>'P239_VGNCIA_NUEVA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Vigencia'
,p_source=>'VGNCIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169201478264132)
,p_name=>'P239_ID_DCLRCION'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_DCLRCION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169377841264133)
,p_name=>'P239_NMBRE_DCLRCION_USO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Estado'
,p_source=>'NMBRE_DCLRCION_USO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1000
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169401892264134)
,p_name=>'P239_NMBRE_IMPSTO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nmbre_impsto from df_c_impuestos ',
'where id_impsto = :P239_ID_IMPSTO'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Nombre del impuesto'
,p_source=>'NMBRE_IMPSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169593007264135)
,p_name=>'P239_NMBRE_IMPSTO_SBMPSTO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Nombre del Sub Impuesto'
,p_source=>'NMBRE_IMPSTO_SBMPSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169645445264136)
,p_name=>'P239_IDNTFCCION_SJTO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>unistr('Identificaci\00F3n del sujeto')
,p_source=>'IDNTFCCION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169740964264137)
,p_name=>'P239_NMBRE_RZON_SCIAL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Nombre del sujeto'
,p_source=>'NMBRE_RZON_SCIAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149169845994264138)
,p_name=>'P239_FCHA_RGSTRO'
,p_source_data_type=>'TIMESTAMP'
,p_is_required=>true
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Fecha de registro'
,p_format_mask=>'fmDay, fmDD fmMonth, YYYY'
,p_source=>'FCHA_RGSTRO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149170590440264145)
,p_name=>'P239_ID_VGNCIA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Nueva Vigencia'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select b.vgncia || '' '' || c.dscrpcion r, a.id_dclrcion_vgncia_frmlrio d',
'from gi_d_dclrcnes_vgncias_frmlr a',
'join gi_d_dclrcnes_tpos_vgncias  b on a.id_dclrcion_tpo_vgncia = b.id_dclrcion_tpo_vgncia',
'join df_i_periodos               c on b.id_prdo = c.id_prdo',
'join gi_d_declaraciones_tipo     d on d.id_dclrcn_tpo = b.id_dclrcn_tpo',
'where d.id_dclrcn_tpo = :P239_ID_DCLRCION_TPO',
'and   a.id_frmlrio = :P239_ID_FRMLRIO',
'and not exists (select *   ',
'                from gi_g_declaraciones z',
'                where z.id_dclrcion_vgncia_frmlrio = a.id_dclrcion_vgncia_frmlrio ',
'                and z.id_sjto_impsto = :P239_ID_SJTO_IMPSTO)',
'order by d asc;'))
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P239_ID_NVDAD'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149170682448264146)
,p_name=>'P239_ID_PERIODO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_prompt=>'Periodo'
,p_source=>'DSCRPCION_PRDO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Periodo actual en el que se encuentra la declaraci\00F3n.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149170765015264147)
,p_name=>'P239_ID_IMPSTO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_IMPSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149685996464069203)
,p_name=>'P239_ID_FRMLRIO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_FRMLRIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149686069383069204)
,p_name=>'P239_ID_DCLRCION_TPO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(149167507867264115)
,p_item_source_plug_id=>wwv_flow_api.id(149167507867264115)
,p_source=>'ID_DCLRCN_TPO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149594170026521767)
,p_name=>'Al Cambiar Fecha Inicio'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_FCHA_INCIAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149594547599521785)
,p_event_id=>wwv_flow_api.id(149594170026521767)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P239_FCHA_FNAL").datepicker( ''option'' , ''minDate'' , $("#P239_FCHA_INCIAL").val());',
'$(".ui-datepicker-trigger").attr( "class" , "ui-datepicker-trigger a-Button a-Button--calendar" );'))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149170868420264148)
,p_name=>'Seleccionar declaracion'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(149168974092264129)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149170967204264149)
,p_event_id=>wwv_flow_api.id(149170868420264148)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'selectItem()'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8068989128000302)
,p_name=>'Habilitar modificacion'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_VGNCIA'
,p_condition_element=>'P239_ID_VGNCIA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8069025448000303)
,p_event_id=>wwv_flow_api.id(8068989128000302)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(149686584725069209)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8069276419000305)
,p_name=>'Desabilitar modificacion'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_VGNCIA'
,p_condition_element=>'P239_ID_VGNCIA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8069308371000306)
,p_event_id=>wwv_flow_api.id(8069276419000305)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(149686584725069209)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8069853875000311)
,p_name=>'Habilitar detalle'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_NMRO_DCLRCION'
,p_condition_element=>'P239_NMRO_DCLRCION'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8069947202000312)
,p_event_id=>wwv_flow_api.id(8069853875000311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8069524473000308)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8070044755000313)
,p_name=>'Desabilitar detalle'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_NMRO_DCLRCION'
,p_condition_element=>'P239_NMRO_DCLRCION'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8070148692000314)
,p_event_id=>wwv_flow_api.id(8070044755000313)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8069524473000308)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8492533268153923)
,p_name=>unistr('Ocultar bot\00F3n crear novedad')
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8492636344153924)
,p_event_id=>wwv_flow_api.id(8492533268153923)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(149686584725069209)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8619660456261402)
,p_name=>'Ocultar item videncia nuevo'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8619751804261403)
,p_event_id=>wwv_flow_api.id(8619660456261402)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P239_VGNCIA_ANTRIOR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8619848033261404)
,p_name=>'Ocultar item videncia anterior'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8619920778261405)
,p_event_id=>wwv_flow_api.id(8619848033261404)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P239_VGNCIA_NUEVA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8494174435153939)
,p_name=>'Ocultar item id_vgncia'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8494224651153940)
,p_event_id=>wwv_flow_api.id(8494174435153939)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P239_ID_VGNCIA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8493401426153932)
,p_name=>unistr('mostrar bot\00F3n crear novedad')
,p_event_sequence=>110
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8493585056153933)
,p_event_id=>wwv_flow_api.id(8493401426153932)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(149686584725069209)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8492785554153925)
,p_name=>unistr('Ocultar bot\00F3n aplicar novedad')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8492882538153926)
,p_event_id=>wwv_flow_api.id(8492785554153925)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425141882408040)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8492901899153927)
,p_name=>unistr('Ocultar bot\00F3n cancelar novedad')
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_NVDAD'
,p_condition_element=>'P239_ID_NVDAD'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8493029747153928)
,p_event_id=>wwv_flow_api.id(8492901899153927)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425369157408042)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8493820495153936)
,p_name=>'Ocultar botones de aplicar y cancelar'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_STADO_NVDAD'
,p_condition_element=>'P239_ID_STADO_NVDAD'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'AP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8493972642153937)
,p_event_id=>wwv_flow_api.id(8493820495153936)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425141882408040)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8494007003153938)
,p_event_id=>wwv_flow_api.id(8493820495153936)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425369157408042)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8494841214153946)
,p_name=>'Ocultar botones de aplicar y cancelar_1'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P239_ID_STADO_NVDAD'
,p_condition_element=>'P239_ID_STADO_NVDAD'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'CN'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8494944158153947)
,p_event_id=>wwv_flow_api.id(8494841214153946)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425141882408040)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8495040410153948)
,p_event_id=>wwv_flow_api.id(8494841214153946)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8425369157408042)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8425455908408043)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'crear_novedad'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Se quema el id del tipo de novedad, por ahora.',
'declare',
'  v_id_tpo_vgncia   number;',
'  v_vgncia          number;',
'  v_id_prdo         number;',
'  v_id_nvdad        number;',
'  v_mnsje_rspsta    varchar2(2000);',
'  v_cdgo_rspsta     number := 0;',
'  v_sqlerrm         clob;',
'begin',
'  -- Se busca el id del tipo de vigencia de la declaracion',
'  select id_dclrcion_tpo_vgncia into v_id_tpo_vgncia from gi_d_dclrcnes_vgncias_frmlr',
'  where id_dclrcion_vgncia_frmlrio = :P239_ID_VGNCIA;',
'  ',
'  -- Se optiene la vigencia y el periodo por le cual se va a cambiar',
'  select vgncia, id_prdo into v_vgncia, v_id_prdo from  gi_d_dclrcnes_tpos_vgncias ',
'  where id_dclrcion_tpo_vgncia = v_id_tpo_vgncia;',
'    ',
'  pkg_gi_declaraciones_nvdad.prc_rg_dclrcion_nvdad(p_id_dclrcion                    => :P239_ID_DCLRCION ',
'                                                 , p_id_dclrcion_vgncia_frmlrio_ant => :P239_ID_VGNCIA_FRMLRIO ',
'                                                 , p_vgncia_antrior                 => :P239_VGNCIA_ANTRIOR',
'                                                 , p_id_prdo_antrior                => :P239_ID_PRDO_ANT',
'                                                 , p_id_dclrcion_vgncia_frmlrio_nvo => :P239_ID_VGNCIA',
'                                                 , p_vgncia_nvo                     => v_vgncia',
'                                                 , p_id_prdo_nvo                    => v_id_prdo',
'                                                 , p_id_nvdad_tpo                   => 1',
'                                                 , o_id_nvdad                       => v_id_nvdad',
'                                                 , o_mnsje_rspsta                   => v_mnsje_rspsta',
'                                                 , o_cdgo_rspsta                    => v_cdgo_rspsta);',
'                                                 ',
'  insert into muerto(v_001, t_001) values(v_mnsje_rspsta || '' - '' || v_cdgo_rspsta, systimestamp); commit;',
'  if v_cdgo_rspsta = 0 then',
'    apex_util.Set_session_state(''P239_ID_NVDAD'', v_id_nvdad);',
'  end if;',
'end;'))
,p_process_error_message=>'no se creo la novedad'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(149686584725069209)
,p_process_when=>'P239_ID_VGNCIA'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Se creo la novedad'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8493276321153930)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'aplicar_novedad'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Se quema el id del tipo de novedad, por ahora.',
'declare',
'  v_mnsje_rspsta    varchar2(2000);',
'  v_cdgo_rspsta     number := 0;',
'  v_sqlerrm         varchar2(2000);',
'begin',
'  ',
'  pkg_gi_declaraciones_nvdad.pr_ac_dclrcion_nvdad(p_id_nvdad      => :P239_ID_NVDAD',
'                                                , p_stado_nvdad   => ''AP''',
'                                                , p_cdgo_clnte    => :F_CDGO_CLNTE',
'                                                , o_mnsje_rspsta  => v_mnsje_rspsta',
'                                                , o_cdgo_rspsta   => v_cdgo_rspsta);',
'                               ',
'                               ',
'  apex_util.Set_session_state(''P239_ID_STADO_NVDAD'', ''AP'');',
'  if v_cdgo_rspsta <> 0 then',
'    insert into muerto(v_001, t_001) values(v_mnsje_rspsta || '' - '' || v_cdgo_rspsta, systimestamp); commit;',
'  end if;',
'end;'))
,p_process_error_message=>'No se ha podido aplicar la novedad.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8425141882408040)
,p_process_when=>'P239_ID_NVDAD'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Se ha aplicado la novedad correctamente.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8493318646153931)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'cancelar_novedad'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Se quema el id del tipo de novedad, por ahora.',
'declare',
'  v_mnsje_rspsta    varchar2(2000);',
'  v_cdgo_rspsta     number := 0;',
'  v_sqlerrm         varchar2(2000);',
'begin',
'  ',
'  pkg_gi_declaraciones_nvdad.pr_ac_dclrcion_nvdad(p_id_nvdad      => :P239_ID_NVDAD',
'                                                , p_stado_nvdad   => ''CN''',
'                                                , p_cdgo_clnte    => :F_CDGO_CLNTE',
'                                                , o_mnsje_rspsta  => v_mnsje_rspsta',
'                                                , o_cdgo_rspsta   => v_cdgo_rspsta);',
'                                                 ',
'  apex_util.Set_session_state(''P239_ID_STADO_NVDAD'', ''AC'');',
'  if v_cdgo_rspsta <> 0 then',
'    insert into muerto(v_001, t_001) values(v_mnsje_rspsta || '' - '' || v_cdgo_rspsta, systimestamp); commit;',
'  end if;',
'end;'))
,p_process_error_message=>'No se ha podido cancelar la novedad.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8425369157408042)
,p_process_when=>'P239_ID_NVDAD'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Se ha cancelado la novedad correctamente.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(149751323989541701)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'novedad'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_id_tpo_vgncia   number;',
'  v_id_rcdo         number;',
'  v_id_lqdcion      number;',
'  v_id_mvmnto_fncro number;',
'  v_id_sjto_impsto  number;',
'  v_vgncia          varchar2(20);',
'  v_id_prdo         number;',
'  v_sqlerrm         clob;',
'  v_number          number;',
'begin',
'  -- Se busca el id del tipo de vigencia de la declaracion',
'  select id_dclrcion_tpo_vgncia into v_id_tpo_vgncia from gi_d_dclrcnes_vgncias_frmlr',
'  where id_dclrcion_vgncia_frmlrio = :P239_ID_VGNCIA;',
'  ',
'  -- Se optiene la vigencia y el periodo por le cual se va a cambiar',
'  select vgncia, id_prdo into v_vgncia, v_id_prdo from  gi_d_dclrcnes_tpos_vgncias ',
'  where id_dclrcion_tpo_vgncia = v_id_tpo_vgncia;',
'  ',
'  -- Se actualiza la declaracion y se retorna el id recaudo ',
'  -- y el id liquidacion si existe para hacerles el cambio de vigencia y periodo',
'  update gi_g_declaraciones ',
'  set id_dclrcion_vgncia_frmlrio = :P239_ID_VGNCIA',
'    , vgncia = v_vgncia',
'    , id_prdo = v_id_prdo',
'  where id_dclrcion = :P239_ID_DCLRCION',
'  return id_rcdo, id_lqdcion, id_sjto_impsto into v_id_rcdo, v_id_lqdcion, v_id_sjto_impsto;',
'  commit;',
'  ',
'  -- Se actualiza los movimientos finaciero y detalles de la declaracion por medio del id origen',
'  update gf_g_movimientos_financiero',
'  set vgncia = v_vgncia',
'    , id_prdo = v_id_prdo',
'  where id_orgen = :P239_ID_DCLRCION;',
'  commit;',
'  ',
'  update gf_g_movimientos_detalle',
'  set vgncia = v_vgncia',
'    , id_prdo = v_id_prdo',
'  where id_orgen = v_id_rcdo;',
'  commit;',
'  ',
'  -- Se actualiza la liquidacion de la declaracion por medio del id liquidacion  ',
'  if v_id_rcdo is not null then ',
'    update gi_g_liquidaciones',
'    set vgncia = v_vgncia',
'      , id_prdo = v_id_prdo',
'    where id_lqdcion = v_id_lqdcion;',
'    commit;',
'  end if;',
'  ',
'   pkg_gf_movimientos_financiero.prc_ac_concepto_consolidado(p_cdgo_clnte               => :F_CDGO_CLNTE',
'                                                           , p_id_sjto_impsto           => v_id_sjto_impsto',
'                                                           , p_ind_ejc_ac_dsm_pbl_pnt	  => ''N'' ',
'                                                           , p_ind_brrdo_sjto_impsto	  => ''S'' ); ',
'  ',
'  -- Limpiamos los items',
'  /*apex_util.Set_session_state(''P239_NMRO_DCLRCION'', '''');',
'  apex_util.Set_session_state(''P239_ID_DCLRCION'', '''');',
'  apex_util.Set_session_state(''P239_ID_PERIODO'', '''');',
'  apex_util.Set_session_state(''P239_ID_FRMLRIO'', '''');',
'  apex_util.Set_session_state(''P239_ID_DCLRCION_TPO'', '''');',
'  apex_util.Set_session_state(''P239_ID_VGNCIA'', '''');',
'  apex_util.Set_session_state(''P239_NMBRE_IMPSTO'', '''');',
'  apex_util.Set_session_state(''P239_NMBRE_DCLRCION_USO'', '''');',
'  apex_util.Set_session_state(''P239_NMBRE_IMPSTO_SBMPSTO'', '''');',
'  apex_util.Set_session_state(''P239_FCHA_PRSNTCION'', '''');',
'  apex_util.Set_session_state(''P239_IDNTFCCION_SJTO'', '''');',
'  apex_util.Set_session_state(''P239_NMBRE_RZON_SCIAL'', '''');',
'  apex_util.Set_session_state(''P239_ID_IMPSTO'', '''');',
'  apex_util.Set_session_state(''P239_VGNCIA_ANTRIOR'', '''');',
'  apex_util.Set_session_state(''P_239_ID_SJTO_IMPSTO'', '''');*/',
'  commit; ',
'  ',
'  exception',
'    when others then',
'      v_sqlerrm := sqlerrm;',
'      insert into muerto (v_001, c_001, t_001) values (''ha ocurrido un error.'', v_sqlerrm, systimestamp);',
'      rollback;',
'end;'))
,p_process_error_message=>unistr('No se ha podido actualizar la declaraci\00F3n.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Se ha actualizado correctamente la declaraci\00F3n.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8360089844674615)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(149167507867264115)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Declaraciones novedad de declaraciones'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(149686327553069207)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'set_state'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_id_dclrcion varchar2(50)        := apex_application.g_x01;',
'  v_id_fmlrio varchar2(50)          := apex_application.g_x03;',
'  v_id_prdo varchar2(50)            := apex_application.g_x02;',
'  v_id_dclrcion_tpo varchar2(50)    := apex_application.g_x04;',
'  v_id_vgncia varchar2(50)          := apex_application.g_x05;',
'  v_nmbre_dclrcion varchar2(50)     := apex_application.g_x06;',
'  v_nmbre_impsto varchar2(50)       := apex_application.g_x07;',
'  v_nmbre_sub_impsto varchar2(50)   := apex_application.g_x08;',
'  v_fcha_prsntcion varchar2(50)     := apex_application.g_x09;',
'  v_idntfcion_sjto varchar2(50)     := apex_application.g_x10;',
'  v_rzon_scial varchar2(50)         := apex_application.g_x11;',
'  v_estdo varchar2(50)              := apex_application.g_x12;',
'  v_vgncia_frmlrio varchar2(50)     := apex_application.g_x13;',
'  v_nmro_dclrcion varchar2(50)      := apex_application.g_x14;',
'  v_id_sjto_impsto varchar2(50)     := apex_application.g_x15;',
'begin',
'  --:P239_NMRO_DCLRCION',
'  apex_util.Set_session_state(''P239_NMRO_DCLRCION'', v_nmro_dclrcion);',
'  apex_util.Set_session_state(''P239_ID_DCLRCION'', v_id_dclrcion);',
'  apex_util.Set_session_state(''P239_ID_PERIODO'', v_id_prdo);',
'  apex_util.Set_session_state(''P239_ID_FRMLRIO'', v_id_fmlrio);',
'  apex_util.Set_session_state(''P239_ID_DCLRCION_TPO'', v_id_dclrcion_tpo);',
'  apex_util.Set_session_state(''P239_ID_VGNCIA'', ''''/*v_vgncia_frmlrio*/); -- Comentado para que no escoja la vigencia automatica',
'  apex_util.Set_session_state(''P239_NMBRE_IMPSTO'', v_nmbre_impsto);',
'  apex_util.Set_session_state(''P239_NMBRE_DCLRCION_USO'', v_nmbre_dclrcion);',
'  apex_util.Set_session_state(''P239_NMBRE_IMPSTO_SBMPSTO'', v_nmbre_sub_impsto);',
'  apex_util.Set_session_state(''P239_FCHA_PRSNTCION'', v_fcha_prsntcion);',
'  apex_util.Set_session_state(''P239_IDNTFCCION_SJTO'', v_idntfcion_sjto);',
'  apex_util.Set_session_state(''P239_NMBRE_RZON_SCIAL'', v_rzon_scial);',
'  apex_util.Set_session_state(''P239_ID_IMPSTO'', v_rzon_scial);',
'  apex_util.Set_session_state(''P239_VGNCIA_ANTRIOR'', v_id_vgncia);',
'  apex_util.Set_session_state(''P_239_ID_SJTO_IMPSTO'', v_id_sjto_impsto);',
'  apex_json.Open_Object();',
'  apex_json.write(''P66_JSON'', ''echo el cambio'');',
'  apex_json.close_Object();',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
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
