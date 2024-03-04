-- simple query 

SELECT * FROM actor;
SELECT * FROM client;
SELECT * FROM movie;
SELECT * FROM movie_has_actor;
SELECT * FROM returned;
SELECT * FROM rent;
SELECT * FROM rent_has_dvd;
SELECT * FROM dvd;

-- Ccomplex query

-- number of actors and youngest actor name and character
SELECT 
    m.title,
    mc.category,
    COUNT(mha.id_actor) AS number_of_actors,
    (
        SELECT a.name
        FROM actor AS a
        INNER JOIN movie_has_actor AS mha_sub ON a.id = mha_sub.id_actor
        WHERE mha_sub.id_movie = m.id
        ORDER BY a.birth_date ASC
        LIMIT 1
    ) AS youngest_actor_name,
	 (
        SELECT mha_sub.character
        FROM actor AS a
        INNER JOIN movie_has_actor AS mha_sub ON a.id = mha_sub.id_actor
        WHERE mha_sub.id_movie = m.id
        ORDER BY a.birth_date ASC
        LIMIT 1
    ) AS character_interpreted
	
FROM
    movie AS m
INNER JOIN 
    movie_has_actor AS mha ON m.id = mha.id_movie
INNER JOIN
    movie_category AS mc ON mc.id = m.id_category
GROUP BY
    m.title, mc.category, youngest_actor_name,character_interpreted;
	
-- movies w price bigger than average

SELECT 
	m.title, 
	m.price_per_day
FROM 
	movie AS m
WHERE 
	m.price_per_day::numeric > (SELECT AVG(price_per_day::numeric) FROM movie);
	
-- all movies where one actor worked and character interpreted

SELECT 
	m.title, 
	mc.category, 
	mha.character 
FROM
	movie AS m
INNER JOIN 
	movie_has_actor AS mha ON m.id = mha.id_movie
INNER JOIN 
	movie_category AS mc ON mc.id = m.id_category
INNER JOIN 
	actor AS a ON mha.id_actor = a.id
WHERE 
	a.name = 'Tom Hanks';	
	
-- total price, dates and client by rental
SELECT 
    r.id,
    c.first_name,
	m.title,
    r.begin_date,
    r.end_date,
    ret.return_date,
    (EXTRACT(DAY FROM COALESCE(ret.return_date, CURRENT_DATE)) - EXTRACT(DAY FROM r.begin_date)) AS days_late,
    SUM(m.price_per_day * (EXTRACT(DAY FROM COALESCE(ret.return_date, CURRENT_DATE)) - EXTRACT(DAY FROM r.begin_date))) AS total
FROM 
    client AS c 
INNER JOIN 
    rent AS r ON r.id_client = c.id
INNER JOIN 
    rent_has_dvd AS rhd ON r.id = rhd.id_rent
INNER JOIN
    dvd AS d ON d.id = rhd.id_dvd
INNER JOIN 
    movie AS m ON m.id = d.id_movie
LEFT JOIN
    returned AS ret ON r.id = ret.id_rent
GROUP BY 
    r.id, c.first_name,m.title, r.begin_date, r.end_date, ret.return_date;
	
-- number of movies rented by category and total price

SELECT 
    c.id AS client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    mc.category AS movie_category,
    COUNT(rhd.id_rent) AS num_rented_movies,
    SUM(m.price_per_day * (EXTRACT(DAY FROM ret.return_date) - EXTRACT(DAY FROM r.begin_date))) AS total_spent
FROM 
    client AS c 
INNER JOIN 
    rent AS r ON r.id_client = c.id
INNER JOIN 
    rent_has_dvd AS rhd ON r.id = rhd.id_rent
INNER JOIN
    dvd AS d ON d.id = rhd.id_dvd
INNER JOIN 
    movie AS m ON m.id = d.id_movie
INNER JOIN
    movie_category AS mc ON mc.id = m.id_category
LEFT JOIN
    returned AS ret ON r.id = ret.id_rent
WHERE
    mc.category = 'Drama'  
GROUP BY 
    c.id, c.first_name, c.last_name, mc.category;

-- return if exists, all rented movies by category

SELECT 
    c.id AS client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name
FROM 
    client AS c 
WHERE
    EXISTS (
        SELECT 1
        FROM rent AS r
        INNER JOIN rent_has_dvd AS rhd ON r.id = rhd.id_rent
        INNER JOIN dvd AS d ON d.id = rhd.id_dvd
        INNER JOIN movie AS m ON m.id = d.id_movie
        INNER JOIN movie_category AS mc ON mc.id = m.id_category
        WHERE
            r.id_client = c.id
            AND mc.category = 'Drama'
    );

-- return late clients and how many days
SELECT 
    c.id AS client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    r.id AS rent_id,
    r.begin_date,
    r.end_date,
    CURRENT_DATE AS current_date,
    CASE 
        WHEN CURRENT_DATE > r.end_date THEN CURRENT_DATE - r.end_date
        ELSE 0
    END AS days_late
FROM 
    client AS c 
INNER JOIN 
    rent AS r ON r.id_client = c.id
WHERE
    CURRENT_DATE > r.end_date
    AND NOT EXISTS (
        SELECT 1
        FROM returned AS ret
        WHERE ret.id_rent = r.id
    ); 

