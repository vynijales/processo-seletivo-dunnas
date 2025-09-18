package com.dunnas.reservasalas.salas.service;

import java.math.BigDecimal;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SalaRequest {
    private Long id;
    private String nome;
    private int capacidade;
    private BigDecimal valorAluguel;
    private Long setorId;
    @Builder.Default
    private Boolean ativo = true;

}
