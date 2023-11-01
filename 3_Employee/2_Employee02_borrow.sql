SET SERVEROUTPUT ON;
DECLARE
    auxCard NUMBER;
    auxItemID VARCHAR2(10);
    itemType VARCHAR2(20);
    auxDate DATE;
    check1 NUMBER;
    check2 NUMBER;
BEGIN
        check1 := &X;
        check2 := &E;
        IF check1 = 2 THEN
            IF check2 = 3 THEN
                DBMS_OUTPUT.PUT_LINE('Giving input  book bookID Return_date');
                itemType := '&Item_Type';  
                auxItemID := '&ID_Item';  
                auxDate := '&Return_date';
                auth_employee.rentItem_library(auxItemID,itemType,auxDate);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Select E value 3 into employee01.sql file');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
        END IF;
        

    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/