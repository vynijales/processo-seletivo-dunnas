package com.dunnas.reservasalas.sala.controller;

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
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.sala.service.SalaRequest;
import com.dunnas.reservasalas.sala.service.SalaService;
import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.setor.service.SetorService;
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
            @RequestParam(required = false) Integer setorId,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
        Page<Sala> salas;

        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Setor> setores;

        // Se for RECEPCIONISTA, filtra apenas os setores do usuário logado
        if (usuarioLogado.getRole() == UsuarioRole.RECEPCIONISTA) {
            setores = setorService.getAllByRecepcionistaId(usuarioLogado.getId());

            if (q != null && !q.trim().isEmpty()) {
                if (setorId != null) {
                    // Verifica se o setorId pertence ao recepcionista
                    if (setores.stream().anyMatch(s -> s.getId().equals(setorId.longValue()))) {
                        salas = salaService.getByQueryAndSetorId(q.trim(), setorId, pageable);
                    } else {
                        // Se o setor não pertence ao recepcionista, mostra apenas salas dos seus
                        // setores
                        salas = salaService.searchByRecepcionistaAndQuery(usuarioLogado.getId(), q.trim(), pageable);
                    }
                } else {
                    salas = salaService.searchByRecepcionistaAndQuery(usuarioLogado.getId(), q.trim(), pageable);
                }
            } else {
                if (setorId != null) {
                    // Verifica se o setorId pertence ao recepcionista
                    if (setores.stream().anyMatch(s -> s.getId().equals(setorId.longValue()))) {
                        salas = salaService.getBySetorId(setorId, pageable);
                    } else {
                        // Se o setor não pertence ao recepcionista, mostra apenas salas dos seus
                        // setores
                        salas = salaService.findByRecepcionistaId(usuarioLogado.getId(), pageable);
                    }
                } else {
                    salas = salaService.findByRecepcionistaId(usuarioLogado.getId(), pageable);
                }
            }
        } else {
            // Para ADMINISTRADOR e outros roles, mostra todas as salas
            setores = setorService.list();

            if (q != null && !q.trim().isEmpty()) {
                model.addAttribute("query", q);
                if (setorId != null) {
                    salas = salaService.getByQueryAndSetorId(q.trim(), setorId, pageable);
                } else {
                    salas = salaService.search(q.trim(), pageable);
                }
            } else {
                if (setorId != null) {
                    salas = salaService.getBySetorId(setorId, pageable);
                } else {
                    salas = salaService.list(pageable);
                }
            }
        }

        model.addAttribute("salas", salas);
        model.addAttribute("setores", setores);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", salas.getTotalPages());
        model.addAttribute("totalItems", salas.getTotalElements());
        model.addAttribute("usuarioLogado", usuarioLogado);

        model.addAttribute("contentPage", "features/sala/sala-listar.jsp");
        return "base";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        Sala sala = salaService.getById(id);

        if (sala == null) {
            model.addAttribute("errorMessage", "Sala não encontrada no nosso banco de dados");
            model.addAttribute("contentPage", "features/sala/sala-detalhes.jsp");
            return "base";
        }

        // Verifica se o recepcionista tem permissão para ver esta sala
        if (usuarioLogado.getRole() == UsuarioRole.RECEPCIONISTA &&
                (sala.getSetor().getRecepcionista() == null ||
                        !sala.getSetor().getRecepcionista().getId().equals(usuarioLogado.getId()))) {
            model.addAttribute("errorMessage", "Você não tem permissão para acessar esta sala");
            return "redirect:/salas";
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
                // Para recepcionista, mostra apenas seus setores
                setores = setorService.getAllByRecepcionistaId(usuarioLogado.getId());
            }
        } else {
            return "redirect:/login";
        }

        model.addAttribute("setores", setores);
        model.addAttribute("salaRequest", SalaRequest.builder().build());
        model.addAttribute("contentPage", "features/sala/sala-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/editar")
    public String showEditForm(@PathVariable Long id, Model model) {
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        Sala sala = salaService.getById(id);

        if (sala == null) {
            return "redirect:/salas";
        }

        // Verifica se o recepcionista tem permissão para editar esta sala
        if (usuarioLogado.getRole() == UsuarioRole.RECEPCIONISTA &&
                (sala.getSetor().getRecepcionista() == null ||
                        !sala.getSetor().getRecepcionista().getId().equals(usuarioLogado.getId()))) {
            return "redirect:/salas";
        }

        List<Setor> setores;

        if (usuarioLogado.getRole() == UsuarioRole.ADMINISTRADOR) {
            setores = setorService.list();
        } else {
            setores = setorService.getAllByRecepcionistaId(usuarioLogado.getId());
        }

        SalaRequest salaRequest = SalaRequest.builder()
                .id(sala.getId())
                .nome(sala.getNome())
                .capacidade(sala.getCapacidade())
                .valorAluguel(sala.getValorAluguel())
                .setorId(sala.getSetor() != null ? sala.getSetor().getId() : null)
                .ativo(sala.getAtivo())
                .build();

        model.addAttribute("salaRequest", salaRequest);
        model.addAttribute("setores", setores);
        model.addAttribute("contentPage", "features/sala/sala-form.jsp");

        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping
    public String create(
            @Valid @ModelAttribute("salaRequest") SalaRequest salaRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Setor> setores;

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.ADMINISTRADOR) {
            setores = setorService.list();
        } else if (usuarioLogado != null) {
            setores = setorService.getAllByRecepcionistaId(usuarioLogado.getId());
        } else {
            return "redirect:/login";
        }

        model.addAttribute("setores", setores);

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors()); // Adiciona erros específicos
            model.addAttribute("contentPage", "features/sala/sala-form.jsp");
            return "base";
        }

        try {
            Sala savedSala = salaService.create(salaRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Sala criada com sucesso!");
            return "redirect:/salas/" + savedSala.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar sala: " + e.getMessage());
            model.addAttribute("salaRequest", salaRequest); // Mantém os dados preenchidos
            model.addAttribute("contentPage", "features/sala/sala-form.jsp");
            return "base";
        }
    }

    @PostMapping("/{id}/editar")
    public String update(
            @PathVariable Long id,
            @Valid @ModelAttribute("salaRequest") SalaRequest salaRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Setor> setores;

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.ADMINISTRADOR) {
            setores = setorService.list();
        } else if (usuarioLogado != null) {
            setores = setorService.getAllByRecepcionistaId(usuarioLogado.getId());
        } else {
            return "redirect:/login";
        }

        model.addAttribute("setores", setores);

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors());
            model.addAttribute("contentPage", "features/sala/sala-form.jsp");
            return "base";
        }

        try {
            Sala updatedSala = salaService.update(id, salaRequest);
            if (updatedSala == null) {
                model.addAttribute("errorMessage", "Sala não encontrada.");
                model.addAttribute("salaRequest", salaRequest);
                model.addAttribute("contentPage", "features/sala/sala-form.jsp");
                return "base";
            }
            redirectAttributes.addFlashAttribute("successMessage", "Sala atualizada com sucesso!");
            return "redirect:/salas/" + updatedSala.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao atualizar sala: " + e.getMessage());
            model.addAttribute("salaRequest", salaRequest);
            model.addAttribute("contentPage", "features/sala/sala-form.jsp");
            return "base";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            salaService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Sala excluída com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir sala: " + e.getMessage());
        }

        return "redirect:/salas";
    }
}
