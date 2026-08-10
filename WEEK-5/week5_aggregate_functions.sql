/*part-A*/
use taxation_db;
SHOW TABLES;
select * from Taxpayer;
select * from Income_Record;
select * from Income_category;
select * from Financial_Year;
/*part-B*/
/*level-1*/
/*task-1*/
select count(*)
from Income_Record;
/*task-2*/
select sum(amount)
from Income_Record;
/*task-3*/
select avg(amount)
from Income_Record;
/*task-4*/
select max(amount)
from Income_Record;
/*task-5*/
select min(amount)
from Income_Record;
/*level-2*/
/*task-1*/
select  category_id,count(*) as
number_of_records
from Income_Record
group by category_id;
/*task-2*/
select category_id,sum(amount)
as total_income
from Income_Record
group by category_id;
/*task-3*/
select category_id,avg(amount)
as total_income
from Income_Record
group by category_id;
/*task-4*/
select category_id,max(amount)
as max_income
from Income_Record
group by category_id;
/*task-5*/
select category_id,min(amount)
as min_income
from Income_Record
group by category_id;
/*task-6*/
select year_id,sum(amount)
as total_income
from Income_Record
group by year_id;
/*task-7*/
select year_id,count(*)
as no_of_records
from Income_Record
group by year_id;
/*task-8*/
select category_id,year_id,sum(amount)
as total_income
from Income_Record
group by category_id,year_id;
/*level-3*/
/*task-1*/
select category_id,sum(amount)
from Income_Record
group by category_id
having sum(amount)>1000000;
/*task-2*/
select category_id,avg(amount)
from Income_Record
group by category_id
having avg(amount)>500000;
/*task-3*/
select category_id,count(amount)
from Income_Record
group by category_id
having count(amount)>3;
/*task-4*/
select category_id,sum(amount)
from Income_Record
group by category_id
order by sum(amount) desc;
/*task-5*/
select category_id,sum(amount)
from Income_Record
group by category_id
having sum(amount)>1000000
order by sum(amount) desc;
/*task-6*/
select category_id,sum(amount) as total,avg(amount) as average
from Income_Record
group by category_id;
/*task-7*/
select category_id,year_id,sum(amount)
as total_income
from Income_Record
group by category_id,year_id
order by sum(amount) desc;
/*task-8*/
select ir.year_id,count(distinct ir.taxpayer_id) as 
number_of_taxpayers 
from Income_Record ir
join Taxpayer t
on ir.taxpayer_id=t.taxpayer_id
group by ir.year_id;
/*real-world taxation analysis*/
/*task-1*/
select category_id,sum(amount) as total
from Income_Record
group by category_id
order by sum(amount) desc
limit 1;
/*task-2*/
select year_id,sum(amount) as total
from Income_Record
group by year_id
order by sum(amount) desc
limit 1;
/*task-3*/
select category_id,avg(amount) as average
from Income_Record
group by category_id
order by avg(amount) desc
limit 1;
/*task-4*/
select category_id,count(*) as
no_of_records
from Income_Record
group by category_id
having count(*)>2;
/*task-5*/
select year_id,sum(amount)
as total 
from Income_Record
group by year_id
having sum(amount)>1000000;
/*task-6*/
select category_id,count(*) as
no_of_records,
sum(amount) as total,
avg(amount) as average,
max(amount) as maximum,
min(amount) as minimum
from Income_Record
group by category_id;
