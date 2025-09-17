package com.dunnas.reservasalas.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private UsuarioRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        criarUsuarioSeNaoExistir("Admin", "admin@dunnas.com", "admin123", UsuarioRole.ADMINISTRADOR);
        criarUsuarioSeNaoExistir("Recepcionista", "recepcionista@dunnas.com", "recep123", UsuarioRole.RECEPCIONISTA);
        criarUsuarioSeNaoExistir("Cliente", "cliente@dunnas.com", "cliente123", UsuarioRole.CLIENTE);
    }

    private void criarUsuarioSeNaoExistir(String nome, String email, String senha, UsuarioRole role) {
        boolean ativo = true;

        if (!userRepository.existsByEmail(email)) {
            Usuario usuario = new Usuario();
            usuario.setNome(nome);
            usuario.setAtivo(ativo);
            usuario.setEmail(email);
            usuario.setSenha(passwordEncoder.encode(senha));
            usuario.setRole(role);
            userRepository.save(usuario);
        }
    }
}
