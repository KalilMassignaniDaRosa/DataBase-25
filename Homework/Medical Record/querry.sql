USE consultorio_medico;

-- Consultas com médico especifico
SELECT 
    c.numero_consulta AS 'Código Consulta',
    p.nome AS Paciente,
    c.data_hora AS 'Data/Hora',
    c.status AS Status,
    esp.nome AS Especialidade
FROM Consulta c
INNER JOIN Medico m ON c.id_medico = m.id_medico
INNER JOIN Paciente p ON c.id_paciente = p.id_paciente
INNER JOIN Medico_Especialidade me ON m.id_medico = me.id_medico
INNER JOIN Especialidade esp ON me.id_especialidade = esp.id_especialidade
WHERE m.nome = 'Dr. João Silva'
  AND c.data_hora >= CURDATE()
ORDER BY c.data_hora;

-- Historico de paciente
SELECT 
    p.nome AS Paciente,
    te.nome AS 'Exame Solicitado',
    e.data_realizacao AS 'Data Realização',
    e.status AS Status,
    te.valor_referencia AS Valor
FROM Exame e
INNER JOIN Consulta c ON e.id_consulta = c.id_consulta
INNER JOIN Paciente p ON c.id_paciente = p.id_paciente
INNER JOIN Tipo_Exame te ON e.id_tipo_exame = te.id_tipo_exame
WHERE p.nome = 'Ana Pereira'
ORDER BY e.data_realizacao DESC;

-- Pacientes com convenio vencido
SELECT 
    p.nome AS Paciente,
    c.nome AS Convênio,
    pc.numero_carteira AS 'Nº Carteira',
    pc.validade AS Validade,
    DATEDIFF(pc.validade, CURDATE()) AS 'Dias Restantes'
FROM Paciente_Convenio pc
INNER JOIN Paciente p ON pc.id_paciente = p.id_paciente
INNER JOIN Convenio c ON pc.id_convenio = c.id_convenio
WHERE pc.validade < CURDATE()
   OR DATEDIFF(pc.validade, CURDATE()) <= 30;
   
-- Prescrições da consulta
SELECT 
    c.numero_consulta AS 'Código Consulta',
    p.nome AS Paciente,
    m.nome AS Medicamento,
    pr.posologia AS Posologia,
    pr.duracao AS Duração,
    m.tarja AS Tarja
FROM Prescricao pr
INNER JOIN Consulta c ON pr.id_consulta = c.id_consulta
INNER JOIN Paciente p ON c.id_paciente = p.id_paciente
INNER JOIN Medicamento m ON pr.id_medicamento = m.id_medicamento
WHERE c.numero_consulta = 'CONS002';

-- Relatório financeiro
SELECT 
    conv.nome AS Convênio,
    COUNT(c.id_consulta) AS 'Total Consultas',
    FORMAT(SUM(c.valor), 2) AS 'Valor Total',
    FORMAT(AVG(c.valor), 2) AS 'Ticket Médio',
    MAX(c.valor) AS 'Maior Valor',
    MIN(c.valor) AS 'Menor Valor'
FROM Consulta c
JOIN Convenio conv ON c.id_convenio = conv.id_convenio
WHERE c.status = 'Realizada'  
  AND YEAR(c.data_hora) = YEAR(CURDATE())  
GROUP BY conv.nome
ORDER BY SUM(c.valor) DESC;