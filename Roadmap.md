## Dependências Essenciais

1. **[[Spring Web]]** - Para construção de aplicativos web, incluindo RESTful
2. **[[Spring Data JPA]]** - Para persistência de dados com Java Persistence API
3. **[[Spring Security]]** - Para autenticação e autorização
4. **[[PostgreSQL Driver]]** - Driver JDBC para o banco PostgreSQL
5. **[[Flyway Migration]]** - Para versionamento do banco de dados
6. **Spring Boot [[DevTools]]** - Para desenvolvimento (recarregamento automático)
7. **JSP ([[JavaServer Pages]])** - Para as views (requer configuração manual)
8. **[[Lombok]]** - Para reduzir o boilerplate code

## Dependências Adicionais Úteis

1. **[[Bean Validation]]** - Para validação de beans
2. **[[Spring Boot Starter Test]]** - Para testes
3. **[[Spring Session]]** - Para gerenciamento de sessão (opcional)
4. **[[Spring Boot Actuator]]** - Para monitoramento e métricas

## Configuração Manual Necessária

Como o Spring Initializr não oferece suporte direto a JSP, você precisará adicionar manualmente:

### No pom.xml (para Maven):

```xml
<!-- Para suporte a JSP -->
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
</dependency>

<!-- JSTL para JSP -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
</dependency>
```

### Configuração no application.properties:

```properties
# Configuração do ViewResolver para JSP
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp

# Banco de dados PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:5432/reserva_salas
spring.datasource.username=seu_usuario
spring.datasource.password=sua_senha

# JPA config
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true

# Flyway
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
```

## Estrutura de Pacotes

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── reservasalas/
│   │           ├── ReservaSalasApplication.java
│   │           ├── core/
│   │           │   ├── config/
│   │           │   │   ├── SecurityConfig.java
│   │           │   │   ├── JwtAuthenticationFilter.java
│   │           │   │   └── JwtUtil.java
│   │           │   ├── exception/
│   │           │   │   └── GlobalExceptionHandler.java
│   │           │   └── util/
│   │           │       └── Validators.java
│   │           ├── auth/
│   │           │   ├── dto/
│   │           │   │   ├── LoginRequest.java
│   │           │   │   ├── JwtResponse.java
│   │           │   │   └── RegisterRequest.java
│   │           │   ├── entity/
│   │           │   │   └── Usuario.java
│   │           │   ├── repository/
│   │           │   │   └── UsuarioRepository.java
│   │           │   ├── service/
│   │           │   │   ├── UserDetailsServiceImpl.java
│   │           │   │   └── AuthService.java
│   │           │   └── controller/
│   │           │       └── AuthController.java
│   │           ├── sala/
│   │           │   ├── dto/
│   │           │   │   ├── SalaRequest.java
│   │           │   │   ├── SalaResponse.java
│   │           │   │   └── SalaFilter.java
│   │           │   ├── entity/
│   │           │   │   └── Sala.java
│   │           │   ├── repository/
│   │           │   │   └── SalaRepository.java
│   │           │   ├── service/
│   │           │   │   └── SalaService.java
│   │           │   └── controller/
│   │           │       └── SalaController.java
│   │           ├── reserva/
│   │           │   ├── dto/
│   │           │   │   ├── ReservaRequest.java
│   │           │   │   ├── ReservaResponse.java
│   │           │   │   └── ReservaFilter.java
│   │           │   ├── entity/
│   │           │   │   └── Reserva.java
│   │           │   ├── repository/
│   │           │   │   └── ReservaRepository.java
│   │           │   ├── service/
│   │           │   │   └── ReservaService.java
│   │           │   └── controller/
│   │           │       └── ReservaController.java
│   │           └── shared/
│   │               ├── dto/
│   │               │   └── ApiResponse.java
│   │               └── enums/
│   │                   ├── Role.java
│   │                   ├── StatusSala.java
│   │                   └── StatusReserva.java
│   ├── resources/
│   │   ├── static/
│   │   │   ├── css/
│   │   │   ├── js/
│   │   │   └── images/
│   │   ├── templates/
│   │   │   ├── auth/
│   │   │   ├── salas/
│   │   │   └── reservas/
│   │   ├── application.properties
│   │   └── db/
│   │       └── migration/
│   └── webapp/
│       └── WEB-INF/
│           └── jsp/
│               ├── auth/
│               │   ├── login.jsp
│               │   └── register.jsp
│               ├── salas/
│               │   ├── list.jsp
│               │   ├── form.jsp
│               │   └── view.jsp
│               ├── reservas/
│               │   ├── list.jsp
│               │   ├── form.jsp
│               │   └── my-reservations.jsp
│               ├── layout/
│               │   ├── header.jsp
│               │   ├── footer.jsp
│               │   └── navbar.jsp
│               └── index.jsp
└── test/
    └── java/
        └── com/
            └── reservasalas/
                ├── auth/
                ├── sala/
                ├── reserva/
                └── core/
```

Essas dependências e configurações fornecerão uma base sólida para implementar o Sistema de Gerenciamento de Reserva de Salas conforme os requisitos especificados.
