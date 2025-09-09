DROP TABLE IF EXISTS ALUNOS;
DROP TABLE IF EXISTS CURSOS;
DROP TABLE IF EXISTS DEPARTAMENTOS;

CREATE TABLE DEPARTAMENTOS (
	Código INTEGER,
    Detalhes VARCHAR(200) NOT NULL,
    PRIMARY KEY(Código)
);

CREATE TABLE CURSOS (
	Nome VARCHAR(200),
    Código_Departamento INTEGER,
    PRIMARY KEY(Nome),
    FOREIGN KEY(Código_Departamento) REFERENCES DEPARTAMENTOS(Código)
);

CREATE TABLE ALUNOS (
	Número INTEGER PRIMARY KEY,
    Nome VARCHAR(200),
    Nome_Curso VARCHAR(200),
    FOREIGN KEY(Nome_Curso) REFERENCES CURSOS(Nome)
);

INSERT INTO DEPARTAMENTOS
	VALUES ('1', 'DACOM'),
		   ('2', 'DAMAT');

INSERT INTO CURSOS
	VALUES ('Ciência da Computação', '1'),
		   ('Estatística', '2'),
           ('Matemática', '2');

INSERT INTO ALUNOS
	VALUES ('1', 'Connor', 'Matemática'),
		   ('2', 'Vivian', 'Matemática'),
           ('3', 'Taís', 'Estatística'),
           ('4', 'Maria Gabriela', 'Estatística'),
           ('5', 'Matheus', 'Ciência da Computação'),
           ('6', 'Anna Luiza', 'Ciência da Computação');