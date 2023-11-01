CLEAR SCREEN
SET SERVEROUTPUT ON;
set verify off;


CREATE OR REPLACE PACKAGE auth_employee AS
  FUNCTION funEmployee(input IN VARCHAR2) RETURN NUMBER;

  PROCEDURE loginEmployee_library(user IN VARCHAR2, pass IN VARCHAR2, msg OUT VARCHAR2);
  PROCEDURE employeeCardInfo;
  PROCEDURE employeeInformation;
  PROCEDURE updateEmployeeInfo(pNumber NUMBER, address VARCHAR2, newPass VARCHAR2);
  PROCEDURE rentItem_library(auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE);
  PROCEDURE payFines_library(money IN NUMBER);
END auth_employee;
/

CREATE OR REPLACE PACKAGE BODY auth_employee AS
  store_msg VARCHAR2(35);

  store_employee_username VARCHAR2(35);
  store_employee_Password VARCHAR2(35);
  empID  NUMBER;
  
  FUNCTION funEmployee(input IN VARCHAR2) RETURN NUMBER 
  IS
    user1 Employee.username%TYPE;
    pass1 Employee.password%TYPE;
    msg1 VARCHAR2(35);
  BEGIN
    user1 := '&Username';
    pass1 := '&Password';
      
    loginEmployee_library(user1, pass1, msg1);
    IF msg1 = 'successful' THEN
      store_msg := msg1;
      store_employee_username := user1;
      store_employee_Password := pass1;
      DBMS_OUTPUT.PUT_LINE('Thanks for logging in.' || store_employee_username ||' '||store_employee_Password);      
      RETURN 1;
    ELSIF msg1 = 'Incorrect' THEN
      --store_employee_username := 'Errors';
      --store_employee_Password := 'Errors';
      store_msg := msg1;
      RETURN 1;
    END IF;
    DBMS_OUTPUT.PUT_LINE('funEmployee ' || input);
    
    RETURN 1;
  END funEmployee;
  

  

  PROCEDURE loginEmployee_library(user IN VARCHAR2, pass IN VARCHAR2, msg OUT VARCHAR2)
  IS
    passAux Employee.password%TYPE;
    incorrect_password EXCEPTION;

  BEGIN
    SELECT password INTO passAux
    FROM Employee
    WHERE username LIKE user;
    
    IF passAux = pass THEN
      msg := 'successful';
      DBMS_OUTPUT.PUT_LINE('User ' || user || ' logged in successfully.');
    ELSE
      msg := 'Incorrect';
      RAISE incorrect_password;
    END IF;

  EXCEPTION
    WHEN no_data_found OR incorrect_password THEN 
      DBMS_OUTPUT.PUT_LINE('Incorrect username or password');
  END loginEmployee_library;


  --SHA321
  PROCEDURE updateEmployeeInfo(pNumber NUMBER, address VARCHAR2, newPass VARCHAR2) 
  IS
  BEGIN
  IF store_employee_username IS NOT NULL AND store_employee_Password IS NOT NULL THEN
    
    UPDATE Employee
      SET phone = pNumber, employeeAddress = address, password = newPass
      WHERE Employee.userName = store_employee_username;
  ELSE
      DBMS_OUTPUT.PUT_LINE('You are not a valid customer in our database.'); 
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END updateEmployeeInfo;
  --SHA321

--SHA123
PROCEDURE employeeInformation IS
BEGIN
  IF store_employee_username IS NOT NULL AND store_employee_Password IS NOT NULL THEN
    
    FOR R IN (SELECT * FROM Employee) LOOP
      IF R.userName = store_employee_username THEN
        empID := R.employeeID;
        DBMS_OUTPUT.PUT_LINE('Employee ID :' || empID); 
        DBMS_OUTPUT.PUT_LINE('Employee name :' || R.name); 
        DBMS_OUTPUT.PUT_LINE('Employee Address :' || R.employeeAddress); 
        DBMS_OUTPUT.PUT_LINE('Employee phone :' || R.phone); 
        DBMS_OUTPUT.PUT_LINE('Employee password :' || R.password); 
        DBMS_OUTPUT.PUT_LINE('Employee userName :' || R.userName); 
        DBMS_OUTPUT.PUT_LINE('Employee PayCheck :' || R.paycheck); 
        DBMS_OUTPUT.PUT_LINE('Employee branch name :' || R.branchName); 
        DBMS_OUTPUT.PUT_LINE('Employee cardNumber :' || R.cardNumber); 
      END IF;
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('You are not a valid customer in our database.'); 
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END employeeInformation;

--SHA123

PROCEDURE employeeCardInfo IS
  auxCard NUMBER;
  auxFines NUMBER;
  auxItem Rent.itemID%TYPE;
  rented number := 0;
  employee_id  Employee.employeeID%TYPE;
