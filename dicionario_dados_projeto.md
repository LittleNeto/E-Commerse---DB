# Dicionário de Dados - Sistema de E-commerce

Este documento contém o dicionário de dados referente ao projeto da disciplina Banco de Dados, ministrada pelo professor Fábio Luiz Leite Júnior no período de 2026.1.

---

## 1. Informações Gerais do Sistema

| Campo | Descrição |
|---|---|
| **Sistema** | Plataforma de E-commerce Multi-módulos |
| **Objetivo** | Armazenamento, organização e recuperação de informações relacionadas a clientes, produtos, categorias, carrinhos de compras, pedidos, pagamentos, entregas e comportamento de navegação. |
| **Módulos Principais** | Cliente e Comportamento, Catálogo e Produtos, Carrinho e Pedidos, Fechamento de Pedido (Checkout), Logística de Entrega, Histórico e Auditoria. |
| **Padrão de Nomenclatura** | `snake_case` (letras minúsculas separadas por underline) |

---

## 2. Estrutura dos Atributos (Tabelas)

### Tabela: `cliente`
**Descrição:** Armazena os dados cadastrais, credenciais de acesso e preferências de perfil dos clientes da plataforma.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_cliente` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do cliente | Gerado automaticamente pelo sistema. |
| `nome_cliente` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome do usuário | Campo obrigatório. |
| `cpf` | CHAR | 11 | Não | Não | Não | Sim | — | Cadastro de Pessoa Física | Deve possuir apenas números e ser válido. |
| `data_nascimento` | DATE | — | Não | Não | Não | Não | — | Data de nascimento | Deve ser menor que a data atual. |
| `sexo` | CHAR | 1 | Não | Não | Sim | Não | — | Gênero biológico/identificado | Valores: 'M', 'F', 'O' (Masculino, Feminino, Outro). |
| `telefone` | VARCHAR | 20 | Não | Não | Não | Não | — | Telefone celular ou fixo | Formato com DDD (apenas números). |
| `email` | VARCHAR | 120 | Não | Não | Não | Sim | — | Endereço de e-mail | Deve possuir formato eletrônico válido (`@`). |
| `senha` | VARCHAR | 255 | Não | Não | Não | Não | — | Senha criptografada | Armazenada obrigatoriamente com hash seguro (ex: bcrypt). |
| `data_cadastro` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora de criação da conta | Preenchida automaticamente no cadastro. |
| `status_conta` | CHAR | 1 | Não | Não | Não | Não | 'A' | Situação atual da conta | 'A' = Ativo, 'I' = Inativo, 'B' = Bloqueado. |
| `foto_perfil` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL ou caminho da foto de perfil | String apontando para o storage de imagens. |

---

### Tabela: preferencia_cliente

**Descrição:** Armazena as preferências associadas a cada cliente da plataforma.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_preferencia` |	INTEGER |	— |	Sim |	Não |	Não |	Sim |	Auto Increment |	Identificador único da preferência |	Gerado automaticamente pelo sistema. |
| `id_cliente` |	INTEGER |	— |	Não |	Sim |	Não |	Não |	— |	Identificador do cliente associado |	Deve corresponder a um cliente existente na tabela cliente. |
| `preferencia` |	VARCHAR |	100 |	Não |	Não |	Não |	Não |	— |	Preferência do cliente |	Campo obrigatório. |

---

