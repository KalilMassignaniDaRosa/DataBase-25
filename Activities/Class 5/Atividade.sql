CREATE DATABASE IF NOT EXISTS atividadeSimposio;

USE atividadeSimposio;

CREATE TABLE Pessoa(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	nome_completo VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	telefone VARCHAR(15) NOT NULL UNIQUE,
	sexo ENUM('M','F') NOT NULL,
	data_nascimento DATE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    codigo_universitario INT DEFAULT NULL,
    eh_universitario BOOLEAN NOT NULL DEFAULT FALSE,
	tipo_pessoa ENUM('Participante', 'Palestrante', 'Organizador') DEFAULT 'Participante' NOT NULL ,
    -- Impedindo que eh_universitario seja true e o codigo_universitario esteja vazio
    CONSTRAINT chk_codigo_universitario
		CHECK(
			(eh_universitario = TRUE AND codigo_universitario IS NOT NULL)
            OR 
            (eh_universitario = FALSE AND codigo_universitario IS NULL)
        )
);

CREATE TABLE Tema(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	descricao TEXT NOT NULL,
	area_conhecimento VARCHAR(255) NOT NULL, 
	data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Comissao(
	id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	id_tema INT NOT NULL,
	descricao TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT Fk_comissao_tema FOREIGN KEY (id_tema) REFERENCES Tema(id)
);

CREATE TABLE Minicurso(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	data_evento DATE NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
    id_tema INT NOT NULL,
    CONSTRAINT FK_minicurso_tema FOREIGN KEY (id_tema) REFERENCES Tema(id)
);

CREATE TABLE Artigo(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	avaliacao VARCHAR(255) NOT NULL,
	titulo VARCHAR(255) NOT NULL,
	data_submissao DATE NOT NULL,
	data_avaliacao DATE,
	nota_avaliacao INT,
	id_comissao  INT NOT NULL,
    id_tema INT NOT NULL,
	CONSTRAINT Fk_artigo_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id),
    CONSTRAINT Fk_artigo_tema FOREIGN KEY (id_tema) REFERENCES Tema(id)
);

CREATE TABLE Palestra(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	data_evento DATE NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
    id_tema INT NOT NULL,
    CONSTRAINT Fk_palestra_tema FOREIGN KEY (id_tema) REFERENCES Tema(id)
);

CREATE TABLE Simposio(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	descricao TEXT,
	universidade VARCHAR(255) NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	id_orador_principal INT NOT NULL,
	local_simposio VARCHAR(255) NOT NULL,
	capacidade INT,
	CONSTRAINT Fk_orador_simposio FOREIGN KEY (id_orador_principal) REFERENCES Pessoa(id)
);

-- Tabelas de Relacionamentos
CREATE TABLE Comissao_Pessoa(
	id_pessoa INT NOT NULL,
	id_comissao  INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_comissao),
	CONSTRAINT Fk_comissao_id_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_comissao_id_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id)
);

CREATE TABLE Inscrito_Simposio(
	id_evento INT NOT NULL,
	id_pessoa INT NOT NULL,
    data_inscricao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_pessoa, id_evento),
	CONSTRAINT Fk_inscrito_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscrito_simposio FOREIGN KEY (id_evento) REFERENCES Simposio(id)
);

CREATE TABLE Minicurso_Simposio(
	id_simposio INT NOT NULL,
	id_minicurso INT NOT NULL,
	PRIMARY KEY (id_simposio, id_minicurso),
	CONSTRAINT Fk_minicurso_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id),
	CONSTRAINT Fk_simposio_minicurso FOREIGN KEY (id_minicurso) REFERENCES Minicurso(id)
);

CREATE TABLE Artigo_Simposio(
	id_simposio INT NOT NULL,
	id_artigo INT NOT NULL,
	PRIMARY KEY (id_simposio, id_artigo),
	CONSTRAINT Fk_artigo_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id),
	CONSTRAINT Fk_simposio_artigo FOREIGN KEY (id_artigo) REFERENCES Artigo(id)
);

CREATE TABLE Palestra_Simposio(
	id_simposio INT NOT NULL,
	id_palestra INT NOT NULL,
	PRIMARY KEY (id_simposio, id_palestra),
	CONSTRAINT Fk_simposio_palestra FOREIGN KEY (id_simposio) REFERENCES Simposio(id),
	CONSTRAINT Fk_palestra_simposio FOREIGN KEY (id_palestra) REFERENCES Palestra(id)
);

CREATE TABLE Organizador_Simposio (
	id_pessoa INT NOT NULL,
	id_simposio INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_simposio),
	CONSTRAINT Fk_organizador_simposio_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_organizador_simposio_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id)
);

