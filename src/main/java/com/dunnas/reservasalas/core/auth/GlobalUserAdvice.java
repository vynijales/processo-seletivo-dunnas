package com.dunnas.reservasalas.core.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.dunnas.reservasalas.usuario.service.UsuarioResponse;
import com.dunnas.reservasalas.usuario.service.UsuarioService;

@ControllerAdvice
public class GlobalUserAdvice {

    @Autowired
    private UsuarioService usuarioService;

    @ModelAttribute
    public void storeUsuario(Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            Object principal = auth.getPrincipal();

            if (principal instanceof UserDetails) {
                String email = ((UserDetails) principal).getUsername();
                UsuarioResponse usuario = usuarioService.getByEmail(email);
                model.addAttribute("usuarioLogado", usuario);
            }
        }
    }
}

// @ControllerAdvice -> Indica que esta classe fornece conselhos globais para
// controladores.
// @ModelAttribute -> Anota um método que adiciona atributos ao modelo,
// tornando-os disponíveis para todas as views.
// Authentication auth = SecurityContextHolder.getContext().getAuthentication();