### Tabela: `endereco`
**Descrição:** Registra os endereços residenciais, de entrega e de faturamento associados aos clientes.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_endereco` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do endereço | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK relacionando o endereço ao cliente | Deve existir na tabela `cliente`. |
| `tipo` | VARCHAR | 30 | Não | Não | Não | Não | — | Tipo de endereço | Ex: 'Residencial', 'Entrega', 'Faturamento'. |
| `logradouro` | VARCHAR | 150 | Não | Não | Não | Não | — | Rua, Avenida, Travessa, etc. | Nome da via pública. |
| `numero` | VARCHAR | 10 | Não | Não | Não | Não | — | Número do imóvel | Aceita texto para casos como 'S/N'. |
| `complemento` | VARCHAR | 50 | Não | Não | Sim | Não | — | Dados adicionais do imóvel | Apartamento, Bloco, Sala, etc. |
| `bairro` | VARCHAR | 50 | Não | Não | Não | Não | — | Bairro onde se localiza | Nome do bairro. |
| `cidade` | VARCHAR | 100 | Não | Não | Não | Não | — | Cidade do endereço | Nome do município. |
| `estado` | CHAR | 2 | Não | Não | Não | Não | — | Sigla da Unidade Federativa | Deve ser uma sigla válida (Ex: 'PB', 'SP'). |
| `cep` | CHAR | 8 | Não | Não | Não | Não | — | Código de Endereçamento Postal | Apenas os 8 dígitos numéricos. |
| `pais` | VARCHAR | 60 | Não | Não | Não | Não | 'Brasil' | País do endereço | Nome do país por extenso. |
| `ponto_ref` | VARCHAR | 150 | Não | Não | Sim | Não | — | Descrição para facilitar entrega | Texto livre auxiliar. |
| `endereco_principal`| BOOLEAN | — | Não | Não | Não | Não | false | Indica se é o endereço padrão | `true` se for o endereço padrão de entrega. |

---

### Tabela: `categoria`
**Descrição:** Armazena a árvore de categorias e subcategorias utilizadas para organizar e classificar os produtos do catálogo.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_categoria` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador da categoria | Gerado automaticamente. |
| `nome_categoria` | VARCHAR | 80 | Não | Não | Não | Sim | — | Nome de exibição da categoria | Ex: 'Eletrônicos'. Único. |
| `descricao` | TEXT | — | Não | Não | Sim | Não | — | Detalhamento do escopo da categoria| Explicação sobre os itens pertencentes. |
| `categoria_pai` | INTEGER | — | Não | Sim | Sim | Não | — | Auto-relacionamento (subcategoria) | Referencia a categoria pai (`id_categoria`). Nulo se for raiz. |
| `status_categoria` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação da categoria | 'A' = Ativa, 'I' = Inativa. |
| `imagem_representativa`| VARCHAR| 255 | Não | Não | Sim | Não | — | URL da imagem ícone da categoria | Link para exibição visual nos menus. |

---

