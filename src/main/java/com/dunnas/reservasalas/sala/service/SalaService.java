package com.dunnas.reservasalas.sala.service;

import java.util.List;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.sala.repository.SalaRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SalaService {
    private final SalaRepository salaRepository;
    private final SalaMapper salaMapper;

    public Page<Sala> list(Pageable pageable) {
        return salaRepository.findAll(pageable);
    }

    public List<Sala> list() {
        return salaRepository.findAll();
    }

    public Page<Sala> search(String query, Pageable pageable) {
        return salaRepository.findByNomeLike(query, pageable);
    }

    public List<Sala> search(String query) {
        return salaRepository.findByNomeLike(query);
    }

    public Sala getById(Long id) {
        return salaRepository.findById(id).orElse(null);
    }

    @Transactional
    public Sala create(SalaRequest req) {
        Sala novoSala = salaMapper.toEntity(req);
        return salaRepository.save(novoSala);
    }

    @Transactional
    public Sala update(Long id, SalaRequest req) {
        Sala existingSala = salaRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Sala não encontrada"));

        // Atualiza os campos mantendo a mesma entidade
        existingSala.setNome(req.getNome());
        existingSala.setCapacidade(req.getCapacidade());
        existingSala.setValorAluguel(req.getValorAluguel());
        existingSala.setAtivo(req.getAtivo() != null ? req.getAtivo() : existingSala.getAtivo());

        return salaRepository.save(existingSala);
    }

    @Transactional
    public boolean delete(Long id) {
        if (salaRepository.existsById(id)) {
            salaRepository.deleteById(id);
            return true;
        }
        return false;
    }

}
