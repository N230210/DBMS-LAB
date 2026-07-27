/*PART_A*/
USE taxation_db;
SHOW TABLES;
SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;
SELECT * FROM Tax_Office;
/*PART -B*/
/*Level-1*/
SELECT UPPER(full_name) AS
full_name
FROM Taxpayer;
SELECT LOWER(occupation) AS
occupation
FROM Taxpayer;
SELECT full_name,LENGTH(full_name) AS
length
FROM Taxpayer;
SELECT pan_number,
SUBSTRING(pan_number,1,4)as
first_four
FROM Taxpayer;
SELECT CONCAT(full_name,'-',occupation) AS
details
FROM Taxpayer;
/*Level-2*/
SELECT REPLACE(category_name,'Income','Inc.')AS
category
FROM Income_Category;
SELECT TRIM(full_name) as
taxpayer_name
FROM Taxpayer;
select SUBSTRING(full_name,1,LOCATE(' ',full_name)-1) as
first_name
FROM Taxpayer;
/*Level-3*/
select concat(
'Taxpayer :',full_name,'\n Occupation :',occupation)AS
details
FROM Taxpayer;
select pan_number
FROM Taxpayer
WHERE LEFT(pan_number,2)='AP';
/*PART-C*/
/*Level-1*/
SELECT annual_income,
round(annual_income)AS
rounded_income
from Taxpayer;
select annual_income,
ABS(annual_income-500000)AS
absolute_difference
FROM Taxpayer;
select annual_income,
POWER(annual_income,2)AS
square_income
FROM Taxpayer;
/*level-2*/
select annual_income,
MOD(annual_income,1000)as
remaider
from Taxpayer;
select annual_income,
round(annual_income,2)AS
rounded_income
from Taxpayer;
select annual_income,
ceil(annual_income) as
ceiling_value,
floor(annual_income) as
floor_value
from Taxpayer;
/*level-3*/
select floor(rand()*100)+1 AS
random_number;
select annual_income,sqrt(annual_income) AS square_root
FROM Taxpayer;
select annual_income,
annual_income*1.10 as
increased_income
from Taxpayer;
/*PART-D*/
/*Level-1*/
SELECT curdate() as today_date;
select now() as current_date_time;
select start_date,
year(start_date)as year
from Financial_Year;
select start_date,
month(start_date) as month
from Financial_Year;
select start_date,
day(start_date) as day
from Financial_Year;
/*level-2*/
select start_date,
DATE_ADD(start_date,INTERVAL 1 YEAR)AS end_date
FROM Financial_Year;
select start_date,
DATE_ADD(start_date,INTERVAL 30 DAY)as after_30_days
from Financial_Year;
select start_date,
DATE_SUB(start_date,INTERVAL 7 DAY)as before_7_days
from Financial_Year;
/*Level-3*/
select start_date,DATEDIFF(CURDATE(),start_date)AS
days_difference
FROM Financial_Year;
select *
from Financial_Year
where year(start_date)=year(CURDATE());
/*PART-E*/
/*LEVEL-1*/
select annual_income,
cast(annual_income as signed)as
integer_income
from Taxpayer;
select taxpayer_id,
cast(taxpayer_id as char)as
taxpayer_char
from Taxpayer;
/*Level-2*/
select start_date,
cast(start_date as datetime) as 
start_datetime
from Financial_Year;
select annual_income,
cast(annual_income as
decimal(12,2)) as decimal_income
from Taxpayer;
/*Level-3*/
select annual_income,
cast(annual_income as char)as
income_string
from Taxpayer;
select annual_income,
cast(annual_income as
decimal(12,2)) *0.10 as
tax_amount
from Taxpayer;
