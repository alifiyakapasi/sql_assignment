-- CODING EXERCISE 1
SELECT DISTINCT customer_id 
FROM payment
WHERE amount>=7.99
ORDER BY customer_id

--CODING EXERCISE 2
SELECT title AS "MovieName",rental_rate ,replacement_cost 
FROM film
WHERE rental_rate>2.99 OR replacement_cost>19.99

--CODING EXERCISE 3
SELECT  title AS "MovieName",rental_rate,replacement_cost ,rental_duration 
FROM film
WHERE rental_duration BETWEEN 4 AND 6
ORDER BY replacement_cost DESC
LIMIT 100

--CODING EXERCISE 4
SELECT  title AS "MovieName",rental_rate,replacement_cost,rating 
FROM film
WHERE rating = 'G' OR rating = 'PG'

--CODING EXERCISE 5
SELECT DISTINCT first_name , COUNT(*) 
FROM actor
GROUP BY first_name

--CODING EXERCISE 6
SELECT f.title AS "MovieName" ,l.name AS "Language" 
FROM film f 
INNER JOIN language l
ON f.language_id = l.language_id

--CODING EXERICISE 7
SELECT CONCAT(actor.first_name,' ',actor.last_name),count(film.film_id)
FROM actor INNER JOIN film_actor 
ON actor.actor_id=film_actor.actor_id
INNER JOIN film
ON film_actor.film_id=film.film_id
GROUP BY actor.actor_id
ORDER BY count DESC

--CODING EXERCISE 8
SELECT DISTINCT film.rating, 
count(inventory.inventory_id) AS total_movie
FROM film
INNER JOIN inventory
ON film.film_id=inventory.film_id
RIGHT JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.rating
ORDER BY total_movie DESC

-- OR

SELECT f.rating,
COUNT(r.rental_id) as total_movie
FROM film f 
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY rating
ORDER BY total_movie DESC

--CODING EXERCISE 9
SELECT customer.first_name,customer.last_name,customer.email,AGE(rental.return_date,rental.rental_date) AS "RentalTime"
FROM customer
INNER JOIN rental
ON customer.customer_id=rental.customer_id
WHERE AGE(rental.return_date,rental.rental_date) > interval '7 Days'
ORDER BY "RentalTime" ASC

--CODING EXERCISE 10,11
SELECT title,
LENGTH(title),
SUBSTR(title,10) AS "after 10th",
SUBSTR(title,15) AS "after 15th",
SUBSTR(title,5,3) AS "after 5th till 3 char",
SUBSTR(title,5,1) AS "after 5th till 1 char"
FROM film

--CODING EXERCISE 12
SELECT CONCAT(customer.first_name,' ',customer.last_name) AS "CustomerName",
       customer.email,
       SUM(payment.amount) AS TotalAmount,
       CASE
         WHEN SUM(payment.amount) > 200 THEN 'Elite'
         WHEN SUM(payment.amount) > 150 AND SUM(payment.amount) <= 200 THEN 'Platinum'
         WHEN SUM(payment.amount) > 100 AND SUM(payment.amount) <= 150 THEN 'Gold'
         WHEN SUM(payment.amount) <= 100 AND SUM(payment.amount) > 0 THEN 'Silver'
       END AS "Tier"
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY "CustomerName", customer.email;

--CODING EXERCISE 13
CREATE VIEW customer_segment AS
SELECT CONCAT(customer.first_name,' ',customer.last_name) AS "Customer Name",
       customer.email,
       SUM(payment.amount) AS "Total Rental",
       CASE
         WHEN SUM(payment.amount) > 200 THEN 'Elite'
         WHEN SUM(payment.amount) > 150 AND SUM(payment.amount) <= 200 THEN 'Platinum'
         WHEN SUM(payment.amount) > 100 AND SUM(payment.amount) <= 150 THEN 'Gold'
         WHEN SUM(payment.amount) <= 100 AND SUM(payment.amount) > 0 THEN 'Silver'
       END AS "Customer Category"
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY "Customer Name", customer.email;

SELECT * FROM customer_segment

----------------------------------------------------------
SELECT title,rental_rate,replacement_cost,
CASE
	WHEN rental_rate < 1 THEN 'Budget_Movie'
	WHEN rental_rate >=1 AND rental_rate<=3 THEN 'Standard Movie'
	WHEN rental_rate >3 THEN 'Premium Movie'
END AS "Category"
FROM film
ORDER BY rental_rate

