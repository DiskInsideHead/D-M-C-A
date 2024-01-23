#1 (1)
SELECT PC.model, PC.speed, PC.hd
FROM PC
JOIN Product ON PC.model = Product.model
WHERE PC.price < 500 AND Product.type = 'PC'


#2 (1)
SELECT DISTINCT maker 
FROM Product  
WHERE type = 'Printer'


#3 (1)
SELECT Laptop.model, Laptop.ram, Laptop.screen
FROM Laptop
WHERE Laptop.price > 1000


#4 (1)
SELECT *
FROM Printer
WHERE color = 'y'

#5 (1)
SELECT PC.model, PC.speed, PC.hd
FROM PC
JOIN Product ON PC.model = Product.model
WHERE PC.cd IN ('12x', '24x') AND PC.price < 600

#6 (2)
SELECT DISTINCT Product.maker, Laptop.speed
FROM Product
JOIN Laptop ON Product.model = Laptop.model
WHERE Product.type = 'Laptop' AND Laptop.hd >= 10

#7 (2)
SELECT model, price
FROM PC
WHERE model IN (SELECT model FROM Product WHERE maker = 'B')

UNION

SELECT model, price
FROM Laptop
WHERE model IN (SELECT model FROM Product WHERE maker = 'B')

UNION

SELECT model, price
FROM Printer
WHERE model IN (SELECT model FROM Product WHERE maker = 'B')

#8 (2)
SELECT DISTINCT maker 
FROM Product AS p 
WHERE (SELECT COUNT(1) 
       FROM Product pt 
       WHERE pt.type = 'PC' AND 
             pt.maker = p.maker
       ) > 0 AND 
      (SELECT COUNT(1) 
       FROM Product pt 
       WHERE pt.type = 'Laptop' AND 
             pt.maker = p.maker
       ) = 0


#9 (1)
SELECT DISTINCT Product.maker
FROM Product
JOIN PC ON Product.model = PC.model
WHERE PC.speed >= 450


#10 (1)
SELECT model, price
FROM Printer
WHERE price = (SELECT MAX(price) FROM Printer)

#11 (1)
SELECT AVG(speed) AS average_speed
FROM PC


#12 (1)
SELECT AVG(speed) AS average_speed
FROM Laptop
WHERE price > 1000


#13 (1)
SELECT AVG(PC.speed) AS average_speed
FROM PC
JOIN Product ON PC.model = Product.model
WHERE Product.maker = 'A'


#14 (2)
SELECT C.class, S.name, C.country
FROM Classes C
JOIN Ships S ON C.class = S.class
WHERE C.numGuns >= 10

#15 (2)
SELECT hd AS HD
FROM PC
GROUP BY hd
HAVING COUNT(*) >= 2

#16 (2)
SELECT DISTINCT P1.model AS model1, P2.model AS model2, P1.speed, P1.ram
FROM PC P1, PC P2
WHERE P1.model > P2.model
  AND P1.speed = P2.speed
  AND P1.ram = P2.ram

#17 (2)
SELECT DISTINCT 'Laptop' AS type, model, speed
FROM Laptop
WHERE speed < ALL (SELECT speed FROM PC)

#18 (2)
SELECT

DISTINCT Pt.maker, price

FROM
Printer AS Pr

JOIN
Product AS Pt
ON Pr.model = Pt.model

WHERE
price = (SELECT MIN(price)  FROM Printer WHERE color = 'y')
AND color = 'y'


#19 (1)
SELECT P.maker, AVG(L.screen) AS avg_screen_size
FROM Product P
JOIN Laptop L ON P.model = L.model
GROUP BY P.maker
HAVING COUNT(L.model) > 0

#20 (2)
SELECT P.maker, COUNT(DISTINCT P.model) AS num_models
FROM Product P
WHERE P.type = 'PC'
GROUP BY P.maker
HAVING COUNT(DISTINCT P.model) >= 3

#21 (1)
SELECT P.maker, MAX(PC.price) AS max_price
FROM Product P
JOIN PC ON P.model = PC.model
GROUP BY P.maker

#22 (1)
SELECT speed, AVG(price) AS avg_price
FROM PC
WHERE speed > 600
GROUP BY speed


#23 (2)
SELECT DISTINCT P1.maker
FROM Product P1
JOIN PC ON P1.model = PC.model
JOIN Product P2 ON P2.maker = P1.maker
JOIN Laptop ON P2.model = Laptop.model
WHERE PC.speed >= 750 AND Laptop.speed >= 750

#24 (2)
SELECT model
FROM (
    SELECT model, price
    FROM PC
    UNION
    SELECT model, price
    FROM Laptop
    UNION
    SELECT model, price
    FROM Printer
) AS AllProducts
WHERE price = (SELECT MAX(price) FROM (
                    SELECT price FROM PC
                    UNION
                    SELECT price FROM Laptop
                    UNION
                    SELECT price FROM Printer
                ) AS AllPrices)

#25 (2)
SELECT distinct maker FROM product WHERE type = 'printer'
INTERSECT
SELECT distinct maker FROM pc inner JOIN product ON pc.model=product.model
WHERE ram = (select MIN(ram) from PC) AND SPEED = (
Select MAX(Speed) FROM PC
WHERE RAM = (SELECT MIN(RAM) FROM PC) )

#26 (2)
WITH cte_avg(price) AS(
    SELECT pc.price
    FROM PC pc
    JOIN Product p ON p.model = pc.model
    WHERE p.maker = 'A'
        UNION ALL
    SELECT l.price
    FROM Laptop l
    JOIN Product p ON p.model = l.model
    WHERE p.maker = 'A')

SELECT AVG(price) AS mean_price
FROM cte_avg

#27 (2)
SELECT P.maker, AVG(PC.hd) AS avg_hd_size
FROM Product P
JOIN PC ON P.model = PC.model
WHERE P.maker IN (
    SELECT DISTINCT maker
    FROM Product
    WHERE type = 'Printer'
)
GROUP BY P.maker

#28 (2)
SELECT COUNT(maker) AS num_single_model_producers
FROM (
    SELECT maker
    FROM Product
    GROUP BY maker
    HAVING COUNT(DISTINCT model) = 1
) AS SingleModelProducers

#29 (2)
SELECT COUNT(maker) AS num_single_model_producers
FROM (
    SELECT maker
    FROM Product
    GROUP BY maker
    HAVING COUNT(DISTINCT model) = 1
) AS SingleModelProducers

#30 (2)
SELECT point, date, 
       NULLIF(ISNULL(SUM(inc), 0), 0) AS income, 
       NULLIF(ISNULL(SUM(out), 0), 0) AS outcome
FROM (
    SELECT point, date, inc, NULL AS out
    FROM Income_o

    UNION ALL

    SELECT point, date, NULL AS inc, out
    FROM Outcome_o
) AS CombinedData
GROUP BY point, date
ORDER BY point, date

#31 (1)
SELECT DISTINCT class, country
FROM Classes
WHERE bore >= 16

#32 (3)
SELECT country , CAST(AVG(POWER(bore, 3) / 2) AS DECIMAL (6, 2)) weight FROM (SELECT country, bore, name FROM classes JOIN ships ON classes.class = ships.class 
UNION 
SELECT country, bore, ship FROM classes JOIN outcomes ON class = ship WHERE ship NOT IN (SELECT name FROM ships)) this_table GROUP BY country

#33 (1)
SELECT ship
FROM Outcomes
WHERE result = 'sunk' 
      AND battle = 'North Atlantic'

#34 (2)
SELECT name
FROM Ships
JOIN Classes ON Ships.class = Classes.class
WHERE type = 'bb' AND displacement > 35000 AND launched >= 1922 AND launched IS NOT NULL

#35 (2)
SELECT model, type
FROM Product
WHERE model NOT LIKE '%[^0-9]%'

UNION

SELECT model, type
FROM Product
WHERE model NOT LIKE '%[^A-Za-z]%'

#36 (2)
SELECT name FROM Ships
WHERE name = class

UNION 

SELECT ship FROM 
Outcomes JOIN Classes ON Classes.Class = ship


