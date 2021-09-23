create or replace trigger dept_restrict
    before delete or update of deptno on eba_demo_da_dept
    for each row
    -- Antes de que se elimine la fila del departamento o se actualice la clave principal (DEPTNO) del departamento, 
    -- comprobar los valores de clave externa dependientes en emp; 
    -- si encuentra alguno, retroceda.

declare
    dummy integer; -- Usar para buscar cursor
    emp_present exception;
    emp_not_present exception;
    PRAGMA EXCEPTION_INIT (emp_present, -4094);
    PRAGMA EXCEPTION_INIT (emp_not_present, -4095);
    
    -- Cursor utilizado para verificar los valores de clave externa dependientes.
    cursor dummy_cursor (dn number) is
        select deptno from eba_demo_da_emp where deptno = dn;
        
begin
    open dummy_cursor (:old.deptno);
    fetch dummy_cursor into dummy;
    -- Si se encuentra una clave externa dependiente, aumente la especificada por el usuario 
    -- código de error y mensaje. Si no lo encuentra, cierre el cursor 
    -- antes de permitir que se complete la declaración de activación.
    if dummy_cursor%notfound then
        raise emp_not_present;
    else 
        raise emp_present;
    end if;
    close dummy_cursor;
    
    exception 
     when emp_present then
        close dummy_cursor;
        raise_application_error(-20001, 'Employees Present in ' || ' Department ' || to_char(:old.deptno));
    when emp_not_present then
        close dummy_cursor;
end;

update eba_demo_da_dept set deptno = 11 where deptno = 10;