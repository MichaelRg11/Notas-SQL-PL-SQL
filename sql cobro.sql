select a.idntfccion, c.prmer_nmbre, a.drccion, a.nmro_acto, a.nombre_etpa from v_cb_g_procesos_jrdco_dcmnto a
join si_i_sujetos_impuesto b on a.id_sjto = b.id_sjto
join si_i_sujetos_responsable c on b.id_sjto_impsto = c.id_sjto_impsto
where a.id_etpa = 247
  and c.prncpal_s_n = 'S'
  and a.fcha > '16/12/21';
 --where a.nmro_acto_dsplay like '-2021-20210000404'--a.id_prcsos_jrdco = 246430
select trunc( dbms_lob.getLength(a.file_blob) )
from v_cb_g_procesos_jrdco_dcmnto a
where a.id_etpa = 247
  and fcha > '16/12/21';

select * from si_i_sujetos_impuesto;

select count(1)--a.id_prcsos_jrdc_dcmnt_plnt, a.id_plntlla, b.id_prcsos_jrdco_dcmnto, b.id_acto, c.id_prcsos_jrdco
from cb_g_prcsos_jrdc_dcmnt_plnt a
join cb_g_procesos_jrdco_dcmnto b on a.id_prcsos_jrdco_dcmnto = b.id_prcsos_jrdco_dcmnto
join cb_g_procesos_juridico c on b.id_prcsos_jrdco = c.id_prcsos_jrdco
join v_wf_d_flujos_tarea d on b.id_fljo_trea = d.id_fljo_trea
where dbms_lob.compare( a.dcmnto, empty_clob() ) = 0
  and d.id_fljo_trea = 247;

select * from cb_g_prcsos_jrdc_dcmnt_plnt a
where a.dcmnto is null;

select * from cb_g_prcsos_jrdc_dcmnt_plnt a
join cb_g_procesos_jrdco_dcmnto b on a.id_prcsos_jrdco_dcmnto = b.id_prcsos_jrdco_dcmnto
where dbms_lob.compare( a.dcmnto, empty_clob() ) = 0;

select * from gd_g_documentos;

update gd_g_documentos a set a.file_blob = v_blob
  where exists (select 1 from gn_g_actos b where b.id_dcmnto = a.id_dcmnto);

select * from muerto
where n_001 = 21
  and v_001 like '%247199';
truncate table muerto;

select * from muerto;

select a.id_acto, a.id_prcsos_jrdco_dcmnto
from v_cb_g_procesos_jrdco_dcmnto a
 where a.actvo = 'S'
  and a.nmro_acto is not null
  and a.file_blob is null
  and a.id_etpa = 247
  and fcha > '16/12/21';
  
select count(*) - 305
from v_cb_g_procesos_jrdco_dcmnto a
 where a.actvo = 'S'
  and a.file_blob is not null
  --and a.nmro_prcso_jrdco = 20210001399
  and a.id_etpa = 247;
  
  
select * from v_cb_g_procesos_jrdco_dcmnto a
where a.nmro_prcso_jrdco = 20210001399;

select * from cb_g_procesos_juridico
where nmro_prcso_jrdco = 20210001399;

select count(*) hola, c.id_prcsos_jrdco, c.id_acto
from cb_g_procesos_juridico a
join cb_g_procesos_jrdco_dcmnto c on a.id_prcsos_jrdco = c.id_prcsos_jrdco
left join cb_g_prcsos_jrdc_dcmnt_plnt h on h.id_prcsos_jrdco_dcmnto = c.id_prcsos_jrdco_dcmnto
where c.id_acto = 8761857
group by c.id_prcsos_jrdco, c.id_acto
order by hola desc;

select count(*) hola, a.id_prcsos_jrdco_dcmnto from cb_g_prcsos_jrdc_dcmnt_plnt a
group by a.id_prcsos_jrdco_dcmnto
order by hola desc;

select * from muerto;