#37 (2)
SELECT class FROM (
SELECT classes.class, name FROM Ships
JOIN Classes ON classes.class = ships.class
UNION
SELECT class, ship FROM Outcomes
JOIN Classes ON ship = class) t
GROUP BY class
HAVING COUNT(class) = 1

#38 (1)
SELECT DISTINCT country
FROM Classes
WHERE type = 'bb' AND country IN (SELECT DISTINCT country FROM Classes WHERE type = 'bc')

#39 (2)
SELECT DISTINCT O1.ship
FROM Outcomes O1
JOIN Outcomes O2 ON O1.ship = O2.ship
JOIN Battles B1 ON O1.battle = B1.name
JOIN Battles B2 ON O2.battle = B2.name
WHERE O1.result = 'damaged' AND B1.date < B2.date

#40 (2)
SELECT maker, MAX(type)
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1

#41 (2)
SELECT maker, CASE WHEN MAX(CASE WHEN price IS NULL THEN 1 ELSE 0 END) = 0
THEN MAX(price) END price FROM (
SELECT maker, price FROM product JOIN pc ON pc.model = product.model
UNION
SELECT maker, price FROM product JOIN laptop ON laptop.model = product.model
UNION
SELECT maker, price FROM product JOIN printer ON printer.model = product.model
) this_table GROUP BY maker

#42 (1)
SELECT
    O.ship AS ship_name,
    O.battle AS battle_name
FROM
    Outcomes O
WHERE
    O.result = 'sunk'

#43
SELECT
    B.name AS battle_name
FROM
    Battles B
WHERE
    YEAR(B.date) NOT IN (SELECT DISTINCT S.launched FROM Ships S WHERE S.launched IS NOT NULL)

#44 (1)
SELECT name FROM Ships WHERE name LIKE 'R%'
UNION
SELECT ship FROM outcomes WHERE ship LIKE 'R%'

#45 (1)
SELECT name FROM Ships WHERE (LEN(name) - LEN(REPLACE(name, ' ', '')) + 1) > 2 
UNION
SELECT ship FROM outcomes WHERE (LEN(ship) - LEN(REPLACE(ship, ' ', '')) + 1) > 2

#46 (2)
SELECT o.ship, c.displacement, c.numGuns
FROM Outcomes o 
LEFT JOIN Ships s ON o.ship = s.name
LEFT JOIN Classes c ON s.class = c.class OR o.ship = c.class
WHERE battle = 'Guadalcanal'


#47 (3)
WITH All_ships AS (
    SELECT c.country, s.name
    FROM ships s JOIN classes c ON s.class=c.class
    UNION
    SELECT c.country, o.ship 
    FROM outcomes o JOIN classes c ON c.class=o.ship
 )
SELECT DISTINCT country FROM All_ships
WHERE country NOT IN (
 SELECT country FROM All_ships
 WHERE All_ships.name NOT IN ( SELECT ship name FROM outcomes WHERE 
  result = 'sunk')
)

#48 (2)
Select class from ships
where name IN ( select ship from outcomes where result = 'sunk')
union
select class from classes 
join outcomes on class = ship 
where result='sunk'

#49 (1)
SELECT name FROM classes JOIN ships ON classes.class = ships.class WHERE bore = 16
UNION
SELECT ship FROM classes JOIN outcomes ON ship = class WHERE bore = 16

#50 (1)
SELECT DISTINCT
    O.battle
FROM
    Outcomes O
JOIN
    Ships S ON O.ship = S.name
WHERE
    S.class = 'Kongo'


#51 (3)
with sh as (
  select name, class from ships
  union
  select ship, ship from outcomes
)
select
  name
  from sh join classes c on sh.class=c.class
  where numguns >= all(
    select ci.numguns from classes ci
      where ci.displacement=c.displacement
      and ci.class in (select sh.class from sh)
    )


#52 (2)
select
  s.name
  from ships s
  join classes c on c.class=s.class
  where country='Japan'
    and type='bb' and (numguns>=9 or numguns is null)
    and (bore<19 or bore is null)
    and (displacement<=65000 or displacement is null)


#53 (2)
select
  cast(avg(numguns*1.0) as numeric(6,2)) as "avg numguns"
  from classes
  where type='bb'


#54 (2)
select
  cast(avg(numguns*1.0) as numeric(6,2)) as "avg numguns"
  from (
    -- все корабли(которые есть в базе) и их классы
    select name, class from ships
    union
    select ship, ship from outcomes
  ) s
  join classes c on s.class=c.class
where type='bb'

#55 (2)
select
  c.class
  , min(launched) "launch year"
  from classes c
  full join ships s on c.class=s.class
  group by c.class

#56 (2)
select
  class
  , SUM(CASE WHEN result='sunk' THEN 1 ELSE 0 END) as sunks
  from (
    -- все корабли для имеющихся в базе классов кораблей
    select c.class, name from classes c
      left join ships s on c.class=s.class
    union
    select class, ship from classes
      join outcomes on class=ship
  ) as sh
  left join outcomes o on sh.name=o.ship
  group by class

#57 (3)
select
  class
  , SUM(CASE WHEN result='sunk' THEN 1 ELSE 0 END) as sunks
  from (
    select c.class, name from classes c
      join ships s on c.class=s.class
    union
    select class, ship from classes 
      join outcomes on class=ship
  ) as sh
  left join outcomes o on sh.name=o.ship
  group by class
  having
    SUM(CASE WHEN result='sunk' THEN 1 ELSE 0 END) > 0
    and (select count(si.name) from (
            select s.name, s.class from ships s
            union
            select o.ship, o.ship from outcomes o
          ) as si
        where si.class = sh.class
        group by si.class
        )>=3

#58 (3)
select distinct
  maker, type
  -- кол-во моделей каждого типа у каждого производителя
  --, count(model) over(partition by maker, type) as mod_type_count
  -- общее число моделей для каждого производителя
  --, count(model) over(partition by maker) as maker_models_total
  , cast(ROUND((
      count(model) over(partition by maker, type))*100.0/
      count(model) over(partition by maker)
    ,2) as NUMERIC(5,2))
      as 'mods of type / mods total, %'
  from (
    select
      pt.maker, pt.type, p.model
      from (
      -- Комбинация(1) всех типов моделей
      -- и всех производителей
        select distinct a.maker, b.type
        from product a, product b
      ) pt
      -- (1) соединяется с моделями.
      -- Если производитель не выпускает какой-то тип продукта
      -- то такая модель будет NULL
      left join product p on pt.maker=p.maker and pt.type=p.type
  ) as p
order by maker, type

#59 (2)
select
  coalesce(i.point,o.point) as point
  --,coalesce(i.date,o.date) as date
  --,sum(coalesce(inc,0)) as total_income
  --,sum(coalesce(out,0)) as total_outcome
  ,sum(coalesce(inc,0))-sum(coalesce(out,0)) as remain
  from income_o i
  full join outcome_o o on i.date=o.date and i.point=o.point
group by coalesce(i.point,o.point)
order by 1,2

#60 (2)
select
  coalesce(i.point,o.point) as point
  ,sum(coalesce(inc,0))-sum(coalesce(out,0)) as remain
  from income_o i
  full join outcome_o o on i.date=o.date and i.point=o.point
  -- "на начало дня" значит
  -- ДО УКАЗАННОЙ ДАТЫ (раньше указанной даты)
  where coalesce(i.date,o.date) < '2001-04-15'
group by coalesce(i.point,o.point)
order by 1,2

#61 (2)
select
  sum(coalesce(inc,0))-sum(coalesce(out,0)) as remain
  from income_o i
  full join outcome_o o on i.date=o.date and i.point=o.point

#62 (1)
select
  sum(coalesce(inc,0))-sum(coalesce(out,0)) as remain
  from income_o i
  full join outcome_o o on i.date=o.date and i.point=o.point
  where coalesce(i.date,o.date) < '2001-04-15'

#63 (2)
select name from passenger
where id_psg in (
  select
    p.id_psg
    from pass_in_trip p
    group by p.id_psg, p.place
    having count(*) > 1
)

