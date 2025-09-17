package com.dunnas.reservasalas.core.auth;

import jakarta.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthenticationController extends HttpServlet {

    @GetMapping("/login")
public String showLoginForm(jakarta.servlet.http.HttpServletRequest request,
        @RequestParam(value = "logout", required = false) String logout,
        Model model) {
    Object errorMessage = request.getSession().getAttribute("errorMessage");
    if (errorMessage != null) {
        model.addAttribute("errorMessage", errorMessage);
        request.getSession().removeAttribute("errorMessage");
    }
    if (logout != null) {
        model.addAttribute("logoutMessage", "Logout realizado com sucesso.");
    }
    return "auth/login";
}
}
