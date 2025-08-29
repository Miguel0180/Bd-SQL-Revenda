-- Consultar todos os clientes cujo nome começa com "jo"
SELECT * FROM clientes WHERE nome ILIKE 'jo%';

EXPLAIN SELECT * FROM clientes WHERE nome ILIKE 'jo%';

CREATE INDEX idx_clientes_nome ON clientes(nome);
EXPLAIN SELECT * FROM clientes WHERE nome ILIKE 'jo%';


-- Tente converter o campo telefone para int
ALTER TABLE clientes
ALTER COLUMN telefone TYPE INT USING telefone::int;


-- Alterar a coluna estoque para varchar
ALTER TABLE produtos
ALTER COLUMN estoque TYPE VARCHAR USING estoque::varchar;

-- Criar usuário com seu nome
CREATE USER seu_nome WITH PASSWORD 'sua_senha';

-- Dar permissões totais
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO seu_nome;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO seu_nome;

-- Criar usuário para colega com apenas SELECT em uma tabela
CREATE USER colega_nome WITH PASSWORD 'senha_segura';

-- Permitir apenas SELECT na tabela produtos
GRANT SELECT ON TABLE produtos TO colega_nome;

--------------------------------





-- INNER JOIN
SELECT c.nome, p.id_pedido
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente;

-- LEFT JOIN
SELECT c.nome, p.id_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente;

-- RIGHT JOIN
SELECT c.nome, p.id_pedido
FROM clientes c
RIGHT JOIN pedidos p ON c.id_cliente = p.id_cliente;




SELECT p.id_pedido, pp.id_produto
FROM pedidos p
INNER JOIN produtos_pedidos pp ON p.id_pedido = pp.id_pedido;

-- LEFT JOIN
-- RIGHT JOIN


SELECT pr.nome, f.nome
FROM produtos pr
INNER JOIN produtos_fornecedores pf ON pr.id_produto = pf.id_produto
INNER JOIN fornecedores f ON pf.id_fornecedor = f.id_fornecedor;

-- LEFT JOIN
-- RIGHT JOIN

-- Exemplo: definir telefone como NULL para alguns clientes
UPDATE clientes
SET telefone = NULL
WHERE id_cliente IN (2, 4, 6, 8);



