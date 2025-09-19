package com.dunnas.reservasalas.agendamento.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.dunnas.reservasalas.core.model.BaseEntity;
import com.dunnas.reservasalas.sala.model.Sala;
import com.dunnas.reservasalas.usuario.model.Usuario;

import io.micrometer.common.lang.Nullable;
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
@Table(name = "agendamentos")
public class Agendamento extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Nullable
    @Column(name = "solicitacao_id")
    private Long solicitacaoId; // Opcional para Agendamentos criados pelo recepcionista/admin

    @NotNull(message = "O cliente é obrigatório")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cliente_id", nullable = false, foreignKey = @ForeignKey(name = "fk_solicitacoes_cliente"))
    private Usuario cliente;

    @NotNull(message = "A sala é obrigatória")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "sala_id", nullable = false, foreignKey = @ForeignKey(name = "fk_solicitacoes_sala"))
    private Sala sala;

    @NotNull(message = "A data de início é obrigatória")
    @FutureOrPresent(message = "A data de início deve ser atual ou futura")
    @Column(name = "data_inicio", nullable = false)
    private LocalDateTime dataInicio;

    @NotNull(message = "A data de fim é obrigatória")
    @Future(message = "A data de fim deve ser futura")
    @Column(name = "data_fim", nullable = false)
    private LocalDateTime dataFim;

    @NotNull(message = "O status é obrigatório")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    @Builder.Default
    private AgendamentoStatus status = AgendamentoStatus.CONFIRMADO;

    @Column(name = "valor_pago", nullable = false)
    @PositiveOrZero(message = "O valor deve ser positivo ou zero")
    private BigDecimal valorPago;

    @Column(name = "data_criacao", updatable = false)
    @CreationTimestamp
    private LocalDateTime dataCriacao;

    @Column(name = "data_atualizacao")
    @UpdateTimestamp
    private LocalDateTime dataAtualizacao;
}
