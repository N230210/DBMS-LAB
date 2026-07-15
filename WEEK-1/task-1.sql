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
(101,'ABCDE1234F','Ravi Kumar','1995-06-15','Software Engineer',850000.00,'ravi.kumar@eexample.com',TRUE),
(102,'BCDEF2345G','Priya Sharma','1992-11-22','Doctor',120000.00,'priya.sharma@example.com',TRUE),
(103,'CDEFG3456H','Arjun Reddy','1988-03-10','Business Owner',1800000.00,'arjun.reddy@example.com',TRUE),
(104,'DEFGH4567J','Sneha Patel','1998-08-05','Teacher',620000.00,'sneha.patel@example',TRUE),
(105,'EFGHJ5678K','kiran Rao','1990-01-18','freelancer',750000.00,'kiran.ra0@example.com',TRUE),
(106,'FGHJK6789L','meera singh','1985-12-30','consultant',150000.00,'meera.singh@example.com',FALSE);
SELECT * FROM Taxpayer;
INSERT INTO Taxpayer()
VALUES(107,'AJHGF','Divya','2008-04-04','Bussiness Owner',78656.00,'div@gmail.com',TRUE);
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

USE taxation_db;
CREATE TABLE Income_Category(
	category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200) NOT NULL,
    taxable BOOLEAN NOT NULL);
INSERT INTO Income_Category(category_id,category_name,description,taxable)
VALUES
(1,'salary','income received from emplyment',TRUE),
(2,'business','income earned from business activities',TRUE),
(3,'house properly','income received from property or rent',TRUE),
(4,'capital gains','income from transfer of eligible assets',TRUE),
(5,'other sources','income such as bank intrest',TRUE),
(6,'agricultural income','income from eligible agricultural aactivities',FALSE);
SELECT * FROM Income_Category;
INSERT INTO Income_Category()
VALUES(7,'Rental Income','Income received from rental',TRUE);

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

USE taxation_db
CREATE TABLE Tax_Office(
	office_id INT PRIMARY KEY,
    office_name VARCHAR(10) NOT NULL,
    city VARCHAR(20) NOT NULL);
INSERT INTO Tax_Office()
VALUES
(1,'ads','hyderabad'),
(2,'sjkd','prakasam');
SELECT * FROM Tax_Office;
TRUNCATE TABLE Tax_Office;
DROP TABLE Tax_Office;
