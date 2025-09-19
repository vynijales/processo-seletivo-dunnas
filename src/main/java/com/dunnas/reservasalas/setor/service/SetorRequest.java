package com.dunnas.reservasalas.setor.service;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SetorRequest {
    private Long id;
    private String nome;
    private Double valorCaixa;
    private Long recepcionistaId;
    @Builder.Default
    private Boolean ativo = true;

}
