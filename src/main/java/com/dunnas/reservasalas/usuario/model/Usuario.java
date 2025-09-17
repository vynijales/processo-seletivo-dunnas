package com.dunnas.reservasalas.usuario.model;

import java.util.Collection;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.dunnas.reservasalas.core.model.BaseEntity;

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
@Table(name = "usuarios", uniqueConstraints = @UniqueConstraint(columnNames = "email"), indexes = @Index(columnList = "email"))
public class Usuario extends BaseEntity implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "O nome é obrigatório")
    @Size(max = 100, message = "O nome deve ter no máximo 100 caracteres")
    @Column(nullable = false, length = 100)
    private String nome;

    @NotBlank(message = "O email é obrigatório")
    @Email(message = "O email deve ser válido")
    @Column(unique = true, nullable = false)
    private String email;

    @NotBlank(message = "A senha é obrigatória")
    @Column(nullable = false)
    private String senha;

    @NotNull(message = "O papel é obrigatório")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UsuarioRole role;

    @EqualsAndHashCode.Exclude
    private boolean ativo;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(getRole().name()));
    }

    @Override
    public String getPassword() {
        return getSenha();
    }

    @Override
    public String getUsername() {
        return getEmail();
    }

}

// @Entity -> Define a classe como uma entidade JPA
// @Data -> Gera getters, setters, toString, equals e hashCode automaticamente
// @EqualsAndHashCode(callSuper = true) -> Inclui os campos da superclasse
// BaseEntity nos métodos equals e hashCode
// @NoArgsConstructor -> Gera um construtor sem argumentos
// @AllArgsConstructor -> Gera um construtor com todos os argumentos
// @Builder -> Gera um builder para a classe
// @Table -> Define o nome da tabela, suas constraints e índices

// @NotBlank -> Não nulo e não "" (antes de persistir no banco de dados)
// @Column(nullable = false) -> Restrição do banco de dados
