/* El primer numero del for indica donde empezara i y el segundo hasta donde llegara */
BEGIN
  FOR i IN 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
  FOR i IN 3..5 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
END;

/* El primer numero del for hasta donde llegara i y el segundo donde empezara */
BEGIN
  FOR i IN REVERSE 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
  FOR i IN REVERSE 3..5 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
END;

/* Para hacer referencia a un indice exterior, este debe tener una etiqueta */
<<main>>  -- Label block.
DECLARE
  i NUMBER := 5;
BEGIN
  FOR i IN 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE ('local: ' || TO_CHAR(i) || ', global: ' || TO_CHAR(main.i));
  END LOOP;
END main;

BEGIN
  <<outer_loop>>
  FOR i IN 1..3 LOOP
    <<inner_loop>>
    FOR i IN 1..3 LOOP
      DBMS_OUTPUT.PUT_LINE
        ('outer: ' || TO_CHAR(outer_loop.i) || ' inner: ' || TO_CHAR(inner_loop.i));
    END LOOP inner_loop;
  END LOOP outer_loop;
END;

/* Cursor forLoop */
/* Si queremos hacer loop de una fracion del cursor este se debe abrir, y asignar su valor a una variable de tipo de la tabla %ROWTYPE */
DECLARE
  v_employees eba_demo_da_emp%ROWTYPE;
  CURSOR c1 is SELECT * FROM eba_demo_da_emp; -- Cursor
BEGIN
  OPEN c1; -- Abriendo cursor
  FOR i IN 1..10 LOOP
    FETCH c1 INTO v_employees; -- Asignando valor del cursor a la variable
    EXIT WHEN c1%NOTFOUND;
    dbms_output.put_line('empno: ' || v_employees.empno || ', nombre: ' || v_employees.ename);
    -- Process data here
  END LOOP;
  CLOSE c1;
END;

/* Para recorrer todo el cursor se le asigna al for */
DECLARE
  v_employees eba_demo_da_emp%ROWTYPE;
  CURSOR c1 is SELECT * FROM eba_demo_da_emp;
BEGIN
  FOR i IN c1 LOOP
    dbms_output.put_line('empno: ' || i.empno || ', nombre: ' || i.ename);
  END LOOP;
END;

DECLARE
  v_employees eba_demo_da_emp%ROWTYPE;
BEGIN
  FOR i IN 1..10 LOOP
      SELECT * INTO v_employees
      FROM eba_demo_da_emp
      WHERE empno = 7782;
    dbms_output.put_line('empno: ' || v_employees.empno || ', nombre: ' || v_employees.ename);
    -- Process data here
  END LOOP;
END;