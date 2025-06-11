USE nota_fiscal_normalizada;

-- Por possuir funções de agrupamente é necessário o Group By
CREATE OR REPLACE VIEW  SalesResume AS
SELECT 
	NF.nome_cliente AS Nome_Cliente, 
    COUNT(NF.numero_nota) AS Total_Notas,
    COUNT(INF.codigo_produto) AS Total_Itens,
    SUM(INF.quantidade) AS Qtd_Total,
    SUM(INF.valor_total) AS Valor_Total,
    MAX(P.valor_produto) AS Max_Val_Produto,
    MIN(P.valor_produto) AS Min_Val_Produto
FROM 
	nota_fiscal AS NF
    INNER JOIN item_nota_fiscal AS INF
		ON NF.numero_nota = INF.numero_nota
	INNER JOIN produto AS P
		ON INF.codigo_produto = P.codigo_produto
GROUP BY 
	NF.nome_cliente; 

SELECT * FROM SalesResume;

SELECT 
	nome_cliente, Total_Notas, Valor_Total
FROM
	SalesResume
WHERE
	Valor_Total > 500;
    
-- Versão sem Funções, e sem Group
SELECT 
	NF.nome_cliente AS Nome_Cliente, 
    NF.numero_nota AS Total_Notas,
    INF.codigo_produto AS Codigo_Produto,
    INF.quantidade AS Quantidade,
    INF.valor_total AS Valor_Total,
    P.valor_produto AS Valor_Produto
FROM 
	nota_fiscal AS NF
    INNER JOIN item_nota_fiscal AS INF
		ON NF.numero_nota = INF.numero_nota
	INNER JOIN produto AS P
		ON INF.codigo_produto = P.codigo_produto
ORDER BY NF.nome_cliente DESC;


    

