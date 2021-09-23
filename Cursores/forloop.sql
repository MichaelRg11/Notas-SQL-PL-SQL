DECLARE
BEGIN
  for item in (select * from eba_demo_ig_emp) loop
    dbms_output.put_line('Id: ' || item.empno || ', nombre: ' || item.ename);
  end loop;
END;

DECLARE
  cursor c1 is select * from eba_demo_ig_emp;
BEGIN
  for item in c1 loop
    dbms_output.put_line('Id: ' || item.empno || ', nombre: ' || item.ename);
  end loop;
END;

DECLARE
  CURSOR c1 (jefe number, v varchar2 default 'N') IS -- Se definen los parametros que recibiremos al abrir el cursor, tambien se le puede pasar el parametro con un valor por defecto.
    SELECT t1.empno, t1.ename, t1.job, t2.empno as idjefe, t2.ename as idname
    FROM EBA_DEMO_IG_EMP t1
    inner join EBA_DEMO_IG_EMP t2 on t1.mgr = t2.empno
    where t1.mgr = jefe and t1.onleave = v; 
BEGIN
  for item in c1(7788, 'Y') loop
    dbms_output.put_line('Id: ' || item.empno || ', nombre: ' || item.ename);
  end loop;
END;

