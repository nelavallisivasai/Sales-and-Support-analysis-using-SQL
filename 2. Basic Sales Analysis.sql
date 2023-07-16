-- Segment 2: Basic Sales Analysis
-- Q. Write SQL queries to retrieve the total number of orders, total revenue, and average order value.
SELECT COUNT(ord_num) AS order_count, 
       SUM(ord_amount) AS total_revenue,
       AVG(ord_amount) AS avg_ord_val
FROM orders;

-- Q. Operations team needs to track the agent who has handled the maximum number of high-grade 
-- customers. Write a SQL query to find the agent_name who has the highest count of customers with 
-- a grade of 3. Display the agent_name and the count of high-grade customers.
SELECT agent_name, grade_count as high_grade_cust_count
FROM agents
JOIN
(SELECT agent_code, COUNT(*) AS grade_count
FROM customer
WHERE grade = 3
GROUP BY agent_code
ORDER BY grade_count DESC
LIMIT 1
)AS highest_grade
on agents.agent_code = highest_grade.agent_code;

-- Q. The company wants to identify the most active customer cities in terms of the total order amount. 
-- Write a SQL query to find the top 3 customer cities with the highest total order amount. 
-- Include cust_city and total_order_amount in the output.
SELECT cust_city, sum(ord_amount) AS total_order_amount
FROM customer JOIN orders
ON customer.cust_code = orders.cust_code
GROUP BY cust_city
order by total_order_amount desc
limit 3;


       