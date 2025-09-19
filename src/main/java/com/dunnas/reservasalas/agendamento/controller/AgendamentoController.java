package com.dunnas.reservasalas.agendamento.controller;

import java.util.List;

import jakarta.persistence.EntityNotFoundException;
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

import com.dunnas.reservasalas.agendamento.model.Agendamento;
import com.dunnas.reservasalas.agendamento.service.AgendamentoRequest;
import com.dunnas.reservasalas.agendamento.service.AgendamentoService;
import com.dunnas.reservasalas.core.auth.AuthenticationController;
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.sala.repository.SalaRepository;
import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;
import com.dunnas.reservasalas.usuario.service.UsuarioMapper;
import com.dunnas.reservasalas.usuario.service.UsuarioResponse;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/agendamentos")
public class AgendamentoController {
    private final AuthenticationController autenticationController;
    private final AgendamentoService agendamentoService;
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final SalaRepository salaRepository;

    @GetMapping
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "dataFim") String sort,
            Model model) {

        Pageable pageable = PageRequest.of(page, size, Sort.by(sort));
        Page<Agendamento> agendamentos;

        if (q != null && !q.trim().isEmpty()) {
            agendamentos = agendamentoService.search(q.trim(), pageable);
            model.addAttribute("query", q);
        } else {
            agendamentos = agendamentoService.list(pageable);
        }

        model.addAttribute("agendamentos", agendamentos);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", agendamentos.getTotalPages());
        model.addAttribute("totalItems", agendamentos.getTotalElements());

        model.addAttribute("contentPage", "features/agendamento/agendamento-listar.jsp");
        return "base";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Agendamento agendamento = agendamentoService.getById(id);

        if (agendamento == null) {
            model.addAttribute("errorMessage", "Agendamento não encontrada no nosso banco de dados");
        }

        model.addAttribute("agendamento", agendamento);
        model.addAttribute("contentPage", "features/agendamento/agendamento-detalhes.jsp");
        return "base";
    }

    // @PreAuthorize("hasRole('ADMINISTRADOR', 'FUNCIONARIO')")
    @GetMapping("/criar")
    public String showCreateForm(Model model) {

        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();

        // O cliente só pode marcar para si próprio
        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("agendamentosRequest", AgendamentoRequest.builder().build());
        model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/editar")
    public String showEditForm(@PathVariable Long id, Model model) {
        Agendamento agendamento = agendamentoService.getById(id);
        if (agendamento == null) {
            throw new EntityNotFoundException();
            // return "redirect:/agendamentos/${id}";
        }
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();

        // O cliente só pode marcar para si próprio
        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("agendamento", agendamento);
        model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
        return "base";
    }

    @PostMapping
    public String create(
            @Valid @ModelAttribute("agendamentoRequest") AgendamentoRequest agendamentoRequest, // Alterado para
                                                                                                // agendamentoRequest
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors());
            model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
            return "base";
        }

        try {
            Agendamento savedAgendamento = agendamentoService.create(agendamentoRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Agendamento criado com sucesso!");
            return "redirect:/agendamentos/" + savedAgendamento.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar solicitação: " + e.getMessage());
            model.addAttribute("agendamentoRequest", agendamentoRequest); // Mantém os dados preenchidos
            model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
            return "base";
        }
    }

    @PostMapping("/{id}/editar")
    public String update(
            @PathVariable Long id,
            @Valid @ModelAttribute("agendamentoRequest") AgendamentoRequest agendamentoRequest, // Alterado para
                                                                                                // agendamentoRequest
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors());
            model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
            return "base";
        }

        try {
            Agendamento savedAgendamento = agendamentoService.update(id, agendamentoRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Agendamento atualizado com sucesso!");
            return "redirect:/agendamentos/" + savedAgendamento.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao atualizar solicitação: " + e.getMessage());
            model.addAttribute("agendamentoRequest", agendamentoRequest);
            model.addAttribute("contentPage", "features/agendamento/agendamento-form.jsp");
            return "base";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            agendamentoService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Agendamento excluído com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir solicitação: " + e.getMessage());
        }
        return "redirect:/agendamentos";
    }
}
