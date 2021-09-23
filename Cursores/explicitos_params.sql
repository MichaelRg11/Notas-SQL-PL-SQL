-- Cursor explícito que acepta parámetros
DECLARE
  CURSOR c1 (jefe number, v varchar2 default 'N') IS -- Se definen los parametros que recibiremos al abrir el cursor, tambien se le puede pasar el parametro con un valor por defecto.
    SELECT t1.empno, t1.ename, t1.job, t2.empno as idjefe, t2.ename as idname
    FROM EBA_DEMO_IG_EMP t1
    inner join EBA_DEMO_IG_EMP t2 on t1.mgr = t2.empno
    where t1.mgr = jefe and t1.onleave = v; 

  procedure print is 
  id eba_demo_ig_emp.empno%type;
  name eba_demo_ig_emp.ename%type;
  job eba_demo_ig_emp.job%type;
  idjefe eba_demo_ig_emp.empno%type;
  namejefe eba_demo_ig_emp.ename%type;
  begin
    loop 
        fetch c1 into id, name, job, idjefe, namejefe;
        exit when c1%notfound;
        dbms_output.put_line('Id empleado: ' || id || ', Nombre empleado: ' || name  
        || ', Puesto: ' || job || ', Id jefe: ' || idjefe || ', Nombre jefe: ' || namejefe);
    end loop;
  end;  

BEGIN
    open c1(7788, 'Y'); 
    dbms_output.put_line('--------------------');
    dbms_output.put_line('Consulta de los jefes inmediatos');
    dbms_output.put_line('--------------------');
    print;
    close c1;

  open c1(7788, 'N'); 
    dbms_output.put_line('--------------------');
    dbms_output.put_line('Consulta de los jefes inmediatos');
    dbms_output.put_line('--------------------');
    print;
    close c1;
END;