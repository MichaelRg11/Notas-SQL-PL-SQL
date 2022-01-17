-- ALterar la tabla gn_g_candidatos_carga
alter table gn_g_candidatos_carga add idntfccion varchar2(100);
alter table gn_g_candidatos_carga add vgncia_dsde varchar2(10);
alter table gn_g_candidatos_carga add vgncia_hsta varchar2(10);
alter table gn_g_candidatos_carga add id_impsto number;
alter table gn_g_candidatos_carga add id_impsto_sbmpsto number;
alter table gn_g_candidatos_carga modify id_sjto_prcso number null;
-- Para carga de fiscalizacion
alter table gn_g_candidatos_carga add cdgo_prgrma varchar2(10);
alter table gn_g_candidatos_carga add cdgo_subprgrma varchar2(10);

-- Vista gn_g_candidatos_carga
create or replace view V_GN_G_CANDIDATOS_CARGA as
  select
    a.id_cnddto_crga,
    a.fcha_rgstro,
    a.id_prcso_crga,
    a.id_prcso_intrmdia,
    a.nmero_lnea,
    a.id_lte_prcso,
    a.id_sjto_prcso,
    a.idntfccion,
    a.vgncia_dsde,
    a.vgncia_hsta,
    a.id_impsto, 
    a.id_impsto_sbmpsto,
    a.cdgo_prgrma,
    a.cdgo_subprgrma,
    b.cdgo_prcso,
    b.dscrpcion as dscrpcion_prcso,
    b.id_crga
  from
         gn_g_candidatos_carga a
    join gn_d_codigos_proceso b on a.cdgo_prcso = b.cdgo_prcso;


update cb_g_procesos_simu_sujeto set actvo = 'N'
where id_prcsos_smu_lte = 861;

delete from cb_g_procesos_simu_rspnsble a
where exists (select 1
from cb_g_procesos_simu_sujeto b
where b.actvo = 'N'
and a.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto
and b.id_prcsos_smu_lte = 861);

delete from cb_g_procesos_smu_mvmnto a
where exists (select 1
from cb_g_procesos_simu_sujeto b
where b.actvo = 'N'
and a.id_prcsos_smu_sjto = b.id_prcsos_smu_sjto
and b.id_prcsos_smu_lte = 861);

delete from cb_g_procesos_simu_sujeto a
where a.id_prcsos_smu_lte = 861;