create or replace trigger dept_set_null_or_new_deptno
    after delete on eba_demo_da_dept
    for each row
   
   -- Antes de que se elimine la fila del departamento, 
   -- eliminar todas las filas de la tabla emp cuyo DEPTNO es el mismo que 
   -- DEPTNO se elimina de la tabla de departamentos:

begin
    delete from eba_demo_emp where deptno = :old.deptno;
end;