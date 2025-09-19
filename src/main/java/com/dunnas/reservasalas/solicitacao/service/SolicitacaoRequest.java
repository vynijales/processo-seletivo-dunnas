package com.dunnas.reservasalas.solicitacao.service;

import java.time.LocalDateTime;

import jakarta.validation.constraints.Future;

import com.dunnas.reservasalas.solicitacao.model.SolicitacaoStatus;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SolicitacaoRequest {
    private Long id;
    private Long clienteId;
    private Long salaId;

    private LocalDateTime dataInicio;
    @Future(message = "A data de fim deve ser futura")
    private LocalDateTime dataFim;

    private SolicitacaoStatus status;

    private boolean sinalPago;

    private LocalDateTime dataCriacao;
}
