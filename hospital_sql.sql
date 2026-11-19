
-- =========================================
-- 1. APAGAR E CRIAR O BANCO DE DADOS
-- =========================================

DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

USE hospital;


-- =========================================
-- 2. CRIAR AS 8 TABELAS
-- =========================================

-- TABELA PACIENTE

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome_paciente VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);


-- TABELA ESPECIALIDADE

CREATE TABLE especialidade (
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome_especialidade VARCHAR(100) NOT NULL
);


-- TABELA MEDICO

CREATE TABLE medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome_medico VARCHAR(100) NOT NULL,
    id_especialidade INT,
    FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id_especialidade)
);


-- TABELA CONVENIO

CREATE TABLE convenio (
    id_convenio INT PRIMARY KEY AUTO_INCREMENT,
    nome_convenio VARCHAR(100) NOT NULL
);


-- TABELA CONSULTA

CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_convenio INT NOT NULL,
    data_consulta DATE,
    valor_consulta DECIMAL(10,2) NOT NULL,
    status_consulta VARCHAR(30),

    FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente),

    FOREIGN KEY (id_medico)
        REFERENCES medico(id_medico),

    FOREIGN KEY (id_convenio)
        REFERENCES convenio(id_convenio)
);


-- TABELA QUARTO

CREATE TABLE quarto (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    numero_quarto INT NOT NULL,
    tipo_quarto VARCHAR(50) NOT NULL
);


-- TABELA INTERNACAO

CREATE TABLE internacao (
    id_internacao INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    id_quarto INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    valor_diaria DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente),

    FOREIGN KEY (id_convenio)
        REFERENCES convenio(id_convenio),

    FOREIGN KEY (id_quarto)
        REFERENCES quarto(id_quarto)
);


-- TABELA PRESCRICAO

CREATE TABLE prescricao (
    id_prescricao INT PRIMARY KEY AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    nome_medicamento VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,

    FOREIGN KEY (id_consulta)
        REFERENCES consulta(id_consulta)
);


-- =========================================
-- 3. CADASTRAR OS PACIENTES
-- =========================================

INSERT INTO paciente (nome_paciente, telefone, email)
VALUES
('Maria Silva', '11999990001', 'maria@email.com'),
('Joao Santos', '11999990002', 'joao@email.com'),
('Mariana Oliveira', '11999990003', 'mariana@email.com'),
('Pedro Silva', '11999990004', 'pedro@email.com'),
('Marcos Souza', '11999990005', 'marcos@email.com');


-- =========================================
-- 4. CADASTRAR AS ESPECIALIDADES
-- =========================================

INSERT INTO especialidade (nome_especialidade)
VALUES
('Cardiologia'),
('Pediatria'),
('Dermatologia'),
('Ortopedia'),
('Neurologia');


-- =========================================
-- 5. CADASTRAR OS MEDICOS
-- =========================================

INSERT INTO medico (nome_medico, id_especialidade)
VALUES
('Carlos Mendes', 1),
('Ana Paula', 2),
('Roberto Lima', 3),
('Fernanda Costa', 4),
('Lucas Almeida', 5);


-- =========================================
-- 6. CADASTRAR OS CONVENIOS
-- =========================================

INSERT INTO convenio (nome_convenio)
VALUES
('Unimed'),
('Saúde Bradesco'),
('Amil Saúde'),
('SulAmérica Saúde'),
('NotreDame Saúde');


-- =========================================
-- 7. CADASTRAR OS QUARTOS
-- =========================================

INSERT INTO quarto (numero_quarto, tipo_quarto)
VALUES
(101, 'Apartamento'),
(102, 'Apartamento'),
(201, 'UTI'),
(202, 'UTI'),
(301, 'Enfermaria');


-- =========================================
-- 8. CADASTRAR AS CONSULTAS
-- =========================================

INSERT INTO consulta
(id_paciente, id_medico, id_convenio, data_consulta, valor_consulta, status_consulta)
VALUES
(1, 1, 1, '2026-10-01', 250.00, 'Realizada'),
(2, 2, 2, '2026-10-02', 180.00, 'Finalizada'),
(3, 3, 3, '2026-10-03', 200.00, 'Agendada'),
(4, 4, 4, '2026-10-04', 300.00, 'Realizada'),
(5, 5, 1, '2026-10-05', 220.00, 'Finalizada'),
(1, 1, 2, '2026-10-06', 280.00, 'Realizada'),
(2, 2, 1, '2026-10-07', 190.00, 'Agendada'),
(3, 1, 3, '2026-10-08', 260.00, 'Realizada');


-- =========================================
-- 9. CADASTRAR AS INTERNACOES
-- =========================================

INSERT INTO internacao
(id_paciente, id_convenio, id_quarto, data_inicio, data_fim, valor_diaria)
VALUES
(1, 1, 1, '2026-10-01', '2026-10-05', 350.00),
(2, 2, 2, '2026-10-02', '2026-10-06', 300.00),
(3, 3, 3, '2026-10-03', '2026-10-07', 800.00),
(4, 4, 4, '2026-10-04', '2026-10-08', 850.00),
(5, 1, 5, '2026-10-05', '2026-10-09', 200.00);


-- =========================================
-- 10. CADASTRAR AS PRESCRICOES
-- =========================================

