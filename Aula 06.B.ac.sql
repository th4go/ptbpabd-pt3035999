-- QUESTÃO 1
GRANT SELECT ON dbo.instructor (ID, name, dept_name) TO User_B;

GRANT SELECT ON dbo.takes (ID, course_id, sec_id, semester, year) TO User_B;

-- TESTE PARA A QUESTÃO 1 (fiquei com receio)
EXECUTE AS USER = 'User_B';
SELECT ID, name, dept_name FROM dbo.instructor;
SELECT salary FROM dbo.instructor;
REVERT;



-- QUESTÃO 2

GRANT SELECT (course_id, sec_id, semester, year), 
      UPDATE (course_id, sec_id, semester, year) 
ON dbo.section TO User_C;

-- QUESTÃO 3

GRANT SELECT ON dbo.instructor TO User_D;
GRANT SELECT ON dbo.student TO User_D;
GRANT SELECT ON dbo.grade_points TO User_D;

-- QUESTÃO 4

CREATE VIEW dbo.vw_student_civil AS
SELECT ID, name, dept_name, tot_cred 
FROM dbo.student 
WHERE dept_name = 'Civil Eng.';
GO

GRANT SELECT ON dbo.vw_student_civil TO User_E;

-- QUESTÃO 5

REVOKE SELECT ON dbo.vw_student_civil FROM User_E;
EXECUTE AS USER = 'User_E';
SELECT * FROM dbo.vw_student_civil;
SELECT * FROM dbo.student;
REVERT;


-- QUESTÃO 6

SELECT 
    pr.name AS Username,
    dp.class_desc AS Scope,
    dp.permission_name AS Permission,
    dp.state_desc AS State,
    o.name AS Object_Name,
    ISNULL(c.name, 'All Columns / Table Level') AS Column_Name
FROM sys.database_permissions dp
JOIN sys.database_principals pr ON dp.grantee_principal_id = pr.principal_id
LEFT JOIN sys.objects o ON dp.major_id = o.object_id AND dp.class = 1
LEFT JOIN sys.columns c ON dp.major_id = c.object_id AND dp.minor_id = c.column_id AND dp.class = 1
WHERE pr.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E')
ORDER BY pr.name, o.name, c.name;