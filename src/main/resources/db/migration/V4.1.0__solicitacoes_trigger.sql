CREATE OR REPLACE FUNCTION verificar_status_bloqueado()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status IN ('CANCELADO', 'FINALIZADO') THEN
        RAISE EXCEPTION 'Não é possível atualizar um agendamento com status %', OLD.status;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_impedir_atualizacao_status_bloqueado
BEFORE UPDATE ON solicitacoes_agendamentos
FOR EACH ROW
EXECUTE FUNCTION verificar_status_bloqueado();
