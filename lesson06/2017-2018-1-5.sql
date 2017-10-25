-- 1) Adjuk meg, hogy az egyes osztályokon hány ember dolgozik.
SELECT COUNT(*) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON;
-- 2) Adjuk meg azokra az osztályokra az átlagfizetést, ahol ez nagyobb mint 2000.
SELECT ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING AVG(FIZETES) > 2000;
-- 3) Adjuk meg az átlagfizetést azokon az osztályokon, ahol legalább 4-en dolgoznak (oazon, avg_fiz)
SELECT ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING COUNT(*) >= 4;
-- 4) Adjuk meg az átlagfizetést és telephelyet azokon az osztályokon, ahol legalább 4-en dolgoznak.
SELECT TELEPHELY, ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING COUNT(*) >= 4;
-- 5) Adjuk meg azon osztályok nevét és telephelyét, ahol az átlagfizetés nagyobb mint 2000. (onev, telephely)
SELECT ONEV, TELEPHELY FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, ONEV, TELEPHELY HAVING AVG(FIZETES) > 2000;
-- 6) Adjuk meg azokat a fizetési kategóriákat, amelybe pontosan 3 dolgozó fizetése esik.
SELECT KATEGORIA
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA HAVING COUNT(KATEGORIA) = 3;
-- 7) Adjuk meg azokat a fizetési kategóriákat, amelyekbe esõ dolgozók mindannyian ugyanazon az osztályon dolgoznak.

-- 8) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek van 1-es fizetési kategóriájú dolgozója.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1;
-- 9) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek legalább 2 fõ 1-es fiz. kategóriájú dolgozója van.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1 AND COUNT(KATEGORIA) >= 2;
-- 10) Készítsünk listát a páros és páratlan azonosítójú (dkod) dolgozók számáról.

-- 11) Listázzuk ki munkakörönként a dolgozók számát, átlagfizetését (kerekítve) numerikusan és grafikusan is.
--     200-anként jelenítsünk meg egy '#'-ot
SELECT KATEGORIA, COUNT(KATEGORIA), ROUND(AVG(FIZETES), 2), RPAD(' ', ROUND(AVG(FIZETES) / 200, 0) + 1, '#') AS ATLAG_FIZETES
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA;
-- 12) Adjuk meg azokat a fizetési kategóriákat, amelybe pontosan 3 dolgozó fizetése esik.

-- 13) Adjuk meg azokat a fizetési kategóriákat, amelyekbe esõ dolgozók mindannyian ugyanazon az osztályon dolgoznak.
-- 14) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek van 1-es fizetési kategóriájú dolgozója.
-- 15) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek legalább 2 fõ 1-es fiz. kategóriájú dolgozója van.
-- 16) Készítsünk listát a páros és páratlan azonosítójú (dkod) dolgozók számáról.
-- 17) Listázzuk ki munkakörönként a dolgozók számát, átlagfizetését (kerekítve) numerikusan és grafikusan is. 200-anként jelenítsünk meg egy '#'-ot

------------
---SZERET---
------------
-- 1) Kik szeretnek minden gyümölcsöt?
-- 2) Kik azok, akik legalább azokat a gyümölcsöket szeretik, mint Micimackó?
-- 3) Kik azok, akik legfeljebb azokat a gyümölcsöket szeretik, mint Micimackó?
-- 4) Kik azok, akik pontosan azokat a gyümölcsöket szeretik, mint Micimackó?
-- 5) Melyek azok a (név,név) párok, akiknek legalább egy gyümölcsben eltér az ízlésük, azaz az  egyik szereti ezt a gyümölcsöt, a másik meg nem?
-- 6) Melyek azok a (név,név) párok, akiknek pontosan ugyanaz az ízlésük, azaz  pontosan  ugyanazokat a gyümölcsöket szeretik? 
-- 7) SZERET(NEV, GYUMOLCS) tábla helyett EVETT(NEV, KG) legyen a relációséma és azt tartalmazza, hogy ki mennyi gyümölcsöt evett összesen. Ki ette a legtöbb gyümölcsöt? 