-- =========================================================================
-- Script de Inserção de Dados - Sistema de E-commerce
-- Dados fictícios para fins de teste/demonstração do modelo relacional.
-- Ordem de inserção respeita as dependências de chave estrangeira definidas
-- em tabelas.sql.
-- =========================================================================

-- -------------------------------------------------------------------------
-- cliente
-- -------------------------------------------------------------------------
insert into `cliente`
    (`id_cliente`, `nome_cliente`, `cpf`, `data_nascimento`, `sexo`, `telefone`, `email`, `senha`, `data_cadastro`, `status_conta`, `foto_perfil`)
values
    (1, 'João Pedro Silva', '12345678901', '1990-05-14', 'M', '83988887777', 'joao.silva@email.com', '$2y$10$hashfake0000000000000000000000000000000000000000001', '2025-01-10 09:15:00', 'A', 'perfil/joao_silva.jpg'),
    (2, 'Maria Fernanda Costa', '23456789012', '1995-08-22', 'F', '83999996666', 'maria.costa@email.com', '$2y$10$hashfake0000000000000000000000000000000000000000002', '2025-02-03 14:40:00', 'A', 'perfil/maria_costa.jpg'),
    (3, 'Carlos Eduardo Souza', '34567890123', '1988-01-30', 'M', '83977775555', 'carlos.souza@email.com', '$2y$10$hashfake0000000000000000000000000000000000000000003', '2025-03-18 18:05:00', 'A', null),
    (4, 'Ana Beatriz Lima', '45678901234', '2000-11-09', 'F', '83966664444', 'ana.lima@email.com', '$2y$10$hashfake0000000000000000000000000000000000000000004', '2025-04-22 11:25:00', 'A', 'perfil/ana_lima.jpg'),
    (5, 'Pedro Henrique Alves', '56789012345', '1993-03-17', 'O', '83955553333', 'pedro.alves@email.com', '$2y$10$hashfake0000000000000000000000000000000000000000005', '2025-05-07 20:50:00', 'B', null);

-- -------------------------------------------------------------------------
-- preferencia_cliente
-- -------------------------------------------------------------------------
insert into `preferencia_cliente`
    (`id_preferencia`, `id_cliente`, `preferencia`)
values
    (1, 1, 'Eletrônicos'),
    (2, 1, 'Notebooks'),
    (3, 2, 'Moda Feminina'),
    (4, 3, 'Smartphones'),
    (5, 4, 'Decoração'),
    (6, 4, 'Promoções');

-- -------------------------------------------------------------------------
-- endereco
-- -------------------------------------------------------------------------
insert into `endereco`
    (`id_endereco`, `id_cliente`, `tipo`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `cep`, `pais`, `ponto_ref`, `endereco_principal`)
values
    (1, 1, 'Residencial', 'Rua das Trincheiras', '120', 'Apto 302', 'Centro', 'Campina Grande', 'PB', '58400365', 'Brasil', 'Próximo à praça central', true),
    (2, 1, 'Cobranca', 'Rua das Trincheiras', '120', 'Apto 302', 'Centro', 'Campina Grande', 'PB', '58400365', 'Brasil', null, false),
    (3, 2, 'Entrega', 'Avenida Floriano Peixoto', '450', null, 'Prata', 'Campina Grande', 'PB', '58411020', 'Brasil', 'Em frente à padaria', true),
    (4, 2, 'Cobranca', 'Rua Marquês do Herval', '75', 'Casa', 'Liberdade', 'Campina Grande', 'PB', '58414010', 'Brasil', null, false),
    (5, 3, 'Residencial', 'Rua João Pessoa', '89', null, 'José Pinheiro', 'Campina Grande', 'PB', '58407120', 'Brasil', null, true),
    (6, 4, 'Entrega', 'Avenida Rio Branco', '1500', 'Bloco B, Apto 12', 'Catolé', 'Campina Grande', 'PB', '58410000', 'Brasil', 'Portaria 24h', true),
    (7, 4, 'Cobranca', 'Avenida Rio Branco', '1500', 'Bloco B, Apto 12', 'Catolé', 'Campina Grande', 'PB', '58410000', 'Brasil', null, false),
    (8, 5, 'Residencial', 'Rua Vigário Calixto', '33', 'S/N', 'Centro', 'Campina Grande', 'PB', '58400010', 'Brasil', null, true);

