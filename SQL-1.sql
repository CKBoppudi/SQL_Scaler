use farmers_market;

select * FROM product;

select * FROM product LIMIT 5;

select product_id FROM product;

select product_id , product_name , product_size from product;

select product_id , product_name , product_size from product LIMIT 5;

select market_date , vendor_id , booth_number FROM vendor_booth_assignments LIMIT 10;

select market_date , vendor_id , booth_number FROM vendor_booth_assignments 
ORDER BY vendor_id LIMIT 10000;

select market_date , vendor_id , booth_number FROM vendor_booth_assignments 
ORDER BY vendor_id DESC LIMIT 10000;

select * FROM customer_purchases LIMIT 5;

select market_date , customer_id , quantity , cost_to_customer_per_qty , 
quantity * cost_to_customer_per_qty FROM customer_purchases;

select market_date , customer_id , quantity , cost_to_customer_per_qty , 
quantity * cost_to_customer_per_qty AS Total_cost FROM customer_purchases;








