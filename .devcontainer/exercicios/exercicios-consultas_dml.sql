-- Exercício 02 - Comandos DML (Agendamento de Consultas)
-- Ordem de execução: INSERT -> UPDATE -> DELETE

BEGIN;

-- Inserir pessoas (pacientes e médicos) no cadastro geral.
INSERT INTO Pessoa (cpf, email, nome, data_nasc, endereco, telefone)
VALUES
    ('002', 'pp@email.com', 'Pedro I', DATE '1479-01-10', 'R. Vasco', NULL),
    ('003', 'ps@email.com', 'Pedro II', DATE '1516-02-10', 'R. Flamengo', '5501'),
    ('001', 'dj@email.com', 'D Joao VI', DATE '1415-12-01', 'R. Portugal', NULL),
    ('004', 'jj@email.com', 'JJ Xavier', DATE '1746-11-12', 'R. Minas', '5502');

-- Inserir pacientes com senha e indicação de plano de saúde.
INSERT INTO Paciente (cpf, senha, plano_saude)
VALUES
    ('002', 'senha1', 'Nao'),
    ('003', 'senha2', 'Sim');

-- Inserir médicos com seus respectivos CRMs.
INSERT INTO Medico (cpf, crm)
VALUES
    ('001', '111'),
    ('004', '112');

-- Inserir especialidades médicas.
INSERT INTO Especialidade (identificador, descricao)
VALUES
    (1, 'Pediatra'),
    (2, 'Cardiologista'),
    (3, 'Ortopedista');

-- Relacionar médicos às especialidades cadastradas.
INSERT INTO MedicoEspecialidade (cpf_medico, identificador_especialidade)
VALUES
    ('001', 1),
    ('004', 2),
    ('004', 3);

-- Inserir os agendamentos de consulta (consulta, agendamento e valor).
INSERT INTO Agendamento (cpf_paciente, cpf_medico, dt_consulta, dt_agendamento, valor_consulta)
VALUES
    ('002', '001', TIMESTAMP '1782-04-14 16:00:00', TIMESTAMP '1782-03-14 10:04:45', 80.00),
    ('002', '004', TIMESTAMP '1782-04-15 10:00:00', TIMESTAMP '1782-03-14 10:04:45', 100.00),
    ('002', '004', TIMESTAMP '1783-05-17 08:00:00', TIMESTAMP '1783-05-10 16:32:00', 100.00),
    ('003', '001', TIMESTAMP '1783-05-17 08:30:00', TIMESTAMP '1783-05-09 09:05:56', 0.00);

-- Atualizar a data de nascimento de D Joao VI para 01-12-1416.
UPDATE Pessoa
SET data_nasc = DATE '1416-12-01'
WHERE nome = 'D Joao VI';

-- Atualizar telefone e e-mail de Pedro I.
UPDATE Pessoa
SET telefone = '5503',
    email = 'pf@email.com'
WHERE nome = 'Pedro I';

-- Atualizar telefones adicionando o dígito 9 no início (somente telefones não nulos).
UPDATE Pessoa
SET telefone = '9' || telefone
WHERE telefone IS NOT NULL;

-- Adiar consultas de 17-05-1783 para 19-05-1783 e ajustar o valor para R$ 150,00.
UPDATE Agendamento
SET dt_consulta = dt_consulta + INTERVAL '2 day',
    valor_consulta = 150.00
WHERE dt_consulta::date = DATE '1783-05-17';

-- Trocar a especialidade de JJ Xavier de Cardiologista para Pediatra (mantendo Ortopedista).
UPDATE MedicoEspecialidade
SET identificador_especialidade = 1
WHERE cpf_medico = '004'
  AND identificador_especialidade = 2;

-- Remover a consulta de Pedro I agendada para o dia 19-05-1783.
DELETE FROM Agendamento
WHERE cpf_paciente = '002'
  AND dt_consulta::date = DATE '1783-05-19';

-- Remover agendamentos com D Joao VI e custo igual a R$ 0,00 (duas condições).
DELETE FROM Agendamento
WHERE cpf_medico = '001'
  AND valor_consulta = 0.00;

-- Remover agendamentos dos pacientes que possuem plano de saúde ou não possuem telefone.
DELETE FROM Agendamento
WHERE cpf_paciente IN (
    SELECT p.cpf
    FROM Paciente p
    JOIN Pessoa pe ON pe.cpf = p.cpf
    WHERE p.plano_saude = 'Sim'
       OR pe.telefone IS NULL
);

-- Remover os pacientes que possuem plano de saúde ou não possuem telefone.
DELETE FROM Paciente
WHERE cpf IN (
    SELECT p.cpf
    FROM Paciente p
    JOIN Pessoa pe ON pe.cpf = p.cpf
    WHERE p.plano_saude = 'Sim'
       OR pe.telefone IS NULL
);

-- Remover os agendamentos vinculados ao médico JJ Xavier.
DELETE FROM Agendamento
WHERE cpf_medico = '004';

-- Remover vínculos de especialidades do médico JJ Xavier.
DELETE FROM MedicoEspecialidade
WHERE cpf_medico = '004';

-- Remover o cadastro de médico de JJ Xavier.
DELETE FROM Medico
WHERE cpf = '004';

-- Remover o registro de pessoa de JJ Xavier da base de dados.
DELETE FROM Pessoa
WHERE cpf = '004';

COMMIT;