#64 (2)
select
  coalesce(i.point,o.point) as point
  ,coalesce(i.date,o.date) as date
  ,CASE WHEN sum(inc) is not null
        THEN 'inc' ELSE 'out'
   END as operation
  ,CASE WHEN sum(inc) is not null
        THEN sum(inc)
        ELSE sum(out)
    END as money
  from income i
  full join outcome o on i.date=o.date and i.point=o.point
  group by coalesce(i.point,o.point), coalesce(i.date,o.date)
  having sum(inc) is null OR sum(out) is null
order by 1,2

#65 (3)
select
  row_number() over(order by maker) as num
  ,CASE WHEN mnum=1 THEN maker
    ELSE ''
  END as maker
  ,type
  from (
    select
    row_number() over(partition by maker order by maker, ord) as mnum
    ,maker
    ,type
    from (
    select
      distinct maker, type
      ,CASE WHEN LOWER(type)='pc' then 1
            WHEN LOWER(type)='laptop' then 2
            ELSE 3
      END as ord
      from product
    ) as mto
  ) as mtn

#66 (2)
select date, max(c) from (select date, count(*) c from trip, 
(select trip_no, date from pass_in_trip where date <= '2003-04-07' and date >= '2003-04-01' group by trip_no, date) as t1 where trip.trip_no = t1.trip_no and town_from = 'Rostov' group by t1.date
union all
select '2003-04-01', 0
union all
select '2003-04-02', 0
union all
select '2003-04-03', 0
union all
select '2003-04-04', 0
union all
select '2003-04-05', 0
union all
select '2003-04-06', 0
union all
select '2003-04-07', 0) as t2
group by t2.date

#67 (2)
with q as (
  -- подзапрос считает кол-во рейсов
  -- для каждого направления {town_from, town_to}
  select
    count(*) as c
    from trip
  group by town_from, town_to
)
-- главный запрос считает кол-во направлений
-- которые обслуживаются наибольшим числом рейсов
select count(*) as route_count from q
  where c=(select max(c) from q)

#68 (2)
with rc as (
  select
    count(*) as route_trips
    from trip
  group by
    case when town_from > town_to
          then town_from else town_to
    end
    ,case when town_from < town_to
          then town_from else town_to
    end
)
select count(*) as route_count from rc
where route_trips=(select max(route_trips) from rc)

#69 (3)
with q as (
  select
    isnull(i.point, o.point) point
    , isnull(i.date, o.date) date
    , coalesce(sum(i.inc), 0) - coalesce(sum(o.out), 0) balance
    from income i
    full join outcome o
      on i.point=o.point and i.date=o.date and i.code=o.code
    group by isnull(i.point, o.point), isnull(i.date, o.date)
)
select
  point
    -- 103 means format "dd/mm/yyyy"
  , convert(varchar, date, 103) day
  , sum(balance) over(partition by point order by date RANGE UNBOUNDED PRECEDING) as rem
  from q
order by point,date

#70 (2)
select
  distinct battle
  --, country, count(*)
  --, sh.class, sh.name
  from (
    -- все орабли и их классы, которые есть в базе
    select class, name from ships
    union
    select ship, ship from outcomes
  ) as sh
  -- для того, чтобы получить страну
  join classes c on c.class=sh.class
  -- для того, чтобы получить название битвы
  join outcomes o on o.ship=sh.name
group by battle, country
having count(sh.name) >= 3

#71 (2)
select distinct maker from Product p1
where type='PC' and not exists(
  select model from Product p2
  where p1.maker=p2.maker and p2.type='PC' and not exists(
    select model from pc where p2.model=pc.model
  )
)

#72 (2)
with q as (
  select
    pt.id_psg as id
    , count(pt.date) as trip_num
    from pass_in_trip pt join trip t on pt.trip_no=t.trip_no
  group by pt.id_psg
  -- having count(distinct t.id_comp)=1
  having max(t.id_comp)=min(t.id_comp)
)
select name, trip_num
from q join Passenger p on q.id=p.id_psg
where trip_num=(select max(trip_num) from q)

#73 (2)
with sh as (
  select class, name from ships
  union
  select ship, ship from outcomes
),
cc as (
  select name, country, battle from Classes c
  left join sh on c.class=sh.class
  join outcomes o on sh.name=o.ship
)
select distinct c.country, b.name
from classes c, battles b
where (
  select count(cc.country) from cc
  where cc.country=c.country and cc.battle=b.name
)=0

#74 (2)
select
  country, class
  from Classes
  where (country='russia' and 'russia'=ANY(select country from Classes))
      OR (country!='russia' and NOT ('russia' = ANY(select country from Classes)))

#75 (2)
Select maker, max(laptop.price) laptop, max(PC.price) PC, max(Printer.price) Printer 
    from product left join pc on product.model = pc.model
             left join laptop on product.model = laptop.model
             left join printer on product.model = printer.model
    where maker in (
        select maker from product where model in (
        select model from pc where price is not null union all 
        select model from printer where price is not null union all 
        select model from laptop where price is not null)
        )
group by product.maker

#76 (2)
with pf as(
  select id_psg, count(*) as place_count
  from pass_in_trip
  group by id_psg, place
),
pt as(
  select
    pt.id_psg, pt.trip_no
    , ps.name
    , time_out, time_in
    , CASE when time_out >= time_in
        then time_in-time_out + 1440
        else time_in-time_out
    end as time
  from pass_in_trip pt
  join passenger ps on ps.id_psg=pt.id_psg
  join (
    select
      datepart(hh, time_out)*60 + datepart(mi, time_out) time_out
      , datepart(hh, time_in)*60 + datepart(mi, time_in) time_in
      , trip_no
    from trip t
  ) as t on t.trip_no=pt.trip_no
  where 1=ALL(select place_count from pf where pf.id_psg=pt.id_psg)
)
select
  name, sum(time) fly_time
from pt
group by id_psg, name

#77 (2)
with q as (
select
  count(distinct t.trip_no) as trip_count
  , pt.date
from trip t, pass_in_trip pt
where t.trip_no=pt.trip_no
      and town_from='Rostov'
group by date
)
select
  trip_count, date
  from q
  where trip_count=(select max(trip_count) from q)

#78 (2)
select
  name
  , DATEADD(day, 1, EOMONTH(DATEADD(month, -1, date))) first_day
  , EOMONTH(date) last_day
from battles

#79 (2)
with pass_time as (
  select
    pt.id_psg
    , SUM(
      CASE when time_out >= time_in
          then datediff(mi, time_out, time_in) + 1440
          else datediff(mi,time_out, time_in)
      end
    ) as trip_time
  from pass_in_trip pt
  join trip t on t.trip_no=pt.trip_no
  group by id_psg
)
select p.name, trip_time
from pass_time pt join passenger p on pt.id_psg=p.id_psg

where trip_time=(select max(trip_time) from pass_time )


#80 (2)
select distinct maker from product
where maker not in (
  select maker from product
  where type='pc' and model not in (select model from pc)
)

#81 (2)
with q as(
  select
    *
    , sum(out) over(
        partition by year(date), month(date)
    ) as month_out
  from Outcome o
)
select code, point, date, out from q
where month_out=(select max(month_out) from q)

#82 (2)

with q as (
  select
    code
    , avg(price) over(
        order by code DESC
        rows between 5 preceding and current row
    ) as avg_price
    , row_number() over(order by code ASC) as rownum
  from pc
)
select
  code, avg_price
from q
where rownum <= (select max(rownum)-5 from q)

#83 (2)
with q as (
  select
    name
    , case numGuns when 8 then 1 else 0 end as a
    , case bore when 15 then 1 else 0 end as c
    , case displacement when 32000 then 1 else 0 end as b
    , case type when 'bb' then 1 else 0 end as d
    , case launched when 1915 then 1 else 0 end as e
    , case c.class when 'Kongo' then 1 else 0 end as f
    , case country when 'USA' then 1 else 0 end as g
  from ships s, classes c where s.class=c.class
)
select name from q where (a+b+c+d+e+f+g)>=4


