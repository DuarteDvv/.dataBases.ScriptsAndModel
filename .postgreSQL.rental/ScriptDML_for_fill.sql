-- Adicionando categorias de filmes
INSERT INTO movie_category (category) VALUES 
('Comédia'),
('Drama'),
('Aventura'),
('Ação'),
('Ficção Científica');

-- Adicionando filmes
INSERT INTO movie (title, duration, id_category, price_per_day) VALUES
('A Era do Gelo', 90.5, 3, 2.50),
('O Poderoso Chefão', 175.75, 2, 3.50),
('Matrix', 120.0, 4, 3.00),
('Jurassic Park', 130.25, 3, 2.75),
('Titanic', 195.5, 2, 4.00);

-- Adicionando DVDs
INSERT INTO dvd (id_movie, quantity) VALUES
(1, 10),
(2, 5),
(3, 8),
(4, 12),
(5, 6);

-- Adicionando atores
INSERT INTO actor (name, birth_date, nationality) VALUES
('Tom Hanks', '1956-07-09', 'Americano'),
('Jennifer Lawrence', '1990-08-15', 'Americana'),
('Leonardo DiCaprio', '1974-11-11', 'Americano'),
('Scarlett Johansson', '1984-11-22', 'Americana'),
('Chris Hemsworth', '1983-08-11', 'Australiano');

-- Adicionando relação entre filmes e atores
INSERT INTO movie_has_actor (id_movie, id_actor, character) VALUES
(1, 1, 'Sid'),
(2, 1, 'Don Vito Corleone'),
(2, 4, 'Rose DeWitt Bukater'),
(3, 3, 'Neo'),
(4, 5, 'Owen Grady'),
(5, 4, 'Jack Dawson');

-- Adicionando clientes
INSERT INTO client (first_name, last_name, address) VALUES
('João', 'Silva', 'Rua A, 123'),
('Maria', 'Oliveira', 'Avenida B, 456'),
('Carlos', 'Santos', 'Travessa C, 789'),
('Ana', 'Pereira', 'Rua D, 321');

-- Adicionando números de telefone para os clientes
INSERT INTO phone_number (id_client, numbers) VALUES
(1, '123456789'),
(2, '987654321'),
(3, '111223344'),
(4, '55556666');

-- Adicionando aluguéis
INSERT INTO rent (id_client, begin_date, end_date) VALUES
(1, '2024-02-01', '2024-02-07'),
(2, '2024-02-03', '2024-02-10'),
(3, '2024-02-05', '2024-02-12'),
(4, '2024-02-08', '2024-02-15');

-- Adicionando DVDs aos aluguéis
INSERT INTO rent_has_dvd (id_rent, id_dvd) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

-- Adicionando devoluções
INSERT INTO returned (id_rent, return_date, number_returned, returned_condition) VALUES
(1, '2024-02-08', 2, 'Bom'),
(2, '2024-02-11', 1, 'Excelente'),
(3, '2024-02-14', 3, 'Regular'),
(4, '2024-02-17', 2, 'Ruim');
