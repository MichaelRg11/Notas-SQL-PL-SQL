--
SELECT JSON_OBJECT(
        KEY 'id' VALUE e.empno, 
        KEY 'nombre' VALUE e.ename,
        KEY 'puesto' VALUE e.job,
        KEY 'salary' VALUE rs.sal,
        KEY 'salMinMax' VALUE JSON_ARRAY(rs.minSal, rs.maxSal)
        FORMAT JSON)
FROM eba_demo_da_emp e
JOIN (SELECT JSON_ARRAYAGG(es.sal) as sal, MAX(es.sal) as maxSal, 
              MIN(es.sal) as minSal, es.empno
      FROM eba_demo_da_emp_sal es
      GROUP BY es.empno) rs on e.empno = rs.empno;

--
SELECT JSON_OBJECT(
        KEY 'id' VALUE e.empno, 
        KEY 'nombre' VALUE e.ename,
        KEY 'puesto' VALUE e.job,
        KEY 'salary' VALUE JSON_ARRAYAGG(es.sal),
        KEY 'salMinMax' VALUE JSON_ARRAY(MAX(es.sal), MIN(es.sal)))
FROM eba_demo_da_emp e, eba_demo_da_emp_sal es 
WHERE es.empno = e.empno
GROUP BY e.empno, e.ename, e.job;

--
select json_arrayagg(json_object(
        key 'id' value e.empno, 
        key 'lider' value e.ename, 
        key 'acargo' value json_arrayagg(json_object(
                                                key 'id' value ec.empno, 
                                                key 'name' value ec.ename))))
from eba_demo_da_emp e, eba_demo_da_emp ec
where e.empno = ec.mgr
group by e.empno, e.ename;

--
select json_arrayagg(json_object(
        key 'id' value e.empno, 
        key 'lider' value e.ename, 
        key 'acargo' value json_arrayagg(json_object(
                                                key 'id' value ec.empno, 
                                                key 'name' value ec.ename))))
from eba_demo_da_emp e
join eba_demo_da_emp ec on e.empno = ec.mgr
group by e.empno, e.ename;

--
select json_arrayagg(json_object(
                key 'depermentID' value d.deptno,
                key 'departmentName' value d.dname,
                key 'departmentLoc' value d.loc,
                key 'employeer' value 
                json_arrayagg(json_object(
                        key 'name' value e.ename,
                        key 'job' value e.job)))) 
from eba_demo_da_dept d
join eba_demo_da_emp e on e.deptno = d.deptno
group by d.deptno, d.dname, d.loc;