CREATE DATABASE unoesc_bank;

USE unoesc_bank;

CREATE TABLE clients (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255)
);

CREATE TABLE accounts(
	id INT NOT NULL AUTO_INCREMENT,
    account_number VARCHAR(10) NOT NULL,
    client_id INT NOT NULL,
    CONSTRAINT pk_accounts PRIMARY KEY (id), -- Primeira forma de Pk
	CONSTRAINT fk_accounts_client FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE transactions(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Forma alternativa de pk
    account_id INT NOT NULL,
    transaction_type INT NOT NULL,
    date_time DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_transactions_account FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Definindo uma fk posteriormente a cricao da tabela
ALTER TABLE transactions
ADD FOREIGN KEY (account_id)
REFERENCES accounts (id);

-- Criando indices
CREATE INDEX idx_transactions_type
ON transactions (transaction_type);

CREATE INDEX idx_transactions_date_time
ON transactions (date_time);