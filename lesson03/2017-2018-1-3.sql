---SZERET---
------------

--Kik szeretnek legalább kétféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 2;
--Kik szeretnek legalább háromféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 3;
--Kik szeretnek legfeljebb kétféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) <= 2;
--Kik szeretnek pontosan kétféle gyümölcsöt?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) = 2;

---DOLGOZO---
-------------

--Kik azok a dolgozók, akiknek a fõnöke KING? (nem leolvasva)
SELECT D1.DNEV "Alkalmazott", D2.DNEV "Fõnöke"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';
--Adjuk meg azoknak a fõnököknek a nevét, akiknek a foglalkozása nem 'MANAGER'. (dnev)
SELECT DISTINCT D1.DNEV "Név", D1.FOGLALKOZAS "Foglalkozás"
FROM DOLGOZO D1
JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD 
WHERE D1.FOGLALKOZAS != 'MANAGER';
--Adjuk meg azokat a dolgozókat, akik többet keresnek a fõnöküknél.
SELECT * FROM DOLGOZO;
--Kik azok a dolgozók, akik fõnökének a fõnöke KING?
SELECT * FROM DOLGOZO;
--Kik azok a dolgozók, akik osztályának telephelye DALLAS vagy CHICAGO?
SELECT * FROM DOLGOZO;
--Kik azok a dolgozók, akik osztályának telephelye nem DALLAS és nem CHICAGO?
SELECT * FROM DOLGOZO;
--Adjuk meg azoknak a nevét, akiknek a fizetése > 2000 vagy a CHICAGO-i osztályon dolgoznak.
SELECT * FROM DOLGOZO;
--Melyik osztálynak nincs dolgozója?
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a dolgozókat, akiknek van 2000-nél nagyobb fizetésû beosztottja.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a dolgozókat, akiknek nincs 2000-nél nagyobb fizetésû beosztottja.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a telephelyeket, ahol van elemzõ (ANALYST) foglalkozású dolgozó.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a telephelyeket, ahol nincs elemzõ (ANALYST) foglalkozású dolgozó.
SELECT * FROM DOLGOZO;
--Adjuk meg a maximális fizetésû dolgozó(k) nevét.
SELECT * FROM DOLGOZO;