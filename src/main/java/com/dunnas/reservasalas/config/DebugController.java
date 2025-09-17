package com.dunnas.reservasalas.config;

import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DebugController {

    @GetMapping("/debug/auth")
    public String debugAuth(Authentication authentication) {
        if (authentication == null) {
            return "Nenhum usuário autenticado";
        }

        String username = authentication.getName();
        String authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(", "));

        return String.format("Usuário: %s | Authorities: %s", username, authorities);
    }
}