#84 (2)
with q as (
  select
    t.id_comp
    , case
        when day(date) < 11 then 1
        when day(date) < 21 then 2
        when day(date) < 32 then 3
    end as decade
    , count(pt.id_psg) as psg_count
  from pass_in_trip pt
    join trip t on t.trip_no=pt.trip_no
  where year(date)=2003 and month(date)=4
  group by t.id_comp,
    case
      when day(date) < 11 then 1
      when day(date) < 21 then 2
      when day(date) < 32 then 3
    end
)
select
  distinct
  name
  , coalesce((select top 1 psg_count from q where decade=1 and q.id_comp=c.id_comp), 0) as '1'
  , coalesce((select top 1 psg_count from q where decade=2 and q.id_comp=c.id_comp), 0) as '2'
  , coalesce((select top 1 psg_count from q where decade=3 and q.id_comp=c.id_comp), 0) as '3'
from q join company c on c.id_comp=q.id_comp

-- MORE efficient solution
select
  c.name
  , SUM(iif(day(date)<11, 1, 0)) as d1
  , SUM(iif(day(date)<21 and day(date)>10, 1, 0)) as d2
  , SUM(iif(day(date)>20, 1, 0)) as d3
from pass_in_trip pt
  join trip t on pt.trip_no=t.trip_no
  join company c on c.id_comp=t.id_comp
where year(pt.date)=2003 and month(pt.date)=4
group by name


#85 (2)
select maker from product where type='printer'
except
select maker from product where type!='printer'
union (
  -- only PC makers with at least 3 models
  select maker from product where type='pc'
  group by maker
  having count(model) >= 3
  except
  select maker from product where type!='pc'
)


#86 (2)
with m as (
  select
    maker
    , max(iif(type='laptop', 'Laptop', char(20))) as lt
    , max(iif(type='pc',  'PC', char(20))) as pc
    , max(iif(type='printer', 'Printer', char(20))) as pr
  from product
  group by maker
)
select
  maker
  , replace(
      replace(
        replace(lt + '/' + pc + '/' + pr, char(20)+'/', ''), '/'+char(20), ''
    ), char(20), ''
  )
  as types
from m


#87 (2)
with t as (

  select pit.date, id_psg, t.*
  from pass_in_trip pit
  join trip t on pit.trip_no=t.trip_no
)
, fo as (

  select id_psg, min(date+time_out) as date_out
  from t group by id_psg
)
, nm as (

  select fo.id_psg
  from fo join t on fo.date_out=(t.date+t.time_out)
  where town_from!='Moscow'
)
select
  p.name, count(*)
from t join passenger p on t.id_psg=p.id_psg
where town_to='Moscow'
      and t.id_psg in (select * from nm)
group by t.id_psg, p.name
having count(*) > 1


#88 (2)
with psc as (
  select
    pit.id_psg
    , count(pit.trip_no) as trip_count
    , max(t.id_comp) as id_comp
  from pass_in_trip pit
    join trip t on pit.trip_no=t.trip_no
  group by pit.id_psg
  having count(distinct t.id_comp) = 1
)
select
  p.name, p1.trip_count, c.name
from psc p1
  join company c on p1.id_comp = c.id_comp
  join passenger p on p1.id_psg = p.id_psg
where p1.trip_count = (select max(trip_count) from psc)


#89 (1)
select Maker , count(distinct model) Qty from Product
group by maker
having count(distinct model) > = ALL
(select count(distinct model) from Product
group by maker)
or
count(distinct model) <= ALL
(select count(distinct model) from Product
group by maker)

#90 (2)
select maker, model, type from
(select
row_number() over (order by model) p1,
row_number() over (order by model DESC) p2, *
from Product
) t1
where p1 > 3 and p2 > 3


#91 (2)
select CAST(AVG(CAST(sum AS NUMERIC(6,2))) AS NUMERIC(6,2)) from (Select B_Q_ID, sum(B_VOL) as sum from utb
group by b_q_id
union
select q_id, 0 from utq where q_id not in(select b_q_id from utb))aa


#92 (2)
SELECT Q_NAME
FROM utQ
WHERE Q_ID IN (SELECT DISTINCT B.B_Q_ID
                FROM (SELECT B_Q_ID
                        FROM utB
                        GROUP BY B_Q_ID
                        HAVING SUM(B_VOL) = 765) AS B
                WHERE B.B_Q_ID NOT IN (SELECT B_Q_ID
                                        FROM utB
                                        WHERE B_V_ID IN (SELECT B_V_ID
                                                          FROM utB
                                                          GROUP BY B_V_ID
                                                          HAVING SUM(B_VOL) < 255)))


#93 (2)
select c.name, sum(vr.vr)
from
(select distinct t.id_comp, pt.trip_no, pt.date,t.time_out,t.time_in,--pt.id_psg,
case
     when DATEDIFF(mi, t.time_out,t.time_in)> 0 then DATEDIFF(mi, t.time_out,t.time_in)
     when DATEDIFF(mi, t.time_out,t.time_in)<=0 then DATEDIFF(mi, t.time_out,t.time_in+1)
end vr
from pass_in_trip pt left join trip t on pt.trip_no=t.trip_no
) vr left join company c on vr.id_comp=c.id_comp
group by c.name


#94 (2)
SELECT DATEADD(day, S.Num, D.date) AS Dt,
       (SELECT COUNT(DISTINCT P.trip_no)
        FROM Pass_in_trip P
               JOIN Trip T
                 ON P.trip_no = T.trip_no
                    AND T.town_from = 'Rostov'
                    AND P.date = DATEADD(day, S.Num, D.date)) AS Qty
FROM (SELECT (3 * ( x - 1 ) + y - 1) AS Num
        FROM (SELECT 1 AS x UNION ALL SELECT 2 UNION ALL SELECT 3) AS N1
               CROSS JOIN (SELECT 1 AS y UNION ALL SELECT 2 UNION ALL SELECT 3) AS N2
        WHERE (3 * ( x - 1 ) + y ) < 8) AS S,
       (SELECT MIN(A.date) AS date
        FROM (SELECT P.date,
                       COUNT(DISTINCT P.trip_no) AS Qty,
                       MAX(COUNT(DISTINCT P.trip_no)) OVER() AS M_Qty
                FROM Pass_in_trip AS P
                       JOIN Trip AS T
                         ON P.trip_no = T.trip_no
                            AND T.town_from = 'Rostov'
                GROUP BY P.date) AS A
        WHERE A.Qty = A.M_Qty) AS D


#95 (2)
SELECT name,
    COUNT(DISTINCT CONVERT(CHAR(24),date)+CONVERT(CHAR(4),Trip.trip_no)),
    COUNT(DISTINCT plane),
    COUNT(DISTINCT ID_psg),
    COUNT(*)
FROM Company,Pass_in_trip,Trip
WHERE Company.ID_comp=Trip.ID_comp and Trip.trip_no=Pass_in_trip.trip_no
GROUP BY Company.ID_comp,name


#96 (2)
with r as (select v.v_name,
       v.v_id,
       count(case when v_color = 'R' then 1 end) over(partition by v_id) cnt_r,
       count(case when v_color = 'B' then 1 end) over(partition by b_q_id) cnt_b
  from utV v join utB b on v.v_id = b.b_v_id)
select v_name
  from r
where cnt_r > 1
  and cnt_b > 0
group by v_name


#97 (3)
select code, speed, ram, price, screen
from laptop where exists (
  select 1 x
  from (
    select v, rank()over(order by v) rn
    from ( select cast(speed as float) sp, cast(ram as float) rm,
                  cast(price as float) pr, cast(screen as float) sc
    )l unpivot(v for c in (sp, rm, pr, sc))u
  )l pivot(max(v) for rn in ([1],[2],[3],[4]))p
  where [1]*2 <= [2] and [2]*2 <= [3] and [3]*2 <= [4]
)


#98 (3)
with CTE AS
(select
1 n, cast (0 as varchar(16)) bit_or,
code, speed, ram FROM PC
UNION ALL
select n*2,
cast (convert(bit,(speed|ram)&n) as varchar(1))+cast(bit_or as varchar(15))
, code, speed, ram
from CTE where n < 65536
)
select code, speed, ram from CTE
where n = 65536
and CHARINDEX('1111', bit_or )> 0


