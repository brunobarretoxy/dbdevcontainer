-- Exercicio 03 - Comandos DQL (SELECT)
-- Contexto: Agendamento de Consultas
-- Banco-alvo: PostgreSQL
--
-- Script alinhado ao diagrama ER enviado:
-- pessoa(cpf, email, nome, data_nascimento, endereco, telefone)
-- paciente(cpf, senha, plano_saude)
-- medico(cpf, crm)
-- agendamento(cpf_paciente, crm_medico, data_hora_consulta, data_hora_agendamento, valor_consulta)
-- especialidade(identificador, descricao)
-- medico_especialidade(crm_medico, identificador_especialidade)

-- 1) Listar todos os dados de todas as pessoas cadastradas.
SELECT *
FROM pessoa;

-- 2) Listar nome, e-mail e data de nascimento das pessoas cadastradas.
SELECT p.nome,
       p.email,
       p.data_nascimento
FROM pessoa AS p;

-- 3) Listar nome, e-mail e data de nascimento da 3a a 8a pessoa cadastrada.
-- Como o diagrama nao possui campo de cadastro, foi usado CPF para ordenacao deterministica.
SELECT p.nome,
       p.email,
       p.data_nascimento
FROM pessoa AS p
ORDER BY p.cpf
OFFSET 2
LIMIT 6;

-- 4) Listar nome, e-mail e idade das pessoas cadastradas.
SELECT p.nome,
       p.email,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.data_nascimento)) AS idade
FROM pessoa AS p;

-- 5) Listar a quantidade de agendamentos.
SELECT COUNT(*) AS quantidade_agendamentos
FROM agendamento AS a;

-- 6) Listar data/hora das consultas e respectivos valores com desconto de 5%, precedidos de "R$".
SELECT a.data_hora_consulta,
       'R$ ' || TO_CHAR(a.valor_consulta * 0.95, 'FM999999990.00') AS valor_com_desconto
FROM agendamento AS a;

-- 7) Listar nome, cpf e e-mail dos pacientes que nao possuem plano de saude.
SELECT p.nome,
       p.cpf,
       p.email
FROM paciente AS pa
JOIN pessoa AS p
  ON p.cpf = pa.cpf
WHERE pa.plano_saude = FALSE;

-- 8) Listar os dados dos agendamentos registrados para o mesmo mes da consulta.
SELECT a.*
FROM agendamento AS a
WHERE EXTRACT(MONTH FROM a.data_hora_agendamento) = EXTRACT(MONTH FROM a.data_hora_consulta)
  AND EXTRACT(YEAR FROM a.data_hora_agendamento) = EXTRACT(YEAR FROM a.data_hora_consulta);

-- 9) Listar cpf, nome e e-mail dos pacientes que nao possuem telefone.
SELECT p.cpf,
       p.nome,
       p.email
FROM paciente AS pa
JOIN pessoa AS p
  ON p.cpf = pa.cpf
WHERE p.telefone IS NULL
   OR TRIM(p.telefone) = '';

-- 10) Listar a data das consultas cujo valor esta entre R$ 50.00 e R$ 100.00.
SELECT a.data_hora_consulta::date AS data_consulta
FROM agendamento AS a
WHERE a.valor_consulta BETWEEN 50.00 AND 100.00;

-- 11) Listar cpf, nome e e-mail dos pacientes que moram em "Natal".
SELECT p.cpf,
       p.nome,
       p.email
FROM paciente AS pa
JOIN pessoa AS p
  ON p.cpf = pa.cpf
WHERE p.endereco ILIKE '%Natal%';

-- 12) Listar cpf, nome, e-mail e data de nascimento dos pacientes ordenados pela data de nascimento.
SELECT p.cpf,
       p.nome,
       p.email,
       p.data_nascimento
FROM paciente AS pa
JOIN pessoa AS p
  ON p.cpf = pa.cpf
ORDER BY p.data_nascimento;

-- 13) Listar a quantidade de pacientes que nao possuem plano de saude.
SELECT COUNT(*) AS quantidade_pacientes_sem_plano
FROM paciente AS pa
WHERE pa.plano_saude = FALSE;

-- 14) Listar o maior e o menor valor das consultas agendadas para cada dia que contem consulta.
SELECT a.data_hora_consulta::date AS dia_consulta,
       MAX(a.valor_consulta) AS maior_valor,
       MIN(a.valor_consulta) AS menor_valor
FROM agendamento AS a
GROUP BY a.data_hora_consulta::date
ORDER BY dia_consulta;

-- 15) Listar a media dos valores das consultas agendadas para o mes de Dezembro.
SELECT AVG(a.valor_consulta) AS media_valores_dezembro
FROM agendamento AS a
WHERE EXTRACT(MONTH FROM a.data_hora_consulta) = 12;

-- 16) Listar nome e e-mail das pessoas que agendaram consulta para o dia do seu aniversario.
SELECT DISTINCT p.nome,
       p.email
FROM agendamento AS a
JOIN paciente AS pa
  ON pa.cpf = a.cpf_paciente
JOIN pessoa AS p
  ON p.cpf = pa.cpf
WHERE EXTRACT(DAY FROM a.data_hora_consulta) = EXTRACT(DAY FROM p.data_nascimento)
  AND EXTRACT(MONTH FROM a.data_hora_consulta) = EXTRACT(MONTH FROM p.data_nascimento);

-- 17) Listar nome, e-mail, cpf dos medicos e suas respectivas especialidades.
SELECT p.nome,
       p.email,
       p.cpf,
       e.descricao AS especialidade
FROM medico AS m
JOIN pessoa AS p
  ON p.cpf = m.cpf
JOIN medico_especialidade AS me
  ON me.crm_medico = m.crm
JOIN especialidade AS e
  ON e.identificador = me.identificador_especialidade
ORDER BY p.nome,
         e.descricao;

-- 18) Listar a quantidade de consultas para cada medico.
SELECT p.nome,
       COUNT(a.crm_medico) AS quantidade_consultas
FROM medico AS m
JOIN pessoa AS p
  ON p.cpf = m.cpf
LEFT JOIN agendamento AS a
  ON a.crm_medico = m.crm
GROUP BY p.nome
ORDER BY p.nome;
