procedure prc_rg_seleccion_cnddts_archvo(p_cdgo_clnte         in  number,
                                           p_id_prcso_crga      in  number,
                                           p_id_lte             in  number,
                                           o_cdgo_rspsta        out number,
                                           o_mnsje_rspsta       out varchar2)
  as
    e_no_encuentra_lote     exception;
    e_no_archivo_excel      exception;
    v_et_g_procesos_carga   et_g_procesos_carga%rowtype; 
    v_cdgo_prcso            varchar2(3);
    v_nl                    number;
    v_nmbre_up              varchar2(70) := 'pkg_gn_generalidades.prc_rg_seleccion_cnddts_archvo';
    
  begin
    
    o_cdgo_rspsta := 0;
    o_mnsje_rspsta := 'OK';
    
    -- Determinamos el nivel del Log de la UPv
    v_nl := pkg_sg_log.fnc_ca_nivel_log(p_cdgo_clnte,null, v_nmbre_up);
    pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, 'Entrando ' || systimestamp, 1);
    
    -- Si no se especifica un lote
    if p_id_lte is null then
        raise e_no_encuentra_lote;
    end if;
    
    -- ****************** INICIO ETL ***************************************************
    begin
        select a.*
        into v_et_g_procesos_carga
		from et_g_procesos_carga a
		where id_prcso_crga = p_id_prcso_crga;
    exception
        when others then
            o_cdgo_rspsta := 5;
            o_mnsje_rspsta := 'Error al consultar informacion de carga en ETL';
            return;
    end;
    
    -- Cargar archivo al directorio
    pk_etl.prc_carga_archivo_directorio (p_file_blob => v_et_g_procesos_carga.file_blob, 
                                         p_file_name => v_et_g_procesos_carga.file_name);
                                         
    pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, ' 200. Despues de prc_carga_archivo_directorio ' || systimestamp, 6);
    
    -- Ejecutar proceso de ETL para cargar a tabla intermedia
    pk_etl.prc_carga_intermedia_from_dir (p_cdgo_clnte 		=> p_cdgo_clnte, 
                                          p_id_prcso_crga 	=> p_id_prcso_crga);
    
    pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, ' 300. Despues de prc_carga_intermedia_from_dir ' || systimestamp, 6);
    
    -- Cargar datos a Gestion
    pk_etl.prc_carga_gestion (p_cdgo_clnte    => p_cdgo_clnte, 
                              p_id_prcso_crga => p_id_prcso_crga);
    
    pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, ' 400. Despues de prc_carga_gestion ' || systimestamp, 6);
    
    -- ****************** FIN ETL ******************************************************
    
    -- Validar si el ID_CRGA pertenece al modulo cautelar o al modulo de cobros
    -- GCB o MCA?
    begin
        select cdgo_prcso into v_cdgo_prcso
        from v_gn_g_candidatos_carga
        where id_prcso_crga = p_id_prcso_crga
          and id_lte_prcso = p_id_lte
          and rownum <= 1;
    exception
        when others then
            o_cdgo_rspsta := 10;
            o_mnsje_rspsta := 'Error al validar el proceso que realiza la carga.';
            return;
    end;
    
    pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, ' 410. v_cdgo_prcso: ' || v_cdgo_prcso || systimestamp, 6);
    
    -- Si el proceso es del modulo de cobros (GCB)
    if v_cdgo_prcso = 'GCB' then
        
        begin
            -- 3. Se eliminan los sujetos (que no han sido procesados) en el lote que 
            -- no se encuentren en la información cargada del archivo.
            --delete from cb_g_procesos_simu_sujeto a
            update cb_g_procesos_simu_sujeto a
               set a.actvo = 'N'
             where a.id_prcsos_smu_lte = p_id_lte
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'S'
               and not exists(select 1
                                from v_gn_g_candidatos_carga c
                               where c.id_sjto_prcso = a.id_prcsos_smu_sjto
                                 and c.id_prcso_crga = p_id_prcso_crga
                                 and c.id_lte_prcso = p_id_lte
                                 and c.cdgo_prcso = v_cdgo_prcso
                            );
                            
            pkg_sg_log.prc_rg_log(p_cdgo_clnte, null, v_nmbre_up, v_nl, ' 420. Despues de update cb_g_procesos_simu_sujeto: ' || v_cdgo_prcso || systimestamp, 6);
        exception
            when others then
                rollback;
                o_cdgo_rspsta := 15;
                o_mnsje_rspsta := o_cdgo_rspsta||'-Error al intentar eliminar los sujetos que no estan en el archivo cargado.'||sqlerrm;
                return;
        end;
        
        -- Incluir sujetos del archivo que no estan en el lote
        for c_sjtos_archvo in (select c.id_sjto_prcso
                                 from v_gn_g_candidatos_carga c
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and exists(select 1
                                              from cb_g_procesos_simu_sujeto j
                                              where j.id_prcsos_smu_sjto = c.id_sjto_prcso
                                                and j.id_prcsos_smu_lte = c.id_lte_prcso
                                                and j.actvo = 'N'
                                                and j.indcdor_prcsdo = 'N')
                              )
        loop
        
            -- Los que esten inactivos pero vinieron en el archivo se vuelven a activar
            update cb_g_procesos_simu_sujeto a
               set a.actvo = 'S'
             where a.id_prcsos_smu_lte = p_id_lte
               and a.id_prcsos_smu_sjto = c_sjtos_archvo.id_sjto_prcso
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'N';
               
        end loop;
        
    elsif v_cdgo_prcso = 'MCA' then -- Si el proceso es del modulo cautelar (MCA)
        
        begin
            -- 3. Se eliminan los sujetos (que no han sido procesados) en el lote que 
            -- no se encuentren en la información cargada del archivo.
            update mc_g_embargos_simu_sujeto a
               set a.actvo = 'N'
             where a.id_embrgos_smu_lte = p_id_lte
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'S'
               and not exists(select 1
                                from v_gn_g_candidatos_carga c
                               where c.id_sjto_prcso = a.id_embrgos_smu_lte
                                 and c.id_prcso_crga = p_id_prcso_crga
                                 and c.id_lte_prcso = p_id_lte
                                 and c.cdgo_prcso = v_cdgo_prcso
                            );
        exception
            when others then
                rollback;
                o_cdgo_rspsta := 20;
                o_mnsje_rspsta := o_cdgo_rspsta||'-Error al intentar eliminar los sujetos que no estan en el archivo cargado.'||sqlerrm;
                return;
        end;
        
        -- Incluir sujetos del archivo que no estan en el lote
        for c_sjtos_archvo in (select c.id_sjto_prcso
                                 from v_gn_g_candidatos_carga c
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and exists(select 1
                                              from mc_g_embargos_simu_sujeto j
                                              where j.id_embrgos_smu_sjto = c.id_sjto_prcso
                                                and j.id_embrgos_smu_lte = c.id_lte_prcso
                                                and j.actvo = 'N'
                                                and j.indcdor_prcsdo = 'N')
                              )
        loop
        
            -- Los que esten inactivos pero vinieron en el archivo se vuelven a activar
            update mc_g_embargos_simu_sujeto a
               set a.actvo = 'S'
             where a.id_embrgos_smu_lte = p_id_lte
               and a.id_embrgos_smu_sjto = c_sjtos_archvo.id_sjto_prcso
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'N';
               
        end loop;
    
    elsif v_cdgo_prcso = 'FIS' then   --  Si el proceso es del modulo de FISCALIZACION (FIS)
        
        begin
            -- 3. Se eliminan los sujetos (que no han sido procesados) en el lote que 
            -- no se encuentren en la información cargada del archivo.
            update fi_g_candidatos a
               set a.actvo = 'N'
             where a.id_fsclzcion_lte = p_id_lte
               and a.indcdor_asgndo = 'N'
               and a.actvo = 'S'
               and not exists(select 1
                                from v_gn_g_candidatos_carga c
                               where c.id_sjto_prcso = a.id_cnddto
                                 and c.id_prcso_crga = p_id_prcso_crga
                                 and c.id_lte_prcso = p_id_lte
                                 and c.cdgo_prcso = v_cdgo_prcso
                            );
        exception
            when others then
                rollback;
                o_cdgo_rspsta := 25;
                o_mnsje_rspsta := o_cdgo_rspsta||'-Error al intentar eliminar los candidatos que no estan en el archivo cargado.'||sqlerrm;
                return;
        end;
        
        -- Incluir sujetos del archivo que no estan en el lote
        for c_sjtos_archvo in (select c.id_sjto_prcso
                                 from v_gn_g_candidatos_carga c
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and exists(select 1
                                              from fi_g_candidatos j
                                              where j.id_cnddto = c.id_sjto_prcso
                                                and j.id_fsclzcion_lte = c.id_lte_prcso
                                                and j.actvo = 'N'
                                                and j.indcdor_asgndo = 'N')
                              )
        loop
        
            -- Los que esten inactivos pero vinieron en el archivo se vuelven a activar
            update fi_g_candidatos a
               set a.actvo = 'S'
             where a.id_fsclzcion_lte = p_id_lte
               and a.id_cnddto = c_sjtos_archvo.id_sjto_prcso
               and a.indcdor_asgndo = 'N'
               and a.actvo = 'N';
               
        end loop;
        
    end if;
    
    commit;
    
  exception
    when e_no_encuentra_lote then
        o_cdgo_rspsta := 97;
        o_mnsje_rspsta := 'No se ha especificado un lote válido.';
    when e_no_archivo_excel then
        o_cdgo_rspsta := 98;
        o_mnsje_rspsta := 'El archivo cargado no es un archivo EXCEL.';
    when others then
        o_cdgo_rspsta := 99;
        o_mnsje_rspsta := 'No se pudo procesar la seleccion de candidatos por medio del cargue de archivo.';
  end prc_rg_seleccion_cnddts_archvo;