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
        // Criar usuários administrativos
        final Usuario admin = criarUsuarioSeNaoExistir("Administrador Master", "admin@dunnas.com", "admin123",
                UsuarioRole.ADMINISTRADOR);
        final Usuario admin2 = criarUsuarioSeNaoExistir("Administrador Secundário", "admin2@dunnas.com", "admin456",
                UsuarioRole.ADMINISTRADOR);

        // Criar recepcionistas
        final Usuario recep1 = criarUsuarioSeNaoExistir("Maria Silva", "maria.silva@dunnas.com", "recep123",
                UsuarioRole.RECEPCIONISTA);
        final Usuario recep2 = criarUsuarioSeNaoExistir("João Santos", "joao.santos@dunnas.com", "recep456",
                UsuarioRole.RECEPCIONISTA);
        final Usuario recep3 = criarUsuarioSeNaoExistir("Ana Costa", "ana.costa@dunnas.com", "recep789",
                UsuarioRole.RECEPCIONISTA);

        // Criar clientes
        criarUsuarioSeNaoExistir("Carlos Oliveira", "carlos.oliveira@dunnas.com", "cliente123",
                UsuarioRole.CLIENTE);
        criarUsuarioSeNaoExistir("Pedro Alves", "pedro.alves@dunnas.com", "cliente456",
                UsuarioRole.CLIENTE);
        criarUsuarioSeNaoExistir("Mariana Lima", "mariana.lima@dunnas.com", "cliente789",
                UsuarioRole.CLIENTE);
        criarUsuarioSeNaoExistir("Fernanda Souza", "fernanda.souza@dunnas.com", "cliente012",
                UsuarioRole.CLIENTE);
        criarUsuarioSeNaoExistir("Ricardo Martins", "ricardo.martins@dunnas.com", "cliente345",
                UsuarioRole.CLIENTE);

        // Criar setores
        Setor dunnas = criarSetorSeNaoExistir("Setor Dunnas", 5000.0, recep1);
        Setor ufersa = criarSetorSeNaoExistir("Setor UFERSA", 3000.0, recep2);
        Setor financeiro = criarSetorSeNaoExistir("Setor Financeiro", 7500.0, recep1);
        Setor comercial = criarSetorSeNaoExistir("Setor Comercial", 4500.0, recep3);
        Setor operacoes = criarSetorSeNaoExistir("Setor Operações", 6000.0, recep2);
        Setor administrativo = criarSetorSeNaoExistir("Setor Administrativo", 6000.0, admin);

        // Criar salas para cada setor
        if (dunnas != null) {
            criarSalaSeNaoExistir("Sala de Reuniões 01", 8, 150.0, dunnas);
            criarSalaSeNaoExistir("Sala de Reuniões 02", 12, 200.0, dunnas);
            criarSalaSeNaoExistir("Sala de Treinamento", 25, 350.0, dunnas);
            criarSalaSeNaoExistir("Sala Executiva", 6, 180.0, dunnas);
            criarSalaSeNaoExistir("Auditório Dunnas", 50, 800.0, dunnas);
        }

        if (ufersa != null) {
            criarSalaSeNaoExistir("Sala Acadêmica 01", 10, 100.0, ufersa);
            criarSalaSeNaoExistir("Sala Acadêmica 02", 15, 120.0, ufersa);
            criarSalaSeNaoExistir("Laboratório de Pesquisa", 20, 250.0, ufersa);
            criarSalaSeNaoExistir("Sala de Estudos", 12, 80.0, ufersa);
            criarSalaSeNaoExistir("Auditório UFERSA", 100, 600.0, ufersa);
        }

        if (financeiro != null) {
            criarSalaSeNaoExistir("Sala Financeira 01", 6, 120.0, financeiro);
            criarSalaSeNaoExistir("Sala Financeira 02", 8, 140.0, financeiro);
            criarSalaSeNaoExistir("Sala de Controles", 4, 100.0, financeiro);
        }

        if (comercial != null) {
            criarSalaSeNaoExistir("Sala Comercial 01", 10, 160.0, comercial);
            criarSalaSeNaoExistir("Sala de Vendas", 8, 140.0, comercial);
            criarSalaSeNaoExistir("Sala de Apresentações", 18, 300.0, comercial);
        }

        if (operacoes != null) {
            criarSalaSeNaoExistir("Sala Operacional 01", 8, 130.0, operacoes);
            criarSalaSeNaoExistir("Sala Operacional 02", 10, 150.0, operacoes);
            criarSalaSeNaoExistir("Sala de Controle", 5, 110.0, operacoes);
            criarSalaSeNaoExistir("Sala de Logística", 12, 180.0, operacoes);
        }

        if (administrativo != null) {
            criarSalaSeNaoExistir("Sala Administrativa 01", 8, 130.0, operacoes);
            criarSalaSeNaoExistir("Sala Administrativa 02", 10, 150.0, operacoes);
        }

        // Salas com valor zero (gratuitas)
        if (dunnas != null) {
            criarSalaSeNaoExistir("Sala de Descanso", 15, 0.0, dunnas);
            criarSalaSeNaoExistir("Sala de Leitura", 10, 0.0, dunnas);
        }

        if (ufersa != null) {
            criarSalaSeNaoExistir("Sala de Estudos Gratuita", 20, 0.0, ufersa);
            criarSalaSeNaoExistir("Sala de Orientação", 6, 0.0, ufersa);
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
        return userRepository.findByEmailIgnoreCase(email);
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
        return setorRepository.findByNome(nome);
    }

    private Sala criarSalaSeNaoExistir(String nome, int capacidade, Double valorAluguel, Setor setor) {
        if (setor == null) {
            throw new EntityRequiredException("Setor é obrigatório!!");
        }

        if (!salaRepository.existsByNome(nome)) {
            Sala sala = Sala.builder()
                    .nome(nome)
                    .capacidade(capacidade)
                    .valorAluguel(BigDecimal.valueOf(valorAluguel))
                    .setor(setor)
                    .ativo(true)
                    .build();
            return salaRepository.save(sala);
        }
        return salaRepository.findByNome(nome);
    }

}
