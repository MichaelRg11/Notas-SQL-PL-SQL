CREATE OR REPLACE PACKAGE My_Types IS
  TYPE My_AA IS TABLE OF PLS_INTEGER -- pls_integer es el tipo de valor que guardara
    INDEX BY VARCHAR2(20); -- varchar2(20) es el tipo de la key
  FUNCTION Init_My_AA RETURN My_AA;
END My_Types;
/
CREATE OR REPLACE PACKAGE BODY My_Types IS
  FUNCTION Init_My_AA RETURN My_AA IS
    Ret My_AA;
  BEGIN
    Ret('-ten') := -10;
    Ret('zero') := 0;
    Ret('one') := 1;
    Ret('two') := 2;
    Ret('three') := 3;
    Ret('four') := 4;
    Ret('nine') := 9;
    RETURN Ret;
  END Init_My_AA;
END My_Types;
/
DECLARE
  v CONSTANT My_Types.My_AA := My_Types.Init_My_AA();
BEGIN
  DECLARE
    Idx varchar2(10) := v.FIRST();
  BEGIN
    WHILE Idx IS NOT NULL LOOP
      DBMS_OUTPUT.PUT_LINE(Idx || ' => ' || v(Idx));
      Idx := v.NEXT(Idx);
    END LOOP;
  END;
END;
/