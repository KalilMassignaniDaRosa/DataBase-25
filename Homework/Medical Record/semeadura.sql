USE consultorio_medico;

-- Convênios
INSERT INTO Convenio (nome, registro_ans, telefone) VALUES
('Unimed', 'ANS123456', '(11) 4000-1234'),
('Amil',   'ANS654321', '(21) 3000-5678'),
('Bradesco Saúde', 'ANS111222', '(31) 9999-0000');

-- Especialidades
INSERT INTO Especialidade (nome, descricao) VALUES
('Cardiologia', 'Clínica de diagnóstico e tratamento de doenças do coração'),
('Dermatologia', 'Tratamento de pele, unhas e cabelos'),
('Pediatria', 'Cuidados médicos para crianças e adolescentes');

-- Médicos
INSERT INTO Medico (nome, crm, uf_crm, telefone, email) VALUES
('Dr. João Silva',  'CRM12345', 'SP', '(11) 91234-5678', 'joao.silva@clinica.com'),
('Dra. Maria Souza','CRM67890', 'RJ', '(21) 99876-5432', 'maria.souza@clinica.com'),
('Dr. Pedro Lima',  'CRM11223', 'MG', '(31) 98765-4321', 'pedro.lima@clinica.com');

-- Relacionamento Médico Especialdiade
INSERT INTO Medico_Especialidade (id_medico, id_especialidade, principal) VALUES
(1, 1, TRUE),
(2, 2, TRUE),  
(3, 3, TRUE), 
(1, 3, FALSE); 

-- Pacientes
INSERT INTO Paciente (
  numero_paciente, nome, data_nascimento, sexo, estado_civil,
  cpf, rg, telefone, id_convenio, email, endereco, cidade, uf
) VALUES
('PAC001', 'Ana Pereira', '1985-04-12', 'F', 'Casado', '123.456.789-00', 'MG-12.345.678', '(31) 91234-0000', 1,
 'ana.pereira@gmail.com', 'Rua A, 123', 'Belo Horizonte', 'MG'),
('PAC002', 'Carlos Oliveira', '1990-11-30', 'M', 'Solteiro', '987.654.321-00', 'SP-87.654.321', '(11) 99876-0000', 2,
 'carlos.oliveira@yahoo.com', 'Av. B, 456', 'São Paulo', 'SP'),
('PAC003', 'Bruna Santos', '2002-06-05', 'F', 'Solteiro', NULL, 'RJ-55.444.333', '(21) 97777-0000', 3,
 'bruna.santos@outlook.com', 'Trav. C, 789', 'Rio de Janeiro', 'RJ');

-- Relacionamento Paciente Convenio
INSERT INTO Paciente_Convenio (id_paciente, id_convenio, numero_carteira, validade, titular) VALUES
(1, 1, 'UNI-0001', '2025-12-31', 'Ana Pereira'),
(2, 2, 'AMI-1234', '2024-06-30', 'Carlos Oliveira'),
(3, 3, 'BRA-9876', '2025-03-31', 'Bruna Santos');

-- Consultas
INSERT INTO Consulta (
  numero_consulta, id_paciente, id_medico, id_convenio,
  data_hora, duracao, diagnostico, prescricao, status, valor
) VALUES
('CONS001', 1, 1, 1, '2025-06-15 09:00:00', 30, 'Hipertensão controlada', 'Ver Anotações', 'Agendada', 200.00),
('CONS002', 2, 2, 2, '2025-06-16 10:30:00', 30, 'Dermatite atópica', 'Creme X duas vezes ao dia', 'Agendada', 150.00),
('CONS003', 3, 3, 3, '2025-06-17 08:00:00', 30, 'Check-up pediátrico', 'Nada prescrito', 'Agendada', 100.00);

-- Tipos de Exame
INSERT INTO Tipo_Exame (nome, descricao, valor_referencia) VALUES
('Hemograma completo', 'Análise de hemácias, leucócitos e plaquetas', 50.00),
('Glicemia de jejum', 'Mede glicose no sangue em jejum', 30.00),
('Raio-X torácico', 'Imagem do tórax', 100.00);

-- Exames
INSERT INTO Exame (id_consulta, id_tipo_exame, data_realizacao, resultado, status) VALUES
(1, 1, '2025-06-15', 'Tudo dentro do normal', 'Entregue'),
(2, 2, '2025-06-16', 'Glicemia 95 mg/dL', 'Entregue'),
(3, 3, '2025-06-17', NULL, 'Solicitado');

-- Medicamentos
INSERT INTO Medicamento (nome, principio_ativo, tarja) VALUES
('Dipirona', 'Metamizol', 'Livre'),
('Amoxicilina', 'Amoxicilina', 'Amarela'),
('Ibuprofeno', 'Ibuprofeno', 'Vermelha');

-- Prescrições
INSERT INTO Prescricao (id_consulta, id_medicamento, posologia, duracao) VALUES
(1, 1, '1g a cada 6 horas se dor', '5 dias'),
(2, 2, '500mg a cada 8 horas', '7 dias'),
(3, 3, '200mg a cada 6 horas', '3 dias');

-- Updates
UPDATE Consulta SET 
  status = 'Realizada',
  data_hora = '2025-05-20 09:00:00'
WHERE numero_consulta = 'CONS001';


UPDATE Consulta SET 
  status = 'Realizada',
  data_hora = '2025-05-21 10:30:00'
WHERE numero_consulta = 'CONS002';
