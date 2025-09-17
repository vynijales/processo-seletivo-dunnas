package com.dunnas.reservasalas.usuario.service;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dunnas.reservasalas.core.exceptions.EmailDuplicadoException;
import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;
import com.dunnas.reservasalas.usuario.utils.UsuarioMapper;
import com.dunnas.reservasalas.usuario.utils.UsuarioRequest;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsuarioService implements UserDetailsService {
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final PasswordEncoder passwordEncoder;

    public Page<Usuario> list(Pageable pageable) {
        return usuarioRepository.findAll(pageable);
    }

    public Page<Usuario> search(String query, Pageable pageable) {
        return usuarioRepository.findByQuery(query, pageable);
    }

    public Usuario getById(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
        return usuario;
    }

    public Usuario getByEmail(String email) {
        return usuarioRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
    }

    @Transactional
    public Usuario create(UsuarioRequest request) {
        if (usuarioRepository.existsByEmail(request.getEmail())) {
            throw new EmailDuplicadoException();
        }

        Usuario novoUsuario = usuarioMapper.toEntity(request);
        novoUsuario.setSenha(passwordEncoder.encode(request.getSenha()));
        novoUsuario.setAtivo(true);

        return usuarioRepository.save(novoUsuario);
    }

    @Transactional
    public Usuario update(UsuarioRequest request) {
        Usuario usuario = usuarioRepository.findById(request.getId())
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
        Usuario atualizado = usuarioMapper.toEntity(request);

        String emailAtual = usuario.getEmail();
        String emailNovo = request.getEmail();

        if (!emailAtual.equals(emailNovo) && usuarioRepository.existsByEmail(emailNovo)) {
            throw new EmailDuplicadoException();
        }

        if (request.getSenha() != null && !request.getSenha().isBlank()) {
            atualizado.setSenha(passwordEncoder.encode(request.getSenha()));
            return usuarioRepository.save(atualizado);
        }

        usuarioRepository.updateUsuarioWithoutPassword(
                atualizado.getId(),
                atualizado.getNome(),
                atualizado.getEmail(),
                atualizado.getRole(),
                atualizado.isAtivo());
        return atualizado;
    }

    @Transactional
    public void delete(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
        usuarioRepository.delete(usuario);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmailIgnoreCase(username)
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado"));
        return usuario;
    }
}
