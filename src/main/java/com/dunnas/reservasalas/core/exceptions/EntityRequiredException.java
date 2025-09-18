package com.dunnas.reservasalas.core.exceptions;

public class EntityRequiredException extends RuntimeException {
    public EntityRequiredException(String message) {
        super(message);
    }

    public EntityRequiredException() {
        super("Entidade é obrigatória");
    }
}
