
######################----------------- JOINS --------------################
USE farmers_market;

SELECT * FROM product;
SELECT * FROM product_category;

# Problem statement
# In the product table we only have the product name, but no information is provided on the category of the product.
# But the product category information is provided in the product_category table.
# So for every product that is available in the product table add the product category.

# Approach for the above problem statement.
# Considering left table as product and right table as product_category.
# As we need to include all the info that is present in the product table but only the category from the product_category.
# We use left join fo this problem.alter

SELECT * FROM 
product PR LEFT JOIN product_category PC
		ON PR.product_category_id = PC.product_category_id;
        
SELECT PR.product_id , PR.product_name , PR.product_category_id , PC.product_category_name FROM 
product AS PR LEFT JOIN product_category AS PC ON PR.product_category_id = PC.product_category_id;

# Problem statement
# List all the customers and their associated purcahses.

SELECT * FROM customer;
SELECT * FROM customer_purchases;

SELECT * FROM 
customer AS c RIGHT JOIN customer_purchases AS cp 
ON c.customer_id = cp.customer_id;

# INNER JOIN

SELECT PR.product_id , PR.product_name , PR.product_category_id , PC.product_category_name FROM 
product AS PR JOIN product_category AS PC ON PR.product_category_id = PC.product_category_id;

# FULL JOIN 
# There is no FULL JOIN in mySQL, so we have to apply "UNION" for the left join and right join.








