-- Como se pueden pasar parametros de forma posicional, llamando o mixta
CREATE OR REPLACE FUNCTION compute_bonus (
  emp_id NUMBER,
  bonus NUMBER
) RETURN NUMBER IS
  emp_sal NUMBER;
BEGIN
  SELECT sal INTO emp_sal
  FROM eba_demo_da_emp
  WHERE empno = emp_id;

  RETURN emp_sal + bonus;
END compute_bonus;

SELECT compute_bonus(7782, 50) FROM DUAL;                   -- positional
SELECT compute_bonus(bonus => 50, emp_id => 7782) FROM DUAL; -- named
SELECT compute_bonus(7782, bonus => 50) FROM DUAL;           -- mixta