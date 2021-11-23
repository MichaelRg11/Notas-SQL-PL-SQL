select * from gi_d_formularios where id_frmlrio = 	646;

select * from gi_g_declaraciones_detalle;

select count(*)--id_rcdo, id_lqdcion, vgncia, id_prdo
from gi_g_declaraciones where  id_dclrcion_crrccion is not null;

select * from re_g_recaudos;

select * 
from gf_g_movimientos_detalle
where id_orgen = 1342572; --- el id lo tiene declaracion en id_rcdo

select id_mvmnto_fncro --into v_id_mvmnto_fncro
  from gf_g_movimientos_detalle
  where id_orgen = 1342572
  group by id_mvmnto_fncro;

select *--id_mvmnto_fncro --into v_id_mvmnto_fncro
  from gf_g_movimientos_detalle
  where id_orgen = :v_id_rcdo
  group by id_mvmnto_fncro;

select * from gi_g_liquidaciones
where id_lqdcion = 38245548; --- el id lo tiene declaracion id_lqdcion

select * from gf_g_movimientos_financiero;

select * from gf_g_mvmntos_cncpto_cnslddo
where id_mvmnto_fncro = 16764874;

select * from muerto where t_001 is not null order by t_001 desc;

--delete from muerto where v_001 is null;.