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
--   Date and Time:   16:26 Tuesday November 30, 2021
--   Exported By:     RVILLALOBOS1
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         19.1.0.00.15
--   Instance ID:     250147824739065
--

prompt --application/pages/delete_00010
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(17431055073919422)
,p_name=>unistr('Gesti\00F3n de  Procesos Jur\00EDdicos')
,p_step_title=>unistr('Etapas Proceso Jur\00EDdico')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#IMAGE_PREFIX#javascript/infortributos/js/utilidades.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'mostrarAyudaD();',
'',
'$(document).on("scroll",function() {',
'  apex.navigation.dialog.close(true);',
'});',
'',
'var v_json;',
'',
'function validar_sel() {',
'',
'    var region = apex.region("etapas_proceso");',
'    if (region) {',
'',
'        var view = apex.region("etapas_proceso").widget().interactiveGrid("getViews", "grid");',
'        var model = view.model;',
'        var records = view.view$.grid("getSelectedRecords");',
'        ',
'        var json_proceso = records.map(function (record) {',
'            return { "ID_PJ": model.getValue(record, "ID_PRCSOS_JRDCO").trim()',
'                   };',
'        });',
'        ',
'        if (json_proceso.length === 1 ){',
'             $s(''P10_ID_PRCSOS_JRDCO'',  json_proceso[0]["ID_PJ"] ); ',
'             apex.item("BTN_ASOCIAR_MEDIDA_CAUTELAR").show();',
'        }else{',
'            $s(''P10_ID_PRCSOS_JRDCO'',  '''' );',
'            apex.item("BTN_ASOCIAR_MEDIDA_CAUTELAR").hide();',
'        };',
'        ',
'        //OBTENEMOS UN JSON CON LOS DATOS SELECCIONADOS QUE NO HAN SIDO PROCESADOS',
'        var json = records.map(function (record) {',
'            return { "ID_PRCSOS_JRDCO_DCMNTO": model.getValue(record, "ID_PRCSOS_JRDCO_DCMNTO").trim(),',
'                      "ID_PLNTLLA"           : model.getValue(record, "ID_PLNTLLA").trim()};',
'        }).filter(function (f) {',
'            return f.ID_PLNTLLA !== ''''',
'        }); ',
'        ',
'        //SETEAMOS EL VALOR DEL JSON EN FORMA DE CADENA AL ITEM',
'       var xml = records.map(function (record) {',
'            return { ',
'                "ID_PRCSOS_JRDCO_DCMNTO": model.getValue(record, "ID_PRCSOS_JRDCO_DCMNTO").trim(), ',
'                "ID_PRCSOS_JRDCO"       : model.getValue(record, "ID_PRCSOS_JRDCO").trim(),',
'                "NMBRE_RPRTE"          : model.getValue(record, "ID_ACTO_TPO").trim() + model.getValue(record, "NMRO_ACTO_DSPLAY").trim(), ',
unistr('                "FNCION"               : model.getValue(record, "ID_ACTO").trim() ? ''pkg_cb_proceso_juridico.prc_ac_acto(p_file_blob => \00A1file_blob ! p_id_acto => '' + model.getValue(record, "ID_ACTO").trim()+ '')'' '),
'                                                                                                : undefined,',
'                "ID_INSTNCIA_FLJO"           :    model.getValue(record, "ID_INSTNCIA_FLJO").trim(),',
'                "ID_PRCSOS_JRDCO"            :    model.getValue(record, "ID_PRCSOS_JRDCO").trim(),',
'                "ID_PRCSOS_JRDCO_DCMNTO"     :    model.getValue(record, "ID_PRCSOS_JRDCO_DCMNTO").trim(),',
'                "ID_ETPA"                    :    model.getValue(record, "ID_ETPA").trim(),',
'                "ID_ACTO_TPO"                :    model.getValue(record, "ID_ACTO_TPO").trim()',
'                   };',
'        });',
'        ',
'        ',
'          ',
'        //$s(''P10_MSVO'', xml.length === 1 ? '''' : ''masivoZip'')',
'        $s(''P10_JSON'', json.length > 0 ? JSON.stringify(json) : '''');',
'        window.localStorage.setItem(''P10_JSON'', xml.length > 0 ? JSON.stringify(xml) : '''');',
'        //fnRegistrarActosGenerar(JSON.stringify(xml));',
'        //$s(''P10_XML'', objectToXml(xml));',
'        ',
'        v_json = JSON.stringify(xml);',
'          ',
'        //HABILITAMOS O DESHABILITAMOS EL BOTOM DEPENDIENDO SI HAY MAS DE UN REGISTRO SELECCIONADO',
'        (json.length !== records.length ||  records.length === 0 ) ? apex.item("BTN_APLICAR").hide() ',
'                                       : apex.item("BTN_APLICAR").show();',
'        ',
'       var masivo = records.filter(function (record) {',
'            var valor = model.getValue(record, "NOMBRE_ETPA");',
'             var vldar_estdo = model.getValue(record, "VLDAR_ESTDO");',
'            return (records.filter((r) => { return valor !== model.getValue(r, "NOMBRE_ETPA")}).length > 0) || vldar_estdo === ''N'';',
'        });',
'        ',
'       // if (masivo.length === 0 && records.length !== 0) {',
'            var jsonMasivo = records.map(function (record) {',
'                                return { "ID_PRCSOS_JRDCO_DCMNTO": model.getValue(record, "ID_PRCSOS_JRDCO_DCMNTO").trim(),',
'                                         "ID_PRCSOS_JRDCO"       : model.getValue(record, "ID_PRCSOS_JRDCO").trim(),',
'                                         "ID_INSTNCIA_FLJO"      : model.getValue(record, "ID_INSTNCIA_FLJO").trim(),',
'                                         "ID_ETPA"               : model.getValue(record, "ID_ETPA").trim(),',
'                                         "ID_ACTO_TPO"           : model.getValue(record, "ID_ACTO_TPO").trim(),',
'                                         "ID_PLNTLLA"            : model.getValue(record, "ID_PLNTLLA").trim()};',
'                                         ',
'                             }).filter(function (f) {                                    ',
'                                    return f.ID_PLNTLLA ==  ''''',
'                                });',
'        ',
'        console.log(''Maivo'', jsonMasivo, jsonMasivo.length);',
'        ',
'        if (jsonMasivo.length > 1){',
'            $s(''P10_JSONMASIVO'', JSON.stringify(jsonMasivo));',
'            $s(''P10_ID_ACTO_TPO'', jsonMasivo[0][''ID_ACTO_TPO''] );',
'            apex.item("BTN_APLCAR_MSVO").show();',
'        }else{',
'            $s(''P10_JSONMASIVO'', '''');',
'            $s(''P10_ID_ACTO_TPO'','''');',
'            apex.item("BTN_APLCAR_MSVO").hide();',
'        }',
'        ',
'        var imprimir = records.filter((f) => {',
'                       return model.getValue(f, "ID_ACTO") && model.getValue(f, "ID_PLNTLLA")',
'                       });',
'        imprimir.length > 0 && imprimir.length === records.length ? apex.item("BTN_IMPRMIR").show() ',
'                                                                  : apex.item("BTN_IMPRMIR").hide();',
'        return;',
'    }',
'    apex.item("BTN_APLICAR").hide();',
'    apex.item("BTN_APLCAR_MSVO").hide();',
'    apex.item("BTN_IMPRMIR").hide();',
'    apex.item("BTN_ASOCIAR_MEDIDA_CAUTELAR").hide();',
'}',
'',
'var fnRegistrarActosGenerar = function(p_actos){',
'    //var v_json = window.localStorage.getItem(''P10_JSON'');',
'    ',
'    if (p_actos.length > 0) {',
'        apex.server.process(',
'                "RegitrarActosGenerar",',
'                {    ',
'                    f01: p_actos',
'                },',
'                {',
'                    //dataType: ''text'',',
'                    success: function( pData ){',
'                        console.log(''Respuesta al crear la caja. '', pData.o_cdgo_rspsta);',
'                        if (pData.o_cdgo_rspsta != 0){ ',
'                            apex.message.clearErrors();',
'                            apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                        }else{',
'                            apex.message.showPageSuccess("Se agregaron "+pData.o_ttal_actos_slccndos+" actos a la lista.");',
'                        }',
'                    }',
'                }',
'        );',
'    }',
'}',
'',
'',
'function objectToXml(xmls) {',
'    var xml = '''';  ',
'    xmls.forEach( function(obj){        ',
'        xml += ''<data>'';        ',
'        for (let prop in obj) {',
'            let p = prop.toLowerCase();',
'            if (!obj.hasOwnProperty(prop)) {',
'                continue;',
'            }',
'            if (obj[prop] == undefined){',
'                continue;   ',
'            }',
'            xml += "<" + p + ">";',
'            if (typeof obj[prop] == "object"){',
'                xml += objectToXml(new Object(obj[prop]));',
'            } else {',
'                xml += obj[prop];',
'            }',
'            xml += "</" + p + ">";',
'        }',
'        xml += ''</data>'';        ',
'    });',
'    ',
'    return xml;',
'}',
'',
'const fnImprimirActos = () => {',
'    ',
'    let v_json_actos = window.localStorage.getItem(''P10_JSON'');',
'    ',
'    //v_json_actos = JSON.parse(v_json_actos);',
'    ',
'    apex.server.process(',
'        "ImprimirActosMasivos",',
'        {    f01: v_json_actos',
'        },',
'        {',
'            //dataType: ''text'',',
'            success: function( pData ){',
'                if (pData.o_cdgo_rspsta != 0){ ',
'                    apex.message.clearErrors();',
'                    apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                }else{',
'                    //console.log(pData.o_url);',
'                    window.open(pData.o_url, ''_blank'');',
'                }',
'            }',
'        }',
'    );',
'    ',
'}',
'',
'/*function obtenerActos(){',
'    var region = apex.region("etapas_proceso");',
'    var actos  = [];',
'    if (region) {',
'        var view = region.widget().interactiveGrid("getViews", "grid");',
'        var model = view.model;  ',
'        var records = view.view$.grid("getSelectedRecords");',
'        if($.isEmptyObject(records) == false){',
'            for(let i=0; i<records.length; i++){',
'                actos.push({"ID_ACTO":model.getValue(records[i], "ID_ACTO").trim()});',
'                //console.log(model.getValue(records[i], "ID_ACTO").trim());',
'            }',
'           v_json = JSON.stringify(actos);',
'           //$s("P12_JSON_ACTOS",JSON.stringify(actos));',
'            //console.log(JSON.stringify(responsables));',
'        }',
'        else{',
'           v_json = null;',
'           $s("P12_JSON_ACTOS",null);   ',
'        }',
'    }//alert(responsables.length); ',
'}*/',
'',
'function seleccionarTodos(e,btn,grid,datos){',
'',
'',
'    v_json = JSON.stringify(datos.map((m) => {',
'        return {',
'            "ID_PRCSOS_JRDCO_DCMNTO": m["ID_PRCSOS_JRDCO_DCMNTO"], ',
'            "ID_PRCSOS_JRDCO"       : m["ID_PRCSOS_JRDCO"],',
'            "NMBRE_RPRTE"           : m["ID_ACTO_TPO"]+m["NMRO_ACTO_DSPLAY"], ',
unistr('            "FNCION"                : m["ID_ACTO"] ? ''pkg_cb_proceso_juridico.prc_ac_acto(p_file_blob => \00A1file_blob ! p_id_acto => '' + m["ID_ACTO"]+ '')'' '),
'                                                                                            : undefined,',
'            "ID_INSTNCIA_FLJO"           :    m["ID_INSTNCIA_FLJO"],',
'            "ID_PRCSOS_JRDCO"            :    m["ID_PRCSOS_JRDCO"],',
'            "ID_PRCSOS_JRDCO_DCMNTO"     :    m["ID_PRCSOS_JRDCO_DCMNTO"],',
'            "ID_ETPA"                    :    m["ID_ETPA"],',
'            "ID_ACTO_TPO"                :    m["ID_ACTO_TPO"]',
'        } ',
'    })); ',
'    ',
'    window.localStorage.setItem(''P10_JSON'', v_json);',
'    ',
'    //fnRegistrarActosGenerar(v_json);',
'    ',
'    //console.log(JSON.parse(v_json).length);',
'     ',
'}',
'',
'const fnCambiarEstadoEtapa = function(){',
'    ',
'    let v_json_actos = window.localStorage.getItem(''P10_JSON'');',
'    let n_elementos = JSON.parse(v_json_actos).length;',
'    ',
unistr('    apex.message.confirm( "\00BFDesea aplicar cambio de estado/etapa para los "+n_elementos+" registros seleccionados?", function( okPressed ) { '),
'        if( okPressed ) {',
'                ',
'                var popup = apex.widget.waitPopup();',
'            ',
'                apex.server.process(',
'                    "Cambiar_Estado_Etapa",',
'                    {    f01: v_json_actos,',
'                         pageItems: ''#P10_ID_PRCSO_JRDCO_LTE''',
'                    },',
'                    {',
'                        //dataType: ''text'',',
'                        success: function( pData ){',
'                            ',
'                            popup.remove();',
'                            ',
'                            if (pData.o_cdgo_rspsta != 0){ ',
'                                apex.message.clearErrors();',
'                                apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                            }else{',
'                                //console.log(pData.JSON);',
'                                //window.open(pData.o_url, ''_blank'');',
'                                apex.submit();',
'                            }',
'                        }',
'                    }',
'                );',
'        }',
'    });',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//validar_sel();',
'//apex.region("etapas_proceso").widget().interactiveGrid("getViews", "grid").view$.grid("selectAll");',
'apex.region("etapas_proceso").widget().interactiveGrid("setSelectedRecords", []);',
'//window.localStorage.setItem(''P10_JSON'', [{}]);'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#etapas_proceso_ig_report_settings, #BTN_ABRIR_MDAL_GNRAR_MSVO{',
'  display: none !important;',
'}'))
,p_step_template=>wwv_flow_api.id(17324973689919355)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17445683081942948)
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20211119102113'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36039146682515112)
,p_plug_name=>unistr('Par\00E1metros de B\00FAsqueda')
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17345839561919369)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36770834366538608)
,p_plug_name=>'Opciones'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<br/>',
'<h5>',
'    <b>',
'        <center>Opciones ',
'            <i class="fa fa-gears" aria-hidden="true"></i>',
'        </center>',
'    </b>',
'</h5>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36770905462538609)
,p_plug_name=>'Ayuda'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<br/>',
'<h5>',
'    <center>',
'        <b>',
'            <i>Ayuda <i class="fa fa-question-circle" aria-hidden="true"></i>',
'        </b>',
'    </center>',
'</h5>',
'<p>',
unistr('<b><i></i></b>Esta funcionalidad permite gestionar todas las etapas de un proceso jur\00EDdico, en cada uno de sus respectivos pasos, contando con las siguientes opciones:<br><br>'),
'',
unistr('<b><i>1.</i></b>Gestionar individualmente un proceso jur\00EDdico para llevarlo por cada una de las etapas del proceso.<br><br>'),
'',
unistr('<b><i>2.</i></b>Generar din\00E1micamente un acto de acuerdo a la etapa en la que se encuentra el proceso, llev\00E1ndolo por etapas de control parametrizadas previamente por ejemplo: proyecci\00F3n, revisi\00F3n y firma del documento.<br><br>'),
'',
unistr('<b><i>3.</i></b>Ver en un flujo los momentos por los que ha pasado un proceso jur\00EDdico, los documentos que ha generado y los usuarios que han intervenido en cada momento del proceso.<br><br>'),
unistr('Si desea conocer m\00E1s informaci\00F3n referente a la funcionalidad dir\00EDjase al Manual de Usuario.'),
'</p>',
'',
'',
'       '))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(82191811138286223)
,p_plug_name=>'tab'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(17363723095919377)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35983282437789150)
,p_plug_name=>unistr('Etapas Proceso Jur\00EDdico')
,p_region_name=>'etapas_proceso'
,p_parent_plug_id=>wwv_flow_api.id(82191811138286223)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.nmro_prcso_jrdco,',
'       a.id_instncia_fljo,',
'       a.id_prcsos_jrdco,',
'       a.id_prcsos_jrdco_dcmnto,',
'       pkg_gn_generalidades.fnc_cl_formato_texto(p_txto => a.idntfccion, p_frmto => ''xx-xx-xx-xx-xxxx-xxxx-x-xx-xx-xxxx'' , p_crcter_dlmtdor => ''-'' ) idntfccion,',
'       a.drccion,',
'       a.id_etpa,',
'       a.vlor_ttal_dda,',
'       to_char(a.fcha,''dd/mm/yyyy'') as fcha,',
'       a.nombre_etpa, ',
'       a.estdo_etpa_vsble,',
'       a.id_fncnrio_firma,',
'       a.id_acto_tpo,',
'       a.id_acto,',
'       a.nmro_acto_dsplay,',
'       a.id_plntlla,',
'       case when a.vldar_estdo != ''S'' ',
'                then apex_util.prepare_url (p_url => ''f?p=''|| :app_id ',
'                                                           || '':12:''',
'                                                           || :app_session ',
'                                                           || ''::NO:12:P12_PRCSOS_JRDCO_DCMNTO,P12_ID_FLJO_TREA,P12_ID_ESTDO_ETPA:'' ',
'                                                           || a.id_prcsos_jrdco_dcmnto || '','' || a.id_etpa || '','' ||  a.id_fljo_trea_estdo , p_checksum_type => ''SESSION'') ',
'           end url,',
'           case when a.vldar_estdo != ''S'' and a.estdo_etpa_vsble is not null',
'                then ''<button style="color:blue" type="button" onclick="&URL." class="a-Button a-Button--noLabel a-Button--iconTextButton" tabindex="0" >Revertir',
'                        <span class="fa fa-undo"></span>',
'                      </button>''',
'           end as html,',
'       a.vldar_estdo,',
'       a.actvo,',
'       a.indcdor_procsar_estdo',
'  from v_cb_g_procesos_jrdco_dcmnto a',
' where a.actvo = ''S''',
'   and a.id_etpa = :p10_fljo_trea',
'   and (trunc(a.fcha) >= trunc(to_date(:p10_fcha_incio,''DD/MM/YYYY'')) or :p10_fcha_incio is null)',
'   and (trunc(a.fcha) <= trunc(to_date(:p10_fcha_fin,''DD/MM/YYYY'')) or :p10_fcha_fin is null)',
'   and (a.idntfccion = :P10_IDNTFCCION or :P10_IDNTFCCION is null)',
'   and a.id_etpa <> (select distinct first_value(id_fljo_trea) over(order by orden desc) ultima_tarea',
'                      from v_wf_g_instancias_transicion ',
'                     where id_instncia_fljo = a.id_instncia_fljo)',
'   and pkg_pl_workflow_1_0.fnc_vl_prtcpnte_fljo(a.id_instncia_fljo,a.id_etpa,a.id_fljo_trea_estdo,:f_id_usrio) = ''S''',
'   and a.cdgo_prcsos_jrdco_estdo = ''A''',
'--order by a.nmro_prcso_jrdco;'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(36771248586538612)
,p_heading=>'Etapa'
,p_label=>'Etapa'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(36771396809538613)
,p_heading=>'Acciones'
,p_label=>'Acciones'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(42497493219652143)
,p_heading=>unistr('Proceso Jur\00EDdico')
,p_label=>unistr('Proceso Jur\00EDdico')
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36272791395852301)
,p_name=>'NOMBRE_ETPA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOMBRE_ETPA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Nombre'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771248586538612)
,p_use_group_for=>'BOTH'
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
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36273336095852307)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36273493180852308)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36771407227538614)
,p_name=>'Actos'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771396809538613)
,p_use_group_for=>'BOTH'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<button style="color:blue" type="button" class="a-Button a-Button--noLabel a-Button--iconTextButton" tabindex="0" aria-labelledby="id_tareas_ig_grid_vc_ctx id_tareas_ig_grid_vc_cur">Generar plantilla <span class="fa fa-external-link"></span>',
'</button>'))
,p_link_target=>'f?p=&APP_ID.:13:&SESSION.:asasas:&DEBUG.:13:P13_ID_ACTO_TPO,P13_ID_PRCSOS_JRDCO,P13_BRANCH,P13_ID_PRCSOS_JRDCO_DCMNTO,P13_ID_ACTO,P13_NMRO_PRCSO_JRDCO,P13_IDNTFCCION,P13_NOMBRE_ETPA,P13_FLJO_TREA:&ID_ACTO_TPO.,&ID_PRCSOS_JRDCO.,&APP_PAGE_ID.,&ID_PRCS'
||'OS_JRDCO_DCMNTO.,&ID_ACTO.,&NMRO_PRCSO_JRDCO.,&IDNTFCCION.,&NOMBRE_ETPA.,&P10_FLJO_TREA.'
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36771586645538615)
,p_name=>'Flujo'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771396809538613)
,p_use_group_for=>'BOTH'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<button style="color:blue" type="button" class="a-Button a-Button--noLabel a-Button--iconTextButton" tabindex="0" >Flujo',
'<span class="fa fa-external-link-square"></span>',
'</button>'))
,p_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP,11:P11_ID_INSTNCIA_FLJO,P11_ID_FLJO_TREA,P11_ID_PRCSOS_JRDCO:&ID_INSTNCIA_FLJO.,&ID_ETPA.,&ID_PRCSOS_JRDCO.'
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(36813552161872501)
,p_name=>'ID_INSTNCIA_FLJO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_INSTNCIA_FLJO'
,p_data_type=>'NUMBER'
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
 p_id=>wwv_flow_api.id(36813676647872502)
