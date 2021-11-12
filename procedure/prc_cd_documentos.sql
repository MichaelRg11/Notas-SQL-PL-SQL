procedure prc_cd_documentos( p_id_dcmnto                in number   default null
                           , p_id_trd_srie_dcmnto_tpo   in number
                           , p_id_dcmnto_tpo            in number
                           , p_file_blob                in blob     default null
                           , p_directory                in varchar2 default null
                           , p_file_name_dsco           in varchar2 default null
                           , p_file_name                in varchar2
                           , p_file_mimetype            in varchar2
                           , p_id_usrio                 in number
                           , p_cdgo_clnte               in number
                           , p_json                     in clob
                           , p_accion                   in varchar2
                           , o_cdgo_rspsta              out number
                           , o_mnsje_rspsta             out varchar2
                           , o_id_dcmnto                out number) 
as
  v_id_dcmnto     number;
  v_nmro_dcmnto   gd_g_documentos.nmro_dcmnto%type;
  v_id_dcmnto_tpo number;
  v_file_bfile    bfile;
begin            
  o_cdgo_rspsta   := 0;
  o_mnsje_rspsta  := 'Proceso realizado de forma exitosa!'; 
  -- Determinamos si creamos el objeto BFILE
  if p_directory is not null and p_file_name_dsco is not null then
    v_file_bfile := bfilename(p_directory, p_file_name_dsco);
    -- Determinamos si existe el Archivo
    if dbms_lob.fileexists( v_file_bfile ) = 0 then
      -- No existe el Archivo
      o_cdgo_rspsta   := 5;
      o_mnsje_rspsta  := 'El archivo en el Directorio no Existe.';
      return;
    end if;
  end if;
  
  if p_accion in ('SAVE','CREATE') then
    begin
      select id_dcmnto_tpo 
        into v_id_dcmnto_tpo
        from v_gd_d_trd_serie_dcmnto_tpo 
       where id_trd_srie_dcmnto_tpo = p_id_trd_srie_dcmnto_tpo;
    exception when others then 
      v_id_dcmnto_tpo := p_id_dcmnto_tpo;
    end;

    if p_id_dcmnto is not null then 
      -- Cuando el  DOCUMENTO ( id_dcmnto ) NO ES NULO -- > Actualizamo el Docuemnto
      begin
        select id_dcmnto
          into v_id_dcmnto
          from gd_g_documentos
         where id_dcmnto = p_id_dcmnto;        
      exception when others then
        o_cdgo_rspsta   := 10;
        o_mnsje_rspsta  := 'No se encontraron datos del documento';
        return;
      end; 

      begin
        o_id_dcmnto := v_id_dcmnto;   
        if p_file_blob is null and p_directory is null then
          -- Actualizamos solo datos diferentes al Archivo ( BLOB o BFLE )
          update gd_g_documentos
           set id_trd_srie_dcmnto_tpo   = nvl(p_id_trd_srie_dcmnto_tpo, id_trd_srie_dcmnto_tpo)
             , id_dcmnto_tpo            = nvl(v_id_dcmnto_tpo, id_dcmnto_tpo)
           where id_dcmnto                = v_id_dcmnto;  
        elsif p_file_blob is not null and p_directory is not null p_file_name_dsco is not null then
          -- Actualizar el archivo en Disco
          pkg_gd_utilidades.prc_rg_dcmnto_dsco(p_blob         => p_file_blob
                                             , p_directorio   => p_directory
                                             , p_nmbre_archvo => p_file_name_dsco
                                             , o_cdgo_rspsta  => o_cdgo_rspsta
                                             , o_mnsje_rspsta => o_mnsje_rspsta);
          update gd_g_documentos
             set id_trd_srie_dcmnto_tpo   = nvl(p_id_trd_srie_dcmnto_tpo, id_trd_srie_dcmnto_tpo)
               , id_dcmnto_tpo            = nvl(v_id_dcmnto_tpo, id_dcmnto_tpo)
               , file_bfile               = v_file_bfile
               , file_name                = p_file_name
               , file_mimetype            = p_file_mimetype
           where id_dcmnto                = v_id_dcmnto;
        elsif p_file_blob is not null then
          -- Actualizamos el Archivo ( BLOB )
          update gd_g_documentos
             set id_trd_srie_dcmnto_tpo   = nvl(p_id_trd_srie_dcmnto_tpo, id_trd_srie_dcmnto_tpo)
               , id_dcmnto_tpo            = nvl(v_id_dcmnto_tpo, id_dcmnto_tpo)
               , file_blob                = p_file_blob
               , file_name                = p_file_name
               , file_mimetype            = p_file_mimetype
           where id_dcmnto                = v_id_dcmnto;
        elsif p_directory is not null then
          -- Actualizamos el Archivo ( BFILE )
          update gd_g_documentos
             set id_trd_srie_dcmnto_tpo   = nvl(p_id_trd_srie_dcmnto_tpo, id_trd_srie_dcmnto_tpo)
               , id_dcmnto_tpo            = nvl(v_id_dcmnto_tpo, id_dcmnto_tpo)
               , file_bfile               = v_file_bfile
               , file_name                = p_file_name
               , file_mimetype            = p_file_mimetype
           where id_dcmnto                = v_id_dcmnto;
        end if;     
        -- Gestionamos los METADATOS del DOCUMENTO
        for c_json in (select case when a.id is null and b.id_dcmnto_tpo_mtdta is not null 
                                    then 'D'
                                    when b.id_dcmnto_tpo_mtdta is null 
                                    then 'I' 
                                    else 'U'
                               end as action
                             , nvl( b.id_dcmnto_mtdta , a.id ) id_dcmnto_mtdta
                             , a.id
                             , a.valor
                          from ( select replace(id, 'INP') id 
                                      , valor 
                                   from json_table( p_json , '$[*]'  columns( id varchar2 path '$.key', valor varchar2 path '$.value' ))) a
                     full join ( select a.id_dcmnto_tpo_mtdta 
                                      , a.id_dcmnto_mtdta
                                   from gd_g_documentos_metadata a
                                  where a.id_dcmnto = v_id_dcmnto
                        ) b
                       on a.id = b.id_dcmnto_tpo_mtdta
                      )
        loop
          case c_json.action 
            when 'I' then
              insert into gd_g_documentos_metadata(id_dcmnto, id_dcmnto_tpo_mtdta, vlor)
                                            values(v_id_dcmnto, c_json.id, c_json.valor);
            when 'D' then
              delete from gd_g_documentos_metadata where id_dcmnto_mtdta = c_json.id_dcmnto_mtdta;  
            when 'U' then
              update gd_g_documentos_metadata 
                 set id_dcmnto            = v_id_dcmnto
                   , id_dcmnto_tpo_mtdta  = c_json.id
                   , vlor                 = c_json.valor
               where id_dcmnto_mtdta      = c_json.id_dcmnto_mtdta;                                 
          end case;
        end loop;   
      exception when others then 
        o_cdgo_rspsta   := 20;
        o_mnsje_rspsta  := 'No se encontraron datos del documento ' || sqlerrm;
        return;                        
      end;
    else
      -- Cuando el  DOCUMENTO ( id_dcmnto ) es NULO -- > Creamos el Docuemnto
      begin
          -- Validamos que el BLOB o el Nombre del Directorio no sean NULOS a la vez
          if p_file_blob is null and p_directory is null then
            o_cdgo_rspsta   := 30;
            o_mnsje_rspsta  := 'No se ha enviado archivo binario ni nombre de directorio.'; 
            return;
          end if;
          --GENERAMOS EL NUMERO DEL DOCUMENTO
          v_nmro_dcmnto := pkg_gn_generalidades.fnc_cl_consecutivo(p_cdgo_clnte, 'GDC');
          if p_file_blob is not null and p_directory is not null then
            -- Inserta el archivo en Disco y guarda apuntador en BFILE
            pkg_gd_utilidades.prc_rg_dcmnto_dsco(p_blob         => p_file_blob
                                               , p_directorio   => p_directory
                                               , p_nmbre_archvo => 'GDG-' || v_nmro_dcmnto || '-' || ltrim(p_file_name,'-') 
                                               , o_cdgo_rspsta  => o_cdgo_rspsta
                                               , o_mnsje_rspsta => o_mnsje_rspsta);
            if (o_cdgo_rspsta <> 0)then
              return;
            else
              v_file_bfile := bfilename(p_directory, p_file_name_dsco);
              insert into gd_g_documentos(id_trd_srie_dcmnto_tpo, id_dcmnto_tpo, nmro_dcmnto, file_bfile, file_name, file_mimetype, id_usrio)
              values (p_id_trd_srie_dcmnto_tpo, v_id_dcmnto_tpo, v_nmro_dcmnto, v_file_bfile, p_file_name, p_file_mimetype, p_id_usrio)
              returning id_dcmnto into o_id_dcmnto;
            end if;
          end if;
          -- Creamos registro de documento con blob
          if p_file_blob is not null then
            insert into gd_g_documentos(id_trd_srie_dcmnto_tpo, id_dcmnto_tpo, nmro_dcmnto, file_blob, file_name, file_mimetype, id_usrio)
            values (p_id_trd_srie_dcmnto_tpo, v_id_dcmnto_tpo, v_nmro_dcmnto, p_file_blob, p_file_name, p_file_mimetype, p_id_usrio)
            returning id_dcmnto into o_id_dcmnto;
          end if; 
          -- Creamos registro de documento con el vfile
          if p_directory is not null and p_file_name_dsco is not null then
            insert into gd_g_documentos(id_trd_srie_dcmnto_tpo, id_dcmnto_tpo, nmro_dcmnto, file_bfile, file_name, file_mimetype, id_usrio)
            values (p_id_trd_srie_dcmnto_tpo, v_id_dcmnto_tpo, v_nmro_dcmnto, v_file_bfile, p_file_name, p_file_mimetype, p_id_usrio)
            returning id_dcmnto into o_id_dcmnto;
          end if;
          --CREAMOS LOS REGISTROS DE METADATAS DEL DOCUMENTO
          insert into gd_g_documentos_metadata(id_dcmnto, id_dcmnto_tpo_mtdta, vlor)
                                        select o_id_dcmnto, replace(id, 'INP'), valor
                                          from json_table( p_json, '$[*]'
                                                      columns( id      varchar2    path    '$.key',
                                                               valor   varchar2    path    '$.value' 
                                                             )
                                                          );
          return;
      exception when others then
        o_cdgo_rspsta   := 30;
        o_mnsje_rspsta  := 'No se pudo registrar el documento' || sqlerrm;
        return;
      end;
    end if; 
  end if;        
end prc_cd_documentos;