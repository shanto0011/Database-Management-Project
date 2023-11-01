CLEAR SCREEN;
SET SERVEROUTPUT ON;
set verify off;


--OBJECT--
/* CREATE OR REPLACE TYPE director_library AS OBJECT(
  employeeid NUMBER,
  name VARCHAR2(40),
  address VARCHAR2(50),
  phone NUMBER(9),
  paycheck NUMBER(10,2),
  extrapaycheck NUMBER(10,2)
);
/ */

CREATE OR REPLACE PROCEDURE addBook_library(auxISBN IN VARCHAR2, auxBookID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER,
auxLostCost IN NUMBER, auxAddress IN VARCHAR2)
IS
BEGIN
  INSERT INTO book
  VALUES(auxISBN,auxBookID,auxState,'A',auxDebyCost,auxLostCost,auxAddress);
  DBMS_OUTPUT.PUT_LINE('Book inserted correctly');
END addBook_library;
/


DECLARE
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
  auxISBN VARCHAR2(4);
  auxItemID VARCHAR2(6);
  auxState VARCHAR2(10);
  auxDebyCost NUMBER(10,2);
  auxLostCost NUMBER(10,2);
  auxAddress VARCHAR2(50);
  checkNewBook NUMBER;
BEGIN
    checkNewBook := &X;
    IF checkNewBook = 3 THEN
        DBMS_OUTPUT.PUT_LINE('Giving information to add new book');
        auxISBN := '&ISBN';
        auxItemID := '&ItemID';
        auxState := '&State';
        auxDebyCost := '&Deby_Cost';
        auxLostCost := '&Lost_Cost';
        auxAddress := '&Location';
        addBook_library(auxISBN, auxItemID, auxState, auxDebyCost, auxLostCost, auxAddress);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
    END IF;
    
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other error');
END;
/

commit;
