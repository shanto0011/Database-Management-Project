CLEAR SCREEN;
SET SERVEROUTPUT ON;
set verify off;


--OBJECT--
CREATE OR REPLACE TYPE director_library AS OBJECT(
  employeeid NUMBER,
  name VARCHAR2(40),
  address VARCHAR2(50),
  phone NUMBER(9),
  paycheck NUMBER(10,2),
  extrapaycheck NUMBER(10,2)
);
/

commit;