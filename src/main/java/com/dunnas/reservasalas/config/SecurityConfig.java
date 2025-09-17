package com.dunnas.reservasalas.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

        private final UsuarioRepository usuarioRepository;

        @Autowired
        public SecurityConfig(UsuarioRepository usuarioRepository) {
                this.usuarioRepository = usuarioRepository;
        }

        @Autowired
private com.dunnas.reservasalas.core.auth.CustomAuthenticationFailureHandler customFailureHandler;

@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
        // desabilitar CSRF para simplificar (não recomendado para produção)
        .csrf(csrf -> csrf.disable())
        .authorizeHttpRequests(auth -> auth
            .requestMatchers(HttpMethod.GET, "/login").permitAll()
            .requestMatchers("/WEB-INF/views/**", "/login",
                "index",
                "/css/**", "/js/**")
            .permitAll()
            .anyRequest().authenticated())
        .formLogin(form -> form
            .loginPage("/login")
            .loginProcessingUrl("/processing-login")
            .failureHandler(customFailureHandler)
            .usernameParameter("email")
            .passwordParameter("password")
            .defaultSuccessUrl("/", true)
            .permitAll())
        .logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/login?logout")
            .permitAll());

    return http.build();
}


        @Bean
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

}
