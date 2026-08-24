/*PART-A*/
/*level-1*/
/*task-1*/
use taxation_db;
select *  from Income_Record
where amount=(select max(amount) from Income_Record);
/*task-2*/
select * from Income_Record
where amount=(select min(amount) from Income_Record);
/*task-3*/
select * from Income_Record
where amount>(select avg(amount) from Income_Record);
/*task-4*/
select * from Income_Record
where amount=(select max(amount) from Income_Record);
/*task-5*/
select * from Taxpayer
where taxpayer_id in (select taxpayer_id from Taxpayer where occupation="Business owner");
/*Application*/
/*task-1*/
select * from taxpayer
where taxpayer_id in (select taxpayer_id from Income_Record);
/*task-2*/
select * from Taxpayer
where taxpayer_id in (select taxpayer_id from Income_Record 
where category_id IN(select category_id from Income_Category where category_name='Business'));
/*task-3*/
select * from Income_Record
where year_id in(select year_id from Financial_Year where year_label='2025-2026');
/*task-4*/
select * from Income_Record
where amount>(select min(amount) from Income_Record
              where category_id in (
                                   select category_id
                                   from Income_Category
                                   where category_name='Business')
			);
/*task-5*/
select * from Income_Record
where amount>(select max(amount) from Income_Record
              where category_id in (
                                   select category_id
                                   from Income_Category
                                   where category_name='Business')
			);
/*task-6*/
select * from Taxpayer
where taxpayer_id in(select taxpayer_id from Income_Record where amount>(select avg(amount) from Income_Record));
/*task-7*/
select * from Income_Category
where category_id in(select category_id from Income_Record);
/*task-8*/
select * from Taxpayer
where taxpayer_id NOT IN(select taxpayer_id from Income_Record
where category_id in(select category_id from Income_Category
where category_name='Investment'));
/*level-3*/
/*task-1*/
select * from Taxpayer where taxpayer_id in(select taxpayer_id from Income_Record where amount=(select max(amount) from Income_Record));
/*task-2*/
select * from Income_Record
where amount>(select avg(amount) from Income_Record
              where category_id in (
                                   select category_id
                                   from Income_Category
                                   where category_name='Business')
			);
/*task-3*/
select * from Taxpayer where taxpayer_id in(select taxpayer_id from Income_Record where amount=(select avg(amount) from Income_Record));
/*task-4*/
select * from Income_Record
where amount>Any(select amount from Income_Record where category_id in(select category_id from Income_Category where category_name='Investment'));
/*task-5*/
select * from Income_Record
where amount>All(select amount from Income_Record where category_id in(select category_id from Income_Category where category_name='Investment'));
/*task-6*/
select * from Income_Category
where category_id in(select category_id from Income_Record where amount=(select max(amount)from Income_Record));
/*task-7*/
SELECT *
FROM Financial_Year
WHERE year_id IN (
    SELECT year_id
    FROM Income_Record
    GROUP BY year_id
    HAVING SUM(amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT year_id,
                   SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY year_id
        ) AS yearly_income
    )
);
/*task-8*/
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income)
        FROM (
            SELECT taxpayer_id,
                   SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY taxpayer_id
        ) AS taxpayer_income
    )
);
/*real-world taxation analysis*/
/*task-1*/
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);
/*task-2*/
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE amount = (
        SELECT avg(amount)
        FROM Income_Record
    )
);
/*task-3*/
SELECT *
FROM Income_Category
WHERE category_id IN (
    SELECT category_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);
/*task-4*/
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Business'
    )
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);
/*task-5*/
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);
/*task-6*/
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);
/*task-7*/
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    GROUP BY taxpayer_id
    HAVING SUM(amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT taxpayer_id,
                   SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY taxpayer_id
        ) AS taxpayer_totals
    )
);
/*task-8*/
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(ir2.amount)
    FROM Income_Record ir2
    WHERE ir2.category_id = Income_Record.category_id
);
