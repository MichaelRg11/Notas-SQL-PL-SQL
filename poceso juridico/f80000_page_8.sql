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
--   Date and Time:   15:40 Tuesday November 30, 2021
--   Exported By:     MRODRIGUEZ
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250147824739065
--

prompt --application/pages/delete_00008
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_api.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_api.id(17431055073919422)
,p_name=>unistr('Lotes de Selecci\00F3n de Poblaci\00F3n')
,p_step_title=>unistr('Lotes de selecci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#javascript/infortributos/js/utilidades.js?v=1',
'#APP_IMAGES#xlsx.min.js',
'#APP_IMAGES#FileSaver.min.js'))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var json;',
'function validar_sel(valid) {',
'',
'    var region = apex.region("simu_sujetos");',
'    if (region) {',
'',
'        var view = region.widget().interactiveGrid("getViews", "grid");',
'        var model = view.model;',
'        var records = view.view$.grid("getSelectedRecords");',
'        ',
'        //REALIZAMOS UN FILTRO DE TODOS LOS DATOS SELECCIONADOS DEL INTERACTIVE GRID QUE NO ESTEN PROCESADOS',
'        records = records.filter(function (record) {',
'            return model.getValue(record, "INDCDOR_PRCSDO").v === ''N''',
'        });',
'              ',
'        //OBTENEMOS UN JSON CON LOS DATOS SELECCIONADOS QUE NO HAN SIDO PROCESADOS',
'        json = records.map(function (record) {',
'            return { "ID_PRCSOS_SMU_SJTO": model.getValue(record, "ID_PRCSOS_SMU_SJTO").trim(),',
'                     "ID_SJTO": model.getValue(record, "ID_SJTO").trim(),',
'                     "VLOR_TTAL_DDA": model.getValue(record, "VLOR_TTAL_DDA").trim(),',
'                     "IDNTFCCION": model.getValue(record, "IDNTFCCION").trim(), ',
'                     "ID_PRCSOS_SMU_LOTE": $v(''P8_ID_PRCSO_SMU_LOTE''),',
'                    "ID_PRCSO_TPO": $v(''P8_ID_PRCSO_TPO'')',
'                   };',
'        });',
'               ',
'        window.localStorage.setItem(''jsonCobro'', json.length > 0 ? JSON.stringify(json) : '''');',
'        ',
'        //HABILITAMOS O DESHABILITAMOS EL BOTOM DEPENDIENDO SI HAY MAS DE UN REGISTRO SELECCIONADO',
'        if (json.length === 1 ){',
'            apex.item("BTN_RSPNSBLE").show();',
'            $s(''P8_PRCSO_SMU_SJTO'',  json[0]["ID_PRCSOS_SMU_SJTO"] );//SETEAMOS EL VALOR DEL SIMU SUJETO SI SOLO HAY UNO SELECIONADO ',
'            ',
'        }else {',
'            apex.item("BTN_RSPNSBLE").hide();',
'            $s(''P8_PRCSO_SMU_SJTO'',  '''');',
'            ',
'        }',
'        ',
'        if (json.length > 1 ){',
'            $s(''P8_MASIVO'',  ''S'');',
'        }else{',
'            $s(''P8_MASIVO'',  ''N'');',
'        }       ',
'        ',
'        //SOLO SE PUEDE INICIAR EL PROCESO JURIDICO SI HAY POR LO MENOS UN REGISTRO SELECCIONADO',
'        // Y EL LOTE SEA DE PROCESO DE COBRO JURIDICO',
'        if (records.length > 0) {',
'            if ($v(''P8_ID_PRCSO_TPO'') == "2"){',
'                apex.item("BTN_INCIAR_PRCSO").show();',
'            }else{',
'                // SI EL LOTE ES DE COBRO PERSUAISIVO SE HABILITA EL BOTON DE INICIAR COBRO PERSUASIVO',
'                apex.item("BTN_INCIAR_CBRO_PRSSVO").show();          ',
'            }',
'            ',
'            apex.item("BTN_ELMNAR_SJTO").show();',
'            ',
'        }else {',
'            apex.item("BTN_INCIAR_PRCSO").hide();',
'            apex.item("BTN_ELMNAR_SJTO").hide();',
'            apex.item("BTN_INCIAR_CBRO_PRSSVO").hide();',
'        }',
'        ',
'        //SELECCIONAMOS LOS ITEM NO PROCESADOS EN EL INTERACTIVE GRID ',
'        apex.region("simu_sujetos").widget().interactiveGrid("setSelectedRecords", records);',
'        return;',
'    }',
'    apex.item("BTN_RSPNSBLE").hide();',
'    apex.item("BTN_INCIAR_PRCSO").hide();',
'    apex.item("BTN_ELMNAR_SJTO").hide();   ',
'}',
'//var datos;',
'function seleccionarTodos(e,btn,grid,data){',
'    json = data.filter((f) => f.INDCDOR_PRCSDO.v === ''N'').map((m) => {',
'            return { "ID_PRCSOS_SMU_SJTO": m.ID_PRCSOS_SMU_SJTO,',
'                     "ID_SJTO": m.ID_SJTO,',
'                     "VLOR_TTAL_DDA": m.VLOR_TTAL_DDA,',
'                     "IDNTFCCION": m.IDNTFCCION,',
'                     "ID_PRCSOS_SMU_LOTE": $v(''P8_ID_PRCSO_SMU_LOTE''),',
'                     "ID_PRCSO_TPO": $v(''P8_ID_PRCSO_TPO'')',
'                   };',
'        }); ',
'    ',
'    //console.log(JSON.stringify(datos));',
'    window.localStorage.setItem(''jsonCobro'', JSON.stringify(json));',
'    //apex.submit(''BTN_INCIAR_PRCSO'');',
'}',
'',
'$(document).on("scroll",function() {',
'  apex.navigation.dialog.close(true);',
'});',
'',
'const refrescarSujetos = () => {',
'    var region = apex.region( "simu_sujetos" );',
'    region.refresh();',
'}',
'',
'const iniciarProcesoPersuasivo = function(){',
'    ',
'    var json_sjtos = localStorage.getItem(''jsonCobro'');',
'    ',
'    if (json_sjtos.length > 0){',
'    ',
unistr('        apex.message.confirm( "\00BFDesea iniciar proceso de cobro persuasivo para los dedudores seleccionados?", async function( okPressed ) { '),
'            if( okPressed ) {',
'',
'                var popup = apex.widget.waitPopup();',
'                //debugger;',
'                await apex.server.process(',
'                                "Iniciar_Proceso_Persuasivo",',
'                                {    ',
'                                     f01: json_sjtos',
'                                },',
'                                {',
'                                    //dataType: ''text'',',
'                                    success: function( pData ){',
'',
'                                        popup.remove();',
'',
'                                        if (pData.o_cdgo_rspsta != 0){ ',
'                                            apex.message.clearErrors();',
'                                            apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                                        }else{',
'                                            apex.message.alert("Se han iniciado procesos de cobro persuasivo!", function(){',
'                                                if (okPressed){',
'                                                    apex.submit();',
'                                                }',
'                                            });',
'                                            ',
'                                            //refrescarSujetos();',
'                                        }',
'                                    }',
'                                }',
'                            );',
'                        } // Fin if',
'                    });',
'        ',
'    }else{',
'        apex.message.clearErrors();',
'        apex.message.alert(  ''No se han seleccionado candidatos a procesar.'' );',
'    }',
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
'                            Title: "Candidatos para proceso de cobro juridico",',
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
'}',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//validar_sel();',
'',
'apex.region("simu_sujetos").widget().interactiveGrid("setSelectedRecords", []);'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#BTN_ABRIR_MODAL_INICIAR_PRCSO{',
'    display: none;',
'}'))
,p_step_template=>wwv_flow_api.id(17324973689919355)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MRODRIGUEZ'
,p_last_upd_yyyymmddhh24miss=>'20211130152504'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(41208004712338009)
,p_plug_name=>'Tabular'
,p_region_name=>'tab_lotes'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(17363723095919377)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(31138131053292404)
,p_plug_name=>'Responsables'
,p_region_name=>'sujetos_responsables'
,p_parent_plug_id=>wwv_flow_api.id(41208004712338009)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_prcsos_smu_rspnsble,',
'       a.id_prcsos_smu_sjto,',
'       a.idntfccion,',
'       b.dscrpcion_idntfccion_tpo,',
'       a.nmbre_cmplto,',
'       a.prncpal_s_n       ',
'  from v_cb_g_procesos_simu_rspnsble a',
'  join df_s_identificaciones_tipo b',
'    on b.cdgo_idntfccion_tpo = a.cdgo_idntfccion_tpo;'))
,p_plug_source_type=>'NATIVE_IG'
,p_master_region_id=>wwv_flow_api.id(210416373233467351)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(31140093035292423)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
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
 p_id=>wwv_flow_api.id(31140139780292424)
