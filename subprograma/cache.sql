create or replace package dept_pkg is
    -- Declaracion de los tipos
    type dept_info_record is record (
        dept_size pls_integer,
        dept_name eba_demo_da_dept.dname%type,
        dept_loc eba_demo_da_dept.loc%type
    );
    -- Declaracion de la funcion
    function get_dept_info (dept_id number) 
    return dept_info_record 
    result_cache;
end dept_pkg;

create or replace package body dept_pkg is 
    function get_dept_info(dept_id number) 
    return dept_info_record 
    result_cache is 
    res dept_info_record;
    begin 
        select dname, loc into res.dept_name, res.dept_loc 
        from eba_demo_da_dept
        where deptno = dept_id;
        
        select count(*) into res.dept_size 
        from eba_demo_da_emp
        where deptno = dept_id;
        
        return  res;
    end get_dept_info;
end dept_pkg;

declare
    res dept_pkg.dept_info_record;
    id number := 20;
begin
    res := dept_pkg.get_dept_info(id);
    dbms_output.put_line('Departamento id: ' || id 
    || ', Nombre: ' || res.dept_name || ', Tamaño: ' || res.dept_size);
end;