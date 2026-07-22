/*Taxpayer table*/
CREATE DATABASE taxation_db;
USE taxation_db;
CREATE TABLE Taxpayer(
	taxpayer_id INT PRIMARY KEY,
    pan_number VARCHAR(10) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    occupation VARCHAR(50) NOT NULL,
    annual_income DECIMAL(12,2) NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_active BOOLEAN );
INSERT INTO Taxpayer(taxpayer_id,pan_number,full_name,date_of_birth,occupation,annual_income,email,is_active)
VALUES
(101,'ABCDE1234','Ravi Kumar','1995-06-15','Software Engineer',850000.00,'ravi.kumar@eexample.com',TRUE),
(102,'BCDEF2345G','Priya Sharma','1992-11-22','Doctor',120000.00,'priya.sharma@example.com',TRUE),
(103,'CDEFG3456H','Arjun Reddy','1988-03-10','Business Owner',1800000.00,'arjun.reddy@example.com',TRUE),
(104,'DEFGH4567J','Sneha Patel','1998-08-05','Teacher',620000.00,'sneha.patel@example',TRUE),
(105,'EFGHJ5678K','kiran Rao','1990-01-18','freelancer',750000.00,'kiran.ra0@example.com',TRUE),
(106,'FGHJK6789L','meera singh','1985-12-30','consultant',150000.00,'meera.singh@example.com',FALSE);
SELECT * FROM Taxpayer;
INSERT INTO Taxpayer()
VALUES(107,'AJHGF','Divya','2008-04-04','Business Owner',78656.00,'div@gmail.com',TRUE);
UPDATE Taxpayer
SET annual_income=950000.00
WHERE taxpayer_id='101';
UPDATE Taxpayer
SET occupation='Software'
WHERE taxpayer_id='105'
UPDATE Taxpayer
SET is_active=TRUE
WHERE taxpayer_id='106'
DELETE FROM Taxpayer
WHERE taxpayer_id=107
ALTER TABLE Taxpayer
ADD phone_number VARCHAR(20)
ALTER TABLE Taxpayer
MODIFY occupation VARCHAR(100)
INSERT INTO Taxpayer()
VALUES
(101,'ijhb','hggbn','1999-09-09','Professor',785767.00,'uh@.com',TRUE);
/*the error occured because there we already had 101 taxpayer_id*/
INSERT INTO Taxpayer()
VALUES(89,'ABCDE1234F','kjhgvc','1997-01-02','Lecturer',788888.00,'ghj@.com',TRUE);
/*the error occured because there we already had ABCDE1234F pan_number*/
INSERT INTO Taxpayer()
VALUES(199,'ABCDE1234F','1997-01-02','uhyg',788888.00,'ghj@.com',TRUE);
/*the error occured because we used NOT NULL constaint*/

/*Income_Category table*/
USE taxation_db;
CREATE TABLE Incomecategory(
	category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200) NOT NULL,
    taxable BOOLEAN NOT NULL);
INSERT INTO Incomecategory(category_id,category_name,description,taxable)
VALUES
(1,'salary','income received from emplyment',TRUE),
(2,'business','income earned from business activities',TRUE),
(3,'house properly','income received from property or rent',TRUE),
(4,'capital gains','income from transfer of eligible assets',TRUE),
(5,'other sources','income such as bank intrest',TRUE),
(6,'agricultural income','income from eligible agricultural aactivities',FALSE);
SELECT * FROM Incomecategory;
INSERT INTO Incomecategory()
VALUES(7,'Rental Income','Income received from rental',TRUE);
/*Financial_Year table*/
USE taxation_db;
CREATE TABLE Financial_Year(
	year_id INT PRIMARY KEY,
    year_label VARCHAR(9) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    filing_deadline DATE,
    is_current BOOLEAN NOT NULL);
