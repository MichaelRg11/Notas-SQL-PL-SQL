/*  Este valida si la condicion es verdadera para ejecutarse */
DECLARE
  done  BOOLEAN := FALSE;
BEGIN
  WHILE done LOOP
    DBMS_OUTPUT.PUT_LINE ('This line does not print.');
    done := TRUE;  -- This assignment is not made.
  END LOOP;

  WHILE NOT done LOOP
    DBMS_OUTPUT.PUT_LINE ('Hello, world!');
    done := TRUE;
  END LOOP;

  WHILE done LOOP
    DBMS_OUTPUT.PUT_LINE ('Hello, true!');
    done := FALSE;
  END LOOP;
END;

