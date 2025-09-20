CREATE TABLE IF NOT EXISTS agendamentos (
    id BIGSERIAL PRIMARY KEY,
    solicitacao_id BIGINT,
    cliente_id BIGINT NOT NULL,
    sala_id BIGINT NOT NULL,

    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    valor_pago NUMERIC(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDENTE_PAGAMENTO', -- ATIVO, FINALIZADO, CANCELADO
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Set NULL: se a solicitação ou cliente for deletada, o agendamento mantém os dados, mas perde a referência
    CONSTRAINT fk_agendamentos_solicitacao FOREIGN KEY (solicitacao_id) REFERENCES solicitacoes_agendamentos(id) ON DELETE SET NULL,
    CONSTRAINT fk_agendamentos_cliente FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    
    -- Cascata: se a sala for deletado, todos os agendamentos associados a ele também serão deletados
    CONSTRAINT fk_agendamentos_sala FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE,

    CONSTRAINT chk_status_agendamento_valido CHECK (status IN ('PENDENTE_PAGAMENTO', 'CANCELADO', 'FINALIZADO')),
    CONSTRAINT chk_valor_pago_positivo CHECK (valor_pago >= 0)
);
