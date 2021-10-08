DROP TABLE BT_CLIENTE;
/
CREATE TABLE BT_CLIENTE (
  ID_CLIENTE NUMBER                 CONSTRAINT BT_CLIENTE_NN NOT NULL ENABLE
                                    CONSTRAINT BT_CLIENTE_ID_PK PRIMARY KEY ENABLE,
  NOMBRE VARCHAR2(30)               CONSTRAINT BT_CLIENTE_NOMBRE_NN NOT NULL ENABLE,
  APELLIDO VARCHAR2 (255)           CONSTRAINT BT_CLIENTE_APELLIDO_NN NOT NULL ENABLE,
  FECHA_NACIMIENTO VARCHAR2 (255)   CONSTRAINT BT_CLIENTE_FCHA_NCMIENTO_NN NOT NULL ENABLE
);
/
CREATE SEQUENCE BT_CLIENTE_AUTO_INCREMETAL start with 1;
/
CREATE OR REPLACE TRIGGER BT_CLIENTE_IU BEFORE INSERT ON BT_CLIENTE FOR EACH ROW
BEGIN 
  SELECT BT_CLIENTE_AUTO_INCREMETAL.NEXTVAL into :NEW.ID_CLIENTE FROM DUAL;
END;
/
ALTER TRIGGER BT_CLIENTE_IU ENABLE;
/
INSERT INTO BT_CLIENTE (NOMBRE, APELLIDO, FECHA_NACIMIENTO) VALUES('ROBERTO', 'RODRIGUEZ', '03-04º-2002');