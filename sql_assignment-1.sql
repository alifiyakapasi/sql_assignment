Assignment 1 :  Simple SQL Query with a single table with where clause 

-------------------------------------------------------------------------------------------------------------------------- 

 Northwind database  

 Sample table :Products  

-ProductID  

-ProductName                      

-SupplierID  

-CategoryID  

-QuantityPerUnit      

-UnitPrice  

-UnitsInStock  

-UnitsOnOrder  

-ReorderLevel  

-Discontinued  

 
1. Write a query to get a Product list (id, name, unit price) where current products cost less than $20. 
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE (((UnitPrice)<20) AND ((Discontinued)=False))
ORDER BY UnitPrice DESC;

2. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 15 AND 25;

3. Write a query to get Product list (name, unit price) of above average price. 
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice;

4. Write a query to get Product list (name, unit price) of ten most expensive products.
select top 10 ProductName AS "Ten Most Expensive Products", UnitPrice
FROM products ORDER BY UnitPrice DESC;
OR
SELECT DISTINCT ProductName AS "Ten Most Expensive Products", UnitPrice
FROM products AS a
WHERE (SELECT COUNT(DISTINCT UnitPrice) FROM products AS b WHERE b.UnitPrice >= a.UnitPrice) <= 10
ORDER BY UnitPrice DESC;

5. Write a query to count current and discontinued products.
SELECT Count(ProductName)
FROM Products
GROUP BY Discontinued;

6. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.
SELECT ProductName, UnitsOnOrder, UnitsInStock
FROM Products
WHERE UnitsInStock < UnitsOnOrder;