select * from customer
select * from salesman
select * from order1


-- 1. write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city
SELECT s.name AS Salesman, c.cust_name, c.city
FROM salesman s
JOIN customer c ON s.city = c.city;

-- 2. write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM order1 o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;

-- 3. write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission
SELECT c.cust_name, c.city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id;

-- 4. write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.
SELECT c.cust_name, c.city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

-- 5. write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission
SELECT c.cust_name, c.city AS CustomerCity, s.name AS Salesman, s.city AS SalesmanCity, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.city <> c.city AND s.commission > 0.12;

-- 6.write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name AS Salesman, s.commission
FROM order1 o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;


-- 7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned. 
SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, c.cust_name AS customer_name, c.city as cust_city, c.grade, c.salesman_id, s.name AS salesman_name, s.commission, s.city as SalesmanCity
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id
JOIN order1 o ON c.customer_id = o.customer_id;


-- 8. write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.
SELECT c.cust_name, c.city AS CustomerCity, c.grade, s.name AS Salesman, s.city AS SalesmanCity
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC;


-- 9. write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id. 
SELECT c.cust_name, c.city, c.grade, s.name AS Salesman, s.city AS SalesmanCity
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id ASC;


-- 10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order
--according to the order date to determine whether any of the existing customers have placed an order or not
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
LEFT JOIN order1 o ON c.customer_id = o.customer_id
ORDER BY o.ord_date ASC;


-- 11. Write a SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission
--to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name AS salesman_name, s.commission
FROM customer c
left JOIN order1 o ON c.customer_id = o.customer_id
left JOIN salesman s ON o.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC;


-- 12. Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers
-- or have not yet joined any of the customers
SELECT s.name AS Salesman, s.salesman_id, c.cust_name
FROM salesman s
full JOIN customer c ON s.salesman_id = c.salesman_id
ORDER BY s.salesman_id ASC;


-- 13. write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
SELECT s.name AS Salesman, s.salesman_id, c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
LEFT JOIN order1 o ON s.salesman_id = o.salesman_id
left JOIN customer c ON o.customer_id = c.customer_id
ORDER BY s.salesman_id ASC, o.ord_date ASC;


-- 14, 15. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customers. 
--The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, 
--or he may not have placed any order to the associated supplier.
SELECT s.name AS Salesman, s.salesman_id, c.cust_name, c.grade, o.ord_no, o.purch_amt
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN order1 o ON c.customer_id = o.customer_id
WHERE (o.purch_amt >= 2000 AND c.grade IS NOT NULL) OR c.customer_id IS NULL
ORDER BY s.salesman_id ASC, o.ord_no ASC;


-- 16. Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
LEFT JOIN order1 o ON c.customer_id = o.customer_id
WHERE (c.grade IS NOT NULL AND o.ord_no IS NOT NULL) OR (c.grade IS NULL AND o.ord_no IS NOT NULL)
ORDER BY c.customer_id ASC, o.ord_date ASC;


-- 17. Write a SQL query to combine each row of the salesman table with each row of the customer table
SELECT s.*, c.*
FROM salesman s
CROSS JOIN customer c;


-- 18. Write a SQL statement to create a Cartesian product between salesperson and customer,
-- i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city
SELECT s.*, c.*
FROM salesman s
CROSS JOIN customer c
WHERE s.city = c.city;


-- 19. Write a SQL statement to create a Cartesian product between salesperson and customer, 
-- i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade
SELECT s.*, c.*
FROM salesman s
CROSS JOIN customer c
WHERE s.city = c.city AND c.grade IS NOT NULL;


-- 20. Write a SQL statement to make a Cartesian product between salesman and custome
--i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city
--which is not the same as his customer and the customers should have their own grade
SELECT s.*, c.*
FROM salesman s
CROSS JOIN customer c
WHERE s.city <> c.city AND c.grade IS NOT NULL;









