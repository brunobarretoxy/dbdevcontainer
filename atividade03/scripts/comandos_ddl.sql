-- Atividade 03 - Comandos DDL
-- Modelo relacional: Aplicacao Web de leitura de mangas
-- Banco-alvo: PostgreSQL

DO $$
BEGIN
    CREATE TYPE plano_enum AS ENUM ('basico', 'standard', 'deluxe');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$
BEGIN
    CREATE TYPE idioma_enum AS ENUM ('PT_BR', 'EN', 'ES', 'JA');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$
BEGIN
    CREATE TYPE classificacao_enum AS ENUM ('LIVRE', '10', '12', '14', '16', '18');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS usuario (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    icone VARCHAR(255) NOT NULL,
    plano plano_enum NOT NULL,
    idioma_preferencial idioma_enum NOT NULL
);

CREATE TABLE IF NOT EXISTS manga (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(511) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    artista VARCHAR(255),
    sumario TEXT NOT NULL,
    classificacao classificacao_enum NOT NULL,
    capa VARCHAR(255) NOT NULL,
    cronograma VARCHAR(63),
    CONSTRAINT manga_classificacao_chk CHECK (classificacao IN ('LIVRE', '10', '12', '14', '16', '18'))
);

CREATE TABLE IF NOT EXISTS favorita (
    usuario_id INT NOT NULL,
    manga_id INT NOT NULL,
    CONSTRAINT favorita_pk PRIMARY KEY (usuario_id, manga_id),
    CONSTRAINT favorita_usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE,
    CONSTRAINT favorita_manga_fk FOREIGN KEY (manga_id) REFERENCES manga (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS capitulo (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    numeracao VARCHAR(255) NOT NULL,
    dataPublicacao DATE NOT NULL,
    qtdVisualizacoes INT NOT NULL DEFAULT 0,
    isFree BOOLEAN NOT NULL,
    idioma idioma_enum NOT NULL,
    id_manga INT NOT NULL,
    CONSTRAINT capitulo_manga_fk FOREIGN KEY (id_manga) REFERENCES manga (id) ON DELETE CASCADE,
    CONSTRAINT capitulo_idioma_chk CHECK (idioma IN ('PT_BR', 'EN', 'ES', 'JA'))
);

CREATE TABLE IF NOT EXISTS pagina (
    id_capitulo INT NOT NULL,
    numero INT NOT NULL,
    imagem VARCHAR(255) NOT NULL,
    CONSTRAINT pagina_pk PRIMARY KEY (id_capitulo, numero),
    CONSTRAINT pagina_capitulo_fk FOREIGN KEY (id_capitulo) REFERENCES capitulo (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comentario (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conteudo TEXT NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    numeroCurtidas INT NOT NULL DEFAULT 0,
    id_capitulo INT NOT NULL,
    id_usuario INT NOT NULL,
    CONSTRAINT comentario_capitulo_fk FOREIGN KEY (id_capitulo) REFERENCES capitulo (id) ON DELETE CASCADE,
    CONSTRAINT comentario_usuario_fk FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE CASCADE
);
