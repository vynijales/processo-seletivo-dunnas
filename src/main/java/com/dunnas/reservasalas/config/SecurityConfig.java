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

import com.dunnas.reservasalas.core.auth.CustomAuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	@Autowired
	private CustomAuthenticationFailureHandler customFailureHandler;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
				// desabilitar CSRF para simplificar (não recomendado para produção)
				.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(auth -> auth
						// Todas as rotas públicas
						.requestMatchers("/entrar", "/criar-conta", "/processar-entrar", "/processar-criar-conta")
						.permitAll()
						.requestMatchers(HttpMethod.POST, "/usuarios").permitAll()

						.requestMatchers("/WEB-INF/views/**",
								"/index",
								"/static/**")
						.permitAll()
						.anyRequest().authenticated())

				.formLogin(form -> form
						.loginPage("/entrar")
						.loginProcessingUrl("/processar-entrar")
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
