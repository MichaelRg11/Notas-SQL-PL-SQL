-- trogger compuesto
-- se crea la tabla donde se insertaran los datos
drop table eba_demo_da_emp_sal;

create table eba_demo_da_emp_sal (
  empno number not null,
  change_date date not null,
  sal number(8, 2) not null,
  constraint pk_eba_demo_da_emp_sal primary key (empno, change_date),
  constraint fk_eba_demo_da_emp_sal foreign key (empno) 
    references eba_demo_da_emp (empno)
);

-- trigger compuesto
create or replace trigger maintain_emp_sal
  for update of sal on eba_demo_da_emp
    compound trigger
      
  -- parte declarativa:
  -- Se elige un valor de umbral pequeño para mostrar cómo funciona el ejemplo:
  threshhold constant simple_integer := 3;
  
  type salaries_t is table of eba_demo_da_emp_sal%rowtype index by simple_integer;
  salaries salaries_t;
  idx simple_integer := 0;
  
  procedure flush_array is
    n constant simple_integer := salaries.count();
  begin
  forall j in 1..n
    insert into eba_demo_da_emp_sal values salaries(j);
  salaries.delete();
  idx := 0;
  dbms_output.put_line('Flushed ' || n || ' rows');
  end flush_array;
  
  -- AFTER EACH ROW Section:
  after each row is
  begin
    idx := idx + 1;
    salaries(idx).empno := :new.empno;
    salaries(idx).change_date := systimestamp;
    salaries(idx).sal := :new.sal;
    if idx >= threshhold then
      flush_array();
    end if;
  end after each row;
  
  -- AFTER STATEMENT Section:
  after statement is
  begin
    flush_array();
  end after statement;
end maintain_emp_sal;

-- Acciones
update eba_demo_da_emp set sal = sal * 1.2 where deptno = 30;

select * from eba_demo_da_emp_sal;

select * from eba_demo_da_emp;