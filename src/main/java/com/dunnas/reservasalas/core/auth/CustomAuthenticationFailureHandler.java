package com.dunnas.reservasalas.core.auth;

import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.core.AuthenticationException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        String errorMessage = "Usuário ou senha inválidos.";
        if (exception.getMessage().contains("Bad credentials")) {
            errorMessage = "Senha incorreta.";
        } else if (exception.getMessage().contains("User is disabled")) {
            errorMessage = "Usuário desativado.";
        } else if (exception.getMessage().contains("User account has expired")) {
            errorMessage = "Conta expirada.";
        }
        request.getSession().setAttribute("errorMessage", errorMessage);
        response.sendRedirect("/login?error");
    }
}
