CREATE TABLE IF NOT EXISTS salas (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL, -- Número máximo de pessoas
    valor_aluguel NUMERIC(10, 2) ,
    setor_id BIGINT NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Deleção e atualização em cascata
    CONSTRAINT fk_salas_setor FOREIGN KEY (setor_id) 
        REFERENCES setores(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT chk_capacidade_positiva CHECK (capacidade > 0),
    CONSTRAINT chk_valor_aluguel_positivo CHECK (valor_aluguel >= 0)
);
