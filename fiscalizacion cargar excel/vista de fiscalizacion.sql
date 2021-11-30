create or replace view V_FI_G_CANDIDATOS as
  select
    c.id_cnddto,
    c.id_sjto_impsto,
    i.id_impsto,
    i.cdgo_impsto,
    i.nmbre_impsto,
    s.id_impsto_sbmpsto,
    s.nmbre_impsto_sbmpsto,
    q.nmbre_rzon_scial as candidato,
    c.indcdor_asgndo,
    e.cdgo_cnddto_estdo,
    e.nmbre,
    i.cdgo_clnte,
    c.id_fsclzcion_lte,
    p.nmbre_prgrma,
    p.id_prgrma,
    p.cdgo_prgrma,
    s.nmbre_sbprgrma,
    s.cdgo_sbprgrma,
    s.id_sbprgrma,
    a.idntfccion,
    c.actvo
  from
         fi_g_candidatos c
    join si_i_sujetos_impuesto      b on c.id_sjto_impsto = b.id_sjto_impsto
    join si_c_sujetos               a on b.id_sjto = a.id_sjto
    join df_c_impuestos             i on c.id_impsto = i.id_impsto
    join df_i_impuestos_subimpuesto s on c.id_impsto_sbmpsto = s.id_impsto_sbmpsto
    join si_i_personas              q on c.id_sjto_impsto = q.id_sjto_impsto
    join fi_d_candidato_estado      e on c.cdgo_cnddto_estdo = e.cdgo_cnddto_estdo
    join fi_d_programas             p on c.id_prgrma = p.id_prgrma
    join fi_d_subprogramas          s on c.id_sbprgrma = s.id_sbprgrma;