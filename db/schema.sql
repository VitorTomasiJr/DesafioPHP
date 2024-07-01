CREATE TABLE produto_tipo (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    perc_imposto DECIMAL(5, 2) NOT NULL,
    ativo CHAR(1) NOT NULL DEFAULT 'S'
);

CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    produto_tipo_id INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ativo CHAR(1) NOT NULL DEFAULT 'S',
    FOREIGN KEY (produto_tipo_id) REFERENCES produto_tipo(id)
);

CREATE TABLE venda (
    id SERIAL PRIMARY KEY,
    total_venda DECIMAL(10, 2) NOT NULL,
    total_imposto DECIMAL(10, 2) NOT NULL
);

CREATE TABLE venda_itens (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade DECIMAL(10, 2) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    perc_imposto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES venda(id),
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);