package com.dunnas.reservasalas.solicitacao.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dunnas.reservasalas.solicitacao.model.Solicitacao;

@Repository
public interface SolicitacaoRepository extends JpaRepository<Solicitacao, Long> {

        // Busca por cliente
        Page<Solicitacao> findByClienteId(Long clienteId, Pageable pageable);

        // Busca por sala
        Page<Solicitacao> findBySalaId(Long salaId, Pageable pageable);

        // Busca por status
        Page<Solicitacao> findByStatus(String status, Pageable pageable);

        // Busca por período
        Page<Solicitacao> findByDataInicioBetween(LocalDateTime start, LocalDateTime end, Pageable pageable);

        // Busca por sinal pago
        Page<Solicitacao> findBySinalPago(Boolean sinalPago, Pageable pageable);

        // Busca textual (para a funcionalidade de search do controller)
        @Query("SELECT s FROM Solicitacao s WHERE " +
                        "LOWER(s.cliente.nome) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
                        "LOWER(s.sala.nome) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
                        "LOWER(s.status) LIKE LOWER(CONCAT('%', :query, '%'))")
        Page<Solicitacao> search(@Param("query") String query, Pageable pageable);

        // Verifica se existe conflito de agendamento para uma sala
        @Query("SELECT COUNT(s) > 0 FROM Solicitacao s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status IN ('SOLICITADO', 'CONFIRMADO') AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamento(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim);

        // Busca agendamentos confirmados para uma sala em um período
        @Query("SELECT s FROM Solicitacao s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status = 'CONFIRMADO' AND " +
                        "s.dataInicio >= :startDate AND " +
                        "s.dataFim <= :endDate")

        List<Solicitacao> findAgendamentosConfirmadosPorSalaEPeriodo(
                        @Param("salaId") Long salaId,
                        @Param("startDate") LocalDateTime startDate,
                        @Param("endDate") LocalDateTime endDate);

        // Busca solicitações por cliente e status
        List<Solicitacao> findByClienteIdAndStatus(Long clienteId, String status);

        // Busca solicitações pendentes (para notificações, etc.)
        List<Solicitacao> findByStatusOrderByDataCriacaoAsc(String status);

        // Verifica se cliente já tem solicitação em um período
        @Query("SELECT COUNT(s) > 0 FROM Solicitacao s WHERE " +
                        "s.cliente.id = :clienteId AND " +
                        "s.status IN ('SOLICITADO', 'CONFIRMADO') AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsSolicitacaoClienteNoPeriodo(
                        @Param("clienteId") Long clienteId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim);

        @Query("SELECT COUNT(s) > 0 FROM Solicitacao s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status IN ('SOLICITADO', 'CONFIRMADO') AND " +
                        "s.id != :excludeId AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamentoExcludingCurrent(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim,
                        @Param("excludeId") Long excludeId);

        @Query("SELECT COUNT(s) > 0 FROM Solicitacao s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status = 'CONFIRMADO' AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamentoConfirmado(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim);

        @Query("SELECT COUNT(s) > 0 FROM Solicitacao s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status = 'CONFIRMADO' AND " +
                        "s.id != :excludeId AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamentoConfirmadoExcludingCurrent(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim,
                        @Param("excludeId") Long excludeId);
}
