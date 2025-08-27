create database db_revenda_miguel;
use db_revenda_miguel;

create table clientes (
    id_cliente int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    telefone varchar(15),
    data_cadastro date default current_date
);

create table produtos (
    id_produto int auto_increment primary key,
    nome varchar(100) not null,
    categoria varchar(50) not null,
    preco decimal(10,2) check (preco > 0),
    estoque int default 0 check (estoque >= 0)
);

create table fornecedores (
    id_fornecedor int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    telefone varchar(15),
    cnpj char(14) unique not null
);

create table pedidos (
    id_pedido int auto_increment primary key,
    id_cliente int not null,
    data_pedido date default current_date,
    status enum('pendente', 'enviado', 'cancelado') default 'pendente',
    valor_total decimal(10,2) default 0 check (valor_total >= 0),
    foreign key (id_cliente) references clientes(id_cliente)
);

create table produtos_pedidos (
    id_pedido int,
    id_produto int,
    quantidade int default 1 check (quantidade > 0),
    preco_unitario decimal(10,2) not null check (preco_unitario >= 0),
    primary key (id_pedido, id_produto),
    foreign key (id_pedido) references pedidos(id_pedido),
    foreign key (id_produto) references produtos(id_produto)
);

create table produtos_fornecedores (
    id_produto int,
    id_fornecedor int,
    primary key (id_produto, id_fornecedor),
    foreign key (id_produto) references produtos(id_produto),
    foreign key (id_fornecedor) references fornecedores(id_fornecedor)
);

create view view_detalhes_pedidos as
select 
    p.id_pedido,
    c.nome as cliente,
    p.data_pedido,
    p.status,
    p.valor_total
from pedidos p
join clientes c on p.id_cliente = c.id_cliente;

create view view_itens_pedido as
select 
    pp.id_pedido,
    pr.nome as produto,
    pp.quantidade,
    pp.preco_unitario,
    (pp.quantidade * pp.preco_unitario) as subtotal
from produtos_pedidos pp
join produtos pr on pp.id_produto = pr.id_produto;

insert into clientes (nome, email, telefone) values
('joão silva', 'joao@email.com', '11999999999'),
('ana costa', 'ana@email.com', '11888888888'),
('lucas pereira', 'lucas@email.com', '11777777777'),
('marina rocha', 'marina@email.com', '11666666666'),
('bruno lima', 'bruno@email.com', '11555555555'),
('carla mendes', 'carla@email.com', '11444444444'),
('tiago souza', 'tiago@email.com', '11333333333'),
('juliana alves', 'juliana@email.com', '11222222222'),
('paulo gomes', 'paulo@email.com', '11111111111'),
('isabela duarte', 'isabela@email.com', '11000000000');

insert into produtos (nome, categoria, preco, estoque) values
('barraca 2 pessoas', 'camping', 350.00, 15),
('lanterna led', 'iluminação', 50.00, 40),
('mochila 50l', 'cargueira', 280.00, 10),
('saco de dormir', 'dormida', 180.00, 20),
('fogareiro portátil', 'cozinha', 120.00, 12),
('garrafa térmica 1l', 'acessórios', 90.00, 25),
('cadeira dobrável', 'camping', 110.00, 18),
('isolante térmico', 'dormida', 70.00, 30),
('bússola profissional', 'navegação', 45.00, 15),
('faca tática', 'acessórios', 60.00, 22);

insert into fornecedores (nome, email, telefone, cnpj) values
('campbrasil', 'contato@campbrasil.com', '1130303030', '12345678000100'),
('trilha forte', 'vendas@trilhaforte.com', '1140404040', '23456789000111'),
('aventura sul', 'sac@aventurasul.com', '1150505050', '34567890000122'),
('expedição norte', 'norte@expedicao.com', '1160606060', '45678900000133'),
('ecomontanha', 'eco@montanha.com', '1170707070', '56789000000144'),
('equipcamping', 'equip@camping.com', '1180808080', '67890000000155'),
('vida outdoor', 'outdoor@vida.com', '1190909090', '78900000000166'),
('resistência gear', 'resist@gear.com', '1111111111', '89000000000177'),
('maxcamp', 'max@camp.com', '1122222222', '90000000000188'),
('trilha livre', 'livre@trilha.com', '1133333333', '00000000000199');

insert into pedidos (id_cliente, status, valor_total) values
(1, 'pendente', 530.00),
(2, 'enviado', 120.00),
(3, 'cancelado', 280.00),
(4, 'enviado', 350.00),
(5, 'pendente', 240.00),
(6, 'enviado', 180.00),
(7, 'pendente', 300.00),
(8, 'enviado', 400.00),
(9, 'pendente', 90.00),
(10, 'cancelado', 110.00);

insert into produtos_pedidos (id_pedido, id_produto, quantidade, preco_unitario) values
(1, 1, 1, 350.00),
(1, 2, 2, 90.00),
(2, 5, 1, 120.00),
(3, 3, 1, 280.00),
(4, 1, 1, 350.00),
(5, 4, 2, 120.00),
(6, 4, 1, 180.00),
(7, 10, 5, 60.00),
(8, 3, 1, 280.00),
(8, 6, 2, 60.00);

insert into produtos_fornecedores (id_produto, id_fornecedor) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

select * from view_detalhes_pedidos;
select * from view_itens_pedido;
