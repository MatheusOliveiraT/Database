DROP TABLE IF EXISTS INSCRICAO_TEM_TURMA;
DROP TABLE IF EXISTS INSCRICAO;
DROP TABLE IF EXISTS TURMA;
DROP TABLE IF EXISTS CURSO_TEM_DISCIPLINA;
DROP TABLE IF EXISTS DISCIPLINA;
DROP TABLE IF EXISTS CURSO;
DROP TABLE IF EXISTS FUNCIONARIO_AUXILIA_PROFESSOR;
DROP TABLE IF EXISTS PROFESSOR;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS ALUNO;
DROP TABLE IF EXISTS PESSOA;

CREATE TABLE PESSOA (
	id INT PRIMARY KEY
);
CREATE TABLE ALUNO (
	id_pessoa INT PRIMARY KEY,
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);
CREATE TABLE FUNCIONARIO (
	id_pessoa INT PRIMARY KEY,
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);
CREATE TABLE PROFESSOR (
	id_pessoa INT PRIMARY KEY,
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);
CREATE TABLE FUNCIONARIO_AUXILIA_PROFESSOR (
	id_funcionario INT,
    id_professor INT,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_pessoa),
    FOREIGN KEY (id_professor) REFERENCES PROFESSOR (id_pessoa),
    PRIMARY KEY (id_funcionario, id_professor)
);
CREATE TABLE CURSO (
	nome VARCHAR(100) PRIMARY KEY
);
CREATE TABLE DISCIPLINA (
	nome1 VARCHAR(100) PRIMARY KEY,
    nome2 VARCHAR(100),
    serial_seq VARCHAR(100),
    FOREIGN KEY (nome2) REFERENCES DISCIPLINA (nome1)
);
CREATE TABLE CURSO_TEM_DISCIPLINA (
	nome_curso VARCHAR(100),
    nome_disciplina VARCHAR(100),
    FOREIGN KEY (nome_curso) REFERENCES CURSO (nome),
    FOREIGN KEY (nome_disciplina) REFERENCES DISCIPLINA (nome1),
    PRIMARY KEY (nome_curso, nome_disciplina)
);
CREATE TABLE TURMA (
	sem_ano DATE,
    nome_curso VARCHAR(100),
    nome_disciplina VARCHAR(100),
    professor_leciona INT,
    FOREIGN KEY (nome_curso, nome_disciplina) REFERENCES CURSO_TEM_DISCIPLINA (nome_curso, nome_disciplina) ON DELETE CASCADE,
    FOREIGN KEY (professor_leciona) REFERENCES PROFESSOR (id_pessoa),
    PRIMARY KEY (sem_ano, nome_curso, nome_disciplina)
);
CREATE TABLE INSCRICAO (
	id INT PRIMARY KEY,
    inicio DATE,
    fim DATE,
    status_insc VARCHAR(20),
    pessoa_insc INT,
    curso_insc VARCHAR(100),
    FOREIGN KEY (pessoa_insc) REFERENCES PESSOA (id),
    FOREIGN KEY (curso_insc) REFERENCES CURSO (nome)
);
CREATE TABLE INSCRICAO_TEM_TURMA (
	id_insc INT,
    sem_ano_turma DATE,
    nome_curso VARCHAR(100),
    nome_disciplina VARCHAR(100),
    nota CHAR(1),
    FOREIGN KEY (id_insc) REFERENCES INSCRICAO (id),
    FOREIGN KEY (sem_ano_turma, nome_curso, nome_disciplina) REFERENCES TURMA (sem_ano, nome_curso, nome_disciplina),
    PRIMARY KEY (id_insc, sem_ano_turma, nome_curso, nome_disciplina)
);