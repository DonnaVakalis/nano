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