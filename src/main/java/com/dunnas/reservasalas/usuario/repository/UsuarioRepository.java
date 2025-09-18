package com.dunnas.reservasalas.usuario.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dunnas.reservasalas.usuario.model.Usuario;
import com.dunnas.reservasalas.usuario.model.UsuarioRole;

import io.micrometer.common.lang.Nullable;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    boolean existsByEmail(String email);

    Page<Usuario> findByNomeLike(String nome, Pageable pageable);

    List<Usuario> findByNomeLike(String nome);

    Page<Usuario> findByEmailIgnoreCase(String email, Pageable pageable);

    @Nullable
    Usuario findByEmailIgnoreCase(String email);

    Page<Usuario> findByNomeLikeAndEmailIgnoreCase(String nome, String email, Pageable pageable);

    List<Usuario> findByNomeLikeAndEmailIgnoreCase(String nome, String email);

    List<Usuario> findByRole(UsuarioRole role);

    @Query("SELECT u FROM Usuario u WHERE LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%'))")
    Page<Usuario> findByQuery(String q, Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE u.role=:role AND (LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%')))")
    Page<Usuario> findByQueryAndRole(String q, UsuarioRole role, Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%'))")
    List<Usuario> findByQuery(String q);

    @Query("SELECT u FROM Usuario u WHERE u.role=:role AND (LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%')))")
    List<Usuario> findByQueryAndRole(String q, UsuarioRole role);

    @Query("SELECT u FROM Usuario u WHERE u.role IN :roles AND " +
            "(LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%')))")
    Page<Usuario> findByQueryAndRoles(@Param("q") String q, @Param("roles") List<UsuarioRole> roles, Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE u.role IN :roles AND " +
            "(LOWER(u.nome) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :q, '%')))")
    List<Usuario> findByQueryAndRoles(@Param("q") String q, @Param("roles") List<UsuarioRole> roles);

    @Query("SELECT u FROM Usuario u WHERE u.role IN :roles")
    Page<Usuario> findByRoles(@Param("roles") List<UsuarioRole> roles, Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE u.role IN :roles")
    List<Usuario> findByRoles(@Param("roles") List<UsuarioRole> roles);

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
