-- Criação do banco de dados
DROP DATABASE IF EXISTS consultorio_medico;
CREATE DATABASE consultorio_medico;
USE consultorio_medico;

CREATE TABLE Convenio (
    id_convenio INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    registro_ans VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    CONSTRAINT pk_convenio PRIMARY KEY (id_convenio)
);

CREATE TABLE Paciente (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    numero_paciente VARCHAR(20) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo ENUM('F', 'M', 'Outro') NOT NULL,
    estado_civil ENUM('Solteiro','Casado','Divorciado','Viúvo','Outro') NULL,
    cpf VARCHAR(14) UNIQUE,
    rg VARCHAR(20) UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    id_convenio INT NOT NULL,  
    email VARCHAR(100),
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    uf CHAR(2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_paciente PRIMARY KEY (id_paciente),
    CONSTRAINT fk_paciente_convenio FOREIGN KEY (id_convenio)
		REFERENCES Convenio(id_convenio),
    INDEX idx_paciente_nome (nome)
);

CREATE TABLE Especialidade (
    id_especialidade INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    CONSTRAINT pk_especialidade PRIMARY KEY (id_especialidade)
);

CREATE TABLE Medico (
    id_medico INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    uf_crm CHAR(2) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_medico PRIMARY KEY (id_medico),
    INDEX idx_medico_nome (nome)
);

CREATE TABLE Medico_Especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT pk_med_espec PRIMARY KEY (id_medico, id_especialidade),
    CONSTRAINT fk_me_medico FOREIGN KEY (id_medico)
        REFERENCES Medico(id_medico),
    CONSTRAINT fk_me_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES Especialidade(id_especialidade)
);

CREATE TABLE Consulta (
    id_consulta INT NOT NULL AUTO_INCREMENT,
    numero_consulta VARCHAR(20) NOT NULL UNIQUE,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_convenio INT,
    data_hora DATETIME NOT NULL,
    duracao INT DEFAULT 30 COMMENT 'Minutos',
    diagnostico TEXT,
    prescricao TEXT,
    status ENUM('Agendada', 'Confirmada', 'Realizada', 'Cancelada', 'Falta') DEFAULT 'Agendada',
    valor DECIMAL(10,2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_consulta PRIMARY KEY (id_consulta),
    CONSTRAINT fk_cons_paciente FOREIGN KEY (id_paciente)
        REFERENCES Paciente(id_paciente),
    CONSTRAINT fk_cons_medico FOREIGN KEY (id_medico)
        REFERENCES Medico(id_medico),
    CONSTRAINT fk_cons_convenio FOREIGN KEY (id_convenio)
        REFERENCES Convenio(id_convenio),
    INDEX idx_consulta_data (data_hora),
    INDEX idx_consulta_status (status)
);

CREATE TABLE Tipo_Exame (
    id_tipo_exame INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    valor_referencia DECIMAL(10,2),
	CONSTRAINT pk_tipo_exame PRIMARY KEY (id_tipo_exame)
);

CREATE TABLE Exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_tipo_exame INT NOT NULL,
    data_realizacao DATE,
    resultado TEXT,
    status ENUM('Solicitado', 'Realizado', 'Entregue', 'Cancelado') DEFAULT 'Solicitado',
    CONSTRAINT pk_exame PRIMARY KEY (id_exame),
    CONSTRAINT fk_exame_consulta FOREIGN KEY (id_consulta)
        REFERENCES Consulta(id_consulta),
    CONSTRAINT fk_exame_tipo    FOREIGN KEY (id_tipo_exame)
        REFERENCES Tipo_Exame(id_tipo_exame)
);

CREATE TABLE Medicamento (
    id_medicamento INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    principio_ativo VARCHAR(100) NOT NULL,
    tarja ENUM('Livre', 'Amarela', 'Vermelha', 'Preta'),
	CONSTRAINT pk_medicamento PRIMARY KEY (id_medicamento)
);

CREATE TABLE Prescricao (
    id_prescricao INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia TEXT NOT NULL,
    duracao VARCHAR(50),
    CONSTRAINT pk_prescricao PRIMARY KEY (id_prescricao),
    CONSTRAINT fk_presc_consulta FOREIGN KEY (id_consulta)
        REFERENCES Consulta(id_consulta),
    CONSTRAINT fk_presc_medicamento FOREIGN KEY (id_medicamento)
        REFERENCES Medicamento(id_medicamento)
);

CREATE TABLE Paciente_Convenio (
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    numero_carteira VARCHAR(50) NOT NULL,
    validade DATE,
    titular VARCHAR(100) NOT NULL,
     CONSTRAINT pk_paciente_convenio PRIMARY KEY (id_paciente, id_convenio, numero_carteira),
    CONSTRAINT fk_pc_paciente FOREIGN KEY (id_paciente)
        REFERENCES Paciente(id_paciente),
    CONSTRAINT fk_pc_convenio FOREIGN KEY (id_convenio)
        REFERENCES Convenio(id_convenio)
);