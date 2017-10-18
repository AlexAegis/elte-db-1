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


-- 1) Kik azok a dolgozók, akik 1982.01.01 után léptek be a céghez?
-- 2) Adjuk meg azon dolgozókat, akik nevének második betûje 'A'.
-- 3) Adjuk meg azon dolgozókat, akik nevében van legalább két 'L' betû. 
-- 4) Adjuk meg a dolgozók nevének utolsó három betûjét.
-- 5) Adjuk meg a dolgozók fizetéseinek négyzetgyökét két tizedesre, és ennek egészrészét. 
-- 6) Adjuk meg, hogy hány napja dolgozik a cégnél ADAMS és milyen hónapban lépett be.
-- 7) Adjuk meg azokat a (név, fõnök) párokat, ahol a két ember neve ugyanannyi betûbõl áll. 
-- 8) Listázzuk ki a dolgozók nevét és fizetését, valamint jelenítsük meg a fizetést grafikusan
  -- a) úgy, hogy a fizetést 1000 Ft-ra kerekítve, minden 1000 Ft-ot egy '#' jel jelöl.
-- 9) Listázzuk ki azoknak a dolgozóknak a nevét, fizetését, jutalékát, és a jutalék/fizetés
  -- a) arányát, akiknek a foglalkozása eladó (salesman). Az arányt két tizedesen jelenítsük meg.


--Összesítõ függvények, csoportképzés
-----------------------------------

-- 1) Mekkora a maximális fizetés a dolgozók között?
-- 2) Mennyi a dolgozók összfizetése?
-- 3) Mennyi a 20-as osztályon az átlagfizetés?
-- 4) Adjuk meg, hogy hány különbözõ foglalkozás fordul elõ a dolgozók között. 
-- 5) Hány olyan dolgozó van, akinek a fizetése > 2000? 
-- 6) Adjuk meg osztályonként az átlagfizetést (oazon, atl_fiz).
-- 7) Adjuk meg osztályonként a telephelyet és az átlagfizetést (oazon, telephely, atl_fiz).
-- 8) Adjuk meg, hogy az egyes osztályokon hány ember dolgozik.
-- 9) Adjuk meg azokra az osztályokra az átlagfizetést, ahol ez nagyobb mint 2000.
-- 10) Adjuk meg az átlagfizetést azokon az osztályokon, ahol legalább 4-en dolgoznak (oazon, avg_fiz)
-- 11) Adjuk meg az átlagfizetést és telephelyet azokon az osztályokon, ahol legalább 4-en dolgoznak.
-- 12) Adjuk meg azon osztályok nevét és telephelyét, ahol az átlagfizetés nagyobb mint 2000. (onev, telephely)
-- 13) Adjuk meg azokat a fizetési kategóriákat, amelybe pontosan 3 dolgozó fizetése esik.
-- 14) Adjuk meg azokat a fizetési kategóriákat, amelyekbe esõ dolgozók mindannyian ugyanazon az osztályon dolgoznak.
-- 15) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek van 1-es fizetési kategóriájú dolgozója.
-- 16) Adjuk meg azon osztályok nevét és telephelyét, amelyeknek legalább 2 fõ 1-es fiz. kategóriájú dolgozója van.
-- 17) Készítsünk listát a páros és páratlan azonosítójú (dkod) dolgozók számáról.
-- 18) Listázzuk ki munkakörönként a dolgozók számát, átlagfizetését (kerekítve) numerikusan és grafikusan is.
  -- a) 200-anként jelenítsünk meg egy '#'-ot
