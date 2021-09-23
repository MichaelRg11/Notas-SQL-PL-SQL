-- Subprogram that dynamic PL/SQL block invokes: crea departamentos
create or replace procedure create_dept (deptno IN OUT NUMBER, dname IN VARCHAR2, loc IN varchar2) is
begin
  select max(deptno) + 10 into deptno from eba_demo_da_dept;
  insert into eba_demo_da_dept values (deptno, dname, loc);
end;

declare
  plsql_block VARCHAR2(500);
  deptno number := 0;
  dname eba_demo_da_dept.dname%type := 'TALENTO HUMANO';
  loc eba_demo_da_dept.loc%type := 'SANTA MARTA';
begin
  -- El bloque dinámico PL / SQL invoca el subprograma:
  plsql_block := 'BEGIN create_dept(:a, :b, :c); END;';
  
  /* Especifique las variables de vinculación en la cláusula USING. 
  Especifique el modo para el primer parámetro. Los modos de otros 
  parámetros son correctos por defecto. */   
  execute immediate plsql_block using in out deptno, dname, loc; -- Invocando execute immediate 
  dbms_output.put_line('con usign');
  dbms_output.put_line('id => ' || deptno);

  create_dept(deptno, dname,loc); -- invocando el procesor
  dbms_output.put_line('llamando el proceso');
  dbms_output.put_line('id => ' || deptno);  
end;

-- con un paquete
CREATE OR REPLACE PACKAGE pkg AUTHID DEFINER AS
  TYPE rec IS RECORD (n1 NUMBER, n2 NUMBER);
  PROCEDURE p (x OUT rec, y NUMBER, z NUMBER);
END pkg;

CREATE OR REPLACE PACKAGE BODY pkg AS
  PROCEDURE p (x OUT rec, y NUMBER, z NUMBER) AS
  BEGIN
    x.n1 := y;
    x.n2 := z;
  END p;
END pkg;

DECLARE
  r pkg.rec;
  dyn_str VARCHAR2(3000);
BEGIN
  dyn_str := 'BEGIN pkg.p(:x, 6, 8); END;';
  EXECUTE IMMEDIATE dyn_str USING OUT r;
  DBMS_OUTPUT.PUT_LINE('con usign');
  DBMS_OUTPUT.PUT_LINE('r.n1 = ' || r.n1);
  DBMS_OUTPUT.PUT_LINE('r.n2 = ' || r.n2);
  
  pkg.p(r, 6, 8);
  DBMS_OUTPUT.PUT_LINE('llamando el proceso');
  DBMS_OUTPUT.PUT_LINE('r.n1 = ' || r.n1);
  DBMS_OUTPUT.PUT_LINE('r.n2 = ' || r.n2);
END;

-- Con paquete y una tabla
create or replace package pkg as
  type number_names is table of varchar2(10) index by pls_integer;
  procedure print_number_names (x number_names);
end pkg;

create or replace package body pkg as
  procedure print_number_names (x number_names) is
  begin 
    for i in x.first .. x.last loop 
      dbms_output.put_line('line => ' || x(i));
    end loop;
  end;
end pkg;

declare  
  digit_names pkg.number_names;
  dyn_stmt VARCHAR2(3000);
begin
  digit_names(0) := 'zero';
  digit_names(1) := 'one';
  digit_names(2) := 'two';
  digit_names(3) := 'three';
  digit_names(4) := 'four';
  digit_names(5) := 'five';
  digit_names(6) := 'six';
  digit_names(7) := 'seven';
  digit_names(8) := 'eight';
  digit_names(9) := 'nine';
 
  dyn_stmt := 'begin pkg.print_number_names(:x); end;';
  dbms_output.put_line('EJECUTANDO CON USING');
  execute immediate dyn_stmt using digit_names;
  dbms_output.put_line('LLAMANDO AL PROCESO DEL PAQUETE');  
  pkg.print_number_names(digit_names);
end;