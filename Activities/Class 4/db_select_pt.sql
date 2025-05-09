USE nota_fiscal_normalizada;

-- Forma classica de consultas combinadas
SELECT nota_fiscal.*, item_nota_fiscal.* 
FROM nota_fiscal, item_nota_fiscal
WHERE nota_fiscal.numero_nota = item_nota_fiscal.numero_nota;

-- Podemos definir ALIAS (apelidos) para as tabelas e facilitar a codigicacao
SELECT nf.numero_nota, nf.data_emissao, nf.valor_total, 
       inf.codigo_produto, inf.quantidade, inf.valor_unitario, inf.valor_total, 
       p.descricao_produto, p.unidade_medida
FROM 
    nota_fiscal AS nf, 
    item_nota_fiscal AS inf,
    produto AS p
WHERE 
    nf.numero_nota = inf.numero_nota
    AND inf.codigo_produto = p.codigo_produto
ORDER BY 
    nf.numero_nota DESC, inf.codigo_produto ASC;

-- INNER JOIN 
-- where sumiu
SELECT nf.numero_nota, nf.data_emissao, nf.valor_total, 
       inf.codigo_produto, inf.quantidade, inf.valor_unitario, inf.valor_total, 
       p.descricao_produto, p.unidade_medida
FROM 
    nota_fiscal AS nf
    INNER JOIN item_nota_fiscal AS inf ON nf.numero_nota = inf.numero_nota
    INNER JOIN produto AS p ON inf.codigo_produto = p.codigo_produto
WHERE nf.numero_nota = 4
ORDER BY 
    nf.numero_nota DESC, inf.codigo_produto ASC;
    
-- Funcoes de agregacao
-- Contando e quantificando registros

-- Quantas notas fiscais tem emitidas?
SELECT COUNT(*) 
FROM nota_fiscal;

-- Notas fiscais por periodo
SELECT COUNT(*)
FROM nota_fiscal
WHERE data_emissao > '2025-03-21' AND data_emissao < '2025-03-25';

-- Usando BETWEEN (menor AND maior)
SELECT COUNT(*)
FROM nota_fiscal
WHERE data_emissao BETWEEN '2025-03-21' AND '2025-03-25';

-- Total de notas do ano
SELECT COUNT(*)
FROM nota_fiscal
WHERE YEAR(data_emissao) = 2025;

-- MAX( ) -> Obtendo o cliente que mais comprou determinado produto em uma unica nota fiscal
SELECT 
    nf.nome_cliente AS cliente, 
    p.descricao_produto AS produto,
    MAX(inf.quantidade) AS quantidade
FROM item_nota_fiscal AS inf
INNER JOIN nota_fiscal AS nf ON inf.numero_nota = nf.numero_nota
INNER JOIN produto AS p ON inf.codigo_produto = p.codigo_produto
-- WHERE inf.codigo_produto = 2
GROUP BY nf.nome_cliente, p.descricao_produto
ORDER BY cliente, quantidade DESC;