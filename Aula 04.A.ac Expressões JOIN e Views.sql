SELECT * FROM student A JOIN takes B ON A.ID = B.ID; -- exercicio 1

SELECT s.ID, s.name, COUNT(t.course_id) AS "Quantidade de cursos"
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE s.dept_name = 'Civil Eng.'
GROUP BY s.ID, s.name ORDER BY "Quantidade de cursos" DESC; -- exercicio 2

CREATE VIEW civil_eng_students AS 
    SELECT s.ID, s.name, COUNT(t.course_id) AS "Quantidade de cursos"
    FROM student s
    JOIN takes t ON s.ID = t.ID
    WHERE s.dept_name = 'Civil Eng.'
    GROUP BY s.ID, s.name;

SELECT * FROM civil_eng_students; -- exercicio 3