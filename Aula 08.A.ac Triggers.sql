CREATE OR ALTER TRIGGER dbo.lost_credits
ON takes
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE s
    SET s.tot_cred = s.tot_cred - c.credits
    FROM student s
    JOIN deleted d ON s.ID = d.ID
    JOIN course c ON d.course_id = c.course_id;
END;


-- Teste do trigger
SELECT ID, name, tot_cred FROM student WHERE ID = '57962';

DELETE FROM takes 
WHERE ID = '57962' AND course_id = '362';


