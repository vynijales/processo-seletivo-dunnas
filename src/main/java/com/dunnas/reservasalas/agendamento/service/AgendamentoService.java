package com.dunnas.reservasalas.agendamento.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.PositiveOrZero;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.agendamento.model.Agendamento;
import com.dunnas.reservasalas.agendamento.model.AgendamentoStatus;
import com.dunnas.reservasalas.agendamento.repository.AgendamentoRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AgendamentoService {
    private final AgendamentoRepository agendamentoRepository;
    private final AgendamentoMapper agendamentoMapper;

    public Page<Agendamento> list(Pageable pageable) {
        return agendamentoRepository.findAll(pageable);
    }

    public List<Agendamento> list() {
        return agendamentoRepository.findAll();
    }

    public Page<Agendamento> search(String query, Pageable pageable) {
        return agendamentoRepository.search(query, pageable);
    }

    public List<Agendamento> search(String query) {
        // Since the repository uses Page for search, we need to handle this differently
        Page<Agendamento> page = agendamentoRepository.search(query, Pageable.unpaged());
        return page.getContent();
    }

    public Agendamento getById(Long id) {
        return agendamentoRepository.findById(id).orElse(null);
    }

    public List<Agendamento> getByClienteId(Long clienteId) {
        return agendamentoRepository.findByClienteId(clienteId, Pageable.unpaged()).getContent();
    }

    public List<Agendamento> getBySalaId(Long salaId) {
        return agendamentoRepository.findBySalaId(salaId, Pageable.unpaged()).getContent();
    }

    public List<Agendamento> getByStatus(String status) {
        return agendamentoRepository.findByStatus(status, Pageable.unpaged()).getContent();
    }

    public boolean existsConflitoAgendamento(Long salaId, LocalDateTime dataInicio, LocalDateTime dataFim) {
        return agendamentoRepository.existsConflitoAgendamento(salaId, dataInicio, dataFim);
    }

    @Transactional
    public Agendamento create(AgendamentoRequest req) {
        if (req.getDataFim().isBefore(req.getDataInicio())) {
            throw new IllegalArgumentException("A data final deve ser posterior à data inicial");
        }

        if (existsConflitoAgendamento(req.getSalaId(), req.getDataInicio(), req.getDataFim())) {
            throw new IllegalStateException("Já existe um agendamento para esta sala no período solicitado");
        }

        Agendamento novaAgendamento = agendamentoMapper.toEntity(req);
        return agendamentoRepository.save(novaAgendamento);
    }

    @Transactional
    public Agendamento update(Long id, AgendamentoRequest req) {
        Agendamento existingAgendamento = agendamentoRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Solicitação não encontrada"));

        if (existingAgendamento != null) {
            // Check for conflicts excluding the current solicitation
            boolean hasConflict = agendamentoRepository.existsConflitoAgendamentoExcludingCurrent(
                    req.getSalaId(), req.getDataInicio(), req.getDataFim(), id);

            if (hasConflict) {
                throw new IllegalStateException("Já existe outro agendamento para esta sala no período solicitado");
            }

            Agendamento updatedAgendamento = agendamentoMapper.toEntity(req);
            updatedAgendamento.setId(id); // Ensure the ID is preserved
            updatedAgendamento.setDataCriacao(existingAgendamento.getDataCriacao()); // Preserve creation date

            return agendamentoRepository.save(updatedAgendamento);
        }

        return null;
    }

    @Transactional
    public Agendamento updateStatus(Long id, AgendamentoStatus status) {
        Agendamento solicitacao = agendamentoRepository.findById(id)
                .orElse(null);

        if (solicitacao != null) {
            solicitacao.setStatus(status);
            return agendamentoRepository.save(solicitacao);
        }

        return null;
    }

    @Transactional
    public Agendamento confirmarAgendamento(Long id) {
        return updateStatus(id, AgendamentoStatus.PENDENTE_PAGAMENTO);
    }

    @Transactional
    public Agendamento cancelarAgendamento(Long id) {
        return updateStatus(id, AgendamentoStatus.CANCELADO);
    }

    @Transactional
    public Agendamento pagarAgendamento(Long id, @PositiveOrZero BigDecimal valor) {
        Agendamento agendamento = agendamentoRepository.findById(id)
                .orElse(null);

        if (agendamento != null) {
            BigDecimal valorAtual = agendamento.getValorPago();
            agendamento.setValorPago(valorAtual.add(valor));
            return agendamentoRepository.save(agendamento);
        }

        return null;
    }

    @Transactional
    public boolean delete(Long id) {
        if (agendamentoRepository.existsById(id)) {
            agendamentoRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public List<Agendamento> getSolicitacoesPendentes() {
        return agendamentoRepository.findByStatusOrderByDataCriacaoAsc("SOLICITADO");
    }

}
