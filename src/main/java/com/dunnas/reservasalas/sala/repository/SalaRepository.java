package com.dunnas.reservasalas.sala.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.reservasalas.sala.model.Sala;

public interface SalaRepository extends JpaRepository<Sala, Long> {

    boolean existsByNome(String nome);

    Page<Sala> findByNomeLike(String nome, Pageable pageable);

    List<Sala> findByNomeLike(String nome);

}
