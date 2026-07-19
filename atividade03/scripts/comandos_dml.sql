-- Atividade 03 - Comandos DML
-- Banco-alvo: PostgreSQL
-- Observacao: os comandos abaixo usam dados significativos no contexto da aplicacao web de mangas.

BEGIN;

-- B1. Comando INSERT para inserir 5 registros na tabela usuario.
INSERT INTO usuario (nome, icone, plano, idioma_preferencial) VALUES
('Ana Costa', '/img/users/ana.png', 'deluxe', 'pt-BR'),
('Bruno Lima', '/img/users/bruno.png', 'standard', 'pt-BR'),
('Carla Mendes', '/img/users/carla.png', 'basico', 'en-US'),
('Daniel Souza', '/img/users/daniel.png', 'standard', 'es-ES'),
('Ester Rocha', '/img/users/ester.png', 'deluxe', 'pt-BR');

-- B1. Comando INSERT para inserir 5 registros na tabela manga.
INSERT INTO manga (nome, autor, artista, sumario, classificacao, capa, cronograma) VALUES
('Cidade de Papel', 'R. Nogueira', 'L. Alves', 'Jovens descobrem uma biblioteca secreta em uma cidade esquecida.', '12+', '/img/manga/cidade-de-papel.png', 'semanal'),
('Guardiao do Norte', 'M. Barros', 'I. Paiva', 'Um guerreiro protege aldeias do frio eterno e de criaturas antigas.', '14+', '/img/manga/guardiao-do-norte.png', 'mensal'),
('Estrelas de Aço', 'T. Menezes', 'C. Duarte', 'Pilotos disputam rotas interestelares em uma guerra comercial futurista.', '16+', '/img/manga/estrelas-de-aco.png', 'quinzenal'),
('Jardim das Sombras', 'P. Ferraz', 'A. Ribeiro', 'Uma investigadora enfrenta enigmas ligados a memórias apagadas.', '18+', '/img/manga/jardim-das-sombras.png', 'mensal'),
('Lendas do Vale', 'S. Almeida', 'M. Costa', 'Cinco aprendizes unem forças para proteger um vale sagrado.', 'livre', '/img/manga/lendas-do-vale.png', 'semanal');

-- B1. Comando INSERT para inserir 5 registros na tabela favorita.
INSERT INTO favorita (usuario_id, manga_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(3, 5),
(5, 2);

-- B1. Comando INSERT para inserir 5 registros na tabela capitulo.
INSERT INTO capitulo (titulo, numeracao, dataPublicacao, qtdVisualizacoes, isFree, idioma, id_manga) VALUES
('A porta escondida', 'Cap. 1', DATE '2026-01-05', 1240, TRUE, 'pt-BR', 1),
('Frio sem fim', 'Cap. 7', DATE '2026-01-18', 980, FALSE, 'pt-BR', 2),
('Primeira rota', 'Cap. 3', DATE '2026-02-02', 2310, TRUE, 'en-US', 3),
('A sala sem espelhos', 'Cap. 9', DATE '2026-02-20', 450, FALSE, 'es-ES', 4),
('O juramento do vale', 'Cap. 2', DATE '2026-03-01', 1780, TRUE, 'pt-BR', 5);

-- B1. Comando INSERT para inserir 5 registros na tabela pagina.
INSERT INTO pagina (id_capitulo, numero, imagem) VALUES
(1, 1, '/img/pages/cap1-p1.png'),
(1, 2, '/img/pages/cap1-p2.png'),
(2, 1, '/img/pages/cap7-p1.png'),
(3, 1, '/img/pages/cap3-p1.png'),
(5, 1, '/img/pages/cap2-p1.png');

-- B1. Comando INSERT para inserir 5 registros na tabela comentario.
INSERT INTO comentario (conteudo, data, hora, numeroCurtidas, id_capitulo, id_usuario) VALUES
('Capitulo muito bom, a revelacao final ficou forte.', DATE '2026-03-02', TIME '18:10:00', 24, 1, 2),
('A arte do frio eterno ficou impressionante.', DATE '2026-03-03', TIME '09:05:00', 18, 2, 1),
('Gostei do ritmo da historia e da dublagem em ingles.', DATE '2026-03-04', TIME '21:40:00', 11, 3, 3),
('Esse misterio da sala sem espelhos prendeu minha atencao.', DATE '2026-03-05', TIME '20:00:00', 32, 4, 5),
('O juramento do vale fechou bem a introducao da obra.', DATE '2026-03-06', TIME '07:30:00', 15, 5, 4);

-- B2. Comando UPDATE para atualizar um campo de todos os registros de uma tabela.
UPDATE manga
SET cronograma = 'semanal';

-- B3. Comando UPDATE para atualizar um campo dos registros que satisfazem uma condicao simples.
UPDATE usuario
SET idioma_preferencial = 'pt-BR'
WHERE plano = 'basico';

-- B4. Comando UPDATE para atualizar um campo dos registros que satisfazem uma condicao composta.
UPDATE capitulo
SET isFree = TRUE
WHERE idioma = 'pt-BR'
  AND qtdVisualizacoes < 1500;

-- B5. Comando UPDATE para atualizar dois campos dos registros que satisfazem uma condicao.
UPDATE comentario
SET numeroCurtidas = 40,
    conteudo = 'Atualizacao: comentario muito positivo sobre o capitulo.'
WHERE id = 4;

-- B6. Comando UPDATE para atualizar um campo usando o antigo valor desse campo.
UPDATE usuario
SET nome = nome || ' da Silva'
WHERE id IN (1, 2);

-- B7. Comando UPDATE para atualizar um campo usando uma funcao.
UPDATE manga
SET nome = INITCAP(nome)
WHERE id IN (1, 2, 3);

-- B8. Comando DELETE para remover todos os registros de uma tabela.
DELETE FROM favorita;

-- B9. Comando DELETE para remover os registros que satisfazem uma condicao simples.
DELETE FROM pagina
WHERE numero = 2;

-- B10. Comando DELETE para remover os registros que satisfazem uma condicao composta.
DELETE FROM comentario
WHERE numeroCurtidas < 20
  AND data < DATE '2026-03-05';

-- B11. Comando DELETE para remover um campo usando uma funcao.
DELETE FROM manga
WHERE LOWER(nome) = LOWER('Jardim das Sombras');

COMMIT;
