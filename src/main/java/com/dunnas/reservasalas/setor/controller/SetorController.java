package com.dunnas.reservasalas.setor.controller;

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

import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.setor.service.SetorRequest;
import com.dunnas.reservasalas.setor.service.SetorService;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.service.UsuarioService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/setores")
public class SetorController {
    private final SetorService setorService;
    private final UsuarioService usuarioService;

    @GetMapping
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "nome") String sort,
            Model model) {

        final String path = "features/setor/setor-listar.jsp";

        // if (result.hasErrors()) {
        // model.addAttribute("errorMessage", result.getAllErrors());
        // model.addAttribute("contentPage", path);
        // return "base";
        // }

        Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
        Page<Setor> setores;

        if (q != null && !q.trim().isEmpty()) {
            setores = setorService.search(q.trim(), pageable);
            model.addAttribute("query", q);
        } else {
            setores = setorService.list(pageable);
        }

        model.addAttribute("setores", setores);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", setores.getTotalPages());
        model.addAttribute("totalItems", setores.getTotalElements());

        model.addAttribute("contentPage", path);
        return "base";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Setor setor = setorService.getById(id);

        if (setor == null) {
            model.addAttribute("errorMessage", "Setor não encontrado no nosso banco de dados");
        }

        model.addAttribute("setor", setor);
        model.addAttribute("contentPage", "features/setor/setor-detalhes.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/criar")
    public String showCreateForm(Model model) {
        List<UsuarioRole> roles = List.of(UsuarioRole.ADMINISTRADOR, UsuarioRole.RECEPCIONISTA);

        model.addAttribute("usuarios", usuarioService.list(roles));
        model.addAttribute("setorRequest", SetorRequest.builder().build());
        model.addAttribute("contentPage", "features/setor/setor-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/editar")
    public String showEditForm(@PathVariable Long id, Model model) {
        Setor setor = setorService.getById(id);
        if (setor == null) {
            return "redirect:/setores";
        }

        List<UsuarioRole> roles = List.of(UsuarioRole.ADMINISTRADOR, UsuarioRole.RECEPCIONISTA);

        SetorRequest setorRequest = SetorRequest.builder()
                .id(setor.getId())
                .nome(setor.getNome())
                .valorCaixa(setor.getValorCaixa())
                .recepcionistaId(setor.getRecepcionista() != null ? setor.getRecepcionista().getId() : null)
                .ativo(setor.getAtivo())
                .build();

        model.addAttribute("setorRequest", setorRequest);
        model.addAttribute("usuarios", usuarioService.list(roles));
        model.addAttribute("contentPage", "features/setor/setor-form.jsp");

        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping
    public String create(
            @Valid @ModelAttribute("setorRequest") SetorRequest setorRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        List<UsuarioRole> roles = List.of(UsuarioRole.ADMINISTRADOR, UsuarioRole.RECEPCIONISTA);
        model.addAttribute("usuarios", usuarioService.list(roles));

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors()); // Adiciona erros específicos
            model.addAttribute("contentPage", "features/setor/setor-form.jsp");
            return "base";
        }

        try {
            Setor savedSetor = setorService.create(setorRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Setor criado com sucesso!");
            return "redirect:/setores/" + savedSetor.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar setor: " + e.getMessage());
            model.addAttribute("setorRequest", setorRequest); // Mantém os dados preenchidos
            model.addAttribute("contentPage", "features/setor/setor-form.jsp");
            return "base";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping("/{id}/editar")
    public String update(
            @PathVariable Long id,
            @Valid @ModelAttribute("setorRequest") SetorRequest setorRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        List<UsuarioRole> roles = List.of(UsuarioRole.ADMINISTRADOR, UsuarioRole.RECEPCIONISTA);
        model.addAttribute("usuarios", usuarioService.list(roles));

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors()); // Adiciona erros específicos
            model.addAttribute("contentPage", "features/setor/setor-form.jsp");
            return "base";
        }

        try {
            Setor updatedSetor = setorService.update(id, setorRequest);
            if (updatedSetor == null) {
                model.addAttribute("errorMessage", "Setor não encontrado.");
                model.addAttribute("setorRequest", setorRequest);
                model.addAttribute("contentPage", "features/setor/setor-form.jsp");
                return "base";
            }
            redirectAttributes.addFlashAttribute("successMessage", "Setor atualizado com sucesso!");
            return "redirect:/setores/" + updatedSetor.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao atualizar setor: " + e.getMessage());
            model.addAttribute("setorRequest", setorRequest); // Mantém os dados preenchidos
            model.addAttribute("contentPage", "features/setor/setor-form.jsp");
            return "base";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            setorService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Setor excluído com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir setor: " + e.getMessage());
        }

        return "redirect:/setores";
    }

}
