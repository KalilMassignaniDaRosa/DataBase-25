CREATE DATABASE Views;
USE Views;

-- Criando View personalizada
-- Faz duas colunas
SELECT 'Segunda-Feira', 'Terça-Feira';

-- Faz duas linhas
SELECT 'Segunda-Feira'
UNION
SELECT 'Terça-Feira';

-- Criando view
CREATE OR REPLACE VIEW DaysOfWeek AS
SELECT 'Segunda-Feira'
UNION
SELECT 'Terça-Feira'
UNION
SELECT 'Quarta-Feira'
UNION
SELECT 'Quinta-Feira'
UNION
SELECT 'Sexta-Feira'
UNION
SELECT 'Sábado'
UNION
SELECT 'Domingo';

SELECT * FROM DaysOfWeek;

DROP VIEW DaysOfWeek;

-- Trazendo todos os dias da semana sem view
SELECT 'Segunda-Feira'
UNION
SELECT 'Terça-Feira'
UNION
SELECT 'Quarta-Feira'
UNION
SELECT 'Quinta-Feira'
UNION
SELECT 'Sexta-Feira'
UNION
SELECT 'Sábado'
UNION
SELECT 'Domingo';

