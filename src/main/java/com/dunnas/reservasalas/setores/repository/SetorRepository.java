package com.dunnas.reservasalas.setores.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.reservasalas.setores.model.Setor;

public interface SetorRepository extends JpaRepository<Setor, Long> {

    boolean existsByNome(String nome);

    Page<Setor> findByNomeContainingIgnoreCase(String nome, Pageable pageable);

    List<Setor> findByNomeContainingIgnoreCase(String nome);

    List<Setor> findAllByRecepcionistaId(Long recepcionistaId);
}
