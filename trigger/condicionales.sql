create or replace trigger tri_emp 
before 
    insert or
    update of sal, hiredate or 
    delete
on eba_demo_da_emp
begin
    case 
        when inserting then
            dbms_output.put_line('Se inserto una nueva fila');
        when updating('sal') then
            dbms_output.put_line('Se actualizao la columna salario');
        when updating('hiredate') then
            dbms_output.put_line('Se actualizao la columna fecha de nacimiento ');
        when deleting then
            dbms_output.put_line('Se ha eliminado una fila');
    end case;
end;

insert into eba_demo_da_emp values (7940, 'Michael', 'SOPORTE', NULL, '22/11/1998', 6000, NULL, 10);

update eba_demo_da_emp set sal=7000 where empno = 7940;

update eba_demo_da_emp set hiredate = '22/11/1999' where empno = 7940;

delete eba_demo_da_emp where empno = 7940;

-- Condicion para saber si se debe ejecutar el trigger
create or replace trigger print_salary_change
    before delete or insert or update on eba_demo_da_emp
    for each row
    when (new.job <> 'MANAGER')

declare 
    sal_diff number;
begin
    sal_diff := :new.sal - :old.sal;
    dbms_output.put_line(:new.ename);
    dbms_output.put_line('Old salary: ' || :old.sal || ', ');
    dbms_output.put_line('New salary' || :new.sal || ', ');
    dbms_output.put_line('Difference: ' || sal_diff);
end;

update eba_demo_da_emp set sal = sal * 1.1 where empno = 7782