USE taxation_db;
-- task-1:
DROP PROCEDURE IF EXISTS welcome_taxation;
DELIMITER //
CREATE PROCEDURE welcome_taxation()
BEGIN
    SELECT 'Welcome to TaxationDB' AS Message;
END //

DELIMITER ;
CALL welcome_taxation();
-- TASK 2: Welcome Message
DROP PROCEDURE IF EXISTS welcome_taxation;
DELIMITER //
CREATE PROCEDURE welcome_taxation()
BEGIN
    SELECT 'Welcome to TaxationDB' AS Message;
END //
DELIMITER ;
CALL welcome_taxation();
-- TASK 4 & TASK 5: Retrieve Taxpayer Income
DROP PROCEDURE IF EXISTS get_taxpayer_income;
DELIMITER //
CREATE PROCEDURE get_taxpayer_income(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    SELECT v_name AS Taxpayer_Name,
           v_income AS Annual_Income;
END //

DELIMITER ;

CALL get_taxpayer_income(1);
-- QUESTION 1: Calculate 10% of Annual Income

DROP PROCEDURE IF EXISTS calculate_ten_percent;
DELIMITER //
CREATE PROCEDURE calculate_ten_percent(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_income DECIMAL(12,2);
    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
    SELECT v_income AS Annual_Income,
           v_income * 0.10 AS Ten_Percent_Income;
END //
DELIMITER ;
CALL calculate_ten_percent(1);
-- QUESTION 2: Display Taxpayer Details
DROP PROCEDURE IF EXISTS display_taxpayer_details;
DELIMITER //
CREATE PROCEDURE display_taxpayer_details(IN p_taxpayer_id INT)
BEGIN
    SELECT full_name AS Taxpayer_Name,
           pan_number AS PAN_Number,
           occupation AS Occupation,
           annual_income AS Annual_Income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
END //

DELIMITER ;

CALL display_taxpayer_details(1);
-- QUESTION 3: Check Active or Inactive Status
DROP PROCEDURE IF EXISTS check_taxpayer_status;
DELIMITER //
CREATE PROCEDURE check_taxpayer_status(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_active INT;

    SELECT is_active
    INTO v_active
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_active = 1 THEN
        SELECT 'Active' AS Taxpayer_Status;
    ELSE
        SELECT 'Inactive' AS Taxpayer_Status;
    END IF;
END //

DELIMITER ;

CALL check_taxpayer_status(1);
-- QUESTION 4: Function to Check Taxable Income
DROP FUNCTION IF EXISTS check_taxable;
DELIMITER //
CREATE FUNCTION check_taxable(p_income DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_income > 0 THEN
        RETURN 'Taxable';
    ELSE
        RETURN 'Non-Taxable';
    END IF;
END //
DELIMITER ;
SELECT check_taxable(500000) AS Tax_Status;
-- QUESTION 5: Display Numbers from 1 to 10
DROP PROCEDURE IF EXISTS display_numbers;
DELIMITER //
CREATE PROCEDURE display_numbers()
BEGIN
    DECLARE v_count INT DEFAULT 1;

    number_loop: LOOP
        SELECT v_count AS Number;

        SET v_count = v_count + 1;

        IF v_count > 10 THEN
            LEAVE number_loop;
        END IF;
    END LOOP;
END //

DELIMITER ;

CALL display_numbers();
-- LEVEL 1
-- QUESTION 1: Classify Taxpayer Income
DROP PROCEDURE IF EXISTS classify_taxpayer_income;
DELIMITER //
CREATE PROCEDURE classify_taxpayer_income(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_income DECIMAL(12,2);

    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_income > 1000000 THEN
        SELECT 'High Income' AS Income_Category;
    ELSEIF v_income >= 500000 THEN
        SELECT 'Medium Income' AS Income_Category;
    ELSE
        SELECT 'Low Income' AS Income_Category;
    END IF;
END //

DELIMITER ;

CALL classify_taxpayer_income(1);
-- QUESTION 2: Function to Return Annual Income
DROP FUNCTION IF EXISTS get_annual_income;
DELIMITER //
CREATE FUNCTION get_annual_income(p_taxpayer_id INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE v_income DECIMAL(12,2);

    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    RETURN v_income;
END //

DELIMITER ;

SELECT full_name,
       get_annual_income(taxpayer_id) AS annual_income
FROM Taxpayer;
-- LEVEL 2
-- QUESTION 1: Cursor for Active Taxpayers
DROP PROCEDURE IF EXISTS display_active_taxpayers;
DELIMITER //
CREATE PROCEDURE display_active_taxpayers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_occupation VARCHAR(100);

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income, occupation
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN taxpayer_cursor;

    read_loop: LOOP
        FETCH taxpayer_cursor
        INTO v_name, v_income, v_occupation;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_name AS Taxpayer_Name,
               v_income AS Annual_Income,
               v_occupation AS Occupation;
    END LOOP;

    CLOSE taxpayer_cursor;
END //

DELIMITER ;

CALL display_active_taxpayers();
-- QUESTION 2: Exception Handling for Taxpayer
DROP PROCEDURE IF EXISTS find_taxpayer;
DELIMITER //
CREATE PROCEDURE find_taxpayer(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_not_found INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = 1;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found = 1 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SELECT v_name AS Taxpayer_Name,
               v_income AS Annual_Income;
    END IF;
END //

DELIMITER ;

CALL find_taxpayer(101);
-- OPTIONAL QUESTIONS
-- OPTIONAL 1: Update Annual Income
DROP PROCEDURE IF EXISTS update_taxpayer_income;

DELIMITER //

CREATE PROCEDURE update_taxpayer_income(
    IN p_taxpayer_id INT,
    IN p_new_income DECIMAL(12,2)
)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Taxpayer
        WHERE taxpayer_id = p_taxpayer_id
    ) THEN
        UPDATE Taxpayer
        SET annual_income = p_new_income
        WHERE taxpayer_id = p_taxpayer_id;

        SELECT 'Income updated successfully' AS Message;
    ELSE
        SELECT 'Taxpayer not found' AS Message;
    END IF;
END //

DELIMITER ;
CALL update_taxpayer_income(1, 800000);
-- OPTIONAL 2: CASE Income Classification
DROP PROCEDURE IF EXISTS classify_income_case;
DELIMITER //
CREATE PROCEDURE classify_income_case(IN p_income DECIMAL(12,2))
BEGIN
    CASE
        WHEN p_income > 1000000 THEN
            SELECT 'High' AS Income_Category;
        WHEN p_income >= 500000 THEN
            SELECT 'Medium' AS Income_Category;
        ELSE
            SELECT 'Low' AS Income_Category;
    END CASE;
END //

DELIMITER ;

CALL classify_income_case(850000);
-- OPTIONAL 3: Display Income Records
DROP PROCEDURE IF EXISTS display_taxpayer_income_records;
DELIMITER //
CREATE PROCEDURE display_taxpayer_income_records(IN p_taxpayer_id INT)
BEGIN
    SELECT income_source AS `Income Source`,
           category_id AS `Category`,
           amount AS `Amount`,
           received_date AS `Received Date`,
           year_id AS `Financial Year`
    FROM Income_Record
    WHERE taxpayer_id = p_taxpayer_id;
END //
DELIMITER ;
CALL display_taxpayer_income_records(101);
-- OPTIONAL 4: Cursor Processing of Income Records
DROP PROCEDURE IF EXISTS process_income_cursor;
DELIMITER //
CREATE PROCEDURE process_income_cursor()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_source VARCHAR(100);
    DECLARE v_amount DECIMAL(12,2);
    DECLARE v_year VARCHAR(20);

    DECLARE income_cursor CURSOR FOR
        SELECT income_id, income_source, amount,year_id
        FROM Income_Record;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN income_cursor;

    read_loop: LOOP
        FETCH income_cursor
        INTO v_id, v_source, v_amount, v_year;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_id AS `Income ID`,
               v_source AS `Income Source`,
               v_amount AS `Amount`,
               v_year AS `Financial Year`;
    END LOOP;

    CLOSE income_cursor;
END //

DELIMITER ;

CALL process_income_cursor();
-- OPTIONAL 5: Function with Taxation Logic
DROP FUNCTION IF EXISTS classify_income;
DELIMITER //
CREATE FUNCTION classify_income(p_income DECIMAL(12,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    IF p_income <= 500000 THEN
        RETURN 'No Tax Category';
    ELSEIF p_income <= 1000000 THEN
        RETURN 'Moderate Income';
    ELSE
        RETURN 'High Income';
    END IF;
END //

DELIMITER ;

SELECT full_name,
       annual_income,
       classify_income(annual_income) AS Income_Classification
FROM Taxpayer;
