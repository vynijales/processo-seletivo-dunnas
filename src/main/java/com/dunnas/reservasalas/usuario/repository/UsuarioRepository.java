package com.dunnas.reservasalas.usuario.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    boolean existsByEmail(String email);

    Page<Usuario> findByNomeLike(String nome, Pageable pageable);

    Page<Usuario> findByEmailIgnoreCase(String email, Pageable pageable);

    Optional<Usuario> findByEmailIgnoreCase(String email);

    Page<Usuario> findByNomeLikeAndEmailIgnoreCase(String nome, String email, Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%'))")
    Page<Usuario> findByQuery(String q, Pageable pageable);

    // Update all, less password
    @Modifying
    @Query("UPDATE Usuario u SET u.nome = :nome, u.email = :email, u.role = :role, u.ativo = :ativo WHERE u.id = :id")
    void updateUsuarioWithoutPassword(
            @Param("id") Long id,
            @Param("nome") String nome,
            @Param("email") String email,
            @Param("role") UsuarioRole role,
            @Param("ativo") boolean ativo);
}

// Extende JpaRepository para herdar métodos de CRUD e outras operações
// save(), findById(), findAll(), count(), delete(), deleteById(), etc.

// @Query permite definir consultas personalizadas usando JPQL (Java Persistence
// Query Language) com proteção contra SQL Injection
