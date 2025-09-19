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


CREATE TABLE IF NOT EXISTS solicitacoes_agendamentos (
    id BIGSERIAL PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    sala_id BIGINT NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'SOLICITADO', -- PENDENTE, CONFIRMADO, CANCELADO
    sinal_pago BOOLEAN NOT NULL DEFAULT FALSE, -- Indica se o sinal de 50% foi pago
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_pago NUMERIC(10, 2),

    CONSTRAINT fk_solicitacoes_cliente FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_solicitacoes_sala FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE,

    CONSTRAINT chk_status_valido CHECK (status IN ('SOLICITADO', 'CONFIRMADO', 'CANCELADO', 'FINALIZADO')),
    CONSTRAINT chk_data_inicio_futura CHECK (data_inicio >= CURRENT_TIMESTAMP),
    CONSTRAINT chk_data_fim_maior CHECK (data_fim > data_inicio)
);

CREATE TABLE IF NOT EXISTS agendamentos (
    id BIGSERIAL PRIMARY KEY,
    solicitacao_id BIGINT,
    cliente_id BIGINT NOT NULL,
    sala_id BIGINT NOT NULL,

    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    valor_pago NUMERIC(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'ATIVO', -- ATIVO, FINALIZADO, CANCELADO
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Set NULL: se a solicitação ou cliente for deletada, o agendamento mantém os dados, mas perde a referência
    CONSTRAINT fk_agendamentos_solicitacao FOREIGN KEY (solicitacao_id) REFERENCES solicitacoes_agendamentos(id) ON DELETE SET NULL,
    CONSTRAINT fk_agendamentos_cliente FOREIGN KEY (cliente_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    
    -- Cascata: se a sala for deletado, todos os agendamentos associados a ele também serão deletados
    CONSTRAINT fk_agendamentos_sala FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE,

    CONSTRAINT chk_status_agendamento_valido CHECK (status IN ('ATIVO', 'FINALIZADO', 'CANCELADO')),
    CONSTRAINT chk_valor_pago_positivo CHECK (valor_pago >= 0)
);

-- -Você deverá desenvolver um Sistema de Gerenciamento de Reserva de Salas, que contempla três tipos de usuários: Administrador, Recepcionista e Cliente. O Administrador vai ter o papel de configuração do sistema, realizando o cadastro dos recepcionistas, setores e salas dentro de um setor, o Recepcionista é o responsável por fazer o gerenciamento do seu setor, abrindo ele para poder realizar as entradas das reservas dos clientes e receber os valores das reservas após a saída do cliente, e o Cliente é o usuário final, que faz a solicitação do agendamento da sala e paga um sinal referente à 50% do valor da sala no ato de confirmação do agendamento. O sistema deve permitir o cadastro livre apenas de novos Clientes, o Administrador padrão deve ser definido por meio de uma seed e os Recepcionistas são adicionados apenas pelo Administrador. O sistema deve contemplar um histórico de todas as transações e agendamentos realizados, sendo eles finalizados ou cancelados, para o Cliente, todos os agendamentos realizados por ele, para o Recepcionista, todos do seu setor, e para o Admin, de todos os setores. Resumo das funcionalidades: - CRUD de setores (Admin) - CRUD de salas (Admin) - CRUD de recepcionistas (Admin) - Visualização de salas disponíveis e seus determinados valores - Solicitação de agendamento de sala - Confirmação de agendamento de sala - Finalização da utilização da sala - Relatórios Requisitos: Stack: ● Backend: Java Spring Boot ● View: Java Server Pages (JSP) ● Banco de dados: PostgreSQL Versionamento de banco de dados: ● Utilize o Flyway para versionar todas as alterações no banco, incluindo criação de tabelas, procedures, functions e demais objetos. ● O versionamento deve estar completo e permitir que qualquer pessoa possa subir o banco do zero. Lógica de negócio: ● Para este desafio, Pelo menos 50% da lógica de negócio deve estar implementada diretamente no banco de dados, como transações, validações e cálculos. Core: ● Admin o Fazer todo o fluxo básico de CRUD de salas, setores e recepcionistas, um setor é composto por várias salas e apenas um recepcionista, cada setor tem um valor em caixa que deve ser incrementado à medida que são os agendamentos são feitos e finalizados, cada sala tem um valor de aluguel e capacidade máxima ● Recepcionista o Responsável por organizar os agendamentos das salas do seu setor o Visualização de solicitações de agendamentos realizados por usuários e possibilidade de confirmação desses agendamentos o Visualização de todos os agendamentos confirmados e finalizados o Abertura e fechamento do setor, com relatórios dos valores em caixa o Agendamento instantâneo de uma sala, sem precisar da solicitação de um cliente o Uma sala não pode ser agendada mais de uma vez no mesmo período de tempo ● Cliente o Visualização de todos os setores e salas disponíveis nesses setores o Solicitação de agendamento para uma sala, enquanto essa solicitação não for confirmada pelo recepcionista, podem existir várias solicitações para uma mesma sala Autenticação: ● Implementar autenticação de usuários (clientes e locadores) com controle de acesso baseado em papéis. Documentação: ● Explique o processo de desenvolvimento, decisões de arquitetura e as principais funcionalidades. ● Inclua o diagrama relacional do banco de dados. ● Descrever claramente quais regras residem no banco e quais na aplicação. ● Incluir instruções de setup (build, execução, credenciais iniciais, migrações). ● Acrescente qualquer informação que julgar pertinente para compreensão do projeto. Pontos de avaliação: ● Entendimento da lógica de negócio ● Distribuição adequada da lógica entre aplicação e banco ● Organização e clareza do código e dos scripts de banco ● Uso correto e eficiente do Flyway para versionamento ● Implementação dos conceitos de MVC ● Uso das funcionalidades do banco de dados e as funcionalidades que foram implementadas nele ● Interface web intuitiva e funcional ● Tempo de entrega
