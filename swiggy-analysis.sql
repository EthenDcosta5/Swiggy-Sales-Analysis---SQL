create database swiggy;
use swiggy;


SELECT 
    name, city
FROM
    customers
WHERE
    city = 'Delhi';
    

SELECT 
    round(AVG(rating),2) as Average
FROM
    restaurants
WHERE
    city = 'Mumbai';
    
    
SELECT DISTINCT
    customers.name
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id;


SELECT 
    customers.name, COUNT(orders.customer_id) AS no_of_orders
FROM
    customers
        LEFT JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name;



SELECT 
    restaurants.name, coalesce(sum(orders.total_amount),0) AS revenue
FROM
    restaurants
        LEFT JOIN
    orders ON orders.restaurant_id = restaurants.restaurant_id
GROUP BY restaurants.name;


SELECT 
    name, rating
FROM
    restaurants
ORDER BY rating DESC
LIMIT 5;


SELECT 
    distinct customers.name
FROM
    customers
        LEFT JOIN
    orders ON customers.customer_id = orders.customer_id
WHERE
    orders.order_id IS NULL;


SELECT 
    customers.name,
    customers.city,
    COUNT(orders.customer_id) AS no_of_orders
FROM
    customers
        LEFT JOIN
    orders ON customers.customer_id = orders.customer_id
WHERE
    city = 'Mumbai'
GROUP BY customers.name , customers.city;


SELECT 
    *, DATEDIFF(NOW(), order_date) AS date_diff
FROM
    orders
WHERE
    DATEDIFF(NOW(), order_date) <= 30;


SELECT 
    deliverypartners.name,
    COUNT(orderdelivery.partner_id) AS no_of_deliveries
FROM
    deliverypartners
        LEFT JOIN
    orderdelivery ON deliverypartners.partner_id = orderdelivery.partner_id
GROUP BY deliverypartners.name
HAVING COUNT(orderdelivery.partner_id) > 1;


SELECT 
    customers.name
FROM
    customers
       JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name
HAVING COUNT(DISTINCT orders.order_date) = 3;


SELECT 
	orderdelivery.partner_id,
    deliverypartners.name,
    COUNT(DISTINCT orders.customer_id) AS no_of_unique_customers
FROM
    deliverypartners
        JOIN
    orderdelivery ON deliverypartners.partner_id = orderdelivery.partner_id
        JOIN
    orders ON orderdelivery.order_id = orders.order_id
GROUP BY deliverypartners.name , orderdelivery.partner_id
ORDER BY no_of_unique_customers DESC
LIMIT 1;


SELECT DISTINCT
    c1.name AS customer1,
    c2.name AS customer2,
    c1.city,
    r.name AS restaurant,
    o1.order_date AS order_date1,
    o2.order_date AS order_date2
FROM
    Customers c1
        JOIN
    Orders o1 ON c1.customer_id = o1.customer_id
        JOIN
    Orders o2 ON o1.restaurant_id = o2.restaurant_id
        JOIN
    Customers c2 ON c1.city = c2.city
        AND c1.customer_id <> c2.customer_id
        AND o2.customer_id = c2.customer_id
        JOIN
    Restaurants r ON o1.restaurant_id = r.restaurant_id
WHERE
    o1.order_date <> o2.order_date
        AND c1.customer_id < c2.customer_id
ORDER BY c1.city , r.name , o1.order_date;