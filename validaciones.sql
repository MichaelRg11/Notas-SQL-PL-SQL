-- Valida paquetes descompilados
select case
        when object_type like 'PACKAGE BODY%' then
          'alter package ' || object_name || ' compile body;'
        else
          'alter ' || object_type || ' ' || object_name || ' compile;'
        end sentencia
from user_objects where status like 'INV%';

--Crear un JOB
begin
DBMS_SCHEDULER.CREATE_JOB (
  job_name  => 'IT_GI_G_CREA_DETRMINACIONES',
  job_type  => 'STORED_PROCEDURE',
  job_action  => 'PKG_GI_DETERMINACION.PRC_EJ_JOB_DETERMINACION',
  number_of_arguments => 0,
  start_date => NULL,
  repeat_interval => NULL,
  end_date => NULL,
  enabled => FALSE,
  auto_drop => FALSE,
  comments => ''
);
end;

-----------------------------
select * from cb_g_prcsos_jrdc_dcmnt_plnt
where id_prcsos_jrdco_dcmnto = 567790;

select * from cb_g_procesos_jrdco_dcmnto a
join cb_g_prcsos_jrdc_dcmnt_plnt b on a.id_prcsos_jrdco_dcmnto = a.id_prcsos_jrdco_dcmnto
join gn_d_plantillas c on c.id_acto_tpo = a.id_acto_tpo and c.id_plntlla = b.id_plntlla
where b.id_prcsos_jrdco_dcmnto = 568382;

select * from gn_g_actos a
--join gd_g_documentos on gn_g_actos.id_dcmnto = gd_g_documentos.id_dcmnto
where a.nmro_acto in (20210000968, 20210000969, 20210000966, 20210000967);--gn_g_actos.id_acto = 8532996;

select * from gn_g_actos a
left join gd_g_documentos b on a.id_dcmnto = b.id_dcmnto
where a.id_acto = 8533016;

select * from muerto
where c_001 is not null;

select * from v_cb_g_procesos_jrdco_dcmnto a
where a.file_blob is not null
  and a.id_acto_tpo <> 35;

select r.*
from gn_d_reportes r
where r.id_rprte = 643;

-- 20210000968, 20210000969, 20210000966, 20210000967


-- Configurar LOG
select * from sg_g_log 
where nmbre_up = 'pkg_gn_generalidades.fnc_ge_xml_prmtro' --and cdgo_clnte = 6 and id_log > 245322779
order by 1 desc;

SELECT * from gn_g_reportes_impresion;

--truncate table gn_g_reportes_impresion;

select count(*) from cb_g_prcsos_jrdc_dcmnt_plnt;
select * from gn_d_plantillas;
alter table gn_g_candidatos_carga modify ID_SJTO_PRCSO number null;
SELECT * FROM GN_G_CANDIDATOS_CARGA;

truncate table cb_g_prcsos_jrdc_dcmnt_plnt;
------------------
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

SELECT * FROM GN_G_CANDIDATOS_CARGA;

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
where a.id_prcsos_smu_lte = 861
  and a.actvo = 'N';

select a.id_sjto_impsto 
from si_i_sujetos_impuesto a
where a.id_impsto = 601
  and a.id_sjto = 715039;--c_sjtos_archvo.id_sjto;

select * from muerto where t_001 is not null order by t_001 desc;

select id_impsto, id_impsto_sbmpsto
from et_g_procesos_carga
where id_prcso_crga = p_id_prcso_crga;

--truncate table muerto;