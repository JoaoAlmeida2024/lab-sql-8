select *
from sakila.film;

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length,
rank() over (order by length desc) as ranking_length
from sakila.film
where length IS NOT NULL OR length <> 0 ;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title, length, rating, 
rank() over (partition by rating order by length desc) as ranking_length
from sakila.film
where length IS NOT NULL OR length <> 0 ;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select * from sakila.category;

select * from sakila.film_category;

select c.category_id, c.name, count(fm.film_id)
from sakila.category c
left join sakila.film_category fm
on c.category_id = fm.category_id
group by 1, 2
order by 1 asc;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select * from sakila.actor;

select * from sakila.film_actor;

select fa.actor_id, sa.first_name, sa.capital_surname, count(fa.film_id)
from sakila.film_actor fa
left join sakila.actor sa
on fa.actor_id = sa.actor_id
group by 1, 2, 3
order by 4 desc;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select * from sakila.customer;

select * from sakila.rental;

select sc.customer_id, sc.first_name, sc.last_name, count(r.rental_id)
from sakila.customer sc
left join sakila.rental r
on sc.customer_id = r.customer_id
group by 1, 2, 3
order by 4 desc;