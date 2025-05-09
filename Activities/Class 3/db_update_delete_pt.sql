CREATE DATABASE nota_fiscal_normalizada;

USE nota_fiscal_normalizada;

CREATE TABLE nota_fiscal (
	numero_nota INT NOT NULL AUTO_INCREMENT,
    nome_cliente VARCHAR(256) NOT NULL,
    endereco_cliente VARCHAR(256) NOT NULL,
    nome_vendedor VARCHAR(256) NOT NULL,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total FLOAT NOT NULL,
    CONSTRAINT pk_nota_fiscal PRIMARY KEY (numero_nota)
);

CREATE TABLE produto(
	codigo_produto INT NOT NULL AUTO_INCREMENT,
    descricao_produto VARCHAR(256) NOT NULL,
    unidade_medida CHAR(2) NOT NULL,
    valor_produto FLOAT NOT NULL,
    CONSTRAINT pk_produto PRIMARY KEY (codigo_produto)
);

CREATE TABLE item_nota_fiscal (
	numero_nota INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario FLOAT NOT NULL,
    valor_total FLOAT NOT NULL,
    CONSTRAINT pk_item_nota_fiscal PRIMARY KEY (numero_nota, codigo_produto),
    CONSTRAINT fk_item_nota_fiscal_nota FOREIGN KEY(numero_nota) REFERENCES nota_fiscal (numero_nota),
    CONSTRAINT fk_item_nota_fiscal_produto FOREIGN KEY(codigo_produto) REFERENCES produto(codigo_produto)
);

-- Produtos
INSERT INTO produto (descricao_produto, unidade_medida, valor_produto) VALUES
('Leite', 'LT', 4.50),
('Desodorante', 'UN', 8.00),
('Salame', 'KG', 40.00);

-- Nota Fiscal
INSERT INTO nota_fiscal (nome_cliente, endereco_cliente, nome_vendedor, valor_total) VALUES
('Aragorn', 'Terra Media', 'Bilbo', 100.00),
('Gandalf', 'Terra Media', 'Frodo', 100.00),
('Boromir', 'Mordor', 'Sam', 100.00),
('Galadriel', 'Valinor', 'Saruman', 100.00);

-- Itens da nota
-- Nota 1
INSERT INTO item_nota_fiscal (numero_nota, codigo_produto, quantidade, valor_unitario, valor_total) VALUES
(1,1,1,4.50,4.50),
(1,2,2,40.00,80.00),
(1,3,10,100.00,1000.00);

-- Nota 2
INSERT INTO item_nota_fiscal (numero_nota, codigo_produto, quantidade, valor_unitario, valor_total) VALUES
(2,1,1,9.00,9.00),
(2,2,2,80.00,160.00),
(2,3,3,33.00,48.50);

-- Nota 3
INSERT INTO item_nota_fiscal (numero_nota, codigo_produto, quantidade, valor_unitario, valor_total) VALUES
(3,1,1,18.00,18.00),
(3,2,2,160.00,320.00),
(3,3,10,400.00,4000.00);

-- Nota 4
INSERT INTO item_nota_fiscal (numero_nota, codigo_produto, quantidade, valor_unitario, valor_total) VALUES
(4,1,1,32.00,32.00),
(4,2,2,420.00,840.00),
(4,3,10,800.00,8000.00);

SELECT * FROM produto WHERE codigo_produto = 3;

-- UPDATE, atualizando dados de colunas em tabelas
UPDATE produto
SET valor_produto = 45, 
	descricao_produto ='Atualizado', 
    unidade_medida = 'Cx' 
WHERE codigo_produto  = 3;

-- DELETE, exlucindo registros de tabelas
DELETE FROM produto 
WHERE codigo_produto = 3;
-- Neste caso uma execao sera lancada
-- Violacao da constraint que amarra o produto ao item na nota fiscal, nao e possivel excluir uma PK que tem dependencias em FKs

INSERT INTO produto (descricao_produto, unidade_medida, valor_produto)
VALUES('Teste delete','LT',5.50);

SELECT * FROM produto;

DELETE FROM produto WHERE codigo_produto  = 4;

SELECT * FROM nota_fiscal;
SELECT * FROM produto;
SELECT * FROM item_nota_fiscal;