CREATE OR REPLACE TRIGGER addCardCusto_library
AFTER INSERT
ON customer
FOR EACH ROW
DECLARE
BEGIN
  INSERT INTO Card
  VALUES (:new.cardnumber,'A',0);
  
  DBMS_OUTPUT.PUT_LINE('Card created');
END addCardCusto_library;
/


--EMPLOYEE--
CREATE OR REPLACE TRIGGER addCardEmp_library
AFTER INSERT
ON employee
FOR EACH ROW
DECLARE
BEGIN
  INSERT INTO card
  VALUES (:new.cardnumber,'A',0);
  
  DBMS_OUTPUT.PUT_LINE('Card created');
END addCardEmp_library;
/

CREATE OR REPLACE TRIGGER modifyFines_library
AFTER DELETE
ON Rent
FOR EACH ROW
DECLARE
  auxCardID NUMBER;
  auxItemID VARCHAR2(6);
  auxBook NUMBER;
  
  auxDeby NUMBER;
BEGIN  
  SELECT cardID, itemID INTO auxCardID, auxItemID
  FROM Rent
  WHERE cardID LIKE :old.cardID;
  
  SELECT COUNT(*) INTO auxBook
  FROM Book
  WHERE bookID LIKE auxItemID;
  
  
  
  IF sysdate > :old.returnDate THEN
    
    IF auxBook > 0 THEN
      SELECT debyCost INTO auxDeby
      FROM Book
      WHERE bookID LIKE auxItemID;
    END IF;
    
    UPDATE card
    SET status = 'B', fines = (fines + auxDeby)
    WHERE cardID LIKE auxCardID;
  ELSE
    DBMS_OUTPUT.PUT_LINE('The item has been return before deadline');
  END IF;
END modifyFines_library;
/

commit;