USE Taxation_db;
-- PART A - TASK 1: TAX CALCULATION FUNCTION
DROP FUNCTION IF EXISTS calculate_tax;
DELIMITER //
CREATE FUNCTION calculate_tax(p_income DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_tax DECIMAL(12,2);

    IF p_income <= 500000 THEN
        SET v_tax = 0;
    ELSEIF p_income <= 1000000 THEN
        SET v_tax = (p_income - 500000) * 0.10;
    ELSEIF p_income <= 1500000 THEN
        SET v_tax = 50000 + (p_income - 1000000) * 0.20;
    ELSE
        SET v_tax = 150000 + (p_income - 1500000) * 0.30;
    END IF;

    RETURN v_tax;
END //
DELIMITER ;
SELECT calculate_tax(400000) AS Tax;
SELECT calculate_tax(800000) AS Tax;
SELECT calculate_tax(1200000) AS Tax;
SELECT calculate_tax(1800000) AS Tax;
-- PART B - TASK 2: INDIVIDUAL TAX ASSESSMENT
DROP PROCEDURE IF EXISTS generate_tax_assessment;
DELIMITER //
CREATE PROCEDURE generate_tax_assessment(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_pan VARCHAR(20);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_occupation VARCHAR(100);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net_income DECIMAL(12,2);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT full_name, pan_number, annual_income, occupation
    INTO v_name, v_pan, v_income, v_occupation
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SET v_tax = calculate_tax(v_income);
        SET v_net_income = v_income - v_tax;

        SELECT
            v_name AS 'Taxpayer Name',
            v_pan AS 'PAN Number',
            v_income AS 'Annual Income',
            v_occupation AS 'Occupation',
            v_tax AS 'Tax Amount',
            v_net_income AS 'Net Income';
    END IF;
END //

DELIMITER ;

CALL generate_tax_assessment(101);
-- PART C - TASK 3: INCOME CLASSIFICATION FUNCTION
DROP FUNCTION IF EXISTS income_category;
DELIMITER //
CREATE FUNCTION income_category(p_income DECIMAL(12,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_category VARCHAR(30);

    IF p_income <= 500000 THEN
        SET v_category = 'Low Income';
    ELSEIF p_income <= 1000000 THEN
        SET v_category = 'Medium Income';
    ELSEIF p_income <= 1500000 THEN
        SET v_category = 'High Income';
    ELSE
        SET v_category = 'Very High Income';
    END IF;

    RETURN v_category;
END //

DELIMITER ;

SELECT
   full_name AS 'Taxpayer Name',
    annual_income AS 'Annual Income',
    income_category(annual_income) AS 'Income Category'
FROM Taxpayer;
-- LEVEL 1 - QUESTION 1: TAXPAYER SUMMARY
DROP PROCEDURE IF EXISTS taxpayer_summary;
DELIMITER //
CREATE PROCEDURE taxpayer_summary(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net_income DECIMAL(12,2);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net_income = v_income - v_tax;

        SELECT
            v_name AS 'Taxpayer Name',
            v_income AS 'Annual Income',
            v_category AS 'Income Category',
            v_tax AS 'Calculated Tax',
            v_net_income AS 'Net Income';
    END IF;
END //

DELIMITER ;

CALL taxpayer_summary(101);
-- LEVEL 1 - QUESTION 2: INCOME RECORD PROCESSING
DROP PROCEDURE IF EXISTS income_record_processing;
DELIMITER //
CREATE PROCEDURE income_record_processing(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_total DECIMAL(14,2) DEFAULT 0;
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SELECT COUNT(*), COALESCE(SUM(amount), 0)
        INTO v_count, v_total
        FROM Income_Record
        WHERE taxpayer_id = p_taxpayer_id;

        IF v_count = 0 THEN
            SELECT 'No income records found' AS Message;
        ELSE
            SELECT
                v_name AS 'Taxpayer Name',
                v_total AS 'Total Recorded Income',
                v_income AS 'Annual Income',
                v_income - v_total AS 'Difference';
        END IF;
    END IF;
END //
DELIMITER ;
CALL income_record_processing(101);
-- LEVEL 1 - QUESTION 3: CONDITIONAL ASSESSMENT
DROP PROCEDURE IF EXISTS conditional_assessment;
DELIMITER //
CREATE PROCEDURE conditional_assessment(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_status VARCHAR(40);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        IF v_income <= 500000 THEN
            SET v_status = 'No Tax Assessment';
        ELSEIF v_income <= 1000000 THEN
            SET v_status = 'Standard Assessment';
        ELSE
            SET v_status = 'High Income Assessment';
        END IF;

        SELECT
            v_name AS 'Taxpayer Name',
            v_income AS 'Annual Income',
            v_status AS 'Assessment Status';
    END IF;
END //

DELIMITER ;

CALL conditional_assessment(101);
-- LEVEL 2 - QUESTION 1: CURSOR-BASED TAX ASSESSMENT
DROP PROCEDURE IF EXISTS cursor_tax_assessment;

DELIMITER //

CREATE PROCEDURE cursor_tax_assessment()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);
    DECLARE done INT DEFAULT 0;

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active=1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS assessment_result;

    CREATE TEMPORARY TABLE assessment_result (
        taxpayer_name VARCHAR(100),
        annual_income DECIMAL(12,2),
        income_category VARCHAR(30),
        tax_amount DECIMAL(12,2),
        net_income DECIMAL(12,2)
    );

    OPEN taxpayer_cursor;

    read_loop: LOOP
        FETCH taxpayer_cursor INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        INSERT INTO assessment_result
        VALUES (v_name, v_income, v_category, v_tax, v_net);
    END LOOP;

    CLOSE taxpayer_cursor;

    SELECT * FROM assessment_result;
END //

DELIMITER ;

CALL cursor_tax_assessment();
-- LEVEL 2 - QUESTION 2: CURSOR WITH CONDITIONAL PROCESSING
DROP PROCEDURE IF EXISTS conditional_cursor_assessment;

DELIMITER //

CREATE PROCEDURE conditional_cursor_assessment()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_category VARCHAR(40);
    DECLARE done INT DEFAULT 0;

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS conditional_result;

    CREATE TEMPORARY TABLE conditional_result (
       full_name VARCHAR(100),
        annual_income DECIMAL(12,2),
        tax_amount DECIMAL(12,2),
        assessment_category VARCHAR(40)
    );

    OPEN taxpayer_cursor;

    read_loop: LOOP
        FETCH taxpayer_cursor INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF v_income <= 500000 THEN
            SET v_tax = 0;
            SET v_category = 'NO TAX';
        ELSEIF v_income <= 1000000 THEN
            SET v_tax = (v_income - 500000) * 0.10;
            SET v_category = 'Standard Assessment';
        ELSE
            SET v_tax = calculate_tax(v_income);
            SET v_category = 'High Income Assessment';
        END IF;

        INSERT INTO conditional_result
        VALUES (v_name, v_income, v_tax, v_category);
    END LOOP;

    CLOSE taxpayer_cursor;

    SELECT * FROM conditional_result;
END //

DELIMITER ;

CALL conditional_cursor_assessment();
-- LEVEL 2 - QUESTION 3: UPDATE TAXPAYER INCOME
DROP PROCEDURE IF EXISTS update_taxpayer_income;

DELIMITER //

CREATE PROCEDURE update_taxpayer_income(
    IN p_taxpayer_id INT,
    IN p_new_income DECIMAL(12,2)
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    IF p_new_income < 0 THEN
        SELECT 'Income must be greater than or equal to zero' AS Message;
    ELSE
        SELECT COUNT(*)
        INTO v_count
        FROM Taxpayer
        WHERE taxpayer_id = p_taxpayer_id;

        IF v_count = 0 THEN
            SELECT 'Taxpayer not found' AS Message;
        ELSE
            UPDATE Taxpayer
            SET annual_income = p_new_income
            WHERE taxpayer_id = p_taxpayer_id;

            SELECT
                taxpayer_id AS 'Taxpayer ID',
                full_name AS 'Taxpayer Name',
                annual_income AS 'Updated Annual Income'
            FROM Taxpayer
            WHERE taxpayer_id = p_taxpayer_id;
        END IF;
    END IF;
END //

DELIMITER ;

CALL update_taxpayer_income(101, 750000);
-- LEVEL 2 - QUESTION 4: EXCEPTION HANDLING
DROP PROCEDURE IF EXISTS tax_exception_handling;
DELIMITER //
CREATE PROCEDURE tax_exception_handling(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'An SQL error occurred' AS Message;
    END;

    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SET v_tax = calculate_tax(v_income);

        SELECT
            v_income AS 'Annual Income',
            v_tax AS 'Tax Amount';
    END IF;
END //

DELIMITER ;

CALL tax_exception_handling(101);
-- LEVEL 3 - QUESTION 1: COMPLETE TAX ASSESSMENT SYSTEM
DROP PROCEDURE IF EXISTS complete_tax_assessment;

DELIMITER //

CREATE PROCEDURE complete_tax_assessment(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_pan VARCHAR(20);
    DECLARE v_occupation VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT full_name, pan_number, occupation, annual_income
    INTO v_name, v_pan, v_occupation, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_found = 0 THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            'TAX ASSESSMENT REPORT' AS Report,
            v_name AS 'Taxpayer Name',
            v_pan AS 'PAN Number',
            v_occupation AS 'Occupation',
            v_income AS 'Annual Income',
            v_category AS 'Income Category',
            v_tax AS 'Tax Amount',
            v_net AS 'Net Income';
    END IF;
END //

DELIMITER ;

CALL complete_tax_assessment(101);
-- LEVEL 3 - QUESTION 2: INCOME RECORD CURSOR PROCESSING
DROP PROCEDURE IF EXISTS process_income_records;

DELIMITER //

CREATE PROCEDURE process_income_records()
BEGIN
    DECLARE v_id INT;
    DECLARE v_taxpayer_id INT;
    DECLARE v_source VARCHAR(100);
    DECLARE v_category VARCHAR(100);
    DECLARE v_amount DECIMAL(12,2);
    DECLARE v_date DATE;
    DECLARE v_year VARCHAR(20);
    DECLARE v_size VARCHAR(30);
    DECLARE done INT DEFAULT 0;

    DECLARE income_cursor CURSOR FOR
        SELECT income_id, taxpayer_id, income_source,
               category_id, amount, received_date,year_id
        FROM Income_Record;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS income_result;

    CREATE TEMPORARY TABLE income_result (
        income_id INT,
        taxpayer_id INT,
        income_source VARCHAR(100),
        category VARCHAR(100),
        amount DECIMAL(12,2),
        received_date DATE,
        financial_year VARCHAR(20),
        record_classification VARCHAR(30)
    );

    OPEN income_cursor;

    read_loop: LOOP
        FETCH income_cursor
        INTO v_id, v_taxpayer_id, v_source, v_category,
             v_amount, v_date, v_year;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF v_amount <= 50000 THEN
            SET v_size = 'Small Income Record';
        ELSEIF v_amount <= 200000 THEN
            SET v_size = 'Medium Income Record';
        ELSE
            SET v_size = 'Large Income Record';
        END IF;

        INSERT INTO income_result
        VALUES (
            v_id, v_taxpayer_id, v_source, v_category,
            v_amount, v_date, v_year, v_size
        );
    END LOOP;

    CLOSE income_cursor;

    SELECT * FROM income_result;
END //

DELIMITER ;

CALL process_income_records();
-- LEVEL 3 - QUESTION 3: COMBINED FUNCTION AND CURSOR
DROP PROCEDURE IF EXISTS combined_tax_assessment;

DELIMITER //

CREATE PROCEDURE combined_tax_assessment()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);
    DECLARE done INT DEFAULT 0;

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active=1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS tax_results;

    CREATE TEMPORARY TABLE tax_results (
        taxpayer_name VARCHAR(100),
        annual_income DECIMAL(12,2),
        income_category VARCHAR(30),
        tax_amount DECIMAL(12,2),
        net_income DECIMAL(12,2)
    );

    OPEN taxpayer_cursor;

    read_loop: LOOP
        FETCH taxpayer_cursor INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        INSERT INTO tax_results
        VALUES (v_name, v_income, v_category, v_tax, v_net);
    END LOOP;

    CLOSE taxpayer_cursor;

    SELECT * FROM tax_results;
END //

DELIMITER ;

CALL combined_tax_assessment();
-- CHALLENGE QUESTION: TAXPAYER ASSESSMENT SUMMARY
DROP PROCEDURE IF EXISTS taxpayer_assessment_summary;

DELIMITER //

CREATE PROCEDURE taxpayer_assessment_summary()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_status VARCHAR(40);

    DECLARE v_count INT DEFAULT 0;
    DECLARE v_total_income DECIMAL(14,2) DEFAULT 0;
    DECLARE v_total_tax DECIMAL(14,2) DEFAULT 0;
    DECLARE done INT DEFAULT 0;

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active=1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS assessment_summary;

    CREATE TEMPORARY TABLE assessment_summary (
        full_name VARCHAR(100),
        annual_income DECIMAL(12,2),
        tax_amount DECIMAL(12,2),
        income_category VARCHAR(30),
        assessment_status VARCHAR(40)
    );

    OPEN taxpayer_cursor;

    read_loop: LOOP
        FETCH taxpayer_cursor INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_tax = calculate_tax(v_income);
        SET v_category = income_category(v_income);

        IF v_income <= 500000 THEN
            SET v_status = 'No Tax Assessment';
        ELSEIF v_income <= 1000000 THEN
            SET v_status = 'Standard Assessment';
        ELSE
            SET v_status = 'High Income Assessment';
        END IF;

        INSERT INTO assessment_summary
        VALUES (
            v_name, v_income, v_tax, v_category, v_status
        );

        SET v_count = v_count + 1;
        SET v_total_income = v_total_income + v_income;
        SET v_total_tax = v_total_tax + v_tax;
    END LOOP;

    CLOSE taxpayer_cursor;

    SELECT * FROM assessment_summary;

    SELECT
        v_count AS 'Total Taxpayers Processed',
        v_total_income AS 'Total Income',
        v_total_tax AS 'Total Tax';
END //
DELIMITER ;
CALL taxpayer_assessment_summary();