#99 (3)
with tbl as (select point, date, case when out is null then date else dateadd(dd, case when datename(dw,dateadd(dd, 1, date))='sunday' then 2 else 1 end, date) end date2 from (Select a.*, b.out from income_o a left join outcome_o b on a.point=b.point and a.date=b.date)aa)
select tbl.point, tbl.date, tbl.date2 from tbl
except
select tbl.point, tbl.date, tbl.date2 from tbl,outcome_o where outcome_o.point=tbl.point and tbl.date2=outcome_o.date
union
select tbl.point,tbl.date, (select dateadd(dd,case when datename(dw,min(date))='saturday' then 2 else 1 end,min(date)) from (select point, date from outcome_o where concat(point, ' ',dateadd(dd,case when datename(dw,date)='saturday' then 2 else 1 end,date)) not in (select concat (point,' ',date) from outcome_o))nn where date>=tbl.date2 and point=tbl.point) from tbl,outcome_o where outcome_o.point=tbl.point and tbl.date2=outcome_o.date


#100 (2)
Select distinct A.date , A.R, B.point, B.inc, C.point, C.out
From (Select distinct date, ROW_Number() OVER(PARTITION BY date ORDER BY code asc) as R From Income
Union Select distinct date, ROW_Number() OVER(PARTITION BY date ORDER BY code asc) From Outcome) A
LEFT Join (Select date, point, inc
                , ROW_Number() OVER(PARTITION BY date ORDER BY code asc) as RI FROM Income
           ) B on B.date=A.date and B.RI=A.R
LEFT Join (Select date, point, out
                , ROW_Number() OVER(PARTITION BY date ORDER BY code asc) as RO FROM Outcome
           ) C on C.date=A.date and C.RO=A.R


#101 (3)
SELECT code, model, color, type, price,
  MAX(model)OVER(PARTITION BY Grp)max_model,
  MAX(CASE type WHEN'Laser'THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)+
  MAX(CASE type WHEN'Matrix'THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)+
  MAX(CASE type WHEN'Jet'THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)distinct_types,
  AVG(price)OVER(PARTITION BY Grp)
FROM(
  SELECT *,
    CASE color WHEN'n'THEN 0 ELSE ROW_NUMBER()OVER(ORDER BY code)END+
    CASE color WHEN'n'THEN 1 ELSE-1 END*ROW_NUMBER()OVER(PARTITION BY color ORDER BY code)Grp
  FROM Printer
)T


#102 (2)
select name from passenger
where id_psg in
(
select id_psg from trip t,pass_in_trip pit
where t.trip_no=pit.trip_no
group by id_psg
having count(distinct case when town_from<=town_to then town_from+town_to else town_to+town_from end)=1
)


#103 (2)
Select min(t.trip_no),min(tt.trip_no),min(ttt.trip_no),max(t.trip_no),max(tt.trip_no),max(ttt.trip_no)
from trip t, trip tt, trip ttt
where tt.trip_no > t.trip_no and ttt.trip_no > tt.trip_no


#104 (2)
WITH cte AS (
    SELECT
        class,
        cast(numGuns AS int) ng,
        'bc-' + cast(numGuns AS varchar(4)) num
    FROM
        dbo.Classes
    WHERE
        TYPE = 'bc'
        AND numGuns > 0
    UNION
    ALL
    SELECT
        class,
        ng - 1,
        'bc-' + cast(ng - 1 AS varchar(4))
    FROM
        cte
    WHERE
        ng > 1
)
SELECT
    class,
    num
FROM
    cte
ORDER BY
    class,
    num


#105 (2)
select maker, model,
       row_number() over (order by maker, model),
       dense_rank() over (order by maker),
       rank() over (order by maker),
       count(*) over (order by maker)
from product


#106 (2)
with a as(
select *,row_number()over(order by b_datetime,b_q_id,b_v_id) n from utb)
select b_datetime,b_q_id,b_v_id,b_vol,
cast(exp(sm1)/exp(sm2) as numeric(12,8))k
from a x
cross apply
(select sum( iif(n%2<> 0,log(b_vol),0)) sm1,sum( iif(n%2=0,log(b_vol),0)) sm2 from a where n<=x.n)y


#107 (1)
Select name, trip_no, date
from(
select row_number() over(order by date+time_out,ID_psg) rn,name,Trip.trip_no,date
from Company,Pass_in_trip,Trip
where Company.ID_comp=Trip.ID_comp and Trip.trip_no=Pass_in_trip.trip_no
  and town_from='Rostov' and year(date)=2003 and month(date)=4)_
where rn=5


#108 (2)
SELECT DISTINCT b1.B_VOL, b2.b_vol, b3.b_vol FROM utb b1, utb b2, utb b3
WHERE b1.B_VOL < b2.B_VOL AND b2.B_VOL < b3.B_VOL
AND NOT ( b3.B_VOL > SQRT( SQUARE(b1.B_VOL) + SQUARE(b2.B_VOL)))


#109 (2)
SELECT A.Q_NAME AS q_name,
       A.Whites AS Whites,
       A.Cnt - A.Whites AS Blacks
FROM (SELECT Q.Q_ID,
               Q.Q_NAME,
               (SUM(SUM(B.B_VOL)) OVER())/765 AS Whites,
               COUNT(*) OVER() AS Cnt
        FROM utQ AS Q
               LEFT JOIN utB AS B
                      ON Q.Q_ID = B.B_Q_ID
        GROUP BY Q.Q_ID,
                  Q.Q_NAME
        HAVING SUM(B.B_VOL) = 765
                OR SUM(B.B_VOL) IS NULL) AS A


#110 (2)
select name from passenger where id_psg in
 (select id_psg
  from pass_in_trip pit join trip t on pit.trip_no = t.trip_no
  where time_in < time_out and datepart(dw, date) = 7
 )


#111 (2)
WITH Nbw AS (
    SELECT
        b_q_id,
        sum(iif(v.v_color = 'R', isnull(b_vol, 0), 0)) vR,
        sum(iif(v.v_color = 'G', isnull(b_vol, 0), 0)) vG,
        sum(iif(v.v_color = 'B', isnull(b_vol, 0), 0)) vB
    FROM
        utB b
        LEFT JOIN utV v ON v.v_id = b.b_v_id
    GROUP BY
        b_q_id
)
SELECT
    q_name,
    vR AS qty
FROM
    Nbw
    INNER JOIN utQ q ON q.q_id = nbw.b_q_id
WHERE
    (vR <> 255)
    AND vR = vB
    AND vr = vG
    AND vR > 0


#112 (3)
with cte as (
select ((count(distinct [V_ID]) * 255 - sum([B_VOL]))/ 255) as fv
from utv left join [dbo].[utB] on [utB].[B_V_ID] = [utV].[V_ID]
group by [V_COLOR])
select iif(count(*)=3,min(fv),0) as qty from cte


#113 (2)
SELECT sum(255-ISNULL ([R],0) ) R , sum(255-isnull([G],0)) G, sum(255-isnull([B],0)) B
FROM
(
/*merging all tables to find paint filling and color for all squares*/
select ISNULL(B_Q_ID, Q_ID) ID, V_COLOR, B_VOL Vol from
utB RIGHT JOIN utQ on B_Q_ID=Q_ID
LEFT JOIN utV on B_V_ID=V_ID
) as SourceT
PIVOT
(
/*rotating table and calculating each paint volume for each square*/
SUM(Vol) For V_COLOR IN ([R], [G], [B])
) Pvt
/*excluding white squares*/
where ISNULL ([R],0) + isnull([G],0) + isnull([B],0) <765


#114 (2)
WITH b AS
(SELECT ID_psg, COUNT(*) as cnt FROM Pass_In_Trip GROUP BY ID_psg, place),
b1 AS
(SELECT DISTINCT ID_psg, cnt FROM b WHERE cnt =(SELECT MAX(cnt) FROM b))
SELECT name, cnt FROM b1 JOIN Passenger p ON (b1.ID_psg = p.ID_psg)


#115 (2)
select distinct Up=u.b_vol, Down=d.b_vol, Side=s.b_vol,
Rad=cast(POWER((POWER(s.b_vol,2)-POWER((1.*d.b_vol-1.*u.b_vol)/2,2)),1./2.)/2 as dec(15,2))
  from utB u, utB d, utB s
  where u.b_vol<d.b_vol and 1.*u.b_vol+1.*d.b_vol=2.*s.b_vol


