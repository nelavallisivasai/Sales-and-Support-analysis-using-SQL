-- Q. Identify the tables in the database and their respective columns.

USE interview;

-- lists the tables present in the datbase interview
SHOW TABLES;

-- Gives details of columns with their data types and constraints.
DESCRIBE agents;
DESCRIBE customer;
DESCRIBE orders;

-- Q. Determine the number of records in each table within the schema.
SELECT table_name, table_rows 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'interview';

-- Q. Identify and handle any missing or inconsistent values in the dataset

-- Droping column country from agents table as that column don't have any data
ALTER TABLE agents DROP country;

-- Replacing incorrect phone numbers with blank.
UPDATE customer
SET phone_no = ''
WHERE phone_no NOT REGEXP '^[0-9-]{7,12}$';

-- Q. Analyse the data types of the columns in each table to ensure they are appropriate for the stored data.
-- Changing datatype of ord_num from decimal(6,0) to varchar(6)
ALTER TABLE orders MODIFY COLUMN ord_num varchar(6);

-- Changing datatype of grade from decimal(10,0) to char as all the values in the range of 0 to 3.
ALTER TABLE customer MODIFY COLUMN grade char;

-- Q. Identify any duplicate records within the tables and develop a strategy for handling them.

-- Adding primary key to avoid dupllicates.
ALTER TABLE customer 
ADD PRIMARY KEY (`CUST_CODE`);
;
-- Adding primary key to avoid dupllicates.
ALTER TABLE orders 
ADD PRIMARY KEY (`ORD_NUM`);
;








