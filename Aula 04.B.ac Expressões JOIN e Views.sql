-- QUESTÃO 1

SELECT 
    i.ID, 
    i.name, 
    COUNT(t.course_id) AS "Number of sections"
FROM 
    instructor i
LEFT OUTER JOIN 
    teaches t ON i.ID = t.ID
GROUP BY 
    i.ID, 
    i.name;

-- QUESTÃO 2



SELECT 
    i.ID, 
    i.name, 
    (SELECT COUNT(course_id) AS "Number of sections" 
    FROM teaches  t 
    WHERE t.ID = i.ID) 
    AS "Number of sections"
FROM instructor i;

-- QUESTÃO 3

SELECT 
    s.course_id, 
    s.sec_id, 
    t.ID, 
    s.semester, 
    s.year, 
    COALESCE(i.name, '-') AS name
FROM 
    section s
LEFT OUTER JOIN 
    teaches t ON s.course_id = t.course_id 
              AND s.sec_id = t.sec_id 
              AND s.semester = t.semester 
              AND s.year = t.year
LEFT OUTER JOIN 
    instructor i ON t.ID = i.ID
WHERE 
    s.semester = 'Spring' AND s.year = 2010;

-- QUESTÃO 4 (Optei pela solução de criar uma tabela "grade_points", achei que ficaria mais simples do que usar um CASE)
-- Não entendi muito bem o enunciado, o mais perto que consegui chegar foi isso, mas ainda diferente do resultado esperado:

CREATE TABLE grade_points (
    grade VARCHAR(2) PRIMARY KEY,
    points NUMERIC(3,1)
);

INSERT INTO grade_points (grade, points) VALUES 
('A+', 4.0), ('A', 3.7), ('A-', 3.4), ('B+', 3.1), 
('B', 2.8), ('B-', 2.5), ('C+', 2.3), ('C', 2.0), ('C-', 1.7);

SELECT 
    s.ID, 
    s.name, 
    s.dept_name,
    SUM(c.credits * gp.points) AS "Pontos totais"
FROM 
    student s
JOIN 
    takes t ON s.ID = t.ID
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    grade_points gp ON t.grade = gp.grade
GROUP BY 
    s.ID, 
    s.name, 
    s.dept_name
ORDER BY 
    s.ID;

-- QUESTÃO 5

CREATE VIEW coeficiente_rendimento AS 
SELECT 
    s.ID, 
    s.name, 
    s.dept_name,
    SUM(c.credits * gp.points) AS "Pontos totais"
FROM 
    student s
JOIN 
    takes t ON s.ID = t.ID
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    grade_points gp ON t.grade = gp.grade
GROUP BY 
    s.ID, 
    s.name, 
    s.dept_name;

SELECT * FROM coeficiente_rendimento ORDER BY ID;