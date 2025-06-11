USE nota_fiscal_normalizada;

SELECT * FROM produto;

DELIMITER $$
CREATE TRIGGER promo_check
BEFORE UPDATE ON produto
FOR EACH ROW
BEGIN
	DECLARE nome VARCHAR(256);
    SELECT descricao_produto
    INTO nome
    FROM produto
    -- NEW da acesso ao novo conjunto de dados
    WHERE codigo_produto = NEW.codigo_produto;
    
    IF NEW.valor_produto < 100 THEN
		SET NEW.descricao_produto = CONCAT('Promoção',' ',nome);
	ELSEIF NEW.valor_produto >= 100 AND NEW.valor_produto <=200 THEN
		SET NEW.descricao_produto = CONCAT('Oferta',' ',nome);
	END IF;
END$$

DELIMITER ;
DROP TRIGGER promo_check;

UPDATE produto
SET valor_produto = 85
WHERE codigo_produto in (1,2);
 

    