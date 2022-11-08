/* У вас SQL база с таблицами:
1) Users(userId, age)
2) Purchases (purchaseId, userId, itemId, date)
3) Items (itemId, price).


Напишите SQL запросы для расчета следующих метрик:

А) какую сумму в среднем в месяц тратит:
- пользователи в возрастном диапазоне от 18 до 25 лет включительно
- пользователи в возрастном диапазоне от 26 до 35 лет включительно
Б) в каком месяце года выручка от пользователей в возрастном диапазоне 35+ самая большая
В) какой товар обеспечивает дает наибольший вклад в выручку за последний год
Г) топ-3 товаров по выручке и их доля в общей выручке за любой год */

drop table if exists users cascade;
create table users (
	userId serial primary key,
	age int
);

drop table if exists items cascade;
create table items (
	itemId serial primary key,
	price decimal(5, 2)
);

drop table if exists purchases cascade;
create table purchases (
	purchaseId serial primary key,
	userId int,
	itemId int,
	buy_date date,
	constraint fk_purchases_users foreign key (userId) REFERENCES users (userId),
	constraint fk_purchases_items foreign key (itemId) REFERENCES items (itemId)
);

insert into users (age)
values 
(18),
(23),
(21),
(25),
(26),
(33),
(35),
(52),
(41);

insert into items (price)
values 
(102.20),
(50.00),
(310.40),
(200.10),
(160.20);

insert into purchases (userId, itemId, buy_date)
values
(1, 2, '2022-10-08'),
(1, 1, '2022-06-18'),
(2, 1, '2022-01-11'),
(3, 4, '2022-05-09'),
(4, 4, '2022-04-07'),
(4, 5, '2022-05-25'),
(5, 4, '2021-11-04'),
(6, 1, '2021-09-18'),
(6, 5, '2022-11-04'),
(7, 3, '2022-07-14'),
(7, 5, '2022-07-02'),
(8, 3, '2022-07-30'),
(8, 1, '2022-08-01'),
(8, 2, '2022-08-15'),
(9, 2, '2021-12-31'),
(9, 1, '2022-07-01'),
(9, 1, '2021-02-14'),
(9, 1, '2021-03-08');

/*А) какую сумму в среднем в месяц тратит:
- пользователи в возрастном диапазоне от 18 до 25 лет включительно
- пользователи в возрастном диапазоне от 26 до 35 лет включительно */

--average spended for each user per each month 

with query_1 as (select u.userId, TO_CHAR(buy_date, 'Month') as Month, 
	   avg(price) as AVG_spend
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where age between 18 and 25
group by u.userId, TO_CHAR(buy_date, 'Month')),
query_2 as (select u.userId, TO_CHAR(buy_date, 'Month') as Month, 
	   avg(price) as AVG_spend
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where age between 26 and 35
group by u.userId, TO_CHAR(buy_date, 'Month'))
--average spended for all users in age group per month
select 'Для users от 18 до 25' as Средние_траты_в_мес, avg(AVG_spend)
from query_1
union
select 'Для users от 26 до 35' as Средние_траты_в_мес, avg(AVG_spend)
from query_2;


/*Б) в каком месяце года выручка от пользователей в возрастном диапазоне 
 35+ самая большая */ 

--max proceed per month include if it happens two equal months on proceed 
select TO_CHAR(buy_date, 'Month') as Months, sum(price) Summ
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where extract(year from buy_date) = 2022 and age > 35
group by TO_CHAR(buy_date, 'Month')
having sum(price) in(select max(Summ)
from
(select TO_CHAR(buy_date, 'Month') as Months, sum(price) Summ
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where extract(year from buy_date) = 2022 and age > 35
group by TO_CHAR(buy_date, 'Month')) as query_3);

/*В) какой товар обеспечивает дает наибольший вклад в выручку 
 * за последний год*/

select i.itemId Best_Item, sum(price) Max_proceed
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where extract(day from current_date::timestamp - buy_date::timestamp) <= 365
group by i.itemId
having sum(price) in(
select max(summ)
from
(select i.itemId, sum(price) summ
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
where extract(day from current_date::timestamp - buy_date::timestamp) <= 365
group by i.itemId) as query_4);

/*Г) топ-3 товаров по выручке и их доля в общей выручке за любой год */

with query_1 as (select i.itemId, sum(price)
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
group by i.itemId
order by 1, 2 desc
limit 3), -- top 3 itemsId for all time
query_2 as (select extract(year from buy_date) years, sum(price) summ_all
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
group by extract(year from buy_date)),
query_3 as (select i.itemId, extract(year from buy_date) years, sum(price) summ_item
from users u
inner join purchases p on p.userId = u.userId
inner join items i on i.itemId = p.itemId
group by i.itemId, extract(year from buy_date))
select q2.years, itemId, round(summ_item/summ_all*100, 1) as доля_выручки
from query_2 q2
inner join query_3 q3 on q2.years = q3.years
order by 1, 3 desc;



