---SZERET---
------------

-- 1) Melyek azok a gyümölcsök, amelyeket Micimackó szeret?
SELECT GYUMOLCS 
FROM SZERET 
WHERE NEV = 'Micimackó';
-- 2) Melyek azok a gyümölcsök, amelyeket Micimackó nem szeret? (de valaki más igen)
SELECT GYUMOLCS 
FROM SZERET 
MINUS
SELECT GYUMOLCS 
FROM SZERET 
WHERE NEV = 'Micimackó';
-- 3) Kik szeretik az almát?
SELECT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'alma';
-- 4) Kik nem szeretik a körtét? (de valami mást igen),
SELECT NEV 
FROM SZERET
MINUS
SELECT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'körte';
-- 5) Kik szeretik vagy az almát vagy a körtét?
SELECT DISTINCT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'alma' OR GYUMOLCS = 'körte';

SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'alma' 
UNION
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'körte';
-- 6) Kik szeretik az almát is és a körtét is?
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'alma'
MINUS
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'körte';
-- 7) Kik azok, akik szeretik az almát, de nem szeretik a körtét?


---DOLGOZO---
-------------

-- 1) Kik azok a dolgozók, akiknek a fizetése nagyobb, mint 2800?
SELECT DNEV
FROM DOLGOZO
WHERE FIZETES > 2800;
-- 2) Kik azok a dolgozók, akik a 10-es vagy a 20-as osztályon dolgoznak?
SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 10 OR OAZON = 20;

SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 10
UNION
SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 20;
-- 3) Kik azok, akiknek a jutaléka nagyobb, mint 600?
SELECT DNEV
FROM DOLGOZO
WHERE JUTALEK > 600;
-- 4) Kik azok, akiknek a jutaléka nem nagyobb, mint 600?
SELECT DNEV 
FROM DOLGOZO
WHERE JUTALEK <= 600 OR JUTALEK IS NULL;
-- 5) Kik azok a dolgozók, akiknek a jutaléka ismeretlen (nincs kitöltve, vagyis NULL)?
SELECT DNEV 
FROM DOLGOZO
WHERE JUTALEK IS NULL;
-- 6) Adjuk meg a dolgozók között elõforduló foglalkozások neveit.
SELECT DISTINCT FOGLALKOZAS 
FROM DOLGOZO
WHERE FOGLALKOZAS IS NOT NULL;
-- 7) Adjuk meg azoknak a nevét és kétszeres fizetését, akik a 10-es osztályon dolgoznak.
SELECT DNEV, FIZETES * 2 
FROM DOLGOZO
WHERE OAZON = 10;
-- 8) Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?
SELECT DNEV, BELEPES 
FROM DOLGOZO
WHERE BELEPES > DATE '1982-01-01';
-- 9) Kik azok, akiknek nincs fõnöke?
SELECT DNEV 
FROM DOLGOZO
WHERE FONOKE IS NULL;
-- 10) Kik azok a dolgozók, akiknek a fõnöke KING? (egyelõre leolvasva a képernyõrõl)
SELECT DNEV 
FROM DOLGOZO
WHERE FONOKE = (SELECT DKOD
                FROM DOLGOZO
                WHERE DNEV = 'KING'); -- this is not valid in relational algebra

SELECT D1.DNEV
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';  -- this is valid in relational algebra