### Tabela: `produto`
**Descrição:** Entidade macro do catálogo que define as informações gerais, marcas e especificações técnicas de agrupamento dos produtos.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_produto` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do produto | Gerado automaticamente. |
| `id_categoria` | INTEGER | — | Não | Sim | Não | Não | — | FK para classificação do produto | Deve existir na tabela `categoria`. |
| `nome_produto` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome comercial macro do produto | Título do produto agrupador. |
| `marca` | VARCHAR | 50 | Não | Não | Não | Não | — | Marca do produto | Ex: 'Sony', 'Samsung'. |
| `fabricante` | VARCHAR | 100 | Não | Não | Não | Não | — | Empresa fabricante do item | Responsável pela manufatura. |
| `peso` | DECIMAL | 8,3 | Não | Não | Sim | Não | — | Peso bruto estimado do produto | Representação em kg. |
| `descricao_curta` | VARCHAR | 255 | Não | Não | Sim | Não | — | Breve resumo comercial | Exibido em listagens rápidas. |
| `descricao_longa` | TEXT | — | Não | Não | Sim | Não | — | Ficha técnica detalhada completa | Explicações extensas e manuais. |
| `dimensoes` | VARCHAR | 50 | Não | Não | Sim | Não | — | Altura x Largura x Profundidade | Formato texto (Ex: '15x8x0.8 cm'). |
| `cadastro` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data de inclusão no sistema | Preenchida automaticamente. |
| `status_produto` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação no catálogo | 'A' = Ativo, 'I' = Inativo. |
| `avaliacao_media` | DECIMAL | 3,2 | Não | Não | Sim | Não | 0.00 | Média ponderada das notas | Calculada dinamicamente via triggers (1 a 5). |
| `numero_visualizacoes`| INTEGER| — | Não | Não | Não | Não | 0 | Contador de acessos ao produto | Incrementado a cada visualização. |
| `garantia` | VARCHAR | 50 | Não | Não | Sim | Não | — | Tempo e termos de garantia | Ex: '12 meses pelo fabricante'. |

---

### Tabela: `item`
**Descrição:** Entidade que representa a variação física, tangível e específica de um produto (SKU). Contém os atributos reais de estoque, tamanho, cor e valores comerciais.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do item específico | Gerado automaticamente. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK relacionando o item ao seu produto pai | Deve existir na tabela `produto`. |
| `sku` | VARCHAR | 50 | Não | Não | Não | Sim | — | Stock Keeping Unit (Código de estoque) | Código identificador logístico único. |
| `nome_item` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome específico da variante do item | Ex: 'Smartphone X - Preto - 128GB'. |
| `marca` | VARCHAR | 50 | Não | Não | Sim | Não | — | Marca específica da variante | Se nulo, assume a marca do produto pai. |
| `cor` | VARCHAR | 30 | Não | Não | Sim | Não | — | Cor específica da variação | Ex: 'Preto', 'Azul'. |
| `tamanho` | VARCHAR | 20 | Não | Não | Sim | Não | — | Dimensão ou escala física | Ex: 'M', '42', '128GB'. |
| `descricao` | TEXT | — | Não | Não | Sim | Não | — | Descrição particular da variação | Detalhes estritos desta variação. |
| `modelo` | VARCHAR | 50 | Não | Não | Sim | Não | — | Modelo comercial técnico | Código do fabricante. |
| `codigo_barra` | VARCHAR | 50 | Não | Não | Sim | Sim | — | Código EAN/GTIN global | Identificador internacional de barras. |
| `preco` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço real de venda da variante | Valor cobrado pelo item. Deve ser > 0. |
| `desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Valor monetário nominal de desconto | Abatimento em Reais nesta variação. |
| `quantidade_restante`| INTEGER| — | Não | Não | Não | Não | 0 | Quantidade física em estoque | Não pode ser negativo. |
| `estoque_minimo` | INTEGER | — | Não | Não | Não | Não | 5 | Limite mínimo para reposição | Dispara alertas logísticos. |
| `peso` | DECIMAL | 8,3 | Não | Não | Sim | Não | — | Peso líquido específico da variante | Usado no cálculo do frete. |
| `imagem` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL da imagem específica da variante | Foto correspondente à cor/modelo exato. |
| `status_item` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação da variação | 'A' = Ativo, 'I' = Inativo, 'E' = Esgotado. |

---

### Tabela: `carrinho_de_compras`
**Descrição:** Instância que agrupa temporariamente os itens selecionados pelo cliente antes do checkout.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_carrinho` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do carrinho | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | Cliente proprietário do carrinho | Permite múltiplos carrinhos por cliente. |
| `data_criacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Momento em que o carrinho foi aberto | Preenchido automaticamente. |
| `ultima_atualizacao`| DATETIME| — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Última alteração de itens | Atualizado via triggers. |
| `situacao_carrinho`| VARCHAR | 20 | Não | Não | Não | Não | 'Aberto' | Estado atual do carrinho | 'Aberto', 'Convertido', 'Abandonado'. |
| `valor_total` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Soma acumulada dos subtotais | Somatório dinâmico dos itens ativos. |
| `quantidade_itens` | INTEGER | — | Não | Não | Não | Não | 0 | Quantidade total de volumes salvos | Soma total das quantidades de itens. |

---

