CREATE DATABASE db_normalization_en;

USE db_normalization_en;

-- Sem normalizacao
CREATE TABLE invoice_not_normalized (
    invoice_number INT PRIMARY KEY,
    customer_name VARCHAR(255),
    address VARCHAR(255),
    seller VARCHAR(100),
    issue_date DATE,
    product1 VARCHAR(255),
    product2 VARCHAR(255),
    product3 VARCHAR(255),
    product_n VARCHAR(255)
);

-- Primeira forma normal
CREATE TABLE invoice_1nf (
    invoice_number INT PRIMARY KEY,
    customer_name VARCHAR(255),
    address VARCHAR(255),
    seller VARCHAR(100),
    issue_date DATE,
    total_value DECIMAL(10,2)
);

CREATE TABLE invoice_item_1nf (
    invoice_number INT,
    product_code VARCHAR(50),
    product_value DECIMAL(10,2),
    PRIMARY KEY (invoice_number, product_code),
    FOREIGN KEY (invoice_number) REFERENCES invoice_1nf(invoice_number)
);

-- Segunda forma normal
CREATE TABLE product_2nf (
    product_code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(255),
    unit_of_measure VARCHAR(10),
    unit_price DECIMAL(10,2)
);

CREATE TABLE vendor_2nf (
    vendor_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE invoice_2nf (
    invoice_number INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(255),
    address VARCHAR(255),
    vendor_id INT,
    issue_date DATE,
    total_value DECIMAL(10,2),
    FOREIGN KEY (vendor_id) REFERENCES vendor_2nf(vendor_id)
);

CREATE TABLE invoice_item_2nf (
    invoice_number INT,
    product_code VARCHAR(20),
    product_value DECIMAL(10,2),
    unit_price DECIMAL(10,2),
    line_total DECIMAL(10,2),
    PRIMARY KEY (invoice_number, product_code),
    FOREIGN KEY (invoice_number) REFERENCES invoice_2nf(invoice_number),
    FOREIGN KEY (product_code) REFERENCES product_2nf(product_code)
);