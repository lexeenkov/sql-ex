-- SQL-EX.RU
-- SQL Exercises
-- SELECT (learning stage, choosing DBMS)
-- DBMS Used - MSSQL , which is strange , I'd rather use MySQL now.
/*
PROLOGUE:
I've done these exercises myself , although , I don't hesitate to share them with the community
as my proof of work and as memories of my early stages of learning. If you read these lines while 
deciding if I'm worth invitation to the interview - don't be too harsh with judgement. And if that's future me , reading that -
hello, mister, hope your're all right and living your best life.
*/

-- 1
SELECT  DISTINCT model , speed , hd
FROM PC
WHERE price<500;

-- 2 
SELECT DISTINCT maker
FROM Product
WHERE type='Printer';

-- 3
Select  distinct model , ram , screen
FROM Laptop
Where price>1000;

-- 4
Select code, model, color, type, price
From Printer
Where color='y';
-- 5
Select model, speed, hd 
from PC
where (cd='24x' or cd='12x')
AND price<600;

-- 6
Select Distinct Product.maker , Laptop.speed
From Laptop INNER JOIN Product ON
Laptop.model = Product.model
Where hd>=10;

-- 7
SELECT PC.model, price
FROM PC INNER JOIN   
     Product ON PC.model = Product.model
WHERE Product.maker='B'
UNION
SELECT Laptop.model, price 
FROM Laptop INNER JOIN   
     Product ON Laptop.model = Product.model
WHERE Product.maker='B'
UNION
SELECT Printer.model, price 
FROM Printer INNER JOIN   
     Product ON Printer.model = Product.model
WHERE Product.maker='B'

ORDER BY price DESC;
-- 8
SELECT Distinct Product.maker
FROM Product
WHERE Product.type='PC'
EXCEPT
SELECT Distinct Product.maker
FROM Product
WHERE Product.type='Laptop';

-- 9
Select DISTINCT Product.maker
FROM Product INNER JOIN PC 
ON PC.model=Product.model
WHERE PC.speed>=450;

-- 10 
SELECT Printer.model , price
FROM Printer
WHERE Printer.price=(SELECT MAX (Printer.price)
FROM PRINTER);

-- 11
SELECT AVG (PC.speed) AS Average
FROM PC;

-- 12
SELECT AVG (Laptop.speed)
FROM Laptop
WHERE Laptop.price>1000;

-- 13
Select AVG (PC.Speed)
FROM PC INNER JOIN Product 
ON Product.model=PC.model
WHERE Product.maker='A';

-- 14
SELECT Ships.class , Ships.name , Classes.country
FROM Ships INNER JOIN Classes
ON Ships.class=Classes.class
WHERE Classes.numGuns>=10;

-- 15
SELECT hd
FROM PC
GROUP BY hd 
HAVING COUNT(hd)>1;
-- 16
SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM pc a, pc b
WHERE a.ram = b.ram
AND a.speed = b.speed
AND a.model > b.model;
-- 17
SELECT DISTINCT p.type , l.model , l.speed
FROM Product p , Laptop l , PC c
WHERE l.speed < (SELECT MIN(speed) FROM PC)
AND 
      p.type = 'laptop';
-- 18
SELECT b.maker , MIN(price)
FROM Printer a INNER JOIN Product b
ON a.model=b.model
WHERE color='y'
AND price = (SELECT MIN(price) FROM Printer 
WHERE color='y')
GROUP BY b.maker;
-- 19
SELECT a.maker , AVG(b.screen)
FROM Product a INNER JOIN Laptop b
on a.model=b.model
GROUP BY a.maker;

-- 20
SELECT a.maker , COUNT(a.model)
FROM Product a
WHERE type='PC'
GROUP BY maker
HAVING COUNT(a.model)>=3;
-- 21
SELECT p.maker , MAX(t.price) as MAX
FROM Product p INNER JOIN PC t ON
p.model=t.model
GROUP BY p.maker;
-- 22
SELECT PC.speed , AVG(PC.price)
      FROM PC