,p_name=>'DSCRPCION_IDNTFCCION_TPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION_IDNTFCCION_TPO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Tipo Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
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
 p_id=>wwv_flow_api.id(31140310585292426)
,p_name=>'PRNCPAL_S_N'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRNCPAL_S_N'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(31141818659292441)
,p_name=>'Editar'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<button style="color:blue" type="button" class="a-Button a-Button--noLabel a-Button--iconTextButton">Editar',
'<span class="fa fa-pencil"></span>',
'</button>'))
,p_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:RP,9:P9_ID_PRCSOS_SMU_RSPNSBLE,P9_ID_PRCSOS_SMU_SJTO:&ID_PRCSOS_SMU_RSPNSBLE.,&ID_PRCSOS_SMU_SJTO.'
,p_static_id=>'editar_rspnsble'
,p_use_as_row_header=>true
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36919819881559906)
,p_name=>'ID_PRCSOS_SMU_RSPNSBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_SMU_RSPNSBLE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36919963127559907)
,p_name=>'ID_PRCSOS_SMU_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_SMU_SJTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_parent_column_id=>wwv_flow_api.id(36919746026559905)
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(139339366690762729)
,p_name=>'NMBRE_CMPLTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMBRE_CMPLTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Nombre'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>803
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
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(31139762415292420)
,p_internal_uid=>31139762415292420
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>false
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>false
,p_no_data_found_message=>'seleccione un registro de la cartera'
,p_show_toolbar=>false
,p_toolbar_buttons=>null
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
'function( options ) {',
'    return options;',
'}'))
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(31171511950433483)
,p_interactive_grid_id=>wwv_flow_api.id(31139762415292420)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(31171680817433483)
,p_report_id=>wwv_flow_api.id(31171511950433483)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31173139928433487)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(31140093035292423)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>97
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31173603047433488)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(31140139780292424)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>150
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31174618064433490)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(31140310585292426)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>70
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31215782507008050)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(31141818659292441)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>77
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36947290478638897)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(36919819881559906)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36947769909638898)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(36919963127559907)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(140371578899869317)
,p_view_id=>wwv_flow_api.id(31171680817433483)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(139339366690762729)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35102129387394001)
,p_plug_name=>'Cartera'
,p_parent_plug_id=>wwv_flow_api.id(41208004712338009)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_prcsos_smu_sjto,',
'       a.vgncia,',
'       c.prdo,',
'       b.dscrpcion,',
'       a.vlor_cptal,',
'       a.vlor_intres ',
'  from cb_g_procesos_smu_mvmnto a',
'  join df_i_conceptos b ',
'    on b.id_cncpto = a.id_cncpto  ',
'  join df_i_periodos c',
'    on a.id_prdo = c.id_prdo ; '))
,p_plug_source_type=>'NATIVE_IG'
,p_master_region_id=>wwv_flow_api.id(210416373233467351)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35102411975394004)
,p_name=>'VGNCIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Vigencia'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
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
 p_id=>wwv_flow_api.id(35102695634394006)
,p_name=>'DSCRPCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Concepto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
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
 p_id=>wwv_flow_api.id(35102763705394007)
,p_name=>'VLOR_CPTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_CPTAL'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Saldo Capital'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G999G999G990'
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
 p_id=>wwv_flow_api.id(35102888088394008)
,p_name=>'VLOR_INTRES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_INTRES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('Saldo Inter\00E9s')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G999G999G990'
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
 p_id=>wwv_flow_api.id(36920074493559908)
,p_name=>'ID_PRCSOS_SMU_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_SMU_SJTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_parent_column_id=>wwv_flow_api.id(36919746026559905)
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36920119366559909)
,p_name=>'PRDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRDO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Periodo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
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
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(35102246786394002)
,p_internal_uid=>35102246786394002
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
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
 p_id=>wwv_flow_api.id(35107935483415805)
,p_interactive_grid_id=>wwv_flow_api.id(35102246786394002)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(35108053963415805)
,p_report_id=>wwv_flow_api.id(35107935483415805)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35109062563415812)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(35102411975394004)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35110068892415816)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(35102695634394006)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>178
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35110522486415818)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(35102763705394007)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>95
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35111014398415820)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(35102888088394008)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>98
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36954086142655432)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(36920074493559908)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(37081752881373555)
,p_view_id=>wwv_flow_api.id(35108053963415805)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(36920119366559909)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>65
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(41208215719338011)
,p_plug_name=>'Lotes'
,p_region_name=>'lotes'
,p_parent_plug_id=>wwv_flow_api.id(41208004712338009)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(210416373233467351)
,p_plug_name=>'Sujetos'
,p_region_name=>'simu_sujetos'
,p_parent_plug_id=>wwv_flow_api.id(41208215719338011)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_prcsos_smu_sjto,',
'       pkg_gn_generalidades.fnc_cl_formato_texto(p_txto => a.idntfccion, p_frmto => ''xx-xx-xx-xx-xxxx-xxxx-x-xx-xx-xxxx'' , p_crcter_dlmtdor => ''-'' ) idntfccion,',
'       a.drccion,',
'       a.vlor_ttal_dda,',
'       a.fcha_ingrso as fcha_ingrso,',
'       a.indcdor_prcsdo,',
'       a.id_sjto,',
'       decode(a.cdgo_orgn_sjto,''EX'',''EXISTENTE'', ''INEXISTENTE(OTRAS FUENTES DE INFORMACION)'') as cdgo_orgn_sjto',
'  from v_cb_g_procesos_simu_sujeto a',
' where a.id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE',
'   and a.actvo = ''S'''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(31142699600292449)
,p_name=>'VLOR_TTAL_DDA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_TTAL_DDA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Valor Total Deuda'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'FM$999G999G999G999G999G999G990'
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
 p_id=>wwv_flow_api.id(31142717841292450)
