package com.dunnas.reservasalas.solicitacao.controller;

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

import com.dunnas.reservasalas.core.auth.AuthenticationController;
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.sala.repository.SalaRepository;
import com.dunnas.reservasalas.solicitacao.model.Solicitacao;
import com.dunnas.reservasalas.solicitacao.service.SolicitacaoRequest;
import com.dunnas.reservasalas.solicitacao.service.SolicitacaoService;
import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;
import com.dunnas.reservasalas.usuario.service.UsuarioMapper;
import com.dunnas.reservasalas.usuario.service.UsuarioResponse;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/solicitacoes")
public class SolicitacaoController {
    private final AuthenticationController autenticationController;
    private final SolicitacaoService solicitacaoService;
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
        Page<Solicitacao> solicitacoes;

        if (q != null && !q.trim().isEmpty()) {
            solicitacoes = solicitacaoService.search(q.trim(), pageable);
            model.addAttribute("query", q);
        } else {
            solicitacoes = solicitacaoService.list(pageable);
        }

        model.addAttribute("solicitacoes", solicitacoes);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sort);
        model.addAttribute("totalPages", solicitacoes.getTotalPages());
        model.addAttribute("totalItems", solicitacoes.getTotalElements());

        model.addAttribute("contentPage", "features/solicitacao/solicitacao-listar.jsp");
        return "base";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Solicitacao solicitacao = solicitacaoService.getById(id);

        if (solicitacao == null) {
            model.addAttribute("errorMessage", "Solicitacao não encontrada no nosso banco de dados");
        }

        model.addAttribute("solicitacao", solicitacao);
        model.addAttribute("contentPage", "features/solicitacao/solicitacao-detalhes.jsp");
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
        model.addAttribute("solicitacoesRequest", SolicitacaoRequest.builder().build());
        model.addAttribute("contentPage", "features/solicitacao/solicitacao-form.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/editar")
    public String showEditForm(@PathVariable Long id, Model model) {
        Solicitacao solicitacao = solicitacaoService.getById(id);
        if (solicitacao == null) {
            throw new EntityNotFoundException();
            // return "redirect:/solicitacoes/${id}";
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
        model.addAttribute("solicitacao", solicitacao);
        model.addAttribute("contentPage", "features/solicitacao/solicitacao-form.jsp");
        return "base";
    }

    @PostMapping
    public String create(
            @Valid @ModelAttribute("solicitacao") SolicitacaoRequest solicitacao,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        final String currentPage = "features/solicitacao/solicitacao-form.jsp";

        // if (result.hasErrors()) {
        // model.addAttribute("errorMessage", result.getAllErrors());
        // model.addAttribute("contentPage", currentPage);
        // return "base";
        // }

        try {
            Solicitacao savedSolicitacao = solicitacaoService.create(solicitacao);
            redirectAttributes.addFlashAttribute("successMessage", "Setor criado com sucesso!");
            return "redirect:/solicitacoes/" + savedSolicitacao.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao criar solicitacao: " + e.getMessage());
            model.addAttribute("contentPage", currentPage);
            model.addAttribute("solicitacao", solicitacao);
            return "base";
        }
    }

    @PostMapping("/{id}/editar")
    public String update(
            @PathVariable Long id,
            @Valid @ModelAttribute("solicitacao") SolicitacaoRequest solicitacao,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        final String path = "features/solicitacao/solicitacao-form.jsp";

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors()); // Adicione os erros específicos
            model.addAttribute("contentPage", path);
            return "base";
        }

        try {
            solicitacao.setId(id);
            Solicitacao savedSolicitacao = solicitacaoService.update(id, solicitacao);
            redirectAttributes.addFlashAttribute("successMessage", "Usuário atualizado com sucesso!");
            return "redirect:/solicitacoes/" + savedSolicitacao.getId();

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro: " + e.getMessage());
            redirectAttributes.addFlashAttribute("solicitacao", solicitacao);
            return "redirect:/solicitacoes/" + id + "/editar";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR)")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            solicitacaoService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Solicitacao excluída com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir solicitacao: " + e.getMessage());
        }

        return "redirect:/setores";
    }
}
