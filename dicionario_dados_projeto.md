# Dicionário de Dados - Sistema de E-commerce

Este documento contém o dicionário de dados referente ao projeto da disciplina Banco de Dados, ministrada pelo professor Fábio Luiz Leite Júnior no período de 2026.1

---

## 1. Informações Gerais do Sistema

| Campo | Descrição |
|---|---|
| **Sistema** | Plataforma de E-commerce Multi-módulos |
| **Objetivo** | Armazenamento, organização e recuperação de informações relacionadas a clientes, produtos, categorias, carrinhos de compras, pedidos, pagamentos, entregas e comportamento de navegação. |
| **Módulos Principais** | Cliente e Comportamento, Catálogo e Produtos, Carrinho e Pedidos, Fechamento de Pedido (Checkout), Logística de Entrega. |
| **Padrão de Nomenclatura** | `snake_case` (letras minúsculas separadas por underline) |

---

## 2. Estrutura dos Atributos (Tabelas)

### Tabela: `cliente`
**Descrição:** Armazena os dados cadastrais, credenciais de acesso e preferências de perfil dos clientes da plataforma.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_cliente` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do cliente | Gerado automaticamente pelo sistema. |
| `nome_completo` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome completo do usuário | Deve conter nome e sobrenome. |
| `cpf` | CHAR | 11 | Não | Não | Não | Sim | — | Cadastro de Pessoa Física | Deve possuir apenas números e ser válido. |
| `data_nascimento` | DATE | — | Não | Não | Não | Não | — | Data de nascimento | Deve ser menor que a data atual. |
| `sexo` | CHAR | 1 | Não | Não | Sim | Não | — | Gênero biológico/identificado | Valores: 'M', 'F', 'O' (Masculino, Feminino, Outro). |
| `telefone` | VARCHAR | 20 | Não | Não | Não | Não | — | Telefone celular ou fixo | Formato com DDD (apenas números). |
| `email` | VARCHAR | 120 | Não | Não | Não | Sim | — | Endereço de e-mail | Deve possuir formato eletrônico válido (`@`). |
| `senha_acesso` | VARCHAR | 255 | Não | Não | Não | Não | — | Senha criptografada | Armazenada obrigatoriamente com hash seguro (ex: bcrypt). |
| `data_cadastro` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora de criação da conta | Preenchida automaticamente no cadastro. |
| `status_conta` | CHAR | 1 | Não | Não | Não | Não | 'A' | Situação atual da conta | 'A' = Ativo, 'I' = Inativo, 'B' = Bloqueado. |
| `foto_perfil` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL ou caminho da foto de perfil | String apontando para o storage de imagens. |
| `preferencias_compra` | TEXT | — | Não | Não | Sim | Não | — | Interesses e tags de preferência | Estrutura de texto ou JSON com categorias de interesse. |

---

### Tabela: `endereco`
**Descrição:** Registra os endereços residenciais, de entrega e de faturamento associados aos clientes.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_endereco` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do endereço | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK relacionando o endereço ao cliente | Deve existir na tabela `cliente`. |
| `tipo_endereco` | VARCHAR | 30 | Não | Não | Não | Não | — | Tipo de endereço | Ex: 'Residencial', 'Entrega', 'Faturamento'. |
| `logradouro` | VARCHAR | 150 | Não | Não | Não | Não | — | Rua, Avenida, Travessa, etc. | Nome da via pública. |
| `numero` | VARCHAR | 10 | Não | Não | Não | Não | — | Número do imóvel | Aceita texto para casos como 'S/N'. |
| `complemento` | VARCHAR | 50 | Não | Não | Sim | Não | — | Dados adicionais do imóvel | Apartamento, Bloco, Sala, etc. |
| `bairro` | VARCHAR | 50 | Não | Não | Não | Não | — | Bairro onde se localiza | Nome do bairro. |
| `cidade` | VARCHAR | 100 | Não | Não | Não | Não | — | Cidade do endereço | Nome do município. |
| `estado` | CHAR | 2 | Não | Não | Não | Não | — | Sigla da Unidade Federativa | Deve ser uma sigla válida (Ex: 'PB', 'SP'). |
| `cep` | CHAR | 8 | Não | Não | Não | Não | — | Código de Endereçamento Postal | Apenas os 8 dígitos numéricos. |
| `pais` | VARCHAR | 60 | Não | Não | Não | Não | 'Brasil' | País do endereço | Nome do país por extenso. |
| `ponto_referencia` | VARCHAR | 150 | Não | Não | Sim | Não | — | Descrição para facilitar entrega | Texto livre auxiliar. |
| `principal` | BOOLEAN | — | Não | Não | Não | Não | false | Indica se é o endereço padrão | `true` se for o endereço padrão de entrega. |

