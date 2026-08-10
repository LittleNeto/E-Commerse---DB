create table `cliente` (
    `id_cliente` integer not null auto_increment,
    `nome_cliente` varchar(150) not null,
    `cpf` char(11) not null unique,
    `data_nascimento` date not null,
    `sexo` char(1),
    `telefone` varchar(20) not null,
    `email` varchar(120) not null unique,
    `senha` varchar(255) not null,
    `data_cadastro` datetime not null default current_timestamp,
    `status_conta` char(1) not null default 'A',
    `foto_perfil` varchar(255),
    `preferencias_compra` text,
    primary key(`id_cliente`),
    constraint `chk_cliente_status_conta` check (`status_conta` in ('A', 'I', 'B'))
);

create table `endereco` (
    `id_endereco` integer not null auto_increment,
    `id_cliente` integer not null,
    `tipo` varchar(30) not null,
    `logradouro` varchar(150) not null,
    `numero` varchar(10) not null,
    `complemento` varchar(50),
    `bairro` varchar(50) not null,
    `cidade` varchar(100) not null,
    `estado` char(2) not null,
    `cep` char(8) not null,
    `pais` varchar(60) not null default 'Brasil',
    `ponto_ref` varchar(150),
    `endereco_principal` boolean not null default false,
    primary key(`id_endereco`),
    constraint `fk_endereco_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`)
);

create table `categoria` (
    `id_categoria` integer not null auto_increment,
    `nome_categoria` varchar(80) not null unique,
    `descricao` text,
    `categoria_pai` integer,
    `status_categoria` char(1) not null default 'A',
    `imagem_representativa` varchar(255),
    primary key(`id_categoria`),
    constraint `fk_categoria_categoria_pai` foreign key (`categoria_pai`) references `categoria` (`id_categoria`),
    constraint `chk_categoria_status` check (`status_categoria` in ('A', 'I'))
);

create table `produto` (
    `id_produto` integer not null auto_increment,
    `id_categoria` integer not null,
    `nome_produto` varchar(150) not null,
    `marca` varchar(50) not null,
    `fabricante` varchar(100) not null,
    `peso` decimal(8,3),
    `descricao_curta` varchar(255),
    `descricao_longa` text,
    `dimensoes` varchar(50),
    `cadastro` datetime not null default current_timestamp,
    `status_produto` char(1) not null default 'A',
    `avaliacao_media` decimal(3,2) default 0.00,
    `numero_visualizacoes` integer not null default 0,
    `garantia` varchar(50),
    primary key(`id_produto`),
    constraint `fk_produto_categoria` foreign key (`id_categoria`) references `categoria` (`id_categoria`),
    constraint `chk_produto_status` check (`status_produto` in ('A', 'I')),
    constraint `chk_produto_avaliacao_media` check (`avaliacao_media` between 0.00 and 5.00)
);

create table `item` (
    `id_item` integer not null auto_increment,
    `id_produto` integer not null,
    `sku` varchar(50) not null unique,
    `nome_item` varchar(150) not null,
    `marca` varchar(50),
    `cor` varchar(30),
    `tamanho` varchar(20),
    `descricao` text,
    `modelo` varchar(50),
    `codigo_barra` varchar(50) unique,
    `preco` decimal(15,2) not null,
    `desconto` decimal(15,2) not null default 0.00,
    `quantidade_restante` integer not null default 0,
    `estoque_minimo` integer not null default 5,
    `peso` decimal(8,3),
    `imagem` varchar(255),
    `status_item` char(1) not null default 'A',
    primary key(`id_item`),
    constraint `fk_item_produto` foreign key (`id_produto`) references `produto` (`id_produto`),
    constraint `chk_item_status` check (`status_item` in ('A', 'I', 'E')),
    constraint `chk_item_preco` check (`preco` > 0.00),
    constraint `chk_item_quantidade_restante` check (`quantidade_restante` >= 0)
);

create table `carrinho_de_compras` (
    `id_carrinho` integer not null auto_increment,
    `id_cliente` integer not null unique,
    `data_criacao` datetime not null default current_timestamp,
    `ultima_atualizacao` datetime not null default current_timestamp,
    `situacao_carrinho` varchar(20) not null default 'Aberto',
    `valor_total` decimal(15,2) not null default 0.00,
    `quantidade_itens` integer not null default 0,
    primary key(`id_carrinho`),
    constraint `fk_carrinho_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`)
);

create table `item_carrinho` (
    `id_item_carrinho` integer not null auto_increment,
    `id_carrinho` integer not null,
    `id_produto` integer not null,
    `quantidade_item` integer not null default 1,
    `preco_item` decimal(15,2) not null,
    `desconto` decimal(15,2) not null default 0.00,
    `subtotal` decimal(15,2) not null,
    `data_adicao` datetime not null default current_timestamp,
    primary key(`id_item_carrinho`),
    constraint `fk_item_carrinho_carrinho` foreign key (`id_carrinho`) references `carrinho_de_compras` (`id_carrinho`),
    constraint `fk_item_carrinho_produto` foreign key (`id_produto`) references `produto` (`id_produto`),
    constraint `chk_item_carrinho_quantidade` check (`quantidade_item` > 0)
);

create table `pedido` (
    `id_pedido` integer not null auto_increment,
    `id_cliente` integer not null,
    `id_endereco_entrega` integer not null,
    `data_pedido` datetime not null default current_timestamp,
    `status_pedido` varchar(30) not null default 'Processando',
    `valor_total` decimal(15,2) not null,
    `valor_frete` decimal(15,2) not null default 0.00,
    `valor_final` decimal(15,2) not null,
    `desconto_aplicado` decimal(15,2) not null default 0.00,
    `prazo_estimado` varchar(50),
    primary key(`id_pedido`),
    constraint `fk_pedido_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`),
    constraint `fk_pedido_endereco` foreign key (`id_endereco_entrega`) references `endereco` (`id_endereco`),
    constraint `chk_pedido_status` check (`status_pedido` in ('Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado')),
    constraint `chk_pedido_valor_final` check (`valor_final` = (`valor_total` + `valor_frete`) - `desconto_aplicado`)
);

