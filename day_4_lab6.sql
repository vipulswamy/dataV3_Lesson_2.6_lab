-- solutions to LAB 2.6
/*
+--------------------+
|  Notes to self     |
+--------------------+

Having clause
- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.

syntax:
	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	HAVING condition
	ORDER BY column_name(s);
    
 time: minutes and seconds
    MINUTE() Function
     -- MINUTE(datetime)
    EXTRACT() function 
	 -- EXTRACT(part FROM date)
    SEC_TO_TIME(1*60)
     -- SEC_TO_TIME(insert seconds)
*/

USE sakila;
/*
1. In the table actor, which are the actors whose last names are not repeated? 
For example:
 if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. 
 So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
*/
SELECT actor_id, last_name as "unique_last_names"
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1
order by actor_id;

/*
2. Which last names appear more than once? 
We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once
*/
SELECT actor_id, last_name as "unique_last_names"
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
order by actor_id;

/*
3. Using the rental table, find out how many rentals were processed by each employee.
*/

select DISTINCT customer_id, staff_id
from sakila.rental
group by customer_id
HAVING customer_id
order by staff_id;


/*
4. Using the film table, find out how many films were released each year.
*/

SELECT release_year as "years", COUNT(film_id) as "number_of_films_released"       --  choose to count the number of films, and rating column 
FROM sakila.film
group by years
having count(film_id) > 1; 

/*
5. Using the film table, find out for each rating how many films were there.
*/

SELECT COUNT(film_id), rating      --  choose to count the number of films, and rating column 
FROM sakila.film                   --  from this table
GROUP BY rating                    --  classify by ... rating
HAVING COUNT(film_id) > 1;         --  with different counts of films.. (condition)

/*
6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
*/
select rating as "film_rating", length  
from sakila.film
group by rating
having round(avg(length),2);

/*
7. Which kind of movies (rating) have a mean duration of more than two hours?
*/
select rating as "film_rating", length
from sakila.film
group by rating
-- having avg(SEC_TO_TIME(rating * 120)) ;
having avg(length) >= 100;
 
 -- I give up I need the solution 
 -- select convert('146',time);

/*
8. Rank films by length (filter out the rows that have nulls or 0s in length column).
   In your output, only select the columns title, length, and the rank.
*/

select DISTINCT length from sakila.film
where NOT (length = null) OR NOT (length = '');
