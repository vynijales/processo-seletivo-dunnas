package com.dunnas.reservasalas.setor.service;

import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.usuario.model.Usuario;

@Component
public class SetorMapper {
    public Setor toEntity(SetorRequest req) {
        final Usuario recepcionista = Usuario.builder().id(req.getRecepcionistaId()).build();
        return Setor.builder()
                .id(req.getId())
                .nome(req.getNome())
                .valorCaixa(req.getValorCaixa())
                .recepcionista(recepcionista)
                .ativo(req.getAtivo())
                .build();
    }

}
