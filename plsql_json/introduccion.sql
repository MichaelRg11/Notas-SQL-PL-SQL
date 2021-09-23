DECLARE
  je JSON_ELEMENT_T;
  jo JSON_OBJECT_T;
  n number;
BEGIN
  je := JSON_ELEMENT_T.parse('{"name":"Radio controlled plane", "canal":"103.9"}');
  IF (je.is_Object) THEN
    jo := treat(je AS JSON_OBJECT_T);
    /* jo.put('price', 199.99); Si se pone el valor numerico 
    bouble directamente arroja el error 'ORA-06502: PL/SQL: 
    error : error de conversión de carácter a número numérico o de valor', 
    asi que este se le debe asignar a una variable y pasar despues al 
    metodo put */
    n := 199.99;
    jo.put('price', n);
  END IF;
  DBMS_OUTPUT.put_line(je.to_string);
END;

--
DECLARE
  jo          JSON_OBJECT_T;
  ja          JSON_ARRAY_T;
  keys        JSON_KEY_LIST;
  keys_string VARCHAR2(100);
BEGIN
  ja := new JSON_ARRAY_T;
  jo := JSON_OBJECT_T.parse('{"name":"Beda", "jobTitle":"codmonki", "projects":["json", "xml"]}');
  keys := jo.get_keys;
  FOR i IN 1..keys.COUNT LOOP
     ja.append(keys(i));
  END LOOP;
  keys_string := ja.to_string;
  DBMS_OUTPUT.put_line(keys_string);
END;