SET SERVEROUTPUT ON;
DECLARE
    demo NUMBER;
    auxCustomerId NUMBER;
    auxName VARCHAR2(40);
    auxCustomerAddress VARCHAR2(50);
    auxPhone NUMBER(9);
    auxPass VARCHAR2(20);
    auxUserName VARCHAR2(10);
    auxpaycheck NUMBER (8, 2);
    auxbranch VARCHAR2(40);
    auxCardNumber NUMBER;
    check1 NUMBER;
    checkNewEmp NUMBER;
BEGIN
    check1 := &S;
    checkNewEmp := &X;
    IF checkNewEmp = 3 THEN
        IF check1 = 2 THEN
            auxCustomerId := '&Employee_ID';
            auxName := '&Name';
            auxCustomerAddress := '&Address';
            auxPhone := '&Phone';
            auxPass := '&Password';
            auxUserName := '&User_Name';
            auxpaycheck := '&Payment';
            auxbranch  := '&Branch_Name';
            auxCardNumber := '&Card_Number';
            demo := newUser.functionNewE(auxCustomerId,auxName,auxCustomerAddress,auxPhone,auxPass,auxUserName,auxpaycheck,auxbranch,auxCardNumber);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Select S value 2 into newUser01.sql file');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
    END IF;   

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other errors');
        ROLLBACK;
END ;
/

SELECT * FROM Employee;
