CLEAR SCREEN;
SET SERVEROUTPUT ON;
DECLARE
    auxCustomerId NUMBER;
    auxName VARCHAR2(40);
    auxCustomerAddress VARCHAR2(50);
    auxPhone NUMBER(9);
    auxPass VARCHAR2(20);
    auxUserName VARCHAR2(10);
    auxCardNumber NUMBER;
    ab NUMBER;
    check1 NUMBER;
    checkNewCus NUMBER;
BEGIN
        check1 := &S;
        checkNewCus := &X;
        IF checkNewCus = 3 THEN
            IF check1 = 1 THEN
                auxCustomerId := '&Customer_ID';
                auxName := '&Name';
                auxCustomerAddress := '&Address';
                auxPhone := '&Phone';
                auxPass := '&Password';
                auxUserName := '&User_Name';
                auxCardNumber := '&Card_Number';
                ab := newUser.functionNewCustomer(auxCustomerId,auxName,auxCustomerAddress,auxPhone,auxPass,auxUserName,auxCardNumber);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Select S value 1 into newUser01.sql file');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
        END IF:
        
    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/

SELECT *from Customer;