SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE handleReturns_library(auxItemID IN VARCHAR2)
IS
  auxRented NUMBER;
  auxBook NUMBER;
  
BEGIN
  SELECT COUNT(*) INTO auxRented
  FROM rent
  WHERE itemid LIKE auxItemID;
  
  SELECT COUNT(*) INTO auxBook
  FROM book
  WHERE bookid LIKE auxItemID;
  
  
  IF auxRented > 0 THEN
    DELETE FROM rent
    WHERE itemid = auxItemID;
    IF auxBook > 0 THEN
      UPDATE book
      SET avalability = 'A'
      WHERE bookid LIKE auxItemID;
      DBMS_OUTPUT.PUT_LINE('The book ' || auxItemID || ' is now avaible.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('This item is not ');
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('This item is not rented at the moment');
  END IF;
  EXCEPTION WHEN no_data_found THEN 
  DBMS_OUTPUT.PUT_LINE('Item ID incorrect');    
END handleReturns_library;
/



DECLARE
 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Giving rent table itemId(bookID)');    
END;
/

DECLARE
  auxItemID VARCHAR2(10);
  checkReturn NUMBER;
BEGIN
    checkReturn := &X;
    IF  checkReturn =3 THEN
        auxItemID := '&ItemID_to_return';
        handleReturns_library(auxItemID);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
    END IF;
    
END;
/

SELECT *from Rent;

commit;