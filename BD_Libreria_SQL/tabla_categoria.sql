DROP TABLE BT_CATEGORIA;
/
CREATE TABLE BT_CATEGORIA (
  ID_CATEGORIA NUMBER         CONSTRAINT BT_CATEGORIA_ID_NN NOT NULL
                              CONSTRAINT BT_CATEGORIA_ID_PK PRIMARY KEY,
  TITULO VARCHAR2(30)         CONSTRAINT BT_CATEGORIA_TITULO_NN NOT NULL,
  DESCRIPCION VARCHAR2 (255)  CONSTRAINT BT_CATEGORIA_DESCRIPCION_NN NOT NULL
);
/
CREATE SEQUENCE BT_CTGRIA_AUTO_INCREMETAL start with 1;
/
CREATE OR REPLACE TRIGGER BT_CATEGORIA_IU BEFORE INSERT ON BT_CATEGORIA FOR EACH ROW
BEGIN 
  SELECT BT_CTGRIA_AUTO_INCREMETAL.NEXTVAL into :NEW.ID_CTGORIA FROM DUAL;
END;
/
ALTER TRIGGER BT_CATEGORIA_IU ENABLE;
/
INSERT INTO BT_CATEGORIA (TITULO, DESCRIPCION) VALUES('TERROR', 'DAN MUCHO MIEDO LEERLO SOLO');