package com.dunnas.reservasalas.agendamento.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.dunnas.reservasalas.agendamento.model.Agendamento;

@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {

        // Busca por cliente
        Page<Agendamento> findByClienteId(Long clienteId, Pageable pageable);

        // Busca por sala
        Page<Agendamento> findBySalaId(Long salaId, Pageable pageable);

        // Busca por status
        Page<Agendamento> findByStatus(String status, Pageable pageable);

        // Busca por período
        Page<Agendamento> findByDataInicioBetween(LocalDateTime start, LocalDateTime end, Pageable pageable);

        @Query("Select a FROM Agendamento a WHERE " +
                        "LOWER(a.cliente.nome) LIKE LOWER(CONCAT('%', :query, '%'))")
        Page<Agendamento> search(@Param("query") String query, Pageable pageable);

        // Verifica se existe conflito de agendamento para uma sala
        @Query("SELECT COUNT(s) > 0 FROM Agendamento s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status IN ('PENDENTE_PAGAMENTO') AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamento(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim);

        // Busca agendamentos confirmados para uma sala em um período
        @Query("SELECT s FROM Agendamento s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status = 'PENDENTE_PAGAMENTO' AND " +
                        "s.dataInicio >= :startDate AND " +
                        "s.dataFim <= :endDate")
        List<Agendamento> findAgendamentosConfirmadosPorSalaEPeriodo(
                        @Param("salaId") Long salaId,
                        @Param("startDate") LocalDateTime startDate,
                        @Param("endDate") LocalDateTime endDate);

        // Busca solicitações por cliente e status
        List<Agendamento> findByClienteIdAndStatus(Long clienteId, String status);

        // Busca solicitações pendentes (para notificações, etc.)
        List<Agendamento> findByStatusOrderByDataCriacaoAsc(String status);

        // Verifica se cliente já tem solicitação em um período
        @Query("SELECT COUNT(s) > 0 FROM Agendamento s WHERE " +
                        "s.cliente.id = :clienteId AND " +
                        "s.status IN ('PENDENTE_PAGAMENTO') AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsAgendamentoClienteNoPeriodo(
                        @Param("clienteId") Long clienteId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim);

        @Query("SELECT COUNT(s) > 0 FROM Agendamento s WHERE " +
                        "s.sala.id = :salaId AND " +
                        "s.status IN ('PENDENTE_PAGAMENTO') AND " +
                        "s.id != :excludeId AND " +
                        "((s.dataInicio <= :dataFim AND s.dataFim >= :dataInicio))")
        boolean existsConflitoAgendamentoExcludingCurrent(
                        @Param("salaId") Long salaId,
                        @Param("dataInicio") LocalDateTime dataInicio,
                        @Param("dataFim") LocalDateTime dataFim,
                        @Param("excludeId") Long excludeId);
}
