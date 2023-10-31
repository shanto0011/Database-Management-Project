SET SERVEROUTPUT ON;
DECLARE
    pNumber NUMBER(9);
    address VARCHAR2(50);
    newPass VARCHAR2(20);
    check1 NUMBER;
    check2 NUMBER;
BEGIN
        pNumber := '&pNumber';
        address := '&address';
        newPass := '&newPass';
        check1 := &X;
        check2 := &P;

        IF check1 = 1 AND check2 = 4 THEN
        --Shanto--
            auth_Customer.updateCustomerInfo(pNumber,address,newPass);        
        ELSIF check2 <> 4 THEN
            DBMS_OUTPUT.PUT_LINE('Please Select P value as 4 in customer_01.sql File');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
        END IF;
        

    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/