-- -------------------------------------------------------------------------
-- categoria
-- -------------------------------------------------------------------------
insert into `categoria`
    (`id_categoria`, `nome_categoria`, `descricao`, `categoria_pai`, `status_categoria`, `imagem_representativa`)
values
    (1, 'Eletrônicos', 'Dispositivos e aparelhos eletrônicos em geral.', null, 'A', 'categorias/eletronicos.png'),
    (2, 'Moda', 'Roupas, calçados e acessórios.', null, 'A', 'categorias/moda.png'),
    (3, 'Casa e Decoração', 'Móveis e itens de decoração para o lar.', null, 'A', 'categorias/casa_decoracao.png'),
    (4, 'Smartphones', 'Telefones celulares e acessórios.', 1, 'A', 'categorias/smartphones.png'),
    (5, 'Notebooks', 'Computadores portáteis.', 1, 'A', 'categorias/notebooks.png'),
    (6, 'Roupas Masculinas', 'Vestuário masculino.', 2, 'A', 'categorias/roupas_masculinas.png');

-- -------------------------------------------------------------------------
-- produto
-- -------------------------------------------------------------------------
insert into `produto`
    (`id_produto`, `id_categoria`, `nome_produto`, `marca`, `fabricante`, `peso`, `descricao_curta`, `descricao_longa`, `dimensoes`, `cadastro`, `status_produto`, `avaliacao_media`, `numero_visualizacoes`, `garantia`)
values
    (1, 4, 'Smartphone Galaxy S23', 'Samsung', 'Samsung Electronics', 0.168, 'Smartphone com tela AMOLED de 6.1"', 'Smartphone Samsung Galaxy S23 com processador Snapdragon 8 Gen 2, câmera tripla de 50MP e tela Dynamic AMOLED 2X.', '14.6x7.1x0.76 cm', '2025-01-15 10:00:00', 'A', 4.50, 320, '12 meses pelo fabricante'),
    (2, 4, 'iPhone 15', 'Apple', 'Apple Inc.', 0.171, 'iPhone com chip A16 Bionic', 'iPhone 15 com tela Super Retina XDR de 6.1", câmera dupla de 48MP e conector USB-C.', '14.7x7.1x0.78 cm', '2025-01-20 10:30:00', 'A', 0.00, 410, '12 meses pelo fabricante'),
    (3, 5, 'Notebook Inspiron 15', 'Dell', 'Dell Technologies', 1.650, 'Notebook para uso profissional', 'Notebook Dell Inspiron 15 com processador Intel Core i7, 16GB RAM e SSD 512GB.', '35.8x23.5x1.9 cm', '2025-02-05 09:20:00', 'A', 4.00, 158, '12 meses pelo fabricante'),
    (4, 6, 'Camisa Polo Clássica', 'Lacoste', 'Lacoste S.A.', 0.220, 'Camisa polo de algodão piquet', 'Camisa polo masculina em algodão piquet, corte regular, disponível em várias cores.', '30x25x2 cm', '2025-02-18 15:45:00', 'A', 0.00, 76, '3 meses'),
    (5, 3, 'Sofá 3 Lugares Comfort', 'Tok&Stok', 'Tok&Stok Indústria e Comércio', 45.000, 'Sofá confortável para sala de estar', 'Sofá de 3 lugares com estrutura em madeira maciça, espuma D33 e revestimento em suede.', '210x90x85 cm', '2025-03-01 08:10:00', 'A', 0.00, 42, '6 meses');

-- -------------------------------------------------------------------------
-- item
-- -------------------------------------------------------------------------
insert into `item`
    (`id_item`, `id_produto`, `sku`, `nome_item`, `marca`, `cor`, `tamanho`, `descricao`, `modelo`, `codigo_barra`, `preco`, `desconto`, `quantidade_restante`, `estoque_minimo`, `peso`, `imagem`, `status_item`)
