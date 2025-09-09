-- Selecione todos alunos que são menores do que 20 anos e são do nível 'JR'

SELECT *
FROM ALUNO
WHERE idade < 20 AND nivel = 'JR';

-- Selecione os professores que são do departamento  68

SELECT *
FROM PROFESSOR
WHERE idDepto = 68;

-- Selecione os alunos que se matricularam em curso de 'Database Systems'

SELECT A.nroAlun
FROM ALUNO A, MATRICULADO M
WHERE M.nroAlun = A.nroAlun AND nomeCurso = 'Database Systems';

-- Selecione os nomes dos professores que ministraram algum curso na sala '20 AVW'

SELECT P.nomeProf
FROM PROFESSOR P, CURSO C
WHERE P.idprof = C.idprof AND sala = '20 AVW';

-- Selecione o nivel dos alunos (sem repetição) que cursaram algum curso na sala '20 AVW'

SELECT DISTINCT A.nivel
FROM ALUNO A, CURSO C, MATRICULADO M
WHERE A.nroAlun = M.nroALun AND M.nomeCurso = C.nome AND sala = '20 AVW';

-- Liste o nome do alunos e o nome da formação cuja formação contenha a string 'cie'

SELECT nomeAlun, formacao
FROM ALUNO
WHERE formacao LIKE '%cie%';

-- Conte o número de alunos.

SELECT COUNT(*) AS 'NUMERO'
FROM ALUNO;

-- Quantas matrículas há no curso com nome 'Database Systems'

SELECT COUNT(*) AS 'MATRICULAS EM DB SYSTEM'
FROM MATRICULADO
WHERE nomeCurso = 'Database Systems';

-- Selecione o nome de todos os professores dos departamentos 68 e 12.

SELECT nomeProf
FROM PROFESSOR
WHERE idDepto = 68 OR idDepto = 12;

-- Selecione o nome dos professores que deram aulas no curso com 
-- 'Database Systems' ou são do departamento 68.

SELECT DISTINCT nomeProf
FROM PROFESSOR P, CURSO C
WHERE C.idProf = P.idProf AND C.nome = 'Database Systems' OR idDepto = 68;

-- Selecione o número dos alunos com formação 'Computer Science' ou que 
-- fizeram o curso de 'Database Systems'.

SELECT nroAlun FROM ALUNO WHERE formacao = 'Computer Science'
UNION
SELECT nroAlun FROM ALUNO WHERE formacao = 'Database Systems';

-- Selecione todos alunos matriculados que são menores do que 20 anos e 
-- são do nível 'JR'*/

SELECT *
FROM ALUNO A, MATRICULADO M
WHERE M.nroAlun = A.nroAlun AND A.idade < 20 AND nivel = 'JR';
    
-- Selecione os professores que ministraram algum curso e que são do departamento 12

SELECT *
FROM PROFESSOR P, CURSO C
WHERE P.idProf = C.idProf AND P.idDepto = 12;

-- Selecione os nomes (alunos) que se matricularam em curso de 'Database Systems'

SELECT A.nomeAlun
FROM Aluno A, Matriculado M
WHERE M.nroAlun = A.nroAlun AND M.nomeCurso = 'Database Systems';

-- Selecione os nomes dos professores sem repetição que ministraram algum curso na sala '20 AVW'

SELECT nomeProf FROM PROFESSOR
WHERE idProf IN(SELECT idProf
				FROM CURSO
				WHERE sala = '20 AVW');

-- Encontre os nomes de todos os Juniors (nível = JR) que 
-- estão matriculados em um curso ministrado por Ivana Teach.

SELECT nomeAlun
FROM Aluno A, Matriculado M, Curso C, Professor P
WHERE A.nroAlun = M.nroAlun 
	AND M.nomeCurso = C.nome 
    AND C.idProf = P.idProf 
    AND P.nomeProf = 'Ivana Teach' 
    AND A.nivel = 'JR';

-- Encontre a idade do aluno mais velho matriculado em um 
-- curso ministrado por Ivana Teach.

SELECT MAX(idade)
FROM Aluno A, Matriculado M, Curso C, Professor P
WHERE A.nroAlun = M.nroAlun 
		AND M.nomeCurso = C.nome 
		AND C.idProf = P.idProf 
		AND P.nomeProf = 'Ivana Teach';
      
