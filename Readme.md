# Sistema de Gerenciamento de Reserva de Salas

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