-- Segment 3: Customer Analysis:
-- Q. Calculate the total number of customers.
SELECT count(*) AS total_customers
FROM customer;

-- Q. Identify the top-spending customers based on their total order value.
-- Top 5 spending customers
SELECT cust_name
FROM customer JOIN orders
ON customer.cust_code = orders.cust_code
GROUP BY orders.cust_code
ORDER BY SUM(ord_amount) DESC
limit 5
;

-- Q. Analyse customer retention by calculating the percentage of repeat customers.
SELECT 
  (COUNT(DISTINCT repeat_customers.cust_code) / COUNT(DISTINCT all_customers.cust_code)) * 100 AS retention_percentage
FROM
  (SELECT cust_code FROM orders GROUP BY cust_code HAVING COUNT(*) > 1) AS repeat_customers
JOIN
  (SELECT cust_code FROM orders GROUP BY cust_code) AS all_customers;
  
-- Q. Find the name of the customer who has the maximum outstanding amount from every country. 
SELECT cust_name
FROM
  (SELECT cust_name, cust_country, MAX(outstanding_amt)
   FROM customer
   GROUP BY cust_country
  ) AS temp;

-- Q. Write a SQL query to calculate the percentage of customers in each grade category (0 to 3). 
SELECT grade, (count(*)/t_cust.total_cust)*100 AS per_cust
FROM customer 
JOIN
  (SELECT COUNT(*) as total_cust 
   FROM customer
  ) AS t_cust
GROUP BY grade;

