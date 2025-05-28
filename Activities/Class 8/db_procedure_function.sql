SELECT * FROM nota_fiscal_normalizada.nota_fiscal;

USE nota_fiscal_normalizada;

CREATE FUNCTION Hello(s CHAR(20))
	RETURNS CHAR(50) DETERMINISTIC
    -- Aqui so faz o concat
    RETURN CONCAT('Hello, ', s, '!');
    
SELECT Hello('Kalil');

SELECT * FROM produto;

SELECT Hello( DESC_PRODUTO ) as Hello
FROM produto
WHERE COD_PRODUTO = 3;

CALL GetAllProducts();

CALL GetProductById(1, @level);

SELECT @level;