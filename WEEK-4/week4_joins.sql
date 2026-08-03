/*PART-A*/
USE taxation_db;
SHOW TABLES;
select * from Taxpayer;
select * from Income_Record;
select * from Income_category;
select * from Financial_Year;
SHOW CREATE TABLE Income_Record;
/*PART-B*/
/*task-1*/
select t.full_name,ir.income_source 
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id;
/*task-2*/
select t.full_name,ic.category_name
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id =ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id=ic.category_id;
/*task-3*/
SELECT ir.income_id,ir.income_source,fy.year_label
FROM Income_Record ir
INNER JOIN Financial_Year fy
ON ir.year_id=fy.year_id;
/*task-4*/
SELECT t.full_name,t.annual_income,ir.amount
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id;
/*task-5*/
SELECT t.full_name,ir.income_source,ic.category_name,fy.year_label
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id=ic.category_id
INNER JOIN Financial_Year fy
ON ir.year_id=fy.year_id
/*level-2*/
/*task-1*/
SELECT t.full_name,ir.income_source
from Taxpayer t 
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id=ic.category_id
WHERE ic.category_name='Salary';
/*task-2*/
SELECT t.full_name,t.occupation,ir.income_source
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id=ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id=ic.category_id
WHERE ic.category_name='Business';
/*task-3*/
select t.*,fy.start_date,fy.end_date
from Taxpayer t 
inner join Income_Record ir on t.taxpayer_id=ir.taxpayer_id
inner join Financial_Year fy on ir.year_id=fy.year_id;
/*task-4*/
select t.*,ic.description
from Taxpayer t 
inner join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
inner join Income_Category ic
on ir.category_id=ic.category_id;
/*task-5*/
select t.full_name,t.pan_number,t.occupation,ir.income_source,ic.category_name,ir.amount,fy.year_label,fy.start_date,fy.end_date
from Taxpayer t
inner join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
inner join Income_Category ic
on ir.category_id=ic.category_id
inner join Financial_Year fy
on ir.year_id=fy.year_id;
/*level-3*/
/*task-1*/
select t.full_name,ir.income_source
from Taxpayer t 
left outer join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id;
/*task-2*/
select ic.category_name,ir.income_id
from Income_Record ir
right outer join Income_Category ic
on ir.category_id=ic.category_id;
/*task-3*/
select t.full_name,ir.income_source
from Taxpayer t 
left join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
union
select t.full_name,ir.income_source
from Taxpayer t
right join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id;
/*task-4*/
select t.full_name,fy.year_label
from Taxpayer t
cross join Financial_Year fy;
/*task-5*/
select t1.full_name as Taxpayer1,t2.full_name as Taxpayer2,
t1.occupation
from Taxpayer t1
INNER JOIN Taxpayer t2
on t1.occupation=t2.occupation and t1.taxpayer_id<t2.taxpayer_id;
/*additional practice(optional)*/
/*task-6*/
select t.full_name,t.pan_number,ir.income_source,ic.category_name,fy.year_label
from Taxpayer t
inner join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
inner join Income_Category ic
on ir.category_id=ic.category_id
inner join Financial_Year fy
on ir.year_id=fy.year_id;
/*task-7*/
select t.full_name,ic.category_name,ic.description
from Taxpayer t 
inner join Income_record ir
on t.taxpayer_id=ir.taxpayer_id
inner join Income_Category ic
ON ir.category_id=ic.category_id;
/*task-8*/
select ir.income_source,fy.year_label
from Income_Record ir
inner join Financial_Year fy
on ir.year_id=fy.year_id;
/*task-9*/
select t.full_name,ir.income_source,ic.category_name,fy.year_label
from Taxpayer t
inner join Income_Record ir
on t.taxpayer_id=ir.taxpayer_id
inner join Income_Category ic
on ir.category_id=ic.category_id
inner join Financial_Year fy
on ir.year_id=fy.year_id
where ic.category_name='Bussiness' and fy.year_label='2025-2026';
/*task-10*/
SELECT t.taxpayer_id,
       t.full_name,
       t.pan_number,
       t.occupation,
       t.annual_income,
       ir.income_source,
       ir.income_id,
       ir.amount,
       ic.category_name,
       ic.description,
       fy.year_label,
       fy.start_date,
       fy.end_date
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id
INNER JOIN Income_Category ic
ON ir.category_id = ic.category_id
INNER JOIN Financial_Year fy
ON ir.year_id = fy.year_id;
