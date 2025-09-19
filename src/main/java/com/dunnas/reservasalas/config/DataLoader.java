package com.dunnas.reservasalas.config;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.dunnas.reservasalas.core.exceptions.EntityRequiredException;
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.sala.repository.SalaRepository;
import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.setor.repository.SetorRepository;
import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;
import com.dunnas.reservasalas.usuario.repository.UsuarioRepository;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private UsuarioRepository userRepository;

    @Autowired
    private SetorRepository setorRepository;

    @Autowired
    private SalaRepository salaRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        final Usuario admin = criarUsuarioSeNaoExistir("Admin", "admin@dunnas.com", "admin123",
                UsuarioRole.ADMINISTRADOR);
        final Usuario recep = criarUsuarioSeNaoExistir("Recepcionista", "recepcionista@dunnas.com", "recep123",
                UsuarioRole.RECEPCIONISTA);
        criarUsuarioSeNaoExistir("Cliente", "cliente@dunnas.com", "cliente123",
                UsuarioRole.CLIENTE);

        Setor dunnas = criarSetorSeNaoExistir("Setor Dunnas", 0.d, admin);
        Setor ufersa = criarSetorSeNaoExistir("Setor UFERSA", 0.d, recep);
        if (dunnas != null && ufersa != null) {
            criarSalaSeNaoExistir("Sala 01", 1, 0.d, dunnas);
            criarSalaSeNaoExistir("Sala 02", 20, 0.d, dunnas);

            criarSalaSeNaoExistir("Sala 03", 1, 0.d, ufersa);

        }

    }

    private Usuario criarUsuarioSeNaoExistir(String nome, String email, String senha, UsuarioRole role) {
        boolean ativo = true;

        if (!userRepository.existsByEmail(email)) {
            Usuario usuario = Usuario.builder()
                    .nome(nome)
                    .ativo(ativo)
                    .email(email)
                    .senha(passwordEncoder.encode(senha))
                    .role(role)
                    .build();
            return userRepository.save(usuario);
        }
        return null;
    }

    private Setor criarSetorSeNaoExistir(String nome, Double valorCaixa, Usuario recepcionista) {
        boolean ativo = true;

        if (!setorRepository.existsByNome(nome)) {
            Setor setor = Setor.builder()
                    .nome(nome)
                    .valorCaixa(valorCaixa)
                    .recepcionista(recepcionista)
                    .ativo(ativo)
                    .build();
            return setorRepository.save(setor);
        }
        return null;
    }

    private void criarSalaSeNaoExistir(String nome, int capacidade, Double valorAluguel, Setor setor) {

        if (setor == null) {
            throw new EntityRequiredException("Setor é obrigatório!!");
        }

        if (!salaRepository.existsByNome(nome)) {
            Sala sala = Sala.builder()
                    .nome(nome)
                    .capacidade(capacidade)
                    .valorAluguel(BigDecimal.valueOf(valorAluguel))
                    .setor(setor)
                    .build();
            salaRepository.save(sala);
        }
    }
}