,p_name=>'ID_ETPA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_ETPA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
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
 p_id=>wwv_flow_api.id(36920750343559915)
,p_name=>'ID_PRCSOS_JRDCO_DCMNTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO_DCMNTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
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
 p_id=>wwv_flow_api.id(37231505041151249)
,p_name=>'URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'URL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>210
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
 p_id=>wwv_flow_api.id(37734140710748103)
,p_name=>'NMRO_PRCSO_JRDCO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMRO_PRCSO_JRDCO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('N\00FAmero')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(42497493219652143)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(37734434525748106)
,p_name=>'HTML'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HTML'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771396809538613)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_link_target=>'&URL.'
,p_link_text=>'&HTML.'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38411594841757513)
,p_name=>'ESTDO_ETPA_VSBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ESTDO_ETPA_VSBLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Estado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771248586538612)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(41210515904338034)
,p_name=>'ID_PRCSOS_JRDCO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(42497245291652141)
,p_name=>'VLOR_TTAL_DDA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_TTAL_DDA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
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
 p_id=>wwv_flow_api.id(42497323882652142)
,p_name=>'FCHA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FCHA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Fecha'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(42497493219652143)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_format_mask=>'DD/MM/YYYY'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(42498076013652149)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Sujeto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(42497493219652143)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_api.id(42498173504652150)
,p_name=>'DRCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DRCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Direcci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(42497493219652143)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(44107690622046706)
,p_name=>'ID_ACTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_ACTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>170
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
 p_id=>wwv_flow_api.id(44108196684046711)
