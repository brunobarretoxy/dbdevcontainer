-- Atividade 03 - Comandos SELECT
-- Banco-alvo: PostgreSQL

-- C1. Comando SELECT para listar todos os campos de todos os registros de uma tabela.
SELECT *
FROM manga;

-- C2. Comando SELECT para listar alguns campos dos registros que satisfazem uma condicao simples.
SELECT nome,
       autor,
       classificacao
FROM manga
WHERE classificacao = '14';

-- C3. Comando SELECT para listar alguns campos dos registros que satisfazem uma condicao composta.
SELECT titulo,
       numeracao,
       data_publicacao,
       idioma
FROM capitulo
WHERE idioma = 'PT_BR'
  AND is_free = TRUE;

-- C4. Comando SELECT usando GROUP BY com os campos dos registros que satisfazem uma condicao.
SELECT m.nome AS manga,
       COUNT(c.id) AS quantidade_capitulos
FROM manga AS m
INNER JOIN capitulo AS c
        ON c.id_manga = m.id
GROUP BY m.nome
HAVING COUNT(c.id) >= 1
ORDER BY quantidade_capitulos DESC,
         manga;

-- C5. Comando SELECT contendo como condicao outro SELECT (SELECTs aninhados).
SELECT nome,
       plano,
       idioma_preferencial
FROM usuario
WHERE id IN (
    SELECT usuario_id
    FROM favorita
    GROUP BY usuario_id
    HAVING COUNT(*) >= 1
)
ORDER BY nome;
