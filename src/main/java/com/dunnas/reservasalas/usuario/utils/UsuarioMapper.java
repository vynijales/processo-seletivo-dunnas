package com.dunnas.reservasalas.usuario.utils;

import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.usuario.model.Usuario;

@Component
public class UsuarioMapper {
    public Usuario toEntity(UsuarioRequest request) {
        return Usuario.builder()
                .id(request.getId())
                .nome(request.getNome())
                .email(request.getEmail())
                .senha(request.getSenha())
                .role(request.getRole())
                .build();
    }

    public void updateEntityFromRequest(UsuarioRequest request, Usuario usuario) {
        usuario.setNome(request.getNome());
        usuario.setEmail(request.getEmail());
        usuario.setRole(request.getRole());
    }

}

// @Component -> Indica que esta classe é um componente gerenciado pelo Spring,
// permitindo a injeção de dependências.
// Métodos de mapeamento entre Usuario, UsuarioRequest e UsuarioResponse para
// facilitar a conversão entre camadas.
