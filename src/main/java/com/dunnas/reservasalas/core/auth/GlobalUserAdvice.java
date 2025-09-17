package com.dunnas.reservasalas.core.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.dunnas.reservasalas.core.utils.Capitalizar;
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
            String nome, email, role;

            if (principal instanceof UserDetails) {
                email = ((UserDetails) principal).getUsername();
                nome = email.split("@")[0];
                role = ((UserDetails) principal).getAuthorities().stream().findFirst().map(Object::toString)
                        .orElse("VISITANTE");
            } else {
                email = principal.toString();
                nome = principal.toString();
                role = "VISITANTE";
            }

            Long usuarioId = usuarioService.getByEmail(email).getId();

            model.addAttribute("usuario_id", usuarioId);
            model.addAttribute("usuario_email", email);
            model.addAttribute("usuario_nome", Capitalizar.capitalizar(nome));
            model.addAttribute("usuario_role", Capitalizar.capitalizar(role));

        }
    }
}

// @ControllerAdvice -> Indica que esta classe fornece conselhos globais para
// controladores.
// @ModelAttribute -> Anota um método que adiciona atributos ao modelo,
// tornando-os disponíveis para todas as views.
// Authentication auth = SecurityContextHolder.getContext().getAuthentication();
