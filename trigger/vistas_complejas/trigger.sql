CREATE OR REPLACE TRIGGER Library_trigger
  INSTEAD OF
  INSERT ON Library_view
  FOR EACH ROW
DECLARE
  Bookvar  Book_t;
  i        INTEGER;
BEGIN
  INSERT INTO Library_table
  VALUES (:NEW.Section);
 
  FOR i IN 1..:NEW.Booklist.COUNT LOOP
    Bookvar := :NEW.Booklist(i);
 
    INSERT INTO Book_table (
      Booknum, Section, Title, Author, Available      
    )
    VALUES (
      Bookvar.booknum, :NEW.Section, Bookvar.Title,
      Bookvar.Author, bookvar.Available
    );
  END LOOP;
END;

INSERT INTO Library_view (Section, Booklist)
VALUES (
  'History', 
  book_list_t (book_t (121330, 'Alexander', 'Mirth', 'Y'))
);