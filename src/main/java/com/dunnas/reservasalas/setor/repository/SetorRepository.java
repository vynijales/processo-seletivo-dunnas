package com.dunnas.reservasalas.setor.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.reservasalas.setor.model.Setor;

public interface SetorRepository extends JpaRepository<Setor, Long> {

    boolean existsByNome(String nome);

    Page<Setor> findByNomeContainingIgnoreCase(String nome, Pageable pageable);

    Setor findByNome(String nome);

    List<Setor> findByNomeContainingIgnoreCase(String nome);

    List<Setor> findAllByRecepcionistaId(Long recepcionistaId);

    Page<Setor> findByRecepcionistaId(Long recepcionistaId, Pageable pageable);

    List<Setor> findByRecepcionistaId(Long recepcionistaId);

    Page<Setor> findByRecepcionistaIdAndNomeContainingIgnoreCase(Long recepcionistaId, String nome, Pageable pageable);
}
