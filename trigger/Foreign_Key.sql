create or replace trigger emp_dept_check
  before insert or update of deptno on eba_demo_da_emp
  for each row when (new.deptno is not null)
  
  -- Antes de que se inserte la fila o se actualice DEPTNO en la tabla emp,
  -- active este disparador para verificar ese nuevo valor de clave externa (DEPTNO)
  -- está presente en la tabla de departamentos.
  declare
    Dummy               INTEGER;  -- Use for cursor fetch
    Invalid_department  EXCEPTION;
    Valid_department    EXCEPTION;
    Mutating_table      EXCEPTION;
    PRAGMA EXCEPTION_INIT (Invalid_department, -4093);
    PRAGMA EXCEPTION_INIT (Valid_department, -4092);
    PRAGMA EXCEPTION_INIT (Mutating_table, -4091); 

  -- Cursor utilizado para verificar que existe el valor de la clave principal. 
  -- Si está presente, bloquee la fila de la clave principal para que no se pueda eliminar 
  -- por otra transacción hasta que esta transacción sea - comprometido o revertido.
  cursor dummy_cursor (dn number) is
    select deptno from eba_demo_da_dept
    where deptno = dn
    for update of deptno;
      
begin
  open dummy_cursor (:new.deptno);
  fetch dummy_cursor into dummy;
  -- Verificar la clave principal. 
  -- Si no se encuentra, genere el código y el mensaje de error especificados por el usuario. 
  -- Si lo encuentra, cierre el cursor antes de permitir que se complete la declaración de activación:
  if dummy_cursor%notfound then
    raise invalid_department;
  else
    close dummy_cursor;
  end if;
  exception
    when invalid_department then
      close dummy_cursor;
      raise_application_error(-20000, 'invalid department' || ' Number ' || to_char(:new.deptno));
    when valid_department then
      close dummy_cursor;
    when mutating_table then
      null;
end;

update eba_demo_da_emp set deptno = 13 where deptno = 10;