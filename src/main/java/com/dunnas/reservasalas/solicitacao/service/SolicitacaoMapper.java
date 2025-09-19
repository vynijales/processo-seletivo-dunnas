package com.dunnas.reservasalas.solicitacao.service;

import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.solicitacao.model.Solicitacao;
import com.dunnas.reservasalas.usuario.model.Usuario;

@Component
public class SolicitacaoMapper {
    public Solicitacao toEntity(SolicitacaoRequest req) {
        final Sala sala = Sala.builder().id(req.getSalaId()).build();
        final Usuario cliente = Usuario.builder().id(req.getClienteId())
                .build();

        Double valorPago = req.getValorPago() != null ? req.getValorPago() : 0;

        return Solicitacao.builder()
                .id(req.getId())
                .cliente(cliente)
                .sala(sala)

                .dataInicio(req.getDataInicio())
                .dataFim(req.getDataFim())

                .status(req.getStatus())
                .sinalPago(req.isSinalPago())
                .valorPago(valorPago)

                .dataCriacao(req.getDataCriacao())
                .dataFim(req.getDataFim())

                .build();
    }
}
