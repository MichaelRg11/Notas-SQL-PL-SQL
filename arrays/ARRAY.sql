-- ARRAYS 
DECLARE
  -- Associative array indexed by string:
  
  TYPE population IS TABLE OF NUMBER  -- Associative array type
    INDEX BY VARCHAR2(64);            --  indexed by string
  
  city_population population;        -- Associative array variable
  i VARCHAR2(64);                    -- Scalar variable
  
BEGIN
  -- Add elements (key-value pairs) to associative array:
 
  city_population('Smallville') := 2000;
  city_population('Midland') := 750000;
  city_population('Megalopolis') := 1000000;
 
  -- Change value associated with key 'Smallville':
 
  city_population('Smallville') := 2001;
 
  -- Print associative array:
 
  i := city_population.FIRST;  -- primer elemento del array
  -- i := city_population.LAST;  -- ultimo elemento del array
 
  DBMS_Output.PUT_LINE('count value => ' || city_population.count()); -- cantidad de elementos

  WHILE i IS NOT NULL LOOP
    DBMS_Output.PUT_LINE
      ('Population of ' || i || ' is ' || city_population(i));
    i := city_population.NEXT(i);  -- proximo elemento del array
    -- i := city_population.PRIOR(i);  -- anterior elemento del array
  END LOOP;
END;

-- 
DECLARE
  TYPE idTable IS TABLE OF eba_demo_ig_emp.empno%type;
  TYPE nameTable IS TABLE OF eba_demo_ig_emp.ename%type;
  TYPE jobTable IS TABLE OF eba_demo_ig_emp.job%type;
 
  id idTable;
  name nameTable;
  job jobTable;
BEGIN
    select empno, ename, job bulk collect into id, name, job 
    from eba_demo_ig_emp;
    for i in id.first..id.last loop
        dbms_output.put_line('Id: ' || id(i) || ', nombre: ' || name(i) || ', puesto: ' || job(i));
    end loop;
END;

select replace(:a,substr(:a,instr(:a,'@') - :b, :b), (
                                                        select listagg(crcter, '')
                                                          from (
                                                                    select '*' as crcter
                                                                      from dual
                                                                   connect by level <= :b
                                                               )
                                                     )
       ) as email
  from dual;