DROP TABLE IF EXISTS PEDIDO_TEM_PIZZA;
DROP TABLE IF EXISTS PEDIDO;
DROP TABLE IF EXISTS CLIENTE, ENTREGADOR, ATENDENTE;
DROP TABLE IF EXISTS PIZZA_TEM_TAMANHO;
DROP TABLE IF EXISTS TAMANHO, PIZZA, BAIRRO, FUNCIONARIO;

CREATE TABLE PIZZA (
	num INT PRIMARY KEY,
    nome VARCHAR(100),
    ingredientes TEXT
);
CREATE TABLE TAMANHO (
	nome VARCHAR(100) PRIMARY KEY
);
CREATE TABLE PIZZA_TEM_TAMANHO (
	num INT,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    PRIMARY KEY (num, nome),
    FOREIGN KEY (num) REFERENCES PIZZA (num),
    FOREIGN KEY (nome) REFERENCES TAMANHO (nome)
);
CREATE TABLE BAIRRO (
	nome VARCHAR(100) PRIMARY KEY,
    tempo TIME
);
CREATE TABLE CLIENTE (
	telefone CHAR (9) PRIMARY KEY,
    nome VARCHAR(100),
    nome_bairro VARCHAR(100),
    FOREIGN KEY (nome_bairro) REFERENCES BAIRRO (nome)
);
CREATE TABLE FUNCIONARIO (
	id INT PRIMARY KEY
);
CREATE TABLE ENTREGADOR (
	telefone CHAR(9),
    id_entregador INT PRIMARY KEY,
    FOREIGN KEY (id_entregador) REFERENCES FUNCIONARIO (id)
);
CREATE TABLE ATENDENTE (
	id_atendente INT PRIMARY KEY,
    FOREIGN KEY (id_atendente) REFERENCES FUNCIONARIO (id)
);
CREATE TABLE PEDIDO (
	num INT PRIMARY KEY,
    data_pedido DATE,
    endereco VARCHAR(200),
    telefone_cliente CHAR(9),
    id_entregador INT,
    id_atendente INT,
    FOREIGN KEY (telefone_cliente) REFERENCES CLIENTE (telefone),
    FOREIGN KEY (id_entregador) REFERENCES ENTREGADOR (id_entregador),
    FOREIGN KEY (id_atendente) REFERENCES ATENDENTE (id_atendente)
);
CREATE TABLE PEDIDO_TEM_PIZZA (
	num_pedido INT,
    num_pizza INT,
    nome_tamanho VARCHAR(100),
    quantidade INT,
    PRIMARY KEY (num_pedido, num_pizza, nome_tamanho),
    FOREIGN KEY (num_pedido) REFERENCES PEDIDO (num),
    FOREIGN KEY (num_pizza, nome_tamanho) REFERENCES PIZZA_TEM_TAMANHO (num, nome)
);
