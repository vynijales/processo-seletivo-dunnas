package com.dunnas.reservasalas.core.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;

@MappedSuperclass
@Data
public abstract class BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @EqualsAndHashCode.Exclude
    @CreationTimestamp
    @Column(updatable = false, name = "data_criacao")
    private LocalDateTime dataCriacao;

    @EqualsAndHashCode.Exclude
    @UpdateTimestamp
    @Column(nullable = false, name = "data_atualizacao")
    private LocalDateTime dataAtualizacao;
}

// @MappedSuperclass -> Indica que esta classe é uma superclasse mapeada, ou
// seja, suas propriedades serão herdadas por outras entidades JPA (não cria
// tabela no banco de dados)

// @Data -> Gera getters, setters, toString, equals e hashCode automaticamente
// @NoArgsConstructor -> Gera um construtor sem argumentos
// @AllArgsConstructor -> Gera um construtor com todos os argumentos

// @EqualsAndHashCode.Exclude -> Exclui o campo anotado dos métodos equals e
// hashCode
