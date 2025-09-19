package com.dunnas.reservasalas.sala.service;

import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.setor.model.Setor;

@Component
public class SalaMapper {
    public Sala toEntity(SalaRequest req) {
        final Setor setor = Setor.builder().id(req.getSetorId()).build();
        return Sala.builder()
                .id(req.getId())
                .nome(req.getNome())
                .capacidade(req.getCapacidade())
                .valorAluguel(req.getValorAluguel())
                .setor(setor)
                .ativo(req.getAtivo())
                .build();
    }
}
