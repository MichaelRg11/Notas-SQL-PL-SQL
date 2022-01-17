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

prompt --application/pages/delete_00255
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>255);
end;
/
prompt --application/pages/page_00255
begin
wwv_flow_api.create_page(
 p_id=>255
,p_user_interface_id=>wwv_flow_api.id(164114460002707812)
,p_name=>unistr('Gesti\00F3n de Selecci\00F3n de Poblaci\00F3n')
,p_step_title=>unistr('Gesti\00F3n de Selecci\00F3n de Poblaci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#javascript/infortributos/js/utilidades.js?v=1',
'#APP_IMAGES#xlsx.min.js',
'#APP_IMAGES#FileSaver.min.js'))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function seleccionarTodos(e,btn,grid,data){',
'',
'    var jsonCandidatos = data.map((candidato) => {',
'        return {',
'            "ID_CNDDTO" : candidato.ID_CNDDTO',
'        };',
'    });',
'    ',
'    $s(''P8_JSON'', JSON.stringify(jsonCandidatos));',
'    window.localStorage.setItem(''jsonCandidatos'', JSON.stringify(jsonCandidatos));',
'     ',
'    ocultarBotonAsignacion();',
'}',
'',
'function buildJsonCandidatos(){',
'',
'    var region = apex.region(''candidatos'');',
'    ',
'    if(region){',
'        ',
'        var view = apex.region("candidatos").widget().interactiveGrid("getViews", "grid");',
'        var model = view.model;',
'        var records = view.view$.grid("getSelectedRecords");',
'        ',
'        var jsonCandidatos = records.map((candidato) => {',
'            return {"ID_CNDDTO" : model.getValue(candidato, "ID_CNDDTO")}; ',
'        });',
'        ',
'        $s(''P8_JSON'', JSON.stringify(jsonCandidatos));',
'        window.localStorage.setItem(''jsonCandidatos'', JSON.stringify(jsonCandidatos));',
'        ',
'        ocultarBotonAsignacion();',
'        ',
'      ',
'    }',
'}',
'',
'function ocultarBotonAsignacion(){',
'    if(JSON.parse(window.localStorage.jsonCandidatos).length > 0 && $("#P8_ID_FNCNRIO :selected").length > 0){',
'        apex.item(''asignar'').show();',
'    }else{',
'        apex.item(''asignar'').hide();',
'    }',
'    ',
'    if($("#P8_ID_FNCNRIO :selected").length > 1){',
'        $("#P8_DSTRBUIR_CONTAINER").show();',
'    }else{',
'        $("#P8_DSTRBUIR_CONTAINER").hide();',
'    }',
'    ',
'}',
'',
'const fnConsultarSujetosExcel = function(p_id_lote){',
'    ',
'    var popup = apex.widget.waitPopup();',
'    ',
'    apex.server.process(',
'            "Obtener_informacion_Excel",',
'            {    ',
'                 x01: p_id_lote',
'            },',
'            {',
'                //dataType: ''text'',',
'                success: function( pData ){',
'',
'                    popup.remove();',
'                    ',
'                    var wb = XLSX.utils.book_new();',
'                        ',
'                    wb.Props = {',
unistr('                            Title: "Candidatos para proceso de Fiscalizaci\00F3n",'),
'                            Subject: "",',
'                            Author: "Equipo GENESYS",',
'                            CreatedDate: new Date(2017,12,19)',
'                    };',
'                    ',
'                    //Parseamos los candidatos que se devuelven del lote',
'                    var v_candidatos = JSON.parse(pData.o_json_cnddto);',
'                        ',
'                    wb.SheetNames.push("Candidatos");',
'                    //var ws_data = [[''hello'' , ''world'']];',
'                    //var ws = XLSX.utils.aoa_to_sheet(ws_data);',
'                    var ws = XLSX.utils.json_to_sheet(v_candidatos);',
'',
'',
'                    wb.Sheets["Candidatos"] = ws;',
'',
'                    /*',
'                        const content = XLSX.write(book, { type: ''buffer'', bookType: ''xlsx'', bookSST: false });',
'                                    fs.writeFileSync("/path/to/folder/test-write.xlsx", content);',
'                    */',
'',
'                    var wbout = XLSX.write(wb, { type: ''binary'', bookType: ''xls'', bookSST: false });',
'',
'',
'                    function s2ab(s) {',
'',
'                            var buf = new ArrayBuffer(s.length);',
'                            var view = new Uint8Array(buf);',
'                            for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;',
'                            return buf;',
'',
'                    }',
'                        ',
'                        ',
'                    ',
'                    // Descarga el archivo',
'                    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), pData.o_file_name);',
'                    ',
'                    ',
'                  ',
'                }',
'            }',
'        );',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''asignar'').hide();',
'$("#P8_DSTRBUIR_CONTAINER").hide();',
'window.localStorage.setItem(''jsonCandidatos'', [{}]);'))
,p_step_template=>wwv_flow_api.id(164066127703707633)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20220103152906'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(189884918272286781)
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
'        <center>Ayuda <i class="fa fa-question-circle" aria-hidden="true"></i></center>',
'    </b>',
'</h5>',
'',
'<p align="justify">',
unistr('<i>Funcionalidad que permite crear lotes para ser procesados y obtener la poblaci\00F3n que va hacer fiscalizada de acuerdo a los parametros de busqueda de la consulta y distribuir la poblaci\00F3n entre los funcionarios de Fiscalizaci\00F3n</i>'),
'</p>',
'',
'',
'<p align="justify">',
unistr('<i>Si desea conocer m\00E1s informaci\00F3n referente a la funcionalidad dir\00EDjase al Manual de Usuario.</i>'),
'</p>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(189884962956286782)
,p_plug_name=>'Opciones'
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
 p_id=>wwv_flow_api.id(191948612705225370)
