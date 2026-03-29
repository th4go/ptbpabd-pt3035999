
-- Questão 1

CREATE TABLE pessoa (
    ID INT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    idade INT CHECK (idade >= 0)
);

-- Insert com erro
INSERT INTO pessoa (ID, nome, sobrenome, idade) 
VALUES (1, 'João', 'Silva', -5);

-- The INSERT statement conflicted with the CHECK constraint "CK__pessoa__idade__756D6ECB". 
--The conflict occurred in database "PTBPABD", table "dbo.pessoa", column 'idade'.

-- Insert corrigido
INSERT INTO pessoa (ID, nome, sobrenome, idade) 
VALUES (1, 'João', 'Silva', 28);

-- Questão 2

ALTER TABLE pessoa
ADD UNIQUE (ID, nome, sobrenome);

INSERT INTO pessoa (ID, nome, sobrenome, idade) 
VALUES (2, 'Maria', 'Santos', 25);

-- Teste de inserção com dados duplicados (deve falhar)

INSERT INTO pessoa (ID, nome, sobrenome, idade) 
VALUES (2, 'Maria', 'Santos', 25);

-- Questão 3

ALTER TABLE pessoa
ALTER COLUMN idade INT NOT NULL;

INSERT INTO pessoa (ID, nome, sobrenome) 
VALUES (NULL, 'Carlos', 'Oliveira'); -- Cannot insert the value NULL into column 'ID', table 'PTBPABD.dbo.pessoa'; column does not allow nulls. INSERT fails.

-- Questão 4

CREATE TABLE endereco (
    ID INT PRIMARY KEY,
    rua VARCHAR(100)
);

ALTER TABLE pessoa
ADD endereco INT;

ALTER TABLE pessoa
ADD CONSTRAINT fk_pessoa_endereco FOREIGN KEY (endereco) REFERENCES endereco(ID);