,p_name=>'ID_PLNTLLA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PLNTLLA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
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
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(48272673659922319)
,p_name=>'NMRO_ACTO_DSPLAY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NMRO_ACTO_DSPLAY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(51687428980979901)
,p_name=>'VLDAR_ESTDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLDAR_ESTDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
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
 p_id=>wwv_flow_api.id(55073030053709130)
,p_name=>'ACTVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>240
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(77852512198940507)
,p_name=>'ID_FNCNRIO_FIRMA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_FNCNRIO_FIRMA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>250
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(77852607029940508)
,p_name=>'ID_ACTO_TPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_ACTO_TPO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>260
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82189828530286203)
,p_name=>'INDCDOR_PROCSAR_ESTDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INDCDOR_PROCSAR_ESTDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>270
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(115712821943426550)
,p_name=>'medidas'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(36771396809538613)
,p_use_group_for=>'BOTH'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<button style="color:blue" type="button" class="a-Button a-Button--noLabel a-Button--iconTextButton" tabindex="0" aria-labelledby="id_tareas_ig_grid_vc_ctx id_tareas_ig_grid_vc_cur">Medidas Cautelares <span class="fa fa-external-link"></span>',
'</button>'))
,p_link_target=>'f?p=&APP_ID.:104:&SESSION.::&DEBUG.:RP,104:P104_ID_PRCSOS_JRDCO:&ID_PRCSOS_JRDCO.'
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(35983716774789150)
,p_internal_uid=>35983716774789150
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
,p_no_data_found_message=>'<h4>No hay actos disponibles para generar <span aria-hidden="true" class="fa fa-send-o fa-2x"></span></h4>'
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
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
'    config.initialSelection = false; ',
'    return selectAll(config, {',
'        name: ''Seleccionar Todos'',',
'        action: seleccionarTodos,',
'        hot:false',
'    }) ;',
'}'))
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(35984190812789150)
,p_interactive_grid_id=>wwv_flow_api.id(35983716774789150)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>20
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(35984207599789150)
,p_report_id=>wwv_flow_api.id(35984190812789150)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1414890004374)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(36273336095852307)
,p_is_visible=>false
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36278717777852618)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(36272791395852301)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>157
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36802829234913447)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(36771407227538614)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>147
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36803256157917325)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(36771586645538615)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>95
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36819501154872718)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(36813552161872501)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(36820013419872722)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(36813676647872502)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(37110265582719790)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(36920750343559915)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>323
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(37729456366664553)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(37231505041151249)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(37753585887882783)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(37734140710748103)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>120
,p_break_order=>3
,p_break_is_enabled=>false
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(37758632578992336)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(37734434525748106)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(39210981932157725)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(38411594841757513)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>96
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(42482721561612238)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(41210515904338034)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(43340937640698646)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(42497245291652141)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>83
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(43341493701698648)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(42497323882652142)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>82
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(44045972438579833)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(42498076013652149)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>222
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(44046445507579837)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(42498173504652150)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>104
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(44737037402597331)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(44107690622046706)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(45354416570391394)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(44108196684046711)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(48348849295953016)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(48272673659922319)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(51693424098980134)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(51687428980979901)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(66151669839451816)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(55073030053709130)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(81550689831857714)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(77852512198940507)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(81551165534857717)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(77852607029940508)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82592313737140728)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(82189828530286203)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(116903265306311932)
,p_view_id=>wwv_flow_api.id(35984207599789150)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(115712821943426550)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>152
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(82189944382286204)
,p_plug_name=>'Responsables'
,p_parent_plug_id=>wwv_flow_api.id(82191811138286223)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17355873415919374)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT R.ID_PRCSOS_JRDCO,R.ID_PRCSOS_JRDCO_RSPNSBLE,R.IDNTFCCION,R.PRMER_NMBRE,R.SGNDO_NMBRE,R.PRMER_APLLDO,R.SGNDO_APLLDO',
'FROM CB_G_PROCESOS_JRDCO_RSPNSBLE R'))
,p_plug_source_type=>'NATIVE_IG'
,p_master_region_id=>wwv_flow_api.id(35983282437789150)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190191368286206)
,p_name=>'ID_PRCSOS_JRDCO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_parent_column_id=>wwv_flow_api.id(41210515904338034)
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190253598286207)
,p_name=>'ID_PRCSOS_JRDCO_RSPNSBLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO_RSPNSBLE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190383933286208)
,p_name=>'IDNTFCCION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IDNTFCCION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Identificaci\00F3n')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
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
 p_id=>wwv_flow_api.id(82190483839286209)
