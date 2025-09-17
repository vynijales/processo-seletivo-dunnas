package com.dunnas.reservasalas.usuario.model;

import lombok.Getter;

@Getter
public enum UsuarioRole {
    ADMINISTRADOR("Administrador"),
    RECEPCIONISTA("Recepcionista"),
    CLIENTE("Cliente");

    private final String label;

    UsuarioRole(String label) {
        this.label = label;
    }
}
