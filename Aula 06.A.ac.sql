-- Questão 01

CREATE USER User_A WITH PASSWORD = 'Password123!';
CREATE USER User_B WITH PASSWORD = 'Password123!';
CREATE USER User_C WITH PASSWORD = 'Password123!';
CREATE USER User_D WITH PASSWORD = 'Password123!';
CREATE USER User_E WITH PASSWORD = 'Password123!';


-- Questão 02
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO User_A WITH GRANT OPTION;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.classroom TO User_A CASCADE;

-- Questão 03
SELECT 
    pr.name AS Username,
    dp.class_desc AS Scope, -- Mostra se a permissão é no SCHEMA ou no OBJECT
    dp.permission_name AS Permission,
    dp.state_desc AS State,
    COALESCE(o.name, s.name) AS Target_Name -- Pega o nome da tabela OU o nome do esquema
FROM sys.database_permissions dp
JOIN sys.database_principals pr ON dp.grantee_principal_id = pr.principal_id
LEFT JOIN sys.objects o ON dp.major_id = o.object_id AND dp.class = 1 -- Classe 1 = Objeto
LEFT JOIN sys.schemas s ON dp.major_id = s.schema_id AND dp.class = 3 -- Classe 3 = Esquema
WHERE pr.name = 'User_A';