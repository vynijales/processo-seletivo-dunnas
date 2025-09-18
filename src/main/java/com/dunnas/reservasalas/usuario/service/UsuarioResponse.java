package com.dunnas.reservasalas.usuario.service;

import com.dunnas.reservasalas.usuario.model.UsuarioRole;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UsuarioResponse {

    private Long id;
    private String nome;
    private String email;
    private UsuarioRole role;
    private boolean ativo;

}
