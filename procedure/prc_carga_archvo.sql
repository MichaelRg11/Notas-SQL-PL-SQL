-- Tabla de registro temporal de como fueron procesados los archivos.
create table gd_g_crga_dcmto_tem(
  id_acto number,
  id_dcmto number,
  nmro_acto number,
  nmbre_dcmto varchar(250),
  tmño_dcmto number,
  obsrvcion varchar(250)
);
/
declare
	-- ********************************************************************
	-- objeto:  cargar archivos desde disco duro como Documento de un Acto
	-- ********************************************************************
  v_mnsje_rspsta varchar2(1000);
  v_cdgo_rspsta  number;	
  v_directorio varchar2(100) := 'DIR_PRUEBA';
  v_nmbre_archvo varchar2(100);
  v_blob blob;
  v_sqlerrm   varchar2(2000);
  v_bfile bfile;
  v_id_dcmnto number;
  v_file_name varchar(100);
  v_blob_length integer;
begin
	-- Recorremos los Actos a Cargarles Documentos
	for c_acts_nmro in (select b.nmro_acto, b.id_Acto
                      from gi_g_determinaciones a
                      join gn_g_actos b on a.id_Acto = b.id_Acto
                      where b.id_dcmnto is null and  a.id_dtrmncion_lte = 869 and rownum <= 1) loop
    -- Bloque donde se creara el documento vacio.
    begin
      pkg_gn_generalidades.prc_ac_acto(	p_file_blob       => empty_blob()
                                      , p_id_acto         => c_acts_nmro.id_acto
                                      , p_ntfccion_atmtca => 'N');
      exception
          when others then
            v_sqlerrm := sqlerrm;
            dbms_output.put_line('[Error] Exception: ' || v_sqlerrm);
    end;
    
    begin
      -- Extraemos el nombre y id del archivo 
      select b.id_dcmnto, b.file_name into v_id_dcmnto, v_file_name
      from gn_g_actos a
      inner join gd_g_documentos b on a.id_dcmnto = b.id_dcmnto
      where id_acto = c_acts_nmro.id_Acto;
      -- Nombre de la arhivo
      v_nmbre_archvo := c_acts_nmro.nmro_acto || '.pdf';
      -- Determinamos si el Archivo existe en el Diretorio.
      v_bfile := bfilename(v_directorio, v_nmbre_archvo);
      begin
        if dbms_lob.fileexists(v_bfile) <> 1 then
          dbms_output.put_line('El archivo no existe en el directorio, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          rollback;
          insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
            values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto, 'El archivo no existe en el directorio, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          commit;
          continue;                                       
        end if;
      end;
      -- Inicializamos la variable v_blob en empty_blob()
      update gd_g_documentos set file_blob = empty_blob()
      where id_dcmnto = v_id_dcmnto 
      return file_blob into v_blob;
      -- Extraemos y cargamos el archivo a v_blob
      v_bfile := bfilename(v_directorio, v_nmbre_archvo);
      v_blob_length := dbms_lob.getlength(v_bfile);
      dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
      dbms_lob.loadfromfile(v_blob, v_bfile, dbms_lob.getlength(v_bfile));
      dbms_lob.fileclose(v_bfile);

      dbms_output.put_line('El archivo a sido registrado exitosamente, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
      -- Guardamos en la tabla de registros temporales
      insert into gd_g_crga_dcmto_tem(id_acto, id_dcmto, nmro_acto, nmbre_dcmto, tmño_dcmto, obsrvcion)
          values(c_acts_nmro.id_Acto, v_id_dcmnto, c_acts_nmro.nmro_acto, v_file_name, v_blob_length, 'El archivo a sido registrado exitosamente, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
      -- Guardamos
      commit;
      
      exception 
        when others then
          rollback;
          insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
            values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto, '[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm || ', fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          commit;
          dbms_lob.fileclose(v_bfile);
          v_sqlerrm := sqlerrm;
          dbms_output.put_line('[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm);
    end;
  end loop;
  
  exception 
        when others then
          rollback;
          v_sqlerrm := sqlerrm;
          dbms_output.put_line('[Error] Exception: ' || v_sqlerrm);
end;
/
declare
	-- ********************************************************************
	-- objeto:  cargar archivos desde disco duro como Documento de un Acto
	-- ********************************************************************
  v_mnsje_rspsta varchar2(1000);
  v_cdgo_rspsta  number;	
  v_directorio varchar2(100) := 'DIR_PRUEBA';
  v_nmbre_archvo varchar2(100);
  v_blob blob;
  v_id_dcmnto number;
  v_file_name varchar(100);
  v_sqlerrm   varchar2(2000);
begin
	-- Recorremos los Actos a Cargarles Documentos
	for c_acts_nmro in (select b.nmro_acto, b.id_Acto
                      from gi_g_determinaciones a
                      join gn_g_actos b on a.id_Acto = b.id_Acto
                      where b.id_dcmnto is null and  a.id_dtrmncion_lte = 869) loop
    begin
      -- Nombre de la arhivo
      v_nmbre_archvo := c_acts_nmro.nmro_acto || '.pdf';
      -- Determinamos si el Archivo existe en el Diretorio.
      begin
        if pkg_gd_utilidades.fnc_vl_archvo_exstnte(v_directorio, v_nmbre_archvo) = 'N' then
          dbms_output.put_line('El archivo no existe en el directorio, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
            values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto,  'El archivo no existe en el directorio, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          commit;
          continue;                                       
        end if;
      end;
      
      begin
        pkg_gd_utilidades.prc_co_archco_dsco(p_directorio    => v_directorio
                                           , p_nmbre_archvo  => v_nmbre_archvo
                                           , o_archvo_blob   => v_blob
                                           , o_cdgo_rspsta   => v_cdgo_rspsta
                                           , o_mnsje_rspsta  => v_mnsje_rspsta);
        -- Validamos que se extrajo bien el documento
        if v_cdgo_rspsta = 0 then
          dbms_output.put_line('El archivo a sido registrado exitosamente, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          pkg_gn_generalidades.prc_ac_acto(p_file_blob       => v_blob
                                         , p_id_acto         => c_acts_nmro.id_acto
                                         , p_ntfccion_atmtca => 'N');
          -- Buscamos el id del documento y su nombre para guardarlos en el registro
          select b.id_dcmnto, b.file_name into v_id_dcmnto, v_file_name
          from gn_g_actos a
          inner join gd_g_documentos b on a.id_dcmnto = b.id_dcmnto
          where id_acto = c_acts_nmro.id_Acto;
          -- Guardamos en la tabla de registros temporales
          insert into gd_g_crga_dcmto_tem(id_acto, id_dcmto, nmro_acto, nmbre_dcmto, obsrvcion)
            values(c_acts_nmro.id_Acto, v_id_dcmnto, c_acts_nmro.nmro_acto, v_file_name,'El archivo a sido registrado exitosamente, fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
          -- Guardamos
          commit;
        end if;
        
        exception 
          when others then
            rollback;
            insert into gd_g_crga_dcmto_tem(id_acto, nmro_acto, obsrvcion)
              values(c_acts_nmro.id_Acto, c_acts_nmro.nmro_acto, '[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm || ', fecha: ' || to_char(sysdate, 'dd/mm/YYYY HH24:MI:SS'));
            commit;
            v_sqlerrm := sqlerrm;
            dbms_output.put_line('[Error acto:' || c_acts_nmro.id_Acto || '] Exception: ' || v_sqlerrm);
      end;
    end;
  end loop;
  
  exception 
        when others then
          rollback;
          v_sqlerrm := sqlerrm;
          dbms_output.put_line('[Error] Exception: ' || v_sqlerrm);
end;
/