WHERE PC.speed > 600
      GROUP BY PC.speed
;
-- 23
SELECT DISTINCT maker
FROM Product INNER JOIN PC p ON
p.model=Product.model
WHERE p.speed>=750
INTERSECT
SELECT DISTINCT maker
FROM Product INNER JOIN Laptop l ON
l.model=Product.model
WHERE l.speed>=750
GROUP BY maker;

-- 24
SELECT model
FROM (
SELECT model , price
FROM PC

UNION 
SELECT model , price
FROM Printer

UNION 
SELECT model , price
FROM Laptop) x
WHERE price=(Select MAX(price) FROM (SELECT model , price
FROM PC

UNION 
SELECT model , price
FROM Printer

UNION 
SELECT model , price
FROM Laptop) z)
;

-- 25
SELECT distinct product.maker FROM product WHERE product.type='Printer'  

INTERSECT 

SELECT distinct product.maker FROM product INNER JOIN pc ON pc.model=product.model  

WHERE product.type='PC' AND pc.ram=(SELECT MIN(ram) FROM pc)  

AND pc.speed = (SELECT MAX(speed) FROM (SELECT distinct speed FROM pc 

WHERE pc.ram=(SELECT MIN(ram) FROM pc)) as t) ;
-- 26
SELECT AVG(price)
FROM (
SELECT x.price , x.model
FROM Laptop x
union all
SELECT y.price , y.model
FROM PC y
) c INNER JOIN Product ON c.model=Product.model
WHERE Product.maker='A';               
-- 27
SELECT maker , AVG(hd)
FROM Product x LEFT JOIN PC a
ON x.model=a.model
WHERE x.maker IN 
(SELECT maker
FROM Product
WHERE type='printer'
GROUP BY maker)
AND x.type='pc'
GROUP BY x.maker
;
-- 28
SELECT COUNT(maker)
FROM (SELECT Product.maker
FROM Product
GROUP BY maker
HAVING COUNT(model)=1) c;
-- 29
SELECT Income_o.point , Income_o.date , inc , out
FROM Income_o LEFT JOIN Outcome_o
ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date
union
SELECT Outcome_o.point , Outcome_o.date , inc , out
FROM Income_o RIGHT JOIN Outcome_o
ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date;
COMMIT;
-- 30
select point, date, SUM(sum_out), SUM(sum_inc)
from( select point, date, SUM(inc) as sum_inc, null as sum_out from Income Group by point, date  
Union 
select point, date, null as sum_inc, SUM(out) as sum_out from Outcome Group by point, date ) as t  
group by point, date order by point;
-- 31
SELECT class , country
FROM Classes 
WHERE bore>=16;

-- 32
-- SKIP
-- 33
SELECT ship
FROM Outcomes
WHERE battle='North Atlantic'
AND result='sunk';
-- 34
SELECT name
FROM Ships a JOIN Classes b
ON b.class=a.class
WHERE a.Launched>=1922
AND b.displacement>35000
AND b.type='bb';
-- 35
SELECT model , type
FROM Product
WHERE model NOT LIKE '%[^0-9]%' OR model NOT LIKE '%[^a-z]%';
-- 36
SELECT name 
FROM Ships a INNER JOIN Classes b
ON a.name=b.class
UNION 
SELECT ship
FROM Outcomes o INNER JOIN Classes b
ON b.class=o.ship;
-- 37
select class from
(
select distinct ship, class
from
(
select o.ship, o.ship as class from outcomes o
join Classes c on c.class=o.ship
union 
Select Name as ship, class
from
ships
)
A
)A
group by
class
having count(*)=1;
-- 38
SELECT DISTINCT country
FROM Classes
WHERE type='bb'
INTERSECTION
SELECT DISTINCT country
FROM Classes
WHERE type='bc';
-- this one gives an error with INTERSECTION , but I didn't care much about it a year ago, when I did these. It worked on sql-ex, so, np for me :D
-- 39
-- SKIP , the gaps between exercises start to build up. I remebrer that i've been strugling on these
-- 42
SELECT ship, battle
FROM Outcomes
WHERE result='sunk'
-- 43
select name 
from battles 
where DATEPART(yy, date)
not in (select DATEPART(yy, date)  
from battles join ships on DATEPART(yy, date)=launched);