values
    (1, 1, 'SGS23-PRT-128', 'Galaxy S23 - Preto - 128GB', 'Samsung', 'Preto', '128GB', 'Variação preta com 128GB de armazenamento.', 'SM-S911B', '7891234500011', 5999.00, 0.00, 25, 5, 0.168, 'itens/sgs23_preto.jpg', 'A'),
    (2, 1, 'SGS23-BRC-256', 'Galaxy S23 - Branco - 256GB', 'Samsung', 'Branco', '256GB', 'Variação branca com 256GB de armazenamento.', 'SM-S911B', '7891234500028', 6799.00, 200.00, 12, 5, 0.168, 'itens/sgs23_branco.jpg', 'A'),
    (3, 2, 'IP15-PRT-128', 'iPhone 15 - Preto - 128GB', 'Apple', 'Preto', '128GB', 'Variação preta com 128GB de armazenamento.', 'A3090', '7891234500035', 7499.00, 0.00, 18, 5, 0.171, 'itens/ip15_preto.jpg', 'A'),
    (4, 3, 'NBI15-PRT-I7', 'Notebook Inspiron 15 - i7/16GB/512GB', 'Dell', 'Prata', 'Único', 'Configuração com Intel i7, 16GB RAM e SSD 512GB.', 'Inspiron-15-3520', '7891234500042', 4899.00, 0.00, 9, 3, 1.650, 'itens/inspiron15.jpg', 'A'),
    (5, 4, 'CPL-AZL-M', 'Camisa Polo - Azul - M', 'Lacoste', 'Azul', 'M', 'Camisa polo tamanho M na cor azul marinho.', 'PH4012', '7891234500059', 199.90, 0.00, 40, 10, 0.220, 'itens/polo_azul_m.jpg', 'A'),
    (6, 4, 'CPL-BRC-G', 'Camisa Polo - Branca - G', 'Lacoste', 'Branco', 'G', 'Camisa polo tamanho G na cor branca.', 'PH4012', '7891234500066', 259.90, 0.00, 3, 10, 0.220, 'itens/polo_branca_g.jpg', 'A'),
    (7, 5, 'SOF3L-CZA', 'Sofá 3 Lugares - Cinza', 'Tok&Stok', 'Cinza', 'Único', 'Sofá revestido em suede cinza.', 'CF-3L-2024', '7891234500073', 2500.00, 0.00, 6, 2, 45.000, 'itens/sofa_cinza.jpg', 'A');

-- -------------------------------------------------------------------------
-- carrinho_de_compras
-- -------------------------------------------------------------------------
insert into `carrinho_de_compras`
    (`id_carrinho`, `id_cliente`, `data_criacao`, `ultima_atualizacao`, `situacao_carrinho`, `valor_total`, `quantidade_itens`)
values
    (1, 1, '2025-06-01 10:00:00', '2025-06-01 10:20:00', 'Convertido', 6398.80, 3),
    (2, 2, '2025-06-05 16:00:00', '2025-06-05 16:10:00', 'Convertido', 7299.00, 1),
    (3, 3, '2025-06-10 09:30:00', '2025-06-10 09:45:00', 'Aberto', 5700.00, 2),
    (4, 4, '2025-06-12 20:00:00', '2025-06-12 20:05:00', 'Abandonado', 259.90, 1);

-- -------------------------------------------------------------------------
-- carrinho_armazena_item
-- -------------------------------------------------------------------------
insert into `carrinho_armazena_item`
    (`id_item_carrinho`, `id_carrinho`, `id_item`, `quantidade_item`, `preco_item`, `desconto`, `subtotal`, `data_adicao`)
