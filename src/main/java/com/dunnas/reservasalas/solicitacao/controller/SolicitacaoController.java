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
import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.setor.repository.SetorRepository;
import com.dunnas.reservasalas.solicitacao.model.Solicitacao;
import com.dunnas.reservasalas.solicitacao.model.SolicitacaoStatus;
import com.dunnas.reservasalas.solicitacao.service.SolicitacaoRequest;
import com.dunnas.reservasalas.solicitacao.service.SolicitacaoService;
import com.dunnas.reservasalas.solicitacao.utils.SolicitacaoValidator;
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
    private final SolicitacaoValidator solicitacaoValidator;
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final SalaRepository salaRepository;
    private final SetorRepository setorRepository;

    @GetMapping
    public String list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "dataFim") String sort,
            @RequestParam(required = false) Integer salaId,
            Model model) {

        Sort.Direction direction = "dataInicio".equals(sort)
                ? Sort.Direction.ASC
                : Sort.Direction.DESC;

        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sort));
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
    public String detail(@PathVariable Long id,
            @RequestParam(required = false) Integer salaId,
            Model model) {
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
        List<Setor> setores = setorRepository.findAll();

        // O cliente só pode marcar para si próprio
        if (usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        if (usuarioLogado.getRole() == UsuarioRole.RECEPCIONISTA) {
            setores = setorRepository.findByRecepcionistaId(usuarioLogado.getId());
            salas = salaRepository.findBySetorRecepcionistaId(usuarioLogado.getId());
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("setores", setores);
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
        }

        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();
        List<Setor> setores = setorRepository.findAll();

        // O cliente só pode marcar para si próprio
        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("setores", setores);
        model.addAttribute("solicitacao", solicitacao);
        model.addAttribute("contentPage", "features/solicitacao/solicitacao-form.jsp");
        return "base";
    }

    @PostMapping
    public String create(
            @Valid @ModelAttribute("solicitacaoRequest") SolicitacaoRequest solicitacaoRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Recarregar dados necessários para o formulário
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();

        solicitacaoValidator.validate(solicitacaoRequest, result);

        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();
        List<Setor> setores = setorRepository.findAll();

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("setores", setores);

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Erros de validação encontrados");
            model.addAttribute("errors", result.getAllErrors());
            model.addAttribute("contentPage", "features/solicitacao/solicitacao-form.jsp");
            return "base";
        }

        try {
            Solicitacao savedSolicitacao = solicitacaoService.create(solicitacaoRequest);
            redirectAttributes.addFlashAttribute("successMessage", "Solicitação criada com sucesso!");
            return "redirect:/solicitacoes/" + savedSolicitacao.getId();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erro ao criar solicitação: " + e.getMessage());
            model.addAttribute("solicitacaoRequest", solicitacaoRequest); // Mantém os dados preenchidos
            model.addAttribute("contentPage", "features/solicitacao/solicitacao-form.jsp");
            return "base";
        }
    }

    @GetMapping("/{id}/efetuarPagamento")
    public String showConfirmarPagamentoForm(@PathVariable Long id, Model model) {
        Solicitacao solicitacao = solicitacaoService.getById(id);
        if (solicitacao == null) {
            throw new EntityNotFoundException();
        }
        UsuarioResponse usuarioLogado = autenticationController.usuarioAutenticado();
        List<Usuario> clientes = usuarioRepository.findAll();
        List<Sala> salas = salaRepository.findAll();

        if (usuarioLogado != null && usuarioLogado.getRole() == UsuarioRole.CLIENTE) {
            clientes = List.of(usuarioMapper.toEntity(usuarioLogado));
        }

        model.addAttribute("clientes", clientes);
        model.addAttribute("salas", salas);
        model.addAttribute("solicitacao", solicitacao);
        model.addAttribute("contentPage", "features/solicitacao/solicitacao-pagamento.jsp");
        return "base";
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping("/{id}/enviar-para-pagamento")
    public String enviarParaPagamento(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes,
            Model model) {

        try {
            // Verificar se há conflitos antes de enviar para pagamento
            Solicitacao solicitacao = solicitacaoService.getById(id);

            if (solicitacao == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Solicitação não encontrada");
                return "redirect:/solicitacoes";
            }

            // Verificar se já existe uma solicitação CONFIRMADA para o mesmo período
            boolean hasConflict = solicitacaoService.existsConflitoAgendamento(
                    solicitacao.getSala().getId(),
                    solicitacao.getDataInicio(),
                    solicitacao.getDataFim());

            if (hasConflict) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Não é possível enviar para pagamento: já existe uma solicitação CONFIRMADA para este período");
                return "redirect:/solicitacoes/" + id;
            }

            // Se não houver conflito, alterar o status
            solicitacaoService.alterarStatus(id, SolicitacaoStatus.AGUARDANDO_PAGAMENTO);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Solicitação enviada para aguardando pagamento com sucesso!");
            return "redirect:/solicitacoes/" + id;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao enviar para pagamento: " + e.getMessage());
            return "redirect:/solicitacoes/" + id;
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping("/{id}/confirmar-pagamento")
    public String confirmarPagamento(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        try {
            Solicitacao solicitacao = solicitacaoService.marcarSinalPago(id);

            if (solicitacao != null && solicitacao.getSinalPago()) {
                // Se o sinal foi pago, confirmar a solicitação
                solicitacaoService.alterarStatus(id, SolicitacaoStatus.CONFIRMADO);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Pagamento confirmado e solicitação confirmada com sucesso!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Erro ao confirmar pagamento");
            }

            return "redirect:/solicitacoes/" + id;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao confirmar pagamento: " + e.getMessage());
            return "redirect:/solicitacoes/" + id;
        }
    }

    @PostMapping("/{id}/efetuarPagamento")
    public String efetuarPagamento(
            @PathVariable Long id,
            @RequestParam("valor") Double valor,
            RedirectAttributes redirectAttributes,
            Model model) {

        try {
            Solicitacao solicitacao = solicitacaoService.getById(id);

            if (solicitacao == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Solicitação não encontrada");
                return "redirect:/solicitacoes";
            }
            // Verificar se o status atual é AGUARDANDO_PAGAMENTO
            if (solicitacao.getStatus() != SolicitacaoStatus.AGUARDANDO_PAGAMENTO) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Só é possível efetuar pagamento para solicitações com status AGUARDANDO_PAGAMENTO");
                return "redirect:/solicitacoes/" + id;
            }
            // Processar o pagamento e atualizar status
            solicitacaoService.processarPagamento(id, valor);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Pagamento efetuado com sucesso e solicitação confirmada!");
            return "redirect:/solicitacoes/" + id;

        } catch (RuntimeException e) {
            // Handle specific business exceptions
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao processar pagamento: " + e.getMessage());
            return "redirect:/solicitacoes/" + id + "/efetuarPagamento";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Erro inesperado ao processar pagamento" + e.toString());
            return "redirect:/solicitacoes/" + id + "/efetuarPagamento";
        }
    }

    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @GetMapping("/{id}/excluir")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            solicitacaoService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Solicitação excluída com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao excluir solicitação: " + e.getMessage());
        }
        return "redirect:/solicitacoes";
    }
}
