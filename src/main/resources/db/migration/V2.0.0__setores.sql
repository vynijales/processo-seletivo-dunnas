CREATE TABLE IF NOT EXISTS setores (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_caixa NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    recepcionista_id BIGINT,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_setores_recepcionista FOREIGN KEY (recepcionista_id) REFERENCES usuarios(id) ON DELETE SET NULL
    
);
