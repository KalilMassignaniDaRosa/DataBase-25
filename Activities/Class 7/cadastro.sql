CREATE DATABASE dados_cadastrais;

USE dados_cadastrais;

CREATE TABLE Pessoa(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    sexo CHAR NOT NULL,
    rg VARCHAR(20) NOT NULL,
    cpf VARCHAR(17) NOT NULL
);

CREATE TABLE Cadastro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	matricula INT NOT NULL,
    data_admissao DATE NOT NULL 
);

CREATE TABLE Endereco(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rua VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    uf VARCHAR(4) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    complemento VARCHAR(100),
    numero int
);