#116 (2)
SELECT MIN(D)start, MAX(D)finish
FROM
(
SELECT D, SUM(F)OVER(ORDER BY D ROWS UNBOUNDED PRECEDING)F
FROM
(
SELECT B_DATETIME D, IIF(IsNull(DATEDIFF(second, LAG(B_DATETIME)OVER(ORDER BY B_DATETIME), B_DATETIME),0)<=1,0,1)F
FROM utB
)q
)q
GROUP BY F
HAVING DATEDIFF(second,MIN(D),MAX(D))> 0


#117 (2)
Select top 1 with ties country, x, n
 from classes
cross apply(values(numguns*5000,'numguns')
                  ,(bore*3000,'bore')
                  ,(displacement,'displacement'))V(x,n)
group by country, x, n
order by rank()over(partition by country order by x desc)


#118 (2)
Select name, convert(char(10),date,120) as battle_dt
,convert(char(10),MIN(Dateadd(dd,1,dt)),120) as election_dt
From
(Select name, date, Dateadd(yy,p,Dateadd(dd,n,Dateadd(mm,3,dateadd(yy,datediff(yy,0,date),0)))) as dt
From Battles
,(values(0),(1),(2),(3),(4),(5),(6),(7),(8)) T(p)
,(values(0),(1),(2),(3),(4),(5),(6)) W(n) ) X
Where date<=dt and (Year(dt)%4=0 and Year(dt)%100> 0 or Year(dt)%400=0)
and DATEPART(dw,dt)=DATEPART(dw,'20140106')
GROUP BY name, date


#119 (2)
SELECT
    date,
    sum(b_vol) vol
FROM
    (
        SELECT
            b_vol,
            b_datetime,
            CONVERT(varchar(10), CONVERT(char(10), b_datetime, 120)) ymd,
            CONVERT(varchar(10), CONVERT(char(7), b_datetime, 120)) ym,
            CONVERT(varchar(10), CONVERT(char(4), b_datetime, 120)) y
        FROM
            utb
    ) p UNPIVOT(date FOR xxx IN(ymd, ym, y)) AS unp
GROUP BY
    date
HAVING
    count(DISTINCT b_datetime) > 10


#120 (2)
With t as
(Select ID_comp, convert(numeric(18,2), Case when time_in > = time_out
    Then datediff(minute, time_out, time_in)
    Else datediff(minute, time_out, dateadd(day, 1, time_in))
   End) as trmin
From (Select trip_no
 From Pass_in_trip
 Group by trip_no, [date]) pt join Trip t on pt.trip_no = t.trip_no
)