### Tabela: `Carrinho_Armazena_Item`
**Descrição:** Tabela associativa que discrimina os produtos adicionados a um carrinho de compras. Conforme o modelo lógico estruturado, vincula-se diretamente a `produto`.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_carrinho`| INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único da linha | Gerado automaticamente. |
| `id_carrinho` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o carrinho de origem | Deve existir em `carrinho_de_compras`. |
| `id_item` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o item associado | Deve existir na tabela `item`. |
| `quantidade_item` | INTEGER | — | Não | Não | Não | Não | 1 | Unidades selecionadas | Deve ser maior que 0. |
| `preco_item` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço unitário no momento da inserção| Histórico de preço de inserção. |
| `desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Abatimento aplicado a este item | Valor nominal de desconto. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Resultado de calculo da linha | `(preco_item - desconto) * quantidade_item`. |
| `data_adicao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Registro do momento da adição | Auditoria de tempo. |

---

### Tabela: `pedido`
**Descrição:** Registra a venda consolidada após o fechamento do checkout.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único numérico do pedido | Número oficial da compra. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK do cliente comprador | Referencia a tabela `cliente`. |
| `id_endereco_entrega`| INTEGER | — | Não | Sim | Não | Não | — | Endereço para envio físico | Referencia a tabela `endereco`. |
| `data_pedido` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora em que a compra fechou | Registrado na finalização. |
| `status_pedido` | VARCHAR | 30 | Não | Não | Não | Não | 'Processando'| Situação da jornada do pedido | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado'. |
| `valor_total` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor bruto original sem deduções | Soma original de todos os itens. |
| `valor_frete` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Custo cobrado pela entrega | Calculado via API de logística. |
| `valor_final` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor líquido real faturado ao cliente| Cálculo final: `valor_total + valor_frete - desconto_aplicado`. |
| `desconto_aplicado`| DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Total de descontos consolidados | Cupons + abatimentos promocionais globais. |
| `prazo_estimado` | VARCHAR | 50 | Não | Não | Sim | Não | — | Prazo prometido de entrega | Ex: '5 dias úteis'. |

---

### Tabela: `item_pedido`
**Descrição:** Linhas de detalhe do pedido. Armazena o histórico imutável dos itens variantes vendidos.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária da linha do item | Identificador do registro físico. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Sim | — | FK do pedido consolidado | Deve pertencer a um registro em `pedido`. |
| `id_item` | INTEGER | — | Não | Sim | Não | Sim | — | FK do item variante específico | Mantém vínculo histórico com `item`. |
| `quantidade` | INTEGER | — | Não | Não | Não | Não | — | Quantidade efetivamente comprada | Valor estritamente maior que zero. |
| `preco_unitario` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço de tabela unitário do item | Valor cheio do item sem os descontos da linha. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor final faturado desta linha | `(preco_unitario - desconto) * quantidade`. |
| `desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Desconto unitário concedido nesta linha| Valor nominal em Reais de desconto por unidade. |

---

### Tabela: `observacoes_cliente`
**Descrição:** Registra notas ou observações textuais personalizadas deixadas pelo cliente associadas a um determinado pedido.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_observacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único da observação | Gerado automaticamente. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido correspondente | Deve existir na tabela `pedido`. |
| `observacao_cliente`| TEXT | — | Não | Não | Não | Não | — | Conteúdo da observação do cliente | Instruções especiais (Ex: "Deixar na portaria"). |

---

