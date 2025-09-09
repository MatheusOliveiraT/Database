SELECT *
FROM ALUNO
WHERE idade < 20 AND nivel = 'JR';

SELECT *
FROM PROFESSOR
WHERE idDepto = 68;

SELECT A.nroAlun
FROM ALUNO A, MATRICULADO M
WHERE M.nroAlun = A.nroAlun AND nomeCurso = 'Database Systems';

SELECT P.nomeProf
FROM PROFESSOR P, CURSO C
WHERE P.idprof = C.idprof AND sala = '20 AVW';

SELECT DISTINCT A.nivel
FROM ALUNO A, CURSO C, MATRICULADO M
WHERE A.nroAlun = M.nroALun AND M.nomeCurso = C.nome AND sala = '20 AVW';

SELECT nomeAlun, formacao
FROM ALUNO
WHERE formacao LIKE '%cie%';

SELECT COUNT(*) AS 'NUMERO'
FROM ALUNO;

SELECT COUNT(*) AS 'MATRICULAS EM DB SYSTEM'
FROM MATRICULADO
WHERE nomeCurso = 'Database Systems';

SELECT nomeProf
FROM PROFESSOR
WHERE idDepto = 68 OR idDepto = 12;

SELECT DISTINCT nomeProf
FROM PROFESSOR P, CURSO C
WHERE C.idProf = P.idProf AND C.nome = 'Database Systems' OR idDepto = 68;

SELECT nroAlun FROM ALUNO WHERE formacao = 'Computer Science'
UNION
SELECT nroAlun FROM ALUNO WHERE formacao = 'Database Systems';

SELECT nroAlun FROM ALUNO WHERE formacao = 'Computer Science'
UNION
SELECT nroAlun FROM MATRICULADO WHERE nomeCurso = 'Database Systems';

SELECT *
FROM ALUNO A, MATRICULADO M
WHERE M.nroAlun = A.nroAlun AND A.idade < 20 AND nivel = 'JR';

SELECT *
FROM PROFESSOR P, CURSO C
WHERE P.idProf = C.idProf AND P.idDepto = 12;

SELECT idProf 
FROM PROFESSOR 
WHERE idDepto = 12 AND idProf IN (SELECT idProf 
									FROM CURSO);
                                    
SELECT A.nomeAlun
FROM Aluno A, Matriculado M
WHERE M.nroAlun = A.nroAlun AND M.nomeCurso = 'Database Systems';

SELECT nomeProf FROM PROFESSOR
WHERE idProf IN(SELECT idProf
				FROM CURSO
				WHERE sala = '20 AVW');

SELECT nomeAlun
FROM Aluno A, Matriculado M, Curso C, Professor P
WHERE A.nroAlun = M.nroAlun 
	AND M.nomeCurso = C.nome 
    AND C.idProf = P.idProf 
    AND P.nomeProf = 'Ivana Teach' 
    AND A.nivel = 'JR';

SELECT MAX(idade)
FROM Aluno A, Matriculado M, Curso C, Professor P
WHERE A.nroAlun = M.nroAlun 
		AND M.nomeCurso = C.nome 
		AND C.idProf = P.idProf 
		AND P.nomeProf = 'Ivana Teach';
        


