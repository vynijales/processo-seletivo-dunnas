package com.dunnas.reservasalas.setor.service;

import java.util.List;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dunnas.reservasalas.setor.model.Setor;
import com.dunnas.reservasalas.setor.repository.SetorRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SetorService {
    private final SetorRepository setorRepository;
    private final SetorMapper setorMapper;

    public Page<Setor> list(Pageable pageable) {
        return setorRepository.findAll(pageable);
    }

    public List<Setor> list() {
        return setorRepository.findAll();
    }

    public Page<Setor> search(String query, Pageable pageable) {
        return setorRepository.findByNomeContainingIgnoreCase(query, pageable);
    }

    public List<Setor> search(String query) {
        return setorRepository.findByNomeContainingIgnoreCase(query);
    }

    public Setor getById(Long id) {
        return setorRepository.findById(id).orElse(null);
    }

    public List<Setor> getAllByRecepcionistaId(Long id) {
        return setorRepository.findAllByRecepcionistaId(id);
    }

    @Transactional
    public Setor create(SetorRequest req) {
        Setor novoSetor = setorMapper.toEntity(req);
        return setorRepository.save(novoSetor);
    }

    @Transactional
    public Setor update(Long id, SetorRequest req) {
        Setor existingSetor = setorRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Setor não encontrado"));

        if (existingSetor != null) {
            Setor novoSetor = setorMapper.toEntity(req);
            novoSetor.setId(id);
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
