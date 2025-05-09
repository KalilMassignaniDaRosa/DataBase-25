CREATE DATABASE normalized_invoice; -- Invoice = fatura

USE normalized_invoice;

CREATE TABLE invoice (
    invoice_number INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(256) NOT NULL,
    customer_address VARCHAR(256) NOT NULL,
    seller_name VARCHAR(256) NOT NULL,
    issue_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_value FLOAT NOT NULL,
    CONSTRAINT pk_invoice PRIMARY KEY (invoice_number)
);

CREATE TABLE product (
    product_code INT NOT NULL AUTO_INCREMENT,
    product_description VARCHAR(256) NOT NULL,
    unit_of_measure CHAR(2) NOT NULL,
    product_value FLOAT NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (product_code)
);

CREATE TABLE invoice_item (
    invoice_number INT NOT NULL,
    product_code INT NOT NULL,
    quantity INT NOT NULL,
    unit_price FLOAT NOT NULL,
    total_price FLOAT NOT NULL,
    CONSTRAINT pk_invoice_item PRIMARY KEY (invoice_number, product_code),
    CONSTRAINT fk_invoice_item_invoice FOREIGN KEY (invoice_number) REFERENCES invoice (invoice_number),
    CONSTRAINT fk_invoice_item_product FOREIGN KEY (product_code) REFERENCES product (product_code)
);

-- Produtos
INSERT INTO product (product_description, unit_of_measure, product_value) VALUES
('Milk', 'LT', 4.50),
('Deodorant', 'UN', 8.00),
('Salami', 'KG', 40.00);

-- Nota fiscal
INSERT INTO invoice (customer_name, customer_address, seller_name, total_value) VALUES
('Aragorn', 'Middle Earth', 'Bilbo', 100.00),
('Gandalf', 'Middle Earth', 'Frodo', 100.00),
('Boromir', 'Mordor', 'Sam', 100.00),
('Galadriel', 'Valinor', 'Saruman', 100.00);

-- Itens da nota
-- Nota 1
INSERT INTO invoice_item (invoice_number, product_code, quantity, unit_price, total_price) VALUES
(1, 1, 1, 4.50, 4.50),
(1, 2, 2, 40.00, 80.00),
(1, 3, 10, 100.00, 1000.00);

-- Nota 2
INSERT INTO invoice_item (invoice_number, product_code, quantity, unit_price, total_price) VALUES
(2, 1, 1, 9.00, 9.00),
(2, 2, 2, 80.00, 160.00),
(2, 3, 3, 33.00, 48.50);

-- Nota 3
INSERT INTO invoice_item (invoice_number, product_code, quantity, unit_price, total_price) VALUES
(3, 1, 1, 18.00, 18.00),
(3, 2, 2, 160.00, 320.00),
(3, 3, 10, 400.00, 4000.00);

-- Nota 4
INSERT INTO invoice_item (invoice_number, product_code, quantity, unit_price, total_price) VALUES
(4, 1, 1, 32.00, 32.00),
(4, 2, 2, 420.00, 840.00),
(4, 3, 10, 800.00, 8000.00);

SELECT * FROM product WHERE product_code = 3;

-- UPDATE, atualizando dados de colunas em tabelas
UPDATE product
SET product_value = 45, 
    product_description = 'Updated', 
    unit_of_measure = 'Bx' 
WHERE product_code = 3;

-- DELETE, exlucindo registros de tabelas
DELETE FROM product 
WHERE product_code = 3;
-- Neste caso uma execao sera lancada
-- Violacao da constraint que amarra o produto ao item na nota fiscal, nao e possivel excluir uma PK que tem dependencias em FKs

INSERT INTO product (product_description, unit_of_measure, product_value)
VALUES('Delete test','LT',5.50);

SELECT * FROM product;

DELETE FROM product WHERE product_code = 4;

SELECT * FROM invoice;
SELECT * FROM product;
SELECT * FROM invoice_item;