/* (select ... into)
Írjunk meg egy függvényt, amelyik visszaadja egy adott fizetési kategóriába tartozó
dolgozók átlagfizetését.
*/
CREATE OR REPLACE FUNCTION kat_atlag(n INTEGER) 
RETURN FLOAT IS
    CURSOR curs1 IS SELECT * FROM dolgozo;
    rec curs1%ROWTYPE;
    osszeg float := 0.0;
    db integer := 0;
BEGIN
    OPEN curs1;
    LOOP
    FETCH curs1 INTO rec;
    EXIT WHEN curs1%NOTFOUND;
    db := db + 1;
    osszeg  := osszeg + rec.fizetes;
    DBMS_OUTPUT.put_line(rec.dnev || ' - ' || rec.fizetes);
    END LOOP;
    CLOSE curs1;
    RETURN osszeg/db;
END;
/
--Tesztelés:
SELECT kat_atlag(4) FROM dual;

-- Vagy
CREATE OR REPLACE FUNCTION kat_atlag(n INTEGER) 
RETURN FLOAT IS
    CURSOR curs1 IS SELECT * FROM dolgozo;
    rec curs1%ROWTYPE;
    osszeg float := 0.0;
    db integer := 0;
BEGIN
    FOR rec IN curs1 LOOP
        db := db + 1;
        osszeg  := osszeg + rec.fizetes;
        DBMS_OUTPUT.put_line(rec.dnev || ' - ' || rec.fizetes);
    END LOOP;
    RETURN osszeg/db;
END;
/
--Tesztelés:
SELECT kat_atlag(4) FROM dual;



----------------------------------------------------------------
/*
Írjunk meg egy plsql procedúrát, amelyik veszi a dolgozókat ábácé szerinti sorrendben, 
és minden páratlan sorszámú dolgozó nevét és fizetését kiírja
*/
--CREATE OR REPLACE PROCEDURE proc9 IS
--Tesztelés:
--set serveroutput on
--call proc9();


----------------------------------------------------------------
/* (paraméteres kurzor)
Írjunk meg egy plsql programot (név nélküli blokkot), amelyik kiírja azon dolgozók 
nevét és belépési dátumát, akik a felhasználó által megadott osztályon dolgoznak. 
A felhasználó az osztály nevének els? bet?jét adja meg (ACCEPT-tel kérjük be). 
A program írja ki az osztály nevét is. Ha nincs megfelel? osztály, akkor azt írja ki.
*/
set serveroutput on;
ACCEPT OSZT PROMPT 'ADD MEG AZ OSZTALYT';
DECLARE
    CURSOR CURS1 IS SELECT * FROM DOLGOZO NATURAL JOIN OSZTALY;
    REC CURS1%ROWTYPE;
BEGIN
    FOR REC IN CURS1 LOOP
        IF REC.FIZETES < 900 THEN
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || ' - csoro');
        ELSIF REC.FIZETES < 1200 THEN
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || REC.FIZETES);
        ELSE
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || ' - gazdag');
        END IF;
    END LOOP;
END;
/

----------------------------------------------------------------
/* (módosítás)
Írjunk meg egy procedúrát, amelyik megnöveli azoknak a dolgozóknak a fizetését 1-el,
akiknek a fizetési kategóriája ugyanaz, mint a procedúra paramétere.
A procedúra a módosítás után írja ki a módosított (új) fizetések átlagát két tizedesjegyre kerekítve.
*/
CREATE OR REPLACE PROCEDURE kat_novel(p_kat NUMBER) IS 
--Tesztelés:
set serveroutput on
call kat_novel(2);


----------------------------------------------------------------
/* (módosítás kurzorral)
Írjunk meg egy procedúrát, amelyik módosítja a paraméterében megadott osztályon a fizetéseket, és 
kiírja a dolgozó nevét és új fizetését.  A módosítás mindenki fizetéséhez adjon hozzá n*10 ezret, 
ahol n a dolgozó nevében lev? magánhangzók száma (a, e, i, o, u).
*/
CREATE OR REPLACE PROCEDURE fiz_mod(p_oazon INTEGER) IS 
--Tesztelés:
set serveroutput on
call fiz_mod(10);
