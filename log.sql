-- Imprimer traza
select * from sg_d_configuraciones_log
where cdgo_clnte = 6 and upper(nmbre_up) like upper('%pkg_gf_ajustes%');

-- Configurar LOG
select * from sg_g_log 
where nmbre_up = 'pkg_re_documentos.prc_rg_documento_rpt' --and cdgo_clnte = 6 and id_log > 245322779
order by 1 desc;

update sg_d_configuraciones_log set nvel_log = 6
where cdgo_clnte = 10 and upper(nmbre_up) like upper('%pkg_cb_medidas_cautelares.prc_rg_blob_acto_embargo%');

begin
  delete from sg_d_configuraciones_log
  where cdgo_clnte = :p_cdgo_clnte and upper(nmbre_up) like upper('%pkg_cb_medidas_cautelares%');
    
  pkg_sg_log.prc_rg_configuraciones_log(p_cdgo_clnte => :p_cdgo_clnte, p_nmbre_up => 'pkg_cb_medidas_cautelares', p_nvel_log => 6);
end;

/* Consulta para buscar procedimientos y funciones que pertenezcan a un paquete */
select object_name, procedure_name, object_type 
from (select * from user_procedures 
      where object_type = 'PROCEDURE'
        union
      select * from user_procedures 
      where object_type = 'FUNCTION'
        union
      select * from user_procedures 
      where object_type = 'PACKAGE' and object_name like 'PK%' and subprogram_id > 0)
where upper(object_name) like upper('%'|| :p_nmbre_up || '%') or :p_nmbre_up is null
order by object_type, object_id, subprogram_id;