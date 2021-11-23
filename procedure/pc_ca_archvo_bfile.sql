declare
	-- ********************************************************************
	-- objeto:  cargar archivos desde disco duro como Documento de un Acto
	-- ********************************************************************
  v_directorio    varchar2(100) := 'DIR_PRUEBA';
  v_nmbre_archvo  varchar2(100);
  v_id_dcmnto     number;
  v_file_name     varchar(100);
  v_sqlerrm       varchar2(2000);
  v_dtrmncion_lte number := 104;
begin
	-- Recorremos los Actos a Cargarles Documentos
	for c_acts_nmro in (select b.nmro_acto, b.id_Acto
                      from gi_g_determinaciones a
                      join gn_g_actos b on a.id_Acto = b.id_Acto
                      where b.id_dcmnto is null 
                        and b.indcdor_dcmnto_gnrdo = 'N'
                        and a.id_dtrmncion_lte = 104) loop
    begin
      -- Nombre de la arhivo
      v_nmbre_archvo := c_acts_nmro.nmro_acto || '.pdf';
      -- Determinamos si el Archivo existe en el Diretorio.
      begin
        if pkg_gd_utilidades.fnc_vl_archvo_exstnte(v_directorio, v_nmbre_archvo) = 'N' then
          dbms_output.put_line('El archivo no existe en el directorio.');
          insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
            values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto,  'El archivo no existe en el directorio.');
          commit;
          continue;                                       
        end if;
      end;
      
      begin
        pkg_gn_generalidades.prc_ac_acto(p_directory       => v_directorio
                                       , p_file_name_dsco  => v_nmbre_archvo
                                       , p_id_acto         => c_acts_nmro.id_acto
                                       , p_ntfccion_atmtca => 'N');

        -- Buscamos el id del documento y su nombre para guardarlos en el registro
        select b.id_dcmnto, b.file_name into v_id_dcmnto, v_file_name
        from gn_g_actos a
        inner join gd_g_documentos b on a.id_dcmnto = b.id_dcmnto
        where id_acto = c_acts_nmro.id_Acto;

        -- Guardamos en la tabla de registros temporales
        insert into gd_g_crga_dcmto_tem(id_acto, id_dcmto, nmro_acto, nmbre_dcmto, obsrvcion)
        values(c_acts_nmro.id_Acto, v_id_dcmnto, c_acts_nmro.nmro_acto, v_file_name, 'El archivo a sido registrado exitosamente.');
        -- Guardamos
        commit;
        
        exception  when others then
          rollback;
          v_sqlerrm := sqlerrm;
          dbms_output.put_line('[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm);
          insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
            values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto, '[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm || '.');
          commit;
      end;
    end;
  end loop;
  
  exception when others then
    rollback;
    v_sqlerrm := sqlerrm;
    dbms_output.put_line('[Error] Exception: ' || v_sqlerrm);
end;
/