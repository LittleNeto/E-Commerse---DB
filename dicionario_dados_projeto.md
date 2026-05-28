# Dicionário de Dados - Sistema de E-commerce

Este documento apresenta o Dicionário de Dados do projeto de Banco de Dados, estruturado a partir do Modelo Entidade-Relacionamento (MER) fornecido. A padronização e os tipos de dados seguem estritamente as diretrizes e convenções estabelecidas no modelo de referência.

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
| `data_nascimento` | DATE | — | Não | Não | Não | Não | — | Data de nascimento | Deve ser menor que a data atual (maioridade dependendo da regra). |
| `sexo` | CHAR | 1 | Não | Não | Sim | Não | — | Gênero biológico/identificado | Valores: 'M', 'F', 'O' (Masculino, Feminino, Outro). |
| `telefone` | VARCHAR | 20 | Não | Não | Não | Não | — | Telefone celular ou fixo | Formato com DDD (apenas números). |
| `email` | VARCHAR | 120 | Não | Não | Não | Sim | — | Endereço de e-mail | Deve possuir formato eletrônico válido (`@`). |
| `senha_acesso` | VARCHAR | 255 | Não | Não | Não | Não | — | Senha criptografada | Armazenada obrigatoriamente com hash seguro (ex: bcrypt). |
| `data_cadastro` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora de criação da conta | Preenchida automaticamente no cadastro. |
| `status_conta` | CHAR | 1 | Não | Não | Não | Não | 'A' | Situação atual da conta | 'A' = Ativo, 'I' = Inativo, 'B' = Bloqueado. |
| `foto_perfil` | VARCHAR | 255 | Não | Não | Sim | Não | — | URL ou caminho da foto de perfil | String apontando para o storage de imagens. |
| `preferencias_compra` | TEXT | — | Não | Não | Sim | Não | — | Interesses e tags de preferência | Estrutura de texto ou JSON com categorias preferidas. |

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
| `descricao_categoria` | TEXT | — | Não | Não | Sim | Não | — | Detalhamento do escopo da categoria | Explicação sobre quais itens pertencem a ela. |
| `pai_id_categoria` | INTEGER | — | Não | Sim | Sim | Não | — | Auto-relacionamento (subcategoria) | Referencia a categoria pai (`id_categoria`). Nulo se for raiz. |

---

### Tabela: `produto`
**Descrição:** Entidade principal do catálogo que centraliza as informações mercadológicas, físicas, de estoque e precificação dos produtos.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_produto` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do produto | Gerado automaticamente. |
| `sku` | VARCHAR | 50 | Não | Não | Não | Sim | — | Stock Keeping Unit (Código de estoque) | Código identificador comercial único do produto. |
| `nome_produto` | VARCHAR | 150 | Não | Não | Não | Não | — | Nome comercial do produto | Título que aparece para o usuário. |
| `descricao` | TEXT | — | Não | Não | Não | Não | — | Descrição detalhada do produto | Ficha técnica, características gerais e uso. |
| `marca` | VARCHAR | 50 | Não | Não | Não | Não | — | Fabricante ou marca do produto | Ex: 'Sony', 'Nike', 'Samsung'. |
| `tamanho` | VARCHAR | 20 | Não | Não | Sim | Não | — | Dimensão de vestuário ou escala | Ex: 'P', 'M', 'G', '42', 'U'. |
| `cor` | VARCHAR | 30 | Não | Não | Sim | Não | — | Cor predominante do item | Ex: 'Preto', 'Azul Marinho'. |
| `preco_custo` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço de aquisição do item | Valor monetário de custo. Deve ser > 0. |
| `preco_venda` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço final praticado na loja | Valor de venda. Deve ser maior que zero. |
| `dimensoes` | VARCHAR | 50 | Não | Não | Sim | Não | — | Altura x Largura x Profundidade | Formato texto ou string padrão para cálculo de frete. |
| `peso` | DECIMAL | 8,3 | Não | Não | Sim | Não | — | Peso do produto em quilogramas | Usado no cálculo do frete (Ex: 1.250 para 1.25kg). |
| `estoque_atual` | INTEGER | — | Não | Não | Não | Não | 0 | Quantidade disponível para venda | Não pode ser negativa. |
| `estoque_minimo` | INTEGER | — | Não | Não | Não | Não | 5 | Limite mínimo para alerta de reposição | Dispara avisos internos ao atingir o valor. |
| `status_produto` | CHAR | 1 | Não | Não | Não | Não | 'A' | Estado de ativação no catálogo | 'A' = Ativo, 'I' = Inativo, 'F' = Fora de Estoque. |
| `avaliacao_media` | DECIMAL | 3,2 | Não | Não | Não | Não | 0.00 | Média de notas recebidas | Calculada dinamicamente entre 1.00 e 5.00. |
| `id_categoria` | INTEGER | — | Não | Sim | Não | Não | — | FK para classificação do produto | Deve existir na tabela `categoria`. |
| `imagem_principal` | VARCHAR | 255 | Não | Não | Não | Não | — | URL da foto em destaque do produto | Caminho da imagem principal para o feed. |

---

### Tabela: `carrinho_compras`
**Descrição:** Instância temporária ou persistente que agrupa os itens selecionados pelo cliente antes da conversão em pedido.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_carrinho` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do carrinho | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Sim | — | Cliente proprietário do carrinho | Relação 1:1 ativa por cliente. |
| `data_criacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Momento em que o carrinho foi aberto | Preenchido automaticamente. |
| `data_atualizacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Última alteração de itens | Atualizado a cada inserção/remoção. |
| `status_carrinho` | VARCHAR | 20 | Não | Não | Não | Não | 'Aberto' | Estado atual do carrinho | 'Aberto', 'Convertido', 'Abandonado'. |

