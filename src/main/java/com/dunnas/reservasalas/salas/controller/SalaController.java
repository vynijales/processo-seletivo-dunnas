package com.dunnas.reservasalas.salas.controller;

import java.util.List;

import jakarta.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.dunnas.reservasalas.core.auth.AuthenticationController;
import com.dunnas.reservasalas.salas.model.Sala;
import com.dunnas.reservasalas.salas.service.SalaRequest;
import com.dunnas.reservasalas.salas.service.SalaService;
import com.dunnas.reservasalas.setores.model.Setor;
import com.dunnas.reservasalas.setores.service.SetorService;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.service.UsuarioResponse;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/salas")
public class SalaController {
    private final SalaService salaService;
    private final SetorService setorService;
    private final AuthenticationController autenticationController;

    @GetMapping
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "nome") String sort,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
        Page<Sala> salas;

        if (q != null && !q.trim().isEmpty()) {
            salas = salaService.search(q.trim(), pageable);
            model.addAttribute("query", q);
        } else {
            salas = salaService.list(pageable);
        }

        model.addAttribute("salas", salas);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", salas.getTotalPages());
        model.addAttribute("totalItems", salas.getTotalElements());

        model.addAttribute("contentPage", "features/sala/sala-listar.jsp");
        return "base";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Sala sala = salaService.getById(id);

        if (sala == null) {
            model.addAttribute("errorMessage", "Sala não encontrada no nosso banco de dados");
        }

        model.addAttribute("sala", sala);
        model.addAttribute("contentPage", "features/sala/sala-detalhes.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR', 'FUNCIONARIO')")
    @GetMapping("/criar")
    public String showCreateForm(Model model) {

        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Setor> setores;
        if (usuarioLogado != null) {

            if (usuarioLogado.getRole() == UsuarioRole.ADMINISTRADOR) {
                setores = setorService.list();

            } else {
                final long id = usuarioLogado.getId();
                setores = (setorService.getAllByRecepcionistaId(id));
            }
        } else {
            return "base";
        }

        model.addAttribute("setores", setores);
        model.addAttribute("salasRequest", SalaRequest.builder().build());
        model.addAttribute("contentPage", "features/sala/sala-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/editar")
    public String showEditForm(@PathVariable Long id, Model model) {
        Sala sala = salaService.getById(id);
        if (sala == null) {
            return "redirect:/salas";
        }

        List<Setor> setores;
        try {
            UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
            if (usuarioLogado != null) {

                if (usuarioLogado.getRole() == UsuarioRole.ADMINISTRADOR) {
                    setores = setorService.list();

                } else {
                    final long usuarioId = usuarioLogado.getId();
                    setores = (setorService.getAllByRecepcionistaId(usuarioId));
                }
            } else {
                return "base";
            }

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.toString());
            return null;
        }

        model.addAttribute("setores", setores);
        model.addAttribute("sala", sala);
        model.addAttribute("contentPage", "features/sala/sala-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping
    public String create(
            @Valid @ModelAttribute("sala") SalaRequest sala,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        final String path = "features/sala/sala-form.jsp";

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", result.getAllErrors());
            model.addAttribute("contentPage", path);
            return "base";
        }
        try {
            Sala savedSetor = salaService.create(sala);
            redirectAttributes.addFlashAttribute("successMessage", "Setor criado com sucesso!");
            return "redirect:/salas/" + savedSetor.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar sala: " + e.getMessage());
            model.addAttribute("contentPage", path);
            return "base";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR)")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            salaService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Sala excluída com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir sala: " + e.getMessage());
        }

        return "redirect:/setores";
    }
}
