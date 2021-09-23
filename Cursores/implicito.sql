-- Cursor implicito cuando la consulta devuelve una sola fila
DECLARE
  id eba_demo_ig_emp.empno%type;
  name eba_demo_ig_emp.ename%type;
  job eba_demo_ig_emp.job%type;
BEGIN
  select empno, ename, job into id, name, job 
  from eba_demo_ig_emp
  where empno = 7839;
  dbms_output.put_line('Id: ' || id || ', nombre: ' || name || ', puesto: ' || job);
END;

-- Cursor implicito cuando la consulta devuelve mas de una sola fila
DECLARE
  TYPE idTable IS TABLE OF eba_demo_ig_emp.empno%type; -- se crean los tipos de tabla donde se guardaran los resultados de la consulta
  TYPE nameTable IS TABLE OF eba_demo_ig_emp.ename%type;
  TYPE jobTable IS TABLE OF eba_demo_ig_emp.job%type;
 
  id idTable; -- se definen las variables del tipo de tabla que guardaran
  name nameTable;
  job jobTable;
BEGIN
  --Consulta que devuelve mas de una fila
  select empno, ename, job bulk collect into id, name, job 
  from eba_demo_ig_emp;

  for i in id.first..id.last loop
      dbms_output.put_line('Id: ' || id(i) || ', nombre: ' || name(i) || ', puesto: ' || job(i));
  end loop;
  
END;