-- Liste os nomes dos cursos sem repetições que possuam alunos matriculados e 
-- sejam ministrados na sala '20 AVW'


-- Encontre os números dos alunos sem repetição que estão matriculados 
-- pelo menos dois cursos que são ministrados na mesma sala.

SELECT DISTINCT M1.nroAlun
FROM  MATRICULADO M1, MATRICULADO M2, CURSO C1, CURSO C2
WHERE M1.nroAlun = M2.nroAlun AND 
      M1.nomeCurso != M2.nomeCurso AND
      C1.nome = M1.nomeCurso AND
      C2.nome = M2.nomeCurso AND
      C1.sala = C2.sala;

-- Encontre o nome do professor que ministra pelo menos dois cursos.

SELECT DISTINCT P.nomeProf
FROM PROFESSOR P, CURSO C1, CURSO C2
WHERE P.idProf = C1.idProf AND
	  P.idProf = C2.idProf AND
      C1.nome != C2.nome;

-- Encontre o nome do professor que ministra pelo menos três cursos.

SELECT DISTINCT P.nomeProf
FROM PROFESSOR P, CURSO C1, CURSO C2, CURSO C3
WHERE 
	  P.idProf = C1.idProf AND
	  C1.idProf = C2.idProf AND
	  C2.idProf = C3.idProf AND
      C1.nome != C2.nome AND
      C2.nome != C3.nome AND
      C1.nome != C3.nome;
      
SELECT nomeProf, COUNT(*) AS QuantidadeCursos
FROM CURSO C NATURAL JOIN PROFESSOR P
GROUP BY idProf
HAVING COUNT(*) >= 3;

-- Verifique se há algum professor com o mesmo nome de um aluno.

SELECT *
FROM PROFESSOR P, ALUNO A
WHERE P.nomeProf = A.nomeAlun;

-- Liste os alunos e, caso eles estejam matriculado, liste o seu curso. 

SELECT A.nomeAlun, M.nomeCurso
FROM ALUNO A LEFT OUTER JOIN MATRICULADO M ON (A.nroAlun = M.nroAlun);

-- Liste todos os cursos e, caso eles tenham algum aluno matriculado, 
-- imprima o número do aluno.

SELECT C.nome, M.nroAlun
FROM CURSO C LEFT OUTER JOIN MATRICULADO M ON (C.nome = M.nomeCurso);

-- Liste todos os cursos e, caso ele tenha algum aluno matriculado, i
-- imprima o nome do aluno.

SELECT C.nome, A.nomeAlun
FROM ALUNO A INNER JOIN MATRICULADO M ON (A.nroAlun = m.nroAlun) 
	 RIGHT OUTER JOIN CURSO C ON (C.nome = M.nomeCurso);

-- Liste todos os cursos e, caso ele tenha algum aluno matriculado do nível 'JR', 
-- imprima o nome do aluno.

SELECT C.nome, A.nomeAlun
FROM (ALUNO A INNER JOIN MATRICULADO M ON (A.nroAlun = m.nroAlun))
	 RIGHT OUTER JOIN CURSO C ON (C.nome = M.nomeCurso)
WHERE nivel IS NULL OR nivel = 'JR';

-- Liste todos os professores e, caso um professor lecione um curso, liste o nome do curso

SELECT nomeProf, nome
FROM PROFESSOR P LEFT OUTER JOIN CURSO C ON (P.idProf = C.idProf);

-- Imprima a quantidade de alunos para cada curso 

SELECT C.nome, COUNT(M.nroAlun)
FROM MATRICULADO M RIGHT OUTER JOIN CURSO C ON (M.nomeCurso = C.nome)
GROUP BY C.nome;

-- Imprima a quantidade de cursos por professor 

SELECT P.idProf, COUNT(C.nome)
FROM CURSO C RIGHT OUTER JOIN PROFESSOR P ON (C.idProf = P.idProf)
GROUP BY P.idProf;

-- Imprima o nível e a idade média dos alunos desse nível, para cada nível. 

SELECT nivel, AVG(idade) AS media_idade
FROM ALUNO
GROUP BY nivel;

-- Imprima o nível e a idade média dos alunos desse nível, para todos os níveis exceto JR. 

SELECT nivel, AVG(idade)
FROM ALUNO
WHERE nivel != 'JR'
GROUP BY NIVEL;

