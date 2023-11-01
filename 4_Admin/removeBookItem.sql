SET SERVEROUTPUT ON;
set verify off;

CREATE OR REPLACE PROCEDURE removeItem_library(auxItemID IN VARCHAR2)
IS
  auxBook NUMBER;
  rentcheck NUMBER;  
BEGIN
  SELECT COUNT(*) INTO auxBook
  FROM Book
  WHERE bookID LIKE auxItemID;

  SELECT COUNT(*) INTO rentcheck
  FROM Rent
  WHERE itemID LIKE auxItemID;

  IF auxBook > 0 AND rentcheck =0 THEN
    DELETE FROM Book
    WHERE bookID LIKE auxItemID;
    DBMS_OUTPUT.PUT_LINE('Book removed correctly');
  ELSIF auxBook > 0 AND rentcheck > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Book After  removed when user return it');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Sorry Book ID is not correct');
  END IF;
END removeItem_library;
/


DECLARE
    auxItemID VARCHAR2(10);
    director director_library; 
BEGIN
        director := director_library(212, 'CHANDLER', 'OUR HEARTHS', 688688688,1150.5,500);
        dbms_output.put_line('-----------------------VERIFY BY---------------------' );
        dbms_output.put_line('--------------------------------------------' ); 
        dbms_output.put_line('DIRECTOR ID: '|| director.employeeid); 
        dbms_output.put_line('NAME: '|| director.name); 
        dbms_output.put_line('ADDRESS: '|| director.address); 
        dbms_output.put_line('PHONE: '|| director.phone); 
        dbms_output.put_line('PAYCHECK: '|| director.paycheck); 
        dbms_output.put_line('EXTRA: '|| director.extrapaycheck);  
        dbms_output.put_line('--------------------------------------------' ); 
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other error');
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('BookId for deletion');
END;
/

DECLARE
  auxItemID VARCHAR2(10);
  checkremove NUMBER;
BEGIN 
  checkremove := &X;   
  IF checkremove = 3 THEN
      auxItemID := '&ItemID_to_remove';
      removeItem_library(auxItemID);
  ELSE
      DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
  END IF;
  
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other error');
END;
/
commit;