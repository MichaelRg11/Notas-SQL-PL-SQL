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
    v_sldo_ttal_crtra       number;
    v_id_sjto_impsto        number;
    v_id_prcsos_smu_sjto    number;
    v_id_embrgos_smu_sjto	  number;
  begin
    
    o_cdgo_rspsta := 0;
    o_mnsje_rspsta := 'OK';
    
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
    
    -- Ejecutar proceso de ETL para cargar a tabla intermedia
    pk_etl.prc_carga_intermedia_from_dir (p_cdgo_clnte 		=> p_cdgo_clnte, 
                                          p_id_prcso_crga 	=> p_id_prcso_crga);
                                          
    -- Cargar datos a Gestion
    pk_etl.prc_carga_gestion (p_cdgo_clnte    => p_cdgo_clnte, 
                              p_id_prcso_crga => p_id_prcso_crga);
    
    -- ****************** FIN ETL ******************************************************
    
    -- Validar si el ID_CRGA pertenece al modulo cautelar o al modulo de cobros
    -- GCB o MCA?
    
    insert into muerto(n_001, v_001, t_001) values (250 ,'p_id_prcso_crga: ' || p_id_prcso_crga || ', p_id_lte: ' || p_id_lte, systimestamp); commit;
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
    
    -- Si el proceso es del modulo de cobros (GCB)
    if v_cdgo_prcso = 'GCB' then
    
        begin
            -- 3. Se inactivan los sujetos (que no han sido procesados) en el lote que 
            -- no se encuentren en la información cargada del archivo.
            --delete from cb_g_procesos_simu_sujeto a
            update cb_g_procesos_simu_sujeto a
               set a.actvo = 'N'
             where a.id_prcsos_smu_lte = p_id_lte
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'S'
               and not exists(select 1
                                from v_gn_g_candidatos_carga c
                                join si_c_sujetos d on d.idntfccion = c.idntfccion 
                               where d.id_sjto = a.id_sjto
                                 and c.id_prcso_crga = p_id_prcso_crga
                                 and c.id_lte_prcso = p_id_lte
                                 and c.cdgo_prcso = v_cdgo_prcso
                            );
        exception
            when others then
                rollback;
                o_cdgo_rspsta := 15;
                o_mnsje_rspsta := o_cdgo_rspsta||'-Error al intentar eliminar los sujetos que no estan en el archivo cargado.'||sqlerrm;
                return;
        end;
        
        -- Activa sujetos que vinieron en el Excel y Están INACTIVOS en el Lote
        for c_sjtos_archvo in (select d.id_sjto
                                 from v_gn_g_candidatos_carga c
                                 join si_c_sujetos d on d.idntfccion = c.idntfccion
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and exists(select 1
                                              from cb_g_procesos_simu_sujeto j
                                              where j.id_sjto = d.id_sjto
                                                and j.id_prcsos_smu_lte = c.id_lte_prcso
                                                and j.actvo = 'N'
                                                and j.indcdor_prcsdo = 'N')
                              )
        loop
        
            -- Los que esten inactivos pero vinieron en el archivo se vuelven a activar
            update cb_g_procesos_simu_sujeto a
               set a.actvo = 'S'
             where a.id_prcsos_smu_lte = p_id_lte
               and a.id_sjto = c_sjtos_archvo.id_sjto
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'N';
               
        end loop;
        
        -- INSERTAR en el Lote ... los Nuevos Sujeto que vinieron en el Excel y No estaban en el Lote
        for c_sjtos_archvo in (select c.idntfccion, c.vgncia_dsde, c.vgncia_hsta, d.id_sjto, c.id_impsto, c.id_impsto_sbmpsto
                                 from v_gn_g_candidatos_carga c
                                 join si_c_sujetos d on d.idntfccion = c.idntfccion
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and not exists(select 1
                                              from cb_g_procesos_simu_sujeto j
                                              where j.id_sjto = d.id_sjto)--and j.id_prcsos_smu_lte = c.id_lte_prcso)
                              )
        loop
        
            -- *************************************
            -- incluimos Sujetos
            -- *************************************
            -- Incluir Responsables
            -- Incluir Movimientos Financieros 
            
            -- <Identificar Sujeto Impuesto>
            begin
              select a.id_sjto_impsto into v_id_sjto_impsto
              from si_i_sujetos_impuesto a
              where a.id_impsto = c_sjtos_archvo.id_impsto
                and a.id_sjto = c_sjtos_archvo.id_sjto;
              insert into muerto(v_001,t_001) values('el id sujeto:  '||v_id_sjto_impsto,systimestamp);
              
            exception
              when others then
                o_cdgo_rspsta := 35;
                o_mnsje_rspsta := 'No se pudo identificar el sujeto impuesto asociado al ID SUJETO #' || c_sjtos_archvo.id_sjto;
                insert into muerto(v_001,t_001) values(o_cdgo_rspsta||' '||o_mnsje_rspsta,systimestamp);
                continue;
            end;
            
            -- FIN <Identificar Sujeto Impuesto>
            
            -- <Validar cartera>
            -- Validar si presenta saldo en el rango de vigencias indicado
            -- En la cartera vencida.
            begin
              select nvl(sum(vlor_sldo_cptal+vlor_intres),0) into v_sldo_ttal_crtra
              from v_gf_g_cartera_x_concepto
              where cdgo_clnte = p_cdgo_clnte
                and id_impsto = c_sjtos_archvo.id_impsto
                and id_impsto_sbmpsto = c_sjtos_archvo.id_impsto_sbmpsto
                and id_sjto_impsto = v_id_sjto_impsto
                and vgncia between c_sjtos_archvo.vgncia_dsde and c_sjtos_archvo.vgncia_hsta
                and trunc(fcha_vncmnto) < trunc(sysdate);
            exception
              when others then
                o_cdgo_rspsta := 40;
                o_mnsje_rspsta := 'Error al validar saldo en cartera.';
                continue;
            end;
            -- FIN <Validar cartera>
            
            -- SI tiene cartera proseguimos
            if v_sldo_ttal_crtra > 0 then
            
            -- 1. Incluir sujeto
              begin
                insert into cb_g_procesos_simu_sujeto(id_prcsos_smu_lte,
                                                      id_sjto,
                                                      vlor_ttal_dda,
                                                      rspnsbles,
                                                      fcha_ingrso,
                                                      indcdor_prcsdo)
                                                values(p_id_lte,
                                                       c_sjtos_archvo.id_sjto,
                                                       v_sldo_ttal_crtra,
                                                       '-',
                                                       sysdate,
                                                       'N')
                returning id_prcsos_smu_sjto into v_id_prcsos_smu_sjto;
              exception
                when others then
                  o_cdgo_rspsta := 50;
                  o_mnsje_rspsta := 'Error al intentar incluir sujeto en el lote de selección.';
                  continue;
              end;
  
              -- 2. Incluir responsables
              for c_rspnsbles in (select a.prmer_nmbre,
                                  a.sgndo_nmbre,
                                  a.prmer_aplldo,
                                  a.sgndo_aplldo,
                                  a.cdgo_idntfccion_tpo,
                                  a.idntfccion_rspnsble,
                                  a.prncpal_s_n,
                                  a.prcntje_prtcpcion,
                                  a.cdgo_tpo_rspnsble,
                                  a.id_pais,
                                  a.id_dprtmnto,
                                  a.id_mncpio,
                                  a.drccion
                               from v_si_i_sujetos_responsable a
                               join si_c_sujetos b
                                 on a.id_sjto = b.id_sjto
                              where a.cdgo_clnte = p_cdgo_clnte
                                and a.id_sjto = c_sjtos_archvo.id_sjto
                                and a.id_sjto_impsto = v_id_sjto_impsto
                              group by a.prmer_nmbre,
                                       a.sgndo_nmbre,
                                       a.prmer_aplldo,
                                       a.sgndo_aplldo,
                                       a.cdgo_idntfccion_tpo,
                                       a.idntfccion_rspnsble,
                                       a.prncpal_s_n,
                                       a.prcntje_prtcpcion,
                                       a.cdgo_tpo_rspnsble,
                                       a.id_pais,
                                       a.id_dprtmnto,
                                       a.id_mncpio,
                                       a.drccion) loop
                begin
                  insert into cb_g_procesos_simu_rspnsble
                      (id_prcsos_smu_sjto,
                       cdgo_idntfccion_tpo,
                       idntfccion,
                       prmer_nmbre,
                       sgndo_nmbre,
                       prmer_aplldo,
                       sgndo_aplldo,
                       prncpal_s_n,
                       cdgo_tpo_rspnsble,
                       prcntje_prtcpcion,
                       id_pais_ntfccion,
                       id_dprtmnto_ntfccion,
                       id_mncpio_ntfccion,
                       drccion_ntfccion)
                      values
                      (v_id_prcsos_smu_sjto,
                       c_rspnsbles.cdgo_idntfccion_tpo,
                       c_rspnsbles.idntfccion_rspnsble,
                       c_rspnsbles.prmer_nmbre,
                       c_rspnsbles.sgndo_nmbre,
                       c_rspnsbles.prmer_aplldo,
                       c_rspnsbles.sgndo_aplldo,
                       c_rspnsbles.prncpal_s_n,
                       c_rspnsbles.cdgo_tpo_rspnsble,
                       c_rspnsbles.prcntje_prtcpcion,
                       c_rspnsbles.id_pais,
                       c_rspnsbles.id_dprtmnto,
                       c_rspnsbles.id_mncpio,
                       c_rspnsbles.drccion);
                exception
                  when others then
                    o_cdgo_rspsta := 55;
                    o_mnsje_rspsta := 'Error mientras se intentaba incluir al responsable con identificación #' || c_rspnsbles.idntfccion_rspnsble;
                    continue;
                end;
              end loop;
  
              -- 3. Insertar los movimientos
              for c_mvmntos in (select id_sjto_impsto,
                                       vgncia,
                                       id_prdo,
                                       id_cncpto,
                                       vlor_sldo_cptal,
                                       vlor_intres,
                                       cdgo_clnte,
                                       id_impsto,
                                       id_impsto_sbmpsto,
                                       cdgo_mvmnto_orgn,
                                       id_orgen,
                                       id_mvmnto_fncro
                                    from v_gf_g_cartera_x_concepto
                                    where cdgo_clnte = p_cdgo_clnte
                                      and id_impsto = c_sjtos_archvo.id_impsto
                                    and id_impsto_sbmpsto = c_sjtos_archvo.id_impsto_sbmpsto
                                    and id_sjto_impsto = v_id_sjto_impsto
                                    and vgncia between c_sjtos_archvo.vgncia_dsde and c_sjtos_archvo.vgncia_hsta
                                    and (vlor_sldo_cptal + vlor_intres) > 0
                                    and trunc(fcha_vncmnto) < trunc(sysdate)
                                                          and cdgo_mvnt_fncro_estdo = 'NO'  -- Cartera Normalizada
                                  ) loop
  
                begin
                  insert into cb_g_procesos_smu_mvmnto
                        (id_prcsos_smu_sjto,
                         id_sjto_impsto,
                         vgncia,
                         id_prdo,
                         id_cncpto,
                         vlor_cptal,
                         vlor_intres,
                         cdgo_clnte,
                         id_impsto,
                         id_impsto_sbmpsto,
                         cdgo_mvmnto_orgn,
                         id_orgen,
                         id_mvmnto_fncro)
                      values
                        (v_id_prcsos_smu_sjto,
                         c_mvmntos.id_sjto_impsto,
                         c_mvmntos.vgncia,
                         c_mvmntos.id_prdo,
                         c_mvmntos.id_cncpto,
                         c_mvmntos.vlor_sldo_cptal,
                         c_mvmntos.vlor_intres,
                         c_mvmntos.cdgo_clnte,
                         c_mvmntos.id_impsto,
                         c_mvmntos.id_impsto_sbmpsto,
                         c_mvmntos.cdgo_mvmnto_orgn,
                         c_mvmntos.id_orgen,
                         c_mvmntos.id_mvmnto_fncro);
                exception 
                                  when others then
                                      o_cdgo_rspsta := 55;
                    o_mnsje_rspsta := 'Error mientras se intentaba incluir movimientos de cartera al sujeto #'||v_id_prcsos_smu_sjto;
                    continue;
                end;
              end loop;
                  else
                      o_cdgo_rspsta := 60;
                      o_mnsje_rspsta := 'El sujeto no tiene saldo en cartera #'||c_sjtos_archvo.id_sjto;
          end if;
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
                                join si_c_sujetos d on d.idntfccion = c.idntfccion 
                               where d.id_sjto = a.id_sjto
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
        
        -- Activa sujetos que vinieron en el Excel y Están INACTIVOS en el Lote
        for c_sjtos_archvo in (select d.id_sjto
                                 from v_gn_g_candidatos_carga c
                                 join si_c_sujetos d on d.idntfccion = c.idntfccion
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and exists(select 1
                                              from mc_g_embargos_simu_sujeto j
                                              where j.id_sjto = d.id_sjto
                                                and j.id_embrgos_smu_lte = c.id_lte_prcso
                                                and j.actvo = 'N'
                                                and j.indcdor_prcsdo = 'N')
                              )
        loop
        
            -- Los que esten inactivos pero vinieron en el archivo se vuelven a activar
            update mc_g_embargos_simu_sujeto a
               set a.actvo = 'S'
             where a.id_embrgos_smu_lte = p_id_lte
               and a.id_sjto = c_sjtos_archvo.id_sjto
               and a.indcdor_prcsdo = 'N'
               and a.actvo = 'N';
               
        end loop;
        
        -- INSERTAR en el Lote ... los Nuevos Sujeto que vinieron en el Excel y No estaban en el Lote
        for c_sjtos in (select c.idntfccion, c.vgncia_dsde, c.vgncia_hsta, d.id_sjto, c.id_impsto, c.id_impsto_sbmpsto
                                 from v_gn_g_candidatos_carga c
                                 join si_c_sujetos d on d.idntfccion = c.idntfccion
                                where c.id_prcso_crga = p_id_prcso_crga
                                  and c.id_lte_prcso = p_id_lte
                                  and c.cdgo_prcso = v_cdgo_prcso
                                  and not exists(select 1
                                              from mc_g_embargos_simu_sujeto j
                                              where j.id_sjto = d.id_sjto)
                              ) loop
        
            -- *************************************
            -- incluimos Sujetos
            -- *************************************
            -- Incluir Responsables
            -- Incluir Movimientos Financieros    
            
              -- <Identificar Sujeto Impuesto>
              begin
                select a.id_sjto_impsto into v_id_sjto_impsto
                from si_i_sujetos_impuesto a
                where a.id_impsto = c_sjtos.id_impsto
                  and a.id_sjto = c_sjtos.id_sjto;
                  
                if v_id_sjto_impsto is null then
                  rollback;
                  insert into mc_g_embrgo_cnddtos_no_crgdos(cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta, fcha, obsrvcion)
                  values (p_cdgo_clnte, c_sjtos.idntfccion, c_sjtos.vgncia_dsde, c_sjtos.vgncia_hsta, systimestamp, 'No se pudo identificar el sujeto impuesto asociado al ID SUJETO #'||c_sjtos.id_sjto); commit;
                  continue;
                end if;
              exception
                when others then
                  o_cdgo_rspsta := 35;
                  o_mnsje_rspsta := 'No se pudo identificar el sujeto impuesto asociado al ID SUJETO #'||c_sjtos.id_sjto;
                  continue;
              end;
              -- FIN <Identificar Sujeto Impuesto>
              
              -- <Validar cartera>
              -- Validar si presenta saldo en el rango de vigencias indicado
              -- En la cartera vencida.
              begin
                select nvl(sum(vlor_sldo_cptal+vlor_intres),0) into v_sldo_ttal_crtra
                from v_gf_g_cartera_x_concepto
                where cdgo_clnte = p_cdgo_clnte
                  and id_impsto = c_sjtos.id_impsto
                  and id_impsto_sbmpsto = c_sjtos.id_impsto_sbmpsto
                  and id_sjto_impsto = v_id_sjto_impsto
                  and vgncia between c_sjtos.vgncia_dsde and c_sjtos.vgncia_hsta
                  and trunc(fcha_vncmnto) < trunc(sysdate);
              exception
                when others then
                  o_cdgo_rspsta := 40;
                  o_mnsje_rspsta := 'Error al validar saldo en cartera.';
                  continue;
              end;
              -- FIN <Validar cartera>
              
              -- Si saldo en cartera es mayor a cero (Cartera > 0), entonces...
              if v_sldo_ttal_crtra > 0 then
      
                  -- Si ya existe un lote, entonces, se incluyen los sujetos, los responsables y los movimientos.
                  -- 1. Incluir sujeto
                  begin
                    insert into mc_g_embargos_simu_sujeto(id_embrgos_smu_lte,
                                        id_sjto,
                                        vlor_ttal_dda,
                                        fcha_ingrso,
                                        indcdor_prcsdo)
                    values(p_id_lte,
                         c_sjtos.id_sjto,
                         v_sldo_ttal_crtra,
                         sysdate,
                         'N')
                    returning id_embrgos_smu_sjto into v_id_embrgos_smu_sjto;
                   
                  exception
                    when others then
                      rollback;
                      o_cdgo_rspsta := 50;
                      o_mnsje_rspsta := 'Error al intentar incluir sujeto en el lote de selección.';
                      insert into mc_g_embrgo_cnddtos_no_crgdos(cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta, fcha, obsrvcion)
                        values (p_cdgo_clnte, c_sjtos.idntfccion, c_sjtos.vgncia_dsde, c_sjtos.vgncia_hsta, systimestamp, o_cdgo_rspsta || ' ' || o_mnsje_rspsta); commit;
                      continue;
                  end;
                  
                  -- 2. Incluir responsables
                  for c_rspnsbles in (select a.prmer_nmbre,
                                a.sgndo_nmbre,
                                a.prmer_aplldo,
                                a.sgndo_aplldo,
                                a.cdgo_idntfccion_tpo,
                                a.idntfccion_rspnsble,
                                a.prncpal_s_n,
                                a.prcntje_prtcpcion,
                                a.cdgo_tpo_rspnsble,
                                a.id_pais,
                                a.id_dprtmnto,
                                a.id_mncpio,
                                a.drccion
                             from v_si_i_sujetos_responsable a
                             join si_c_sujetos b
                               on a.id_sjto = b.id_sjto
                            where a.cdgo_clnte = p_cdgo_clnte
                              and a.id_sjto = c_sjtos.id_sjto
                              and a.id_sjto_impsto = v_id_sjto_impsto
                            group by a.prmer_nmbre,
                                 a.sgndo_nmbre,
                                 a.prmer_aplldo,
                                 a.sgndo_aplldo,
                                 a.cdgo_idntfccion_tpo,
                                 a.idntfccion_rspnsble,
                                 a.prncpal_s_n,
                                 a.prcntje_prtcpcion,
                                 a.cdgo_tpo_rspnsble,
                                 a.id_pais,
                                 a.id_dprtmnto,
                                 a.id_mncpio,
                                 a.drccion)
                  loop
                    begin
                      insert into mc_g_embargos_simu_rspnsble
                          (id_embrgos_smu_sjto,
                           cdgo_idntfccion_tpo,
                           idntfccion,
                           prmer_nmbre,
                           sgndo_nmbre,
                           prmer_aplldo,
                           sgndo_aplldo,
                           prncpal_s_n,
                           cdgo_tpo_rspnsble,
                           prcntje_prtcpcion,
                           id_pais_ntfccion,
                           id_dprtmnto_ntfccion,
                           id_mncpio_ntfccion,
                           drccion_ntfccion)
                          values
                          (v_id_embrgos_smu_sjto,
                           c_rspnsbles.cdgo_idntfccion_tpo,
                           c_rspnsbles.idntfccion_rspnsble,
                           c_rspnsbles.prmer_nmbre,
                           c_rspnsbles.sgndo_nmbre,
                           c_rspnsbles.prmer_aplldo,
                           c_rspnsbles.sgndo_aplldo,
                           c_rspnsbles.prncpal_s_n,
                           c_rspnsbles.cdgo_tpo_rspnsble,
                           c_rspnsbles.prcntje_prtcpcion,
                           c_rspnsbles.id_pais,
                           c_rspnsbles.id_dprtmnto,
                           c_rspnsbles.id_mncpio,
                           c_rspnsbles.drccion);
                           null;
                    exception
                      when others then
                        rollback;
                        o_cdgo_rspsta := 55;
                        o_mnsje_rspsta := 'Error mientras se intentaba incluir al responsable con identificación #'||c_rspnsbles.idntfccion_rspnsble;
                        insert into mc_g_embrgo_cnddtos_no_crgdos(cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta, fcha, obsrvcion)
                        values (p_cdgo_clnte, c_sjtos.idntfccion, c_sjtos.vgncia_dsde, c_sjtos.vgncia_hsta, systimestamp, o_cdgo_rspsta || ' ' || o_mnsje_rspsta); commit;
                    end;
                  end loop;
      
                  -- 3. Insertar los movimientos
                  for c_mvmntos in (select id_sjto_impsto,
                               vgncia,
                               id_prdo,
                               id_cncpto,
                               vlor_sldo_cptal,
                               vlor_intres,
                               cdgo_clnte,
                               id_impsto,
                               id_impsto_sbmpsto,
                               cdgo_mvmnto_orgn,
                               id_orgen,
                               id_mvmnto_fncro
                            from v_gf_g_cartera_x_concepto
                            where cdgo_clnte = p_cdgo_clnte
                              and id_impsto = c_sjtos.id_impsto
                            and id_impsto_sbmpsto = c_sjtos.id_impsto_sbmpsto
                            and id_sjto_impsto = v_id_sjto_impsto
                            and vgncia between c_sjtos.vgncia_dsde and c_sjtos.vgncia_hsta
                            and (vlor_sldo_cptal + vlor_intres) > 0
                            and trunc(fcha_vncmnto) < trunc(sysdate)
                          )
                  loop
      
                    begin
                      insert into mc_g_embargos_smu_mvmnto
                            (id_embrgos_smu_sjto,
                             id_sjto_impsto,
                             vgncia,
                             id_prdo,
                             id_cncpto,
                             vlor_cptal,
                             vlor_intres,
                             cdgo_clnte,
                             id_impsto,
                             id_impsto_sbmpsto,
                             cdgo_mvmnto_orgn,
                             id_orgen,
                             id_mvmnto_fncro)
                          values
                            (v_id_embrgos_smu_sjto,
                             c_mvmntos.id_sjto_impsto,
                             c_mvmntos.vgncia,
                             c_mvmntos.id_prdo,
                             c_mvmntos.id_cncpto,
                             c_mvmntos.vlor_sldo_cptal,
                             c_mvmntos.vlor_intres,
                             c_mvmntos.cdgo_clnte,
                             c_mvmntos.id_impsto,
                             c_mvmntos.id_impsto_sbmpsto,
                             c_mvmntos.cdgo_mvmnto_orgn,
                             c_mvmntos.id_orgen,
                             c_mvmntos.id_mvmnto_fncro);
                    exception when others then
                      rollback;
                      o_cdgo_rspsta := 55;
                      o_mnsje_rspsta := 'Error mientras se intentaba incluir movimientos de cartera al sujeto #'||v_id_embrgos_smu_sjto;
                      commit;
                      insert into mc_g_embrgo_cnddtos_no_crgdos(cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta, fcha, obsrvcion)
                      values (p_cdgo_clnte, c_sjtos.idntfccion, c_sjtos.vgncia_dsde, c_sjtos.vgncia_hsta, systimestamp, o_cdgo_rspsta || ' ' || o_mnsje_rspsta); 
                    end;
                  end loop;
              else
                rollback;
                o_cdgo_rspsta := 60;
                o_mnsje_rspsta := 'El sujeto no tiene saldo en cartera #'||c_sjtos.id_sjto;
                insert into mc_g_embrgo_cnddtos_no_crgdos(cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta, fcha, obsrvcion)
                values (p_cdgo_clnte, c_sjtos.idntfccion, c_sjtos.vgncia_dsde, c_sjtos.vgncia_hsta, systimestamp, o_cdgo_rspsta || ' ' || o_mnsje_rspsta);    commit;
              end if;
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