CREATE TABLE Autor_Artigo(
	id_pessoa INT NOT NULL,
	id_artigo INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_artigo),
	CONSTRAINT Fk_autor_artigo_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_autor_artigo_artigo  FOREIGN KEY (id_artigo) REFERENCES Artigo(id)
);

CREATE TABLE Inscricao_Minicurso(
	id_pessoa INT NOT NULL,
	id_minicurso INT NOT NULL,
    data_inscricao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_pessoa, id_minicurso),
	CONSTRAINT Fk_inscricao_minicurso_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscricao_minicurso_minicurso FOREIGN KEY (id_minicurso) REFERENCES Minicurso(id)
);

CREATE TABLE Inscricao_Palestra(
	id_pessoa INT NOT NULL,
	id_palestra INT NOT NULL,
    data_inscricao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_pessoa, id_palestra),
	CONSTRAINT Fk_inscricao_palestra_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscricao_palestra_palestra FOREIGN KEY (id_palestra) REFERENCES Palestra(id)
);

CREATE TABLE Inscricao_Artigo (
	id_pessoa INT NOT NULL,
	id_artigo INT NOT NULL,
    data_inscricao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pessoa, id_artigo),
    CONSTRAINT Fk_ia_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
    CONSTRAINT Fk_ia_artigo FOREIGN KEY (id_artigo) REFERENCES Artigo(id)
);

CREATE TABLE Orador_Minicurso (
	id_minicurso INT NOT NULL,
	id_pessoa INT NOT NULL,
	PRIMARY KEY (id_minicurso, id_pessoa),
	CONSTRAINT Fk_orador_minicurso  FOREIGN KEY (id_minicurso) REFERENCES Minicurso(id),
	CONSTRAINT Fk_om_pessoa  FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);

CREATE TABLE Orador_Palestra (
	id_palestra INT NOT NULL,
	id_pessoa INT NOT NULL,
	PRIMARY KEY (id_palestra, id_pessoa),
	CONSTRAINT Fk_orador_palestra FOREIGN KEY (id_palestra) REFERENCES Palestra(id),
	CONSTRAINT Fk_op_pessoa  FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);

-- Triggers
DELIMITER //
CREATE TRIGGER tr_impedir_inscricao_minicurso 
BEFORE INSERT ON Inscricao_Minicurso
FOR EACH ROW
BEGIN
    DECLARE orador_minicurso INT;

    -- Obtem o ID do orador do minicurso
    SELECT id_pessoa INTO orador_minicurso
    FROM Orador_Minicurso
    WHERE id_minicurso = NEW.id_minicurso;

    -- Impede a inserção se a pessoa for o orador
    IF NEW.id_pessoa = orador_minicurso THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Oradores nao podem se inscrever em seus proprios minicursos';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_impedir_inscricao_palestrante 
BEFORE INSERT ON Inscricao_Palestra
FOR EACH ROW
BEGIN
    DECLARE orador_palestra INT;

    -- Obtem o ID do orador da palestra
    SELECT id_pessoa INTO orador_palestra 
    FROM Orador_Palestra 
    WHERE id_palestra = NEW.id_palestra;

    -- Impede a inserção se a pessoa for o orador
    IF NEW.id_pessoa = orador_palestra THEN
        SIGNAL SQLSTATE '45000' -- Código de erro padrão
        SET MESSAGE_TEXT = 'Palestrantes nao podem se inscrever em suas proprias palestras';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_validar_tema_artigo
BEFORE INSERT ON Artigo
FOR EACH ROW
BEGIN
    DECLARE tema_comissao INT;

    -- Obtem o tema da comissão
    SELECT id_tema INTO tema_comissao
    FROM Comissao
    WHERE id = NEW.id_comissao;

    -- Verifica se o tema do artigo corresponde ao tema da comissão
    IF tema_comissao != NEW.id_tema THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O tema do artigo deve ser o mesmo da comissao avaliadora';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_insert_avaliacao_artigo
BEFORE INSERT ON Artigo
FOR EACH ROW
BEGIN
    -- Define avaliação com base na nota
    IF NEW.nota_avaliacao IS NOT NULL THEN
        IF NEW.nota_avaliacao >= 7 THEN
            SET NEW.avaliacao = 'Aprovado';
        ELSE
            SET NEW.avaliacao = 'Reprovado';
        END IF;
    END IF;
END//
DELIMITER ;

-- Views
CREATE VIEW View_CPF_Formatado AS
SELECT 
    id,
    CONCAT(
        SUBSTRING(cpf, 1, 3), '.', 
        SUBSTRING(cpf, 4, 3), '.', 
        SUBSTRING(cpf, 7, 3), '-', 
        SUBSTRING(cpf, 10, 2)
    ) AS cpf_formatado
FROM Pessoa;