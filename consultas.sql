-- el valor retornado en los case siempre debe ser del mismo tipo, 
-- sino se explota :,v
SELECT nombre,
   case 
     when salario > 2310000 then salario 
     when salario = 1000000 then null
     else salario*2
   end as sal
   FROM empleados
   ORDER BY nombre;

select empno, ename, job,
case 
    when sal > 3000 then 'salario alto'
    else 'salario bajo'
end as tipiSalario,
case 
    when comm is null then 'no sirve'
    else 'si sirve'
end as comm
from EBA_DEMO_DA_EMP;

-- Consulta con json 
select json_arrayagg(json_object(
        key 'id' value e.empno, 
        key 'lider' value e.ename, 
        key 'acargo' value rs.value))
from eba_demo_da_emp e
inner join (select json_arrayagg(json_object(
                      key 'id' value empno, 
                      key 'name' value ename)) as value, mgr 
            from eba_demo_da_emp 
            where mgr is not null
            group by mgr ) rs on e.empno = rs.mgr;

select json_arrayagg(json_object(
        key 'id' value e.empno, 
        key 'lider' value e.ename, 
        key 'acargo' value json_arrayagg(json_object(
                                                key 'id' value ec.empno, 
                                                key 'name' value ec.ename))))
from eba_demo_da_emp e, eba_demo_da_emp ec
where e.empno = ec.mgr
group by e.empno, e.ename;
