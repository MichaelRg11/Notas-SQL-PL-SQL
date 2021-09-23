select * from gf_g_ajustes where numro_ajste = 	20190028596;

select * from gf_g_ajuste_detalle where id_ajste = 48090;

select a.id_instncia_fljo
from gf_g_ajustes a
inner join	(	select b.cdna as id_instncia_fljo
                from table(pkg_gn_generalidades.fnc_ca_split_table(p_cdna => '1145633', p_crcter_dlmtdor => ',')) b ) c on c.id_instncia_fljo = a.id_instncia_fljo
				order by a.fcha,a.id_instncia_fljo;

/*Parte 1: Se ejecutan todos los procedimientos parametrizados*/
select a.id_ajste, a.id_sjto_impsto, a.tpo_ajste
from gf_g_ajustes a
where a.cdgo_clnte = 6
and a.id_instncia_fljo = 1145633;

-- Extrae el id ajuste => 48090, id sujeto impuesto => 356114, tipo ajuste => DB

--Se valida el id flujo tarea
select b.id_fljo_trea
from wf_g_instancias_transicion a
inner join  v_wf_d_flujos_tarea b on b.id_fljo_trea = a.id_fljo_trea_orgen
where b.cdgo_clnte = 6
and a.id_instncia_fljo = 1145633
and a.id_estdo_trnscion in (1,2,4);

-- Extrae el id flujo tarea => 139

--Se recorren las acciones a procesar
select a.nmbre_up
from df_c_procesos_tarea a  -----parametrica q realciona la tarea con la up que se va a ejecutar
where a.cdgo_clnte = 6
and a.id_fljo_trea = 139
and a.request = 'A'
order by a.orden;

select * from df_c_procesos_tarea;

select * from sg_g_log 
where cdgo_clnte = 6 and id_log > 245322779 and nmbre_up = 'pkg_gf_ajustes.prc_rg_ajste_accon_msva'
order by 1 desc;

update sg_d_configuraciones_log set nvel_log = 6
where cdgo_clnte = 10 and upper(nmbre_up) like upper('%pkg_re_documentos.fnc_gn_documento%');

select * from sg_d_configuraciones_log
where cdgo_clnte = 6 and upper(nmbre_up) like upper('%pkg_gf_ajustes%');

begin
    delete from sg_d_configuraciones_log
    where cdgo_clnte = :p_cdgo_clnte and upper(nmbre_up) like upper('%pkg_gi_determinacion%');
    
    pkg_sg_log.prc_rg_configuraciones_log(p_cdgo_clnte => :p_cdgo_clnte, p_nmbre_up => 'pkg_gi_determinacion', p_nvel_log => 6);
end;