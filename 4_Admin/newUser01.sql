CLEAR SCREEN;
SET SERVEROUTPUT ON;
set verify off;

ACCEPT S NUMBER PROMPT 'Press 1 newCustomer,Press 2 newEmployee:' ;
--Shanto

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

CREATE OR REPLACE PACKAGE newUser AS
  FUNCTION functionNewCustomer(auxCustomerId IN NUMBER,auxName IN VARCHAR2,auxCustomerAddress IN VARCHAR2,auxPhone IN NUMBER,auxPass IN VARCHAR2,auxUserName IN VARCHAR2,auxCardNumber IN NUMBER) RETURN NUMBER ;
  FUNCTION functionNewE(
    auxCustomerId IN NUMBER,
    auxName IN VARCHAR2,
    auxCustomerAddress IN VARCHAR2,
    auxPhone IN NUMBER,
    auxPass IN VARCHAR2,
    auxUserName IN VARCHAR2,
    auxcheck IN NUMBER,
    auxBrance IN VARCHAR2,
    auxCardNumber IN NUMBER
  ) RETURN NUMBER;
END newUser;
/

CREATE OR REPLACE PACKAGE BODY newUser AS
  store_msg VARCHAR2(35);
  store_customer_username VARCHAR2(35);
  store_customer_Password VARCHAR2(35);
  custoID  NUMBER;

  FUNCTION functionNewCustomer(auxCustomerId IN NUMBER,auxName IN VARCHAR2,auxCustomerAddress IN VARCHAR2,auxPhone IN NUMBER,auxPass IN VARCHAR2,auxUserName IN VARCHAR2,auxCardNumber IN NUMBER) RETURN NUMBER 
  IS
   
    custoId_ NUMBER;
    userName_ VARCHAR2(40);
    userCard_ NUMBER;
    customer_count NUMBER;
    employee_count NUMBER;
  BEGIN
    
    SELECT COUNT(*) INTO custoId_ FROM Customer WHERE customerID = auxCustomerId;
    IF custoId_ = 0 THEN
      SELECT COUNT(*) INTO userName_ FROM Customer WHERE userName = auxUserName;
      IF userName_ = 0 THEN
        SELECT COUNT(*) INTO userCard_ FROM Card WHERE cardID = auxCardNumber;
        
        IF userCard_ > 0 THEN

           SELECT COUNT(*) INTO customer_count FROM Customer WHERE cardNumber = auxCardNumber;
           SELECT COUNT(*) INTO employee_count FROM Employee WHERE cardNumber = auxCardNumber; 

           DBMS_OUTPUT.PUT_LINE(customer_count || employee_count);

           IF customer_count=0 AND employee_count=0 THEN
                   INSERT INTO Customer VALUES (
                   auxCustomerId, 
                   auxName, 
                   auxCustomerAddress, 
                   auxPhone, 
                   auxPass, 
                   auxUserName, 
                   SYSDATE, 
                   auxCardNumber
                 );
                DBMS_OUTPUT.PUT_LINE('Hello Shanto');
                RETURN 1;
           ELSE
                DBMS_OUTPUT.PUT_LINE('CARD ID Already Used');
                RETURN 1;
           END IF;

          
        ELSE
        --
            INSERT INTO Card VALUES (auxCardNumber,'A',0);

            SELECT COUNT(*) INTO userCard_ FROM Card WHERE cardID = auxCardNumber;
            IF userCard_ > 0 THEN
              INSERT INTO Customer VALUES (
                auxCustomerId, 
                auxName, 
                auxCustomerAddress, 
                auxPhone, 
                auxPass, 
                auxUserName, 
                SYSDATE, 
                auxCardNumber
              );
              RETURN 1;
            ELSE
             DBMS_OUTPUT.PUT_LINE('CARD ID Already Used');
              RETURN 1;
            END IF;
        --
         DBMS_OUTPUT.PUT_LINE('CARD ID Already Used');
          RETURN 1;
        END IF; 
      ELSE
      
         DBMS_OUTPUT.PUT_LINE('User Name Already Used');
          RETURN 1; 
      END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Customer Id Already Used');
        RETURN 1;
    END IF;

    RETURN 0;
  END functionNewCustomer;

  --
  FUNCTION functionNewE(
    auxCustomerId IN NUMBER,
    auxName IN VARCHAR2,
    auxCustomerAddress IN VARCHAR2,
    auxPhone IN NUMBER,
    auxPass IN VARCHAR2,
    auxUserName IN VARCHAR2,
    auxcheck IN NUMBER,
    auxBrance IN VARCHAR2,
    auxCardNumber IN NUMBER
  ) RETURN NUMBER 
  IS
    custoId_ NUMBER;
    userName_ NUMBER;
    userCard_ NUMBER;
    customer_count NUMBER;
    employee_count NUMBER;
    branch_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO branch_count FROM Employee WHERE branchName = auxBrance;
    IF branch_count > 0 THEN
    SELECT COUNT(*) INTO custoId_ FROM Employee WHERE employeeID = auxCustomerId;
    IF custoId_ = 0 THEN
      SELECT COUNT(*) INTO userName_ FROM Employee WHERE userName = auxUserName;
      IF userName_ = 0 THEN
        SELECT COUNT(*) INTO userCard_ FROM Card WHERE cardID = auxCardNumber;
        IF userCard_ = 0 THEN
          INSERT INTO Card VALUES (auxCardNumber,'A',0);
        END IF;
        SELECT COUNT(*) INTO customer_count FROM Customer WHERE cardNumber = auxCardNumber;
        SELECT COUNT(*) INTO employee_count FROM Employee WHERE cardNumber = auxCardNumber; 
        IF customer_count = 0 AND employee_count = 0 THEN
          INSERT INTO Employee VALUES (
            auxCustomerId, 
            auxName, 
            auxCustomerAddress, 
            auxPhone, 
            auxPass, 
            auxUserName, 
            auxcheck,
            auxBrance, 
            auxCardNumber
          );
          DBMS_OUTPUT.PUT_LINE('Hello Shanto');
          RETURN 1;
        ELSE
          DBMS_OUTPUT.PUT_LINE('CARD ID Already Used');
          RETURN 1;
        END IF;
      ELSE
        DBMS_OUTPUT.PUT_LINE('User Name Already Used');
        RETURN 1; 
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Employee Id Already Used');
      RETURN 1;
    END IF;
  ELSE
      DBMS_OUTPUT.PUT_LINE('Sorry Branch Name invalid according our branches');
      RETURN 1;
  END IF;
  RETURN 0;
  END functionNewE;
  --
END newUser;
/



--Shanto
DECLARE
    director director_library; 
    input NUMBER ;
    checkNewUser NUMBER;
BEGIN
        checkNewUser := &X;
        IF checkNewUser = 3 THEN
          input := &S; 
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
            IF input = 1 THEN
              DBMS_OUTPUT.PUT_LINE('Please Run newUser02_Customer.sql File');
            ELSIF input = 2 THEN 
              DBMS_OUTPUT.PUT_LINE('Please Run newUser02_Employee.sql File');
            END IF;
        ELSE
          DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
        END IF;
        
    EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other error');

END ;
/

commit;