,p_name=>'PRMER_NMBRE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRMER_NMBRE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Primer Nombre'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190542279286210)
,p_name=>'SGNDO_NMBRE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGNDO_NMBRE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Segundo Nombre'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190608002286211)
,p_name=>'PRMER_APLLDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRMER_APLLDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Primer Apellido'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82190764914286212)
,p_name=>'SGNDO_APLLDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGNDO_APLLDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Segundo Apellido'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(82190022712286205)
,p_internal_uid=>82190022712286205
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
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
 p_id=>wwv_flow_api.id(82612707183227255)
,p_interactive_grid_id=>wwv_flow_api.id(82190022712286205)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(82612834858227255)
,p_report_id=>wwv_flow_api.id(82612707183227255)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82613935327227258)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(82190191368286206)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82614486348227261)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(82190253598286207)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82614917124227262)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(82190383933286208)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82615438935227263)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(82190483839286209)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82615936764227265)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(82190542279286210)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82616499781227266)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(82190608002286211)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82616997405227267)
,p_view_id=>wwv_flow_api.id(82612834858227255)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(82190764914286212)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(82190892697286213)
,p_plug_name=>'Cartera del Proceso'
,p_parent_plug_id=>wwv_flow_api.id(82191811138286223)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17355873415919374)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    M.ID_PRCSOS_JRDCO_MVMNTO,',
'    M.ID_PRCSOS_JRDCO,',
'    C.VGNCIA,',
'    C.PRDO,',
'    C.DSCRPCION_CNCPTO,',
'    C.VLOR_SLDO_CPTAL,',
'    C.VLOR_INTRES,',
'    (C.VLOR_SLDO_CPTAL+C.VLOR_INTRES) as VLOR_TTAL',
'from  V_GF_G_CARTERA_X_CONCEPTO c, CB_G_PROCESOS_JRDCO_MVMNTO m',
'where C.ID_SJTO_IMPSTO = M.ID_SJTO_IMPSTO',
'  and C.VGNCIA = M.VGNCIA',
'  and C.ID_PRDO = M.ID_PRDO ',
'  and C.ID_CNCPTO = M.ID_CNCPTO',
'  and cdgo_mvnt_fncro_estdo = ''NO''  -- Cartera Normalizada',
'  and M.ESTDO = ''A'';'))
,p_plug_source_type=>'NATIVE_IG'
,p_master_region_id=>wwv_flow_api.id(35983282437789150)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82191025532286215)
,p_name=>'ID_PRCSOS_JRDCO_MVMNTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO_MVMNTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82191171600286216)
,p_name=>'ID_PRCSOS_JRDCO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID_PRCSOS_JRDCO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_parent_column_id=>wwv_flow_api.id(41210515904338034)
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(82191234413286217)
,p_name=>'VGNCIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VGNCIA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Vigencia'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
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
 p_id=>wwv_flow_api.id(82191384663286218)
