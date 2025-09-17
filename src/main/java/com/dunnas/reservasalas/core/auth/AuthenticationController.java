package com.dunnas.reservasalas.core.auth;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AuthenticationController {

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
}
