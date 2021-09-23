
DECLARE
  TYPE departamento_cursor IS REF CURSOR;
 
  dep_cursor departamento_cursor;
  dept_name  eba_demo_da_dept.dname%TYPE;
  emp_name   eba_demo_da_emp.ename%TYPE;
 
  CURSOR c1 IS
    SELECT dname,
      CURSOR ( SELECT e.ename
                FROM eba_demo_da_emp e
                WHERE e.deptno = d.deptno
                ORDER BY e.ename
              ) eba_demo_da_emp
    FROM eba_demo_da_dept d
    ORDER BY dname;
BEGIN
  OPEN c1;
  LOOP  -- Process each row of query result set
    FETCH c1 INTO dept_name, dep_cursor;
    EXIT WHEN c1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Department: ' || dept_name);
 
    LOOP -- Process each row of subquery result set
      FETCH dep_cursor INTO emp_name;
      EXIT WHEN dep_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('-- Employee: ' || emp_name);
    END LOOP;
  END LOOP;
  CLOSE c1;
END;