,p_plug_name=>unistr('Fiscalizaci\00F3n Selecci\00F3n de Lote')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(164080910676707690)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199352726630173070)
,p_plug_name=>'Tab'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(164084128065707698)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199353023019173072)
,p_plug_name=>'Candidatos'
,p_region_name=>'candidatos'
,p_parent_plug_id=>wwv_flow_api.id(199352726630173070)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(164080387335707690)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from gi_g_intermedia_dian',
'where id_prcso_crga = :P255_ID_PRCSO_CRGA;',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(152228668791363201)
,p_name=>'ID_INTRMDIA_DIAN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_INTRMDIA_DIAN'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
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
 p_id=>wwv_flow_api.id(152228764198363202)
,p_name=>'VGNCIA_GRVBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA_GRVBLE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Vigencia'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>30
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152228890962363203)
,p_name=>'PRDO_GRVBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRDO_GRVBLE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Periodo'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152228967279363204)
,p_name=>'TPO_IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TPO_IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Tipo identificaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_api.id(152229075062363205)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>20
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
 p_id=>wwv_flow_api.id(152229194229363206)
,p_name=>'RZON_SCIAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RZON_SCIAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Raz\00F3n social')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>500
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
 p_id=>wwv_flow_api.id(152229225679363207)
,p_name=>'DRCCION_SCCNAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DRCCION_SCCNAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Direcci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>500
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
 p_id=>wwv_flow_api.id(152229362208363208)
,p_name=>'CNSCTVO_DCLRCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CNSCTVO_DCLRCION'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cnsctvo Dclrcion'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152229412970363209)
,p_name=>'FCHA_RCDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FCHA_RCDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Fecha radicado'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>20
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
 p_id=>wwv_flow_api.id(152229579845363210)
