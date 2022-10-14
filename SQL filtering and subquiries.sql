use farmers_market;

 SELECT * FROM customer_purchases LIMIT 10;
 
 SELECT market_date , customer_id , vendor_id,
quantity*cost_to_customer_per_qty AS Total_cost FROM customer_purchases;


 SELECT market_date , customer_id , vendor_id,
ROUND(quantity*cost_to_customer_per_qty , 2) AS Total_cost FROM customer_purchases;

SELECT market_date , customer_id , vendor_id,
ROUND(quantity*cost_to_customer_per_qty , 0) AS Total_cost FROM customer_purchases;

SELECT market_date , customer_id , vendor_id,
ROUND(quantity*cost_to_customer_per_qty , 0) AS Total_cost FROM customer_purchases;

SELECT market_date , customer_id , vendor_id,
ROUND(quantity*cost_to_customer_per_qty , 0) AS Total_cost ,
CEIL(quantity*cost_to_customer_per_qty) AS Total_cost_ceil FROM customer_purchases;




SELECT * FROM customer;
##-- We want to merge each customers name in to a single column (continued)
##-- that contains the first name, then a space, and then the last name 

SELECT 
customer_id , 
CONCAT(customer_first_name , " " ,  customer_last_name) AS cust_name,
customer_zip FROM customer;

# writing a query for sorting the table with respect to customer name.

SELECT 
customer_id , 
CONCAT(customer_first_name , " " ,  customer_last_name) AS cust_name,
customer_zip FROM customer
ORDER BY cust_name; # ORDER BY is the sorting function+


##-- We want to merge each customers name in to a single column (continued)
##-- that contains the first name, then a space, and then the last name 
##-- Also include the first name and last name columns in the table.

SELECT 
customer_id , 
customer_first_name , customer_last_name , 
CONCAT(customer_first_name , " " ,  customer_last_name) AS cust_name,
customer_zip FROM customer
ORDER BY cust_name;

##-- Extract all the product names that are part of the product category - 1 ##--

SELECT * FROM product_category;

SELECT product_category_name FROM product_category WHERE product_category_id = 1;

SELECT market_date , customer_id , vendor_id ,
ROUND(quantity*cost_to_customer_per_qty , 2) AS Total_cost FROM customer_purchases
WHERE customer_id = 4 
ORDER BY market_date , market_date , vendor_id , customer_id , product_id;

##-- Get all the product info for product with id between 3 and 8 -continued-
##-- and of product with id 10 

SELECT * FROM product WHERE (product_id >= 3 AND product_id <= 8) OR (product_id = 10);

##-- Find the details of purchases made by customer-4 at vendor-7

SELECT * FROM customer_purchases WHERE (customer_id = 4 AND vendor_id = 7);

##-- Find the customer details with first name "Carlos" or the last name of "Diaz".

SELECT * FROM customer WHERE (customer_first_name = "Carlos" OR customer_last_name = "Diaz");

##-- Write a Query to find out what booths vendor-2 was assigned to on or before april 20,2019

SELECT * FROM vendor_booth_assignments 
WHERE market_date <= "2019-4-03"
ORDER BY booth_number; # Order by sorts the column in ascending order by default.

##-- Write a Query to retain a list of customers with select last names [Diaz,Edward,Wilson]

SELECT * FROM customer 
WHERE 
customer_last_name = 'Diaz' 
OR customer_last_name = 'Edwards' 
OR customer_last_name = 'Wilson';

#########-----------more convenient method - using IN function ---------#######

SELECT * FROM customer 
WHERE customer_last_name IN ("Diaz" , "Edwards" , "Wilson");

# Extract the data where product_size is NULL.
SELECT * FROM product
WHERE product_size = NULL;

# The above does not give the required output.

SELECT * FROM product
WHERE product_size IS NULL;

# Extract the data from product table where the column product_size has  empty spaces and Null values.

SELECT * FROM product WHERE TRIM(product_size) = "";
SELECT * FROM product WHERE product_size = " ";

SELECT * FROM product 
WHERE product_size = " "
OR product_size IS NULL;

##--From table product extract all the product names that contain the letter "h".

SELECT * FROM product WHERE product_name LIKE "%h%";


##--From table product extract all the product_names that have the last letter "e".

SELECT product_name FROM product WHERE product_name LIKE "%e";

############################### SUB QUERIES ###########################

##-- Extract the data of total sales of the dates in the market on a rainy day. --##

SELECT market_date , customer_id , ROUND(quantity * cost_to_customer_per_qty , 2) 
AS Total_cost
FROM customer_purchases
WHERE market_date IN (SELECT market_date FROM market_date_info 
WHERE market_rain_flag = 1);


# Segregate the data with respect to the vendor_type fresh as one category and remaining as others.

SELECT *, 
CASE
WHEN vendor_type LIKE "%fresh%" THEN "fresh products"
ELSE "other" END AS vendor_categorised
FROM vendor;

# From the customer purchases extract out all the customers that made purchases of above 5$.

SELECT 
CASE
WHEN quantity * cost_to_customer_per_qty > 5
THEN 1 ELSE 0 
END AS purchase_above_5,
(quantity * cost_to_customer_per_qty) AS Total_cost
FROM customer_purchases;


# Write a Query for Multiple case statemensts.

SELECT
vendor_id , customer_id , ROUND (quantity * cost_to_customer_per_qty,2) AS Total_cost ,
CASE
WHEN (quantity * cost_to_customer_per_qty) < 5
	THEN "under 5$"
WHEN (quantity * cost_to_customer_per_qty) <= 10
	THEN "b\w 5&10"
WHEN (quantity * cost_to_customer_per_qty) <= 20 
	THEN "b\w 10&20"
    ELSE "above 20"
END AS "price categories"
FROM customer_purchases;















