-- 1. feladat 
--  Írj PL/SQL procedúrát

SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION IS_PRIME(NO IN NUMBER) RETURN VARCHAR
IS ANS VARCHAR(5);
N NUMBER;
BEGIN
    IF(NO = 1) THEN
        ANS := 'FALSE';
    ELSIF(NO = 2) THEN
        ANS := 'TRUE';
    ELSE    
        N := NO / 2;    
        FOR I IN 2..N LOOP
            IF(MOD(NO, I) = 0) THEN
                ANS := 'FALSE';
                EXIT;
            ELSE
                ANS := 'TRUE';
            END IF;
        END LOOP;
    END IF;
    RETURN(ANS);
END;
/

CREATE OR REPLACE PROCEDURE ZH1 
(N IN NUMBER)
AS 
    i NUMBER;
    counter NUMBER;
    k NUMBER;
BEGIN 
    i := 2;
    k := floor(n/2);
    FOR i IN 1..k LOOP
        IF (is_prime(i) = 'TRUE' and (mod(n, i) = 0)) THEN
            DBMS_OUTPUT.PUT_LINE(i||' is a prime number which is also a divisor');
        END IF;
    END LOOP;
END; 
/

CALL ZH1(100);
DBMS_OUTPUT.ENABLE;

-- 2. feladat

