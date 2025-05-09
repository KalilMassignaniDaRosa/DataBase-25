CREATE DATABASE db_normalization_pt;

USE db_normalization_pt;

-- Sem normalizacao
CREATE TABLE nota_fiscal_nao_normalizada (
    nr_nota INT PRIMARY KEY,
    nm_cliente VARCHAR(100),
    endereco VARCHAR(255),
    vendedor VARCHAR(100),
    dt_emissao DATE,
    produto1 VARCHAR(255),
    produto2 VARCHAR(255),
    produto3 VARCHAR(255),
    produto_n VARCHAR(255)
);

-- Primeira forma normal
CREATE TABLE nota_fiscal_1fn (
    nr_nota INT PRIMARY KEY,
    nm_cliente VARCHAR(100),
    endereco VARCHAR(255),
    vendedor VARCHAR(100),
    dt_emissao DATE,
    valor_total DECIMAL(10,2)
);

CREATE TABLE item_nota_fiscal_1fn (
    nr_nota INT,
    cod_produto VARCHAR(50),
    val_produto DECIMAL(10,2),
    PRIMARY KEY (nr_nota, cod_produto),
    FOREIGN KEY (nr_nota) REFERENCES nota_fiscal_1fn(nr_nota)
);

-- Segunda forma normal
CREATE TABLE produto_2fn (
    cod_produto VARCHAR(20) PRIMARY KEY,
    descricao VARCHAR(255),
    un_medida VARCHAR(10),
    vl_unitario DECIMAL(10,2)
);

CREATE TABLE vendedor_2fn (
    id_vendedor INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE nota_fiscal_2fn (
    nr_nota INT PRIMARY KEY,
    id_cliente INT,
    nm_cliente VARCHAR(100),
    endereco VARCHAR(255),
    id_vendedor INT,
    dt_emissao DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor_2fn(id_vendedor)
);

CREATE TABLE item_nota_fiscal_2fn (
    nr_nota INT,
    cod_produto VARCHAR(20),
    val_produto DECIMAL(10,2),
    val_unitario DECIMAL(10,2),
    val_total DECIMAL(10,2),
    PRIMARY KEY (nr_nota, cod_produto),
    FOREIGN KEY (nr_nota) REFERENCES nota_fiscal_2fn(nr_nota),
    FOREIGN KEY (cod_produto) REFERENCES produto_2fn(cod_produto)
);