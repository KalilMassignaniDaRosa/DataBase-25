CREATE DATABASE dados_cadastrais;
USE dados_cadastrais;

-- Tabela base de Pessoas 
CREATE TABLE Pessoa(
    pessoa_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    rg VARCHAR(20) NOT NULL UNIQUE,
    cpf VARCHAR(11) NOT NULL UNIQUE, 
    data_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    sexo ENUM('M','F') NOT NULL,
    estado_civil ENUM('Solteiro','Casado','Divorciado','Viuvo') NOT NULL,
    tipo ENUM('Titular','Dependente') NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_pessoa PRIMARY KEY (pessoa_id)
);

-- Tabela de Endereços
CREATE TABLE Endereco(
    endereco_id INT NOT NULL AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_endereco PRIMARY KEY (endereco_id)
);

-- Tabela de Cargos
CREATE TABLE Cargo(
    cargo_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    nivel VARCHAR(50),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cargo PRIMARY KEY (cargo_id)
);

-- Tabela de Departamentos
CREATE TABLE Departamento(
    departamento_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(10),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_departamento PRIMARY KEY (departamento_id)
);

-- Tabela de Cadastro (Matrícula)
CREATE TABLE Cadastro(
    cadastro_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cadastro PRIMARY KEY (cadastro_id),
    CONSTRAINT fk_cadastro_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id)
);

-- Tabela de Cargos Ocupados
CREATE TABLE Cargos_Ocupados(
    cargo_ocupado_id INT NOT NULL AUTO_INCREMENT,
    cadastro_id INT NOT NULL,
    cargo_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    cargo_atual BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cargos_ocupados PRIMARY KEY (cargo_ocupado_id),
    CONSTRAINT fk_co_cadastro FOREIGN KEY (cadastro_id) REFERENCES Cadastro(cadastro_id),
    CONSTRAINT fk_co_cargo FOREIGN KEY (cargo_id) REFERENCES Cargo(cargo_id)
);

-- Tabela de Lotação 
CREATE TABLE Lotacao(
    lotacao_id INT NOT NULL AUTO_INCREMENT,
    cadastro_id INT NOT NULL,
    departamento_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    lotacao_atual BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT pk_lotacao PRIMARY KEY (lotacao_id),
    CONSTRAINT fk_lotacao_cadastro FOREIGN KEY (cadastro_id) REFERENCES Cadastro(cadastro_id),
    CONSTRAINT fk_lotacao_departamento FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id)
);

-- Tabela de Dependentes
CREATE TABLE Dependente(
    dependente_id INT NOT NULL AUTO_INCREMENT,
    cadastro_id INT NOT NULL,
    pessoa_id INT NOT NULL UNIQUE, 
    parentesco VARCHAR(50) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_dependente PRIMARY KEY (dependente_id),
    CONSTRAINT fk_dependente_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_dependente_titular FOREIGN KEY (cadastro_id) REFERENCES Cadastro(cadastro_id)
);

CREATE TABLE Pessoa_Endereco (
    pessoa_id INT NOT NULL,
    endereco_id INT NOT NULL,
    endereco_atual BOOLEAN NOT NULL DEFAULT FALSE,
    tipo_endereco ENUM('Residencial', 'Comercial', 'Outro') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_pessoa_endereco PRIMARY KEY (pessoa_id, endereco_id),
    CONSTRAINT fk_pe_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_pe_endereco FOREIGN KEY (endereco_id) REFERENCES Endereco(endereco_id)
);

-- Validação de dependentes
-- Insert
DELIMITER //
CREATE TRIGGER trg_valida_dependente_insert
BEFORE INSERT ON Dependente
FOR EACH ROW
BEGIN
    -- Verifica se pessoa é dependente
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.pessoa_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    -- Verifica se titular existe e é válido
    IF NOT EXISTS (
        SELECT 1 FROM Cadastro c
        INNER JOIN Pessoa p ON p.pessoa_id = c.pessoa_id
        WHERE c.cadastro_id = NEW.cadastro_id
        AND p.tipo = 'Titular'
        AND (c.data_demissao IS NULL OR c.data_demissao > CURDATE())
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser válido e do tipo "Titular"';
    END IF;
    
    -- Impede auto-dependência
    IF NEW.pessoa_id = (
        SELECT pessoa_id FROM Cadastro WHERE cadastro_id = NEW.cadastro_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END //

-- Update
CREATE TRIGGER trg_valida_dependente_update
BEFORE UPDATE ON Dependente
FOR EACH ROW
BEGIN
    -- Verifica se pessoa é dependente
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.pessoa_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    -- Verifica se titular existe e é válido
    IF NOT EXISTS (
        SELECT 1 FROM Cadastro c
        INNER JOIN Pessoa p ON p.pessoa_id = c.pessoa_id
        WHERE c.cadastro_id = NEW.cadastro_id
        AND p.tipo = 'Titular'
        AND (c.data_demissao IS NULL OR c.data_demissao > CURDATE())
    )  THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser válido e do tipo "Titular"';
    END IF;
    
    -- Impede auto-dependência
    IF NEW.pessoa_id = (
        SELECT pessoa_id FROM Cadastro WHERE cadastro_id = NEW.cadastro_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END //

-- Validação de CPF
CREATE TRIGGER trg_valida_cpf
BEFORE INSERT ON Pessoa
FOR EACH ROW
BEGIN
	-- Exatamente 11 digitos entre 0 e 9
    IF NEW.cpf NOT REGEXP '^[0-9]{11}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CPF deve conter exatamente 11 dígitos numéricos';
    END IF;
END //
DELIMITER ;

-- View CPF formatado
CREATE VIEW vw_cpf_formatado AS
SELECT 
    pessoa_id,
    nome,
    sobrenome,
    CONCAT(SUBSTRING(cpf, 1, 3), '.', 
           SUBSTRING(cpf, 4, 3), '.', 
           SUBSTRING(cpf, 7, 3), '-', 
           SUBSTRING(cpf, 10, 2)) AS cpf_formatado
FROM Pessoa;

-- Função para dependentes
DELIMITER //
CREATE FUNCTION GetIdDependente(p_cadastro_id INT) 
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE dependentes_ids VARCHAR(255);
    SELECT GROUP_CONCAT(d.pessoa_id ORDER BY d.pessoa_id SEPARATOR ',')
    INTO dependentes_ids
    FROM Dependente d
    WHERE d.cadastro_id = p_cadastro_id;

    RETURN IFNULL(dependentes_ids, '');
END //
DELIMITER ;

-- Índices para Pessoa
CREATE INDEX idx_pessoa_cpf ON Pessoa(cpf);
CREATE INDEX idx_pessoa_nome_sobrenome ON Pessoa(nome, sobrenome);

-- Índices para Cadastro
CREATE INDEX idx_cadastro_matricula ON Cadastro(matricula);
CREATE INDEX fk_cadastro_pessoa_idx ON Cadastro(pessoa_id);

-- Índices para Cargos_Ocupados
CREATE INDEX fk_co_cadastro_idx ON Cargos_Ocupados(cadastro_id);
CREATE INDEX fk_co_cargo_idx ON Cargos_Ocupados(cargo_id);

-- Índices para Lotacao
CREATE INDEX fk_lotacao_cadastro_idx ON Lotacao(cadastro_id);
CREATE INDEX fk_lotacao_departamento_idx ON Lotacao(departamento_id);

-- Índices para Dependente
CREATE INDEX fk_dependente_cadastro_idx ON Dependente(cadastro_id);
CREATE INDEX fk_dependente_pessoa_idx ON Dependente(pessoa_id);