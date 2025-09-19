package com.dunnas.reservasalas.agendamento.service;

import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.agendamento.model.Agendamento;
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.usuario.model.Usuario;

@Component
public class AgendamentoMapper {
    public Agendamento toEntity(AgendamentoRequest req) {
        final Sala sala = Sala.builder().id(req.getSalaId()).build();
        final Usuario cliente = Usuario.builder().id(req.getClienteId())
                .build();

        return Agendamento.builder()
                .id(req.getId())
                .cliente(cliente)
                .sala(sala)

                .dataInicio(req.getDataInicio())
                .dataFim(req.getDataFim())

                .valorPago(req.getValorPago())

                .dataCriacao(req.getDataCriacao())
                .dataFim(req.getDataFim())
                .build();
    }
}