INSERT INTO prescricao
(id_consulta, nome_medicamento, quantidade)
VALUES
(1, 'Dipirona', 2),
(2, 'Paracetamol', 1),
(3, 'Amoxicilina', 2),
(4, 'Dipirona', 3),
(5, 'Paracetamol', 2),
(6, 'Ibuprofeno', 1),
(7, 'Dipirona', 1),
(8, 'Paracetamol', 3);


-- =========================================
-- 11. AS 10 CONSULTAS SQL DO TRABALHO
-- =========================================


-- CONSULTA 1:
-- FATURAMENTO TOTAL DE CONSULTAS POR CONVENIO

SELECT
    convenio.nome_convenio,
    SUM(consulta.valor_consulta) AS faturamento_total
FROM consulta
INNER JOIN convenio
    ON consulta.id_convenio = convenio.id_convenio
WHERE convenio.nome_convenio LIKE '%Saúde%'
GROUP BY convenio.nome_convenio;


-- CONSULTA 2:
-- MEDIA DO VALOR DE CONSULTA POR ESPECIALIDADE MEDICA

SELECT
    especialidade.nome_especialidade,
    AVG(consulta.valor_consulta) AS media_consulta
FROM consulta
INNER JOIN medico
    ON consulta.id_medico = medico.id_medico
INNER JOIN especialidade
    ON medico.id_especialidade = especialidade.id_especialidade
WHERE especialidade.nome_especialidade LIKE '%Cardiologia%'
GROUP BY especialidade.nome_especialidade;


-- CONSULTA 3:
-- MEDIA DO VALOR DA DIARIA POR TIPO DE QUARTO

SELECT
    quarto.tipo_quarto,
    AVG(internacao.valor_diaria) AS media_diaria
FROM internacao
INNER JOIN quarto
    ON internacao.id_quarto = quarto.id_quarto
WHERE quarto.tipo_quarto IN ('Apartamento', 'UTI')
GROUP BY quarto.tipo_quarto;


-- CONSULTA 4:
-- TOTAL DE CONSULTAS POR MEDICO

SELECT
    medico.nome_medico,
    SUM(consulta.valor_consulta) AS total_consultas
FROM consulta
INNER JOIN medico
    ON consulta.id_medico = medico.id_medico
WHERE consulta.status_consulta IN ('Realizada', 'Finalizada')
GROUP BY medico.nome_medico;


-- CONSULTA 5:
-- TOTAL DAS DIARIAS DE PACIENTES COM SOBRENOME SILVA

SELECT
    paciente.nome_paciente,
    SUM(internacao.valor_diaria) AS total_diarias
FROM internacao
INNER JOIN paciente
    ON internacao.id_paciente = paciente.id_paciente
WHERE paciente.nome_paciente LIKE '%Silva'
GROUP BY paciente.nome_paciente;


-- CONSULTA 6:
-- QUANTIDADE DE PRESCRICOES POR STATUS DA CONSULTA

SELECT
    consulta.status_consulta,
    COUNT(prescricao.id_prescricao) AS quantidade_prescricoes
FROM prescricao
INNER JOIN consulta
    ON prescricao.id_consulta = consulta.id_consulta
WHERE prescricao.nome_medicamento LIKE '%Dipirona%'
   OR prescricao.nome_medicamento LIKE '%Paracetamol%'
GROUP BY consulta.status_consulta;


-- CONSULTA 7:
-- MEDIA DAS CONSULTAS POR CONVENIO UNIMED E ESPECIALIDADE

SELECT
    convenio.nome_convenio,
    especialidade.nome_especialidade,
    AVG(consulta.valor_consulta) AS media_consulta
FROM consulta
INNER JOIN convenio
    ON consulta.id_convenio = convenio.id_convenio
INNER JOIN medico
    ON consulta.id_medico = medico.id_medico
INNER JOIN especialidade
    ON medico.id_especialidade = especialidade.id_especialidade
WHERE convenio.nome_convenio = 'Unimed'
GROUP BY
    convenio.nome_convenio,
    especialidade.nome_especialidade;


-- CONSULTA 8:
-- MEDIA DAS DIARIAS POR CONVENIO EM QUARTOS DE UTI

SELECT
    convenio.nome_convenio,
    AVG(internacao.valor_diaria) AS media_diaria
FROM internacao
INNER JOIN convenio
    ON internacao.id_convenio = convenio.id_convenio
INNER JOIN quarto
    ON internacao.id_quarto = quarto.id_quarto
WHERE quarto.tipo_quarto = 'UTI'
GROUP BY convenio.nome_convenio;


-- CONSULTA 9:
-- QUANTIDADE DE ITENS PRESCRITOS POR MEDICO

SELECT
    medico.nome_medico,
    COUNT(prescricao.id_prescricao) AS quantidade_itens
FROM prescricao
INNER JOIN consulta
    ON prescricao.id_consulta = consulta.id_consulta
INNER JOIN medico
    ON consulta.id_medico = medico.id_medico
WHERE consulta.status_consulta = 'Realizada'
GROUP BY medico.nome_medico;


-- CONSULTA 10:
-- TOTAL E MEDIA DAS CONSULTAS POR PACIENTE COM NOME INICIADO EM M

SELECT
    paciente.nome_paciente,
    SUM(consulta.valor_consulta) AS total_consultas,
    AVG(consulta.valor_consulta) AS media_consultas
FROM consulta
INNER JOIN paciente
    ON consulta.id_paciente = paciente.id_paciente
WHERE paciente.nome_paciente LIKE 'M%'
GROUP BY paciente.nome_paciente;


-- =========================================
-- FIM DO PROJETO HOSPITAL
-- =========================================