--  Para cada professor que ministra cursos apenas na sala R128
-- imprima seu nome e o número
-- total de cursos que ele ou ela ministra.

SELECT nomeProf, count(*)
FROM PROFESSOR P, CURSO C
WHERE C.idProf = P.idProf AND NOT EXISTS (SELECT *
										  FROM CURSO C1
										  WHERE C1.sala != 'R128' AND
										  P.idProf = C1.idProf)
GROUP BY P.idProf;

-- Encontre os nome de todos os cursos que são ministrados na sala R128 ou que têm cinco
-- ou mais alunos matriculados.

SELECT nome 
FROM CURSO 
WHERE sala = 'R128'
UNION
SELECT nomeCurso 
FROM MATRICULADO 
GROUP BY nomeCurso
HAVING COUNT(*)>4;

-- Encontre os nomes dos alunos matriculados no número máximo de cursos.

SELECT nomeAlun, COUNT(*) 
FROM MATRICULADO NATURAL JOIN ALUNO
GROUP BY nroAlun
HAVING COUNT(*) >= ALL (SELECT COUNT(*) 
						FROM MATRICULADO 
						GROUP BY nroAlun);

-- Encontre os nomes dos professores para os quais a lista de matriculados dos cursos que
-- eles ministram é menor do que cinco.

SELECT P.nomeProf, COUNT(*)
FROM PROFESSOR P, CURSO C, MATRICULADO M
WHERE C.nome = M.nomeCurso AND P.idProf = C.idProf
GROUP BY P.idProf
HAVING COUNT(*) < 5;

-- Selecione os professor que são do departamento 11 OU ministrem pelo menos 2 cursos.*/

SELECT *
FROM PROFESSOR
WHERE idDepto = 11 OR idProf IN (SELECT idProf
								FROM CURSO
								GROUP BY idProf
								HAVING COUNT(*) >= 2);
-- Encontre os alunos que não estão matriculados 

SELECT *
FROM ALUNO
WHERE nroAlun NOT IN (SELECT nroAlun
					  FROM MATRICULADO);

DROP TABLE IF EXISTS MATRICULADO;
DROP TABLE IF EXISTS ALUNO;
DROP TABLE IF EXISTS CURSO;
DROP TABLE IF EXISTS PROFESSOR;

CREATE TABLE ALUNO( 	
    nroAlun INTEGER PRIMARY KEY, 	
    nomeAlun VARCHAR (30), 	
    formacao VARCHAR (25), 	
    nivel VARCHAR(2), 	
    idade INTEGER	
); 

CREATE TABLE PROFESSOR(
	idProf INTEGER PRIMARY KEY, 	
	nomeProf VARCHAR (30), 	
	idDepto INTEGER	
);

CREATE TABLE CURSO( 	
	nome VARCHAR(40) PRIMARY KEY, 	
	horario VARCHAR(20), 	
	sala VARCHAR (10), 	
	idProf INTEGER, 	
	FOREIGN KEY(idProf) REFERENCES PROFESSOR(idProf)	
); 

