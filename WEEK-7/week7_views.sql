/*part-A*/
/*level-1*/
/*task-1*/
use taxation_db;
create view highest_income as
select * from Income_Record
where amount=(
select max(amount) from Income_Record);
select * from highest_income;
/*task-2*/
create view lowest_income as
select * from Income_Record
where amount=(
select min(amount) from Income_Record);
select * from lowest_income;
/*task-3*/
create view average_income as
select * from Income_Record
where amount>(
select avg(amount) from Income_Record);
select * from average_income;
/*task-4*/
create view highest_income_records as
select * from Income_Record
where amount=(
select max(amount) from Income_Record);
select * from highest_income_records;
/*task-5*/
create view business_owner as
select * from Taxpayer where occupation='Business';
select * from business_owner;
/*level-2*/
/*task-1*/
create view taxpayer_with_income as
select * from Taxpayer
where taxpayer_id in(select taxpayer_id from Income_Record);
select * from taxpayer_with_income;
/*task-2*/
create view bussiness as
select * from taxpayer
where taxpayer_id in
(select taxpayer_id from Income_Record where category_id in
(select category_id from Income_Category where category_name='Business'));
select * from bussiness;
/*task-3*/
create view income_2025_2026 as
select ir.*
from Income_Record ir
INNER JOIN Financial_Year fy on ir.year_id=fy.year_id where fy.year_id='2025-2026';
select * from income_2025_2026;
/*task-4*/
create view greater_than_min_business as
select * from Income_Record
where amount>
(select min(amount) from income_record where category_id in
(select category_id from Income_Category where category_name='Business'));
select* from greater_than_min_business;
/*task-5*/
create view less_than_max_business as
select * from Income_Record
where amount<
(select max(amount) from income_record where category_id in
(select category_id from Income_Category where category_name='Salary'));
select* from less_than_max_business;
/*task-6*/
create view taxpayers_above_average as select distinct t.* from Taxpayer t
inner join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
where ir.amount>(select avg(amount) from Income_Record);
select* from taxpayers_above_average;
/*task-7*/
create view categories_with_income as
select * from Income_Category where category_id in (select category_id from Income_Record);
select * from categories_with_income;
/*task-8*/
create view
taxpayers_without_investment as
select t.taxpayer_id,t.full_name from Taxpayer t
where t.taxpayer_id not in (select i.taxpayer_id from Income_Record i inner join Income_Category c on i.category_id=c.category_name='Investment');
select * from taxpayers_without_investment;
/*level-3*/
/*task-1*/
CREATE VIEW highest_income_taxpayer AS
SELECT t.taxpayer_id, t.full_name, i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
select * from highest_income_taxpayer;
/*task-2*/
CREATE VIEW above_average_business_income AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);
select * from above_average_business_income;
/*task-3*/
CREATE VIEW taxpayers_above_avg_total_income AS
SELECT t.taxpayer_id, t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) x
);
SELECT * FROM taxpayers_above_avg_total_income;
/*task-4*/
CREATE VIEW greater_than_any_investment AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_any_investment;
/*task-5*/
CREATE VIEW greater_than_all_investment AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_all_investment;
/*task-6*/
CREATE VIEW category_with_highest_income AS
SELECT c.category_id, c.category_name, i.amount
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM category_with_highest_income;
/*task-7*/
CREATE VIEW highest_total_income_year AS
SELECT f.year_id,
       f.start_date,
       f.end_date,
       SUM(i.amount) AS total_income
FROM Financial_Year f
INNER JOIN Income_Record i
ON f.year_id = i.year_id
GROUP BY f.year_id, f.start_date, f.end_date
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY year_id
    ) x
);
SELECT * FROM highest_total_income_year;
/*task-8*/
CREATE VIEW taxpayers_greater_than_avg_total AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) x
);
SELECT * FROM taxpayers_greater_than_avg_total;
/*real-world taxation analysis using views*/
/*task-1*/
CREATE VIEW highest_individual_income AS
SELECT t.taxpayer_id, t.full_name, i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_individual_income;
/*task-2*/
CREATE VIEW taxpayer_above_average_income AS
SELECT DISTINCT t.taxpayer_id, t.full_name
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
SELECT * FROM taxpayer_above_average_income;
/*task-3*/
CREATE VIEW category_highest_income AS
SELECT c.category_id, c.category_name, i.amount
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM category_highest_income;
/*task-4*/
CREATE VIEW business_no_investment AS
SELECT t.taxpayer_id, t.full_name
FROM Taxpayer t
WHERE t.taxpayer_id IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
)
AND t.taxpayer_id NOT IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM business_no_investment;
/*task-5*/
CREATE VIEW greater_than_every_investmet AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_every_investmet;
/*task-6*/
CREATE VIEW greater_than_one_investment AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_one_investment;
/*task-7*/
CREATE VIEW taxpayers_highest_total_income AS
SELECT t.taxpayer_id, t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) x
);
SELECT * FROM taxpayers_highest_total_income;
/*task-8*/
CREATE VIEW income_above_category_average AS
SELECT i.income_id,
       i.taxpayer_id,
       i.category_id,
       i.amount
FROM Income_Record i
INNER JOIN (
    SELECT category_id, AVG(amount) AS avg_income
    FROM Income_Record
    GROUP BY category_id
) c
ON i.category_id = c.category_id
WHERE i.amount > c.avg_income;
SELECT * FROM income_above_category_average;
