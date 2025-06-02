USE dados_cadastrais;

-- 1- Lista completa de pessoas
SELECT 
    p.pessoa_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS nome_completo,
    v.cpf_formatado,
    p.data_nascimento,
    TIMESTAMPDIFF(YEAR, p.data_nascimento, CURDATE()) AS idade,
    p.sexo,
    p.estado_civil,
    p.tipo
FROM Pessoa p
    JOIN vw_cpf_formatado AS v ON p.pessoa_id = v.pessoa_id
ORDER BY p.tipo DESC, p.nome;

-- 2- Titulares com dependentes
SELECT 
    t.pessoa_id AS titular_id,
    CONCAT(t.nome, ' ', t.sobrenome) AS titular,
    IFNULL(GetIdDependente(c_tit.cadastro_id), '') AS dependentes_ids,
    -- Retorna o primeiro valor NOT NULL
    COALESCE(
      GROUP_CONCAT(
        CONCAT(d.nome, ' ', d.sobrenome, ' (', dep.parentesco, ')')
        ORDER BY d.nome
        SEPARATOR ', '
      ),
      'Sem dependentes'
    ) AS dependentes_detalhados
FROM Pessoa t
    JOIN Cadastro AS c_tit ON t.pessoa_id = c_tit.pessoa_id
    LEFT JOIN Dependente AS dep ON dep.cadastro_id = c_tit.cadastro_id
    LEFT JOIN Pessoa AS d ON d.pessoa_id = dep.pessoa_id
WHERE t.tipo = 'Titular'
GROUP BY t.pessoa_id, c_tit.cadastro_id
ORDER BY t.nome;

-- 3- Colaboradores ativos
SELECT 
    CONCAT(p.nome, ' ', p.sobrenome) AS colaborador,
    c.nome AS cargo,
    d.nome AS departamento,
    ca.matricula,
    DATE_FORMAT(ca.data_admissao, '%d/%m/%Y') AS admissao
FROM Pessoa p
    JOIN Cadastro AS ca ON p.pessoa_id = ca.pessoa_id
    JOIN Cargos_Ocupados AS co ON co.cadastro_id = ca.cadastro_id 
		AND co.data_fim IS NULL
    JOIN Cargo AS c ON co.cargo_id = c.cargo_id
    JOIN Lotacao AS l ON l.cadastro_id = ca.cadastro_id 
		AND l.data_fim IS NULL
    JOIN Departamento AS d ON l.departamento_id = d.departamento_id
WHERE p.tipo = 'Titular'
ORDER BY d.nome, p.nome;

-- 4- Endereços cadastrados
SELECT 
    CONCAT(p.nome, ' ', p.sobrenome) AS pessoa,
    pe.tipo_endereco,
    CONCAT(
      e.rua, ', ', 
      e.numero, 
      IF(e.complemento IS NOT NULL, CONCAT(' - ', e.complemento), ''), 
      ', ', e.bairro
    ) AS endereco,
    CONCAT(e.cidade, '/', e.estado) AS cidade_uf,
    e.cep
FROM Pessoa p
  JOIN Pessoa_Endereco AS pe ON p.pessoa_id = pe.pessoa_id
    AND pe.endereco_atual = TRUE
  JOIN Endereco AS e ON pe.endereco_id = e.endereco_id
ORDER BY p.nome;

-- 5- Quantidade de colabores por departamento
SELECT 
    d.nome AS departamento,
    COUNT(DISTINCT ca.cadastro_id) AS total_colaboradores_ativos
FROM Departamento d
    JOIN Lotacao AS l ON d.departamento_id = l.departamento_id 
		AND l.data_fim IS NULL
    JOIN Cadastro AS ca ON l.cadastro_id = ca.cadastro_id
    JOIN Cargos_Ocupados AS co ON co.cadastro_id = ca.cadastro_id 
		AND co.data_fim IS NULL
GROUP BY d.departamento_id, d.nome
ORDER BY total_colaboradores_ativos DESC;