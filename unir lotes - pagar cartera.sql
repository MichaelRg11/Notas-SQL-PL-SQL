
/* Unir lotes */
select * from v_cb_g_procesos_jrdco_dcmnto a
where a.id_etpa = 191
  and a.fcha > '20/12/2021';
  
  
select * from cb_g_procesos_jrdco_dcmnto b
where b.id_lte_imprsion >= 600
  and b.id_lte_imprsion <= 679;

update cb_g_procesos_jrdco_dcmnto b set b.id_lte_imprsion = 598
where b.id_lte_imprsion >= 421
  and b.id_lte_imprsion <= 598;


/* Pagar cartera */
/* Se genera documento */
  -- Gestion financiera
    -- Documento
      -- Emision de recibo puntuales

/* Pagar documento de pago */
select pkgbarcode.funcadfac( null
                           , null
                           , null
                           , nmro_dcmnto
                           , vlor_ttal_dcmnto
                           , trunc(fcha_vncmnto)
                           , b.cdgo_ean
                           , 'N' )      
from v_re_g_documentos a
join df_i_impuestos_subimpuesto b on a.id_impsto_sbmpsto = b.id_impsto_sbmpsto
where nmro_dcmnto = '20190072307';

/* Recaudos */

  -- Recaudo
    -- Gestion de registro de recaudo manual

/* Se aplica el recaudo */
  
  -- Recaudo
    -- Aplicacion de recaudo