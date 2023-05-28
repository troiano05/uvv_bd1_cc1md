--ESTE É O SCRIPT DE CRIAÇÃO DO BANCO DE DADOS "LOJAS UVV" PROJETADO NO PostgreSQLM PARA RESOLUÇÃO DO Pset1.
-- Heitor Damasceno Oliveira Ortega Soares - cc1md.

--CRIANDO O USUÁRIO
--MEDIDAS DE SEGURANÇA: Conferir se já não existe um usuário e banco de dados com o mesmo nome, se sim, deletá-los.
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS heitor;

--CRIANDO O USUÁRIO E ATRIBUINDO PERMISSÕES
CREATE USER heitor WITH 
        createdb 
        createrole 
        encrypted password '123senha';

--CRIANDO O BANCO DE DADOS E CONFIGURANDO-O
CREATE DATABASE uvv WITH 
          owner = heitor
          encoding = "UTF8"
          lc_collate = 'pt_BR.UTF-8'
          lc_ctype = 'pt_BR.UTF-8'
          allow_connections = TRUE;

--COMENTÁRIO NO BANCO DE DADOS CRIADO
COMMENT ON DATABASE uvv IS 'Banco de Dados gerado e estruturado para se adequar as exigências do Pset.';

--ESTABELECENDO A CONEXÃO COM O BANCO DE DADOS E COM O USUÁRIO CRIADOS.
\setenv PGPASSWORD 123senha
\c uvv heitor;

--CRIANDO O ESQUEMA DENTRO DO BANCO DE DADOS.
CREATE SCHEMA IF NOT EXISTS lojas
AUTHORIZATION heitor;

--COMENTÁRIO NO SCHEMA CRIADO
COMMENT ON SCHEMA lojas IS 'Schema criado especificamente para a realização do projeto do Pset.';

--DEFININDO O SCHEMA LOJAS COMO O CAMINHO PRINCIPAL
ALTER USER heitor
SET SEARCH_PATH TO lojas, "$user", public;

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20) NOT NULL,
                telefone2 VARCHAR(20) NOT NULL,
                telefone3 VARCHAR(20) NOT NULL,
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
--COMENTÁRIOS DA TABELA CLIENTES
COMMENT ON TABLE lojas.clientes IS 'Comando que cria a tabela de clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Comando que cria a coluna que serve de PK na tabela clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Comando que cria a coluna contendo o email de cada cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Comando que cria a coluna que contém o nome de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Comando que cria a coluna com a primeira opção de telefone de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Comando que cria a coluna com a segunda opção de telefone de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Comando que cria a coluna com a terceira opção de telefone de cada cliente.';


CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                detalhes BYTEA NOT NULL,
                imagem BYTEA NOT NULL,
                imagem_mime_type VARCHAR(512) NOT NULL,
                imagem_arquivo VARCHAR(512) NOT NULL,
                imagem_charset VARCHAR(512) NOT NULL,
                imagem_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

--COMENTÁRIOS DA TABELA PRODUTOS
COMMENT ON TABLE lojas.produtos IS 'Comando que cria a tabela produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Comando que cria a coluna que serve de PK para a tabela de produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Comando que cria a coluna com os nomes de cada produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Comando que cria a coluna com o preço de cada produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Comando que gera a coluna com os detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Comando que cria uma coluna que contém a imagem de cada produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Comando que cria a coluna imagem_mime_type na tabela de produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Comando que cria a coluna com os arquivos que contém a imagem de cada produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Comando que cria a coluna imagem_charset na tabela de produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Comando que cria a coluna que contém da última atualização das imagens dos produtos.';


CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100) NOT NULL,
                endereco_fisico VARCHAR(512) NOT NULL,
                latitude NUMERIC NOT NULL,
                longitude NUMERIC NOT NULL,
                logo BYTEA NOT NULL,
                logo_mime_type VARCHAR(512) NOT NULL,
                logo_arquivo VARCHAR(512) NOT NULL,
                logo_charset VARCHAR(512) NOT NULL,
                logo_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);

