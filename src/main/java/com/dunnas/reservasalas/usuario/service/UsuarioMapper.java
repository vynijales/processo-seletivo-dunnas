package com.dunnas.reservasalas.usuario.service;

import java.util.List;
import java.util.stream.Collectors;

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
                .ativo(request.isAtivo())
                .build();
    }

    public Usuario toEntity(UsuarioResponse request) {
        return Usuario.builder()
                .id(request.getId())
                .nome(request.getNome())
                .email(request.getEmail())
                .role(request.getRole())
                .ativo(request.isAtivo())
                .build();
    }

    public UsuarioResponse toResponse(Usuario usuario) {
        return UsuarioResponse.builder()
                .id(usuario.getId())
                .nome(usuario.getNome())
                .email(usuario.getEmail())
                .role(usuario.getRole())
                .ativo(usuario.isAtivo())
                .build();
    }

    public UsuarioResponse toResponse(UsuarioRequest usuario) {
        return UsuarioResponse.builder()
                .id(usuario.getId())
                .nome(usuario.getNome())
                .email(usuario.getEmail())
                .role(usuario.getRole())
                .ativo(usuario.isAtivo())
                .build();
    }

    public List<UsuarioResponse> toResponse(List<Usuario> usuarios) {
        return usuarios.stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }
}

// @Component -> Indica que esta classe é um componente gerenciado pelo Spring,
// permitindo a injeção de dependências.
// Métodos de mapeamento entre Usuario, UsuarioRequest e UsuarioResponse para
// facilitar a conversão entre camadas.
