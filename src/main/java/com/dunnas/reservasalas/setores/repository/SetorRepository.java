package com.dunnas.reservasalas.setores.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.reservasalas.setores.model.Setor;

public interface SetorRepository extends JpaRepository<Setor, Long> {

    Page<Setor> findByNomeLike(String nome, Pageable pageable);

}
