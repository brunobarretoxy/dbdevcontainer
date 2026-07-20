-- Atividade 03 - Comandos SELECT com Operadores de Junção
-- Banco-alvo: PostgreSQL

-- D1. Comando SELECT para exibir alguns dados de DUAS tabelas usando junção qualificada.
SELECT m.nome AS manga,
       c.titulo,
       c.data_publicacao
FROM manga AS m
INNER JOIN capitulo AS c
        ON c.id_manga = m.id
ORDER BY m.nome,
         c.data_publicacao;

-- D2. Comando SELECT para exibir alguns dados de TRES tabelas usando junção qualificada.
SELECT u.nome AS usuario,
       m.nome AS manga,
       f.usuario_id
FROM favorita AS f
INNER JOIN usuario AS u
        ON u.id = f.usuario_id
INNER JOIN manga AS m
        ON m.id = f.manga_id
ORDER BY u.nome,
         m.nome;

-- D3. Comando SELECT para exibir alguns dados usando junção externa.
SELECT m.nome AS manga,
       c.titulo,
       c.idioma
FROM manga AS m
LEFT JOIN capitulo AS c
       ON c.id_manga = m.id
ORDER BY m.nome,
         c.data_publicacao;

-- D4. Comando SELECT para exibir alguns dados usando FULL OUTER JOIN.
SELECT u.nome AS usuario,
       f.manga_id,
       m.nome AS manga
FROM usuario AS u
FULL OUTER JOIN favorita AS f
             ON f.usuario_id = u.id
FULL OUTER JOIN manga AS m
             ON m.id = f.manga_id
ORDER BY usuario,
         manga;