,p_name=>'PGO_TTAL_ICAC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PGO_TTAL_ICAC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Pago total ICAC'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152229686149363211)
,p_name=>'INTRSES_ICAC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INTRSES_ICAC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Intereses ICAC'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>120
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152229797725363212)
,p_name=>'SNCNES_ICAC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SNCNES_ICAC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Sanciones ICAC'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>130
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152229863827363213)
,p_name=>'TTAL_INGRSOS_BRTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TTAL_INGRSOS_BRTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Ttal Ingrsos Brto'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>140
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152229962539363214)
,p_name=>'DVLCNES_RBJAS_DSC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DVLCNES_RBJAS_DSC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Dvlcnes Rbjas Dsc'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>150
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230054613363215)
,p_name=>'MNOS_INGRSOS_X_EXP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MNOS_INGRSOS_X_EXP'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Mnos Ingrsos X Exp'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>160
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230120530363216)
,p_name=>'MNOS_INGRSOS_X_VNTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MNOS_INGRSOS_X_VNTA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Mnos Ingrsos X Vnta'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>170
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230200875363217)
,p_name=>'INGRSOS_EXNTOS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INGRSOS_EXNTOS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Ingrsos Exntos'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>180
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230300958363218)
,p_name=>'TTAL_INGRSOS_GRVBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TTAL_INGRSOS_GRVBLE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Ttal Ingrsos Grvble'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>190
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230408884363219)
,p_name=>'TTAL_IMPSTO_ICA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TTAL_IMPSTO_ICA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Ttal Impsto Ica'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>200
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230568799363220)
,p_name=>'RTNCNES_O_AUTORTNCNES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RTNCNES_O_AUTORTNCNES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Rtncnes O Autortncnes'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>210
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230694183363221)
,p_name=>'SLDO_PGAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SLDO_PGAR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Sldo Pgar'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>220
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_api.id(152230732310363222)
,p_name=>'ID_DCLRCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_DCLRCION'
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
 p_id=>wwv_flow_api.id(152230853481363223)
,p_name=>'INDCDOR_PRCSDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INDCDOR_PRCSDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Indcdor Prcsdo'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>240
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>1
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
 p_id=>wwv_flow_api.id(152230955925363224)
,p_name=>'ID_PRCSO_CRGA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSO_CRGA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>250
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
 p_id=>wwv_flow_api.id(152231037502363225)
,p_name=>'ID_PRCSO_INTRMDIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSO_INTRMDIA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>260
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
 p_id=>wwv_flow_api.id(152231155640363226)
,p_name=>'NMERO_LNEA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMERO_LNEA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>270
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
 p_id=>wwv_flow_api.id(199875425927783271)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(199353037754173073)
