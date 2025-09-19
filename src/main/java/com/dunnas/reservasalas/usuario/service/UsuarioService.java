package com.dunnas.reservasalas.usuario.service;

import java.util.List;

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
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;

import io.micrometer.common.lang.Nullable;
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

    public Page<Usuario> list(Pageable pageable, String q, UsuarioRole role) {
        return usuarioRepository.findByQueryAndRole(q, role, pageable);
    }

    public List<Usuario> list() {
        return usuarioRepository.findAll();
    }

    public List<UsuarioResponse> list(UsuarioRole role) {
        final List<Usuario> usuarios = usuarioRepository.findByRole(role);
        return usuarioMapper.toResponse(usuarios);
    }

    public List<UsuarioResponse> list(String q, UsuarioRole role) {
        final List<Usuario> usuarios = usuarioRepository.findByQueryAndRole(q, role);
        return usuarioMapper.toResponse(usuarios);
    }

    public List<UsuarioResponse> list(String q, List<UsuarioRole> roles) {
        final List<Usuario> usuarios = usuarioRepository.findByQueryAndRoles(q, roles);
        return usuarioMapper.toResponse(usuarios);
    }

    public List<UsuarioResponse> list(List<UsuarioRole> roles) {
        List<Usuario> usuarios = usuarioRepository.findByRoles(roles);
        return usuarioMapper.toResponse(usuarios);
    }

    public Page<Usuario> search(String query, Pageable pageable) {
        return usuarioRepository.findByQuery(query, pageable);
    }

    public List<UsuarioResponse> search(String query) {
        List<Usuario> usuarios = usuarioRepository.findByQuery(query);
        return usuarioMapper.toResponse(usuarios);
    }

    @Nullable
    public Usuario getById(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    @Nullable
    public UsuarioResponse getByEmail(String email) {
        Usuario usuario = usuarioRepository.findByEmailIgnoreCase(email);
        return usuarioMapper.toResponse(usuario);
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
    public Usuario update(Long id, UsuarioRequest request) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        String emailAtual = usuario.getEmail();
        String emailNovo = request.getEmail();

        // Alterou o email? É duplicado?
        if (!emailAtual.equals(emailNovo) && usuarioRepository.existsByEmail(emailNovo)) {
            throw new EmailDuplicadoException();
        }

        // Atualiza os campos
        usuario.setNome(request.getNome());
        usuario.setEmail(request.getEmail());
        usuario.setRole(request.getRole());

        // Atualiza senha se fornecida
        if (request.getSenha() != null && !request.getSenha().isBlank()) {
            usuario.setSenha(passwordEncoder.encode(request.getSenha()));
        }

        return usuarioRepository.save(usuario);
    }

    @Transactional
    public void delete(Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
        usuarioRepository.delete(usuario);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmailIgnoreCase(username);
        if (usuario == null) {
            throw new UsernameNotFoundException("Usuário não encontrado");
        }
        return usuario;
    }
}
