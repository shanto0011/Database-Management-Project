SET SERVEROUTPUT ON;
DECLARE
    pNumber NUMBER(9);
    address VARCHAR2(50);
    newPass VARCHAR2(20);
--
    check1 NUMBER;
    check2 NUMBER;
BEGIN
        check1 := &X;
        check2 := &E;
        IF check1 = 2 THEN
            IF check2 = 4 THEN
                pNumber := '&pNumber';
                address := '&address';
                newPass := '&newPass';
                auth_employee.updateCustomerInfo(pNumber,address,newPass);  
            ELSE
                DBMS_OUTPUT.PUT_LINE('Select E value 4 into employee01.sql file');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
        END IF;
--
       

    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/