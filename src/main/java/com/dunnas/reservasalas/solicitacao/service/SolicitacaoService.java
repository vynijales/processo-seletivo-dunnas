package com.dunnas.reservasalas.solicitacao.service;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.solicitacao.model.Solicitacao;
import com.dunnas.reservasalas.solicitacao.model.SolicitacaoStatus;
import com.dunnas.reservasalas.solicitacao.repository.SolicitacaoRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SolicitacaoService {
    private final SolicitacaoRepository solicitacaoRepository;
    private final SolicitacaoMapper solicitacaoMapper;

    public Page<Solicitacao> list(Pageable pageable) {
        return solicitacaoRepository.findAll(pageable);
    }

    public List<Solicitacao> list() {
        return solicitacaoRepository.findAll();
    }

    public Page<Solicitacao> search(String query, Pageable pageable) {
        return solicitacaoRepository.search(query, pageable);
    }

    public List<Solicitacao> search(String query) {
        // Since the repository uses Page for search, we need to handle this differently
        Page<Solicitacao> page = solicitacaoRepository.search(query, Pageable.unpaged());
        return page.getContent();
    }

    public Solicitacao getById(Long id) {
        return solicitacaoRepository.findById(id).orElse(null);
    }

    public List<Solicitacao> getByClienteId(Long clienteId) {
        return solicitacaoRepository.findByClienteId(clienteId, Pageable.unpaged()).getContent();
    }

    public List<Solicitacao> getBySalaId(Long salaId) {
        return solicitacaoRepository.findBySalaId(salaId, Pageable.unpaged()).getContent();
    }

    public List<Solicitacao> getByStatus(String status) {
        return solicitacaoRepository.findByStatus(status, Pageable.unpaged()).getContent();
    }

    public boolean existsConflitoAgendamento(Long salaId, LocalDateTime dataInicio, LocalDateTime dataFim) {
        return solicitacaoRepository.existsConflitoAgendamento(salaId, dataInicio, dataFim);
    }

    @Transactional
    public Solicitacao create(SolicitacaoRequest req) {
        if (req.getDataFim().isBefore(req.getDataInicio())) {
            throw new IllegalArgumentException("A data final deve ser posterior à data inicial");
        }

        // TODO: REMOVER VALIDAÇÃO
        if (existsConflitoAgendamento(req.getSalaId(), req.getDataInicio(), req.getDataFim())) {
            throw new IllegalStateException("Já existe um agendamento para esta sala no período solicitado");
        }

        Solicitacao novaSolicitacao = solicitacaoMapper.toEntity(req);
        return solicitacaoRepository.save(novaSolicitacao);
    }

    public Solicitacao alterarStatus(Long id, SolicitacaoStatus status) {
        Solicitacao solicitacao = solicitacaoRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Solicitação não encontrada com ID: " + id));

        solicitacao.setStatus(status);

        return solicitacaoRepository.save(solicitacao);
    }

    @Transactional
    public Solicitacao update(Long id, SolicitacaoRequest req) {
        Solicitacao existingSolicitacao = solicitacaoRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Solicitação não encontrada"));

        if (existingSolicitacao != null) {
            // Check for conflicts excluding the current solicitation
            boolean hasConflict = solicitacaoRepository.existsConflitoAgendamentoExcludingCurrent(
                    req.getSalaId(), req.getDataInicio(), req.getDataFim(), id);

            if (hasConflict) {
                throw new IllegalStateException("Já existe outro agendamento para esta sala no período solicitado");
            }

            Solicitacao updatedSolicitacao = solicitacaoMapper.toEntity(req);
            updatedSolicitacao.setId(id); // Ensure the ID is preserved
            updatedSolicitacao.setDataCriacao(existingSolicitacao.getDataCriacao()); // Preserve creation date

            return solicitacaoRepository.save(updatedSolicitacao);
        }

        return null;
    }

    @Transactional
    public Solicitacao updateStatus(Long id, SolicitacaoStatus status) {
        Solicitacao solicitacao = solicitacaoRepository.findById(id)
                .orElse(null);

        if (solicitacao != null) {
            solicitacao.setStatus(status);
            return solicitacaoRepository.save(solicitacao);
        }

        return null;
    }

    @Transactional
    public Solicitacao confirmarSolicitacao(Long id) {
        return updateStatus(id, SolicitacaoStatus.CONFIRMADO);
    }

    @Transactional
    public Solicitacao cancelarSolicitacao(Long id) {
        return updateStatus(id, SolicitacaoStatus.CANCELADO);
    }

    public List<Solicitacao> getSolicitacoesPendentes() {
        return solicitacaoRepository.findByStatusOrderByDataCriacaoAsc("SOLICITADO");
    }

    public List<Solicitacao> getAgendamentosConfirmadosPorPeriodo(
            Long salaId, LocalDateTime startDate, LocalDateTime endDate) {
        return solicitacaoRepository.findAgendamentosConfirmadosPorSalaEPeriodo(salaId, startDate, endDate);
    }

    public boolean existsConflitoAgendamentoConfirmado(Long salaId, LocalDateTime dataInicio, LocalDateTime dataFim) {
        return solicitacaoRepository.existsConflitoAgendamentoConfirmado(salaId, dataInicio, dataFim);
    }

    public boolean existsConflitoAgendamentoConfirmadoExcludingCurrent(Long salaId, LocalDateTime dataInicio,
            LocalDateTime dataFim, Long excludeId) {
        return solicitacaoRepository.existsConflitoAgendamentoConfirmadoExcludingCurrent(salaId, dataInicio, dataFim,
                excludeId);
    }

    @Transactional
    public Solicitacao processarPagamento(Long id, Double valor) {
        Solicitacao solicitacao = solicitacaoRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Solicitação " + id + " não encontrada!"));

        if (solicitacao.getStatus() != SolicitacaoStatus.AGUARDANDO_PAGAMENTO) {
            throw new RuntimeException("Erro ao processar... status inválido");
        }

        Double valorAluguel = solicitacao.getSala().getValorAluguel();
        Double valorPago = valor;
        Double metadeValorAluguel = valorAluguel / 2;

        if (valorPago < metadeValorAluguel) {
            throw new RuntimeException("Valor insuficiente");
        }

        if (valorPago < valorAluguel) {
            solicitacao.setStatus(SolicitacaoStatus.CONFIRMADO);
        } else {
            solicitacao.setStatus(SolicitacaoStatus.CONFIRMADO_PAGO);
        }

        solicitacao.setSinalPago(true);

        return solicitacaoRepository.save(solicitacao);
    }

    public Solicitacao marcarSinalPago(Long id) {
        Solicitacao solicitacao = solicitacaoRepository.findById(id)
                .orElse(null);

        if (solicitacao != null) {
            solicitacao.setSinalPago(true);
            return solicitacaoRepository.save(solicitacao);
        }

        return null;
    }

    @Transactional
    public boolean delete(Long id) {
        if (solicitacaoRepository.existsById(id)) {
            solicitacaoRepository.deleteById(id);
            return true;
        }
        return false;
    }

}
