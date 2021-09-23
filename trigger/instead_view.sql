/* se crea una vista donde se muestra los empleados ordenados por departamento */
create or replace view order_emp_dept as
  select e.empno, e.ename, e.job, e.hiredate, e.sal, d.deptno, d.dname, d.loc
  from eba_demo_da_emp e
  inner join eba_demo_da_dept d on e.deptno = d.deptno
  order by d.loc;

/* Se crea un trigger que se ejecutara cuando se inserte una fila en la vista 
  order_emp_dept y insertara esa fila en las tabla empleado y departamento */
create or replace trigger order_info 
  instead of insert on order_emp_dept
declare
  duplicate_info exception;
  pragma exception_init (duplicate_info, -00001);
begin
  insert into eba_demo_da_dept (deptno, dname, loc) 
  values (:new.deptno, :new.dname, :new.loc);
  
  insert into eba_demo_da_emp (empno, ename, job, hiredate, sal)
  values (:new.empno, :new.ename, :new.job, :new.hiredate, :new.sal);
  
  exception
    when duplicate_info then
      raise_application_error (
        num => -20107,
        msg => 'Duplicate empleado or department ID.'
      );
end order_info;

insert into order_emp_dept 
values (7940, 'MICHAEL', 'SOPORTE', to_date(SYSDATE, 'DD,MM,YYYY'), 8000, 91, 'VENTAS', 'BRASIL');

delete eba_demo_da_emp where empno = 7940;

delete eba_demo_da_dept where empno = 91;