SET SERVEROUTPUT ON;
DECLARE
    money NUMBER;
    check1 NUMBER;
    check2 NUMBER;
BEGIN
        check1 := &X;
        check2 := &E;
        IF check1 = 2 THEN
            IF check2 = 5 THEN
               money := '&Money_To_Pay'; 
               auth_employee.payFines_library(money); 
            ELSE
                DBMS_OUTPUT.PUT_LINE('Select E value 5 into employee01.sql file');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
        END IF;
        

    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/