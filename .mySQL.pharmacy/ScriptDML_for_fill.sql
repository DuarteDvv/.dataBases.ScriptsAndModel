USE pharmacy;
-- type_product
START TRANSACTION;
	INSERT INTO type_product(name) VALUES('Baby Care');
	INSERT INTO type_product(name) VALUES('Skin Care');
	INSERT INTO type_product(name) VALUES('Hygiene');
	INSERT INTO type_product(name) VALUES('Prescription Medications');
	INSERT INTO type_product(name) VALUES('Supplements');
COMMIT;

-- manufacturers
START TRANSACTION;
	INSERT INTO manufacturers(name) VALUES('BASF SE'); 
    INSERT INTO manufacturers(name) VALUES('Dow Chemical Company');
    INSERT INTO manufacturers(name) VALUES('Evonik Industries AG');
    INSERT INTO manufacturers(name) VALUES('Lanxess AG');
COMMIT;

-- components
START TRANSACTION;
	INSERT INTO components(name) VALUES('Hydrochloric Acid');
    INSERT INTO components(name) VALUES('Sodium Chloride');
    INSERT INTO components(name) VALUES('Ethanol');
    INSERT INTO components(name) VALUES('Sulfuric Acid');
    INSERT INTO components(name) VALUES('Ammonia');
COMMIT;

-- doctor
START TRANSACTION;
	INSERT INTO doctor(name,crm) VALUES('Dr. Emily Johnson',12345); 
    INSERT INTO doctor(name,crm) VALUES('Dr. Alexander Rodriguez',67890);
    INSERT INTO doctor(name,crm) VALUES('Dr. Olivia Smith',54321);
COMMIT;

-- client
START TRANSACTION;
	INSERT INTO client (cpf, cep, local, address)
	VALUES 
	('Carlos Alberto','123.456.789-01', '12345-678', 'Cidade A', 'Rua Principal, 123'),
	('Roberto Luiz', '987.654.321-09', '56789-012', 'Cidade B', 'Avenida Secundária, 456'),
	('Luiz Augusto','234.567.890-12', '34567-890', 'Cidade C', 'Travessa Terciária, 789'),
	('Jose Martins','876.543.210-98', '90123-456', 'Cidade D', 'Alameda Quaternária, 012');
COMMIT;

-- phone_number
START TRANSACTION;
	INSERT INTO phone_number (id_client, phone)
	VALUES
	(1, '+1 123-456-7890'),
	(2, '+1 987-654-3210'),
	(3, '+1 234-567-8901'),
	(4, '+1 876-543-2109'),
    (2, '+1 555-123-4567');
COMMIT;

-- sell
START TRANSACTION;
	INSERT INTO sell (id_client, date)
	VALUES
	(1, '2024-02-14'),
	(2, '2024-02-15'),
	(3, '2024-02-16'),
	(4, '2024-02-17'),
    (2, '2024-02-17');
COMMIT;

-- product
START TRANSACTION;
	INSERT INTO product (id_type_product, designation, price)
	VALUES
	(1, 'Product A', 19.99),
	(5, 'Product B', 29.99),
	(4, 'Product C', 15.99),
	(3, 'Product D', 24.99),
	(2, 'Product E', 34.99),
	(3, 'Product F', 21.99);
COMMIT;

-- has_manufacturers
START TRANSACTION;
	INSERT INTO has_manufacturers (id_product, id_manufacturer)
	VALUES
	(1, 1),
    (2, 2),
	(3, 4), 
	(4, 3),  
	(5, 2),  
	(6, 3);  
COMMIT;

-- components
START TRANSACTION;
	INSERT INTO has_components (id_product, id_components)
	VALUES
	(1, 1),  -- Product A com Component 1
	(2, 2),  -- Product B com Component 2
	(3, 1),  -- Product C com Component 1
	(4, 3),  -- Product D com Component 3
	(5, 2),  -- Product E com Component 2
	(6, 3),  -- Product F com Component 3
	(1, 4),  -- Product A com Component 4
	(2, 5),  -- Product B com Component 5
	(3, 4),  -- Product C com Component 4
	(4, 5),  -- Product D com Component 5
	(5, 4),  -- Product E com Component 4
	(6, 5);  -- Product F com Component 5
COMMIT;

-- sell_has_product
START TRANSACTION;
	INSERT INTO sell_has_product (sell_id, product_id, how_many)
	VALUES
	(1, 1, 3),  -- Venda 1 com Product A (3 unidades)
	(1, 2, 2),  -- Venda 1 com Product B (2 unidades)
	(2, 3, 1),  -- Venda 2 com Product C (1 unidade)
	(2, 4, 4),  -- Venda 2 com Product D (4 unidades)
	(3, 5, 2),  -- Venda 3 com Product E (2 unidades)
	(3, 6, 5);  -- Venda 3 com Product F (5 unidades)
COMMIT;

-- doctor_recipe
START TRANSACTION;
	INSERT INTO doctor_recipe (id_doctor, content, id_sell)
	VALUES
	(1, 'Prescrição para o Paciente 1', 1),  -- Receita do Doctor 1 para a Venda 1
	(2, 'Prescrição para o Paciente 2', 2),  -- Receita do Doctor 2 para a Venda 2
	(3, 'Prescrição para o Paciente 3', 3);  -- Receita do Doctor 3 para a Venda 3
COMMIT;


    
