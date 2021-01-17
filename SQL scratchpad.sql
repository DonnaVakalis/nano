MODULE 2 SOLUTIONS
SELECT accounts.name,web_events.channel,web_events.occurred_at, accounts.primary_poc
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
WHERE accounts.name = 'Walmart';



SELECT r.name as region, a.name as customer, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
JOIN sales_reps as sr
ON sr.id = a.sales_rep_id
JOIN region as r
ON r.id = sr.region_id
	



Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.


SELECT r.name AS region_name, sr.name AS rep_name, a.name AS account_name
FROM sales_reps AS sr
LEFT JOIN accounts AS a
ON sr.id = a.sales_rep_id 
LEFT JOIN region AS r
ON sr.region_id = r.id
WHERE r.name = 'Midwest'
ORDER BY a.name;
	

Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT sr.name AS rep_name, r.name AS region_name, a.name AS account_name
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id
JOIN accounts AS a
ON sr.id = a.sales_rep_id
WHERE sr.name LIKE 'S%' AND r.name = 'Midwest'
ORDER BY a.name;
	

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).


SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd/(o.total + 0.01) AS unit_price
FROM orders AS o
LEFT JOIN accounts as a
ON o.account_id = a.id
LEFT JOIN sales_reps AS sr
ON  a.sales_rep_id = sr.id
LEFT JOIN region AS r
ON sr.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY o.total_amt_usd/(o.total + 0.01) DESC;
	

What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
 
SELECT DISTINCT a.name, w.channel 
        FROM accounts AS a
           JOIN web_events AS w
           ON a.id = w.account_id
   WHERE a.id = 1001;
	

Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
        FROM orders AS o
           JOIN accounts AS a
           ON a.id = o.account_id
   WHERE o.occurred_at BETWEEN '2015-01-01' AND '2017-01-01'
ORDER BY o.occurred_at;
	



MODULE 3 SOLUTIONS


1. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
SELECT *
        FROM (SELECT total_amt_usd
                FROM orders 
                ORDER BY total_amt_usd  
                LIMIT 3456) as temp
   ORDER BY total_amt_usd DESC
   LIMIT 1;
	

Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.


SELECT MIN(orders.occurred_at), accounts.name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id 
GROUP BY accounts.name
ORDER BY MIN(orders.occurred_at);
	

Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.


SELECT w.occurred_at, w.channel, a.name
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;
	

Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.


SELECT COUNT(id), channel
FROM web_events
GROUP BY channel;
	

Who was the primary contact associated with the earliest web_event?


SELECT a.primary_poc
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;
	

What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.


SELECT MIN(o.total_amt_usd) AS min_order ,a.name
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY min_order;
	

For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.


SELECT a.name, AVG(o.standard_amt_usd) AS avg_std ,AVG(o.poster_amt_usd) AS avg_pstr
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name;
	

Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.


SELECT s.name AS rep, w.channel, COUNT(w) AS occurances
FROM web_events AS w
JOIN accounts AS a
ON a.id = w.account_id
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
GROUP BY w.channel, rep
ORDER BY occurances DESC;
	

Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.


SELECT r.name, w.channel, COUNT (w.id) AS num_events
FROM web_events AS w
JOIN accounts AS a
ON a.id = w.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;
	



Use DISTINCT to test if there are any accounts associated with more than one region.


COMPARE TWO QUERIES:
SELECT COUNT(a.name) AS acc, COUNT(r.name) AS reg
FROM accounts AS a
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id;
	VS 
SELECT  DISTINCT a.name AS acc, r.name AS reg
FROM accounts AS a
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id;
	(both return 351)


Have any sales reps worked on more than one account?


SELECT DISTINCT s.name AS rep, a.name AS acc
FROM accounts AS a
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
ORDER BY rep;
	

How many accounts have more than 20 orders?


SELECT a.name, COUNT(o.*)  
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name 
HAVING COUNT(o.*) > 20;
	



Which account has the most orders?
SELECT  a.name, COUNT(o.id) num
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name 
ORDER BY num DESC
LIMIT 1;
	



Which accounts spent less than 1,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) total
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(o.total_amt_usd)<1000;
	

Which accounts used facebook as a channel to contact customers more than 6 times?


SELECT a.name
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name
HAVING COUNT(w.id)>6;
	Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?


SELECT DATE_PART('month', occurred_at) order_month, SUM(total_amt_usd) tot
FROM orders
GROUP BY order_month 
ORDER BY tot DESC
	

Which channel was most frequently used by most accounts?


SELECT a.name, w.channel, COUNT(*)
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY COUNT(w.id) DESC;
	

Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?


SELECT DATE_PART('year', occurred_at) order_yr, SUM(total_amt_usd) tot
FROM orders
GROUP BY order_yr 
ORDER BY tot DESC
	

Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
SELECT DATE_PART('month', occurred_at) order_month, COUNT(*) num_orders
FROM orders AS o
GROUP BY order_month
ORDER BY num_orders DESC
	



SELECT DATE_PART('year', occurred_at) order_year, DATE_PART('month', occurred_at) order_month, COUNT(*) num_orders
FROM orders AS o
GROUP BY order_year, order_month
ORDER BY order_year DESC
	

Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
SELECT account_id, total_amt_usd, 
CASE WHEN total_amt_usd < 3000 THEN 'Small' ELSE 'Large' END AS order_size
FROM orders
	

	Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT CASE WHEN total>= 2000 THEN 'Lots'
                        WHEN total< 2000 AND total >1000 THEN 'Some'
           ELSE 'Few' END AS num_items, COUNT(*) 
FROM orders
GROUP BY 1
	

We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name AS account_name, 
SUM(total_amt_usd) AS lifetime_value,
CASE WHEN SUM(total_amt_usd)>= 200000 THEN 'L1'
WHEN SUM(total_amt_usd)< 200000 AND SUM(total_amt_usd) >100000 THEN 'L2'
ELSE 'L3' END AS level  
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY 1
ORDER BY lifetime_value DESC
	

	

We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name AS account_name, SUM(total_amt_usd) AS lifetime_value,
CASE WHEN SUM(total_amt_usd)>= 200000 THEN 'L1'
WHEN SUM(total_amt_usd)< 200000 AND SUM(total_amt_usd) >100000 THEN 'L2'
ELSE 'L3' END AS level  
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
WHERE DATE_PART('year',o.occurred_at) = 2016  OR DATE_PART('year',o.occurred_at) = 2017
GROUP BY 1
ORDER BY lifetime_value DESC
	

The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!


SELECT sr.name AS rep_name, 
SUM(o.total_amt_usd) AS total_sales, 
COUNT(o.id) AS num_orders, 
CASE WHEN COUNT(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top' 
WHEN COUNT(o.id) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle' 
ELSE 'low' END AS rank
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps sr
ON sr.id = a.sales_rep_id
GROUP BY 1
ORDER BY 4 DESC, 3 DESC