CLEAR SCREEN;
SET SERVEROUTPUT ON;
set verify off;





CREATE OR REPLACE PACKAGE auth_Customer AS
  FUNCTION functionCustomer(input IN VARCHAR2) RETURN NUMBER;
  PROCEDURE loginCustomer_library(user IN VARCHAR2, pass IN VARCHAR2, msg OUT VARCHAR2);
  PROCEDURE customerCardInfo;
  PROCEDURE customerInformation;
  PROCEDURE updateCustomerInfo(pNumber NUMBER, address VARCHAR2, newPass VARCHAR2);
  PROCEDURE rentItem_library(auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE);
  PROCEDURE payFines_library(money IN NUMBER);
END auth_Customer;
/

CREATE OR REPLACE PACKAGE BODY auth_Customer AS
  store_msg VARCHAR2(35);

  store_customer_username VARCHAR2(35);
  store_customer_Password VARCHAR2(35);
  custoID  NUMBER;
  
  FUNCTION functionCustomer(input IN VARCHAR2) RETURN NUMBER 
  IS
    user1 customer.username%TYPE;
    pass1 customer.password%TYPE;
    msg1 VARCHAR2(35);
  BEGIN
    user1 := '&Username';
    pass1 := '&Password';
      
    loginCustomer_library(user1, pass1, msg1);
    IF msg1 = 'successful' THEN
      store_msg := msg1;
      store_customer_username := user1;
      store_customer_Password := pass1;
      DBMS_OUTPUT.PUT_LINE('Thanks for logging ->' || store_customer_username ||'<-');      
      RETURN 1;
    ELSIF msg1 = 'Incorrect' THEN
      --store_customer_username := 'Errors';
      --store_customer_Password := 'Errors';
      store_msg := msg1;
      RETURN 1;
    END IF;    
    RETURN 1;
  END functionCustomer;


  PROCEDURE loginCustomer_library(user IN VARCHAR2, pass IN VARCHAR2, msg OUT VARCHAR2)
  IS
    passAux customer.password%TYPE;
    incorrect_password EXCEPTION;

  BEGIN
    SELECT password INTO passAux
    FROM customer
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
  END loginCustomer_library;


  --SHA321
 
  --SHA321

--SHA123
PROCEDURE customerInformation IS
BEGIN
  IF store_customer_username IS NOT NULL AND store_customer_Password IS NOT NULL THEN
    
    FOR R IN (SELECT * FROM Customer) LOOP
      IF R.userName = store_customer_username THEN
        custoID := R.customerID;
        DBMS_OUTPUT.PUT_LINE('Customer ID :' || custoID); 
        DBMS_OUTPUT.PUT_LINE('Customer name :' || R.name); 
        DBMS_OUTPUT.PUT_LINE('Customer Address :' || R.customerAddress); 
        DBMS_OUTPUT.PUT_LINE('Customer phone :' || R.phone); 
        DBMS_OUTPUT.PUT_LINE('Customer password :' || R.password); 
        DBMS_OUTPUT.PUT_LINE('Customer userName :' || R.userName); 
        DBMS_OUTPUT.PUT_LINE('Customer dateSignUp :' || R.dateSignUp); 
        DBMS_OUTPUT.PUT_LINE('Customer cardNumber :' || R.cardNumber); 
      END IF;
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('You need to login First'); 
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END customerInformation;

--SHA123

PROCEDURE customerCardInfo IS
  auxCard NUMBER;
  auxFines NUMBER;
  auxItem Rent.itemID%TYPE;
  rented number := 0;
  customer_id  Customer.customerID%TYPE;
BEGIN
  IF store_customer_username IS NOT NULL AND store_customer_Password IS NOT NULL THEN
    --DBMS_OUTPUT.PUT_LINE(store_customer_username || ' ' || store_customer_Password);

    --SHANTO11
    SELECT customerID INTO customer_id  
    FROM Customer
    WHERE userName = store_customer_username;

    custoID := customer_id ;

    SELECT cardnumber INTO auxCard
    FROM Customer
    WHERE customerID = custoID;

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
    DBMS_OUTPUT.PUT_LINE('You need to login First'); 
    --SHANTO11
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END customerCardInfo;



 
PROCEDURE rentItem_library(auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE)
IS
  statusAux VARCHAR2(10);
  itemStatus VARCHAR2(10);
  customer_id  Customer.customerID%TYPE;
  auxCard NUMBER;
BEGIN
  
IF store_customer_username IS NOT NULL AND store_customer_Password IS NOT NULL THEN

    SELECT customerID INTO customer_id  
    FROM Customer
    WHERE userName = store_customer_username;

    custoID := customer_id ;

    SELECT cardnumber INTO auxCard
    FROM Customer
    WHERE customerID = custoID;

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
    DBMS_OUTPUT.PUT_LINE('Please Loging first'); 
    --SHANTO11
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
  
END rentItem_library; 


--
PROCEDURE updateCustomerInfo(pNumber NUMBER, address VARCHAR2, newPass VARCHAR2) IS
BEGIN
  IF store_customer_username IS NOT NULL AND store_customer_Password IS NOT NULL THEN
    
    UPDATE Customer
      SET phone = pNumber, customeraddress = address, password = newPass
      WHERE Customer.userName = store_customer_username;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Please Loging first'); 
  END IF;

  EXCEPTION 
    WHEN no_data_found THEN 
      DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Other errors');
END updateCustomerInfo; 


PROCEDURE payFines_library(money IN NUMBER)
IS
  finesAmount NUMBER;
  total NUMBER;
  auxCard  Card.cardID%TYPE;
BEGIN

IF store_customer_username IS NOT NULL AND store_customer_Password IS NOT NULL THEN

    SELECT cardnumber INTO auxCard  
    FROM Customer
    WHERE userName = store_customer_username;


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
    DBMS_OUTPUT.PUT_LINE('Please Loging first'); 
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
  
END auth_Customer;
/




DECLARE
 input NUMBER;
 demo NUMBER;
 shanto EXCEPTION;
 cus NUMBER;
BEGIN
    cus := &X;
    IF cus = 1 THEN
      demo:=auth_Customer.functionCustomer('Please Loging...'); 
    ELSE      
      DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File'); 
	RAISE shanto;          
    END IF;

EXCEPTION
	WHEN shanto THEN
		DBMS_OUTPUT.PUT_LINE('Please Give Right value');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other errors');
END;
/



ACCEPT P NUMBER PROMPT 'Press 1 info,Press 2 Card info,Press 3 Borrow ,Press 4 Updating info,Press 5 Payment:' ;

DECLARE
   input NUMBER ;
   checkC NUMBER;
BEGIN
    input := &P;
    checkC :=&X;
    
    IF checkC = 1 THEN 
		    IF input = 1 THEN
      		auth_Customer.customerInformation;
    		ELSIF input = 2 THEN 
     		 	auth_Customer.customerCardInfo;
    		ELSIF input = 3 THEN 
      		DBMS_OUTPUT.PUT_LINE('Please Run customer02_borrow.sql File');
    		ELSIF input = 4 THEN 
      		DBMS_OUTPUT.PUT_LINE('Please Run customer02_update.sql File');  
    		ELSIF input = 5 THEN 
      		DBMS_OUTPUT.PUT_LINE('Please Run customer02_cardRecharge.sql File');     
    		END IF;
    ELSE
	      DBMS_OUTPUT.PUT_LINE('Please SELECT X Value is 1 into initialized.sql File');
    END IF;
    
    

  EXCEPTION
	    WHEN OTHERS THEN
		      DBMS_OUTPUT.PUT_LINE('Other errors');

END ;
/

commit;