---

### Tabela: `item_carrinho`
**Descrição:** Tabela associativa que discrimina os produtos adicionados a um carrinho de compras específico e suas respectivas quantidades.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_carrinho`| INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do item no carrinho| Gerado automaticamente. |
| `id_carrinho` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o carrinho de origem | Deve existir na tabela `carrinho_compras`. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK identificando o produto escolhido | Deve existir na tabela `produto`. |
| `quantidade` | INTEGER | — | Não | Não | Não | Não | 1 | Unidades selecionadas do produto | Deve ser um valor inteiro maior que 0. |
| `preco_unitario` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço de venda no momento da inserção | Congela o preço para fins de visualização. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Resultado de `quantidade * preco_unitario` | Calculado ou atualizado por gatilhos. |
| `data_inclusao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Registro de quando o item foi insercido | Auditoria interna de tempo. |

---

### Tabela: `pedido`
**Descrição:** Registra a venda consolidada após o fechamento do checkout, contendo valores consolidados, prazos e os endereços de destino finais.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único numérico do pedido | Número oficial da compra. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK do cliente comprador | Referencia o comprador na tabela `cliente`. |
| `id_endereco_entrega`| INTEGER | — | Não | Sim | Não | Não | — | Endereço para envio físico da compra | Referencia a tabela `endereco`. |
| `data_pedido` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Data e hora em que a compra fechou | Registrado na finalização do checkout. |
| `status_pedido` | VARCHAR | 30 | Não | Não | Não | Não | 'Processando'| Situação da jornada do pedido | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado'. |
| `valor_total` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Valor bruto final a ser pago | Soma dos itens + frete - descontos. |
| `valor_frete` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Custo cobrado pela entrega | Calculado via API de logística. |
| `valor_desconto` | DECIMAL | 15,2 | Não | Não | Não | Não | 0.00 | Deduções aplicadas por cupons/ações | Deve ser maior ou igual a zero. |

---