create table `item_pedido` (
    `id_item_pedido` integer not null auto_increment,
    `id_pedido` integer not null,
    `id_item` integer not null,
    `quantidade` integer not null,
    `preco_unitario` decimal(15,2) not null,
    `subtotal` decimal(15,2) not null,
    `desconto` decimal(15,2) not null default 0.00,
    primary key(`id_item_pedido`),
    constraint `fk_item_pedido_pedido` foreign key (`id_pedido`) references `pedido` (`id_pedido`),
    constraint `fk_item_pedido_item` foreign key (`id_item`) references `item` (`id_item`),
    constraint `chk_item_pedido_quantidade` check (`quantidade` > 0)
);

create table `observacoes_cliente` (
    `id_observacao` integer not null auto_increment,
    `id_pedido` integer not null,
    `observacao_cliente` text not null,
    primary key(`id_observacao`),
    constraint `fk_observacoes_cliente_pedido` foreign key (`id_pedido`) references `pedido` (`id_pedido`)
);

create table `pagamento` (
    `id_pagamento` integer not null auto_increment,
    `id_pedido` integer not null,
    `forma_pagamento` varchar(50) not null,
    `valor` decimal(15,2) not null,
    `data_pagamento` datetime,
    `status` varchar(30) not null default 'Pendente',
    `num_transacoes` integer not null default 1,
    `quantidade_parcelas` integer not null default 1,
    `bandeira_cartao` varchar(30),
    `comprovante` varchar(255),
    primary key(`id_pagamento`),
    constraint `fk_pagamento_pedido` foreign key (`id_pedido`) references `pedido` (`id_pedido`),
    constraint `chk_pagamento_forma` check (`forma_pagamento` in ('Cartao_Credito', 'Boleto', 'Pix')),
    constraint `chk_pagamento_status` check (`status` in ('Pendente', 'Aprovado', 'Recusado', 'Estornado')),
    constraint `chk_pagamento_parcelas` check (`quantidade_parcelas` >= 1)
);

create table `observacoes_financeiras` (
    `id_observacao_financeira` integer not null auto_increment,
    `id_pagamento` integer not null,
    `observacao` text not null,
    primary key(`id_observacao_financeira`),
    constraint `fk_observacoes_financeiras_pagamento` foreign key (`id_pagamento`) references `pagamento` (`id_pagamento`)
);

create table `entrega` (
    `id_entrega` integer not null auto_increment,
    `id_pedido` integer not null,
    `transportadora` varchar(100) not null,
    `cod_rastreio` varchar(50) unique,
    `data_envio` datetime,
    `data_prevista` datetime not null,
    `data_entrega` datetime,
    `status_entrega` varchar(30) not null default 'Pendente',
    `entregador` varchar(100),
    `custo_frete` decimal(15,2) not null default 0.00,
    `historico` text,
    primary key(`id_entrega`),
    constraint `fk_entrega_pedido` foreign key (`id_pedido`) references `pedido` (`id_pedido`),
    constraint `chk_entrega_status` check (`status_entrega` in ('Pendente', 'Em Transito', 'Entregue', 'Extraviado'))
);

create table `avaliacao` (
    `id_avaliacao` integer not null auto_increment,
    `id_cliente` integer not null,
    `id_produto` integer not null,
    `nota` integer not null,
    `comentario` text,
    `data_avaliacao` datetime not null default current_timestamp,
    `status_avaliacao` varchar(30) not null default 'Pendente',
    primary key(`id_avaliacao`),
    constraint `fk_avaliacao_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`),
    constraint `fk_avaliacao_produto` foreign key (`id_produto`) references `produto` (`id_produto`),
    constraint `chk_avaliacao_nota` check (`nota` between 1 and 5),
    constraint `chk_avaliacao_status` check (`status_avaliacao` in ('Pendente', 'Aprovado', 'Reprovado'))
);

create table `registro_interacao` (
    `id_interacao` integer not null auto_increment,
    `id_cliente` integer,
    `id_produto` integer not null,
    `data_visualizacao` date not null default (current_date),
    `horario_visualizacao` time not null default (current_time),
    `tempo_interacao` integer not null default 0,
    `adicionado_favorito` boolean not null default false,
    `adicionado_carrinho` boolean not null default false,
    `quantidade_visualizacoes` integer not null default 1,
    `dispositivo_utilizado` varchar(50) not null,
    primary key(`id_interacao`),
    constraint `fk_registro_interacao_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`),
    constraint `fk_registro_interacao_produto` foreign key (`id_produto`) references `produto` (`id_produto`)
);

create table `historico_cliente` (
    `id_compra` integer not null auto_increment,
    `id_cliente` integer not null,
    `id_pedido` integer not null,
    `id_pagamento` integer,
    `id_entrega` integer,
    primary key(`id_compra`),
    constraint `fk_historico_cliente_cliente` foreign key (`id_cliente`) references `cliente` (`id_cliente`),
    constraint `fk_historico_cliente_pedido` foreign key (`id_pedido`) references `pedido` (`id_pedido`),
    constraint `fk_historico_cliente_pagamento` foreign key (`id_pagamento`) references `pagamento` (`id_pagamento`),
    constraint `fk_historico_cliente_entrega` foreign key (`id_entrega`) references `entrega` (`id_entrega`)
);