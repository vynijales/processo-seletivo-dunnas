# Boas práticas para migrações de banco de dados


## Versionamento Semântico
Use versionamento semântico para nomear seus arquivos de migração. O formato recomendado é `
V<major>.<minor>.<patch>__<description>.sql`, onde:
- `<major>`: Incrementado para mudanças incompatíveis.
- `<minor>`: Incrementado para adições de funcionalidades compatíveis.
- `<patch>`: Incrementado para correções de bugs compatíveis.
- `<description>`: Uma breve descrição da migração, usando underscores para separar palavras.

```sql
-- Exemplo: V1.0.0__create_users_table.sql
-- Exemplo: V1.1.0__add_email_to_users.sql
-- Exemplo: V1.1.1__fix_user_email_index.sql
```

## Scripts Idempotentes
Escreva scripts que possam ser executados múltiplas vezes sem causar erros:

```sql
CREATE TABLE IF NOT EXISTS produto (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);
```

## Solução de Problemas

### Problemas Comuns
1. **Migração com erro**: Use `flyway:repair` para reparar o histórico
2. **Conflito de versões**: Nunca edite migrações já aplicadas
3. **Problemas de validação**: Verifique checksums com `flyway:validate`

### Migrações com Falha
Se uma migração falhar:
1. O Flyway revert automaticamente a transação
2. Corrija o script SQL
3. Execute `flyway:repair` se necessário
4. Execute `flyway:migrate` novamente
