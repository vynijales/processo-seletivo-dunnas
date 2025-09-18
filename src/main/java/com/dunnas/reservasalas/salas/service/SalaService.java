package com.dunnas.reservasalas.salas.service;

import java.util.List;

import jakarta.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.salas.model.Sala;
import com.dunnas.reservasalas.salas.repository.SalaRepository;

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
                .orElse(null);

        if (existingSala != null) {
            Sala novoSala = salaMapper.toEntity(req);

            return salaRepository.save(novoSala);
        }

        return null;
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