---

### Tabela: `categoria`
**Descrição:** Armazena a árvore de categorias e subcategorias utilizadas para organizar e classificar os produtos do catálogo.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_categoria` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador da categoria | Gerado automaticamente. |
| `nome_categoria` | VARCHAR | 80 | Não | Não | Não | Sim | — | Nome de exibição da categoria | Ex: 'Eletrônicos', 'Livros'. Único. |
| `descricao_categoria`| TEXT | — | Não | Não | Sim | Não | — | Detalhamento do escopo da categoria| Explicação sobre quais itens pertencem a ela. |
| `pai_id_categoria` | INTEGER | — | Não | Sim | Sim | Não | — | Auto-relacionamento (subcategoria) | Referencia a categoria pai (`id_categoria`). Nulo se for raiz. |
| `imagem` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL da imagem ícone da categoria | Link para exibição visual nos menus do e-commerce. |
| `status_categoria` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação da categoria | 'A' = Ativa, 'I' = Inativa. |

---

### Tabela: `produto`
**Descrição:** Entidade de agrupamento conceitual do catálogo que define as informações gerais, marcas e classificação macro dos produtos, servindo como base para as variações (itens).

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_produto` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do produto | Gerado automaticamente. |
| `nome_produto` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome comercial macro do produto | Título que agrupa as variações (Ex: 'Smartphone X'). |
| `descricao` | TEXT | — | Não | Não | Não | Não | — | Descrição detalhada geral do produto | Ficha técnica, características gerais e uso. |
| `marca` | VARCHAR | 50 | Não | Não | Não | Não | — | Fabricante ou marca do produto | Ex: 'Sony', 'Nike', 'Samsung'. |
| `preco` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço padrão/sugerido do produto | Valor de venda referencial. Deve ser > 0. |
| `desconto` | DECIMAL | 5,2 | Não | Não | Não | Não | 0.00 | Porcentagem de desconto padrão | Valor percentual padrão do produto (0.00 a 100.00). |
| `status_produto` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação no catálogo | 'A' = Ativo, 'I' = Inativo. |
| `id_categoria` | INTEGER | — | Não | Sim | Não | Não | — | FK para classificação do produto | Deve existir na tabela `categoria`. |
| `cadastro` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data de inclusão do produto | Preenchida automaticamente no sistema no momento da criação. |

---

