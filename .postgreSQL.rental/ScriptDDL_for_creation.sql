
CREATE DATABASE rental;

/c rental;

CREATE TABLE movie_category(
	id SERIAL PRIMARY KEY,
	category VARCHAR NOT NULL
);

CREATE TABLE movie(
	id SERIAL PRIMARY KEY,
	title VARCHAR(45) NOT NULL,
	duration DECIMAL(5,2) NOT NULL,
	id_category INT NOT NULL REFERENCES movie_category(id),
	price_per_day MONEY NOT NULL
);

CREATE TABLE dvd(
	id SERIAL PRIMARY KEY,
	id_movie INT NOT NULL REFERENCES movie(id),
	quantity INT NOT NULL
);

CREATE TABLE actor(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birth_date DATE,
	nationality VARCHAR(45)
);


CREATE TABLE movie_has_actor(
	id_movie INT NOT NULL REFERENCES movie(id),
	id_actor INT NOT NULL REFERENCES actor(id),
	character VARCHAR(45) NOT NULL
);

CREATE TABLE client(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL,
	address VARCHAR(45) NOT NULL
);

CREATE TABLE phone_number(
	id_client SERIAL PRIMARY KEY REFERENCES client(id),
	numbers VARCHAR(15) NOT NULL
);

CREATE TABLE rent(
	id SERIAL PRIMARY KEY,
	id_client INT NOT NULL REFERENCES client(id),
	begin_date DATE NOT NULL,
	end_date DATE NOT NULL
);

CREATE TABLE rent_has_dvd(
	id_rent INT NOT NULL REFERENCES rent(id),
	id_dvd INT NOT NULL REFERENCES dvd(id)
);

CREATE TABLE returned(
	id SERIAL PRIMARY KEY,
	id_rent INT NOT NULL REFERENCES rent(id),
	return_date DATE NOT NULL,
	number_returned INT NOT NULL,
	returned_condition VARCHAR(45) NOT NULL
);