BEGIN
  IF store_employee_username IS NOT NULL AND store_employee_Password IS NOT NULL THEN
    --DBMS_OUTPUT.PUT_LINE(store_employee_username || ' ' || store_employee_Password);

    --SHANTO11
    SELECT employeeID INTO employee_id  
    FROM Employee
    WHERE userName = store_employee_username;

    empID := employee_id ;

    SELECT cardnumber INTO auxCard
    FROM Employee
    WHERE employeeID = empID;

    SELECT COUNT(*) INTO rented
    FROM Rent
    WHERE Rent.cardID = auxCard;

    DBMS_OUTPUT.PUT_LINE('The user card is :' || auxCard);  
    IF rented > 0 THEN
      SELECT rent.itemID INTO auxItem
      FROM rent,card
      WHERE Card.cardID = Rent.cardID
      AND Card.cardID = auxCard;    

      DBMS_OUTPUT.PUT_LINE('The user has ..' || auxItem || '.. rented');
    ELSE    
      DBMS_OUTPUT.PUT_LINE('This user has no rents'); 
    END IF;

    SELECT fines INTO auxFines
    FROM card
    WHERE cardID = auxCard;

    DBMS_OUTPUT.PUT_LINE('The user fines are : ' || auxFines);
  ELSE
    DBMS_OUTPUT.PUT_LINE('You are not a valid customer in our database.'); 
    --SHANTO11
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END employeeCardInfo;

--
PROCEDURE rentItem_library(auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE)
IS
  statusAux VARCHAR2(10);
  itemStatus VARCHAR2(10);
  customer_id  Customer.customerID%TYPE;
  auxCard NUMBER;
BEGIN
  
IF store_employee_username IS NOT NULL AND store_employee_Password IS NOT NULL THEN

    SELECT customerID INTO customer_id  
    FROM Customer
    WHERE userName = store_employee_username;

    empID := customer_id ;

    SELECT cardnumber INTO auxCard
    FROM Customer
    WHERE customerID = empID;

  SELECT status INTO statusAux
  FROM Card
  WHERE cardID LIKE auxCard;
  
  IF statusAux LIKE 'A' THEN
    IF itemType LIKE 'book' THEN
      SELECT avalability INTO itemStatus
      FROM Book
      WHERE bookID LIKE auxItemID;
      
      IF itemStatus LIKE 'A' THEN
        UPDATE Book
        SET avalability = 'O'
        WHERE bookID LIKE auxItemID;
        
        INSERT INTO Rent
        VALUES (auxCard,auxItemID,sysdate,auxDate);
        DBMS_OUTPUT.PUT_LINE('Item ' || auxItemID || ' rented');
      ELSE
        DBMS_OUTPUT.PUT_LINE('The item is already rented');
      END IF;
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('The user is blocked');
  END IF; 
ELSE
    DBMS_OUTPUT.PUT_LINE('You are not a valid customer in our database.'); 
    --SHANTO11
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
  
END rentItem_library;
--
--
--
PROCEDURE payFines_library(money IN NUMBER)
IS
  finesAmount NUMBER;
  total NUMBER;
  auxCard  Card.cardID%TYPE;
BEGIN

IF store_employee_username IS NOT NULL AND store_employee_Password IS NOT NULL THEN

    SELECT cardnumber INTO auxCard  
    FROM Employee
    WHERE userName = store_employee_username;


  SELECT fines INTO finesAmount
  FROM Card
  WHERE cardID LIKE auxCard;
  
  IF finesAmount < money THEN
    total := money - finesAmount;
    DBMS_OUTPUT.PUT_LINE('YOU PAY ALL YOUR FINES AND YOU HAVE ' || total || ' MONEY BACK');
    
    UPDATE card
    SET status = 'A', fines = 0
    WHERE cardID = auxCard;
    
  ELSIF finesAmount = money THEN
    total := money - finesAmount;
    DBMS_OUTPUT.PUT_LINE('YOU PAY ALL YOUR FINES');
    
    UPDATE card
    SET status = 'A', fines = 0
    WHERE cardID= auxCard;
  
  ELSE
    total := finesAmount - money;
    DBMS_OUTPUT.PUT_LINE('YOU WILL NEED TO PAY ' || total || ' MORE DOLLARS TO UNLOCK YOUR CARD');
    
    UPDATE card
    SET fines = total
    WHERE cardID = auxCard;
  END IF;


ELSE
    DBMS_OUTPUT.PUT_LINE('You are not a valid customer in our database.'); 
    --SHANTO11
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END payFines_library;
--
--
  
END auth_employee;
/

DECLARE
   demo NUMBER;
   emp  NUMBER;
   shanto1 EXCEPTION;
BEGIN
    emp := &X;
    IF emp = 2 THEN
	demo:=auth_employee.funEmployee('Please Loging...');
    ELSE      
      DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 2 into initialized.sql File'); 
	RAISE shanto1;          
    END IF;

EXCEPTION
	WHEN shanto1 THEN
		DBMS_OUTPUT.PUT_LINE('Please Give Right value');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other errors');
END;
/

ACCEPT E NUMBER PROMPT 'Press 1 info,Press 2 Card info,Press 3 Borrow ,Press 4 Updating info,Press 5 Payment:' ;

DECLARE
   input NUMBER ;
   checkE NUMBER;
   
BEGIN
    
    checkE := &X;

    IF checkE = 2 THEN
      input := &E;

      IF input = 1 THEN
        auth_employee.employeeInformation;
      ELSIF input = 2 THEN 
        auth_employee.employeeCardInfo;
      ELSIF input = 3 THEN 
        DBMS_OUTPUT.PUT_LINE('Please Run Employee02_borrow.sql File');
      ELSIF input = 4 THEN 
        DBMS_OUTPUT.PUT_LINE('Please Run Employee02_update.sql File');  
      ELSIF input = 5 THEN 
        DBMS_OUTPUT.PUT_LINE('Please Run Employee02_cardRecharge.sql File');     
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 2 into initialized.sql File');
    END IF;
    
        
    

  EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/

commit;
