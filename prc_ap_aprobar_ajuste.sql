select id_sjto_impsto, idntfccion_sjto
from v_si_i_sujetos_impuesto
where cdgo_clnte  =  6
  and id_impsto = 19
  and idntfccion_sjto   = 1045172493;

select * from gf_g_ajustes 
where --id_ajste = 48440; 
id_instncia_fljo = 1146197;
            
select * from v_gf_g_cartera_x_concepto;

-- Datos del ajuste
select id_impsto, id_impsto_sbmpsto, id_sjto_impsto, id_instncia_fljo, tpo_ajste, ind_ajste_prcso
from gf_g_ajustes 
where id_ajste = 48445;

-- Consulta el detalle o detalles del ajuste 
select a.id_ajste_dtlle, a.id_ajste, a.id_cncpto, a.id_prdo, a.vgncia, a.sldo_cptal, a.vlor_ajste, a.vlor_intres, a.ajste_dtlle_tpo, a.id_mvmnto_orgn										
from gf_g_ajuste_detalle a 
where a.id_ajste = 48445;

select b.id_orgen 
from v_gf_g_cartera_x_concepto a
join v_gf_g_movimientos_detalle b on a.id_impsto = b.id_impsto 
                                  and a.id_sjto_impsto = b.id_sjto_impsto
                                  and a.vgncia = b.vgncia
                                  and a.id_prdo = b.id_prdo
                                  and a.id_mvmnto_fncro = b.id_mvmnto_fncro
where b.id_mvmnto_dtlle = 1725824 -- se agrega condición SF 19/08/2021
and a.id_sjto_impsto = 405153
and b.vgncia = 2019
and b.id_prdo = 58
and b.id_cncpto = 10
and b.id_cncpto  = a.id_cncpto
and a.vlor_sldo_cptal = 120000
and (('C' = 'RC' and a.cdgo_mvnt_fncro_estdo = 'RC' and b.cdgo_mvmnto_orgn_dtlle in( 'LQ', 'DL') ) or ('C' = 'SA' and a.cdgo_mvnt_fncro_estdo in ('NO', 'CN') and b.cdgo_mvmnto_orgn_dtlle  in( 'LQ', 'DL') ) or ( a.cdgo_mvnt_fncro_estdo in ('NO', 'CN'))or  (a.cdgo_mvnt_fncro_estdo = 'AN' and b.cdgo_mvmnto_orgn_dtlle = 'FS') )
and b.cdgo_mvmnto_tpo = 'IN';