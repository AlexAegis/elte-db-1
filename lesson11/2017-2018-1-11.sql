----------------------------------------------------------------
/*

Írjunk meg egy plsql procedúrát, amelyik veszi a dolgozókat ábácé szerinti sorrendben, 
és azon dolgozó nevét és fizetését kiírja akik többet keresnek mint a névsorban elõttük álló.
*/
CREATE OR REPLACE PROCEDURE procNevsor IS
Tesztelés:
set serveroutput on
call procNevsor();

----------------------------------------------------------------
/*

Írjunk meg egy plsql programot (név nélküli blokkot), amelyik kiírja azon dolgozók 
nevét és belépési dátumát, akik a felhasználó által megadott osztályon dolgoznak. 
A felhasználó az osztály nevének elsõ betûjét adja meg (ACCEPT-tel kérjük be). 
A program írja ki az osztály nevét is. Ha nincs megfelelõ osztály, akkor azt írja ki.

----------------------------------------------------------------
/*

Írj PL/SQL név nélküli blokkot, ami a képernyõre kiírja a Dolgozó tábla azon dolgozóinak nevét, akik foglalkozása megegyezik azzal, amit a felhasználó INPUTként megadott, a foglalkozását, és azt hogy:
 'csoro' ha a fizetés < 900	a fizetést, ha az >=900 de <1200	'gazdag' ha az >=4000

----------------------------------------------------------------
/* (módosítás)

Hozza létre a dolgozo2 táblát az dolgozo táblából, és bõvítse azt egy sorszám oszloppal. Ezt
töltse fel 1-tõl kiindulva egyesével növekvõ értékkel minden dolgozó esetén a dolgozók
nevének ábécé sorrendje szerint. 

----------------------------------------------------------------
/*

Növeljük meg a dolgozo 2 táblában a prímszám sorszámú dolgozók fizeteset 50%-kal.

----------------------------------------------------------------
/*

Töröljük a dolgozók közül a 3-mas fizetési kategóriájú fizetésûeket.

----------------------------------------------------------------
/*

Írjunk meg egy procedúrát, amelyik megnöveli azoknak a dolgozóknak a fizetését 1-el,
akiknek a fizetési kategóriája ugyanaz, mint a procedúra paramétere.
A procedúra a módosítás után írja ki a módosított (új) fizetések átlagát két tizedesjegyre kerekítve.
*/
CREATE OR REPLACE PROCEDURE kat_novel(p_kat NUMBER) IS 
Tesztelés:
set serveroutput on
call kat_novel(2);


----------------------------------------------------------------
/* (módosítás kurzorral)
Írjunk meg egy procedúrát, amelyik módosítja a paraméterében megadott osztályon a fizetéseket, és 
kiírja a dolgozó nevét és új fizetését.  A módosítás mindenki fizetéséhez adjon hozzá n*10 ezret, 
ahol n a dolgozó nevében levõ magánhangzók száma (a, e, i, o, u).
*/
CREATE OR REPLACE PROCEDURE fiz_mod(p_oazon INTEGER) IS 
Tesztelés:
set serveroutput on
call fiz_mod(10);
