select fizetes from dolgozo
minus
select distinct d1.fizetes
from dolgozo d1, dolgozo d2
where d1.fizetes > d2.fizetes;

--minimális fizetésû nevek listázása, házi, emailben