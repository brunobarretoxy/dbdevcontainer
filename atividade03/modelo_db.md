# Atividade 03 - Construção dos Comandos SQL para uma Aplicação Web existente

## Identificação da equipe

- Integrante: Bruno Barreto
- Repositório de entrega: dbdevcontainer

## Modelagem relacional

O modelo abaixo foi organizado a partir do diagrama relacional e do dicionário de dados do PDF da Atividade 2, considerando a normalização descrita no material.

### Diagrama relacional textual

- USUARIO(id, nome, icone, plano, idiomaPreferencial)
- MANGA(id, nome, autor, artista, sumario, classificacao, capa, cronograma)
- MANGA(id, nome, autor, artista, sumario, classificacao, capa, cronograma, qtdCapitulos, idioma)
- FAVORITA(usuario_id, manga_id)
- CAPITULO(id, titulo, numeracao, dataPublicacao, qtdVisualizacoes, isFree, idioma, id_manga)
- PAGINA(id_capitulo, numero, imagem)
- COMENTARIO(id, conteudo, data, hora, numeroCurtidas, id_capitulo, id_usuario)

### Relacionamentos

- Um usuario pode favoritar varios mangas e um manga pode ser favoritado por varios usuarios.
- Um manga possui varios capitulos e cada capitulo pertence a um unico manga.
- Um capitulo possui varias paginas e cada pagina pertence a um unico capitulo.
- Um usuario escreve varios comentarios e cada comentario pertence a um unico usuario.
- Um capitulo recebe varios comentarios e cada comentario pertence a um unico capitulo.

## Dicionario de dados resumido

### USUARIO

| Atributo           | Tipo         |  PK |  FK | Nulo | Descricao                         |
| ------------------ | ------------ | --: | --: | ---: | --------------------------------- |
| id                 | INT          | Sim | Nao |  Nao | Identificador do usuario          |
| nome               | VARCHAR(255) | Nao | Nao |  Nao | Nome de exibicao                  |
| icone              | VARCHAR(255) | Nao | Nao |  Nao | Caminho ou URL do perfil          |
| plano              | ENUM         | Nao | Nao |  Nao | Valores: basico, standard, deluxe |
| idiomaPreferencial | ENUM         | Nao | Nao |  Nao | Valores: PT_BR, EN, ES, JA        |

### MANGA

| Atributo      | Tipo         |  PK |  FK | Nulo | Descricao                          |
| ------------- | ------------ | --: | --: | ---: | ---------------------------------- |
| id            | INT          | Sim | Nao |  Nao | Identificador do manga             |
| nome          | VARCHAR(511) | Nao | Nao |  Nao | Titulo da obra                     |
| autor         | VARCHAR(255) | Nao | Nao |  Nao | Nome do autor                      |
| artista       | VARCHAR(255) | Nao | Nao |  Sim | Nome do artista                    |
| sumario       | TEXT         | Nao | Nao |  Nao | Sinopse ou resumo                  |
| classificacao | ENUM         | Nao | Nao |  Nao | Valores: LIVRE, 10, 12, 14, 16, 18 |
| capa          | VARCHAR(255) | Nao | Nao |  Nao | Caminho ou URL da capa             |
| cronograma    | VARCHAR(63)  | Nao | Nao |  Sim | Frequencia de publicacao           |
| qtdCapitulos  | INT          | Nao | Nao |  Nao | Quantidade total de capitulos      |
| idioma        | ENUM         | Nao | Nao |  Nao | Valores: PT_BR, EN, ES, JA         |

### FAVORITA

| Atributo   | Tipo |  PK |  FK | Nulo | Descricao             |
| ---------- | ---- | --: | --: | ---: | --------------------- |
| usuario_id | INT  | Sim | Sim |  Nao | Usuario que favoritou |
| manga_id   | INT  | Sim | Sim |  Nao | Manga favoritado      |

### CAPITULO

| Atributo         | Tipo         |  PK |  FK | Nulo | Descricao                           |
| ---------------- | ------------ | --: | --: | ---: | ----------------------------------- |
| id               | INT          | Sim | Nao |  Nao | Identificador do capitulo           |
| titulo           | VARCHAR(255) | Nao | Nao |  Nao | Titulo do capitulo                  |
| numeracao        | VARCHAR(255) | Nao | Nao |  Nao | Numero ou identificador do capitulo |
| dataPublicacao   | DATE         | Nao | Nao |  Nao | Data de publicacao                  |
| qtdVisualizacoes | INT          | Nao | Nao |  Nao | Total de visualizacoes              |
| isFree           | BOOLEAN      | Nao | Nao |  Nao | Indica se e gratuito                |
| idioma           | ENUM         | Nao | Nao |  Nao | Valores: PT_BR, EN, ES, JA          |
| id_manga         | INT          | Nao | Sim |  Nao | Manga ao qual pertence              |

### PAGINA

| Atributo    | Tipo         |  PK |  FK | Nulo | Descricao                          |
| ----------- | ------------ | --: | --: | ---: | ---------------------------------- |
| id_capitulo | INT          | Sim | Sim |  Nao | Capitulo ao qual a pagina pertence |
| numero      | INT          | Sim | Nao |  Nao | Ordem da pagina                    |
| imagem      | VARCHAR(255) | Nao | Nao |  Nao | Caminho ou URL da imagem           |

### COMENTARIO

| Atributo       | Tipo |  PK |  FK | Nulo | Descricao                   |
| -------------- | ---- | --: | --: | ---: | --------------------------- |
| id             | INT  | Sim | Nao |  Nao | Identificador do comentario |
| conteudo       | TEXT | Nao | Nao |  Nao | Texto do comentario         |
| data           | DATE | Nao | Nao |  Nao | Data da publicacao          |
| hora           | TIME | Nao | Nao |  Nao | Hora da publicacao          |
| numeroCurtidas | INT  | Nao | Nao |  Nao | Quantidade de curtidas      |
| id_capitulo    | INT  | Nao | Sim |  Nao | Capitulo comentado          |
| id_usuario     | INT  | Nao | Sim |  Nao | Usuario que escreveu        |