values
    (1, 1, 1, 1, 5999.00, 0.00, 5999.00, '2025-06-01 10:05:00'),
    (2, 1, 5, 2, 199.90, 0.00, 399.80, '2025-06-01 10:18:00'),
    (3, 2, 3, 1, 7499.00, 200.00, 7299.00, '2025-06-05 16:08:00'),
    (4, 3, 4, 1, 4899.00, 0.00, 4899.00, '2025-06-10 09:35:00'),
    (5, 3, 7, 1, 2500.00, 1699.00, 801.00, '2025-06-10 09:44:00'),
    (6, 4, 6, 1, 259.90, 0.00, 259.90, '2025-06-12 20:04:00');

-- -------------------------------------------------------------------------
-- pedido
-- -------------------------------------------------------------------------
insert into `pedido`
    (`id_pedido`, `id_cliente`, `id_carrinho`, `id_endereco_entrega`, `id_endereco_cobranca`, `data_pedido`, `status_pedido`, `valor_total`, `valor_frete`, `valor_final`, `desconto_aplicado`, `prazo_estimado`, `motivo_cancelamento`)
values
    (1, 1, 1, 1, 2, '2025-06-01 10:25:00', 'Entregue', 6398.80, 25.00, 6423.80, 0.00, '5 dias úteis', null),
    (2, 2, 2, 3, 4, '2025-06-05 16:15:00', 'Enviado', 7299.00, 0.00, 7199.00, 100.00, '3 dias úteis', null);

-- -------------------------------------------------------------------------
-- item_pedido
-- -------------------------------------------------------------------------
insert into `item_pedido`
    (`id_item_pedido`, `id_pedido`, `id_item`, `quantidade`, `preco_unitario`, `subtotal`, `desconto`)
values
    (1, 1, 1, 1, 5999.00, 5999.00, 0.00),
    (2, 1, 5, 2, 199.90, 399.80, 0.00),
    (3, 2, 3, 1, 7499.00, 7299.00, 200.00);

-- -------------------------------------------------------------------------
-- observacoes_cliente
-- -------------------------------------------------------------------------
insert into `observacoes_cliente`
    (`id_observacao`, `id_pedido`, `observacao_cliente`)
values
    (1, 1, 'Deixar na portaria com o porteiro, caso não haja ninguém para receber.'),
    (2, 2, 'Entregar preferencialmente após às 18h, durante a semana.');

-- -------------------------------------------------------------------------
-- pagamento
-- -------------------------------------------------------------------------
insert into `pagamento`
    (`id_pagamento`, `id_pedido`, `forma_pagamento`, `valor`, `data_pagamento`, `status`, `num_transacoes`, `quantidade_parcelas`, `bandeira_cartao`, `comprovante`)
values
    (1, 1, 'Cartao_Credito', 6423.80, '2025-06-01 10:26:30', 'Aprovado', 1, 3, 'Visa', 'NSU-000123456'),
    (2, 2, 'Pix', 7199.00, '2025-06-05 16:16:05', 'Aprovado', 1, 1, null, 'PIX-TX-987654321');

-- -------------------------------------------------------------------------
-- observacoes_financeiras
-- -------------------------------------------------------------------------
insert into `observacoes_financeiras`
    (`id_observacao_financeira`, `id_pagamento`, `observacao`)
values
    (1, 1, 'Pagamento aprovado sem divergências na primeira tentativa.'),
    (2, 2, 'Confirmação recebida via webhook do PSP em poucos segundos.');

-- -------------------------------------------------------------------------
-- entrega
-- -------------------------------------------------------------------------
insert into `entrega`
    (`id_entrega`, `id_pedido`, `transportadora`, `cod_rastreio`, `data_envio`, `data_prevista`, `data_entrega`, `status_entrega`, `entregador`, `custo_frete`, `historico`)
values
    (1, 1, 'Correios', 'BR123456789PB', '2025-06-02 08:00:00', '2025-06-06 18:00:00', '2025-06-05 14:30:00', 'Entregue', 'José Ribeiro', 25.00, 'Objeto postado; Em trânsito; Saiu para entrega; Entregue ao destinatário.'),
    (2, 2, 'Loggi', 'LG987654321BR', '2025-06-06 09:00:00', '2025-06-09 18:00:00', null, 'Em Transito', null, 0.00, 'Objeto coletado; Em rota para centro de distribuição.');

