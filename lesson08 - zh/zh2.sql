--1)
--1.1)

--drop in this order to avoid conflicts
DROP TABLE ZH_PRODUCT;
DROP SEQUENCE SQ_ZH_PRODUCT;
DROP TABLE ZH_USER;

CREATE TABLE ZH_USER (
    USERNAME VARCHAR2(40) PRIMARY KEY NOT NULL,
    PASSWORD VARCHAR2(40) NOT NULL,
    EMAIL VARCHAR2(40) NOT NULL UNIQUE,
    REGISTRATION DATE NOT NULL
);

CREATE TABLE ZH_PRODUCT (
    ID NUMBER(9, 0) PRIMARY KEY NOT NULL,
    NAME VARCHAR2(40) NOT NULL,
    QUANTITY NUMBER(9, 0) NOT NULL,
    PRICE NUMBER(24,4) NOT NULL,
    ANNOUNCEMENT DATE NOT NULL,
    SELLER VARCHAR2(40) NOT NULL REFERENCES ZH_USER,
    BUYER VARCHAR2(40) REFERENCES ZH_USER
);

CREATE SEQUENCE SQ_ZH_PRODUCT START WITH 1;
-- run the set define off together with the trigger statement
SET DEFINE OFF;
CREATE OR REPLACE TRIGGER BI_TRG_ZH_PRODUCT 
BEFORE INSERT ON ZH_PRODUCT 
FOR EACH ROW
BEGIN
  SELECT SQ_ZH_PRODUCT.NEXTVAL
  INTO   :new.ID
  FROM   dual;
END;
/

--1.2)
INSERT INTO ZH_USER (USERNAME, PASSWORD, EMAIL, REGISTRATION) VALUES ('A', 'A', 'A@A.A', SYSDATE);
INSERT INTO ZH_USER (USERNAME, PASSWORD, EMAIL, REGISTRATION) VALUES ('B', 'B', 'B@B.B', SYSDATE);

INSERT INTO ZH_PRODUCT(NAME, QUANTITY, PRICE, ANNOUNCEMENT, SELLER) VALUES('Ha', 1, 10, SYSDATE, 'A');
INSERT INTO ZH_PRODUCT(NAME, QUANTITY, PRICE, ANNOUNCEMENT, SELLER) VALUES('Hb', 1, 10, SYSDATE, 'B');

--1.3)
UPDATE ZH_PRODUCT SET BUYER = 'A' WHERE NAME = 'Hb' AND SELLER = 'B';
--1.4)
--DELETE FROM ZH_PRODUCT WHERE ID = 1;
DELETE FROM ZH_PRODUCT WHERE NAME = 'Ha' AND SELLER = 'A';

--2)
SELECT DNEV, LENGTH(DNEV) AS NEV_LENGHT--, FOGLALKOZAS 
FROM DOLGOZO 
WHERE SUBSTR(FOGLALKOZAS,1,1) = 'C' OR SUBSTR(FOGLALKOZAS,1,1) = 'M'
ORDER BY FOGLALKOZAS;

/*
DNEV       NEV_LENGHT
---------- ----------
JAMES               5
MILLER              6
ADAMS               5
LOLA                4
SMITH               5
JONES               5
CLARK               5
BLAKE               5

*/

--3)
SELECT AVG(COALESCE(JUTALEK, 0)) AS AVG_FIZ FROM DOLGOZO;

/*
   AVG_FIZ
----------
156,25    
*/

--4)
SELECT KATEGORIA, COUNT(DNEV)
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA
ORDER BY KATEGORIA;

/* 
 KATEGORIA COUNT(DNEV)
---------- -----------
         1           4
         2           3
         3           3
         4           5
         5           1

*/

--5)
SELECT DKOD, DNEV, FOGLALKOZAS, JUTALEK, BELEPES--, FIZETES, OAZON 
FROM DOLGOZO 
WHERE OAZON IS NOT NULL AND FIZETES IN (
    SELECT --DNEV, FOGLALKOZAS, JUTALEK, BELEPES, 
    MIN(FIZETES)
    FROM DOLGOZO NATURAL JOIN OSZTALY
    GROUP BY OAZON);
    
/*
      DKOD DNEV       FOGLALKOZ    JUTALEK BELEPES     
---------- ---------- --------- ---------- ------------
      7900 JAMES      CLERK                81-DEC.  -03
      7369 SMITH      CLERK                80-DEC.  -17
      7934 MILLER     CLERK                82-JAN.  -23
*/
    
--6)
SELECT SUM(COUNT(DISTINCT F.DNEV)) AS NON_MANAGER_BOSS 
FROM DOLGOZO F JOIN DOLGOZO D ON F.DKOD = D.FONOKE 
WHERE F.FOGLALKOZAS != 'MANAGER' GROUP BY F.FOGLALKOZAS;

/*
NON_MANAGER_BOSS
----------------
               3
*/

--7) Ez rossz lett :(
SELECT NEV1, NEV2, SZ FROM (
select SZ1.NEV AS NEV1, SZ2.NEV AS NEV2, 
   case
      when SZ1.GYUMOLCS = SZ2.GYUMOLCS then 'true' 
      else 'false' 
   end AS SZ
from SZERET SZ1, SZERET SZ2) WHERE SZ = 'true' GROUP BY NEV1, NEV2, SZ HAVING COUNT(NEV2) = 2 AND COUNT(NEV1) = 2;

/*
NEV1            NEV2            SZ   
--------------- --------------- -----
Tigris          Tigris          true 
Tigris          Kanga           true 
Micimackó       Tigris          true 
Malacka         Kanga           true 
Micimackó       Kanga           true 
Kanga           Malacka         true 
Kanga           Micimackó       true 
Tigris          Micimackó       true 
Malacka         Tigris          true 
Kanga           Kanga           true 
Kanga           Tigris          true 

NEV1            NEV2            SZ   
--------------- --------------- -----
Tigris          Malacka         true 

12 rows selected. 
*/