### Tabela: `item`
**Descrição:** Entidade que representa a variação física, tangível e específica de um produto. Contém os atributos reais de estoque, tamanho, cor e identificadores comerciais diretos (SKU e Código de Barras).

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do item específico | Gerado automaticamente. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK relacionando o item ao seu produto pai | Deve existir na tabela `produto`. |
| `sku` | VARCHAR | 50 | Não | Não | Não | Sim | — | Stock Keeping Unit (Código de estoque) | Código identificador comercial e logístico único. |
| `nome_item` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome específico da variante do item | Ex: 'Smartphone X - Preto - 128GB'. |
| `marca` | VARCHAR | 50 | Não | Não | Sim | Não | — | Marca específica (caso mude da macro) | Opcional. Se nulo, assume a marca do produto pai. |
| `cor` | VARCHAR | 30 | Não | Não | Sim | Não | — | Cor específica da variação | Ex: 'Preto', 'Azul Marinho', 'Rosê'. |
| `tamanho` | VARCHAR | 20 | Não | Não | Sim | Não | — | Dimensão de vestuário ou escala física | Ex: 'P', 'M', 'G', '42', '128GB'. |
| `descricao` | TEXT | — | Não | Não | Sim | Não | — | Descrição particular da variação | Detalhes que se aplicam estritamente a este item. |
| `modelo` | VARCHAR | 50 | Não | Não | Sim | Não | — | Modelo comercial do fabricante | Código técnico atribuído pela fábrica. |
| `codigo_barra` | VARCHAR | 50 | Não | Não | Sim | Sim | — | Código EAN/GTIN global do item | Identificador internacional de barras. |
| `preco` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço real de venda da variante | Valor cobrado em caixa pelo item. Deve ser > 0. |
| `desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Valor monetário nominal de desconto | Abatimento direto em Reais aplicado a esta variação. |
| `preco_promocional`| DECIMAL | 15,2 | Não | Não | Sim | Não | — | Preço final líquido com promoção ativa | Calculado ou fixado dinamicamente (`preco - desconto`). |
| `quantidade_restante`| INTEGER| — | Não | Não | Não | Não | 0 | Quantidade atual física em estoque | Não pode ser um valor negativo. |
| `estoque_mínimo` | INTEGER | — | Não | Não | Não | Não | 5 | Limite mínimo para alerta de reposição | Dispara avisos logísticos internos ao ser atingido. |
| `peso` | DECIMAL | 8,3 | Não | Não | Sim | Não | — | Peso líquido do item em quilogramas | Usado no cálculo do frete (Ex: 0.350 para 350g). |
| `imagem` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL da imagem específica da variante | Caminho da foto correspondente à cor/modelo exato. |
| `status_item` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação da variação | 'A' = Ativo, 'I' = Inativo, 'E' = Esgotado. |

---

### Tabela: `carrinho_compras`
**Descrição:** Instância que agrupa temporariamente os itens selecionados pelo cliente, monitorando as quantidades e os valores parciais consolidados antes do checkout.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_carrinho` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do carrinho | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Sim | — | Cliente proprietário do carrinho | Relação 1:1 ativa por cliente. |
| `data_criacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Momento em que o carrinho foi aberto | Preenchido automaticamente. |
| `data_atualizacao`| DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Última alteração de itens | Atualizado a cada inserção/remoção. |
| `status_carrinho` | VARCHAR | 20 | Não | Não | Não | Não | 'Aberto' | Estado atual do carrinho | 'Aberto', 'Convertido', 'Abandonado'. |
| `valor_total` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Soma acumulada dos subtotais dos itens| Somatório dinâmico dos itens ativos no carrinho. |
| `quantidade_items`| INTEGER | — | Não | Não | Não | Não | 0 | Quantidade total de volumes salvos | Soma total das quantidades de todos os itens. |

---

### Tabela: `item_carrinho`
**Descrição:** Tabela associativa que discrimina os itens variantes específicos adicionados a um carrinho de compras e suas respectivas quantidades.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_carrinho`| INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único da linha no carrinho| Gerado automaticamente. |
| `id_carrinho` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o carrinho de origem | Deve existir na tabela `carrinho_compras`. |
| `id_item` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o item variante escolhido| Deve existir na tabela `item`. |
| `quantidade` | INTEGER | — | Não | Não | Não | Não | 1 | Unidades selecionadas daquele item | Deve ser um valor inteiro maior que 0. |
| `preco_unitario` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço de venda no momento da inserção | Congela o preço para fins de visualização estável. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Resultado de `quantidade * preco_unitario` | Calculado ou atualizado por gatilhos. |
| `data_inclusao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Registro de quando o item foi insercido | Auditoria interna de tempo. |

---

### Tabela: `pedido`
**Descrição:** Registra a venda consolidada após o fechamento do checkout, guardando os valores finais consolidados, descontos totais aplicados e os prazos logísticos acordados.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único numérico do pedido | Número oficial da compra. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK do cliente comprador | Referencia o comprador na tabela `cliente`. |
| `id_endereco_entrega`| INTEGER | — | Não | Sim | Não | Não | — | Endereço para envio físico da compra | Referencia a tabela `endereco`. |
| `data_pedido` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora em que a compra fechou | Registrado na finalização do checkout. |
| `status_pedido` | VARCHAR | 30 | Não | Não | Não | Não | 'Processando'| Situação da jornada do pedido | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado'. |
| `valor_total` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor bruto original sem deduções | Soma original de todos os itens + frete. |
| `desconto_aplicado`| DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Total de descontos consolidados | Cupons + abatimentos promocionais globais. |
| `valor_final` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor líquido real faturado ao cliente| Cálculo final: `valor_total - desconto_aplicado`. |
| `valor_frete` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Custo cobrado pela entrega | Calculado via API de logística. |
| `prazo_estimado` | VARCHAR | 50 | Não | Não | Sim | Não | — | Prazo ou data limite prometida | Ex: '5 dias úteis' ou uma data estipulada. |

---

### Tabela: `item_pedido`
**Descrição:** Linhas de detalhe do pedido. Armazena o histórico imutável das variantes (itens) vendidas, guardando os descontos específicos concedidos por item no ato da compra.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária da linha do item | Identificador do registro físico. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido consolidado | Deve pertencer a um registro em `pedido`. |
| `id_item` | INTEGER | — | Não | Sim | Não | Não | — | FK do item específico comercializado | Mantém vínculo histórico com a tabela `item`. |
| `quantidade` | INTEGER | — | Não | Não | Não | Não | — | Quantidade efetivamente comprada | Valor estritamente maior que zero. |
| `preco_unitario` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço de tabela unitário do item | Valor cheio do item sem os descontos da linha. |
| `desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Desconto unitário concedido nesta linha| Valor nominal em Reais de desconto por unidade. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor final faturado desta linha | `(preco_unitario - desconto) * quantidade`. |

