package com.dunnas.reservasalas.setores.service;

import jakarta.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.setores.model.Setor;
import com.dunnas.reservasalas.setores.repository.SetorRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SetorService {
    private final SetorRepository setorRepository;
    private final SetorMapper setorMapper;

    public Page<Setor> list(Pageable pageable) {
        return setorRepository.findAll(pageable);
    }

    public Page<Setor> search(String query, Pageable pageable) {
        return setorRepository.findByNomeLike(query, pageable);
    }

    public Setor getById(Long id) {
        return setorRepository.findById(id).orElse(null);
    }

    @Transactional
    public Setor create(SetorRequest req) {
        Setor novoSetor = setorMapper.toEntity(req);
        return setorRepository.save(novoSetor);
    }

    @Transactional
    public Setor update(Long id, SetorRequest req) {
        Setor existingSetor = setorRepository.findById(id)
                .orElse(null);

        if (existingSetor != null) {
            Setor novoSetor = setorMapper.toEntity(req);

            return setorRepository.save(novoSetor);
        }

        return null;
    }

    @Transactional
    public boolean delete(Long id) {
        if (setorRepository.existsById(id)) {
            setorRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
