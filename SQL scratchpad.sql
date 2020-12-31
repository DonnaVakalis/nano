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
	

Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.