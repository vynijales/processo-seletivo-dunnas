package com.dunnas.reservasalas;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication()
public class ReservaSalasApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(ReservaSalasApplication.class, args);
	}

}

// @SpringBootApplication -> Marca a classe como uma aplicação Spring Boot

// exclude = { SecurityAutoConfiguration.class } -> Desativa a configuração
// automática de segurança (Spring Security)