### Tabela: `pagamento`
**Descrição:** Controla as transações financeiras, meios e confirmações de pagamento de cada pedido.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pagamento` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador da transação financeira | Código sequencial interno. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido correspondente | Deve existir na tabela `pedido`. |
| `forma_pagamento` | VARCHAR | 50 | Não | Não | Não | Não | — | Meio utilizado para o pagamento | 'Cartao_Credito', 'Boleto', 'Pix'. |
| `valor` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Quantia financeira transacionada | Deve corresponder ao valor alocado para a transação. |
| `data_pagamento` | DATETIME | — | Não | Não | Sim | Não | — | Instante de confirmação bancária | Preenchido quando confirmado pelo gateway. |
| `status` | VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Estado atual do pagamento | 'Pendente', 'Aprovado', 'Recusado', 'Estornado'. |
| `num_transacoes` | INTEGER | — | Não | Não | Não | Não | 1 | Número ou contador sequencial da tentativa| Controle interno de tentativas de pagamento. |
| `quantidade_parcelas`| INTEGER| — | Não | Não | Não | Não | 1 | Número de parcelas da cobrança | Mínimo 1. Relevante para Cartão. |
| `bandeira_cartao` | VARCHAR | 30 | Não | Não | Sim | Não | — | Bandeira emissora do cartão | Ex: 'Visa', 'Mastercard'. |
| `comprovante` | VARCHAR | 255 | Não | Não | Sim | Não | — | Link ou hash do recibo do gateway | Código NSU ou link de autenticação. |

---

### Tabela: `observacoes_financeiras`
**Descrição:** Armazena anotações internas ou auditorias de falhas e logs gerados pelo setor financeiro ou gateway de pagamento.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_observacao_financeira`| INTEGER| — | Sim | Não | Não | Sim | Auto Increment| Identificador único da nota | Gerado automaticamente. |
| `id_pagamento` | INTEGER | — | Não | Sim | Não | Não | — | FK do pagamento correspondente | Deve existir na tabela `pagamento`. |
| `observacao` | TEXT | — | Não | Não | Não | Não | — | Descrição detalhada da ocorrência | Logs de erro, recusa ou auditoria financeira. |

---

### Tabela: `entrega`
**Descrição:** Gerencia a logística de envio, rastreio e entrega física das mercadorias compradas.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_entrega` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único da entrega | Gerado automaticamente. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido correspondente | Deve existir na tabela `pedido`. |
| `transportadora` | VARCHAR | 100 | Não | Não | Não | Não | — | Nome da empresa de logística | Ex: 'Correios', 'Loggi'. |
| `cod_rastreio` | VARCHAR | 50 | Não | Não | Sim | Sim | — | Código de rastreamento do objeto | Único por envio. |
| `data_envio` | DATETIME | — | Não | Não | Sim | Não | — | Data e hora de despacho da mercadoria| Preenchida ao mudar para enviado. |
| `data_prevista` | DATETIME | — | Não | Não | Não | Não | — | Data de previsão limite de entrega | Calculada no checkout. |
| `data_entrega` | DATETIME | — | Não | Não | Sim | Não | — | Data e hora real do recebimento | Preenchida no ato da entrega final. |
| `status_entrega` | VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Estado logístico atual do pacote | 'Pendente', 'Em Transito', 'Entregue', 'Extraviado'. |
| `entregador` | VARCHAR | 100 | Não | Não | Sim | Não | — | Nome do entregador responsável | Opcional (quando aplicável). |
| `custo_frete` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Valor de custo logístico real pago | Custo interno operacional do frete. |
| `historico` | TEXT | — | Não | Não | Sim | Não | — | Logs textuais de atualização de status | Ex: JSON ou texto com pontos de parada. |

---

### Tabela: `avaliacao`
**Descrição:** Reúne as notas quantitativas, comentários qualitativos e status das avaliações dos produtos enviadas pelos clientes.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_avaliacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do comentário | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Sim | — | FK do cliente autor do feedback | Deve constar em `cliente`. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Sim | — | FK do produto macro avaliado | Deve constar em `produto`. |
| `nota` | INTEGER | — | Não | Não | Não | Não | — | Pontuação dada ao produto | Valores válidos inteiros de 1 a 5. |
| `comentario` | TEXT | — | Não | Não | Sim | Não | — | Texto livre com a opinião do cliente | Crítica ou elogio por extenso. |
| `data_avaliacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Dia e hora da postagem | Definido na criação do registro. |
| `status_avaliacao`| VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Situação de moderação | 'Pendente', 'Aprovado', 'Reprovado'. |

