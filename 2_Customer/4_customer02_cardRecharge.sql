SET SERVEROUTPUT ON;
DECLARE
    money NUMBER;
    check1 NUMBER;
    check2 NUMBER;
BEGIN
        check1 := &X;
        check2 := &P;
        money := '&Money_To_Pay'; 
    
        IF check1 = 1 AND check2 = 5 THEN
            auth_Customer.payFines_library(money);
        ELSIF check2 <> 5 THEN
            DBMS_OUTPUT.PUT_LINE('Please Select P value as 5 in customer_01.sql File');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
        END IF;

    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/