package com.dunnas.reservasalas.core.exceptions;

public class EmailDuplicadoException extends RuntimeException {
    public EmailDuplicadoException(String message) {
        super(message);
    }

    public EmailDuplicadoException() {
        super("Já existe um usuário cadastrado com este email.");
    }
}
