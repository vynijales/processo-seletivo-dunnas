package com.dunnas.reservasalas.usuario.controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.service.UsuarioService;
import com.dunnas.reservasalas.usuario.utils.UsuarioRequest;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/usuarios")
public class UsuarioController extends HttpServlet {
    private final UsuarioService usuarioService;

    @GetMapping
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "nome") String sort,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
        Page<Usuario> usuarios;

        if (q != null && !q.trim().isEmpty()) {
            usuarios = usuarioService.search(q.trim(), pageable);
            model.addAttribute("query", q);
        } else {
            usuarios = usuarioService.list(pageable);
        }

        model.addAttribute("usuarios", usuarios);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", usuarios.getTotalPages());
        model.addAttribute("totalItems", usuarios.getTotalElements());

        return "features/usuario/lista";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Usuario usuario = usuarioService.getById(id);
        model.addAttribute("usuario", usuario);
        return "features/usuario/detalhes";
    }

    @GetMapping("/criar")
    public String createForm(Model model) {
        model.addAttribute("usuarioRequest", UsuarioRequest.builder().build());
        return "features/usuario/form-criar";
    }

    @GetMapping("/{id}/editar")
    public String editForm(@PathVariable Long id, Model model) {
        Usuario usuario = usuarioService.getById(id);
        UsuarioRequest request = UsuarioRequest.builder()
                .id(usuario.getId())
                .nome(usuario.getNome())
                .email(usuario.getEmail())
                .role(usuario.getRole())
                .build();
        model.addAttribute("usuarioRequest", request);
        return "features/usuario/form-editar";
    }

    @PostMapping("/criar")
    public String create(
            @ModelAttribute @Valid UsuarioRequest usuarioRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        // Validação manual da senha na criação
        if (usuarioRequest.getSenha() == null || usuarioRequest.getSenha().length() < 8) {
            result.rejectValue("senha", "error.senha", "Senha deve ter pelo menos 8 caracteres");
        }
        if (result.hasErrors()) {
            model.addAttribute("usuarioRequest", usuarioRequest);
            model.addAttribute("errors", result.getAllErrors());
            return "features/usuario/form-criar";
        }
        try {
            Usuario savedUsuario = usuarioService.create(usuarioRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Usuário criado com sucesso!");
            return "redirect:/usuarios/" + savedUsuario.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro: " + e.getMessage());
            redirectAttributes.addFlashAttribute("usuarioRequest", usuarioRequest);
            return "redirect:/usuarios/criar";
        }
    }

    @PostMapping("/{id}/editar")
    public String edit(
            @PathVariable Long id,
            @ModelAttribute @Valid UsuarioRequest usuarioRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        // Validação manual da senha na edição (só se preenchida)
        if (usuarioRequest.getSenha() != null && !usuarioRequest.getSenha().isBlank() && usuarioRequest.getSenha().length() < 8) {
            result.rejectValue("senha", "error.senha", "Senha deve ter pelo menos 8 caracteres");
        }
        if (result.hasErrors()) {
            model.addAttribute("usuarioRequest", usuarioRequest);
            model.addAttribute("errors", result.getAllErrors());
            return "features/usuario/form-editar";
        }
        try {
            usuarioRequest.setId(id); // Garante que o id está correto
            Usuario savedUsuario = usuarioService.update(usuarioRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Usuário atualizado com sucesso!");
            return "redirect:/usuarios/" + savedUsuario.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro: " + e.getMessage());
            redirectAttributes.addFlashAttribute("usuarioRequest", usuarioRequest);
            return "redirect:/usuarios/" + id + "/editar";
        }
    }

    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            usuarioService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Usuário excluído com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir usuário: " + e.getMessage());
        }
        return "redirect:/usuarios";
    }
}
