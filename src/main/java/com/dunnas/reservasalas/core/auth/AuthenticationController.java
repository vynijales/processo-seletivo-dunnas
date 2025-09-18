package com.dunnas.reservasalas.core.auth;

import java.util.Arrays;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.service.UsuarioMapper;
import com.dunnas.reservasalas.usuario.service.UsuarioResponse;
import com.dunnas.reservasalas.usuario.service.UsuarioService;

@Controller
public class AuthenticationController {

    @Autowired
    UsuarioService usuarioService;

    @Autowired
    UsuarioMapper usuarioMapper;

    @GetMapping("/entrar")
    public String showLoginForm(HttpServletRequest request,
            @RequestParam(value = "logout", required = false) String logout,
            Model model) {
        System.out.println("Entrou no controller de login customizado!");
        Object errorMessage = request.getSession().getAttribute("errorMessage");
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "Logout realizado com sucesso.");
        }
        return "auth/entrar";
    }

    @GetMapping("/login")
    public String redirectLogin() {
        return "redirect:/entrar";
    }

    @GetMapping("/teste-controller")
    @ResponseBody
    public String teste() {
        System.out.println("Entrou no teste-controller!");
        return "Controller OK";
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("contentPage", "index.jsp");
        return "base";
    }

    public static boolean hasAnyRole(UsuarioRole... roles) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null)
            return false;

        return Arrays.stream(roles)
                .anyMatch(role -> authentication.getAuthorities().stream()
                        .anyMatch(a -> role.equals(UsuarioRole.valueOf(a.getAuthority()))));
    }

    @Autowired
    public UsuarioResponse usuarioAutenticado() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails || principal instanceof String) {
            String username = ((UserDetails) principal).getUsername();
            return usuarioService.getByEmail(username);
        }

        return null;
    }
}
