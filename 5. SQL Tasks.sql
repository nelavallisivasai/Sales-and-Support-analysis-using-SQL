-- Segment 5: SQL Tasks
-- Q. Add a new column named avg_rcv_amt in the table customers which contains the average receive amount 
-- for every country. Display all columns from the customer table along with the avg_rcv_amt 
-- column in the last.

ALTER TABLE customer
ADD COLUMN avg_rcv_amt DECIMAL(12,2);

UPDATE customer AS c
JOIN (
    SELECT cust_country, AVG(receive_amt) AS avg_amt
    FROM customer
    GROUP BY cust_country
) AS subquery
ON c.cust_country = subquery.cust_country
SET c.avg_rcv_amt = subquery.avg_amt;

-- Q. Write a sql query to create and call a UDF named avg_amt to return the average outstanding amount 
-- of the customers which are managed by a given agent. Also, call the UDF with the agent name ‘Mukesh’.

DELIMITER //
CREATE FUNCTION avg_amt(agent_name VARCHAR(40))
RETURNS DECIMAL(10,2)
DETERMINISTIC 
BEGIN
DECLARE avg_outstanding_amt DECIMAL(10, 2);
SELECT AVG(outstanding_amt) INTO avg_outstanding_amt
FROM agents JOIN customer
ON agents.agent_code = customer.agent_code
WHERE agent_name = agent_name;
RETURN avg_outstanding_amt;
END //
DELIMITER ;
-- In the above query DETERMINISTIC means always returns the same result for the same input 
-- and doesn't modify the database or have any side effects

-- Calling function avg_amt	
SELECT avg_amt('Mukesh');

-- Q. Write a sql query to create and call a subroutine called cust_detail to return all the details 
--    of the customer which are having the given grade. Also, call the subroutine with grade 2.
DELIMITER //
CREATE PROCEDURE cust_detail(IN grade_param char)
BEGIN
    SELECT * FROM customer
    WHERE grade = grade_param;
END //

DELIMITER ;
-- Calling stored procedure cust_detail
CALL cust_detail('3');

-- Q. Write a stored procedure sp_name which will return the concatenated ord_num (comma separated) 
-- of the customer with input customer code using cursor. Also, write the procedure call query 
-- with cust_code ‘C00015’.
DELIMITER //
CREATE PROCEDURE sp_name(IN cust_code_param VARCHAR(10))
BEGIN
    DECLARE ord_num_list VARCHAR(1000) DEFAULT '';
    DECLARE done INT DEFAULT FALSE;
    DECLARE ord_num_val VARCHAR(10);

    -- Cursor declaration
    DECLARE cur CURSOR FOR
        SELECT ord_num
        FROM orders
        WHERE cust_code = cust_code_param;

    -- Continue handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ord_num_val;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF ord_num_list = '' THEN
            SET ord_num_list = ord_num_val;
        ELSE
            SET ord_num_list = CONCAT(ord_num_list, ',', ord_num_val);
        END IF;
    END LOOP;

    CLOSE cur;

    -- Return the concatenated ord_num list
    SELECT ord_num_list AS concatenated_ord_nums;
END //

DELIMITER ;
-- Call the stored procedure with cust_code = 'C00015'
CALL sp_name('C00015');







