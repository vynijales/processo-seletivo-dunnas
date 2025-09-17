package com.dunnas.reservasalas.usuario.utils;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import com.dunnas.reservasalas.usuario.model.UsuarioRole;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UsuarioRequest {

    private Long id;

    @NotBlank(message = "Nome é obrigatório")
    @Size(max = 100, message = "Nome deve ter no máximo 100 caracteres")
    private String nome;

    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ser válido")
    private String email;

    private String senha;

    @NotNull(message = "Papel é obrigatório")
    private UsuarioRole role;

    private boolean ativo;

}
