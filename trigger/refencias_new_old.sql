CREATE TABLE new (
  field1  NUMBER,
  field2  VARCHAR2(20)
);
 -- referencia para evitar conflictos entre el nombre de la tabla y el nombre de la correlación
CREATE OR REPLACE TRIGGER Print_salary_changes
BEFORE UPDATE ON new
REFERENCING new AS Newest  -- referencia para evitar conflictos entre el nombre de la tabla y el nombre de la correlación
FOR EACH ROW
BEGIN
  :Newest.Field2 := TO_CHAR (:newest.field1);
END;