,p_internal_uid=>199353037754173073
,p_is_editable=>true
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
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
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(config) {',
'    ',
'    window.localStorage.removeItem(''jsonCandidatos'');',
'    ',
'    config.initialSelection = false;',
'    ',
'    return selectAll(config, {',
'        name: ''Seleccionar Todos'',',
'        action: seleccionarTodos',
'    }) ;',
'}'))
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(199369624112232343)
,p_interactive_grid_id=>wwv_flow_api.id(199353037754173073)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(199369738477232344)
,p_report_id=>wwv_flow_api.id(199369624112232343)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152234672412370190)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(152228668791363201)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152235069802370203)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(152228764198363202)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152235509363370207)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(152228890962363203)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152236053121370209)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(152228967279363204)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152236591714370210)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(152229075062363205)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152237052754370212)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(152229194229363206)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152237500100370214)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(152229225679363207)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152238010002370215)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(152229362208363208)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152238524384370217)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(152229412970363209)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152239004580370225)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(152229579845363210)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152239513036370227)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(152229686149363211)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152240085161370229)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(152229797725363212)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152240532573370232)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(152229863827363213)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152241070205370236)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(152229962539363214)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152241597729370238)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(152230054613363215)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152242028239370240)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(152230120530363216)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152242554514370242)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>26
,p_column_id=>wwv_flow_api.id(152230200875363217)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152243095214370244)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(152230300958363218)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152243504599370246)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>28
,p_column_id=>wwv_flow_api.id(152230408884363219)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152244083389370249)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(152230568799363220)
,p_is_visible=>true
,p_is_frozen=>false
);
end;
/
begin
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152244523225370251)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>30
,p_column_id=>wwv_flow_api.id(152230694183363221)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152245095285370253)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>31
,p_column_id=>wwv_flow_api.id(152230732310363222)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152245556030370255)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>32
,p_column_id=>wwv_flow_api.id(152230853481363223)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152246035801370257)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>33
,p_column_id=>wwv_flow_api.id(152230955925363224)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152246581386370259)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>34
,p_column_id=>wwv_flow_api.id(152231037502363225)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(152247003575370261)
,p_view_id=>wwv_flow_api.id(199369738477232344)
,p_display_seq=>35
,p_column_id=>wwv_flow_api.id(152231155640363226)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151957311996087574)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(189884962956286782)
,p_button_name=>'BTN_NVO_LTE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Nuevo Lote'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:257:&SESSION.::&DEBUG.:RP,9::'
,p_icon_css_classes=>'fa-folder-plus'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151955750580087572)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(189884962956286782)
,p_button_name=>'BTN_CARGAR_ARCHIVO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Agregar candidatos <br>mediante cargue<br> de archivos'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:259:&SESSION.::&DEBUG.:RP,259:P259_ID_CRGA,P259_ID_PRCSO_LOTE:&P255_ID_CRGA.,&P255_ID_DECLARACION_LTE.'
,p_button_condition=>'P255_ID_CRGA'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-excel-o'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151956157587087573)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(189884962956286782)
,p_button_name=>'BTN_PRCSAR_LTE'
,p_button_static_id=>'procesar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Procesar Lote'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_ID_CNDDTO_LTE,P10_APP_ID,P10_APP_PAGE_ID:&P255_ID_FSCLZCION_LTE.,&APP_ID.,&APP_PAGE_ID.'
,p_button_condition=>':P255_ID_FSCLZCION_LTE is not null and :P255_ID_FSCLZCION_LTE_PRCSDO is null'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-cog fa-spin'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151956939590087573)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(189884962956286782)
,p_button_name=>'BTN_ANLR_LTE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>'Eliminar Lote'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P255_ID_DECLARACION_LTE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-trash-o'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(151955311175087571)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(189884962956286782)
,p_button_name=>'BTN_DSCRGAR_ARCHVO_LTE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(164103809474707765)
,p_button_image_alt=>unistr('Descargar informaci\00F3n<br> del lote')
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-download'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151958087950087575)
,p_name=>'P255_ID_DECLARACION_LTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(191948612705225370)
,p_prompt=>'Lote'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper( ''Lote: ''|| a.id_dclrcion_lote || '' Fecha: '' ||  a.fcha_rgstro  || '' - '' || a.nmbre_lote ) as d,',
'       a.id_dclrcion_lote as r',
'from gi_g_declaraciones_lote a;'))
,p_lov_display_null=>'YES'
,p_field_template=>wwv_flow_api.id(164103298426707753)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151958407308087575)
,p_name=>'P255_OBSRVCION'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(191948612705225370)
,p_prompt=>unistr('Observaci\00F3n')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P255_ID_DECLARACION_LTE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(164103298426707753)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(151960035514087577)
,p_name=>'P255_ID_CRGA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(191948612705225370)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_id_crga    number;',
'begin',
'    ',
'    begin',
'        select id_crga into v_id_crga',
'          from gn_d_codigos_proceso',
'         where cdgo_prcso = ''DCL'';',
'    exception',
'        when others then',
'            v_id_crga := null;',
'    end;',
'    ',
'    return v_id_crga;',
'    ',
'end;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152231247356363227)
,p_name=>'P255_ID_PRCSO_CRGA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(191948612705225370)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_prcso_crga from gi_g_declaraciones_lote a',
'where a.id_dclrcion_lote = :P255_ID_DECLARACION_LTE'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when=>'P255_ID_DECLARACION_LTE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(151976813085087617)
,p_name=>'Al cambiar'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P255_ID_DECLARACION_LTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(151977314794087618)
,p_event_id=>wwv_flow_api.id(151976813085087617)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(151973168002087606)
,p_name=>'Al seleccionar Funcionario'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P255_ID_FNCNRIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(151973608417087606)
,p_event_id=>wwv_flow_api.id(151973168002087606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'ocultarBotonAsignacion();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(151974007981087607)
,p_name=>'Sin seleccionar'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P255_ID_DECLARACION_LTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_BE.CTB.SELECT2|ITEM TYPE|slctunselect'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(151974560361087607)
,p_event_id=>wwv_flow_api.id(151974007981087607)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(151956157587087573)
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(151970573886087604)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida Procesamiento del lote'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('  --Se obtiene la obsevaci\00F3n del lote'),
'  begin',
'       select a.DSCRPCION_LOTE, ID_PRCSO_CRGA',
'       into :P255_OBSRVCION, :P255_ID_PRCSO_CRGA',
'       from gi_g_declaraciones_lote a',
'       where a.cdgo_clnte = :F_CDGO_CLNTE ',
'       and a.ID_DCLRCION_LOTE = :P255_ID_DECLARACION_LTE;',
'  exception',
'      when no_data_found then',
'          :P255_ID_FSCLZCION_LTE_PRCSDO := null;',
'  end;'))
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