CREATE TABLE MATRICULADO( 	
	nroAlun INTEGER, 	
	nomeCurso varchar(40), 	
	PRIMARY KEY (nroAlun, nomeCurso), 	
	FOREIGN KEY (nroAlun) REFERENCES ALUNO(nroAlun), 
	FOREIGN KEY (nomeCurso) REFERENCES CURSO(nome) 	
);
INSERT INTO ALUNO(nroAlun, nomeAlun, formacao, nivel, idade) VALUES (051135593, 'Maria White', 'English', 'SR',21),  (060839453, 'Charles Harris', 'Architecture', 'SR', 22), (099354543, 'Susan Martin', 'Law', 'JR' ,20), (112348546, 'Joseph Thompson' ,'Computer Science', 'SO', 19), (115987938, 'Christopher Garcia', 'Computer Science', 'JR', 20), (132977562, 'Angela Martinez', 'History', 'SR', 20), (269734834, 'Thomas Robinson', 'Psychology', 'SO', 18), (280158572, 'Margaret Clark', 'Animal Science', 'FR', 18), (301221823, 'Juan Rodriguez', 'Psychology', 'JR', 20), (318548912, 'Dorthy Lewis', 'Finance', 'FR', 18), (320874981, 'Daniel Lee', 'Electrical Engineering', 'FR', 17), (322654189, 'Lisa Walker', 'Computer Science', 'SO', 17), (348121549, 'Paul Hall' ,'Computer Science', 'JR', 18), (351565322, 'Nancy Allen', 'Accounting', 'JR', 19), (451519864, 'Mark Young', 'Finance', 'FR', 18), (455798411, 'Luis Hernandez', 'Electrical Engineering', 'FR', 17), (462156489, 'Donald King', 'Mechanical Engineering', 'SO', 19), (550156548, 'George Wright', 'Education', 'SR', 21), (552455318, 'Ana Lopez', 'Computer Engineering', 'SR', 19), (556784565, 'Kenneth Hill', 'Civil Engineering', 'SR', 21), (567354612, 'Karen Scott', 'Computer Engineering', 'FR', 18), (573284895, 'Steven Green', 'Kinesiology',  'SO', 19), (574489456, 'Betty Adams', 'Economics', 'JR', 20), (578875478, 'Edward Baker', 'Veterinary Medicine', 'SR', 21);
INSERT INTO PROFESSOR(idProf, nomeProf, idDepto) VALUES (142519864, 'Ivana Teach',20),  (242518965, 'James Smith',68), (141582651, 'Mary Johnson',20), (011564812, 'John Williams',68), (254099823, 'Patricia Jones',68), (356187925, 'Robert Brown',12), (489456522, 'Linda Davis',20), (287321212, 'Michael Miller',12), (248965255, 'Barbara Wilson',12), (159542516, 'William Moore',33), (090873519, 'Elizabeth Taylor',11), (486512566, 'David Anderson',20),  (619023588, 'Jennifer Thomas',11),  (489221823, 'Richard Jackson',33),  (548977562, 'Ulysses Teach',20);
INSERT INTO CURSO(nome, horario, sala, idProf) VALUES ('Data Structures', 'MWF 10', 'R128', 489456522), ('Database Systems', 'MWF 12:30-1:45', '1320 DCL', 142519864),  ('Operating System Design', 'TuTh 12-1:20', '20 AVW', 489456522),   ('Archaeology of the Incas', 'MWF 3-4:15', 'R128', 248965255),  ('Aviation Accident Investigation', 'TuTh 1-2:50','Q3', 011564812),  ('Air Quality Engineering','TuTh 10:30-11:45','R15', 011564812),  ('Introductory Latin', 'MWF 3-4:15','R12', 248965255),  ('American Political Parties', 'TuTh 2-3:15','20 AVW', 619023588),  ('Social Cognition', 'Tu 6:30-8:40','R15', 159542516),  ('Perception', 'MTuWTh 3','Q3', 489221823),  ('Multivariate Analysis', 'TuTh 2-3:15' ,'R15', 489221823),  ('Patent Law','F 1-2:50','R128', 489221823),  ('Urban Economics','MWF 11','20 AVW', 489221823),  ('Organic Chemistry','TuTh 12:30-1:45','R12', 489221823),  ('Marketing Research','MW 10-11:15','1320 DCL', 489221823),  ('Seminar in American Art','M 4','R15', 489221823),  ('Orbital Mechanics','MWF 8','1320 DCL', 011564812),  ('Dairy Herd Management','TuTh 12:30-1:45','R128', 356187925),  ('Communication Networks', 'MW 9:30-10:45', '20 AVW', 141582651),  ('Optical Electronics', 'TuTh 12:30-1:45', 'R15', 254099823), ('Intoduction to Math', 'TuTh 8-9:30', 'R128', 489221823);
INSERT INTO MATRICULADO(nroAlun, nomeCurso) VALUES  (112348546,'Database Systems'),  (115987938,'Database Systems'), (348121549,'Database Systems'), (322654189,'Database Systems'), (552455318, 'Database Systems'), (455798411,'Operating System Design'), (552455318, 'Operating System Design'), (567354612, 'Operating System Design'), (112348546,'Operating System Design'), (115987938,'Operating System Design'), (322654189,'Operating System Design'), (567354612,'Data Structures'), (552455318,'Communication Networks'), (455798411,'Optical Electronics'), (301221823,'Perception'), (301221823,'Social Cognition'), (301221823,'American Political Parties'), (556784565,'Air Quality Engineering'), (099354543,'Patent Law'), (574489456,'Urban Economics');
