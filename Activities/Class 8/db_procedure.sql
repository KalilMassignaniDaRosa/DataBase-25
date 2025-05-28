DELIMITER //
CREATE PROCEDURE `GetAllProducts` ()
BEGIN
	/* Declaracao de variaveis */
    DECLARE totalSale DEC(10,2) DEFAULT 0.0;
    DECLARE x, y, total, qtd INT DEFAULT 0;
    
    SET total = 10;
    /* carregando valroes de um select em uma variavel */
    SELECT COUNT(*)
    INTO qtd
    FROM produto;
    
    SELECT qtd;
    SELECT * FROM PRODUTO;
END//
DELIMITER ;

-- Com parametros
DELIMITER //
CREATE PROCEDURE `GetProductById`(
	IN pProductId INT,
    -- nao e um retorno, e um parametro do tipo out
    OUT pProductLevel VARCHAR(20)
)
BEGIN
	DECLARE PValue DECIMAL(10,2) DEFAULT 0;
    
    SELECT COUNT(*)
    INTO PValue
    FROM PRODUTO AS P
    WHERE P.COD_PRODUTO = pProductId;
    
    IF ( PValue >= 5 AND PValue <= 10) THEN
		SET pProductLevel = 'CRITICO';
	ELSEIF ( PValue > 10 AND PValue <= 20 ) THEN
		SET pProductLevel = 'PREOCUPANTE';
	ELSEIF (PValue > 20 ) THEN
		SET pProductLevel = 'TA SUAVE';
	ELSE
		SET pProductLevel = 'FUJA';
	END IF;
END//
DELIMITER ;