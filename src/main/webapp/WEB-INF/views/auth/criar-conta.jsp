<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="titulo" value="Criar Conta" />
<c:set var="actionUrl" value="/processar-criar-conta" />
<c:set var="textoBotao" value="Criar Conta" />

<div class="form-container fade-in">
  <div class="form-header">
    <h1 class="text-2xl font-bold">${titulo}</h1>
    <p class="text-gray-600">Preencha os dados abaixo para criar sua conta</p>
  </div>

  <div class="form-body">
    <!-- Componente de alerta reutilizável -->
    <c:if test="${not empty errorMessage}">
      <div class="alert alert-error">
        <div class="alert-icon">
          <i class="fas fa-exclamation-circle"></i>
        </div>
        <div class="alert-content">
          <div class="alert-title">Erro</div>
          <div class="alert-message">${errorMessage}</div>
        </div>
      </div>
    </c:if>

    <!-- Exibir erros de validação específicos -->
    <c:if test="${not empty errors}">
      <div class="alert alert-error">
        <div class="alert-icon">
          <i class="fas fa-exclamation-circle"></i>
        </div>
        <div class="alert-content">
          <div class="alert-title">Erros de Validação</div>
          <div class="alert-message">
            <ul>
              <c:forEach var="error" items="${errors}">
                <li>${error.defaultMessage}</li>
              </c:forEach>
            </ul>
          </div>
        </div>
      </div>
    </c:if>

    <c:if test="${not empty successMessage}">
      <div class="alert alert-success">
        <div class="alert-icon">
          <i class="fas fa-check-circle"></i>
        </div>
        <div class="alert-content">
          <div class="alert-title">Sucesso</div>
          <div class="alert-message">${successMessage}</div>
        </div>
      </div>
    </c:if>

    <form action="${actionUrl}" method="post">
      <div class="form-group">
        <label for="nome" class="form-label">Nome Completo</label>
        <input
          type="text"
          id="nome"
          name="nome"
          value="${usuarioRequest.nome}"
          minlength="1"
          maxlength="100"
          placeholder="Digite seu nome completo"
          class="form-input ${not empty errors['nome'] ? 'border-red-500' : ''}"
          required
        />
        <c:if test="${not empty errors['nome']}">
          <p class="text-red-500 text-sm mt-1">${errors['nome']}</p>
        </c:if>
      </div>

      <div class="form-group">
        <label for="email" class="form-label">E-mail</label>
        <input
          type="email"
          id="email"
          name="email"
          value="${usuarioRequest.email}"
          minlength="5"
          maxlength="255"
          placeholder="exemplo@dominio.com"
          class="form-input ${not empty errors['email'] ? 'border-red-500' : ''}"
          required
        />
        <c:if test="${not empty errors['email']}">
          <p class="text-red-500 text-sm mt-1">${errors['email']}</p>
        </c:if>
      </div>

      <div class="form-group">
        <label for="senha" class="form-label">Senha</label>
        <input
          type="password"
          id="senha"
          name="senha"
          placeholder="Digite sua senha"
          class="form-input ${not empty errors['senha'] ? 'border-red-500' : ''}"
          minlength="8"
          required
          maxlength="255"
        />
        <c:if test="${not empty errors['senha']}">
          <p class="text-red-500 text-sm mt-1">${errors['senha']}</p>
        </c:if>
        <p class="password-info">Mínimo de 8 caracteres</p>
      </div>

      <!-- Campo role oculto para definir como CLIENTE por padrão -->
      <input type="hidden" name="role" value="CLIENTE" />
      <input type="hidden" name="ativo" value="true" />

      <button type="submit" class="btn-primary">
        <i class="fas fa-user-plus mr-2"></i> ${textoBotao}
      </button>
    </form>

    <div class="mt-4 text-center">
      <a href="/entrar" class="back-link">
        <i class="fas fa-arrow-left mr-1"></i> Voltar para a página inicial
      </a>
    </div>
  </div>
</div>
