-- Criar BD
CREATE DATABASE greenhouse;

-- Definir BD como padrao/utilizavel
USE greenhouse;

/* Padronizacao DB
snake_case
tabelas no singular (ex: plant)
*/
-- Criar tabela/entidade 
CREATE TABLE plants(
	plant_name CHAR(30) NOT NULL, 
    sensor_value FLOAT DEFAULT NULL, 
    sensor_event TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- PK = primary key
    PRIMARY KEY pk_plants (plant_name)
);

-- Visualizar todas as ocorrências em PLANTS
-- Listar todos os registros de dados
SELECT * FROM plants;

-- Visualizar colunas especificas
SELECT plant_name, sensor_value, sensor_event FROM plants;

-- Inserir dados na tabela/entidade PLANTS
-- Para registros usar aspas simples
INSERT INTO plants (plant_name, sensor_value) VALUES ('Rose', 0.2319);

-- Inserir multiplos registro de uma vez
INSERT INTO plants (plant_name, sensor_value) VALUES 
('Cactus', 0.2411), 
('Sunflower', 0.3112), 
('Orchid', 0.4102), 
('Lily', 0.5566);

-- Consulta aplicando filtros
SELECT * FROM plants WHERE plant_name = 'Cactus';

-- Filtros compostos com operadores AND OR XOR etc
SELECT * FROM plants WHERE plant_name <> 'Tulip' AND sensor_value < 0.5566 AND sensor_value > 0.2411;
