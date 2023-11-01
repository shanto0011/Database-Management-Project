SET SERVEROUTPUT ON;

CREATE or REPLACE view archeology_coner(Name,User_Name,CardID) as 
SELECT E.name , E.userName, E.cardNumber
from Employee E where E.branchName='ARCHEOLOGY';

CREATE or REPLACE view chemistry_coner(Name,User_Name,CardID) as 
SELECT E.name , E.userName, E.cardNumber 
from Employee E where E.branchName='CHEMISTRY';

CREATE or REPLACE view computer_coner(Name,User_Name,CardID) as 
SELECT E.name , E.userName, E.cardNumber 
from Employee E where E.branchName='COMPUTING';

CREATE or REPLACE view physics_coner(Name,User_Name,CardID) as 
SELECT E.name , E.userName, E.cardNumber 
from Employee E where E.branchName='PHYSICS';

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------ARCHEOLOGY-----------------');
END;
/
SELECT *from archeology_coner ;

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------COMPUTING-----------------');
END;
/
SELECT *from chemistry_coner ;

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------PHYSICS-----------------');
END;
/
SELECT *from computer_coner ;

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------CHEMISTRY-----------------');
END;
/
SELECT *from physics_coner ;

/* CREATE or REPLACE PACKAGE branchWiseEmloyee AS 
    PROCEDURE showbranchWiseEmloyee(branchName IN VARCHAR2);
END branchWiseEmloyee;

CREATE or REPLACE PACKAGE body branchWiseEmloyee AS 

    PROCEDURE showbranchWiseEmloyee(branchName IN VARCHAR2)
    IS
    BEGIN

    END showbranchWiseEmloyee;

END branchWiseEmloyee; */