,p_name=>'FCHA_INGRSO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FCHA_INGRSO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Fecha Registro'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(32123976842408504)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
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
 p_id=>wwv_flow_api.id(33591057929707717)
,p_name=>'DRCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DRCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(35105214417394032)
,p_name=>'INDCDOR_PRCSDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INDCDOR_PRCSDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Procesado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:Si;S,No;N'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36038606070515107)
,p_name=>'ID_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_SJTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36919746026559905)
,p_name=>'ID_PRCSOS_SMU_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_SMU_SJTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(108701099144940301)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(108701197759940302)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138908525702587106)
,p_name=>'CDGO_ORGN_SJTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CDGO_ORGN_SJTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Origen del sujeto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>41
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
 p_id=>wwv_flow_api.id(31139201900292415)
,p_internal_uid=>31139201900292415
,p_is_editable=>true
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>800
,p_show_icon_view=>false
,p_show_detail_view=>false
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(config) {',
'	config.initialSelection = false;',
'    //window.localStorage.removeItem(''jsonCobro'');',
'    return selectAll(config, {',
'        name: ''Seleccionar Todos'',',
'        action: seleccionarTodos',
'    }) ;',
'}'))
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(31164028095395542)
,p_interactive_grid_id=>wwv_flow_api.id(31139201900292415)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(31164184035395542)
,p_report_id=>wwv_flow_api.id(31164028095395542)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10425486033946)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(33591057929707717)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>292
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31407175504678502)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(31142699600292449)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>251
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(31407680628678503)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(31142717841292450)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>122
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(32135237713725981)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(32123976842408504)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>281
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(35263943181905130)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(35105214417394032)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>82
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36161661217824739)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(36038606070515107)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36944175293620255)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(36919746026559905)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(108707054828940769)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(108701099144940301)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(138942221760711338)
,p_view_id=>wwv_flow_api.id(31164184035395542)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(138908525702587106)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(210555021048270933)
,p_plug_name=>'Lotes'
,p_region_name=>'lotes'
,p_parent_plug_id=>wwv_flow_api.id(41208215719338011)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>'<div id="downloadLink"></div>'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(210554774328270931)
,p_plug_name=>'Opciones'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--hiddenOverflow'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>20
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
 p_id=>wwv_flow_api.id(219064558330785416)