---

### Tabela: `pagamento`
**Descrição:** Controla as tentativas, transações, bandeiras e as confirmações financeiras de cada pedido realizado.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pagamento` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador da transação financeira | Código sequencial interno. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido correspondente | Relação N:1 (permite re-tentativas). |
| `forma_pagamento` | VARCHAR | 50 | Não | Não | Não | Não | — | Meio utilizado para o pagamento | 'Cartao_Credito', 'Boleto', 'Pix'. |
| `bandeira_cartao` | VARCHAR | 30 | Não | Não | Sim | Não | — | Bandeira emissora do cartão | Ex: 'Visa', 'Mastercard', 'Elo', 'Amex'. |
| `status_pagamento`| VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Estado atual da cobrança bancária | 'Pendente', 'Aprovado', 'Recusado', 'Estornado'. |
| `valor_pago` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Quantia financeira transacionada | Deve bater com o `valor_final` do pedido. |
| `data_pagamento` | DATETIME | — | Não | Não | Sim | Não | — | Instante de confirmação da operadora | Preenchido apenas quando aprovado. |
| `parcelas` | INTEGER | — | Não | Não | Não | Não | 1 | Número de divisões da cobrança | Mínimo 1. Relevante para Cartão de Crédito. |
| `comprovante` | VARCHAR | 255 | Não | Não | Sim | Não | — | Código ou link do recibo do gateway | Código NSU ou link de autenticação. |

---

### Tabela: `avaliacao`
**Descrição:** Reúne as notas quantitativas, comentários qualitativos e o status de moderação dos feedbacks dos clientes.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_avaliacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do comentário | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK do cliente autor do feedback | Deve constar em `cliente`. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK do produto macro que recebeu a nota| Deve constar em `produto`. |
| `nota` | INTEGER | — | Não | Não | Não | Não | — | Pontuação dada ao produto pelo usuário | Valores válidos inteiros de 1 a 5. |
| `comentario` | TEXT | — | Não | Não | Sim | Não | — | Texto livre com a opinião do cliente | Crítica ou elogio por extenso. |
| `status_avaliacao`| VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Situação de moderação da avaliação | 'Pendente', 'Aprovado', 'Reprovado'. |
| `data_avaliacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Dia e hora da postagem da avaliação | Definido na criação do registro. |

