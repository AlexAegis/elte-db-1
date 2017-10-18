--select dkod, dnev from dolgozo where oazon = 10 or oazon = 20;
select dkod, dnev from dolgozo where oazon = 10
union
select dkod, dnev from dolgozo where oazon = 20;