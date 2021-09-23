DECLARE
  x NUMBER := 0;
BEGIN
  LOOP -- After CONTINUE statement, control resumes here
    DBMS_OUTPUT.PUT_LINE ('Inside loop:  x = ' || TO_CHAR(x));

    x := x + 1;
    
    /* Tambien se puede hacer con:
    IF x < 3 THEN
      CONTINUE;
    END IF; */
    CONTINUE WHEN x < 3;

    DBMS_OUTPUT.PUT_LINE
      ('Inside loop, after CONTINUE:  x = ' || TO_CHAR(x));
    
    /* Tambien se puede hacer con:
    IF x = 5 THEN
      EXIT;
    END IF; */
    EXIT WHEN x = 5;

  END LOOP;
 
  DBMS_OUTPUT.PUT_LINE (' After loop:  x = ' || TO_CHAR(x));
END;