package com.dunnas.reservasalas.core.auth;

import java.util.Arrays;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dunnas.reservasalas.core.exceptions.EmailDuplicadoException;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.service.UsuarioMapper;
import com.dunnas.reservasalas.usuario.service.UsuarioRequest;
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

        Object errorMessage = request.getSession().getAttribute("errorMessage");
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }

        // Verificar se há mensagem de sucesso (após criação de conta)
        Object successMessage = request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            model.addAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }

        if (logout != null) {
            model.addAttribute("usuarioRequest", null);
            model.addAttribute("logoutMessage", "Logout realizado com sucesso.");
        }

        return "auth/entrar";
    }

    @GetMapping("/login")
    public String redirectLogin() {
        return "redirect:/entrar";
    }

    @GetMapping("/criar-conta")
    public String criarConta(Model model) {
        model.addAttribute("usuarioRequest", UsuarioRequest.builder().build());
        return "auth/criar-conta";
    }

    @PostMapping("/processar-criar-conta")
    public String processarCriarConta(
            @ModelAttribute @Valid UsuarioRequest usuarioRequest,
            BindingResult result,
            HttpServletRequest request, // Adicionado HttpServletRequest
            Model model) {

        // Validação manual da senha
        if (usuarioRequest.getSenha() == null || usuarioRequest.getSenha().length() < 8) {
            result.rejectValue("senha", "error.senha", "Senha deve ter pelo menos 8 caracteres");
        }

        if (result.hasErrors()) {
            model.addAttribute("usuarioRequest", usuarioRequest);
            model.addAttribute("errors", result.getAllErrors());
            return "auth/criar-conta";
        }

        try {
            usuarioRequest.setRole(UsuarioRole.CLIENTE);
            usuarioRequest.setAtivo(true);

            usuarioService.create(usuarioRequest);

            // Armazena a mensagem de sucesso na sessão
            request.getSession().setAttribute("successMessage",
                    "Conta criada com sucesso! Faça login para continuar.");

            return "redirect:/entrar";
        } catch (EmailDuplicadoException e) {
            model.addAttribute("errorMessage", "Este email já está cadastrado.");
            model.addAttribute("usuarioRequest", usuarioRequest);
            return "auth/criar-conta";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar conta: " + e.getMessage());
            model.addAttribute("usuarioRequest", usuarioRequest);
            return "auth/criar-conta";
        }
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