INSERT INTO Financial_Year(year_id,year_label,start_date,end_date,filing_deadline,is_current)
VALUES
(1,'2020-2021','2020-04-01','2021-03-31','2021-07-31',FALSE),
(2,'2021-2022','2021-04-01','2022-03-31','2022-07-31',FALSE),
(3,'2022-2023','2022-03-31','2023-07-31','2023-07-31',FALSE),
(4,'2023-2024','2023-04-01','2024-03-31','2024-07-31',FALSE),
(5,'2024-2025','2024-04-01','2025-03-31','2025-07-31',FALSE),
(6,'2025-2026','2025-04-01','2026-03-31','2026-07-31',TRUE);
SELECT * FROM Financial_Year;
/*Income_Record*/
USE taxation_db;
CREATE TABLE Income_Record (
    income_id INT PRIMARY KEY,
    taxpayer_id INT NOT NULL,
    income_source VARCHAR(100) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    received_date DATE NOT NULL,
    financial_year VARCHAR(9) NOT NULL);
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_name, amount, received_date, financial_year)
VALUES
(1001, 101, 'TechNova Solutions', 'Salary', 850000.00, '2026-03-31', '2025-2026'),
(1002, 102, 'City Care Hospital', 'Salary', 1200000.00, '2026-03-31', '2025-2026'),
(1003, 103, 'Reddy Enterprises', 'Business', 1800000.00, '2026-03-31', '2025-2026'),
(1004, 104, 'Sunrise School', 'Salary', 620000.00, '2026-03-31', '2025-2026'),
(1005, 105, 'Web Design Projects', 'Business', 750000.00, '2026-03-31', '2025-2026'),
(1006, 106, 'Professional Consulting', 'Business', 1500000.00, '2026-03-31', '2025-2026');
SELECT * FROM Income_Record;
ALTER TABLE Income_Record
ADD remarks VARCHAR(20)
ALTER TABLE Income_Record
drop category_name;
ALTER TABLE Income_Record
drop financial_year;
ALTER TABLE Income_Record
ADD category_id INT;
ALTER TABLE Income_Record
ADD year_id INT;
ALTER TABLE Income_Record
ADD constraint fk_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES Taxpayer(taxpayer_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES Income_Category(category_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_year
FOREIGN KEY (year_id)
REFERENCES Financial_Year(year_id);
UPDATE Income_Record
SET category_id=1,year_id=6
WHERE income_id=1001;
UPDATE Income_Record
SET category_id=1,year_id=6
WHERE income_id=1002;
UPDATE Income_Record
SET category_id=2,year_id=6
WHERE income_id=1003;
UPDATE Income_Record
SET category_id=1,year_id=6
WHERE income_id=1004;
UPDATE Income_Record
SET category_id=2,year_id=6
WHERE income_id=1005;
UPDATE Income_Record
SET category_id=2,year_id=6
WHERE income_id=1006;
/*PART-B*/
/*task-1*/
INSERT INTO Income_Record()
VALUES(1007,999,'ABC company',25000,'2026-03-31',1,6);
/* error occurs because taxpayer_id=999 is not in Taxpayer table,so the foreigh key constraint rejects it*/
/*task-2*/
INSERT INTO Income_Record()
VALUES(1008,'XYZ pvt Ltd',30000,'2026-03-31',20,6);
/*category_id=20 is not present in Income_Category table*/
/*task-3*/
INSERT INTO Income_Record()
VALUES(1009,'ABC ltd',3500,'2026-03-31',2,15);
/*year_id=15 does not exist in the financial_year table*/
/*task-4*/
DELETE FROM Taxpayer
WHERE taxpayer_id=101;
/*that taxpayer is referenced by records in Income_Record*/
/*task-5*/
DELETE FROM Incomecategory
WHERE category_id=1;
/*category_id=1 is already referenced by records in Income_Record*/
/* task-6
1. What is a Foreign Key?
A Foreign Key is a column in one table that refers to the Primary Key of another table. It creates a relationship between the two tables.
2. What is Referential Integrity?
Referential Integrity ensures that every foreign key value matches an existing primary key value in the parent table. This prevents invalid or orphan records.
3. Why are Foreign Keys required?
They maintain data accuracy.
They prevent invalid entries.
They establish relationships between tables.
They improve database consistency.*/
/*PART-C*/
/*task-1*/
SELECT DISTINCT occupation
FROM Taxpayer;
/*task-2*/
SELECT DISTINCT category_name
FROM Incomecategory;
/*task-3*/
SELECT DISTINCT year_label
FROM Financial_Year;
/*task-4*/
SELECT DISTINCT income_source
FROM Income_Record;
/*PART-D*/
/*task-1*/
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.category_id = 1
UNION
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.category_id = 2;
/*task-2*/
SELECT income_source
FROM Income_Record
WHERE year_id = 5
UNION
SELECT income_source
FROM Income_Record
WHERE year_id = 6;
/*task-3*/
SELECT full_name
FROM Taxpayer
WHERE occupation = 'Teacher'
UNION
SELECT full_name
FROM Taxpayer
WHERE occupation = 'Software Engineer';
/*PART-E*/
/*task-1*/
SELECT DISTINCT t.full_name
FROM Taxpayer t
JOIN Income_Record i1 ON t.taxpayer_id = i1.taxpayer_id
JOIN Income_Record i2 ON t.taxpayer_id = i2.taxpayer_id
WHERE i1.category_id = 1
AND i2.category_id = 2;
/*task-2*/
SELECT DISTINCT t.full_name
FROM Taxpayer t
JOIN Income_Record i1 ON t.taxpayer_id = i1.taxpayer_id
JOIN Income_Record i2 ON t.taxpayer_id = i2.taxpayer_id
WHERE i1.year_id = 5
AND i2.year_id = 6;
/*PART-F*/
/*task-1*/
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.category_id = 1
EXCEPT
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.category_id = 2;
/*task-2*/
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.year_id = 6
EXCEPT
SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.year_id = 5;
/*PART-G*/
/*task-1*/
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
);
/*task-2*/
SELECT full_name
FROM Taxpayer
WHERE occupation IN (
    SELECT t.occupation
    FROM Taxpayer t
    JOIN Income_Record i
    ON t.taxpayer_id = i.taxpayer_id
    WHERE i.category_id = 2
);
/*PART-H*/
/*task-1*/
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);
/*task-2*/
SELECT DISTINCT occupation
FROM Taxpayer
WHERE occupation NOT IN (
    SELECT DISTINCT t.occupation
    FROM Taxpayer t
    JOIN Income_Record i
    ON t.taxpayer_id = i.taxpayer_id
);
/*PART-I*/
/*task-1*/
SELECT full_name
FROM Taxpayer t
WHERE EXISTS (
    SELECT *
    FROM Income_Record i
    WHERE t.taxpayer_id = i.taxpayer_id
);
/*task-2*/
SELECT year_label
FROM Financial_Year f
WHERE EXISTS (
    SELECT *
    FROM Income_Record i
    WHERE f.year_id = i.year_id
);
/*PART-J*/
/*Task 1*/

