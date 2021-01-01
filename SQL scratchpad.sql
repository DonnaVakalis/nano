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