---

### Tabela: `registro_interacao`
**Descrição:** Módulo de comportamento. Registra eventos detalhados de rastreamento de navegação e interações de interesse com produtos.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_interacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária do log comportamental | Contador numérico sequencial. |
| `id_cliente` | INTEGER | — | Não | Sim | Sim | Não | — | Usuário logado que gerou o evento | Nulo se for visitante anônimo. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | Produto alvo da ação de navegação | Identifica o produto focado. |
| `data_visualizacao`| DATE | — | Não | Não | Não | Não | (CURRENT_DATE) | Data em que ocorreu o acesso | Data do log. |
| `horario_visualizacao`| TIME | — | Não | Não | Não | Não | (CURRENT_TIME) | Horário exato do acesso | Hora do log. |
| `tempo_interacao` | INTEGER | — | Não | Não | Não | Não | 0 | Tempo gasto na página em segundos | Métrica analítica de interesse. |
| `adicionado_favorito`| BOOLEAN | — | Não | Não | Não | Não | false | Indica se o produto foi favoritado | `true` se adicionou aos favoritos na sessão. |
| `adicionado_carrinho`| BOOLEAN | — | Não | Não | Não | Não | false | Indica se gerou adição ao carrinho | `true` se converteu em intenção de compra. |
| `quantidade_visualizacoes`| INTEGER| — | Não | Não | Não | Não | 1 | Total de repetições na mesma sessão | Quantidade acumulada de acessos à página. |
| `dispositivo_utilizado`| VARCHAR| 50 | Não | Não | Não | Não | — | Plataforma de hardware/software | Ex: 'Desktop_Chrome', 'Mobile_App_iOS'. |

---

### Tabela: `historico_cliente`
**Descrição:** Entidade consolidada de histórico, servindo de trilha de auditoria e centralização de jornadas finalizadas de compras dos clientes.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_compra` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do registro de histórico | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK relacionando o cliente à jornada | Deve existir na tabela `cliente`. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido consolidado e fechado | Deve existir na tabela `pedido`. |
| `id_pagamento` | INTEGER | — | Não | Sim | Sim | Não | — | FK da transação financeira aprovada | Deve existir na tabela `pagamento`. |
| `id_entrega` | INTEGER | — | Não | Sim | Sim | Não | — | FK do fluxo de expedição logística | Deve existir na tabela `entrega`. |

---

## 3. Matriz de Relacionamentos

Mapeamento lógico estruturado de acordo com as restrições e dependências do modelo relacional:

| Tabela Origem | Campo FK | Tabela Destino | Campo PK | Cardinalidade | Descrição |
|---|---|---|---|---|---|
| `endereco` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente pode registrar múltiplos endereços. |
| `categoria` | `categoria_pai` | `categoria` | `id_categoria` | N:1 | Auto-relacionamento estrutural para subcategorias. |
| `produto` | `id_categoria` | `categoria` | `id_categoria` | N:1 | Um produto pertence a uma categoria macro obrigatória. |
| `item` | `id_produto` | `produto` | `id_produto` | N:1 | Um produto macro pode conter várias variações físicas (SKUs). |
| `carrinho_de_compras`| `id_cliente` | `cliente` | `id_cliente` | 1:1 | Cada cliente possui um único carrinho ativo por vez. |
| `item_carrinho` | `id_carrinho` | `carrinho_de_compras`| `id_carrinho` | N:1 | Um carrinho agrupa diversas linhas de itens. |
| `item_carrinho` | `id_produto` | `produto` | `id_produto` | N:1 | Um item adicionado ao carrinho referencia conceitualmente um produto pai. |
| `pedido` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente realiza múltiplos pedidos ao longo do tempo. |
| `pedido` | `id_endereco_entrega`| `endereco` | `id_endereco` | N:1 | Um pedido é despachado para um endereço específico cadastrado. |
| `item_pedido` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido fechado contém um ou mais itens discriminados. |
| `item_pedido` | `id_item` | `item` | `id_item` | N:1 | A linha física do pedido aponta para a variação exata do item vendido. |
| `observacoes_cliente`| `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido pode ter observações ou instruções textuais anexadas. |
| `pagamento` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido pode conter tentativas ou transações de pagamento associadas. |
| `observacoes_financeiras`| `id_pagamento` | `pagamento` | `id_pagamento` | N:1 | Um registro de pagamento pode conter observações ou logs financeiros. |
| `entrega` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido gera uma guia de entrega e rastreamento logístico. |
| `avaliacao` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente pode submeter comentários e notas na plataforma. |
| `avaliacao` | `id_produto` | `produto` | `id_produto` | N:1 | Um produto macro recebe variados feedbacks e notas dos compradores. |
| `registro_interacao`| `id_cliente` | `cliente` | `id_cliente` | N:1 | Registra logs comportamentais de navegação de usuários logados (opcional).|
| `registro_interacao`| `id_produto` | `produto` | `id_produto` | N:1 | Identifica o produto foco das ações de clique ou visualização. |
| `historico_cliente` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Agrupa a linha do tempo e auditoria das compras do cliente. |
| `historico_cliente` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Vincula o pedido concluído ao histórico consolidado do usuário. |
| `historico_cliente` | `id_pagamento` | `pagamento` | `id_pagamento` | N:1 | Associa a transação financeira aprovada ao histórico do cliente. |
| `historico_cliente` | `id_entrega` | `entrega` | `id_entrega` | N:1 | Associa o fluxo de despacho finalizado à linha do tempo do usuário. |

