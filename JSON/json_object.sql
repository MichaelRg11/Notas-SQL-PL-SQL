-- 
SELECT JSON_OBJECT(
        KEY 'Id' VALUE e.empno, 
        KEY 'Name' VALUE e.ename,
        KEY 'Job' VALUE e.job,
        KEY 'IsLider' VALUE CASE WHEN e.mgr IS NULL THEN 'true' ELSE 'False' END,
        KEY 'Department' VALUE JSON_OBJECT(
                                    KEY 'DeptId' VALUE d.deptno,
                                    KEY 'DName' VALUE d.dname,
                                    KEY 'Location' VALUE d.loc) FORMAT JSON)
FROM eba_demo_da_emp e
JOIN eba_demo_da_dept d ON e.deptno = d.deptno;

-- Utilizamos ABSENT ON NULL, el cual sirve para omitir un atributo null y asi no crearlo
SELECT JSON_OBJECT(
        KEY 'id' VALUE e.empno, 
        KEY 'nombre' VALUE e.ename,
        KEY 'puesto' VALUE e.job,
        KEY 'Lider' VALUE e.mgr ABSENT ON NULL
        FORMAT JSON)
FROM eba_demo_da_emp e;

-- JSON OBJECTAGG
SELECT JSON_OBJECTAGG(KEY d.dname VALUE d.deptno)
FROM eba_demo_da_dept d