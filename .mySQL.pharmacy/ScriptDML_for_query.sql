USE pharmacy;

-- Simple query
SELECT * FROM client;
SELECT * FROM components;
SELECT * FROM doctor;
SELECT * FROM product;
SELECT * FROM sell;
SELECT * FROM sell_has_product;

-- Specific queries

-- Calculate the total sales for each client and sale
SELECT
    c.name AS "NAME",
    s.id AS "SELL ID",
    SUM(product.price * sp.how_many) AS "TOTAL SELL AMOUNT", 
    s.date AS "DATE"
FROM
    client AS c
INNER JOIN
    sell AS s ON c.id = s.id_client
INNER JOIN
    sell_has_product AS sp ON sp.sell_id = s.id
INNER JOIN
    product ON product.id = sp.product_id
GROUP BY
    c.name, s.id;
----------------------------------------------------
-- Phone number by client
SELECT
	c.name AS "NAME",
    n.phone AS "NUMBER"
FROM
	client AS c,
    phone_number AS n
WHERE 
	c.id = n.id_client
GROUP BY 
	c.name,n.phone
ORDER BY 
	c.name DESC;
-------------------------------------------------------
-- Sales by year
SELECT
    p.id AS "ID",
    p.designation AS "NAME",
    DATE_FORMAT(s.date, '%d/%m/%Y') AS "SELL DATE",
    shp.how_many AS "HOW MANY",
    p.price AS "PRICE",
    shp.how_many * p.price AS "TOTAL SALE"
FROM
    product AS p
INNER JOIN
    sell_has_product shp ON p.id = shp.product_id
INNER JOIN
    sell s ON shp.sell_id = s.id
WHERE
   YEAR(s.date) = 2024;
   
-----------------------------------
-- Products that have a sale average less than general sale average
SELECT
    p.id AS "ID",
    p.designation AS "NAME",
    AVG(shp.how_many) AS "AVERAGE SALES"
FROM
    product AS p
JOIN
    sell_has_product shp ON p.id = shp.product_id
GROUP BY
    p.id, p.designation
HAVING
    AVG(shp.how_many) < (
        SELECT AVG(how_many)
        FROM sell_has_product
    );

------------------------------------------
-- Prices bigger than average price

SELECT
    p.designation AS "NAME",
    p.price AS "PRICE"
FROM
    product p
WHERE
    p.price > (
        SELECT AVG(price)
        FROM product
    );

------------------------------------
-- Recipe per doctor

SELECT
    d.name AS "DOCTOR",
    COUNT(dr.id) AS "N.RECIPES"
FROM
    doctor AS d
JOIN
   doctor_recipe AS dr ON d.id = dr.id_doctor
GROUP BY
    d.id, d.name;
