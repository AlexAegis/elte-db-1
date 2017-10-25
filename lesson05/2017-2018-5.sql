-- TO_DATE('94-11-30', 'YY-MM-DD') -> DATE
-- SUBSTR("valami",2,1) -> a
-- SUBSTR("valami",-2,1) -> m
-- INSTR("alma",'a', 1, 2) -> 2. a betû pozíciója (ha > 0 van ilyen)
-- ROUND(SQRT(4.4),2) -> 2.09
-- TO_CHAR(DATE, 'month') -> hónapnév
-- LENGTH("alma") -> 4
-- RPAD(' ', 3, '#') -> "###"
-- UPPER("alma") -> ALMA
-- LOWER("ALMA") -> alma
-- SYSDATE -> aktuális timestamp
-- NVL(jutalék, 0) -> ha null, 0-ra cserél


-- 1) Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?
SELECT DNEV, BELEPES FROM DOLGOZO WHERE BELEPES > TO_DATE('1982.01.01', 'YYYY.MM.DD');
-- 2) Adjuk meg azon dolgozókat, akik nevének második betûje 'A'.
SELECT DNEV FROM DOLGOZO WHERE SUBSTR(DNEV, 2, 1) = 'A';
-- 3) Adjuk meg azon dolgozókat, akik nevében van legalább két 'L' betû. 
SELECT DNEV FROM DOLGOZO WHERE INSTR(DNEV,'L', 1, 2) > 0;
SELECT DNEV FROM DOLGOZO WHERE DNEV LIKE '%L%L%';
-- 4) Adjuk meg a dolgozók nevének utolsó három betûjét.
SELECT SUBSTR(DNEV, -3, 3) FROM DOLGOZO;
-- 5) Adjuk meg a dolgozók fizetéseinek négyzetgyökét két tizedesre, és ennek egészrészét. 
SELECT DNEV, ROUND(SQRT(FIZETES), 0) FROM DOLGOZO;
-- 6) Adjuk meg, hogy hány napja dolgozik a cégnél ADAMS és milyen hónapban lépett be.
SELECT DNEV, ROUND(SYSDATE - BELEPES, 0),TO_CHAR(BELEPES, 'month') FROM DOLGOZO WHERE DNEV = 'ADAMS';
-- 7) Adjuk meg azokat a (név, fõnök) párokat, ahol a két ember neve ugyanannyi betûbõl áll. 
SELECT D1.DNEV, D2.DNEV FROM DOLGOZO D1, DOLGOZO D2 WHERE D1.DKOD = D2.FONOKE AND LENGTH(D1.DNEV) = LENGTH(D2.DNEV);
SELECT D1.DNEV, D2.DNEV FROM DOLGOZO D1 JOIN DOLGOZO D2 ON D1.DKOD = D2.FONOKE AND LENGTH(D1.DNEV) = LENGTH(D2.DNEV);
-- 8) Listázzuk ki a dolgozók nevét és fizetését, valamint jelenítsük meg a fizetést grafikusan
--    úgy, hogy a fizetést 1000 Ft-ra kerekítve, minden 1000 Ft-ot egy '#' jel jelöl.
SELECT DNEV, RPAD(' ', SUBSTR(ROUND(FIZETES, -3), 1, 1) + 1, '#') AS FIZETES FROM DOLGOZO; 
-- 9) Listázzuk ki azoknak a dolgozóknak a nevét, fizetését, jutalékát, és a jutalék/fizetés
--    arányát, akiknek a foglalkozása eladó (salesman). Az arányt két tizedesen jelenítsük meg.
SELECT DNEV, FIZETES, JUTALEK, ROUND(JUTALEK/FIZETES, 2) FROM DOLGOZO WHERE FOGLALKOZAS = 'SALESMAN';

--Összesítõ függvények, csoportképzés
-----------------------------------

-- 1) Mekkora a maximális fizetés a dolgozók között?
SELECT MAX(FIZETES) FROM DOLGOZO;
-- 2) Mennyi a dolgozók összfizetése?
SELECT SUM(FIZETES) FROM DOLGOZO;
-- 3) Mennyi a 20-as osztályon az átlagfizetés?
SELECT SUM(FIZETES) / COUNT(*) FROM DOLGOZO WHERE OAZON = 20;
-- 4) Adjuk meg, hogy hány különbözõ foglalkozás fordul elõ a dolgozók között. 
SELECT COUNT(DISTINCT FOGLALKOZAS) FROM DOLGOZO WHERE FOGLALKOZAS IS NOT NULL;
-- 5) Hány olyan dolgozó van, akinek a fizetése > 2000? 
SELECT COUNT(*) FROM DOLGOZO WHERE FIZETES > 2000;
-- 6) Adjuk meg osztályonként az átlagfizetést (oazon, atl_fiz).
SELECT OAZON, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON; 
-- 7) Adjuk meg osztályonként a telephelyet és az átlagfizetést (oazon, telephely, atl_fiz).
SELECT OAZON, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY;
-- 8) Adjuk meg, hogy az egyes osztályokon hány ember dolgozik.
SELECT TELEPHELY, COUNT(DKOD) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY TELEPHELY;
-- 9) Adjuk meg azokra az osztályokra az átlagfizetést, ahol ez nagyobb mint 2000.
SELECT OAZON, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING ROUND(AVG(FIZETES), 2) > 2000;
-- 10) Adjuk meg az átlagfizetést azokon az osztályokon, ahol legalább 4-en dolgoznak (oazon, avg_fiz)
SELECT OAZON, COUNT(DKOD), ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING COUNT(DKOD) > 4;
-- 11) Adjuk meg az átlagfizetést és telephelyet azokon az osztályokon, ahol legalább 4-en dolgoznak.
SELECT OAZON, TELEPHELY, COUNT(DKOD), ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING COUNT(DKOD) > 4;
-- 12) Adjuk meg azon osztályok nevét és telephelyét, ahol az átlagfizetés nagyobb mint 2000. (onev, telephely)
SELECT ONEV, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY ONEV, TELEPHELY HAVING ROUND(AVG(FIZETES), 2) > 2000;
-- 13) Adjuk meg azokat a fizetési kategóriákat, amelybe pontosan 3 dolgozó fizetése esik.
SELECT KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES > ALSO AND FIZETES < FELSO 
GROUP BY KATEGORIA HAVING COUNT(KATEGORIA) = 3 ;
-- 14) Adjuk meg azokat a fizetési kategóriákat, amelyekbe esõ dolgozók mindannyian ugyanazon az osztályon dolgoznak.

-- 15) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek van 1-es fizetési kategóriájú dolgozója.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1;
-- 16) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek legalább 2 fõ 1-es fiz. kategóriájú dolgozója van.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1 AND COUNT(KATEGORIA) >= 2;
-- 17) Készítsünk listát a páros és páratlan azonosítójú (dkod) dolgozók számáról.
-- 18) Listázzuk ki munkakörönként a dolgozók számát, átlagfizetését (kerekítve) numerikusan és grafikusan is.
--     200-anként jelenítsünk meg egy '#'-ot
