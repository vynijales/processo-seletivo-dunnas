package com.dunnas.reservasalas.solicitacao.utils;

import java.time.LocalDateTime;

import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.dunnas.reservasalas.solicitacao.service.SolicitacaoRequest;

@Component
public class SolicitacaoValidator implements Validator {

    @Override
    public boolean supports(@NonNull Class<?> clazz) {
        return SolicitacaoRequest.class.equals(clazz);
    }

    @Override
    public void validate(@NonNull Object target, @NonNull Errors errors) {
        SolicitacaoRequest solicitacao = (SolicitacaoRequest) target;

        if (solicitacao.getDataInicio() != null && solicitacao.getDataFim() != null) {
            if (solicitacao.getDataFim().isBefore(solicitacao.getDataInicio())) {
                errors.rejectValue("dataFim", "data.fim.posterior", "A data final deve ser posterior à data inicial");
            }

            if (solicitacao.getDataInicio().isBefore(LocalDateTime.now())) {
                errors.rejectValue("dataInicio", "data.inicio.futura", "A data de início deve ser atual ou futura");
            }

            if (solicitacao.getDataFim().isBefore(LocalDateTime.now())) {
                errors.rejectValue("dataFim", "data.fim.futura", "A data de fim deve ser futura");
            }
        }
    }
}