SELECT full_name
FROM Taxpayer t
WHERE NOT EXISTS (
    SELECT 1
    FROM Income_Record i
    WHERE t.taxpayer_id = i.taxpayer_id
);

/* Task 2*/

SELECT category_name
FROM IncomeCategory c
WHERE NOT EXISTS (
    SELECT 1
    FROM Income_Record i
    WHERE c.category_id = i.category_id
);
/*PART-K*/
/* Task 1*/

SELECT full_name
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);

/* Task 2*/

SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE t.annual_income > ANY (
    SELECT t2.annual_income
    FROM Taxpayer t2
    JOIN Income_Record i2
    ON t2.taxpayer_id = i2.taxpayer_id
    WHERE i2.category_id = 2
);
/*PART-L*/
/*Task 1*/

SELECT full_name
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);


/*Task 2*/

SELECT t.full_name
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE t.annual_income > ALL (
    SELECT t2.annual_income
    FROM Taxpayer t2
    JOIN Income_Record i2
    ON t2.taxpayer_id = i2.taxpayer_id
    WHERE i2.category_id = 2
);
/*PART-M*/
/* 1.display all taxpayers in ascending order of name */
SELECT *
FROM Taxpayer
ORDER BY full_name ASC;

/* 2. Display taxpayers whose annual income is greater than ₹8,00,000 */
SELECT *
FROM Taxpayer
WHERE annual_income > 800000;

/* 3. Display taxpayers whose occupation is Software Engineer */
SELECT *
FROM Taxpayer
WHERE occupation = 'Software Engineer';

/* 4. Display all income records belonging to the Business category */
SELECT *
FROM Income_Record
WHERE category_id = 2;

/* 5. Display income records with amounts between ₹5,00,000 and ₹10,00,000 */
SELECT *
FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;

/* 6. Display taxpayers whose names start with the letter A */
SELECT *
FROM Taxpayer
WHERE full_name LIKE 'A%';

/* 7. Display all taxpayers from a particular village or city */
/* Taxpayer table does not have a city/village column, so this query cannot be written. */

/* 8. Display all active taxpayers */
SELECT *
FROM Taxpayer
WHERE is_active = TRUE;

/* 9. Display the total number of taxpayers */
SELECT COUNT(*) AS total_taxpayers
FROM Taxpayer;

/* 10. Display the highest annual income recorded */
SELECT MAX(annual_income) AS highest_income
FROM Taxpayer;
/*PART-N*/
/* 1. Which taxpayer has the highest annual income? */
SELECT full_name, annual_income
FROM Taxpayer
WHERE annual_income = (
    SELECT MAX(annual_income)
    FROM Taxpayer
);

/* 2. Which income category contains the highest number of income records? */
SELECT c.category_name, COUNT(*) AS total_records
FROM IncomeCategory c
JOIN Income_Record i
ON c.category_id = i.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_records DESC
LIMIT 1;

/* 3. How many taxpayers belong to each occupation? */
SELECT occupation, COUNT(*) AS total_taxpayers
FROM Taxpayer
GROUP BY occupation;

/* 4. How many taxpayers are currently active? */
SELECT COUNT(*) AS active_taxpayers
FROM Taxpayer
WHERE is_active = TRUE;

/* 5. Which financial year contains the highest number of income records? */
SELECT f.year_label, COUNT(*) AS total_records
FROM Financial_Year f
JOIN Income_Record i
ON f.year_id = i.year_id
GROUP BY f.year_id, f.year_label
ORDER BY total_records DESC
LIMIT 1;
