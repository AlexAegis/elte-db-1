---SZERET---
------------

-- 1) Kik szeretnek legalább kétféle gyümölcsöt?
SELECT DISTINCT SZ1.NEV 
FROM SZERET SZ1, SZERET SZ2 
WHERE SZ1.NEV = SZ2.NEV AND SZ1.GYUMOLCS != SZ2.GYUMOLCS;

SELECT NEV
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 2;
-- 2) Kik szeretnek legalább háromféle gyümölcsöt?
SELECT DISTINCT SZ1.NEV 
FROM SZERET SZ1, SZERET SZ2, SZERET SZ3
WHERE SZ1.NEV = SZ2.NEV 
    AND SZ2.NEV = SZ3.NEV
    AND SZ3.NEV = SZ1.NEV -- this is unnecessary due to transitivity
    AND SZ1.GYUMOLCS != SZ2.GYUMOLCS 
    AND SZ2.GYUMOLCS != SZ3.GYUMOLCS 
    AND SZ3.GYUMOLCS != SZ1.GYUMOLCS;

SELECT NEV
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 3;
-- 3) Kik szeretnek legfeljebb kétféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) <= 2;
-- 4) Kik szeretnek pontosan kétféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) = 2;

---DOLGOZO---
-------------

-- 1) Kik azok a dolgozók, akiknek a fõnöke KING? (nem leolvasva)
SELECT D1.DNEV "Alkalmazott", D2.DNEV "Fõnöke"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';
-- 2) Adjuk meg azoknak a fõnököknek a nevét, akiknek a foglalkozása nem 'MANAGER'. (dnev)
SELECT DISTINCT D1.DNEV "Név", D1.FOGLALKOZAS "Foglalkozás"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD 
WHERE D1.FOGLALKOZAS != 'MANAGER';
-- 3) Adjuk meg azokat a dolgozókat, akik többet keresnek a fõnöküknél.
SELECT D1.DNEV "Fõnök", D1.FOGLALKOZAS "Fõnök foglalkozása", D1.FIZETES "Fõnök fizetése",  D2.DNEV "Alkalmazott", D2.FOGLALKOZAS "Alkalmazott foglalkozása", D2.FIZETES "Alkalmazott fizetése"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD
WHERE D2.FIZETES > D1.FIZETES;

SELECT D1.DNEV "Fõnök", D1.FOGLALKOZAS "Fõnök foglalkozása", D1.FIZETES "Fõnök fizetése",  D2.DNEV "Alkalmazott", D2.FOGLALKOZAS "Alkalmazott foglalkozása", D2.FIZETES "Alkalmazott fizetése"
FROM DOLGOZO D1, DOLGOZO D2
WHERE D2.FONOKE = D1.DKOD AND D2.FIZETES > D1.FIZETES;
-- 4) Kik azok a dolgozók, akik fõnökének a fõnöke KING?
SELECT D1.DKOD "Alk kód",
        D1.DNEV "Alk",
        D1.FONOKE "Alk fõnöke",
        D2.DKOD "Fõn kód",
        D2.DNEV "Fõn",
        D2.FONOKE "Fõn fõnöke",
        D3.DKOD "Fõn fõn kód",
        D3.DNEV "Fõn fõn",
        D3.FONOKE "Fõn fõn fõnöke"
FROM DOLGOZO D1,
        DOLGOZO D2,
        DOLGOZO D3
WHERE D1.FONOKE = D2.DKOD 
    AND D2.FONOKE = D3.DKOD
    AND D3.DNEV = 'KING';
-- 5) Kik azok a dolgozók, akik osztályának telephelye DALLAS vagy CHICAGO?
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY = 'DALLAS' OR OSZTALY.TELEPHELY = 'CHICAGO';

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY = 'DALLAS' OR OSZTALY.TELEPHELY = 'CHICAGO');
-- 6) Kik azok a dolgozók, akik osztályának telephelye nem DALLAS és nem CHICAGO?
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY != 'DALLAS' AND OSZTALY.TELEPHELY != 'CHICAGO';

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY != 'DALLAS' AND OSZTALY.TELEPHELY != 'CHICAGO');
-- 7) Adjuk meg azoknak a nevét, akiknek a fizetése > 2000 vagy a CHICAGO-i osztályon dolgoznak.
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY = 'CHICAGO' OR DOLGOZO.FIZETES > 2000;

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY = 'CHICAGO' OR DOLGOZO.FIZETES > 2000);
-- 8) Melyik osztálynak nincs dolgozója?
SELECT TELEPHELY FROM OSZTALY 
MINUS
SELECT DISTINCT TELEPHELY
FROM DOLGOZO JOIN OSZTALY
ON OSZTALY.OAZON = DOLGOZO.OAZON;
-- 9) Adjuk meg azokat a dolgozókat, akiknek van 2000-nél nagyobb fizetésû beosztottja.
SELECT DISTINCT D1.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.DKOD = D2.FONOKE 
    AND D2.FIZETES > 2000; 
-- 10) Adjuk meg azokat a dolgozókat, akiknek nincs 2000-nél nagyobb fizetésû beosztottja.
SELECT DISTINCT DNEV 
FROM DOLGOZO
MINUS 
SELECT DISTINCT D1.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.DKOD = D2.FONOKE 
    AND D2.FIZETES > 2000; 
-- 11) Adjuk meg azokat a telephelyeket, ahol van elemzõ (ANALYST) foglalkozású dolgozó.
SELECT DISTINCT OSZTALY.TELEPHELY 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON 
    AND DOLGOZO.FOGLALKOZAS = 'ANALYST';
-- 12) Adjuk meg azokat a telephelyeket, ahol nincs elemzõ (ANALYST) foglalkozású dolgozó.
SELECT TELEPHELY FROM OSZTALY
MINUS
SELECT DISTINCT OSZTALY.TELEPHELY 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON 
    AND DOLGOZO.FOGLALKOZAS = 'ANALYST';
-- 13) Adjuk meg a maximális fizetésû dolgozó(k) nevét.
SELECT DNEV 
FROM DOLGOZO
MINUS
SELECT D2.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.FIZETES > D2.FIZETES; 