,p_plug_name=>'Ayuda'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<br>',
'<h5>',
'    <b>',
'        <i>',
'            <center>Ayuda <i class="fa fa-question-circle" aria-hidden="true"></i></center>',
'        </i>',
'    </b>',
'</h5>',
'<i>',
unistr('<b><i>1.</i></b>Esta funcionalidad permite la gesti\00F3n de lotes de los procesos jur\00EDdicos.<br><br>'),
'',
unistr('<b><i>2.</i></b>Permite crear un nuevo lote de selecci\00F3n donde se podr\00E1 incluir los candidatos/sujetos con cartera apta para realizar proceso de cobro.<br><br>'),
'',
unistr('<b><i>3.</i></b>Al escoger un sujeto o registro del lote se cargara la cartera y los responsables en la pesta\00F1a "Responsables & Cartera"<br><br>'),
'',
unistr('<b><i>4.</i></b>En la pesta\00F1a de "Responsables & Cartera" es posible actualizar la informaci\00F3n de los responsables del candidato/sujeto o de incluir un nuevo responsable en caso de ser necesario.<br><br>'),
'',
unistr('<b><i>5.</i></b>Para iniciar el proceso de cobro se deben seleccionar los candidatos/sujetos asociados a un lote y que adem\00E1s no hayan sido procesados con anterioridad. si el candidato/sujeto ya fue procesado este no podr\00E1 ser seleccionado para su ma')
||unistr('nipulaci\00F3n y/o nuevo inicio de cobro.<br><br>'),
unistr('  Si desea conocer m\00E1s informaci\00F3n referente a la funcionalidad dir\00EDjase al Manual de Usuario.'),
'        </i>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30821493525832262)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_NUEVO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Nuevo Lote'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_BRANCH,P5_ID_PRCSO_TPO:&APP_PAGE_ID.,&P8_ID_PRCSO_TPO.'
,p_icon_css_classes=>'fa-folder-plus'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(49269875096384349)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_SQL'
,p_button_static_id=>'BTN_SQL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Selecci\00F3n Masiva<br>por Regla')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.:RP,17:P17_ID_PRCSOS_SMU_LTE,P17_ID_PRCSO_TPO:&P8_ID_PRCSO_SMU_LOTE.,&P8_ID_PRCSO_TPO.'
,p_icon_css_classes=>'fa-file-sql'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36038370146515104)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_AGRGAR_SJTO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Agregar Candidato(s)'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_BRANCH,P5_ID_PRCSO_SMU_LOTE,P5_ID_PRCSO_TPO:&APP_PAGE_ID.,&P8_ID_PRCSO_SMU_LOTE.,&P8_ID_PRCSO_TPO.'
,p_button_condition=>'P8_ID_PRCSO_SMU_LOTE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-user'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(31141049040292433)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_RSPNSBLE'
,p_button_static_id=>'BTN_RSPNSBLE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Nuevo Responsable'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-users'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(142943747147884606)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_CARGAR_ARCHIVO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Agregar candidatos <br>mediante cargue<br> de archivos'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:132:&SESSION.::&DEBUG.:RP,132:P132_ID_PRCSO_SMU_LOTE,P132_ID_CRGA:&P8_ID_PRCSO_SMU_LOTE.,&P8_ID_CRGA.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P8_ID_CRGA is not null and :P8_ID_PRCSO_TPO = 2 then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-file-excel-o'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(35105589570394035)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_INCIAR_PRCSO'
,p_button_static_id=>'BTN_INCIAR_PRCSO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Iniciar <br/>Proceso Jur\00EDdico')
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P8_ID_PRCSO_TPO'
,p_button_condition2=>'2'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-play'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(22605403774594219)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_INCIAR_CBRO_PRSSVO'
,p_button_static_id=>'BTN_INCIAR_CBRO_PRSSVO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Iniciar <br/>Proceso Persuasivo'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P8_ID_PRCSO_TPO'
,p_button_condition2=>'1'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-play'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50867741396674902)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_ELMNAR_LTE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Eliminar Lote'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id_prcsos_smu_lte',
'  from cb_g_procesos_simu_sujeto s',
' where s.id_prcsos_smu_lte = nvl(:P8_ID_PRCSO_SMU_LOTE,  s.id_prcsos_smu_lte)',
'   and s.indcdor_prcsdo = ''S'';'))
,p_button_condition_type=>'NOT_EXISTS'
,p_icon_css_classes=>'fa-trash-o'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51073433411308402)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_ELMNAR_SJTO'
,p_button_static_id=>'BTN_ELMNAR_SJTO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Eliminar Sujetos'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-trash-o'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(84982062613475109)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_IR_PRCSO_JRDCO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Gesti\00F3n de <br/>Procesos Juridicos')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10::'
,p_button_condition=>'P8_ID_PRCSO_TPO'
,p_button_condition2=>'2'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-external-link-square'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(88663036423226004)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_RSLTDOS_PRCSMNTO'
,p_button_static_id=>'resultados'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Resultados de <br>Procesamiento'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:45:&SESSION.::&DEBUG.:RP,45:P45_ID_PRCSO_JRDCO_LTE_IP:&P8_ID_PRCSO_JRDCO_LTE_IP.'
,p_button_condition=>'P8_ID_PRCSO_JRDCO_LTE_IP'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-window-search'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(142943815128884607)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(210554774328270931)
,p_button_name=>'BTN_DSCRGAR_ARCHVO_LTE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Descargar informaci\00F3n<br> del lote')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.:imprimir:&DEBUG.:::'
,p_icon_css_classes=>'fa-download'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30822904957832264)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(210555021048270933)
,p_button_name=>'BTN_CONSULTA'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consultar'
,p_button_position=>'BODY'
,p_icon_css_classes=>'fa-window-search'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(82861510190223449)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(210555021048270933)
,p_button_name=>'BTN_ACTLZAR_OBSVCION'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Actualizar Observaci\00F3n')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.:RP:P30_ID_PRCSOS_SMU_LTE:&P8_ID_PRCSO_SMU_LOTE.'
,p_icon_css_classes=>'fa-clipboard-edit'
,p_grid_column_attributes=>'style="left:10px;"'
,p_grid_new_grid=>false
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(35104847863394028)
,p_branch_name=>'Go To Page 9'
,p_branch_action=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:RP,9:P9_ID_PRCSOS_SMU_SJTO:&P8_PRCSO_SMU_SJTO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(31141049040292433)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(44108405916046714)
,p_branch_name=>'Go To Page 15'
,p_branch_action=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP,15:P15_ID_PRCSO_SMU_LOTE,P15_MSVO,P15_ID_PRCSO_TPO:&P8_ID_PRCSO_SMU_LOTE.,&P8_MASIVO.,&P8_ID_PRCSO_TPO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(35105589570394035)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(138908457477587105)
,p_branch_name=>'Go To Page 127'
,p_branch_action=>'f?p=&APP_ID.:127:&SESSION.::&DEBUG.:RP,127:P127_ID_PRCSO_SMU_LOTE,P127_MSVO,P127_ID_PRCSO_TPO:&P8_ID_PRCSO_SMU_LOTE.,&P8_MASIVO.,&P8_ID_PRCSO_TPO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>30
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'BTN_INCIAR_CBRO_PRSSVO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13140688210228602)
,p_name=>'P8_TIPO_PROCESAMIENTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_item_default=>'SEL'
,p_prompt=>'Tipo Procesamiento'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Procesar todos;ALL,Procesar puntuales;SEL'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(17408658834919398)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22604506270594210)
,p_name=>'P8_ID_PRCSO_TPO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22605165488594216)
,p_name=>'P8_DSCRPCION_PRCSO_TPO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30823372519832264)
,p_name=>'P8_ID_PRCSO_SMU_LOTE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_prompt=>unistr('Lote de Selecci\00F3n')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''*Lote: ''||a.id_prcsos_smu_lte||'' *Fecha: ''||to_char(a.fcha_lte,''dd/mm/yyyy'')||'' *Funcionario: ''||b.nmbre_trcro  as dscrpcion_Lte, ',
'        id_prcsos_smu_lte',
'   from cb_g_procesos_simu_lote a, v_sg_g_usuarios b',
'   where a.id_fncnrio = b.id_fncnrio',
'   and a.cdgo_clnte = :F_CDGO_CLNTE ',
'   and a.id_prcso_tpo = :P8_ID_PRCSO_TPO',
'   and b.id_usrio = :F_ID_USRIO',
'order by id_prcsos_smu_lte'))
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(17408492887919397)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Es el lote de selecci\00F3n realizado por un funcionario. Al consultarlo mostrara la informaci\00F3n de los candidatos, contenida en el lote para poder procesarla y generar el proceso jur\00EDdico.')
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'700'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31141559653292438)
,p_name=>'P8_JSON'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31141686192292439)
,p_name=>'P8_PRCSO_SMU_SJTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(77852345902940505)
,p_name=>'P8_MASIVO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82861346381223447)
,p_name=>'P8_OBSRVCION_LTE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_prompt=>unistr('Observaci\00F3n de Lote')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>200
,p_cHeight=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(17408492887919397)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Muestra la observaci\00F3n del lote que fue ingresada cuando se genero un lote nuevo de selecci\00F3n de candidatos.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(88662945296226003)
,p_name=>'P8_ID_PRCSO_JRDCO_LTE_IP'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(146797193359898524)
,p_name=>'P8_ID_CRGA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_id_crga    number;',
'begin',
'    ',
'    begin',
'        select id_crga into v_id_crga',
'          from gn_d_codigos_proceso',
'         where cdgo_prcso = ''GCB'';',
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
 p_id=>wwv_flow_api.id(149567269365205703)
