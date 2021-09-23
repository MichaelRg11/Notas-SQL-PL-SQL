create or replace trigger check_emp_sal_raise
  for update of sal on eba_demo_da_emp
    compound trigger

  ten_percent constant number := 0.2;
  type salaries_t is table of eba_demo_da_emp.sal%type;
  avg_salaries salaries_t;
  type department_ids_t is table of eba_demo_da_emp.deptno%type;
  department_ids department_ids_t;
    
  -- Declaracion de tipo de coleccion y variable:
  type department_sal_t is table of eba_demo_da_emp.sal%type index by varchar2(80);
  deparment_avg_sal department_sal_t;
    
  before statement is
    begin
      select avg(e.sal), nvl(e.deptno, -1) bulk collect into avg_salaries, department_ids
        from eba_demo_da_emp e
        group by e.deptno;
      for j in 1..department_ids.count() loop
        deparment_avg_sal(department_ids(j)) := avg_salaries(j);
      end loop;
  end before statement;
  
  after each row is
    begin
    if :new.sal - :old.sal > ten_percent*deparment_avg_sal(:new.deptno) then
      raise_application_error(-20000, 'Raise too big');
    end if;
  end after each row;
end check_emp_sal_raise;

update eba_demo_da_emp set sal = sal * 1.1 where deptno = 30;