--COMENTÁRIOS DA TABELA LOJAS
COMMENT ON TABLE lojas.lojas IS 'Comando que cria a tabela que contém as lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Comando que cria a coluna que serve como PK para a tabela de lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Comando que cria a coluna dos nomes das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Comando que cria a coluna que contém os nomes dos endereços web das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Comando que cria a coluna com o endereço físico das lojas.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Comando que cria a coluna que contém a latitude de cada loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Comando que cria a coluna que contém a longitude de cada loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Comando que cria a coluna que contém a logo de cada loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Comando que cria a coluna logo_mime_type na tabela de lojas.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Comando que cria a coluna que contém os arquivos com a logo de cada loja.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Comando que cria a coluna logo_charset na tabela de lojas.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Comando que cria a coluna que contém a data das atualizações de cada logo.';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

--COMENTÁRIOS DA TABELA PEDIDOS
COMMENT ON TABLE lojas.pedidos IS 'Comando que cria a tabela com os pedidos.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Comando que cria a coluna que serve de PK para a tabela de pedidos.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Comando que cria a coluna que contém a data e hora em que foi feito cada pedido. ';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Comando que cria a coluna com o id de cada cliente. Serve como FK na tabela pedidos.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Comando que cria a coluna contendo o status de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Comando que cria a coluna com o id de cada loja. Serve como FK na tabela pedidos.';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

--COMENTÁRIOS DA TABELA ENVIOS
COMMENT ON TABLE lojas.envios IS 'Comando que cria a tabela com os envios.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Comando que cria a coluna que serve de PK para a tabela envios.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Comando que cria a coluna que contém o id de cada lojas. Serve como FK na tabela de envios.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Comando que cria a coluna com o id de cada cliente. Serve de FK na tabela envios.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Comando que cria a coluna que contém os endereços de entrega.';
COMMENT ON COLUMN lojas.envios.status IS 'Comando que cria a coluna com o status de cada envio.';


CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

--COMENTÁRIOS DA TABELA PEDIDOS_ITENS
COMMENT ON TABLE lojas.pedidos_itens IS 'Comando que cria a tabela que contém os itens de cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Comando que cria uma das colunas que serve como PK da tabela pedidos_itens.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Comando que cria a outra coluna que serve de PK para a tabela pedidos_itens.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Comando que cria a coluna que tem os números de linha.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Comando que contém o preço unitário de cada item do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Comando que cria a coluna que contém a quantidade de cada produto de cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Comando que cria a coluna que contém o id de cada envio. Serve como FK na tabela pedidos_itens.';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

--COMENTÁRIOS DA TABELA ESTOQUES
COMMENT ON TABLE lojas.estoques IS 'Comando que cria a tabela de estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Comando que cria a coluna que serve de PK para a tabela de estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Comando que cria a coluna com o id de cada loja. Serve como FK na tabela de estoques.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Comando que cria a coluna com o id de cada produto. Serve como FK da tabela de estoques.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Comando que cria a coluna que contém a quantidade de cada produto em estoque.';

--CRIANDO OS RELACIONAMENTOS ENTRE AS TABELAS

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS ENVIOS E CLIENTES.
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS PEDIDOS E CLIENTES.
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS ESTOQUES E PRODUTOS.
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS PEDIDOS_ITENS E PRODUTOS.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS ESTOQUES E LOJAS.
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS ENVIOS E LOJAS.
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS PEDIDOS E LOJAS.
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS PEDIDOS_ITENS E PEDIDOS.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ESTABELECENDO O RELACIONAMENTO ENTRE AS TABELAS PEDIDOS_ITENS E ENVIOS.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO AS CONSTRAINTS DE CHECAGEM: Garantem que os dados tenham coerência lógica.

--CRIANDO AS CONSTRAINTS PARA O CAMPO "STATUS" NAS TABELAS PEDIDOS E ENVIOS.
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK(status IN('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK(status IN('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));

--CRIANDO AS CONSTRAINTS QUE IMPEDEM QUE O VALOR DO CAMPO "QUANTIDADE" SEJA NEGATIVO NAS TABELAS PREDIDOS_ITENS E ESTOQUES.
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK(quantidade > 0);

ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK(quantidade > 0);

--CRIANDO A CONSTRAINT QUE OBRIGA QUE AO MENOS UM DOS ENDEREÇOS DA TABELA LOJAS SEJA PREENCHIDO.
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco
CHECK(endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

--CRIANDO AS CONSTRAINTS QUE IMPEDEM QUE O VALOR DO CAMPO "preco_unitario" SEJA NEGATIVO NAS TABELAS PRODUTOS E ITENS.
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK(preco_unitario > 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK(preco_unitario > 0);