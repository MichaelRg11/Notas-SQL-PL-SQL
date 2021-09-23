-- Varray inicializdo con un constructor, tamaño estatico
DECLARE
  TYPE Foursome IS VARRAY(4) OF VARCHAR2(15);  -- VARRAY type
 
  team Foursome := Foursome('John', 'Mary', 'Alberto', 'Juanita'); -- constructor ininizializador
 
  PROCEDURE print_team (heading VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(heading); 
    FOR i IN 1..team.count() LOOP
      DBMS_OUTPUT.PUT_LINE(i || '.' || team(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------'); 
  END;
  
BEGIN 
  print_team('2001 Team:');
 
  team(3) := 'Pierre';  -- Se cambia el valor de dos elementos
  team(4) := 'Yvonne';
  print_team('2005 Team:');
  
  -- Se invoca el constructor y se asigna un nuevo varray
  team := Foursome('Arun', 'Amitha', 'Allan', 'Mae');
  print_team('2009 Team:');
END;

-- Tabla
DECLARE
  TYPE Roster IS TABLE OF VARCHAR2(15);  -- nested table type
 
  -- nested table variable initialized with constructor:
 
  names Roster := Roster('D Caruso', 'J Hamil', 'D Piro', 'R Singh');
 
  PROCEDURE print_names (heading VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(heading);
    FOR i IN names.FIRST .. names.LAST LOOP  -- For first to last element
      DBMS_OUTPUT.PUT_LINE(names(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('---');
  END;
  
BEGIN 
  print_names('Initial Values:');
 
  names(3) := 'P Perez';  -- Change value of one element
  print_names('Current Values:');
 
  names := Roster('A Jansen', 'B Gupta');  -- Change entire table
  print_names('Current Values:');
END;

-- Creando el tipo de array global
CREATE OR REPLACE TYPE nt_type IS TABLE OF NUMBER;
/
CREATE OR REPLACE PROCEDURE print_nt (nt nt_type) IS
  i  NUMBER;
BEGIN
  i := nt.FIRST;
 
  IF i IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('nt is empty');
  ELSE
    WHILE i IS NOT NULL LOOP
      DBMS_OUTPUT.PUT('nt.(' || i || ') = ');
      DBMS_OUTPUT.PUT_LINE(NVL(TO_CHAR(nt(i)), 'NULL'));
      i := nt.NEXT(i);
    END LOOP;
  END IF;
 
  DBMS_OUTPUT.PUT_LINE('---');
END print_nt;
/
DECLARE
  nt nt_type := nt_type();  -- nested table variable initialized to empty
BEGIN
  print_nt(nt);
  nt := nt_type(90, 9, 29, 58);
  print_nt(nt);
END;