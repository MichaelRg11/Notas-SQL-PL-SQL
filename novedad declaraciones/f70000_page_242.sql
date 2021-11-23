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

prompt --application/pages/delete_00242
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>242);
end;
/
prompt --application/pages/page_00242
begin
wwv_flow_api.create_page(
 p_id=>242
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>'Declaracion Busqueda'
,p_page_mode=>'MODAL'
,p_step_title=>'Declaracion Busqueda'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20211118132811'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157536579820965306)
,p_plug_name=>'<b>Detalle de consulta</b>'
,p_region_name=>'tablaDeclaraciones'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164076287595707682)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(207794329141316235)
,p_plug_name=>'Detalle'
,p_region_name=>'tablaDetalle'
,p_parent_plug_id=>wwv_flow_api.id(157536579820965306)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164080387335707690)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select      a.id_dclrcion,',
'            a.nmro_cnsctvo,',
'            k.nmbre_dclrcion_uso,',
'            g.id_impsto,',
'            g.nmbre_impsto,',
'            h.nmbre_impsto_sbmpsto,',
'            f.dscrpcion dscrpcion_tpo_dcrlcion,',
'            c.vgncia,',
'            d.id_prdo,',
'            d.dscrpcion dscrpcion_prdo,',
'            i.idntfccion_sjto,            ',
'            i.idntfccion_antrior,',
'            j.nmbre_rzon_scial,',
'            a.fcha_prsntcion,',
'            to_char(a.bse_grvble, ''999G999G999G999G999G999G999G999G999G999'') bse_grvble,',
'            to_char(a.vlor_ttal, ''999G999G999G999G999G999G999G999G999G999'') vlor_ttal,',
'            to_char((select sum(l.vlor_sldo_cptal + l.vlor_intres)',
'                       from v_gf_g_cartera_x_vigencia l',
'                      where l.id_sjto_impsto = a.id_sjto_impsto',
'                        and l.id_prdo = a.id_prdo',
'                        and l.vgncia = a.vgncia',
'                        and l.id_orgen = a.id_dclrcion) , ''999G999G999G999G999G999G999G999G999G999'') crtra_prdo,',
'            b.id_frmlrio,',
'            f.id_dclrcn_tpo,',
'            b.id_dclrcion_vgncia_frmlrio,',
'            a.id_sjto_impsto',
'from        gi_g_declaraciones          a',
'inner join  gi_d_dclrcnes_vgncias_frmlr b   on  b.id_dclrcion_vgncia_frmlrio    =   a.id_dclrcion_vgncia_frmlrio',
'inner join  gi_d_dclrcnes_tpos_vgncias  c   on  c.id_dclrcion_tpo_vgncia        =   b.id_dclrcion_tpo_vgncia',
'inner join  df_i_periodos               d   on  d.id_prdo                       =   c.id_prdo',
'inner join  df_s_periodicidad           e   on  e.cdgo_prdcdad                  =   d.cdgo_prdcdad',
'inner join  gi_d_declaraciones_tipo     f   on  f.id_dclrcn_tpo                 =   c.id_dclrcn_tpo',
'inner join  df_c_impuestos              g   on  g.id_impsto                     =   f.id_impsto',
'inner join  df_i_impuestos_subimpuesto  h   on  h.id_impsto_sbmpsto             =   f.id_impsto_sbmpsto',
'inner join  v_si_i_sujetos_impuesto     i   on  i.id_sjto_impsto                =   a.id_sjto_impsto',
'inner join  si_i_personas               j   on  j.id_sjto_impsto                =   i.id_sjto_impsto',
'inner join  gi_d_declaraciones_uso      k   on  k.id_dclrcion_uso               =   a.id_dclrcion_uso',
'where       a.cdgo_clnte            =   :F_CDGO_CLNTE',
'and         g.id_impsto             =   nvl(:P242_ID_IMSPTO, g.id_impsto)',
'and         h.id_impsto_sbmpsto     =   nvl(:P242_ID_SUB_IMSPTO, h.id_impsto_sbmpsto)',
'and         f.id_dclrcn_tpo         =   nvl(:P242_ID_DCLRCN_TPO, f.id_dclrcn_tpo)',
'and         d.vgncia                =   nvl(:P242_VGNCIA, d.vgncia)',
'and         d.id_prdo               =   nvl(:P242_ID_PRDO, d.id_prdo)',
'and         case',
'                when j.id_sjto_tpo is null and :P242_ID_SJTO_TPO is null then 1',
'                when j.id_sjto_tpo = nvl(:P242_ID_SJTO_TPO, j.id_sjto_tpo) then 1',
'                else 0                    ',
'            end                     =   1',
'and         a.id_dclrcion_uso       =   nvl(:P242_ID_DCLRCION_USO, a.id_dclrcion_uso)',
'and         i.idntfccion_sjto       =   nvl(:P242_IDNTFCCION, i.idntfccion_sjto)',
'and         k.cdgo_dclrcion_uso     =   ''DIN''',
'and         a.cdgo_dclrcion_estdo   in  (''PRS'', ''APL'', ''FRM'')',
'--and         (A.INDCDOR_MGRDO <> ''C'' OR A.INDCDOR_MGRDO IS NULL)',
'and         (to_char(a.fcha_prsntcion,''YYYYMMDD'') >= to_char(TO_DATE(:P242_FCHA_INCIAL,''DD/MM/YYYY''),''YYYYMMDD'') OR :P242_FCHA_INCIAL IS NULL)',
'and         a.id_dclrcion_crrccion is null'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(16439416567701508)
,p_name=>'ID_SJTO_IMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_SJTO_IMPSTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
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
 p_id=>wwv_flow_api.id(158054880766770393)
