package com.dunnas.reservasalas.sala.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.reservasalas.sala.model.Sala;

public interface SalaRepository extends JpaRepository<Sala, Long> {

    boolean existsByNome(String nome);

    Page<Sala> findByNomeLike(String nome, Pageable pageable);

    Page<Sala> findByNomeLikeAndSetorId(String nome, int setor_id, Pageable pageable);

    List<Sala> findByNomeLikeAndSetorId(String nome, int setor_id);

    Page<Sala> findBySetorId(int setor_id, Pageable pageable);

    List<Sala> findBySetorId(int setor_id);

    Sala findByNome(String nome);

    List<Sala> findByNomeLike(String nome);

    Page<Sala> findBySetorRecepcionistaId(Long recepcionistaId, Pageable pageable);

    List<Sala> findBySetorRecepcionistaId(Long recepcionistaId);

    Page<Sala> findBySetorRecepcionistaIdAndNomeContainingIgnoreCase(Long recepcionistaId, String nome,
            Pageable pageable);

}