---

### Tabela: `registro_interacao`
**Descrição:** Módulo de comportamento. Registra eventos de rastreamento de navegação, visualizações e cliques baseados nos produtos de interesse.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_interacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária do log comportamental | Contador numérico sequencial. |
| `id_cliente` | INTEGER | — | Não | Sim | Sim | Não | — | Usuário logado que gerou o evento | Nulo se for visitante anônimo. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | Produto alvo da ação de navegação | Identifica o produto macro focado. |
| `tipo_interacao` | VARCHAR | 50 | Não | Não | Não | Não | — | Natureza do clique ou ação | 'Visualizacao', 'Adicionar_Favorito', 'Clique_Banner'. |
| `data_hora` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Momento exato da ocorrência da ação| Registrador temporal de alta precisão. |
| `dispositivo` | VARCHAR | 50 | Não | Não | Não | Não | — | Plataforma de hardware/software | Ex: 'Desktop_Chrome', 'Mobile_App_iOS'. |

---

## 3. Matriz de Relacionamentos (Refatorada)

A tabela abaixo detalha o mapeamento lógico e as novas dependências estruturais introduzidas pela tabela `item`:

| Tabela Origem | Campo FK | Tabela Destino | Campo PK | Cardinalidade | Descrição |
|---|---|---|---|---|---|
| `item` | `id_produto` | `produto` | `id_produto` | N:1 | Um produto macro pode possuir diversas variações físicas de itens. |
| `produto` | `id_categoria` | `categoria` | `id_categoria` | N:1 | Um produto está categorizado obrigatoriamente sob uma categoria macro. |
| `item_carrinho` | `id_item` | `item` | `id_item` | N:1 | A linha de um carrinho aponta diretamente para um item físico variante. |
| `item_pedido` | `id_item` | `item` | `id_item` | N:1 | A linha de histórico de um pedido aponta para o item variante vendido. |
| `item_pedido` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido fechado contém uma ou mais linhas de itens comprados. |
| `carrinho_compras`| `id_cliente` | `cliente` | `id_cliente` | 1:1 | Cada cliente possui apenas um carrinho de compras ativo por vez. |

---

## 4. Restrições de Integridade e Domínio (CHECK Constraints)

| Campo | Tipo de Restrição | Valores Permitidos / Regras |
|---|---|---|
| `categoria.status_categoria`| Domínio Fixo | 'A' (Ativa), 'I' (Inativa) |
| `produto.status_produto` | Domínio Fixo | 'A' (Ativo), 'I' (Inativo) |
| `item.status_item` | Domínio Fixo | 'A' (Ativo), 'I' (Inativo), 'E' (Esgotado) |
| `item.preco` | Verificação Numérica | Deve ser estritamente maior que zero (`> 0.00`) |
| `item.quantidade_restante`| Verificação Numérica | Deve ser maior ou igual a zero (`>= 0`) |
| `item.preco_promocional` | Verificação Numérica | Deve ser menor ou igual ao preço e maior que zero (`<= preco AND > 0`) |
| `pedido.status_pedido` | Domínio Fixo | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado' |
| `pedido.valor_final` | Verificação Lógica | Deve corresponder estritamente a: `valor_total - desconto_aplicado` |
| `pagamento.forma_pagamento` | Domínio Fixo | 'Cartao_Credito', 'Boleto', 'Pix' |
| `avaliacao.status_avaliacao`| Domínio Fixo | 'Pendente', 'Aprovado', 'Reprovado' |
| `avaliacao.nota` | Intervalo Fixo | Número inteiro contido e verificado entre `1` e `5` |