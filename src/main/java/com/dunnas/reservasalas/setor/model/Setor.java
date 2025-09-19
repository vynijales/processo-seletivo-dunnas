package com.dunnas.reservasalas.setor.model;

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
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

import com.dunnas.reservasalas.core.model.BaseEntity;
import com.dunnas.reservasalas.usuario.model.Usuario;

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
@Table(name = "setores")
public class Setor extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "O nome é obrigatório")
    @Size(max = 100, message = "O nome deve ter no máximo 100 caracteres")
    @Column(nullable = false, length = 100, unique = true)
    private String nome;

    @NotNull(message = "O valor do caixa é obrigatório")
    @PositiveOrZero
    @Column(name = "valor_caixa", nullable = false, columnDefinition = "NUMERIC(10,2) DEFAULT 0.00")
    private Double valorCaixa;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recepcionista_id", foreignKey = @ForeignKey(name = "fk_setores_recepcionista"))
    private Usuario recepcionista;

    @NotNull(message = "O status ativo é obrigatório")
    @Column(nullable = false)
    @Builder.Default
    private Boolean ativo = true;
}

// @ManyToOne(fetch = FetchType.LAZY) -> Define um relacionamento muitos-para-um
// com a entidade Usuario, usando carregamento preguiçoso (lazy loading) para
// otimizar o desempenho.
// @JoinColumn(name = "recepcionista_id", foreignKey = @ForeignKey(name =
// "fk_setores_recepcionista")) -> Especifica a coluna de junção na tabela
// "setores" que referencia a chave primária da tabela "usuarios", com uma
// restrição de chave estrangeira nomeada "fk_setores_recepcionista".
