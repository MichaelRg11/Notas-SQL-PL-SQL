declare 
  v_archivo   utl_file.file_type;
  v_offset    number;
  v_length    number; 
 
begin                        
  v_archivo := utl_file.fopen('LOGS',p_file_name,'WB', 32767);
  v_offset  := 1;
  v_length  := dbms_lob.getlength(p_file_blob);        
  loop
      exit when v_offset > v_length;
      utl_file.put_raw(v_archivo, dbms_lob.substr(p_file_blob, 32767, v_offset));
      v_offset := v_offset + 32767;
  end loop;
  utl_file.fclose(v_archivo);
end;

declare

lfi_file utl_file.file_type;

Begin
select * from gd_g_documentos
where id_dcmnto  = 141;
— se crea el archivo para escritura.

lfi_file:= utl_file.fopen(‘MI_RUTA’, ‘mi_archivo.pdf, ‘w’);

— se escriben datos en el archivo

utl_file.put_line(lfi_file, ’inicio de mi proceso: ’||to_char(sysdate));

— se ejecuta el proceso

Mi_proceso(123);

utl_file.put_line(lfi_file, ’termino de mi proceso: ’||to_char(sysdate));

— se cierra el archivo

utl_file.fclose(lfi_file);

End;