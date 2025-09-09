DROP TABLE IF EXISTS REPARO_TEM_PECA;
DROP TABLE IF EXISTS PECA;
DROP TABLE IF EXISTS FUNCIONARIO_FAZ_REPARO;
DROP TABLE IF EXISTS REPARO;
DROP TABLE IF EXISTS CLIENTE_TEM_VEICULO;
DROP TABLE IF EXISTS VEICULO;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS CATEGORIA;

CREATE TABLE CATEGORIA (
	nome VARCHAR(100) PRIMARY KEY,
    custo DECIMAL(10,2)
);
CREATE TABLE FUNCIONARIO (
	id INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(9),
    endereco VARCHAR(200),
    nome_categoria VARCHAR(100),
    FOREIGN KEY (nome_categoria) REFERENCES CATEGORIA (nome)
);
CREATE TABLE CLIENTE (
	id INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(9),
    endereco VARCHAR(200)
);
CREATE TABLE VEICULO (
	placa VARCHAR(8) PRIMARY KEY
);
CREATE TABLE CLIENTE_TEM_VEICULO (
	id_cliente INT,
    placa_veiculo VARCHAR(8),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id),
    FOREIGN KEY (placa_veiculo) REFERENCES VEICULO (placa),
    PRIMARY KEY (id_cliente, placa_veiculo)
);
CREATE TABLE REPARO (
	id INT PRIMARY KEY,
    custo DECIMAL(10,2),
    data_reparo DATE,
    placa_veiculo VARCHAR(8),
    id_cliente INT,
    FOREIGN KEY (id_cliente, placa_veiculo) REFERENCES CLIENTE_TEM_VEICULO (id_cliente, placa_veiculo)
);
CREATE TABLE FUNCIONARIO_FAZ_REPARO (
	id_funcionario INT,
    id_reparo INT,
    tempo TIME,
    custo_mao_de_obra DECIMAL(10,2),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id),
    FOREIGN KEY (id_reparo) REFERENCES REPARO (id),
    PRIMARY KEY (id_funcionario, id_reparo)
);
CREATE TABLE PECA (
	codigo INT PRIMARY KEY,
    designacao VARCHAR(100),
    custo DECIMAL(10,2),
    quantidade INT
);
CREATE TABLE REPARO_TEM_PECA (
	codigo_peca INT,
    id_reparo INT,
    custo DECIMAL(10,2),
    FOREIGN KEY (codigo_peca) REFERENCES PECA (codigo),
    FOREIGN KEY (id_reparo) REFERENCES REPARO (id),
    PRIMARY KEY (codigo_peca, id_reparo)
);