Select Coalesce(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean
From (
 Select Id_comp ,
  convert(numeric(18,2), avg(trmin)) A_mean,
  convert(numeric(18,2), Exp(avg(Log(trmin)))) G_mean,
  convert(numeric(18,2), sqrt(avg(trmin*trmin))) Q_mean,
  convert(numeric(18,2), count(*)/sum(1/trmin)) H_mean
 From t
 Group by ID_comp
 with cube) as a left join Company c on a.ID_comp = c.ID_comp


#121 (2)
WITH CTE AS (
SELECT s.name, launched,
CASE
WHEN launched IS null
THEN (SELECT MAX(date) FROM Battles)
ELSE MIN(date)
END AS battle_date
FROM Ships s
LEFT JOIN Battles b
ON s.launched <= YEAR(b.date)
GROUP BY s.name, launched
)
SELECT CTE.name, launched, b.name AS battle_name
FROM CTE
LEFT JOIN Battles b
ON CTE.battle_date = b.date


#122 (2)
WITH Fly AS (
    SELECT
        ID_psg,
        min(
            CONVERT(char(20), date + time_out, 127) + town_from
        ) ff,
        max(
            CONVERT(char(20), date + time_out, 127) + town_to
        ) lf
    FROM
        Pass_in_trip pit
        LEFT JOIN Trip t ON t.trip_no = pit.trip_no
    GROUP BY
        ID_psg
)
SELECT
    p.name,
    substring(ff, 21, len(ff) -21 + 1)
FROM
    Fly f
    LEFT JOIN Passenger p ON p.ID_psg = f.ID_psg
WHERE
    substring(ff, 21, len(ff) -21 + 1) <> substring(lf, 21, len(lf) -21 + 1)


#123 (2)
SELECT ROW_NUMBER() OVER(ORDER BY gp, type DESC, model), 
model,
type
FROM (
    SELECT model, type, ROW_NUMBER() OVER(ORDER BY model) AS gp
    FROM Product 
    WHERE type = 'Printer'
    UNION ALL
    SELECT model, type, (ROW_NUMBER() OVER(ORDER BY model)-1)  % (
        SELECT COUNT(model) FROM Product WHERE type = 'Printer'
    )+1 AS gp
    FROM Product
    WHERE type = 'PC'
) CTE


#124 (2)
SELECT
    (
        SELECT
            name
        FROM
            passenger
        WHERE
            id_psg = t.id_psg
    )
FROM
    (
        SELECT
            id_psg,
            id_comp,
            COUNT(*) cn
        FROM
            pass_in_trip pit
            JOIN trip t ON t.trip_no = pit.trip_no
        GROUP BY
            id_psg,
            id_comp
    ) t
GROUP BY
    id_psg
HAVING
    COUNT(*) > 1
    AND MAX(cn) = AVG(cn)


#125 (2)
with tab as (select p.id_psg, p.name, pit.trip_no, pit.date, pit.place,
row_number() over(partition by p.id_psg order by pit.date, t.time_out) num
from passenger p
join pass_in_trip pit on pit.id_psg = p.id_psg
join trip t on t.trip_no = pit.trip_no)

select t1.name
from tab t1
join tab t2 on t2.id_psg = t1.id_psg and t2.place = t1.place and t2.num = t1.num + 1
group by t1.id_psg, t1.name


#126 (2)
WITH min_max AS (
	SELECT MIN(id_psg) AS min_psg, MAX(id_psg) AS max_psg FROM Passenger
),
data AS
(
SELECT p.ID_psg, p.name, 
	DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS cnt, 
	LAG(p.name, 1, (
		SELECT p1.name from Passenger p1 where p1.id_psg = (
			SELECT max_psg FROM min_max)
			)
		) 
	OVER(ORDER by p.id_psg) AS prev, 
	LEAD(p.name, 1, (
		SELECT p1.name from Passenger p1 where p1.id_psg = (
			SELECT min_psg FROM min_max)
			)
		) 
	OVER(ORDER BY p.id_psg) AS nxt  
	FROM Pass_in_trip pit RIGHT JOIN Passenger p ON p.ID_psg = pit.ID_psg
GROUP BY p.ID_psg, p.name
)
SELECT d.name, d.prev, d.nxt FROM data d WHERE cnt = 1


#127 (3)
WITH 
dsPCD AS
    (SELECT
         p.maker
     FROM 
         PC,
         Product p
     WHERE
         p.model = PC.model and
         cast(replace(cd,'x','')as numeric) = (SELECT MIN(cast(replace(cd,'x','') as numeric)) FROM PC)
    ),
dsL AS
    (SELECT
         TOP 1  l.price 
     FROM 
         Laptop l,
         Product p
     WHERE
         p.model = l.model and
         p.maker in (SELECT maker FROM dsPCD) and
         l.price > 0
     ORDER BY l.price
    ),
dsPPr AS
    (SELECT
         p.maker
     FROM 
         Printer pr,
         Product p
     WHERE
         p.model = pr.model and
         pr.price = (SELECT MIN(price) FROM Printer)
    ),
dsPC AS
    (SELECT
         TOP 1  PC.price 
     FROM 
         PC,
         Product p
     WHERE
         p.model = PC.model and
         p.maker in (SELECT maker FROM dsPPr) and
         PC.price > 0
     ORDER BY PC.price DESC
    ),
dsPL AS
    (SELECT
         p.maker
     FROM 
         Laptop l,
         Product p
     WHERE
         p.model = l.model and
         l.ram = (SELECT MAX(RAM) FROM lAPTOP)
    ),
dsPr AS
    (SELECT
         TOP 1 pr.price 
     FROM 
         Printer pr,
         Product p
     WHERE
         p.model = pr.model and
         p.maker in (SELECT maker FROM dsPL) and
         pr.price > 0
     ORDER BY pr.price DESC
    )
SELECT
    cast(AVG(price) as NUMERIC(10,2))
FROM
    (SELECT
         price
     FROM 
         dsL
     UNION ALL
     SELECT
         price
     FROM 
         dsPC
     UNION ALL
     SELECT
         price
     FROM 
         dsPr
     ) dsPrices


#128 (2)
with
cta as (
select [point], [date], sum(out) s
from outcome
where [point] in (select point from [dbo].[Outcome_o])
group by [point], [date]),

ctb as (
select [point], [date], sum(out) s
from outcome_o
where [point] in (select point from [dbo].[Outcome])
group by [point], [date]),

ctc as (select
coalesce([cta].[point], ctb.[point]) as point,
coalesce([cta].[date], [ctb].[date]) as [date],
coalesce([cta].[s], 0) as [sa],
coalesce([ctb].[s], 0) as [sb]
from cta full join ctb on [ctb].[date] = [cta].[date] and [ctb].[point] = [cta].[point])
select
[ctc].[point],
[ctc].[date],
case
when sa > sb then 'more than once a day'
when sa < sb then 'once a day'
else 'both'
end lider
from ctc
order by [ctc].[point],[ctc].[date]


#129 (2)
WITH first_results AS (
SELECT u.Q_ID id, CASE WHEN LEAD(u.Q_ID, 1) OVER (ORDER BY u.Q_ID ASC) <> u.Q_ID + 1 THEN  LEAD(u.Q_ID, 1) OVER (ORDER BY u.Q_ID ASC) ELSE NULL END AS nxt_num  FROM utQ u
), resultset AS (
	SELECT r.id + 1 as prev, r.nxt_num - 1 as nxt from first_results r
	WHERE r.nxt_num IS NOT NULL
)
SELECT MIN(r.prev), MAX(r.nxt) FROM resultset r


#130 (2)
WITH 
dsB AS
    (SELECT 
         ROW_NUMBER() OVER (ORDER BY DATE) number1,
         name,
         date,
         NTILE(2) OVER (ORDER BY DATE) group1
     FROM 
         Battles b
    ),
dsBN AS 
     (SELECT
          *,
          ROW_NUMBER() OVER (PARTITION BY group1 ORDER BY DATE) number2
      FROM 
          dsB
     )
SELECT 
    max(iif(group1 = 1, number1, null)),
    max(iif(group1 = 1, name, null)),
    max(iif(group1 = 1, date, null)),
    max(iif(group1 = 2, number1, null)),
    max(iif(group1 = 2, name, null)),
    max(iif(group1 = 2, date, null))
FROM
    dsBN
GROUP BY 
    number2


#131 (2)
with ctea as (
select distinct town_from [town] from [dbo].[Trip] union select town_to from [dbo].[Trip]),
cteb as (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u'),
ctec as (
select [town], DATALENGTH([ctea].[town]) - DATALENGTH(replace([ctea].[town], s, '')) as cs
from ctea, cteb),
ctee as (select [town], [cs], count(*) over(partition by [ctec].[town]) cc,
max(cs) over(partition by [ctec].[town]) mxc, min(cs) over(partition by [ctec].[town]) mnc
from ctec where cs > 0)
select distinct town from ctee where cc > 1 and mxc = mnc


#132 (2)
with cte as (select trip_no,
cast(trip_no as integer) num,
cast('' as varchar(max)) str
from trip
union all
select trip_no, num / 2, concat(num % 2, str)
from cte
where num <> 0)

select trip_no, str trip_no_bit
from cte
where num = 0


#133 (2)
with tab as (select q_id, (num - 1) % 3 c_num, (num - 1) / 3 r_num
from (select q_id, row_number() over(order by q_id) num
from utq) a)

select t1.q_id X, t2.q_id Y, t3.q_id Z
from (select *
from tab
where c_num = 0) t1
left join (select *
from tab
where c_num = 1) t2 on t2.r_num = t1.r_num
left join (select *
from tab
where c_num = 2) t3 on t3.r_num = t1.r_num


#134 (2)
WITH
dsNeed AS
    (SELECT
         q.Q_ID,
         q.col color,
         255-SUM(COALESCE(b.B_VOL,0)) need,
         SUM(255-SUM(COALESCE(b.B_VOL,0))) 
               OVER (PARTITION BY q.col ORDER BY 
                         255-SUM(COALESCE(b.B_VOL,0)), q.Q_ID
                    ) sum
     FROM
         (SELECT Q_ID, Col 
          FROM (SELECT
                    Q_ID
                FROM 
                    utQ
                ) t1
                CROSS JOIN 
               (SELECT 'R' Col
                UNION ALL 
                SELECT 'G' UNION ALL
                SELECT 'B'
               ) t2
          )  q
         LEFT JOIN 
          (SELECT
               v.V_COLOR,
               b.B_Q_ID,
               SUM(b.B_VOL) B_VOL
           FROM
              utB b,utV v
              WHERE v.V_ID = b.B_V_ID  
            GROUP BY 
              v.V_COLOR,
              b.B_Q_ID 
           ) b
         ON q.Q_ID = b.B_Q_ID AND b.V_COLOR = q.Col
     GROUP BY
         q.Q_ID,
         q.col
    ),

dsHas AS
    (SELECT
         v.V_COLOR color,
         COUNT(DISTINCT v.V_ID)*255 - SUM(COALESCE(b.B_VOL,0)) has
     FROM
         utV v
         LEFT JOIN utB b
         ON v.V_ID = b.B_V_ID         
     GROUP BY
         v.V_COLOR
     )
SELECT
    DISTINCT dsNeed.Q_ID
FROM 
    dsNeed,
    dsHas
WHERE
    dsNeed.color = dsHas.color and
    dsNeed.sum > dsHas.has


#135 (1)
SELECT MAX(b_datetime) FROM utB
GROUP BY CAST(CONVERT(varchar, b_datetime, 112) + ' '+LEFT(CONVERT(varchar, B_DATETIME, 114), 2) + ':00' AS datetime2)
SELECT MAX(b_datetime) FROM utB
GROUP BY CAST(B_DATETIME AS date), DATEPART(HOUR, B_DATETIME)


#136 (2)
SELECT name,
PATINDEX('%[^a-zA-Z]%', name) as position,
SUBSTRING(name, PATINDEX('%[^a-zA-Z]%', name), 1) as non_alpha_char
FROM Ships
WHERE PATINDEX('%[^a-zA-Z]%', name) > 0


#137 (2)
SELECT mo.type,

CASE
WHEN mo.type = 'pc' THEN AVG(p.price)
WHEN mo.type = 'laptop' THEN AVG(lap.price)
WHEN mo.type = 'printer' THEN AVG(prin.price)
END avg_price

FROM
(SELECT prod.model, prod.type, prod.num
FROM
(SELECT row_number() over(ORDER BY model ASC) num, model, type
FROM Product) prod
GROUP BY prod.model, prod.type, prod.num
HAVING num%5 = 0) mo

LEFT JOIN Pc p ON mo.model = p.model
LEFT JOIN Laptop lap ON mo.model = lap.model
LEFT JOIN Printer prin ON mo.model = prin.model

GROUP BY mo.num, mo.type


#138 (4)
WITH CTE AS (
    SELECT pit.ID_psg, town_from, town_to, name
    FROM Trip t
    JOIN Pass_in_trip pit
    ON t.trip_no = pit.trip_no
    JOIN Passenger p
    ON p.ID_psg = pit.ID_psg
),
CTE2 AS (
    SELECT ID_psg, town_from AS town, name
    FROM CTE
    UNION
    SELECT ID_psg, town_to AS town, name
    FROM CTE
),
CTE3 AS (
    SELECT name, COUNT(DISTINCT town) AS num
    FROM CTE2
    GROUP BY ID_psg, name
)
SELECT name 
FROM CTE3
WHERE num = (
    SELECT MAX(num) FROM CTE3
)


#139 (2)
WITH CTE AS (
    SELECT DISTINCT country, ship
    FROM Classes c
    LEFT JOIN Ships s
    ON c.class = s.class
    JOIN Outcomes o
    ON o.ship = s.name OR o.ship = c.class
)
SELECT DISTINCT country
FROM Classes c
WHERE NOT EXISTS (
    SELECT 1
    FROM CTE
    WHERE c.country = CTE.country
)


#140 (2)
WITH nums1 AS (select 1 as n from (values(1),(1),(1),(1),(1),(1)) as d(n))
, nums2 AS (SELECT 1 as n FROM nums1 n1 CROSS JOIN nums1 n2)
, rns AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as rn FROM nums2)
, max_yrs AS (
	SELECT MIN(DATEPART(year, date)/10)*10 as min_yr, MAX(DATEPART(year, date)/10)*10 as max_yr FROM Battles
), gen_decades AS 
(
	SELECT min_yr + (rn - 1) * 10  AS yr  FROM max_yrs JOIN rns ON min_yr + (rn - 1) * 10 <= max_yr
)
SELECT CAST(gd.yr AS varchar(4)) + 's', COUNT(b.name) FROM gen_decades gd LEFT JOIN Battles b ON gd.yr = (DATEPART(year, b.date)/10)*10
GROUP BY gd.yr


#141 (2)
WITH 
dsPgs AS
     (SELECT 
          p.ID_psg, 
          IIF(DATEDIFF(DAY, min(date),'2003-04-01') > 0,
              '2003-04-01',
              min(date)
             ) mindate,
          IIF(DATEDIFF(DAY, max(date), '2003-04-30') > 0,
              max(date),
              '2003-04-30'
             )  maxdate
      FROM 
          Pass_in_trip p
      GROUP BY 
          p.ID_psg
      )
SELECT
    p.name,
    IIF(DATEDIFF(DAY, dsPgs.mindate, dsPgs.maxdate) + 1 < 0,
        0,
        DATEDIFF(DAY, dsPgs.mindate, dsPgs.maxdate) + 1
       )
FROM 
    dsPgs,
    Passenger p
WHERE
    p.ID_psg = dsPgs.ID_psg


#142 (2)
WITH 
dsPsg AS
    (SELECT 
         p.ID_psg
     FROM 
         Pass_in_trip p
         INNER JOIN Trip t
         ON t.trip_no = p.trip_no 
     GROUP BY 
         p.ID_psg
     HAVING 
         MAX(t.plane) = MIN(t.plane) AND
	 COUNT(town_to) >  COUNT(DISTINCT town_to) 
)
SELECT
    p.name
FROM 
    Passenger p
WHERE    
    p.ID_psg IN (SELECT dsPsg.ID_psg FROM dsPsg)


#143 (2)
WITH nums AS
(
	SELECT 0 AS n
	UNION ALL
	SELECT n + 1 AS n FROM nums
	WHERE n < 6
)
SELECT b.name, CAST(b.date AS date), DATEADD(day, -n , EOMONTH(b.date)) FROM Battles b JOIN Nums n
ON DATEPART(dw, DATEADD(day, -n , EOMONTH(b.date))) = DATEPART(dw, '20210326')


#144 (2)
select product.maker
from product
join pc
on product.model = pc.model
where pc.price = (
  select max(pc.price)
  from product
  join pc
  on product.model = pc.model
)
intersect
select product.maker
from product
join pc
on product.model = pc.model
where pc.price = (
  select min(pc.price)
  from product
  join pc
  on product.model = pc.model
)

-- mysql
select distinct P1.maker 
from (
  select product.maker
  from product
  join pc
  on product.model = pc.model
  where pc.price = (
    select max(pc.price)
    from product
    join pc
    on product.model = pc.model
  )
) as P1
join (
  select product.maker
  from product
  join pc
  on product.model = pc.model
  where pc.price = (
    select min(pc.price)
    from product
    join pc
    on product.model = pc.model
  )
) as P2
on P1.maker = P2.maker

-- Этот вариант неправильный, так как он не учитывает пересечение производителей
select distinct product.maker
from product
join pc
on product.model = pc.model
where pc.price = (
  select max(pc.price)
  from product
  join pc
  on product.model = pc.model
) and price = ( 
  select min(pc.price)
  from product
  join pc
  on product.model = pc.model
)


#145 (2)
WITH CTE AS (
    SELECT DISTINCT date, DENSE_RANK() OVER(ORDER BY date) AS rn
    FROM Income_o
),
CTE2 AS (
    SELECT c1.date AS start_date,
    c2.date AS end_date
    FROM CTE c1
    JOIN CTE c2
    ON c1.rn = c2.rn - 1
)
SELECT SUM(COALESCE(out,0)),start_date, end_date
FROM CTE2 c2
LEFT JOIN Outcome_o o
ON o.date > start_date AND o.date <= end_date
GROUP BY start_date, end_date


#146 (2)
WITH cte AS
(
	SELECT TOP (1) CAST(pc.cd AS VARCHAR(50)) cd, CAST(pc.hd AS VARCHAR(50)) hd, CAST(pc.model AS VARCHAR(50)) model,
	CAST(pc.price AS VARCHAR(50)) price, CAST(pc.ram AS VARCHAR(50)) ram, CAST(pc.speed AS VARCHAR(50)) speed
	FROM PC pc
	ORDER BY code DESC
)
SELECT chr, value FROM cte c
CROSS APPLY (VALUES('cd', [cd]), ('hd', [hd]), ('model', [model]), ('price', [price]), ('ram', [ram]), ('speed', [speed])) AS X(chr, value)


#147 (1)
WITH cnts AS
(
	SELECT p.maker, COUNT(*) AS cnt FROM Product p
	GROUP BY p.maker
)
SELECT ROW_NUMBER() OVER( ORDER BY c.cnt DESC, p.maker ASC, p.model ASC ), p.maker, p.model FROM Product p JOIN cnts c ON p.maker = c.maker


#148 (2)
WITH cte AS (
	SELECT o.ship, occ_1st_space.sp as frst_occ, occ_lst_space.sp AS lst_occ, LEN(o.ship) as ln FROM Outcomes o
	CROSS APPLY (VALUES
					(CHARINDEX(' ', o.ship, 1))
		) AS occ_1st_space(sp)
	CROSS APPLY (
		VALUES(
			DATALENGTH(o.ship) - CHARINDEX(' ', REVERSE(o.ship), 1 ) + 1
			)
		) AS occ_lst_space(sp)
	WHERE NOT (occ_1st_space.sp = occ_lst_space.sp OR occ_1st_space.sp = 0 OR occ_lst_space.sp = 0)
)
SELECT c.ship, STUFF(c.ship, c.frst_occ + 1, c.lst_occ - 1 - c.frst_occ , REPLICATE('*', c.lst_occ - 1 - c.frst_occ)) FROM cte c


#149 (1)
WITH CTE AS (
    SELECT b1.B_DATETIME 
    FROM UTB b1
    JOIN UTB b2
    ON b1.B_DATETIME >= b2.B_DATETIME
    GROUP BY b1.B_DATETIME
    HAVING COUNT(DISTINCT b2.B_V_ID) = (
        SELECT COUNT(DISTINCT B_V_ID) FROM UTB
    )
)
SELECT v.V_NAME
FROM UTB b
JOIN UTV v
ON b.B_V_ID = v.V_ID
WHERE b.B_DATETIME = (
    SELECT MIN(B_DATETIME) 
    FROM CTE
)
GROUP BY v.V_ID, v.V_NAME


#150 (2)
WITH CTE AS (
    SELECT point, 
    date,
    DENSE_RANK() OVER(PARTITION BY point ORDER BY date) AS min_rn,
    DENSE_RANK() OVER(PARTITION BY point ORDER BY date DESC) AS max_rn,
    DENSE_RANK() OVER(ORDER BY date) AS rn
    FROM Income
)
SELECT DISTINCT c1.point, c3.date, c1.date, c2.date, c4.date
FROM CTE c1
JOIN CTE c2
ON c1.point = c2.point
LEFT JOIN CTE c3
ON c3.rn = c1.rn - 1
LEFT JOIN CTE c4
ON c4.rn = c2.rn + 1
WHERE c1.min_rn = 1 AND c2.max_rn = 1

