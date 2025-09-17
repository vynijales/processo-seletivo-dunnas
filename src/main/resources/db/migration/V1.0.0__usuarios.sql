CREATE TABLE usuarios (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT FALSE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints adicionais para validação
    CONSTRAINT chk_email_valido CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_role_valida CHECK (role IN ('ADMINISTRADOR', 'RECEPCIONISTA', 'CLIENTE'))
);

-- Índices para melhor performance
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_usuarios_ativo ON usuarios(ativo);
CREATE INDEX idx_usuarios_role ON usuarios(role);

-- Comentários para documentação
COMMENT ON TABLE usuarios IS 'Tabela de usuários do sistema';
COMMENT ON COLUMN usuarios.id IS 'Identificador único do usuário';
COMMENT ON COLUMN usuarios.nome IS 'Nome completo do usuário (máx. 100 caracteres)';
COMMENT ON COLUMN usuarios.email IS 'Email único do usuário (usado para login)';
COMMENT ON COLUMN usuarios.senha IS 'Senha criptografada do usuário';
COMMENT ON COLUMN usuarios.role IS 'Papel do usuário no sistema (ADMIN, USER, MODERATOR)';
COMMENT ON COLUMN usuarios.ativo IS 'Status de ativação do usuário';
COMMENT ON COLUMN usuarios.data_criacao IS 'Data de criação do registro';
COMMENT ON COLUMN usuarios.data_atualizacao IS 'Data da última atualização do registro';