,p_name=>'ID_IMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_IMPSTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(158054917684770394)
,p_name=>'ID_PRDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRDO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(158055273599770397)
,p_name=>'ID_FRMLRIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_FRMLRIO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(158055373244770398)
,p_name=>'ID_DCLRCN_TPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_DCLRCN_TPO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>210
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(158055575737770400)
,p_name=>'ID_DCLRCION_VGNCIA_FRMLRIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_DCLRCION_VGNCIA_FRMLRIO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>220
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(172728418605684489)
,p_name=>'IDNTFCCION_ANTRIOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION_ANTRIOR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_api.id(172728492186684490)
,p_name=>'NMBRE_RZON_SCIAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_RZON_SCIAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Raz\00F3n Social')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>160
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_api.id(172728628894684491)
,p_name=>'BSE_GRVBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BSE_GRVBLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Base Gravable'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'RIGHT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>40
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
 p_id=>wwv_flow_api.id(172728670780684492)
,p_name=>'FCHA_PRSNTCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FCHA_PRSNTCION'
,p_data_type=>'TIMESTAMP'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Fecha Presentaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/YYYY'
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
 p_id=>wwv_flow_api.id(207196161886845290)
,p_name=>'CRTRA_PRDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CRTRA_PRDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cartera'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
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
 p_id=>wwv_flow_api.id(207794611156316238)
,p_name=>'ID_DCLRCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_DCLRCION'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_stretch=>'A'
,p_link_target=>'f?p=&APP_ID.:239:&SESSION.::&DEBUG.:RP,239:P239_ID_DCLRCION:&ID_DCLRCION.'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(207794694731316239)
,p_name=>'NMRO_CNSCTVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMRO_CNSCTVO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Numero Formulario'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:133:&SESSION.::&DEBUG.:RP,133:P133_ID_DCLRCION:&ID_DCLRCION.'
,p_link_text=>'&NMRO_CNSCTVO.'
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
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(207794889198316240)
,p_name=>'NMBRE_IMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_IMPSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Tributo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
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
 p_id=>wwv_flow_api.id(207794941498316241)
,p_name=>'NMBRE_IMPSTO_SBMPSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_IMPSTO_SBMPSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Sub-Tributo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(207795025391316242)
,p_name=>'DSCRPCION_TPO_DCRLCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION_TPO_DCRLCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(207795156344316243)
,p_name=>'VGNCIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Vigencia'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
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
 p_id=>wwv_flow_api.id(207795281361316244)
,p_name=>'DSCRPCION_PRDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION_PRDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Periodo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(207795386595316245)
,p_name=>'IDNTFCCION_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION_SJTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
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
 p_id=>wwv_flow_api.id(207795524311316247)
,p_name=>'VLOR_TTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_TTAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Saldo a Cargo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
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
 p_id=>wwv_flow_api.id(207795724771316249)
,p_name=>'NMBRE_DCLRCION_USO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_DCLRCION_USO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Uso Declaraci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>1000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(207794529140316237)
,p_internal_uid=>207794529140316237
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
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
 p_id=>wwv_flow_api.id(207862949534792509)
,p_interactive_grid_id=>wwv_flow_api.id(207794529140316237)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>5
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(207863061382792511)
,p_report_id=>wwv_flow_api.id(207862949534792509)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(16511851610936415)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(16439416567701508)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158060977668771623)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(158054880766770393)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158067934989790554)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(158054917684770394)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158086326175230123)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(158055273599770397)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158086937595230127)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(158055373244770398)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(158106429416766114)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(158055575737770400)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(174177392654032313)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(172728418605684489)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(174177830707032332)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(172728492186684490)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(174194420438118509)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(172728628894684491)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(174408236356278133)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(172728670780684492)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207863590492792528)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(207794611156316238)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207864000360792536)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(207794694731316239)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207864520270792538)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(207794889198316240)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>177
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207865020592792539)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(207794941498316241)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207865475833792541)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(207795025391316242)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207865978076792542)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(207795156344316243)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>97
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'FIRST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207866443788792544)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(207795281361316244)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>105
,p_sort_order=>2
,p_sort_direction=>'DESC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207866985844792545)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(207795386595316245)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207867961941792577)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(207795524311316247)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(207938247331913743)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(207795724771316249)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(218306167081505270)
,p_view_id=>wwv_flow_api.id(207863061382792511)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(207196161886845290)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(207789114332314805)
,p_plug_name=>unistr('<b>Par\00E1metros de  B\00FAsqueda</b>')
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164076287595707682)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8364223522699773)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(207789114332314805)
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
 p_id=>wwv_flow_api.id(8364647718699778)
