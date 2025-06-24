create database ecommerce;

create table fornecedor (
	id_fornecedor serial not null,
	nome varchar(100) not null,
	cnpj char(15) not null,
	constraint pk_fornecedor primary key (id_fornecedor)
);

create table produto (
	id_produto serial not null,
	id_fornecedor integer not null,
	valor_custo decimal(18,2) not null default 0,
	constraint pk_produto primary key (id_produto),
	constraint fk_fornecedor_produto foreign key (id_fornecedor) references fornecedor (id_fornecedor)
);

create table estoque (
	id_estoque serial not null,
	local varchar(100) not null,
	constraint pk_estoque primary key (id_estoque)
);

create table estoque_produto (
	id_produto integer not null,
	id_estoque integer not null,
	quantidade decimal(18,4) not null default 0,
	constraint pk_estoque_produto primary key (id_produto, id_estoque),
	constraint fk_estoque_produto_produto foreign key (id_produto) references produto (id_produto),
	constraint fk_estoque_produto_estoque foreign key (id_estoque) references estoque (id_estoque)
);

create type tp_tipo_pessoa as enum ('fisica', 'juridica');
create table cliente (
	id_cliente serial not null, 
	nome varchar(100) not null,
	tipo_pessoa tp_tipo_pessoa not null,
	senha varchar(100) not null,
	login varchar(100) not null,
	constraint pk_cliente primary key (id_cliente)
);

create table cliente_juridica (
	id_cliente integer not null,
	telefone varchar(100) not null,
	nome_contato varchar(100) not null,
	email_contato varchar(100) not null,
	cnpj char(15) not null,
	constraint pk_cliente_juridica primary key (id_cliente),
	constraint pk_cliente_juridica_cliente foreign key (id_cliente) references cliente(id_cliente)
);

create table cliente_fisica ( 
	id_cliente integer not null, 
	email varchar(100) not null,
	celular varchar(100) not null,
	cpf char(12) not null,
	constraint pk_cliente_fisica primary key (id_cliente),
	constraint pk_cliente_fisica_cliente foreign key (id_cliente) references cliente (id_cliente)
);

create table cliente_endereco ( 
	id_cliente_endereco serial not null,
	id_cliente integer not null,
	cidade varchar(100) not null,
	estado char(2) not null,
	logradouro varchar(100) not null,
	complemento varchar(100),
	bairro varchar(100) not null,
	cep varchar(10) not null,
	constraint pk_cliente_endereco primary key (id_cliente_endereco),
	constraint fk_cliente_endereco_cliente foreign key (id_cliente) references cliente (id_cliente)
);

create type tp_tipo_cartao as enum ('credito', 'debito');
create table cliente_cartao (
	id_cliente_cartao serial not null,
	id_cliente integer not null,
	numero varchar(45) not null,
	nome varchar(100) not null,
	validade date not null,
	tipo tp_tipo_cartao not null,
	ativo bool not null default true,
	constraint pk_cliente_cartao primary key (id_cliente_cartao),
	constraint fk_cliente_cartao_cliente foreign key (id_cliente) references cliente (id_cliente)
);

create table vendedor (
	id_vendedor serial not null,
	nome varchar(100) not null,
	constraint pk_vendedor primary key (id_vendedor)
);

create table produto_vendedor (
	id_produto integer not null,
	id_vendedor integer not null,
	preco decimal(18,2) not null,
	constraint pk_produto_vendedor primary key (id_produto, id_vendedor),
	constraint fk_produto_vendedor_produto foreign key (id_produto) references produto (id_produto),
	constraint fk_produto_vendedor_vendedor foreign key (id_vendedor) references vendedor (id_vendedor)
);

create table pedido (
	id_pedido serial not null,
	id_cliente integer not null,
	id_vendedor integer not null,
	data date not null,
	id_cliente_endereco integer not null,
	prazo_entrega date not null,
	prazo_devolucao date not null,
	constraint pk_pedido primary key (id_pedido),
	constraint fk_pedido_cliente foreign key (id_cliente) references cliente (id_cliente),
	constraint fk_pedido_vendedor foreign key (id_vendedor) references vendedor (id_vendedor),
	constraint fk_pedido_cliente_endereco foreign key (id_cliente_endereco) references cliente_endereco (id_cliente_endereco)
);

create type tp_forma_pagamento as enum ('Dinheiro','Cartao','Pix');
create table pedido_pagamento (
	id_pedido_pagamento serial not null,
	id_pedido integer not null,
	forma_pagamento tp_forma_pagamento not null,
	valor decimal(18,2) not null,
	id_cliente_cartao integer,
	constraint pk_pedido_pagamento primary key (id_pedido_pagamento),
	constraint fk_pedido_pagamento_pedido foreign key (id_pedido) references pedido (id_pedido),
	constraint fk_pedido_pagamento_cliente_cartao foreign key (id_cliente_cartao) references cliente_cartao (id_cliente_cartao)
);

create type tp_pedido_situacao as enum ('Pendente','Em Separacao','Em Transito','Entregue','Cancelado');
create table pedido_situacao (
	id_pedido_situacao serial not null,
	id_pedido integer not null,
	data timestamp not null,
	situacao tp_pedido_situacao not null,
	constraint pk_pedido_situacao primary key (id_pedido_situacao),
	constraint fk_pedido_situacao_pedido foreign key (id_pedido) references pedido (id_pedido)
);

create table pedido_entrega (
	id_pedido_entrega serial not null,
	id_pedido integer not null,
	local_origem varchar(100) not null,
	local_destino varchar(100) not null,
	data_saida timestamp not null,
	data_chegada timestamp,
	observacao text,
	constraint pk_pedido_entrega primary key (id_pedido_entrega),
	constraint fk_pedido_entrega_pedido foreign key (id_pedido) references pedido (id_pedido)
);