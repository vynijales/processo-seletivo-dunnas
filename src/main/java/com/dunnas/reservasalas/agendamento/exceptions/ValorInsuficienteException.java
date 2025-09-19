package com.dunnas.reservasalas.agendamento.exceptions;

public class ValorInsuficienteException extends RuntimeException {
    public ValorInsuficienteException(String msg) {
        super(msg);
    }

    public ValorInsuficienteException() {
        super("Valor insuficiente");
    }

}
