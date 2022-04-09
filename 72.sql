-- 72
-- v.1
SELECT name , y.qty from Passenger p
JOIN (SELECT * 
FROM(
SELECT  ID_comp , ID_psg, COUNT(*) qty
FROM trip t JOIN Pass_in_trip p ON p.trip_no=t.trip_no
GROUP BY ID_psg , ID_comp
ORDER BY qty DESC) x
GROUP BY ID_psg
HAVING COUNT(*)=1) y ON p.ID_psg=y.ID_psg
WHERE y.qty= (SELECT COUNT(*) qty
FROM Pass_in_trip
GROUP BY ID_psg
ORDER BY qty DESC
LIMIT 1)
ORDER BY qty DESC
;
-- v.2 Window functions do a great job , if you know how to use them. Although, both of the versions don't work for sql-ex , guess i've got the wrong idea of exercise
SELECT name , qty FROM (
SELECT  ID_comp , ID_psg, COUNT(*) qty , RANK() OVER (Order by qty DESC) AS rk
FROM trip t JOIN Pass_in_trip p ON p.trip_no=t.trip_no
GROUP BY ID_psg , ID_comp
ORDER BY rk aSC) x JOIN PAssenger p ON x.ID_psg=p.ID_psg
WHERE rk=1
;
