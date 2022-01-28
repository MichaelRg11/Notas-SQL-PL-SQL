-- Imprimer traza
select * from sg_d_configuraciones_log
where cdgo_clnte = 6 and upper(nmbre_up) like upper('%pkg_gf_ajustes%');

-- Configurar LOG
select * from sg_g_log 
where nmbre_up = 'pkg_re_documentos.prc_rg_documento_rpt' --and cdgo_clnte = 6 and id_log > 245322779
order by 1 desc;

update sg_d_configuraciones_log set nvel_log = 6
where cdgo_clnte = 10 and upper(nmbre_up) like upper('%pkg_re_documentos.fnc_gn_documento%');

begin
  delete from sg_d_configuraciones_log
  where cdgo_clnte = :p_cdgo_clnte and upper(nmbre_up) like upper('%pkg_gi_determinacion%');
    
  pkg_sg_log.prc_rg_configuraciones_log(p_cdgo_clnte => :p_cdgo_clnte, p_nmbre_up => 'pkg_gi_determinacion', p_nvel_log => 6);
end;

-- Paquetes descompilados
select
  case when object_type like 'PACKAGE BODY%' then
    'alter package ' || object_name || ' compile body;'
  else
    'alter ' || object_type || ' ' || object_name || ' compile;'
  end sentencia
from user_objects where status like 'INV%';