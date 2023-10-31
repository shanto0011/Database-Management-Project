CLEAR SCREEN;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT P NUMBER PROMPT 'Press 0:';
ACCEPT E NUMBER PROMPT 'Press 0:';
ACCEPT S NUMBER PROMPT 'Press 0:';
ACCEPT X NUMBER PROMPT 'Press 1 Customerer,Press 2 Employee ,Press 3 Admin :'; 

DECLARE
 catagory NUMBER;
 demo NUMBER;
 shanto EXCEPTION;
 
BEGIN
    catagory := &X;
    IF catagory = 1 THEN
      DBMS_OUTPUT.PUT_LINE('Please Run customer_01.sql File');
    ELSIF catagory = 2 THEN
      DBMS_OUTPUT.PUT_LINE('Please Run employee01.sql File');
    ELSIF catagory = 3 THEN
      DBMS_OUTPUT.PUT_LINE('Please Run Admin Folder'); 
    ELSE      
      dbms_output.put_line('Invalid According our range');       
      RAISE shanto;    
    END IF;

EXCEPTION
	WHEN shanto THEN
		DBMS_OUTPUT.PUT_LINE('Please Give Right value');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other errors');
END;
/


commit;

