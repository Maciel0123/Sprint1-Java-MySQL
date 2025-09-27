CREATE TABLE evento_alpr
(
    id_alpr    BIGINT AUTO_INCREMENT NOT NULL,
    moto_id    BIGINT,
    placa_lida VARCHAR(255) NOT NULL,
    url_imagem VARCHAR(255),
    ts_alpr    DATETIME,
    PRIMARY KEY (id_alpr)
);

CREATE TABLE evento_wifi
(
    id_evento_wifi BIGINT AUTO_INCREMENT NOT NULL,
    moto_id        BIGINT,
    gateway_id_gateway BIGINT,
    rssits_evento  INT,
    PRIMARY KEY (id_evento_wifi)
);

CREATE TABLE gateway
(
    id_gateway      BIGINT AUTO_INCREMENT NOT NULL,
    mac_address     VARCHAR(255) NOT NULL,
    descricao       VARCHAR(255),
    localid_zona_id BIGINT,
    PRIMARY KEY (id_gateway)
);

CREATE TABLE moto
(
    id       BIGINT AUTO_INCREMENT NOT NULL,
    modelo   VARCHAR(255),
    placa    VARCHAR(7),
    zona_id  BIGINT,
    status   SMALLINT,
    patio_id BIGINT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE patio
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    nome             VARCHAR(255),
    quantidade_vagas INT,
    metragem_zonaa   DOUBLE,
    metragem_zonab   DOUBLE,
    PRIMARY KEY (id)
);

CREATE TABLE usuario (
    id_user    BIGINT AUTO_INCREMENT NOT NULL,
    nome_user VARCHAR(255) NOT NULL,
    email     VARCHAR(255) NOT NULL UNIQUE,
    password  VARCHAR(255) NOT NULL,
    phone     VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_user)
);

CREATE TABLE zona
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    tipo_zona VARCHAR(255) NOT NULL,
    metragem  DOUBLE,
    nome      VARCHAR(255) NOT NULL,
    patio_id  BIGINT NOT NULL,
    PRIMARY KEY (id)
);

-- Adicionando as constraints UNIQUE
ALTER TABLE gateway
    ADD CONSTRAINT uc_gateway_mac_address UNIQUE (mac_address);

ALTER TABLE moto
    ADD CONSTRAINT uc_moto_placa UNIQUE (placa);

ALTER TABLE patio
    ADD CONSTRAINT uc_patio_nome UNIQUE (nome);

ALTER TABLE zona
    ADD CONSTRAINT uq_zona_patio_tipo UNIQUE (patio_id, tipo_zona);

-- Adicionando as chaves estrangeiras
ALTER TABLE evento_alpr
    ADD CONSTRAINT FK_EVENTOALPR_ON_MOTO FOREIGN KEY (moto_id) REFERENCES moto (id);

ALTER TABLE evento_wifi
    ADD CONSTRAINT FK_EVENTOWIFI_ON_GATEWAY_ID_GATEWAY FOREIGN KEY (gateway_id_gateway) REFERENCES gateway (id_gateway);

ALTER TABLE evento_wifi
    ADD CONSTRAINT FK_EVENTOWIFI_ON_MOTO FOREIGN KEY (moto_id) REFERENCES moto (id);

ALTER TABLE gateway
    ADD CONSTRAINT FK_GATEWAY_ON_LOCALID_ZONA FOREIGN KEY (localid_zona_id) REFERENCES zona (id);

ALTER TABLE moto
    ADD CONSTRAINT FK_MOTO_ON_ZONA FOREIGN KEY (zona_id) REFERENCES zona (id);

ALTER TABLE moto
    ADD CONSTRAINT FK_MOTO_PATIO FOREIGN KEY (patio_id) REFERENCES patio (id);

ALTER TABLE zona
    ADD CONSTRAINT FK_ZONA_PATIO FOREIGN KEY (patio_id) REFERENCES patio (id);
