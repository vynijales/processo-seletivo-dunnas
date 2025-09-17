package com.dunnas.reservasalas.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Autowired
    private com.dunnas.reservasalas.core.auth.CustomAuthenticationFailureHandler customFailureHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // desabilitar CSRF para simplificar (não recomendado para produção)
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        // Todas as rotas públicas
                        .requestMatchers("/entrar", "/processar-login").permitAll()

                        // Clientes não podem criar criar usuários
                        .requestMatchers("/usuarios/criar")
                        .hasAnyAuthority("ADMINISTRADOR", "RECEPCIONISTA")
                        .requestMatchers("/usuarios/*/editar").authenticated()

                        .requestMatchers("/WEB-INF/views/**", "/entrar",
                                "/index",
                                "/static/**")
                        .permitAll()
                        .anyRequest().authenticated())

                .formLogin(form -> form
                        .loginPage("/entrar")
                        .loginProcessingUrl("/processing-login")
                        .failureHandler(customFailureHandler)
                        .usernameParameter("email")
                        .passwordParameter("password")
                        .defaultSuccessUrl("/", true)
                        .permitAll())
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/entrar?logout")
                        .permitAll());

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
