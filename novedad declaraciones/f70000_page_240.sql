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
--   Date and Time:   11:30 Friday November 19, 2021
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250147824739065
--

prompt --application/pages/delete_00240
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>240);
end;
/
prompt --application/pages/page_00240
begin
wwv_flow_api.create_page(
 p_id=>240
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>'Novedades de Declaraciones'
,p_step_title=>'Novedades de Declaraciones'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(164066127703707633)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20211118133955'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8341845415423401)
,p_plug_name=>'Novedades de Declaraciones'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164080387335707690)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * ',
'from v_gi_g_dclrcnes_nvdad',
'where id_impsto = nvl(:p240_id_imspto, id_impsto)',
'and id_impsto_sbmpsto = nvl(:p240_id_sub_imspto, id_impsto_sbmpsto)',
'and nmro_cnsctvo = nvl(:P240_NMRO_DCLRCION , nmro_cnsctvo)',
'and idntfccion = nvl(:P240_IDNTFCCION , idntfccion)',
'and nvl(to_date(:p240_fcha_incial, ''DD/MM/YYYY''), to_date(''01/01/1500'', ''DD/MM/YYYY'')) <= fcha_nvdad ',
'and fcha_nvdad <= nvl(to_date(to_date(:p240_fcha_fnal, ''DD/MM/YYYY'') + 1, ''DD/MM/YYYY''), sysdate + 1)',
'--and fcha_nvdad between to_date(:p240_fcha_incial, ''DD/MM/YYYY'') AND to_date(to_date(:p240_fcha_fnal, ''DD/MM/YYYY'') + 1, ''DD/MM/YYYY'')'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8423758083408026)
,p_name=>'ID_NVDAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_NVDAD'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:239:&SESSION.::&DEBUG.:RP:P239_ID_DCLRCION,P239_ID_NVDAD,P239_ID_STADO_NVDAD:&ID_DCLRCION.,&ID_NVDAD.,&CDGO_ESTDO.'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8423896411408027)
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
 p_id=>wwv_flow_api.id(8423964062408028)
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
 p_id=>wwv_flow_api.id(8424068314408029)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8424101831408030)
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
 p_id=>wwv_flow_api.id(8424211690408031)
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
 p_id=>wwv_flow_api.id(8424340749408032)
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
 p_id=>wwv_flow_api.id(8424476868408033)
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
 p_id=>wwv_flow_api.id(8424597903408034)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8424670942408035)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8424751102408036)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8424826201408037)
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
 p_id=>wwv_flow_api.id(8424998680408038)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8425013306408039)
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
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(8491719799153915)
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
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8494427510153942)
,p_name=>'ID_IMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_IMPSTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
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
 p_id=>wwv_flow_api.id(8494506390153943)
,p_name=>'ID_IMPSTO_SBMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_IMPSTO_SBMPSTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>190
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(8422674074408015)
,p_internal_uid=>8422674074408015
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
 p_id=>wwv_flow_api.id(8445536247529754)
,p_interactive_grid_id=>wwv_flow_api.id(8422674074408015)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(8445643404529754)
,p_report_id=>wwv_flow_api.id(8445536247529754)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8446157144529758)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(8423758083408026)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8446670388529763)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(8423896411408027)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8447126674529766)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(8423964062408028)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8447603762529769)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(8424068314408029)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8448136887529771)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(8424101831408030)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8448683961529773)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(8424211690408031)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>152.219
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8449136138529775)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(8424340749408032)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>169.562
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8449612278529777)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(8424476868408033)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>190.562
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8450147408529780)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(8424597903408034)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8450615021529782)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(8424670942408035)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8451152659529784)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(8424751102408036)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8451656900529786)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(8424826201408037)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8452123738529788)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(8424998680408038)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8452600961529791)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(8425013306408039)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>130.688
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8511753778310277)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(8491719799153915)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8599461342218157)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(8494427510153942)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8600073962218161)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(8494506390153943)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(21845981572269)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_execution_seq=>5
,p_name=>'Novedades aplicadas'
,p_background_color=>'#D2F7D2'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(8491719799153915)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'Aplicado'
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(21868564581231)
,p_view_id=>wwv_flow_api.id(8445643404529754)
,p_execution_seq=>10
,p_name=>'Novedades canceladas'
,p_background_color=>'#FCC7C7'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(8491719799153915)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'Cancelado'
,p_is_enabled=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157622568612814882)
,p_plug_name=>'opciones'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>30
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
 p_id=>wwv_flow_api.id(216360713586459346)
,p_plug_name=>unistr('<b>Par\00E1metros de  B\00FAsqueda</b>')
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164076287595707682)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8453907273550765)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(157622568612814882)
,p_button_name=>'P240_NVA_NVDAD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103654258707764)
,p_button_image_alt=>unistr('Nueva novedad declaraci\00F3n')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:239:&SESSION.::&DEBUG.:RP,239::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8572017365144565)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(216360713586459346)
,p_button_name=>'Consultar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consultar'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-window-search'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8494639416153944)
,p_name=>'P240_NMRO_DCLRCION'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>unistr('Numero declaraci\00F3n')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8494738355153945)
,p_name=>'P240_IDNTFCCION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>'Identificacion'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8572442684144569)
,p_name=>'P240_ID_IMSPTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>'<b>Impuesto</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_named_lov=>'LV_IMPUESTO_X_USUARIO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select b.nmbre_impsto || '' ['' || b.cdgo_impsto || '']'' d,',
'        a.id_impsto r',
'  from sg_g_usuarios_impuesto a ',
'  join df_c_impuestos b on a.id_impsto = b.id_impsto',
'where a.id_usrio = :F_ID_USRIO',
'  and b.cdgo_clnte = :F_CDGO_CLNTE',
'  and a.actvo = ''S''',
'  and b.actvo = ''S''',
'order by 1;'))
,p_lov_display_null=>'YES'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'80%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8572791678144576)
,p_name=>'P240_ID_SUB_IMSPTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>'<b>Sub - Impuesto</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  nmbre_impsto_sbmpsto,',
'   id_impsto_sbmpsto ',
'from df_i_impuestos_subimpuesto',
'where id_impsto = :P240_ID_IMSPTO'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P240_ID_IMSPTO'
,p_ajax_items_to_submit=>'P240_ID_IMSPTO'
,p_ajax_optimize_refresh=>'Y'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'80%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8574767287144578)
,p_name=>'P240_FCHA_INCIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>'<b>Fecha Inicial</b>'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_attributes=>'onkeydown="return false" '
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'+0d'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'MONTH_AND_YEAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8575180083144578)
,p_name=>'P240_FCHA_FNAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(216360713586459346)
,p_prompt=>'<b>Fecha Final</b>'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_attributes=>'onkeydown="return false" '
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_02=>'&P240_FCHA_INCIAL.'
,p_attribute_03=>'+0d'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'MONTH_AND_YEAR'
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
