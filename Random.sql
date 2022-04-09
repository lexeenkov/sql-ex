-- Some random exercises I did:
-- 
-- 62
SELECT name
FROM Passenger
WHERE ID_psg=SOME
(SELECT  ID_psg 
FROM Pass_in_trip
WHERE ID_psg=ANY(
SELECT ID_psg 
FROM Pass_in_trip
GROUP BY ID_psg )
GROUP BY place , ID_psg
HAVING COUNT(place)>1);

-- 71
select p.maker 
from product p 
where p.type='pc' 
group by p.maker 
having count(DISTINCT p.model)
 = (
select count(DISTINCT pc.model) 
from pc 
where pc.model in ( select DISTINCT pr.model from product pr where pr.maker=p.maker ));

-- 74
SELECT c.country , c.class
FROM Classes c
where c.country like (
CASE when (Select count(*) FROM Classes c
where c.country='Russia' GROUP BY c.country)

IS NOT NULL then ('Russia')

ELSE ('%') end);

-- 