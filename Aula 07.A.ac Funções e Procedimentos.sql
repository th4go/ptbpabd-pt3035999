-- questão 1
CREATE PROCEDURE student_grade_points 
    @conceito VARCHAR(2)
AS
BEGIN
    SELECT 
        s.name AS [Nome do estudante],
        s.dept_name AS [Departamento do estudante],
        c.title AS [Título do curso],
        c.dept_name AS [Departamento do curso],
        t.semester AS [Semestre do curso],
        t.year AS [Ano do curso],
        t.grade AS [Pontuação alfanumérica],
        -- Exemplo de lógica para pontuação numérica (ajuste conforme sua regra de negócio)
        CASE t.grade
            WHEN 'A+' THEN 4.0 WHEN 'A' THEN 4.0 WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3 WHEN 'B' THEN 3.0 WHEN 'B-' THEN 2.7
            WHEN 'C+' THEN 2.3 WHEN 'C' THEN 2.0 WHEN 'C-' THEN 1.7
            ELSE 0.0
        END AS [Pontuação numérica]
    FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    WHERE t.grade = @conceito;
END;

EXEC student_grade_points @conceito = 'C'; -- teste da procedure

-- questão 2

GO
CREATE FUNCTION return_instructor_location (@instructor_name VARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT 
        i.name AS [Nome do instrutor],
        c.title AS [Curso ministrado],
        t.semester AS [Semestre do curso],
        t.year AS [Ano do curso],
        s.building AS [prédio],
        s.room_number AS [número da sala]
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    JOIN section s ON t.course_id = s.course_id 
        AND t.sec_id = s.sec_id 
        AND t.semester = s.semester 
        AND t.year = s.year
    WHERE i.name = @instructor_name
);

SELECT * FROM dbo.return_instructor_location('Gustafsson'); -- teste da função
