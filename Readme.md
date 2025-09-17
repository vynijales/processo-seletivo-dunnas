# Sistema de Gerenciamento de Reserva de Salas

## Arquitetura
- **Feature-based:** admin, recepcionista, cliente, auth, core
- **MVC:** Model (entities, repositories), View (JSPs), Controller (REST endpoints), Service (business logic)
- **Spring Boot + JSP + PostgreSQL + Flyway**

## Diagrama Relacional
```
USUARIO (id, nome, email, senha, role, ativo)
   |
   |--< SETOR (id, nome, recepcionista_id, caixa, ativo)
         |
         |--< SALA (id, nome, setor_id, valor, capacidade, ativo)

RESERVA (id, sala_id, cliente_id, recepcionista_id, status, data_inicio, data_fim, valor, sinal_pago, ...)
   |
   |--< TRANSACAO (id, reserva_id, tipo, valor, usuario_id, data)
```

## Setup
1. Clone o projeto
2. Configure o banco PostgreSQL e credenciais em `application.yaml`
3. Execute as migrações Flyway (`mvn flyway:migrate`)
4. Build e rode o projeto (`./mvnw spring-boot:run`)
5. Acesse via navegador (`http://localhost:8080`)
6. Admin inicial: `admin@reservasalas.com` / senha: `adminpasswordhash` (troque para hash real)

## Lógica de Negócio
- **No banco:**
  - Prevenção de duplo agendamento (trigger)
  - Atualização de caixa do setor (trigger)
  - Transações de pagamento (trigger)
  - Relatórios/histórico (views)
- **Na aplicação:**
  - Orquestração, validação, fluxo de usuário, autenticação

## Decisões
- Feature folders para escalabilidade
- Lógica crítica no banco para performance e integridade
- Spring Security para RBAC
- JSP para views simples e dinâmicas

## Observações
- Adicione recepcionistas e setores via admin
- Clientes podem se registrar livremente
- Recepcionista gerencia apenas seu setor
- Relatórios disponíveis por papel

---
Para dúvidas, consulte o código ou entre em contato.

## 📋 Descrição do Projeto

Sistema de gerenciamento de reservas de salas com três tipos de usuários: Administrador, Recepcionista e Cliente.

## 👥 Tipos de Usuários

### Administrador
- Configuração do sistema
- Cadastro de recepcionistas, setores e salas
- Visualização de histórico completo de todas as transações

### Recepcionista
- Gerenciamento do setor designado
- Abertura/fechamento do setor
- Confirmação de solicitações de reserva
- Realização de agendamentos instantâneos
- Visualização de histórico do setor

### Cliente
- Visualização de salas disponíveis
- Solicitação de agendamento de sala
- Pagamento de 50% do valor como sinal
- Visualização do próprio histórico

## 🚀 Funcionalidades Principais

- **CRUD de setores** (Admin)
- **CRUD de salas** (Admin)
- **CRUD de recepcionistas** (Admin)
- **Visualização de salas disponíveis** e valores
- **Solicitação de agendamento** de sala
- **Confirmação de agendamento** de sala
- **Finalização da utilização** da sala
- **Relatórios** financeiros e de utilização

## 🛠 Stack Tecnológica

- **Backend**: Java Spring Boot
- **View**: Java Server Pages (JSP)
- **Banco de dados**: PostgreSQL
- **Versionamento de BD**: Flyway

## 📊 Distribuição da Lógica de Negócio

Pelo menos **50% da lógica de negócio** será implementada diretamente no banco de dados através de:
- Stored procedures
- Functions
- Triggers
- Constraints
- Transações

## 🔐 Autenticação e Autorização

Sistema de autenticação com controle de acesso baseado em papéis (RBAC) para os três tipos de usuários.

## 📁 Estrutura do Projeto

```
sistema-reserva-salas/
├── src/
│   ├── main/
│   │   ├── java/
│   │   ├── resources/
│   │   │   └── db/
│   │   │       └── migration/
│   │   └── webapp/
│   └── test/
├── documentation/
│   └── database-diagram.md
└── README.md
```

## Arquitetura de persistência e camadas

 Banco de Dados
     ^
     | (Lê/Grava)
     |
[ ENTITY ]  ->  (Camada de Persistência: Repository)
     ^
     | (Usa)
     |
[ SERVICE ]  ->  (Camada de Lógica de Negócio)
     ^
     | (Usa/Conversão)
     |
[ CONTROLLER ]
     ^
     | (Retorna)
     |
[  DTO   ]  <-  (Data Transfer Object) -> [ VIEW / API RESPONSE ]

## ⚙️ Setup e Configuração

### Pré-requisitos
- Java JDK 11+
- PostgreSQL 12+
- Maven 3.6+

### Instalação
1. Clone o repositório
2. Configure as credenciais do banco em `application.properties`
3. Execute `mvn flyway:migrate` para criar a estrutura do banco
4. Execute `mvn spring-boot:run` para iniciar a aplicação

### Credenciais Iniciais
O administrador padrão será criado via seed com as credenciais:
- Email: admin@system.com
- Senha: admin123

## 📝 Documentação Adicional

Para informações detalhadas sobre:
- Diagrama relacional do banco de dados
- Decisões de arquitetura
- Regras implementadas no banco vs aplicação
- Instruções completas de setup

Consulte a documentação completa no diretório `documentation/` do projeto.
