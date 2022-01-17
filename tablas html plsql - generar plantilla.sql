declare 
  v_tabla clob;
begin
  
  v_tabla := '<table align="center" border="1" style="border-collapse:collapse">
                <tr>
                  <th>Concepto</th>
                  <th>Vigencia</th>
                  <th>Capital</th>
                  <th>Interes</th>
                  <th>Total</th>
                </tr>';
  for c_pago in (select a.dscrpcion,
                         a.vgncia ||'-'||a.prdo prdo,
                         to_char(a.vlor_cptal,'FM$999G999G999G999G999G999G990')  as vlor_cptal,
                         to_char(a.vlor_intres,'FM$999G999G999G999G999G999G990') as vlor_intres,
                         to_char(a.vlor_ttal,'FM$999G999G999G999G999G999G990')   as vlor_ttal,
                         initcap(pkg_gn_generalidades.fnc_number_to_text(trunc(nvl(a.vlor_ttal,0)), 'd')) vlor_ttal_ltras_cnvnio
                    from v_gf_g_convenios_cartera a
                   where id_cnvnio =  pkg_gn_generalidades.fnc_ca_extract_value( p_xml => :F_APP_XML, p_nodo => 'ID_CNVNIO')) loop
         
    v_tabla := v_tabla  || '<tr>
                              <td>' || c_pago.dscrpcion || '</td>
                              <td>' || c_pago.prdo || '</td>
                              <td>' || c_pago.vlor_cptal || '</td>
                              <td>' || c_pago.vlor_intres || '</td>
                              <td>' || c_pago.vlor_ttal || '</td>
                            </tr>';       
  end loop;
  
  v_tabla := v_tabla || '</table>';
  --return v_tabla;
  dbms_output.put_line(v_tabla);
end;

-- Generar plantilla

declare
  v_clob clob;
  v_id_plantilla number;
begin
  v_id_plantilla := 13;

  v_clob := pkg_gn_generalidades.fnc_ge_dcmnto('<F_CDGO_CLNTE>70</F_CDGO_CLNTE>
                                                <ID_CNVNIO>26</ID_CNVNIO>', v_id_plantilla);
  if v_clob is null then
    dbms_output.put_line('No se ha generado la plantilla');
  else  
    insert into muerto (v_001, c_001) values ('v_clob', v_clob); commit;
  end if;
end;