-- -------------------------------------------------------------------------
-- avaliacao
-- -------------------------------------------------------------------------
insert into `avaliacao`
    (`id_avaliacao`, `id_cliente`, `id_produto`, `nota`, `comentario`, `data_avaliacao`, `status_avaliacao`)
values
    (1, 1, 1, 5, 'Excelente smartphone, câmera muito boa e bateria dura o dia todo.', '2025-06-07 12:00:00', 'Aprovado'),
    (2, 2, 3, 4, 'Notebook rápido, mas esquenta um pouco sob carga pesada.', '2025-06-11 09:30:00', 'Pendente');

-- -------------------------------------------------------------------------
-- registro_interacao
-- -------------------------------------------------------------------------
insert into `registro_interacao`
    (`id_interacao`, `id_cliente`, `id_produto`, `data_visualizacao`, `horario_visualizacao`, `tempo_interacao`, `adicionado_favorito`, `adicionado_carrinho`, `quantidade_visualizacoes`, `dispositivo_utilizado`)
values
    (1, 1, 1, '2025-06-01', '09:50:00', 180, true, true, 3, 'Desktop_Chrome'),
    (2, 2, 3, '2025-06-05', '15:40:00', 240, false, true, 2, 'Mobile_App_iOS'),
    (3, 3, 4, '2025-06-10', '09:20:00', 90, false, true, 1, 'Desktop_Firefox'),
    (4, 3, 7, '2025-06-10', '09:30:00', 300, true, true, 4, 'Desktop_Firefox'),
    (5, null, 2, '2025-06-13', '11:15:00', 60, false, false, 1, 'Mobile_Web_Android');

-- -------------------------------------------------------------------------
-- historico_cliente
-- -------------------------------------------------------------------------
insert into `historico_cliente`
    (`id_compra`, `id_cliente`, `id_pedido`, `id_pagamento`, `id_entrega`)
values
    (1, 1, 1, 1, 1),
    (2, 2, 2, 2, 2);

-- -------------------------------------------------------------------------
-- historico_pedido
-- -------------------------------------------------------------------------
insert into `historico_pedido`
    (`id_historico`, `id_pedido`, `data`, `status_anterior`, `status_novo`, `responsavel`)
values
    (1, 1, '2025-06-01 10:25:00', 'Processando', 'Pago', 'Sistema'),
    (2, 1, '2025-06-02 08:00:00', 'Pago', 'Enviado', 'Sistema'),
    (3, 1, '2025-06-05 14:30:00', 'Enviado', 'Entregue', 'Sistema'),
    (4, 2, '2025-06-05 16:15:00', 'Processando', 'Pago', 'Sistema'),
    (5, 2, '2025-06-06 09:00:00', 'Pago', 'Enviado', 'Sistema');

-- -------------------------------------------------------------------------
-- movimentacao_estoque
-- -------------------------------------------------------------------------
insert into `movimentacao_estoque`
    (`id_movimentacao`, `id_item`, `tipo_movimentacao`, `quantidade`, `data`, `responsavel`, `observacoes`)
values
    (1, 1, 'Entrada', 30, '2025-05-20 08:00:00', 'Sistema', 'Recebimento de novo lote do fornecedor.'),
    (2, 1, 'Saida', 1, '2025-06-01 10:25:00', 'Sistema', 'Baixa referente ao pedido 1.'),
    (3, 5, 'Entrada', 50, '2025-05-25 08:00:00', 'Sistema', 'Reposição de estoque sazonal.'),
    (4, 5, 'Saida', 2, '2025-06-01 10:25:00', 'Sistema', 'Baixa referente ao pedido 1.'),
    (5, 3, 'Saida', 1, '2025-06-05 16:15:00', 'Sistema', 'Baixa referente ao pedido 2.'),
    (6, 6, 'Ajuste', 2, '2025-06-13 17:00:00', 'Ana Paula (Estoque)', 'Correção após contagem de inventário mensal.');
