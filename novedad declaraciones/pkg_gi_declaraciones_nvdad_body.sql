create or replace package body pkg_gi_declaraciones_nvdad as

	procedure prc_rg_dclrcion_nvdad (p_id_dclrcion number
                                 , p_id_dclrcion_vgncia_frmlrio_ant number
                                 , p_vgncia_antrior number
                                 , p_id_prdo_antrior number
                                 , p_id_dclrcion_vgncia_frmlrio_nvo number
                                 , p_vgncia_nvo number
                                 , p_id_prdo_nvo number
                                 , p_id_nvdad_tpo number
                                 , o_id_nvdad out number
                                 , o_mnsje_rspsta out varchar2
                                 , o_cdgo_rspsta out number) as
  v_id_nvdad number;
  v_sqlerrm varchar2(2000);
  begin
		insert into gi_g_dclrcnes_nvdad(id_dclrcion, id_nvdad_tpo, fcha_nvdad) 
      values(p_id_dclrcion, p_id_nvdad_tpo, systimestamp)
      return id_nvdad into v_id_nvdad;

    insert into gi_g_dclrcnes_nvdad_dtlle(id_nvdad, id_dclrcion_vgncia_frmlrio_ant, vgncia_antrior, id_prdo_antrior, id_dclrcion_vgncia_frmlrio_nvo, vgncia_nvo, id_prdo_nvo) 
      values(v_id_nvdad, p_id_dclrcion_vgncia_frmlrio_ant, p_vgncia_antrior, p_id_prdo_antrior, p_id_dclrcion_vgncia_frmlrio_nvo, p_vgncia_nvo, p_id_prdo_nvo);

    o_id_nvdad := v_id_nvdad;

    o_mnsje_rspsta := 'Novedad insertada con exito';
    o_cdgo_rspsta := 0;
    commit;
    exception
      when others then
        v_sqlerrm := sqlerrm;
        o_mnsje_rspsta := 'No se ha registrado la novedad. ' || v_sqlerrm || '.';
        o_cdgo_rspsta := 10;
        rollback;
	end prc_rg_dclrcion_nvdad;
  
  procedure prc_ap_dclrcion_nvdad_vgncia(p_id_nvdad number
                                       , p_cdgo_clnte number
                                       , o_mnsje_rspsta out varchar2
                                       , o_cdgo_rspsta out number)
  as
  v_id_dclrcion             number;
  v_id_dclrcion_tpo_vgncia  number;
  v_vgncia                  number;
  v_id_prdo                 number;
  v_id_rcdo                 number;
  v_id_lqdcion              number;
  v_id_sjto_impsto          number;
  v_sqlerrm                 varchar2(2000);
  begin
    -- Se optienen los datos de la novedad.
    select a.id_dclrcion, b.id_dclrcion_vgncia_frmlrio_nvo, b.vgncia_nvo, b.id_prdo_nvo
      into v_id_dclrcion, v_id_dclrcion_tpo_vgncia, v_vgncia, v_id_prdo
    from gi_g_dclrcnes_nvdad a
    join gi_g_dclrcnes_nvdad_dtlle b on a.id_nvdad = b.id_nvdad
    where a.id_nvdad = p_id_nvdad;
    
    /* Se actualiza la declaracion y se retorna el id recaudo 
       y el id liquidacion si existe para hacerles el cambio de vigencia y periodo. */
    update gi_g_declaraciones 
    set id_dclrcion_vgncia_frmlrio = v_id_dclrcion_tpo_vgncia
      , vgncia = v_vgncia
      , id_prdo = v_id_prdo
    where id_dclrcion = v_id_dclrcion
    return id_rcdo, id_lqdcion, id_sjto_impsto into v_id_rcdo, v_id_lqdcion, v_id_sjto_impsto;
    
    -- Se actualiza los movimientos finaciero y detalles de la declaracion por medio del id origen.
    update gf_g_movimientos_financiero
    set vgncia = v_vgncia
      , id_prdo = v_id_prdo
    where id_orgen = v_id_dclrcion;
    
    update gf_g_movimientos_detalle
    set vgncia = v_vgncia
      , id_prdo = v_id_prdo
    where id_orgen = v_id_rcdo;
    
    -- Se actualiza la liquidacion de la declaracion por medio del id liquidacion  
    if v_id_rcdo is not null then 
      update gi_g_liquidaciones
      set vgncia = v_vgncia
        , id_prdo = v_id_prdo
      where id_lqdcion = v_id_lqdcion;
    end if;
    
    pkg_gf_movimientos_financiero.prc_ac_concepto_consolidado(p_cdgo_clnte               => p_cdgo_clnte
                                                            , p_id_sjto_impsto           => v_id_sjto_impsto
                                                            , p_ind_ejc_ac_dsm_pbl_pnt	 => 'N' 
                                                            , p_ind_brrdo_sjto_impsto	   => 'S' ); 
          
          
    o_mnsje_rspsta := 'Novedad insertada con exito';
    o_cdgo_rspsta := 0;
    commit;
    
    exception
      when others then
        v_sqlerrm := sqlerrm;
        o_mnsje_rspsta := 'No se ha podido aplicar la novedad. ' || v_sqlerrm || '.';
        o_cdgo_rspsta := 10;
        rollback;                                               
  end prc_ap_dclrcion_nvdad_vgncia;
  
  procedure pr_ac_dclrcion_nvdad (p_id_nvdad number
                                , p_stado_nvdad varchar2
                                , p_cdgo_clnte number
                                , o_mnsje_rspsta out varchar2
                                , o_cdgo_rspsta out number)
  as
  v_flas_afctdas number;
  v_sqlerrm      varchar2(2000);
  begin
    -- Actualizamos la novedad con el estado que se le agregara, aplicada o cancelada.
    update gi_g_dclrcnes_nvdad
    set cdgo_estdo = p_stado_nvdad
    where id_nvdad = p_id_nvdad;
    
    -- filas afectadas por el update.
    v_flas_afctdas := sql%rowcount;
    
    -- Si se actualiza la novedad y se va aplicar se lanca el proceso que actualiza la vigencia en las tablas respectivas.
    if v_flas_afctdas = 1 and p_stado_nvdad = 'AP' then
      prc_ap_dclrcion_nvdad_vgncia(p_id_nvdad       => p_id_nvdad
                                 , p_cdgo_clnte     => p_cdgo_clnte
                                 , o_mnsje_rspsta   => o_mnsje_rspsta
                                 , o_cdgo_rspsta    => o_cdgo_rspsta);
    elsif v_flas_afctdas = 1 and p_stado_nvdad = 'CN' then
      o_mnsje_rspsta := 'La novedad se ha cancelado con exito.';
      o_cdgo_rspsta := 0;
    else
      o_mnsje_rspsta := 'No se ha podido actualizar la novedad.';
      o_cdgo_rspsta := 10;
    end if;
    
    -- Sino ocurrio ningun error en el proceso se hace commit de lo contrario se hace un roolback.
    if o_cdgo_rspsta <> 0 then
      rollback;
    else
      commit;
    end if;
    
    exception
      when others then
        v_sqlerrm := sqlerrm;
        o_mnsje_rspsta := 'No se ha podido actualizar la novedad. ' || v_sqlerrm || '.';
        o_cdgo_rspsta := 10;
        rollback;         
  end pr_ac_dclrcion_nvdad;

end pkg_gi_declaraciones_nvdad;