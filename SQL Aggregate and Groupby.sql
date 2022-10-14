USE farmers_market;

# Get a list of customer ID's who made purchases on each market date.

SELECT market_date , customer_id
FROM customer_purchases
GROUP BY market_date , customer_id
ORDER BY market_date , customer_id;

# Count the number of purchases each customer made per each market date.

SELECT market_date , customer_id, quantity,
COUNT(*) AS pur_num
FROM customer_purchases
GROUP BY market_date , customer_id
ORDER BY market_date , customer_id;

SELECT market_date , customer_id, 
SUM(quantity) AS sum_quantity,
COUNT(*) AS num_pur
FROM customer_purchases
GROUP BY market_date , customer_id 
ORDER BY market_date , customer_id;

# How many different kinds of products were purchased by each customer on each market date and also give the customer names. 

SELECT * FROM customer_purchases;

SELECT cp.customer_id , cp.market_date , 
count(DISTINCT product_id) AS diff_products , SUM(quantity) , c.customer_first_name
FROM customer_purchases cp LEFT JOIN customer c ON cp.customer_id = c.customer_id
GROUP BY customer_id , market_date
ORDER BY market_date , customer_id;

# How many distinct vendors are present in the table

SELECT COUNT(DISTINCT vendor_id) FROM vendor_inventory;

# which product is having the minimuym and maximum price in vendor_inventory and also give the count of distinct vendor_id.

SELECT MIN(original_price) AS Min_price , MAX(original_price) AS max_price , COUNT(DISTINCT vendor_id)
FROM vendor_inventory;

# Get the lowest and highest prices within in each product category.

## Solution ##
# We need to deal with the tables - product , product_category , vendor_inventory.

SELECT * FROM vendor_inventory; 
# In the above we have the product_id and original_price, but no product category
SELECT * FROM product;
# In the above we have the product category id but no product category name.
SELECT * FROM product_category;
# In the above we have the product category name.

SELECT pc.product_category_name , 
p.product_category_id,
MIN(v.original_price) AS min_price , MAX(v.original_price) AS max_price
FROM vendor_inventory v INNER JOIN product p
ON v.product_id = p.product_id 
INNER JOIN product_category pc ON p.product_category_id = pc.product_category_id
GROUP BY product_category_name , product_category_id;



SELECT pc.product_category_name , p.product_category_id,
MIN(v.original_price) AS min_price , MAX(v.original_price) AS max_price
FROM vendor_inventory v INNER JOIN product p
ON v.product_id = p.product_id 
RIGHT JOIN product_category pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.product_category_name , p.product_category_id;

# We wanted to know how many different products - with unique product ids - each vendor brought to market during a date range.
# We could use the count distinct on the product id field. 


SELECT 
vendor_id , COUNT(DISTINCT product_id) 
FROM vendor_inventory
WHERE market_date BETWEEN "2019-07-03" AND "2020-07-04"
GROUP BY vendor_id ORDER BY vendor_id;

SELECT SUM(quantity) , vendor_id
FROM vendor_inventory
GROUP BY vendor_id
ORDER BY vendor_id;


# vendor_id with quantity more than 10,000.

SELECT SUM(quantity) AS inventory_item_count , vendor_id
FROM vendor_inventory
GROUP BY vendor_id
HAVING inventory_item_count > 10000
ORDER BY vendor_id;

# Find the average amount spent by customers each day. we want to consider only those days where the number of purchases 
# were more than 15 and transaction amount was greater than 5.

SELECT market_date , ROUND(AVG(quantity * cost_to_customer_per_qty)) AS avg_spent ,
COUNT(*) AS transaction_count
FROM customer_purchases
WHERE quantity * cost_to_customer_per_qty > 5
GROUP BY market_date
HAVING transaction_count > 15
ORDER BY market_date;