---

## 4. Restrições de Integridade e Domínio (CHECK Constraints)

| Campo | Tipo de Restrição | Valores Permitidos / Regras |
|---|---|---|
| `cliente.status_conta` | Domínio Fixo | 'A' (Ativa), 'I' (Inativa), 'B' (Bloqueada) |
| `categoria.status_categoria`| Domínio Fixo | 'A' (Ativa), 'I' (Inativa) |
| `produto.status_produto` | Domínio Fixo | 'A' (Ativo), 'I' (Inativo) |
| `produto.avaliacao_media` | Intervalo Numérico | Decimal contido e verificado obrigatoriamente entre `0.00` e `5.00` |
| `item.status_item` | Domínio Fixo | 'A' (Ativo), 'I' (Inativo), 'E' (Esgotado) |
| `item.preco` | Verificação Numérica | Deve ser estritamente maior que zero (`> 0.00`) |
| `item.quantidade_restante`| Verificação Numérica | Deve ser maior ou igual a zero (`>= 0`) |
| `item_carrinho.quantidade_item`| Verificação Numérica | Deve ser um valor inteiro maior que zero (`> 0`) |
| `item_pedido.quantidade` | Verificação Numérica | Deve ser um valor inteiro maior que zero (`> 0`) |
| `pedido.status_pedido` | Domínio Fixo | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado' |
| `pedido.valor_final` | Verificação Lógica | Deve corresponder à regra: `(valor_total + valor_frete) - desconto_aplicado` |
| `pagamento.forma_pagamento` | Domínio Fixo | 'Cartao_Credito', 'Boleto', 'Pix' |
| `pagamento.status` | Domínio Fixo | 'Pendente', 'Aprovado', 'Recusado', 'Estornado' |
| `pagamento.quantidade_parcelas`| Verificação Numérica| Deve ser maior ou igual a um (`>= 1`) |
| `entrega.status_entrega` | Domínio Fixo | 'Pendente', 'Em Transito', 'Entregue', 'Extraviado' |
| `avaliacao.nota` | Intervalo Fixo | Número inteiro contido e verificado entre `1` e `5` |
| `avaliacao.status_avaliacao`| Domínio Fixo | 'Pendente', 'Aprovado', 'Reprovado' |