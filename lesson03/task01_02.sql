select nev from szeret
group by nev
having count (*) > 1;