/* I definetely have to recollect these topics , can't remember,
when I used LIKE for the last time
*/

-- 44
SELECT name
FROM Ships
WHERE name LIKE'R%'
UNION
SELECT ship
FROM Outcomes
WHERE ship LIKE'R%';
-- 45
SELECT name 
FROM Ships
WHERE name LIKE '% % %'
UNION
SELECT ship
FROM Outcomes
WHERE ship LIKE '% % %';
-- 46 , this one is from the internet , pasting it here just to apreciate how epic and long queries can be if you work on retarded and badly structured database system. (Creators said so about "Ships" DB, not me :D)

SELECT name as n, displacement as d, numguns as ng from ships inner join classes on ships.class=classes.class where name in (select ship from outcomes where battle = 'Guadalcanal')   
union 
select ship as n, displacement as d, numguns as ng from outcomes inner join classes on outcomes.ship=classes.class where battle = 'Guadalcanal' and ship not in (select name from ships)   
union  
select ship as n, null as d, null as ng from outcomes where battle = 'Guadalcanal' and ship not in (select name from ships) and ship not in  (select class from classes)  ;

-- 47 , probably the longes querie i've wrote yet

SELECT s.country
FROM 
(SELECT COUNT(ship) as a, country
FROM
(SELECT o.ship , c.country 
FROM Outcomes o JOIN Classes c
ON o.ship=c.class
UNION 
SELECT o.ship , c.country
FROM Outcomes o JOIN Ships s
ON s.name=o.ship JOIN
Classes c
ON s.class=c.class
UNION 
SELECT s.name as ship , c.country
FROM Ships s JOIN Classes c
ON s.class=c.class) x
GROUP BY country ) s

 JOIN 

(SELECT COUNT (ship) as b, country
FROM
(SELECT o.ship , c.country 
FROM Outcomes o JOIN Classes c
ON o.ship=c.class
WHERE result='sunk'
UNION 
SELECT o.ship , c.country
FROM Outcomes o JOIN Ships s
ON s.name=o.ship JOIN
Classes c
ON s.class=c.class
WHERE result='sunk') x
GROUP BY country) f
ON f.country=s.country

WHERE a-b=0;


-- 48
SELECT c.class
FROM Outcomes o JOIN Classes c
ON o.ship=c.class
WHERE result='sunk'
UNION 
SELECT c.class
FROM Outcomes o JOIN Ships s
ON o.ship=s.name
JOIN Classes c 
ON c.class=s.class
WHERE result='sunk';

-- 49
SELECT o.ship 
FROM Outcomes o JOIN Classes c
ON o.ship=c.class
WHERE bore=16
UNION 
SELECT o.ship
FROM Outcomes o JOIN Ships s
ON o.ship=s.name
JOIN Classes c 
ON c.class=s.class
WHERE c.bore=16
UNION 
SELECT s.name
FROM Ships s JOIN Classes c
ON s.class=c.class
WHERE bore=16;

-- 50
SELECT DISTINCT battle FROM Ships s
JOIN Outcomes o ON o.ship=s.name
WHERE s.class='Kongo';

-- SKIP

-- 53

SELECT CONVERT(NUMERIC(10,2), AVG(numGuns*1.00)) 
FROM Classes
WHERE type='bb';

-- 55
SELECT classes.class, MIN(launched)
from Classes
FULL JOIN ships s ON
s.class=classes.class
GROUP BY classes.class;

/*
These were the exercises I've done during my second semester in VU. Kestutis Zilinskas, our lecturer
at the time was a funny well-aged man and I'm pretty sure that a good part of students slept during his lectures.
So did I. But I'm grateful to him - he was the first person to spark my interest to databases. Let's now
see how far can I get with that.
*/