,p_name=>'PRDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRDO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Periodo'
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
 p_id=>wwv_flow_api.id(82191430237286219)
,p_name=>'DSCRPCION_CNCPTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DSCRPCION_CNCPTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Concepto'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>100
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
 p_id=>wwv_flow_api.id(82191544677286220)
,p_name=>'VLOR_SLDO_CPTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_SLDO_CPTAL'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Saldo Capital'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G999G999G990'
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
 p_id=>wwv_flow_api.id(82191685600286221)
,p_name=>'VLOR_INTRES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_INTRES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('Saldo Inter\00E9s')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G999G999G990'
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
 p_id=>wwv_flow_api.id(82191711092286222)
,p_name=>'VLOR_TTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VLOR_TTAL'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Saldo Total'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
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
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(82190921916286214)
,p_internal_uid=>82190921916286214
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
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
 p_id=>wwv_flow_api.id(82613326771227256)
,p_interactive_grid_id=>wwv_flow_api.id(82190921916286214)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(82613409307227256)
,p_report_id=>wwv_flow_api.id(82613326771227256)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82617418162227268)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(82191025532286215)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82617967951227270)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(82191171600286216)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82618488859227271)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(82191234413286217)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82618907505227275)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(82191384663286218)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82619457241227277)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(82191430237286219)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82619955844227278)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(82191544677286220)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82620446131227280)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(82191685600286221)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(82620910605227281)
,p_view_id=>wwv_flow_api.id(82613409307227256)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(82191711092286222)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(82860835227223442)
,p_plug_name=>'Consolidado'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17356902947919375)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(a.nombre_etpa) nombre_etpa',
'     , count(a.id_prcsos_jrdco_dcmnto) cantidad',
'     ,  (select apex_util.prepare_url( p_url => ''f?p='' || :APP_ID ',
'                                                       || '':10:'' ',
'                                                       || :APP_SESSION ',
'                                                       ||''::NO::P10_TIPO_FLUJO,P10_FLJO_TREA:'' ',
'                                                       || t.id_fljo',
'                                                       || '',''',
'                                                       || t.id_fljo_trea)',
'from wf_d_flujos_tarea t where t.id_fljo_trea = a.id_etpa ) url',
'     , a.id_etpa',
'  from v_cb_g_procesos_jrdco_dcmnto a',
' where a.actvo = ''S''',
'   and a.id_etpa <> (select distinct first_value(id_fljo_trea) over(order by orden desc) ultima_tarea',
'                      from v_wf_g_instancias_transicion ',
'                     where id_instncia_fljo = a.id_instncia_fljo)',
'   and pkg_pl_workflow_1_0.fnc_vl_prtcpnte_fljo(a.id_instncia_fljo,a.id_etpa,a.id_fljo_trea_estdo,:f_id_usrio) = ''S''',
'   and a.cdgo_prcsos_jrdco_estdo = ''A''',
'group by a.nombre_etpa, a.id_etpa',
'order by 2'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.BADGE_LIST'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'CANTIDAD'
,p_attribute_04=>'&URL.'
,p_attribute_05=>'0'
,p_attribute_07=>'BOX'
,p_attribute_08=>'Y'
,p_attribute_09=>'NOMBRE_ETPA'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36771027124538610)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_APLCAR'
,p_button_static_id=>'BTN_APLICAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Aplicar Cambio  <br/>de Etapa/Estado'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-floppy-o'
,p_grid_new_grid=>false
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(42497912625652148)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_APLCAR_MSVO'
,p_button_static_id=>'BTN_APLCAR_MSVO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Generar Documentos  <br/> Masivos'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-gears'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13160835616099701)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_ABRIR_MDAL_GNRAR_MSVO'
,p_button_static_id=>'BTN_ABRIR_MDAL_GNRAR_MSVO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17409089099919398)
,p_button_image_alt=>'Btn Abrir Mdal Gnrar Msvo'
,p_button_position=>'BELOW_BOX'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36771109835538611)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_IMPRMIR'
,p_button_static_id=>'BTN_IMPRMIR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Generar/Imprimir <br>Acto(s)'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-cog'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(88664564884226019)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_RSLTDOS_PRCSMNTO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Resultados de <br>Procesamiento'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:47:&SESSION.::&DEBUG.:RP,47:P47_ID_PRCSO_JRDCO_LTE:&P10_ID_PRCSO_JRDCO_LTE.'
,p_button_condition=>'P10_ID_PRCSO_JRDCO_LTE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-window-search'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115712342466426545)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_ASOCIAR_MEDIDA_CAUTELAR'
,p_button_static_id=>'BTN_ASOCIAR_MEDIDA_CAUTELAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>'Asociar Medida <br>Cautelar'
,p_button_position=>'BELOW_BOX'
,p_icon_css_classes=>'fa-clipboard-plus'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(116933436655382741)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(36770834366538608)
,p_button_name=>'BTN_IR_SLCCION_LOTE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_image_alt=>unistr('Ir a Lotes de <br>Selecci\00F3n Jur\00EDdica')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP,8:P8_ID_PRCSO_TPO:2'
,p_icon_css_classes=>'fa-box-arrow-in-ne'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36039375703515114)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(36039146682515112)
,p_button_name=>'Consulta'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17409110614919398)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consulta'
,p_button_position=>'BODY'
,p_icon_css_classes=>'fa-window-search'
,p_grid_column_attributes=>'style="margin-top:10px;"'
,p_grid_new_grid=>false
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(44107173456046701)
,p_branch_name=>'Go To Page 71'
,p_branch_action=>'f?p=66000:71:&SESSION.:&P10_MSVO.:&DEBUG.:RP,71:P71_ID_RPRTE,P71_NMBRE_ZIP,P71_ORGEN,P71_CDGO_IMPRSION:&P10_ID_RPRTE.,Documentos_juridicos,P10_JSON,GCB&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'masivoZipProcesar'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(115712441876426546)
,p_branch_name=>unistr('Ir a P\00E1gina 101')
,p_branch_action=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP,101:P101_ID_PRCSOS_JRDCO:&P10_ID_PRCSOS_JRDCO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(115712342466426545)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(51688079032979907)
,p_branch_name=>'Go To Page 18'
,p_branch_action=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP,18:P18_ID_FLJO_TREA:&P10_FLJO_TREA.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(42497912625652148)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5519163311658750)
,p_name=>'P10_TPOS_SLCCION'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_item_default=>'SEL'
,p_prompt=>unistr('Tipos de Selcci\00F3n')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Selecci\00F3n puntual;SEL,Seleccionar todos;ALL')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(17408383121919397)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36039234671515113)
,p_name=>'P10_FLJO_TREA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_prompt=>'Etapa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select initcap(a.nmbre_trea)nmbre_trea, a.id_fljo_trea',
'  from v_wf_d_flujos_tarea a',
' where a.id_fljo = :p10_tipo_flujo',
' order by a.nmbre_trea'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P10_TIPO_FLUJO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(17408723634919398)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Seleccione la Etapa en la que se encuentra el proceso jur\00EDdico.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37230439247151238)
,p_name=>'P10_JSON'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42497520955652144)
,p_name=>'P10_FCHA_INCIO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_prompt=>'Fecha Inicio'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_cMaxlength=>255
,p_tag_attributes=>'onkeydown="return false" onfocus="this.value=''''" '
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(17408492887919397)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Fecha que hace referencia al d\00EDa en que se genero el proceso jur\00EDdico.')
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'MONTH_AND_YEAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42497677669652145)
,p_name=>'P10_FCHA_FIN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_prompt=>'Fecha Fin'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_attributes=>'onkeydown="return false" onfocus="this.value=''''" '
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(17408492887919397)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Fecha que hace referencia al d\00EDa en que se genero el proceso jur\00EDdico.')
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'MONTH_AND_YEAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(44107296530046702)
,p_name=>'P10_XML'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48273538378922328)
,p_name=>'P10_MSVO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51687532922979902)
,p_name=>'P10_JSONMASIVO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51687972481979906)
,p_name=>'P10_ID_ACTO_TPO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(57848926534104903)
,p_name=>'P10_IDNTFCCION'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_prompt=>unistr('Identificaci\00F3n Sujeto')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_cattributes_element=>'onkeypress="return validarExpresion(event, ''numeroEntero'');"'
,p_field_template=>wwv_flow_api.id(17408492887919397)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Ingrese la identificaci\00F3n del sujeto sin guiones para que al consultar, filtre por este par\00E1metro.')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(62816285868590315)
,p_name=>'P10_ID_RPRTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82859490470223428)
,p_name=>'P10_TIPO_FLUJO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_prompt=>'Tipo Flujo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select b.dscrpcion_fljo ,b.id_fljo',
' from wf_d_flujos b',
'where id_prcso = 10',
'  and cdgo_clnte = :f_cdgo_clnte'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17408723634919398)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Seleccionar el tipo de flujo con el que se inicio el proceso jur\00EDdico.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(88664406551226018)
,p_name=>'P10_ID_PRCSO_JRDCO_LTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(115712590043426547)
,p_name=>'P10_ID_PRCSOS_JRDCO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(117354954247950507)
,p_name=>'P10_ID_RPRTE_PRMTRO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(36039146682515112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(62816300593590316)
,p_computation_sequence=>10
,p_computation_item=>'P10_ID_RPRTE'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select A.id_rprte',
'from gn_d_plantillas a',
'join gn_d_actos_tipo_tarea c on C.id_acto_tpo = A.id_acto_tpo ',
'where C.id_fljo_trea = :P10_FLJO_TREA',
'group by A.id_rprte;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37229915375151233)
,p_name=>'al seleccionar datos de la grilla '
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(35983282437789150)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37230050695151234)
,p_event_id=>wwv_flow_api.id(37229915375151233)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'validar_sel();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37734816151748110)
,p_name=>'al cerrar el cuadro de dialogo'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'body'
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'dialogclose'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37735369523748115)
,p_event_id=>wwv_flow_api.id(37734816151748110)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(35983282437789150)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(57292934474180011)
,p_name=>'Al cambiar item P10_FCHA_INCIO'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_FCHA_INCIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(57293030338180012)
,p_event_id=>wwv_flow_api.id(57292934474180011)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P10_FCHA_FIN").datepicker( ''option'' , ''minDate'' , $("#P10_FCHA_INCIO").val());',
'$(".ui-datepicker-trigger").attr( "class" , "ui-datepicker-trigger a-Button a-Button--calendar" );',
'',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(57292183283180003)
,p_name=>'Al cambiar fecha de inicio_1'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_FCHA_INCIO_1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(57292233195180004)
,p_event_id=>wwv_flow_api.id(57292183283180003)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P10_FCHA_FIN_1").datepicker( ''option'' , ''minDate'' , $("#P10_FCHA_INCIO_1").val());',
'$(".ui-datepicker-trigger").attr( "class" , "ui-datepicker-trigger a-Button a-Button--calendar" );',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(57292540938180007)
,p_name=>'Al cambiar fecha inicio 1'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_FECHA_INICIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(57292675867180008)
,p_event_id=>wwv_flow_api.id(57292540938180007)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P10_FECHA_FIN_1").datepicker( ''option'' , ''minDate'' , $("#P10_FECHA_INICIO_1").val());',
'$(".ui-datepicker-trigger").attr( "class" , "ui-datepicker-trigger a-Button a-Button--calendar" );',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5518465537658743)
,p_name=>'Al dar click en BTN_IMPRMIR'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(36771109835538611)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5518568489658744)
,p_event_id=>wwv_flow_api.id(5518465537658743)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let v_json_data = window.localStorage.getItem(''P10_JSON'');',
'',
'let v_ttal_actos = JSON.parse(v_json_data).length;',
'',
unistr('console.log(''\00BFCuantos actos se seleccionaron?'', v_ttal_actos);'),
'',
'if (v_ttal_actos > 1) {',
'    ',
unistr('    console.log(''Entra a impresi\00F3n masiva!'');'),
'',
'    apex.server.process(',
'        "ImprimirMasivo",',
'        {    ',
'            f01: v_json_data',
'        },',
'        {',
'            //dataType: ''text'',',
'            success: function( pData ){',
'',
'                if (pData.o_cdgo_rspsta != 0){ ',
'                    apex.message.clearErrors();',
'                    apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                }else{',
'                    //console.log(pData.o_url);',
'                    console.log(''Valido para masivo'');',
'                    //$s("P10_MSVO", "masivoZip"); //ImprimirLoteZip o masivoZip',
'                    //apex.item("P10_MSVO").setValue("masivoZip");',
'                    //v_request = "masivoZip";',
'                    window.localStorage.setItem(''P10_MSVO'', "masivoZip");',
'                }',
'            }',
'        }',
'    );',
'    ',
'}else{',
'    ',
unistr('    console.log(''Entra a impresi\00F3n puntual!'');'),
'    ',
'    apex.server.process(',
'        "ImprimirPuntual",',
'        {    ',
'            f01: v_json_data',
'        },',
'        {',
'            //dataType: ''text'',',
'            success: function( pData ){',
'',
'                if (pData.o_cdgo_rspsta != 0){ ',
'                    apex.message.clearErrors();',
'                    apex.message.alert(  pData.o_mnsje_rspsta );',
'',
'                }else{',
'                    console.log(''Valido para puntual'');',
'                    //$s("P10_MSVO", "ImprimirPuntual");',
'                    //apex.item("P10_MSVO").setValue("ImprimirPuntual");',
'                    window.localStorage.setItem(''P10_MSVO'', "ImprimirPuntual");',
'                }',
'            }',
'        }',
'    );',
'}',
'',
'var v_request = window.localStorage.getItem(''P10_MSVO'');',
'',
'if (v_request == '''' || v_request == ''undefined''){',
'    apex.message.clearErrors();',
unistr('    apex.message.alert(  ''No se pueden generar los documentos debido a que no se ha determinado si la generaci\00F3n es masiva o puntual.'' );'),
'}else{',
'    $s("P10_MSVO", v_request);',
'',
'    //console.log(''El Localstorage a ejecutar es: '', v_request);',
'    //console.log(''El Request a ejecutar es: '', apex.item("P10_MSVO").getValue());',
'',
'    //Ejecutamos el Branch para ir de la pag 10 a la 71 para la impresion de PDF',
'    apex.submit({request: ''masivoZipProcesar''});',
'}',
''))
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13160925444099702)
,p_name=>'Al cambiar Item P10_TPOS_SLCCION'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_TPOS_SLCCION'
,p_condition_element=>'P10_TPOS_SLCCION'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ALL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13161001401099703)
,p_event_id=>wwv_flow_api.id(13160925444099702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''button[data-action="selectAll"]'').click();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13161143829099704)
,p_event_id=>wwv_flow_api.id(13160925444099702)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region("etapas_proceso").widget().interactiveGrid("setSelectedRecords", []);'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(36894020087523101)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'cambiar de estado el documento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    pkg_cb_proceso_juridico.prc_rg_estado_documento( p_id_usuario => :F_ID_USRIO,',
'                                                    p_id_prcso_jrdco_lte_lpe => :P10_ID_PRCSO_JRDCO_LTE,',
'                                                     p_json       => :P10_JSON',
'                                                     );',
'                                                     ',
'                                                    -- INSERT INTO MUERTO (X) VALUES (''SI ESTOY INGRESANDO, ''||:P10_JSON||'' ''||:P10_ID_PRCSO_JRDCO_LTE);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(36771027124538610)
,p_process_success_message=>unistr('Acci\00F3n procesada de forma exitosa.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(119600155426538302)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'creacion XMl'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_dta            clob;',
'    v_cdgo_rspsta    number;',
'    v_mnsje_rspsta   varchar2(100);',
'    v_json         clob;',
'begin',
'    for i in 1..apex_application.g_f01.count ',
'    loop',
'        v_json :=  v_json || apex_application.g_f01(i);',
'    end loop;',
'    ',
'    ',
'    :P10_ID_RPRTE_PRMTRO  := pkg_gn_generalidades.fnc_ge_id_rprte_prmtro();',
'        ',
'  /*  for c_cobro in (',
'                            select a.id_dtrmncion,',
'                            b.nmro_dcmnto ',
'                            from gi_g_determinaciones a',
'                            join re_g_documentos    b on a.id_dcmnto = b.id_dcmnto',
'                            where a.id_dtrmncion_lte = :P63_ID_DTRMNCION_LTE',
'        ',
'        ',
'        ',
'                           ) loop */',
'    ',
'   /*     v_dta  := ''<ID_PRCSOS_JRDCO_DCMNTO>'' || :P63_ID_DTRMNCION_LTE        || ''</ID_PRCSOS_JRDCO_DCMNTO>''|| ',
'                  ''<ID_PRCSOS_JRDCO>''     || c_determinacion.id_dtrmncion || ''</ID_PRCSOS_JRDCO>''    || ',
'				  ''<FNCION>''              || c_determinacion.id_dtrmncion || ''</FNCION>''    || ',
'                  ''<nmbre_rprte> ''        || c_determinacion.nmro_dcmnto  || ''</nmbre_rprte>'';',
'             ',
'        pkg_gn_generalidades.prc_rg_t_reportes_parametro( :P63_ID_RPRTE_PRMTRO,',
'                                                          v_dta,',
'                                                          v_cdgo_rspsta,',
'										                  v_mnsje_rspsta );',
'                                                      ',
' --   end loop; */',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5517691707658735)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ImprimirMasivo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_json_actos    clob;',
'    o_cdgo_rspsta   number;',
'    o_mnsje_rspsta  varchar2(1000);',
'    o_ttal_rgstros  number;',
'    v_url           varchar2(1000);',
'    v_request       varchar2(20);',
'begin',
'',
'    o_cdgo_rspsta := 0;',
'    o_mnsje_rspsta := ''OK'';',
'    ',
'    -- Se prepara el JSON de los actos obtenidos desde el localStorage',
'    for i in 1..APEX_APPLICATION.g_f01.count loop',
'       v_json_actos := v_json_actos||APEX_APPLICATION.g_f01(i);',
'    end loop;',
'    ',
'    -- Se registra la DATA del LocalStorage',
'    pkg_gn_generalidades.prc_rg_registros_impresion(p_json_regstros => v_json_actos,',
'                                                    p_cdgo_imprsion => ''GCB'',',
'                                                    p_id_usrio      => :F_ID_USRIO,',
'                                                    p_id_session    => :APP_SESSION,',
'                                                    o_ttal_rgstros  => o_ttal_rgstros,',
'                                                    o_cdgo_rspsta   => o_cdgo_rspsta,',
'                                                    o_mnsje_rspsta  => o_mnsje_rspsta);',
'    ',
'    if o_cdgo_rspsta <> 0 then',
'        apex_json.open_object();',
'        apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'        apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'        apex_json.close_object();',
'    end if;',
'    ',
'    apex_json.open_object();',
'    apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'    --apex_json.write(''o_url'', v_url);',
'    apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'    apex_json.close_object();',
'    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8313219730425001)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ImprimirPuntual'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_json_actos    clob;',
'    o_cdgo_rspsta   number;',
'    o_mnsje_rspsta  varchar2(1000);',
'    o_ttal_rgstros  number;',
'    v_url           varchar2(1000);',
'    v_request       varchar2(20);',
'begin',
'',
'    o_cdgo_rspsta := 0;',
'    o_mnsje_rspsta := ''OK'';',
'    ',
'    -- Se prepara el JSON de los actos obtenidos desde el localStorage',
'    for i in 1..APEX_APPLICATION.g_f01.count loop',
'       v_json_actos := v_json_actos||APEX_APPLICATION.g_f01(i);',
'    end loop;',
'    ',
'    delete gn_g_reportes_impresion',
'     where cdgo_imprsion = ''GCB''',
'       and id_usrio = :F_ID_USRIO',
'       and id_session = :APP_SESSION;',
'    commit;',
'    ',
'    -- Se registra la DATA del LocalStorage',
'    pkg_gn_generalidades.prc_rg_registros_impresion(p_json_regstros => v_json_actos,',
'                                                    p_cdgo_imprsion => ''GCB'',',
'                                                    p_id_usrio      => :F_ID_USRIO,',
'                                                    p_id_session    => :APP_SESSION,',
'                                                    o_ttal_rgstros  => o_ttal_rgstros,',
'                                                    o_cdgo_rspsta   => o_cdgo_rspsta,',
'                                                    o_mnsje_rspsta  => o_mnsje_rspsta);',
'    ',
'    if o_cdgo_rspsta <> 0 then',
'        apex_json.open_object();',
'        apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'        apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'        apex_json.close_object();',
'    end if;',
'    ',
'    apex_json.open_object();',
'    apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'    --apex_json.write(''o_url'', v_url);',
'    apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'    apex_json.close_object();',
'    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5519041402658749)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'RegitrarActosGenerar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_json_actos   clob;',
'    o_cdgo_rspsta  number;',
'    o_mnsje_rspsta varchar2(1000);',
'    v_id_acto      number;',
'    v_cntdor       number := 0;',
'begin',
'    ',
'    -- Se prepara el JSON de los actos obtenidos desde el localStorage',
'    for i in 1..APEX_APPLICATION.g_f01.count loop',
'       v_json_actos := v_json_actos||APEX_APPLICATION.g_f01(i);',
'    end loop;',
'    ',
'    /*delete cb_g_prcsos_jrdco_dcmnt_gnr',
'    where id_usrio = :F_ID_USRIO',
'    and id_session = :APP_SESSION;',
'    commit;*/',
'    ',
'    o_cdgo_rspsta := 0;',
'    o_mnsje_rspsta := ''OK'';',
'    ',
'    for c_actos in (select *',
'                    from json_table(v_json_actos, ''$[*]''',
'                                columns(',
'                                    id_instncia_fljo        number path ''$.ID_INSTNCIA_FLJO'',',
'                                    id_prcsos_jrdco         number path ''$.ID_PRCSOS_JRDCO'',',
'                                    id_prcsos_jrdco_dcmnto  number path ''$.ID_PRCSOS_JRDCO_DCMNTO'',',
'                                    id_etpa                 number path ''$.ID_ETPA'',',
'                                    id_acto_tpo             number path ''$.ID_ACTO_TPO''',
'                                ) ',
'                             )',
'    ) loop',
'    ',
'        begin',
'            select id_acto into v_id_acto',
'            from cb_g_procesos_jrdco_dcmnto ',
'            where id_prcsos_jrdco_dcmnto = c_actos.id_prcsos_jrdco_dcmnto;',
'        exception',
'            when others then',
'                v_id_acto := null;',
'        end;',
'        ',
'        if v_id_acto is null then',
'            ',
'            v_cntdor := v_cntdor + 1;',
'        ',
'            pkg_cb_proceso_juridico.prc_rg_generacion_masiva_actos(p_id_instncia_fljo =>    c_actos.id_instncia_fljo',
'                                                                ,  p_id_prcsos_jrdco  =>    c_actos.id_prcsos_jrdco',
'                                                                ,  p_id_prcsos_jrdco_dcmnto =>    c_actos.id_prcsos_jrdco_dcmnto',
'                                                                ,  p_id_etpa          =>    c_actos.id_etpa',
'                                                                ,  p_id_acto_tpo      =>    c_actos.id_acto_tpo',
'                                                                ,  p_id_usrio         =>    :F_ID_USRIO',
'                                                                ,  p_id_session       =>    :APP_SESSION',
'                                                                ,  o_cdgo_rspsta      =>    o_cdgo_rspsta',
'                                                                ,  o_mnsje_rspsta     =>    o_mnsje_rspsta);',
'        ',
'        end if;',
'   end loop;',
'   ',
'   apex_json.open_object;',
'   apex_json.write(''o_cdgo_rspsta'', o_cdgo_rspsta);',
'   apex_json.write(''o_ttal_actos_slccndos'', v_cntdor);',
'   apex_json.write(''o_mnsje_rspsta'', o_mnsje_rspsta);',
'   apex_json.close_object;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(147345322246501005)
,p_process_sequence=>50
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cambiar_Estado_Etapa'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_json_actos    clob;',
'begin',
'    ',
'    for i in 1..APEX_APPLICATION.g_f01.count loop',
'       v_json_actos := v_json_actos||APEX_APPLICATION.g_f01(i);',
'    end loop;',
'    ',
'    pkg_cb_proceso_juridico.prc_rg_estado_documento( p_id_usuario => :F_ID_USRIO,',
'                                                    p_id_prcso_jrdco_lte_lpe => :P10_ID_PRCSO_JRDCO_LTE,',
'                                                     p_json       => v_json_actos',
'                                                     );',
'                                                     ',
'    apex_json.open_object();',
'    apex_json.write(''o_cdgo_rspsta'', 0);',
'    --apex_json.write(''JSON'', v_json_actos);',
'    apex_json.write(''o_mnsje_rspsta'', ''OK'');',
'    apex_json.close_object();',
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
