clear screen;
SET SERVEROUTPUT ON;
SET VERIFY off;



CREATE OR REPLACE PROCEDURE allMedia_library(mediaType VARCHAR2)
IS
   
BEGIN
  IF mediaType LIKE 'books' THEN    
    DBMS_OUTPUT.PUT_LINE('ISBN     ID        AVALABILITY  DEBY_COST  LOST_COST  STATE  LOCATION');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
    
    FOR xBooks IN (SELECT *FROM Book) LOOP      
      DBMS_OUTPUT.PUT_LINE(xBooks.isbn || '     ' || xBooks.bookid || '    ' || xBooks.avalability || '            ' || xBooks.debycost || '          ' ||
      xBooks.lostcost||'         ' || xBooks.state  || '     ' || xBooks.address );
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Sorry video or others formate not available us');
  END IF;
END allMedia_library;
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
BEGIN
  DBMS_OUTPUT.PUT_LINE('Type books or Others to see :');

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other error');
END;
/

DECLARE
  typeItem VARCHAR2(10);
BEGIN
  typeItem := '&Select_btwn_books_or_videos';
  allMedia_library(typeItem);

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other error');
END;
/