### Tabela: `item_pedido`
**Descrição:** Linhas de detalhe do pedido. Armazena o histórico imutável dos produtos vendidos, quantidades e preços praticados no ato exato da compra.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_item_pedido` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária da linha do item | Identificador do registro físico. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido consolidado | Deve pertencer a um registro em `pedido`. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK do produto comercializado | Mantém vínculo histórico com `produto`. |
| `quantidade` | INTEGER | — | Não | Não | Não | Não | — | Quantidade efetivamente comprada | Valor estritamente maior que zero. |
| `preco_unitario` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Preço final unitário vendido | Valor fixado com descontos diretos aplicados. |
| `subtotal` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Multiplicação de `quantidade * preco_unitario`| Valor imutável pós-venda. |

---

### Tabela: `pagamento`
**Descrição:** Controla as tentativas, transações, parcelamentos e as confirmações financeiras de cada pedido realizado.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_pagamento` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador da transação financeira | Código sequencial interno. |
| `id_pedido` | INTEGER | — | Não | Sim | Não | Não | — | FK do pedido correspondente | Relação N:1 (permite re-tentativas). |
| `forma_pagamento` | VARCHAR | 50 | Não | Não | Não | Não | — | Meio utilizado para o pagamento | 'Cartao_Credito', 'Boleto', 'Pix'. |
| `status_pagamento`| VARCHAR | 30 | Não | Não | Não | Não | 'Pendente' | Estado atual da cobrança bancária | 'Pendente', 'Aprovado', 'Recusado', 'Estornado'. |
| `valor_pago` | DECIMAL | 15,2 | Não | Não | Não | Não | — | Quantia financeira transacionada | Deve bater com o `valor_total` do pedido. |
| `data_pagamento` | DATETIME | — | Não | Não | Sim | Não | — | Instante de confirmação da operadora | Preenchido apenas quando aprovado. |
| `parcelas` | INTEGER | — | Não | Não | Não | Não | 1 | Número de divisões da cobrança | Mínimo 1. Relevante para Cartão de Crédito. |
| `comprovante` | VARCHAR | 255 | Não | Não | Sim | Não | — | Código ou link do recibo do gateway | Código NSU ou link de autenticação. |

---

### Tabela: `avaliacao`
**Descrição:** Reúne as notas quantitativas e os comentários qualitativos fornecidos pelos clientes sobre os produtos adquiridos.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_avaliacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Identificador único do comentário | Gerado automaticamente. |
| `id_cliente` | INTEGER | — | Não | Sim | Não | Não | — | FK do cliente autor do feedback | Deve constar em `cliente`. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | FK do produto que recebeu a nota | Deve constar em `produto`. |
| `nota` | INTEGER | — | Não | Não | Não | Não | — | Pontuação dada ao produto pelo usuário | Valores válidos inteiros de 1 a 5. |
| `comentario` | TEXT | — | Não | Não | Sim | Não | — | Texto livre com a opinião do cliente | Crítica ou elogio por extenso. |
| `data_avaliacao` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Dia e hora da postagem da avaliação | Definido na criação do registro. |

---

### Tabela: `registro_interacao`
**Descrição:** Módulo de comportamento. Registra eventos de rastreamento de navegação, visualizações e cliques de usuários para inteligência de dados e recomendações.

| Campo | Tipo de Dado | Tamanho | PK | FK | Nulo | Único | Default | Descrição | Regra de Negócio / Domínio |
|---|---|---|---|---|---|---|---|---|---|
| `id_interacao` | INTEGER | — | Sim | Não | Não | Sim | Auto Increment | Chave primária do log comportamental | Contador numérico sequencial. |
| `id_cliente` | INTEGER | — | Não | Sim | Sim | Não | — | Usuário logado que gerou o evento | Nulo se for visitante anônimo. |
| `id_produto` | INTEGER | — | Não | Sim | Não | Não | — | Produto alvo da ação de navegação | Identifica o item focado. |
| `tipo_interacao` | VARCHAR | 50 | Não | Não | Não | Não | — | Natureza do clique ou ação | 'Visualizacao', 'Adicionar_Favorito', 'Clique_Banner'. |
| `data_hora` | DATETIME | — | Não | Não | Não | Não | CURRENT_TIMESTAMP | Momento exato da ocorrência da ação| Registrador temporal de alta precisão. |
| `dispositivo` | VARCHAR | 50 | Não | Não | Não | Não | — | Plataforma de hardware/software | Ex: 'Desktop_Chrome', 'Mobile_App_iOS'. |

---

## 3. Matriz de Relacionamentos

A tabela abaixo consolida todas as chaves estrangeiras (`FK`) mapeadas diretamente do modelo lógico visual do diagrama:

| Tabela Origem | Campo FK | Tabela Destino | Campo PK | Cardinalidade | Descrição |
|---|---|---|---|---|---|
| `endereco` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente pode cadastrar múltiplos endereços de entrega. |
| `categoria` | `pai_id_categoria` | `categoria` | `id_categoria` | N:1 (Auto) | Uma subcategoria pertence a uma categoria pai na hierarquia. |
| `produto` | `id_categoria` | `categoria` | `id_categoria` | N:1 | Um produto está categorizado obrigatoriamente em uma categoria. |
| `carrinho_compras`| `id_cliente` | `cliente` | `id_cliente` | 1:1 | Cada cliente possui apenas um carrinho de compras ativo por sessão. |
| `item_carrinho` | `id_carrinho` | `carrinho_compras` | `id_carrinho` | N:1 | Um carrinho agrupa várias linhas de itens de produtos. |
| `item_carrinho` | `id_produto` | `produto` | `id_produto` | N:1 | Uma linha de item de carrinho aponta para um produto específico. |
| `pedido` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente realiza um ou mais pedidos na plataforma. |
| `pedido` | `id_endereco_entrega`| `endereco` | `id_endereco` | N:1 | Um pedido possui um endereço fixo de destino para entrega. |
| `item_pedido` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido consolidado contém um ou mais itens comprados. |
| `item_pedido` | `id_produto` | `produto` | `id_produto` | N:1 | O item de um pedido faz referência ao catálogo de produtos. |
| `pagamento` | `id_pedido` | `pedido` | `id_pedido` | N:1 | Um pedido pode ter tentativas de pagamento (gerando históricos). |
| `avaliacao` | `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente pode submeter feedbacks sobre suas compras. |
| `avaliacao` | `id_produto` | `produto` | `id_produto` | N:1 | Um produto recebe múltiplas avaliações quantitativas de clientes.|
| `registro_interacao`| `id_cliente` | `cliente` | `id_cliente` | N:1 | Um cliente logado gera rastros de cliques e comportamento. |
| `registro_interacao`| `id_produto` | `produto` | `id_produto` | N:1 | Um produto recebe cliques e visualizações na navegação. |

---

## 4. Restrições de Integridade e Domínio

### Restrições de Verificação (`CHECK Constraints` / Domínios)

| Campo | Tipo de Restrição | Valores Permitidos / Regras |
|---|---|---|
| `cliente.status_conta` | Domínio Fixo | 'A' (Ativo), 'I' (Inativo), 'B' (Bloqueado) |
| `cliente.sexo` | Domínio Fixo | 'M' (Masculino), 'F' (Feminino), 'O' (Outro) |
| `produto.preco_venda` | Verificação Numérica | Deve ser estritamente maior que zero (`> 0.00`) |
| `produto.estoque_atual` | Verificação Numérica | Deve ser maior ou igual a zero (`>= 0`) |
| `avaliacao.nota` | Intervalo Fixo | Número inteiro contido entre `1` e `5` |
| `carrinho_compras.status_carrinho` | Domínio Fixo | 'Aberto', 'Convertido', 'Abandonado' |
| `pedido.status_pedido` | Domínio Fixo | 'Processando', 'Pago', 'Enviado', 'Entregue', 'Cancelado' |
| `pagamento.forma_pagamento` | Domínio Fixo | 'Cartao_Credito', 'Boleto', 'Pix' |

---

### Diretrizes de Integridade Referencial (Ações de Chaves Estrangeiras)

| Chave Estrangeira (FK) | Ação em `ON DELETE` | Ação em `ON UPDATE` | Justificativa de Negócio |
|---|---|---|---|
| `endereco.id_cliente` | `CASCADE` | `CASCADE` | Ao deletar um cliente da base, seus endereços associados perdem sentido e devem ser limpos. |
| `produto.id_categoria` | `RESTRICT` | `CASCADE` | Uma categoria não pode ser removida se houver qualquer produto ativamente vinculado a ela. |
| `pedido.id_cliente` | `RESTRICT` | `CASCADE` | Proibido deletar um registro de cliente que possua pedidos consolidados por motivos fiscais. |
| `item_pedido.id_pedido` | `CASCADE` | `CASCADE` | Se um rascunho de pedido for excluído, todos os seus itens filhos devem sumir em cascata. |
| `item_pedido.id_produto` | `RESTRICT` | `CASCADE` | Impedir a deleção física de um produto do catálogo se ele já tiver sido vendido em algum pedido. |