,p_name=>'P8_ID_IMPSTO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149567376053205704)
,p_name=>'P8_VGNCIA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149567469279205705)
,p_name=>'P8_ID_IMPSTO_SBMPSTO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149567577780205706)
,p_name=>'P8_ID_PRDO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(210555021048270933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(82861436096223448)
,p_computation_sequence=>10
,p_computation_item=>'P8_OBSRVCION_LTE'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select obsrvcion',
'from cb_g_procesos_simu_lote',
'where id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(22605316349594218)
,p_computation_sequence=>20
,p_computation_item=>'P8_DSCRPCION_PRCSO_TPO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select b.dscrpcion',
'from cb_g_procesos_simu_lote a',
'join cb_d_procesos_tipo b on b.id_prcso_tpo = a.id_prcso_tpo',
'where a.id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(149567611772205707)
,p_computation_sequence=>30
,p_computation_item=>'P8_ID_IMPSTO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_impsto',
'from cb_g_procesos_smu_mvmnto a',
'where exists (select 1 from cb_g_procesos_simu_sujeto b',
'where a.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto',
'and b.id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE)',
'group by id_impsto'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(149567761700205708)
,p_computation_sequence=>40
,p_computation_item=>'P8_ID_IMPSTO_SBMPSTO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id_impsto_sbmpsto',
'from cb_g_procesos_smu_mvmnto a',
'where exists (select 1 from cb_g_procesos_simu_sujeto b',
'where a.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto',
'and b.id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE)',
'group by id_impsto_sbmpsto;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30826895689832275)
,p_name=>unistr('Guardar en sesi\00F3n el valor del sub-impuesto selccionado')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P14_SUB_IMPUESTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30827336890832276)
,p_event_id=>wwv_flow_api.id(30826895689832275)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    APEX_UTIL.SET_SESSION_STATE(''P14_ID_IMPSTO_SBMPSTO'',:P14_ID_IMPSTO_SBMPSTO);',
'END;'))
,p_attribute_02=>'P14_ID_IMPSTO_SBMPSTO'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31141168032292434)
,p_name=>'al seleccionar un registro de lotes'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(210416373233467351)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31141256199292435)
,p_event_id=>wwv_flow_api.id(31141168032292434)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//console.log(this);',
'validar_sel();'))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51073332656308401)
,p_event_id=>wwv_flow_api.id(31141168032292434)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var texto = this.data.selectedRecords.length === 1 ? '' - <b>ID: '' + this.data.model.getValue(this.data.selectedRecords[0], "IDNTFCCION") + ''</b>'' : '''';',
'$setDetailTab(''#SR_lotes_tab'', texto);',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(35104201958394022)
,p_name=>'al cargar la pagina'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35104362775394023)
,p_event_id=>wwv_flow_api.id(35104201958394022)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(document).ready(function() {  ',
'    var region = apex.region("lotes_simu");',
'    if (region) {',
'        apex.region("lotes_simu").widget().interactiveGrid("setSelectedRecords", []);',
'    }',
'    validar_sel();      ',
'});',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(38411237401757510)
,p_name=>'close dialog'
,p_event_sequence=>50
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'body'
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'dialogclose'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(38411356262757511)
,p_event_id=>wwv_flow_api.id(38411237401757510)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//console.log(this, sujeto);',
'var actElment = this.affectedElements[0].activeElement;',
'',
'var idActive = $(actElment).attr(''id'') || $(actElment).data(''action'');',
'var region = (idActive === ''BTN_INCIAR_PRCSO'' || idActive === ''all_process'') ? apex.region("simu_sujetos") ',
'                                                                             : (idActive === ''BTN_RSPNSBLE'' ? apex.region("sujetos_responsables") : undefined);',
'',
'var sujeto = $v(''P8_PRCSO_SMU_SJTO'');',
'',
'if (region == undefined && sujeto !== null && idActive !== ''resultados''){',
'    region = apex.region("sujetos_responsables");',
'}',
'',
'if (region) ',
'    region.refresh(); ',
' '))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50663303175664301)
,p_name=>'al cerrar la ventana de reglas'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(49269875096384349)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50663483228664302)
,p_event_id=>wwv_flow_api.id(50663303175664301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var url = ''f?p='' +  $v(''pFlowId'') + '':'' + $v(''pFlowStepId'') + '':'' + $v(''pInstance'');',
'window.location.href = url;'))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(84981867573475107)
,p_name=>'Al cerrar ventana de Observacion de lote'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(82861510190223449)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(84981931834475108)
,p_event_id=>wwv_flow_api.id(84981867573475107)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(116933944918382746)
,p_name=>'Al darle click al boton eliminar sujeto'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51073433411308402)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(116934064668382747)
,p_event_id=>wwv_flow_api.id(116933944918382746)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var json = window.localStorage.jsonCobro;',
'let $waitPopup;',
'try {',
'    JSON.parse(json);',
unistr('    apex.message.confirm(''\00BFEst\00E1 seguro de Borrar el/los sujeto(s)?'', (ok) => {'),
'        if (ok) {',
'            if (apex.page.validate()) {',
'                $waitPopup = apex.widget.waitPopup();',
'                apex.server.process("EliminarSujetosCobro", {',
'                    f01: json,',
'                    pageItems: "#P8_ID_PRCSO_SMU_LOTE"',
'                }).then((resp) => {',
'                    $waitPopup.remove();',
'                    if (resp.type === ''OK'') {',
'                        apex.message.showPageSuccess(resp.msg);',
'                        window.location.href = resp.url;',
'                    }',
'                });',
'            }',
'        }',
'    })',
'',
'} catch (e) {',
'    apex.message.clearErrors();',
'    apex.message.showErrors([',
'        {',
'            type: "error",',
'            location: ["page"],',
'            message: "No se encontraron datos seleccionados",',
'            unsafe: false',
'        }]);',
'} finally {',
'    if ($waitPopup)',
'        $waitPopup.remove();',
'}'))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(22605694082594221)
,p_name=>'Al dar click en BTN_INCIAR_CBRO_PRSSVO'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(22605403774594219)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(22605741534594222)
,p_event_id=>wwv_flow_api.id(22605694082594221)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'iniciarProcesoPersuasivo();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13161581291099708)
,p_name=>'Al cambiar item P8_TIPO_PROCESAMIENTO'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P8_TIPO_PROCESAMIENTO'
,p_condition_element=>'P8_TIPO_PROCESAMIENTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ALL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13161631396099709)
,p_event_id=>wwv_flow_api.id(13161581291099708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''button[data-action="selectAll"]'').click();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13161751470099710)
,p_event_id=>wwv_flow_api.id(13161581291099708)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region("simu_sujetos").widget().interactiveGrid("setSelectedRecords", []);'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142944561467884614)
,p_name=>'Al dar Click en BTN_DSCRGAR_ARCHVO_LTE'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(142943815128884607)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142944681453884615)
,p_event_id=>wwv_flow_api.id(142944561467884614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'fnConsultarSujetosExcel($v(''P8_ID_PRCSO_SMU_LOTE''));'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(149686791627069211)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_dscrga_excel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'  v_num_fla       number := 5;     -- Numero de filas del excel',
'  v_num_impstos   number := 5;',
'  v_num_col       number := 0;     -- Inicio de columnas',
'  v_bfile         bfile;           -- Apuntador del documento en disco',
'  o_file_blob     blob;            -- Archivo blob de salida',
'  v_directorio    clob;            -- Directorio donde caera el archivo',
'  v_file_name     varchar2(3000);  -- Nombre del rachivo',
'  v_file_blob     blob;            ',
'  v_nmbre_clnte   varchar2(1000); ',
'  v_slgan         varchar2(1000); ',
'  v_nit           varchar2(1000);  ',
'  v_nmbre_dcmnto  varchar2(100);',
'begin',
'  -- Datos del cliente',
'  select  upper(nmbre_clnte)',
'        , nmro_idntfccion',
'        , upper(slgan)          ',
'  into  v_nmbre_clnte ',
'      , v_nit',
'      , v_slgan',
'  from df_s_clientes',
'  where cdgo_clnte = :F_CDGO_CLNTE;',
'  ',
'  o_file_blob  :=  empty_blob(); -- Inicializacion del blob ',
'  v_directorio := ''COPIAS'';      -- Nombre del directorio donde caera el archivo',
'  v_file_name  := ''Temp_.xlsx'';  -- Nombre del archivo',
'  --se crea un hoja       ',
'  as_xlsx.new_sheet(''Candidatos'');',
'  ',
'  --combinamos celdas  ',
'  as_xlsx.mergecells( 1, 1, 12, 1 );  --Cliente',
'  as_xlsx.mergecells( 1, 2, 12, 2 );  --Slogan',
'  as_xlsx.mergecells( 1, 3, 12, 3 );  --Nit',
'  ',
'  --estilos de encabezado          ',
'  as_xlsx.cell( 1, 1 , v_nmbre_clnte, p_alignment => as_xlsx.get_alignment( p_horizontal => ''center'' )',
'                                   , p_fontId => as_xlsx.get_font( ''Calibri'', p_bold => true, p_fontsize => 12));      ',
'                                   ',
'  as_xlsx.cell( 1, 2 , v_slgan, p_alignment => as_xlsx.get_alignment( p_horizontal => ''center'' )',
'                                   , p_fontId => as_xlsx.get_font( ''Calibri'', p_bold => true, p_fontsize => 12));',
'                                   ',
'  as_xlsx.cell( 1, 3 , ''Nit. '' || v_nit, p_alignment => as_xlsx.get_alignment( p_horizontal => ''center'' )',
'                                   , p_fontId => as_xlsx.get_font( ''Calibri'', p_bold => true, p_fontsize => 12));',
'                                   ',
'  -- Aliniar fila 6 del excel y creamos filtro',
'  as_xlsx.set_row(p_row  => 5',
'                , p_alignment => as_xlsx.get_alignment( p_horizontal => ''center'', p_vertical => ''center'')',
'                , p_fontId    => as_xlsx.get_font( ''Calibri'', p_bold => true, p_fontsize => 11));  ',
'  ',
'  --as_xlsx.set_autofilter(4, 4, p_row_start => 5, p_row_end => 1000 ); --Filtro',
'  ',
'  --Nombre de las columnas',
'  as_xlsx.cell( 1, v_num_fla , ''CLIENTE*'');',
'  as_xlsx.cell( 2, v_num_fla , ''FECHA LOTE'');',
'  as_xlsx.cell( 3, v_num_fla , ''ID SUJETO'');',
unistr('  as_xlsx.cell( 4, v_num_fla , ''IDENTIFICACI\00D3N*'');'),
'  as_xlsx.cell( 5, v_num_fla , ''FUNCIONARIO*'');',
'  as_xlsx.cell( 6, v_num_fla , ''VALOR CARTERA'');',
'  as_xlsx.cell( 7, v_num_fla , ''VIGENCIA DESDE*'');',
'  as_xlsx.cell( 8, v_num_fla , ''VIGENCIA HASTA*'');',
'  as_xlsx.cell( 9, v_num_fla , ''IMPUESTO*'');',
'  as_xlsx.cell( 10, v_num_fla , ''SUB. IMPUESTO*'');',
'  as_xlsx.cell( 11, v_num_fla , ''RESPONSABLES'');',
'  as_xlsx.cell( 12, v_num_fla , ''CODIGO TIPO PROCESO'');',
'  as_xlsx.cell( 13, v_num_fla , ''ID LOTE*'');',
'  as_xlsx.cell( 14, v_num_fla , ''ID SUJETO LOTE'');',
'',
'  -- Consulta de impuestos',
'  as_xlsx.cell( 16, v_num_fla , ''ID IMPUEST0'');',
'  as_xlsx.cell( 17, v_num_fla , ''COD. IMPUESTO'');',
'  as_xlsx.cell( 18, v_num_fla , ''NOMBRE IMPUESTO'');',
'  as_xlsx.cell( 19, v_num_fla , ''ID SUB. IMPUESTO'');',
'  as_xlsx.cell( 20, v_num_fla , ''COD. SUB. IMPUESTO'');',
'  as_xlsx.cell( 21, v_num_fla , ''NOMBRE SUB. IMPUESTO'');',
'  ',
'  for c_impsto in (select a.id_impsto, a.cdgo_impsto, a.nmbre_impsto ',
'                     from df_c_impuestos a',
'                     where cdgo_clnte = :F_CDGO_CLNTE) loop ',
'                    ',
'    v_num_impstos :=  v_num_impstos + 1;  ',
'    as_xlsx.cell( 16, v_num_impstos , c_impsto.id_impsto);',
'    as_xlsx.cell( 17, v_num_impstos , c_impsto.cdgo_impsto);',
'    as_xlsx.cell( 18, v_num_impstos , c_impsto.nmbre_impsto);',
'    ',
'    ',
'    for c_subimpsto in (select a.id_impsto_sbmpsto, a.cdgo_impsto_sbmpsto, a.nmbre_impsto_sbmpsto',
'                          from df_i_impuestos_subimpuesto a',
'                          where id_impsto = c_impsto.id_impsto) loop',
'    ',
'      v_num_impstos :=  v_num_impstos + 1;  ',
'      as_xlsx.cell( 19, v_num_impstos , c_subimpsto.id_impsto_sbmpsto);',
'      as_xlsx.cell( 20, v_num_impstos , c_subimpsto.cdgo_impsto_sbmpsto);',
'      as_xlsx.cell( 21, v_num_impstos , c_subimpsto.nmbre_impsto_sbmpsto);',
'    ',
'    end loop;',
'    ',
'  end loop;',
'',
'  -- Consulta ',
'  for c_candidatos in (select a.cdgo_clnte, ',
'                           to_char(a.fcha_lte) as fecha_lte,',
'                           b.id_sjto,',
'                           to_char(d.idntfccion) as idntfccion,',
'                           a.id_prcso_tpo,',
'                           b.indcdor_prcsdo,',
'                           a.id_fncnrio,',
'                           b.vlor_ttal_dda,',
'                           (select min(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_desde,',
'                           (select max(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_hasta,',
'                           f.id_impsto,',
'                           f.id_impsto_sbmpsto,    ',
'                           LISTAGG(c.prmer_nmbre||'' ''||c.sgndo_nmbre||'' ''||c.prmer_aplldo||'' ''||c.sgndo_aplldo, '', '') WITHIN GROUP (ORDER BY c.prmer_nmbre||'' ''||c.sgndo_nmbre||'' ''||c.prmer_aplldo||'' ''||c.sgndo_aplldo) nmbre_rspnsbles,',
'                           a.id_prcsos_smu_lte,',
'                           b.id_prcsos_smu_sjto',
'                     from cb_g_procesos_simu_lote        a',
'                     join cb_g_procesos_simu_sujeto      b   on  a.id_prcsos_smu_lte = b.id_prcsos_smu_lte',
'                     join cb_g_procesos_simu_rspnsble    c   on  b.id_prcsos_smu_sjto = c.id_prcsos_smu_sjto',
'                     join si_c_sujetos                   d   on  d.id_sjto = b.id_sjto',
'                     join cb_g_procesos_smu_mvmnto       f   on b.id_prcsos_smu_sjto = f.id_prcsos_smu_sjto',
'                    where a.id_prcsos_smu_lte = :P8_ID_PRCSO_SMU_LOTE',
'                    and b.indcdor_prcsdo = ''N''',
'                    and b.actvo = ''S''',
'                    group by a.cdgo_clnte, ',
'                           a.fcha_lte,',
'                           a.id_fncnrio,',
'                           a.id_prcso_tpo,',
'                           a.id_prcsos_smu_lte,',
'                           b.id_prcsos_smu_sjto,',
'                           b.id_sjto,',
'                           d.idntfccion,',
'                           b.indcdor_prcsdo,',
'                           b.vlor_ttal_dda,',
'                           f.id_impsto,',
'                           f.id_impsto_sbmpsto) loop',
'',
'      -- aqui se debe hacer la consulta y ir llenado las filas',
'      v_num_fla :=  v_num_fla + 1;  ',
'      as_xlsx.cell( 1, v_num_fla , c_candidatos.cdgo_clnte);    ',
'      as_xlsx.cell( 2, v_num_fla , c_candidatos.fecha_lte);  ',
'      as_xlsx.cell( 3, v_num_fla , c_candidatos.id_sjto);    ',
'      as_xlsx.cell( 4, v_num_fla , c_candidatos.idntfccion);',
'      as_xlsx.cell( 5, v_num_fla , c_candidatos.id_fncnrio);',
'      as_xlsx.cell( 6, v_num_fla , c_candidatos.vlor_ttal_dda);      ',
'      as_xlsx.cell( 7, v_num_fla , c_candidatos.vigencia_desde);    ',
'      as_xlsx.cell( 8, v_num_fla , c_candidatos.vigencia_hasta);    ',
'      as_xlsx.cell( 9, v_num_fla , c_candidatos.id_impsto);',
'      as_xlsx.cell( 10, v_num_fla , c_candidatos.id_impsto_sbmpsto);',
'      as_xlsx.cell( 11, v_num_fla , c_candidatos.nmbre_rspnsbles);',
'      as_xlsx.cell( 12, v_num_fla , c_candidatos.id_prcso_tpo);',
'      as_xlsx.cell( 13, v_num_fla , c_candidatos.id_prcsos_smu_lte);',
'      as_xlsx.cell( 14, v_num_fla , c_candidatos.id_prcsos_smu_sjto);',
'',
'    end loop;',
'  ',
'  -- Guardar Excel',
'  as_xlsx.save( v_directorio, v_file_name );',
'  ',
'  v_bfile := bfilename( v_directorio, v_file_name);',
'',
'  --------------------------------------------------------------------',
'  ',
'  dbms_lob.open(v_bfile, dbms_lob.lob_readonly);',
'  dbms_lob.createtemporary(',
'      lob_loc => o_file_blob, ',
'      cache   => true, ',
'      dur     => dbms_lob.session',
'  );',
'  -- Open temporary lob',
'  dbms_lob.open(o_file_blob, dbms_lob.lob_readwrite);',
'',
'  -- Load binary file into temporary LOB',
'  dbms_lob.loadfromfile(',
'      dest_lob => o_file_blob,',
'      src_lob  => v_bfile,',
'      amount   => dbms_lob.getlength(v_bfile)',
'  );',
'',
'  -- Close lob objects',
'  dbms_lob.close(o_file_blob);',
'  dbms_lob.close(v_bfile);',
'',
'  utl_file.fremove(v_directorio,v_file_name);',
'  htp.init;',
'  owa_util.mime_header(''application/ms-excel'', false);',
'  ',
'  v_nmbre_dcmnto := ''Lote_'' || :P8_ID_PRCSO_SMU_LOTE || ''_'' || to_char(sysdate,''yyyymmddhhmiss'');',
'  ',
'  htp.p(''Content-length: '' ||sys.dbms_lob.getlength(o_file_blob) );  ',
'  htp.p(''Content-Disposition: attachment; filename="''|| v_nmbre_dcmnto ||''.xlsx"'');  ',
'  htp.p(''Cache-Control: max-age=0'');',
'  owa_util.http_header_close;  ',
'  wpg_docload.download_file(o_file_blob);  ',
'  apex_application.stop_apex_engine;',
'  ',
'  exception',
'    when others then',
'      raise_application_error(-20000,''Problemas al generar excel, ''||sqlerrm);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'imprimir'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50867609345674901)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'eliminar lotes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    pkg_cb_proceso_juridico.prc_el_procesos_simu_lte (P_ID_PRCSOS_SMU_LTE => :P8_ID_PRCSO_SMU_LOTE);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(50867741396674902)
,p_process_success_message=>'Lote eliminado de forma exitosa.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50868065635674905)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'eliminar datos de session'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(50867741396674902)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51073546797308403)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Eliminar Sujetos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    pkg_cb_proceso_juridico.prc_el_procesos_simu_sjto( p_id_prcsos_smu_lte => :P8_ID_PRCSO_SMU_LOTE ,',
'                                                       p_json_sujetos      => :P8_JSON );',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(51073433411308402)
,p_process_when_type=>'NEVER'
,p_process_success_message=>'Sujetos Eliminados de Forma Exitosa!!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(108701243416940303)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(210416373233467351)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Sujetos - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
,p_exec_cond_for_each_row=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(116934100879382748)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'EliminarSujetosCobro'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    v_json                     clob;',
'    v_url                      varchar2(4000);',
'    v_id_prcso_jrdco_lte_ip    number;',
'    ',
'begin',
'     for i in 1..apex_application.g_f01.count ',
'     loop',
'         v_json :=  v_json || apex_application.g_f01(i);',
'     end loop;',
'     ',
'    pkg_cb_proceso_juridico.prc_el_procesos_simu_sjto( p_id_prcsos_smu_lte => v(''P8_ID_PRCSO_SMU_LOTE''),',
'                                                       p_json_sujetos      => v_json );',
'    ',
'    v_url := apex_util.prepare_url( p_url => ''f?p='' || v(''APP_ID'') || '':8:''|| v(''APP_SESSION'')||''::NO::P8_ID_PRCSO_SMU_LOTE:''',
'                                   || v(''P8_ID_PRCSO_SMU_LOTE'')',
'                                  , p_checksum_type => ''SESSION'');',
'    ',
'    htp.p(''{"type":"OK","url":"''||v_url||''","msg":"''||case when v_id_prcso_jrdco_lte_ip is null ',
'                                 then ''Sujeto(s) Eliminado(s) Correctamente!!''',
'                                 else ''Algunos registros no fueron procesados'' ',
'                            end||''"}'');',
'   /* apex_json.open_object;',
'    apex_json.write(''type'', ''OK'');',
'    apex_json.write(''url'', v_url);    ',
'    apex_json.write(''msg'',  case when v_id_prcso_jrdco_lte_ip is null ',
'                                 then ''Medida(s) cautelar(es) Iniciada(s) Correctamente!!''',
'                                 else ''Algunos registros no fueron procesados'' ',
'                            end );',
'    apex_json.close_object;*/',
'exception',
'    when others then',
'    ',
'        htp.p(''{"type":"ERROR","msg":"''||sqlerrm||''"}'');',
'        ',
'        /*apex_json.open_object;',
'        apex_json.write(''type'', ''ERROR'');',
'        apex_json.write(''msg'',  sqlerrm);',
'        apex_json.close_object;*/',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(139053749057675124)
,p_process_sequence=>60
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Iniciar_Proceso_Persuasivo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'        v_json_sjtos   clob;',
'        o_cdgo_rspsta  number;',
'        o_mnsje_rspsta varchar2(1000);',
'        v_msvo         varchar2(1);',
'begin',
'    ',
'    ',
'    for i IN 1..APEX_APPLICATION.G_F01.count loop ',
'        v_json_sjtos := v_json_sjtos||APEX_APPLICATION.G_F01(i);',
'    end loop;',
'    ',
'    ',
'    v_msvo := ''N'';',
'    ',
'    if APEX_APPLICATION.G_F01.count > 1 then',
'            v_msvo := ''S'';',
'    end if;',
'    ',
'    -- Iniciar proceso de cobro persuasivo',
'    pkg_cb_proceso_persuasivo.prc_rg_proceso_persuasivo( p_cdgo_clnte            => :F_CDGO_CLNTE,',
'                                                         p_id_usuario            => :F_ID_USRIO,',
'                                                         p_json_sjtos            => v_json_sjtos,',
'                                                         p_msvo                  => v_msvo,',
'                                                         o_cdgo_rspsta           => o_cdgo_rspsta,',
'                                                         o_mnsje_rspsta          => o_mnsje_rspsta);',
'    ',
'    ',
'    apex_json.open_object();',
'    apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'    apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'    apex_json.close_object();',
'',
'exception',
'    when others then',
'            apex_json.open_object();',
'            apex_json.write(''o_cdgo_rspsta'', 99);',
'            apex_json.write(''o_mnsje_rspsta'', ''Error: ''||sqlerrm);',
'            apex_json.close_object();',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'&P15_MNSJE.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(142944481567884613)
,p_process_sequence=>70
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Obtener_informacion_Excel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_json_cnddto json_object_t := new json_object_t();',
'    v_json_array json_array_t := new json_array_t();',
'    v_lte         number := APEX_APPLICATION.g_x01;',
'begin',
'    for c_cnddtos_lte in (select a.cdgo_clnte, ',
'                                 a.fcha_lte,',
'                                 b.id_sjto,',
'                                 to_char(d.idntfccion) as idntfccion,',
'                                 a.id_prcso_tpo,',
'                                 b.indcdor_prcsdo,',
'                                 a.id_fncnrio,',
'                                 b.vlor_ttal_dda,',
'                                 (select min(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_desde,',
'                                 (select max(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_hasta,',
'                                 LISTAGG(c.prmer_nmbre||'' ''||c.sgndo_nmbre||'' ''||c.prmer_aplldo||'' ''||c.sgndo_aplldo, '', '') WITHIN GROUP (ORDER BY c.prmer_nmbre||'' ''||c.sgndo_nmbre||'' ''||c.prmer_aplldo||'' ''||c.sgndo_aplldo) nmbre_rspnsbles,',
'                                 a.id_prcsos_smu_lte,',
'                                 b.id_prcsos_smu_sjto',
'                           from cb_g_procesos_simu_lote        a',
'                           join cb_g_procesos_simu_sujeto      b   on  a.id_prcsos_smu_lte = b.id_prcsos_smu_lte',
'                           join cb_g_procesos_simu_rspnsble    c   on  b.id_prcsos_smu_sjto = c.id_prcsos_smu_sjto',
'                           join si_c_sujetos                   d   on  d.id_sjto = b.id_sjto',
'                          where a.id_prcsos_smu_lte = v_lte',
'                          and b.indcdor_prcsdo = ''N''',
'                          and b.actvo = ''S''',
'                          group by a.cdgo_clnte, ',
'                                 a.fcha_lte,',
'                                 a.id_fncnrio,',
'                                 a.id_prcso_tpo,',
'                                 a.id_prcsos_smu_lte,',
'                                 b.id_prcsos_smu_sjto,',
'                                 b.id_sjto,',
'                                 d.idntfccion,',
'                                 b.indcdor_prcsdo,',
'                                 b.vlor_ttal_dda)',
'     loop',
'         ',
'         ',
'         v_json_cnddto.put(''CLIENTE'', c_cnddtos_lte.cdgo_clnte);',
'         v_json_cnddto.put(''FECHA_LOTE'', c_cnddtos_lte.fcha_lte);',
'         v_json_cnddto.put(''ID_SUJETO'', c_cnddtos_lte.id_sjto);',
'         v_json_cnddto.put(''IDENTIFICACION'',c_cnddtos_lte.idntfccion);',
'         v_json_cnddto.put(''FUNCIONARIO'', c_cnddtos_lte.id_fncnrio);',
'         v_json_cnddto.put(''VALOR_CARTERA'', c_cnddtos_lte.vlor_ttal_dda);',
'         v_json_cnddto.put(''VIGENCIA DESDE'', c_cnddtos_lte.vigencia_desde);',
'         v_json_cnddto.put(''VIGENCIA HASTA'', c_cnddtos_lte.vigencia_hasta);',
'         v_json_cnddto.put(''RESPONSABLES'', c_cnddtos_lte.nmbre_rspnsbles);',
'         v_json_cnddto.put(''CODIGO_TIPO_PROCESO'', c_cnddtos_lte.id_prcso_tpo);',
'         v_json_cnddto.put(''ID_LOTE'', c_cnddtos_lte.id_prcsos_smu_lte);',
'         v_json_cnddto.put(''ID_SUJETO_LOTE'', c_cnddtos_lte.id_prcsos_smu_sjto);',
'         --v_json_cnddto.put(''PROCESADO'', decode(c_cnddtos_lte.indcdor_prcsdo,''S'',''SI'',''NO''));',
'         ',
'         /*select ',
'             json_object(',
'                     ''cdgo_clnte'' value c_cnddtos_lte.cdgo_clnte,',
'                     ''fcha_lte'' value c_cnddtos_lte.fcha_lte,',
'                     ''id_fncnrio'' value c_cnddtos_lte.id_fncnrio,',
'                     ''id_prcso_tpo'' value c_cnddtos_lte.id_prcso_tpo,',
'                     ''id_prcsos_smu_lte'' value c_cnddtos_lte.id_prcsos_smu_lte,',
'                     ''id_prcsos_smu_sjto'' value c_cnddtos_lte.id_prcsos_smu_sjto,',
'                     ''id_sjto'' value c_cnddtos_lte.id_sjto,',
'                     ''indcdor_prcsdo'' value c_cnddtos_lte.indcdor_prcsdo,',
'                     ''vlor_ttal_dda'' value c_cnddtos_lte.vlor_ttal_dda,',
'                     ''nmbre_rspnsbles'' value c_cnddtos_lte.nmbre_rspnsbles',
'                 )',
'         into v_json_cnddto',
'         from dual;*/',
'         ',
'         v_json_array.append(v_json_cnddto);',
'         ',
'     end loop;',
'     ',
'    -- insert into muerto (v_001, c_001) values(''val_json_des_exc'', v_json_array.to_clob()); commit;',
'     ',
'     apex_json.open_object();',
'     apex_json.write(''o_json_cnddto'',v_json_array.to_clob());',
'     apex_json.write(''o_file_name'', ''Lote_''||v_lte||''_''||to_char(sysdate,''yyyymmddhhmiss'')||''.xls'');',
'     apex_json.close_object();',
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
