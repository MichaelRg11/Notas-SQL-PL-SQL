-- ALterar la tabla gn_g_candidatos_carga
alter table gn_g_candidatos_carga add idntfccion varchar2(100);
alter table gn_g_candidatos_carga add vgncia_dsde number;
alter table gn_g_candidatos_carga add vgncia_hsta number;

-- consulta para imprimir excel en la 80000, pagina 8
select a.cdgo_clnte, 
        a.fcha_lte,
        b.id_sjto,
        d.idntfccion,
        a.id_prcso_tpo,
        b.indcdor_prcsdo,
        a.id_fncnrio,
        b.vlor_ttal_dda,
        (select min(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_desde,
        (select max(vgncia) from cb_g_procesos_smu_mvmnto i where i.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto) as vigencia_hasta,
        LISTAGG(c.prmer_nmbre||' '||c.sgndo_nmbre||' '||c.prmer_aplldo||' '||c.sgndo_aplldo, ', ') WITHIN GROUP (ORDER BY c.prmer_nmbre||' '||c.sgndo_nmbre||' '||c.prmer_aplldo||' '||c.sgndo_aplldo) nmbre_rspnsbles,
        a.id_prcsos_smu_lte,
        b.id_prcsos_smu_sjto
  from cb_g_procesos_simu_lote        a
  join cb_g_procesos_simu_sujeto      b   on  a.id_prcsos_smu_lte = b.id_prcsos_smu_lte
  join cb_g_procesos_simu_rspnsble    c   on  b.id_prcsos_smu_sjto = c.id_prcsos_smu_sjto
  join si_c_sujetos                   d   on  d.id_sjto = b.id_sjto
where a.id_prcsos_smu_lte = v_lte
and b.indcdor_prcsdo = 'N'
and b.actvo = 'S'
group by a.cdgo_clnte, 
        a.fcha_lte,
        a.id_fncnrio,
        a.id_prcso_tpo,
        a.id_prcsos_smu_lte,
        b.id_prcsos_smu_sjto,
        b.id_sjto,
        d.idntfccion,
        b.indcdor_prcsdo,
        b.vlor_ttal_dda

-- En el orden 
v_json_cnddto.put('CLIENTE', c_cnddtos_lte.cdgo_clnte);
v_json_cnddto.put('FECHA_LOTE', c_cnddtos_lte.fcha_lte);
v_json_cnddto.put('ID_SUJETO', c_cnddtos_lte.id_sjto);
v_json_cnddto.put('IDENTIFICACION', c_cnddtos_lte.idntfccion);
v_json_cnddto.put('FUNCIONARIO', c_cnddtos_lte.id_fncnrio);
v_json_cnddto.put('VALOR_CARTERA', c_cnddtos_lte.vlor_ttal_dda);
v_json_cnddto.put('VIGENCIA DESDE', c_cnddtos_lte.vigencia_desde);
v_json_cnddto.put('VIGENCIA HASTA', c_cnddtos_lte.vigencia_hasta);
v_json_cnddto.put('RESPONSABLES', c_cnddtos_lte.nmbre_rspnsbles);
v_json_cnddto.put('CODIGO_TIPO_PROCESO', c_cnddtos_lte.id_prcso_tpo);
v_json_cnddto.put('ID_LOTE', c_cnddtos_lte.id_prcsos_smu_lte);
v_json_cnddto.put('ID_SUJETO_LOTE', c_cnddtos_lte.id_prcsos_smu_sjto);

-- 