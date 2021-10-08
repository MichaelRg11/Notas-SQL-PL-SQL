-- Para eliminar un ajuste se debe borrar primero de la tabla gf_g_ajuste_detalle y despues de la tabla gf_g_ajustes
select * from gf_g_ajuste_detalle where id_ajste = 48412;

delete from gf_g_ajuste_detalle where id_ajste = 48413;

select * from gf_g_ajustes where id_ajste = 48412;

delete from gf_g_ajustes where id_ajste = 48413;









-- id para crear ajustes
select g.id_sjto_impsto, g.idntfccion_sjto, sum(vlor_sldo_cptal)
from V_GF_G_CARTERA_X_CONCEPTO d
join v_si_i_sujetos_impuesto g on g.id_sjto_impsto = d.id_sjto_impsto
where d.cdgo_clnte = 6
    and d.vgncia in ( 2020 )
  /*  and d.id_sjto_impsto in( select distinct id_sjto_impsto
from gi_g_liquidaciones x
where cdgo_clnte = 6
and id_prcso_crga in (372,373) and vgncia in ( 2018, 2019 ))*/
group by g.id_sjto_impsto, idntfccion_sjto
having sum(vlor_sldo_cptal) = 0 ;