-- Cursores explicitos
DECLARE
  -- Deficniendo una variable del tipo de la tabla para tener todas los datos en una misma variable
  res eba_demo_ig_people%rowtype;
  CURSOR c1 RETURN EBA_DEMO_IG_PEOPLE%ROWTYPE;    -- Declaracion del cursor c1

  CURSOR c1 RETURN EBA_DEMO_IG_PEOPLE%ROWTYPE IS  -- Definicion del cursor 1,
    SELECT * FROM eba_demo_ig_people              -- repeating return type
    WHERE from_yr between '1900' and '1910';

  -- Definiendo una variable para cada tipo de dato que trae la consulta
  id eba_demo_ig_people.id%type;
  from_yr eba_demo_ig_people.from_yr%type;
  name eba_demo_ig_people.name%type;
  CURSOR c2 IS                             -- Declaracion y definicion del cursor 2
    SELECT id, name, from_yr FROM EBA_DEMO_IG_PEOPLE
    where from_yr between '1840' and '1850'; 
 
  -- Definiendo una variable para cada tipo de dato que trae la consulta
  id eba_demo_ig_people.id%type;
  from_yr eba_demo_ig_people.from_yr%type;
  name eba_demo_ig_people.name%type;
  CURSOR c3 RETURN EBA_DEMO_IG_PEOPLE%ROWTYPE;      -- Declaracion del cursor c3
 
  CURSOR c3 IS                             -- Definicion del cursor c3,
    SELECT  id, name, from_yr FROM eba_demo_ig_people       -- Omitiondo return de del tipo
    WHERE from_yr = '1900';
BEGIN
    open c2; 
    dbms_output.put_line('--------------------');
    dbms_output.put_line('Cursor 2');
    dbms_output.put_line('--------------------');
    loop 
        fetch c2 into id, name, from_yr;
        exit when c2%notfound;
        dbms_output.put_line('Id: ' || id || ', Name: ' || name  || ', year: ' || from_yr);
    end loop;
    close c2;
    
    open c1; 
    dbms_output.put_line('--------------------');
    dbms_output.put_line('Cursor 1');
    dbms_output.put_line('--------------------');
    loop 
        fetch c1 into res;
        exit when c1%notfound;
        dbms_output.put_line('Id: ' || res.id || ', Name: ' || res.name || ', year: ' || res.from_yr);
    end loop;
    close c1;
    
    open c3; 
    dbms_output.put_line('--------------------');
    dbms_output.put_line('Cursor 3');
    dbms_output.put_line('--------------------');
    loop 
        fetch c3 into id;
        fetch c3 into name;
        fetch c3 into from_yr;
        exit when c3%notfound;
        dbms_output.put_line('Id: ' || id || ', Name: ' || name || ', country: ' || country);
    end loop;
    close c3;
END;

-- Diferente manera que abceder a los datos del cursor
declare
  TYPE idTable IS TABLE OF eba_demo_ig_emp.empno%type; -- se crean los tipos de tabla donde se guardaran los resultados de la consulta
  TYPE nameTable IS TABLE OF eba_demo_ig_emp.ename%type;
  TYPE jobTable IS TABLE OF eba_demo_ig_emp.job%type;
 
  id idTable; -- se definen las variables del tipo de tabla que guardaran
  name nameTable;
  job jobTable;
  c1 sys_refcursor;
BEGIN
  open c1 for select empno, ename, job from eba_demo_da_emp;
  fetch c1 bulk collect into id, name, job;
  close c1;
  
  FOR i IN id.FIRST .. id.LAST
  LOOP
    dbms_output.put_line('Id: ' || id(i) || ', Name: ' || name(i)  || ', puesto: ' || job(i));
  END LOOP;
END;