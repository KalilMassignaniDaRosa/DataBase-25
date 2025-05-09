USE normalized_invoice;

-- Forma classica de consultas combinadas
SELECT invoice.*, invoice_item.*  
FROM invoice, invoice_item  
WHERE invoice.invoice_number = invoice_item.invoice_number;

-- Podemos definir ALIAS (apelidos) para as tabelas e facilitar a codigicacao
SELECT inv.invoice_number, inv.issue_date, inv.total_value,
    itm.product_code, itm.quantity, itm.unit_price, itm.total_price,
    prod.product_description, prod.unit_of_measure
FROM 
    invoice AS inv, 
    invoice_item AS itm,
    product AS prod
WHERE 
    inv.invoice_number = itm.invoice_number
    AND itm.product_code = prod.product_code
ORDER BY 
	inv.invoice_number DESC, itm.product_code ASC;

-- INNER JOIN 
-- where sumiu
SELECT 
    inv.invoice_number, inv.issue_date, inv.total_value,
    itm.product_code, itm.quantity, itm.unit_price, itm.total_price,
    prod.product_description, prod.unit_of_measure
FROM 
    invoice AS inv
    INNER JOIN invoice_item AS itm ON inv.invoice_number = itm.invoice_number
    INNER JOIN product AS prod ON itm.product_code = prod.product_code
WHERE inv.invoice_number = 4
ORDER BY 
    inv.invoice_number DESC, itm.product_code ASC;
    
-- Funcoes de agregacao
-- Contando e quantificando registros

-- Quantas notas fiscais tem emitidas?
SELECT COUNT(*) 
FROM invoice;

-- Notas fiscais por periodo
SELECT COUNT(*)
FROM invoice
WHERE issue_date  > '2025-03-21' AND issue_date  < '2025-03-25';

-- Usando BETWEEN (menor AND maior)
SELECT COUNT(*)
FROM invoice
WHERE issue_date BETWEEN '2025-03-21' AND '2025-03-25';

-- Total de notas do ano
SELECT COUNT(*)
FROM invoice
WHERE YEAR(issue_date) = 2025;

-- MAX( ) -> Obtendo o cliente que mais comprou determinado produto em uma unica nota fiscal
SELECT COUNT(*)
FROM invoice
WHERE YEAR(issue_date) = 2025;

-- MAX( ) -> Obtendo o cliente que mais comprou determinado produto em uma unica nota fiscal
-- (Getting the customer who purchased the most of a specific product in a single invoice)
SELECT 
    inv.customer_name AS customer, 
    prod.product_description AS product,
    MAX(itm.quantity) AS quantity
FROM invoice_item AS itm
INNER JOIN invoice AS inv ON itm.invoice_number = inv.invoice_number
INNER JOIN product AS prod ON itm.product_code = prod.product_code
-- WHERE itm.product_code = 2
GROUP BY inv.customer_name, prod.product_description
ORDER BY customer, quantity DESC;