CREATE TABLE IF NOT EXISTS solicitacoes_agendamentos (
    id BIGSERIAL PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    sala_id BIGINT NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'SOLICITADO',
    sinal_pago BOOLEAN NOT NULL DEFAULT FALSE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_pago NUMERIC(10, 2),

    CONSTRAINT fk_solicitacoes_cliente FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_solicitacoes_sala FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE,
    CONSTRAINT chk_status_valido CHECK (status IN ('SOLICITADO', 'AGUARDANDO_PAGAMENTO', 'CONFIRMADO', 'CONFIRMADO_PAGO', 'CANCELADO', 'FINALIZADO')),
    CONSTRAINT chk_data_fim_maior CHECK (data_fim > data_inicio)
);
