create or replace  view V_GI_G_DECLARACIONES as 
select
    a.id_dclrcion,
    a.nmro_cnsctvo,
    b.id_dclrcion_vgncia_frmlrio,
    f.id_impsto,
    g.idntfccion_sjto,
    g.id_sjto_impsto,
    c.id_frmlrio,
    a.vlor_ttal,
    a.vlor_pago,
    f.dscrpcion,
    e.vgncia,
    e.dscrpcion dscrpcion_prdo,
    h.id_sjto_tpo,
    i.nmbre_sjto_tpo,
    a.cdgo_dclrcion_estdo,
    a.fcha_rgstro,
    a.fcha_prsntcion,
    a.fcha_prsntcion_pryctda,
    a.fcha_aplccion,
    a.fcha_ultma_mdfccion,
    a.cdgo_clnte,
    a.id_cnddto_vgncia,
    f.id_dclrcn_tpo,
    j.nmbre_dclrcion_uso,
    k.nmbre_impsto,
    l.nmbre_impsto_sbmpsto,
    m.nmbre_rzon_scial, 
    o.idntfccion,
    d.id_prdo
  from
         gi_g_declaraciones a
    inner join gi_d_dclrcnes_vgncias_frmlr b on b.id_dclrcion_vgncia_frmlrio = a.id_dclrcion_vgncia_frmlrio
    inner join gi_d_formularios            c on c.id_frmlrio = b.id_frmlrio
    inner join gi_d_dclrcnes_tpos_vgncias  d on d.id_dclrcion_tpo_vgncia = b.id_dclrcion_tpo_vgncia
    inner join df_i_periodos               e on e.id_prdo = d.id_prdo
    inner join gi_d_declaraciones_tipo     f on f.id_dclrcn_tpo = d.id_dclrcn_tpo
    inner join v_si_i_sujetos_impuesto     g on g.id_sjto_impsto = a.id_sjto_impsto
    inner join gi_d_dclrcnes_tpos_sjto     h on f.id_dclrcn_tpo = h.id_dclrcn_tpo
    inner join df_i_sujetos_tipo           i on i.id_sjto_tpo = h.id_sjto_tpo
    inner join gi_d_declaraciones_uso      j on a.id_dclrcion_uso = j.id_dclrcion_uso
    inner join df_c_impuestos              k on k.id_impsto = a.id_impsto
    inner join df_i_impuestos_subimpuesto  l on l.id_impsto_sbmpsto = a.id_impsto_sbmpsto
    inner join si_i_personas               m on a.id_sjto_impsto     = m.id_sjto_impsto
    inner join si_i_sujetos_impuesto       n on a.id_sjto_impsto     = n.id_sjto_impsto
    inner join si_c_sujetos                o on o.id_sjto            = n.id_sjto;