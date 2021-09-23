set SERVEROUTPUT on;

-- Procedimiento 

-- Este funciona como si fuera un fragmento de codigo dentro de la funcion 
-- Si las variables pasadas como argumento cambien su valor, 
-- este cambio sera visto por la funcion donde fue llamafa
create or replace procedure aumentar_salario(
  valor out varchar, 
  sal in out number, 
  saldo_extra number) is
begin 
  sal := sal + saldo_extra;
  valor := 'salrio actual ' || sal;
end;

DECLARE
  emp_salary  NUMBER(8,2);
  cadena varchar(100);
BEGIN
  SELECT sal INTO emp_salary
  FROM eba_demo_ig_emp
  WHERE empno = 7839;
 
  DBMS_OUTPUT.PUT_LINE('Before invoking procedure, emp_salary: ' || emp_salary);
 
  aumentar_salario(cadena, emp_salary, 1000);
 
  DBMS_OUTPUT.PUT_LINE('After invoking procedure, emp_salary: ' || emp_salary);
  DBMS_OUTPUT.PUT_LINE(cadena);
END;

--saludar recibe un nombre el cual imprime y despues cambia.
create or replace procedure saludar (nombre in out VARCHAR2) is
begin
  DBMS_OUTPUT.PUT_LINE('Nombre ingresado: Hola, ' || nombre || ', como estas?');
  nombre := nombre || ' Hola ';
  DBMS_OUTPUT.PUT_LINE('Nombre cambiado: Hola, ' || nombre || ', como estas?');
end;

-- Uso de while, loop, case y if
-- case es como un ternario, no es igual al if
DECLARE
  done BOOLEAN;              -- Initial value is NULL by default
  counter NUMBER := 0;
  cadena varchar2(500) := '';
BEGIN
  done := FALSE;                -- Assign literal value
  WHILE done != TRUE            -- Compare to literal value
    LOOP
      counter := counter + 1;
	    done := counter > 100;
	    --TAMBIEN SE PUEDE
      --done :=  CASE WHEN (counter > 100) then true else false end;
      IF mod(counter, 10) = 0 then 
        cadena := cadena || counter || ', ' || chr(10);
      else 
        if done then cadena := cadena || counter;
        else cadena := cadena || counter || ', ';
        end if;
      end if;
      
    END LOOP WHILE;
  DBMS_OUTPUT.PUT_LINE('valor => ' || counter);
  DBMS_OUTPUT.PUT_LINE('cadena valor => ' || cadena);
END;

-- actualizar la columna salario de la tabla empleado, bonus
DECLARE
  PROCEDURE p (sales NUMBER, quota NUMBER, emp_id NUMBER) IS
   bonus  NUMBER := 0;
  BEGIN
    IF sales > (quota + 200) THEN
      bonus := (sales - quota)/4;
    ELSE
      IF sales > quota THEN
        bonus := 50;
      ELSE
        bonus := 0;
      END IF;
    END IF;
 
    DBMS_OUTPUT.PUT_LINE('bonus = ' || bonus);
 
    UPDATE eba_demo_da_emp
    SET sal = sal + bonus 
    WHERE empno = emp_id;
  END p;
BEGIN
  p(10100, 10000, 7782);
  p(10500, 10000, 7566);
  p(9500, 10000, 7788);
END;