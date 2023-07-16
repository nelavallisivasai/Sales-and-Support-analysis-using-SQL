-- Segment 4: Agent Performance Analysis
-- Q. Company wants to provide a performance bonus to their best agents based on the maximum order amount. 
-- Find the top 5 agents eligible for it.
SELECT agent_name
FROM agents JOIN orders
ON agents.agent_code = orders.agent_code
GROUP BY orders.agent_code
ORDER BY SUM(ord_amount) DESC
limit 5
;

-- Q. The company wants to analyse the performance of agents based on the number of orders 
-- they have handled. Write a SQL query to rank agents based on the total number of orders 
-- they have processed. Display agent_name, total_orders, and their respective ranking.

SELECT agents.agent_name, COUNT(orders.ord_num) AS total_orders,
ROW_NUMBER() OVER (ORDER BY COUNT(orders.ord_num) DESC) AS ranking
FROM agents
JOIN orders ON agents.agent_code = orders.agent_code
GROUP BY agents.agent_name
ORDER BY total_orders DESC;

-- Q. Company wants to change the commission for the agents, basis advance payment they collected. 
-- Write a sql query which creates a new column updated_commision on the basis below rules.
-- ⦁If the average advance amount collected is less than 750, there is no change in commission.
-- ⦁If the average advance amount collected is between 750 and 1000 (inclusive), 
-- the new commission will be 1.5 times the old commission.
-- ⦁If the average advance amount collected is more than 1000, the new commission will be 2 times the old commission.
ALTER TABLE agents
ADD COLUMN updated_commission DECIMAL(10,2);

UPDATE agents
SET updated_commission =
CASE
   WHEN (SELECT AVG(advance_amount) from orders where agent_code = agents.agent_code) < 750 then commission
   WHEN (SELECT AVG(advance_amount) from orders where agent_code = agents.agent_code) BETWEEN 750 AND 1000 THEN commission * 1.5
   WHEN (SELECT AVG(advance_amount) from orders where agent_code = agents.agent_code) > 1000 THEN commission * 2
   ELSE commission
END;


 
