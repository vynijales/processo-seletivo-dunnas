package com.dunnas.reservasalas.sala.service;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SalaRequest {
    private Long id;
    private String nome;
    private int capacidade;
    private Double valorAluguel;
    private Long setorId;
    @Builder.Default
    private Boolean ativo = true;

}