,p_name=>'P242_ID_IMSPTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
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
 p_id=>wwv_flow_api.id(8365073286699795)
,p_name=>'P242_ID_SUB_IMSPTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>'<b>Sub - Impuesto</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  nmbre_impsto_sbmpsto,',
'   id_impsto_sbmpsto ',
'from df_i_impuestos_subimpuesto',
'where id_impsto = :P242_ID_IMSPTO'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P242_ID_IMSPTO'
,p_ajax_items_to_submit=>'P242_ID_IMSPTO'
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
 p_id=>wwv_flow_api.id(8365403953699796)
,p_name=>'P242_ID_DCLRCN_TPO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>unistr('<b>Tipo de Declaraci\00F3n</b>')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dscrpcion,id_dclrcn_tpo from gi_d_declaraciones_tipo',
'where cdgo_clnte = :F_CDGO_CLNTE',
'and  id_impsto  = :P242_ID_IMSPTO',
'and actvo = ''S'''))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P242_ID_IMSPTO'
,p_ajax_items_to_submit=>'P242_ID_IMSPTO'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'80%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8365833369699796)
,p_name=>'P242_ID_DCLRCION_USO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>unistr('<b>Uso de Declaraci\00F3n</b>')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  a.nmbre_dclrcion_uso,',
'        a.id_dclrcion_uso',
'from    gi_d_declaraciones_uso  a',
'where   a.cdgo_clnte    =   :F_CDGO_CLNTE',
'and     a.cdgo_dclrcion_uso not like ''DCO''',
'order by a.nmbre_dclrcion_uso'))
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'80%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8366236925699796)
,p_name=>'P242_IDNTFCCION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>unistr('<b>Identificaci\00F3n</b>')
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
 p_id=>wwv_flow_api.id(8366613499699796)
,p_name=>'P242_ID_SJTO_TPO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>'<b>Tipo de Sujeto</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.nmbre_sjto_tpo,a.id_sjto_tpo',
'from df_i_sujetos_tipo a',
'where a.id_sjto_tpo in (select distinct(id_sjto_tpo)  id_sjto_tpo from gi_d_dclrcnes_tpos_sjto b',
'where b.id_dclrcn_tpo = :P242_ID_DCLRCN_TPO)'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P242_ID_DCLRCN_TPO'
,p_ajax_items_to_submit=>'P242_ID_DCLRCN_TPO'
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
 p_id=>wwv_flow_api.id(8367098122699796)
,p_name=>'P242_FCHA_INCIAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
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
 p_id=>wwv_flow_api.id(8367488038699797)
,p_name=>'P242_FCHA_FNAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>'<b>Fecha Final</b>'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_attributes=>'onkeydown="return false" '
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_02=>'&P242_FCHA_INCIAL.'
,p_attribute_03=>'+0d'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'MONTH_AND_YEAR'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8367813375699797)
,p_name=>'P242_VGNCIA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>'<b>Vigencia</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(vgncia) dscrpcion_vgncia,vgncia from gi_d_dclrcnes_tpos_vgncias',
'where id_dclrcn_tpo = :P242_id_dclrcn_tpo or :P242_id_dclrcn_tpo is null',
'order by vgncia desc'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P242_ID_DCLRCN_TPO'
,p_ajax_items_to_submit=>'P242_ID_DCLRCN_TPO'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8368262289699797)
,p_name=>'P242_ID_PRDO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>'<b>Periodo</b>'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(a.dscrpcion),a.id_prdo from df_i_periodos a',
'where ',
'--id_impsto = :P242_ID_IMSPTO',
'--and  ',
'a.id_prdo in (',
'select distinct(id_prdo) from gi_d_dclrcnes_tpos_vgncias where id_dclrcn_tpo = :P242_id_dclrcn_tpo and vgncia = :P242_VGNCIA',
')'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P242_ID_DCLRCN_TPO,P242_ID_IMSPTO'
,p_ajax_items_to_submit=>'P242_ID_DCLRCN_TPO,P242_ID_IMSPTO'
,p_ajax_optimize_refresh=>'Y'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8368639356699798)
,p_name=>'P242_CDGO_DCLRCION_ESTDO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(207789114332314805)
,p_prompt=>unistr('<b>Estados de la Declaraci\00F3n</b>')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>'STATIC:FIRME;FRM,PRESENTADA;PRS,APLICADA;APL'
,p_lov_display_null=>'YES'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(164103203154707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
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
