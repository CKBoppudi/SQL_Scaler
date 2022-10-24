USE farmers_market;

################################## WINDOW FUNCTIONS #####################################
-- Get the maximum price for each vendor id.
-- Using GROUP BY
SELECT * FROM vendor_inventory;
SELECT vendor_id , MAX(original_price) AS Highest_price 
FROM vendor_inventory 
GROUP BY vendor_id;

-- Extract the most expensive items and the product_id they are associated with per vendor.
-- Return top 10th of the inventory when sorted by price.

SELECT vendor_id , market_date , quantity , product_id , original_price ,
ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rownumber,
RANK() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank,
DENSE_RANK() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_denserank,
NTILE(5) OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_Ntile
FROM vendor_inventory;


SELECT vendor_id , market_date , quantity , product_id , original_price ,
NTILE(5) OVER (ORDER BY original_price DESC) AS price_Ntile_orderby
FROM vendor_inventory;

-- As a farmer, you want to figure out which of your products were above the,
-- average product price on each market date.

SELECT market_date , vendor_id , product_id , original_price , 
AVG(original_price)
OVER(PARTITION BY market_date ORDER BY market_date)
AS average_of_original_price
FROM vendor_inventory;

-- Extract the farmers products that have prices above the market date's 
-- average product cost.
SELECT * FROM 
(SELECT market_date , vendor_id , product_id , original_price , 
AVG(original_price)
OVER(PARTITION BY market_date ORDER BY market_date)
AS average_of_original_price
FROM vendor_inventory) AS t
WHERE vendor_id = 8 AND original_price > average_of_original_price;

-- Count how many different products each vendor brought to market on each date,
-- and display that count on each row.

SELECT market_date , vendor_id , original_price , COUNT(product_id)
OVER (PARTITION BY market_date , vendor_id ORDER BY market_date , vendor_id , original_price DESC) 
AS count_products
FROM vendor_inventory;

-- Caluclate the running total of cost of items purchased by each customer , 
-- sorted by the date and time and product_id

SELECT customer_id , market_date , transaction_time , product_id , quantity * cost_to_customer_per_qty AS price ,
SUM(quantity * cost_to_customer_per_qty)
OVER (PARTITION BY customer_id ORDER BY market_date , transaction_time , product_id) AS runining_total_purchases
FROM customer_purchases; 

-- What if order by is not used.\

SELECT customer_id , market_date , transaction_time , product_id , quantity * cost_to_customer_per_qty AS price ,
SUM(quantity * cost_to_customer_per_qty)
OVER (PARTITION BY customer_id ) AS runining_total_purchases
FROM customer_purchases; 

-- if order by is not used only the sum is printed against each row.

-- Using the vendor booth assignments table in the farmers market database, display each vendors booth assignment
-- for each market_date alongside their prevoious booth assignments.

SELECT vendor_id , market_date , booth_number , 
LAG(booth_number) OVER(PARTITION BY vendor_id  ORDER BY vendor_id , market_date) AS booth_previous
FROM vendor_booth_assignments;

-- From the above extract all the vendors whose booth numbers are changing.
SELECT * FROM
(SELECT vendor_id , market_date , booth_number , 
LAG(booth_number) OVER(PARTITION BY vendor_id  ORDER BY vendor_id , market_date) AS booth_previous
FROM vendor_booth_assignments) AS t
WHERE t.booth_number <> t.booth_previous OR t.booth_number IS NULL;

-- Lets say You want to find out if the total sales on each market date are,
-- higher or lower than they were on the previous market date.

SELECT market_date , SUM(quantity * cost_to_customer_per_qty) AS total_sales ,
LAG(SUM(quantity * cost_to_customer_per_qty)) OVER(ORDER BY market_date) AS previous_total_sales 
FROM customer_purchases 
GROUP BY market_date 
ORDER BY market_date;

































