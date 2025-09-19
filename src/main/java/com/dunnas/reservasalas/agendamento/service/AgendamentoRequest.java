package com.dunnas.reservasalas.agendamento.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.validation.constraints.Future;

import com.dunnas.reservasalas.agendamento.model.AgendamentoStatus;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AgendamentoRequest {
    private Long id;

    private Long solicitacaoId;
    private Long clienteId;
    private Long salaId;

    private LocalDateTime dataInicio;
    @Future(message = "A data de fim deve ser futura")
    private LocalDateTime dataFim;

    private AgendamentoStatus status;

    private BigDecimal valorPago;

    private LocalDateTime dataCriacao;
}
