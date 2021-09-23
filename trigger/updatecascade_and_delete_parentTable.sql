create or replace trigger dept_set_null_or_new_deptno
  after delete or update of deptno on eba_demo_da_dept
  for each row
  -- Antes de que se elimine la fila del departamento o se actualice la clave principal (DEPTNO) del departamento, 
  -- establezca todos los valores de clave externa dependientes correspondientes en emp en NULL:

begin
  if updating and :old.deptno != :new.deptno then
    update eba_demo_da_emp set deptno = :new.deptno where deptno = :old.deptno;
  elsif deleting then
    update eba_demo_da_emp set deptno = null where deptno = :old.deptno;
  end if;
end;

update eba_demo_da_dept set deptno = 10 where deptno = 13;