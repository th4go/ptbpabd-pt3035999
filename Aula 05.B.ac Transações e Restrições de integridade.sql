-- QUESTÃO 1
CREATE SCHEMA avaliacaocontinua; 

-- QUESTÃO 2
CREATE TABLE avaliacaocontinua.company (
    company_name VARCHAR(100) NOT NULL PRIMARY KEY,
    city VARCHAR(100)
);

-- QUESTÃO 3
CREATE TABLE avaliacaocontinua.employee (
    person_name VARCHAR(100) NOT NULL PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100)
);

-- QUESTÃO 4
CREATE TABLE avaliacaocontinua.manages (
    person_name VARCHAR(100) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(100)
);

-- QUESTÃO 5
CREATE TABLE avaliacaocontinua.works (
    person_name VARCHAR(100) NOT NULL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2)
);

-- QUESTÃO 6
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- QUESTÃO 7
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_company
FOREIGN KEY (company_name) REFERENCES avaliacaocontinua.company(company_name)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- QUESTÃO 8
ALTER TABLE avaliacaocontinua.manages
ADD CONSTRAINT fk_manages_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;