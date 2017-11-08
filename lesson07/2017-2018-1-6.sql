-- Feladatok módosításra, törlésre, beszúrásra.
--------------------------------------------

-- TÁBLA LÉTREHOZÁS
CREATE TABLE proba123(
    ID INT NOT NULL PRIMARY KEY,
    nev VARCHAR(10) NOT NULL
);

-- NÉZETTÁBLA LÉTREHOZÁS
CREATE VIEW viewproba123 AS
SELECT nev FROM proba123 WHERE ID = 2;

-- TÁBLA OSZLOP TÖRLÉS/MÓDOSÍTÁS/HOZZÁADÁS
ALTER TABLE proba123 DROP COLUMN nev;
ALTER TABLE proba123 ADD nev varchar(30);

-- TÁBLA ÖSSZES SORÁNAK TÖRLÉSE
TRUNCATE TABLE proba123;

-- TÁBLA TELJES TÖRLÉSE
DROP TABLE proba123;

-- SOR BESZÚRÁS
INSERT INTO proba123 VALUES (2, 'Feri');
INSERT INTO proba123 (nev, uid) VALUES ('Jozsi', 3);

-- SOROK MÓDOSÍTÁSA
UPDATE proba123 SET nev='Peti', id = 1 WHERE nev = 'Jozsi';

-- SOROK TÖRLÉSE
DELETE FROM proba123 WHERE nev='Peti';


--Feladatok módosításra, törlésre, beszúrásra.
--------------------------------------------

-- A módosítást egy másodpéldányon végezzük, hogy a tábla eredeti tartalma megmaradjon
CREATE TABLE DOLGOZO2 AS SELECT * FROM nikovits.dolgozo;
CREATE TABLE OSZTALY2 AS SELECT * FROM nikovits.osztaly;

-- DELETE

-- (reset with this after each altering)
DROP TABLE DOLGOZO2;
CREATE TABLE DOLGOZO2 AS SELECT * FROM nikovits.DOLGOZO;

DROP TABLE OSZTALY2;
CREATE TABLE OSZTALY2 AS SELECT * FROM nikovits.OSZTALY;

-- Töröljük azokat a dolgozókat, akiknek jutaléka NULL.
DELETE FROM DOLGOZO2 WHERE JUTALEK IS NULL;
-- Töröljük azokat a dolgozókat, akiknek a belépési dátuma 1982 elõtti.
DELETE FROM DOLGOZO2 WHERE BELEPES < DATE '1982-01-01';
-- Töröljük azokat a dolgozókat, akik osztályának telephelye DALLAS.
DELETE FROM DOLGOZO2 WHERE DKOD IN 
    (SELECT DOLGOZO2.DKOD FROM DOLGOZO2 NATURAL JOIN OSZTALY2 WHERE TELEPHELY = 'DALLAS');
-- Töröljük azokat a dolgozókat, akiknek a fizetése kisebb, mint az átlagfizetés.
DELETE FROM DOLGOZO2 WHERE FIZETES < (SELECT AVG(FIZETES) FROM DOLGOZO2);
-- Töröljük a jelenleg legjobban keresõ dolgozót.
DELETE FROM DOLGOZO2 WHERE DKOD = 
    (SELECT DKOD 
    FROM DOLGOZO2
    MINUS
    SELECT D2.DKOD 
    FROM DOLGOZO2 D1, DOLGOZO2 D2 
    WHERE D1.FIZETES > D2.FIZETES); 
-- Töröljük ki azokat az osztályokat, akiknek van olyan dolgozója, aki a 2-es fizetési 
--  kategóriába esik (lásd még Fiz_kategoria táblát).
-- (Adjuk meg azon osztályok nevét, amelyeknek van olyan dolgozója, aki a 2-es fizetési kategóriába esik)

-- Töröljük ki azon osztályokat, amelyeknek 2 olyan dolgozója van, aki a 2-es fizetési kategóriába esik.


-- INSERT

- Vigyünk fel egy 'Kovacs' nevû új dolgozót a 10-es osztályra a következõ 
  értékekkel: dkod=1, dnev='Kovacs', oazon=10, belépés=aktuális dátum,
  fizetés=a 10-es osztály átlagfizetése. A többi oszop legyen NULL.


UPDATE

-- Növeljük meg a 20-as osztályon a dolgozók fizetését 20%-kal.

-- Növeljük meg azok fizetését 500-zal, akik jutaléka NULL vagy a fizetésü
-- kisebb az átlagnál.

-- Növeljük meg mindenkinek a jutalékát a jelenlegi maximális jutalékkal. (NULL tekintsük 0-nak)

-- Módosítsuk 'Loser'-re a legrosszabbul keresõ dolgozó nevét.

-- Növeljük meg azoknak a dolgozóknak a jutalékát 3000-rel, akiknek legalább 2 közvetlen beosztottjuk van. 
-- Az ismeretlen (NULL) jutalékot vegyük úgy, mintha 0 lenne. 

-- Növeljük meg azoknak a dolgozóknak a fizetését, akiknek van beosztottja, a minimális fizetéssel

-- Növeljük meg a nem fonökök fizetését a saját osztályuk átlagfizetésével