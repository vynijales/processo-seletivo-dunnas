package com.dunnas.reservasalas.sala.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

import com.dunnas.reservasalas.core.model.BaseEntity;
import com.dunnas.reservasalas.setor.model.Setor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "salas")
public class Sala extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "O nome é obrigatório")
    @Size(max = 100, message = "O nome deve ter no máximo 100 caracteres")
    @Column(nullable = false, length = 100)
    private String nome;

    @NotNull(message = "A capacidade é obrigatória")
    @Positive(message = "A capacidade precisa ser positiva")
    @Column(nullable = false)
    private Integer capacidade;

    @NotNull(message = "O valor do aluguel é obrigatório")
    @PositiveOrZero(message = "O valor do aluguel deve ser positivo ou zero")
    @Column(name = "valor_aluguel", nullable = false, precision = 10, scale = 2)
    private BigDecimal valorAluguel;

    @NotNull(message = "O setor é obrigatório")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "setor_id", nullable = false, foreignKey = @ForeignKey(name = "fk_salas_setor"))
    private Setor setor;

    @Builder.Default
    @Column(nullable = false)
    private Boolean ativo = true;

}
