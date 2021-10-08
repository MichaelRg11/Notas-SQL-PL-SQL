-- Valida paquetes descompilados
select case
        when object_type like 'PACKAGE BODY%' then
          'alter package ' || object_name || ' compile body;'
        else
          'alter ' || object_type || ' ' || object_name || ' compile;'
        end sentencia
from user_objects where status like 'INV%';

--Crear un JOB
begin
DBMS_SCHEDULER.CREATE_JOB (
  job_name  => 'IT_GI_G_CREA_DETRMINACIONES',
  job_type  => 'STORED_PROCEDURE',
  job_action  => 'PKG_GI_DETERMINACION.PRC_EJ_JOB_DETERMINACION',
  number_of_arguments => 0,
  start_date => NULL,
  repeat_interval => NULL,
  end_date => NULL,
  enabled => FALSE,
  auto_drop => FALSE,
  comments => ''
);
end;