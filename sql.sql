-- 1. Se eliminan los actos vigencias

select * from gn_g_actos_vigencia a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');
              
delete gn_g_actos_vigencia a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');

-- 2. se elimina el acto sujeto impuesto

select * from gn_g_actos_sujeto_impuesto a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');

delete gn_g_actos_sujeto_impuesto a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');

-- 3. Se eliminan los actos responsables

select * from gn_g_actos_responsable a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');

delete gn_g_actos_responsable a
where exists (select * 
              from mc_g_solicitudes_y_oficios b
              where b.id_embrgos_crtra = 22101
              and b.id_acto_ofcio = a.id_acto
              and b.activo = 'S');

-- 4. 
