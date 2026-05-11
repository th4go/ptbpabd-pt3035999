CREATE OR ALTER PROCEDURE salaryHistogram
    @num_intervalos INT
AS
BEGIN
    IF @num_intervalos IS NULL OR @num_intervalos <= 0
        SET @num_intervalos = 5;

    WITH Limites AS (
        SELECT 
            MIN(salary) AS MinGlobal,
            MAX(salary) AS MaxGlobal
        FROM instructor
    ),

    CalculoLargura AS (
        SELECT 
            MinGlobal,
            MaxGlobal,
            CAST((MaxGlobal - MinGlobal) / CAST(@num_intervalos AS DECIMAL(18,4)) AS DECIMAL(18,4)) AS LarguraIntervalo
        FROM Limites
    ),

    NumerosIntervalos AS (
        SELECT 1 AS Numero
        UNION ALL
        SELECT Numero + 1
        FROM NumerosIntervalos
        WHERE Numero < @num_intervalos
    ),

    Faixas AS (
        SELECT 
            n.Numero AS IntervaloID,
            CAST(c.MinGlobal + (n.Numero - 1) * c.LarguraIntervalo AS DECIMAL(18,2)) AS FaixaMin,
            CAST(c.MinGlobal + n.Numero * c.LarguraIntervalo AS DECIMAL(18,2)) AS FaixaMax
        FROM NumerosIntervalos n
        CROSS JOIN CalculoLargura c
    )

    SELECT 
        CAST(CEILING(f.FaixaMin) AS INT) AS valorMinimo,
        CAST(FLOOR(f.FaixaMax) AS INT) AS valorMaximo,
        COUNT(i.ID) AS total
    FROM Faixas f
    LEFT JOIN instructor i ON 
        (f.IntervaloID = @num_intervalos AND i.salary >= f.FaixaMin AND i.salary <= f.FaixaMax)
        OR
        (f.IntervaloID < @num_intervalos AND i.salary >= f.FaixaMin AND i.salary < f.FaixaMax)
    GROUP BY f.IntervaloID, f.FaixaMin, f.FaixaMax
    ORDER BY f.IntervaloID;
END;