USE dados_cadastrais;

-- Inserção de Pessoas
INSERT INTO Pessoa (nome, sobrenome, rg, cpf, data_nascimento, nacionalidade, sexo, estado_civil, tipo) VALUES
-- Titulares
('João','Silva','MG1234567','12345678901','1980-05-15','Brasileira','M','Casado','Titular'),
('Maria','Oliveira','SP7654321','98765432109','1985-09-30','Brasileira','F','Solteiro','Titular'),
('Pedro','Souza','RJ1122334','11122233344','1975-12-10','Brasileira','M','Divorciado','Titular'),
-- Dependentes
('Ana','Silva','MG9988776','22233344455','2010-03-20','Brasileira','F','Solteiro','Dependente'),
('Lucas','Silva','MG5544332','33344455566','2012-07-08','Brasileira','M','Solteiro','Dependente'),
('Carlos','Oliveira','SP1122334','44455566677','2015-10-25','Brasileira','M','Solteiro','Dependente');

-- Inserção de Endereços
INSERT INTO Endereco (rua, numero, complemento, bairro, cidade, estado, cep) VALUES
('Av. Paulista','1234','Apto 101','Bela Vista','São Paulo','SP', '01310100'),
('Rua das Flores','567',NULL,'Centro','Campinas','SP','13010200'),
('Av. Brasil','890',NULL,'Centro','Rio de Janeiro','RJ','20010000'),
('Rua dos Pinheiros', '321','Casa 2','Pinheiros','São Paulo','SP','05422000');

-- Inserção de Cargos
INSERT INTO Cargo (nome, descricao, nivel) VALUES
('Analista','Analista de Sistemas','Pleno'),
('Gerente','Gerente de Departamento','Sênior'),
('Assistente','Assistente Administrativo','Júnior'),
('Supervisor','Supervisor de Equipe','Pleno'),
('Estagiário','Estagiário','Júnior');

-- Inserção de Departamentos
INSERT INTO Departamento (nome, sigla) VALUES
('Financeiro','FIN'),
('Recursos Humanos','RH'),
('Tecnologia da Informação','TI'),
('Logística','LOG'),
('Operações','OP');

-- Inserção de Cadastros (Matrículas)
INSERT INTO Cadastro (pessoa_id, matricula, data_admissao) VALUES
(1, 'MATR001', '2005-01-10'),  -- João  
(2, 'MATR002', '2010-05-22'),  -- Maria 
(3, 'MATR003', '2000-09-15');  -- Pedro

-- Inserção de Cargos Ocupados
INSERT INTO Cargos_Ocupados (cadastro_id, cargo_id, data_inicio, data_fim) VALUES
-- João
(1, 1, '2005-01-10', '2010-12-31'),
(1, 2, '2011-01-01', NULL),
-- Maria
(2, 3, '2010-05-22', '2015-08-15'),
(2, 4, '2015-08-16', NULL),
-- Pedro 
(3, 5, '2000-09-15', '2002-12-31');

-- Inserção de Lotações
INSERT INTO Lotacao (cadastro_id, departamento_id, data_inicio, data_fim) VALUES
-- João
(1, 3, '2014-03-01', NULL),
-- Maria
(2, 5, '2012-12-01', NULL),
-- Pedro
(3, 1, '2000-09-15', '2003-06-30');

-- Relacionamento Pessoa-Endereço
INSERT INTO Pessoa_Endereco (pessoa_id, endereco_id, endereco_atual, tipo_endereco) VALUES
-- João
(1, 1, TRUE,'Residencial'),
(1, 4, FALSE,'Comercial'),
-- Maria
(2, 2, TRUE,'Residencial'),
-- Pedro
(3, 3, TRUE,'Residencial'),
-- Ana (dependente)
(4, 1, TRUE,'Residencial'),
-- Lucas (dependente)
(5, 1, TRUE,'Residencial'),
-- Carlos (dependente)
(6, 2, TRUE,'Residencial'); 

--  Vinculando Dependentes
INSERT INTO Dependente (cadastro_id, pessoa_id, parentesco) VALUES
-- Ana 
(1, 4, 'Filha'),
-- Lucas
(1, 5, 'Filho'),
-- Carlos
(2, 6, 'Filho');