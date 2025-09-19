<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="titulo" value="Entrar no Sistema" />

<div class="form-container fade-in">
  <div class="form-header">
    <h1 class="text-2xl font-bold">${titulo}</h1>
    <p class="text-gray-600">Acesse sua conta para continuar</p>
  </div>

  <div class="form-body">
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

      <!-- Mensagem de sucesso (após criação de conta) -->
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

      <!-- Mensagem de logout -->
      <c:if test="${not empty logoutMessage}">
        <div class="alert alert-success">
          <div class="alert-icon">
            <i class="fas fa-check-circle"></i>
          </div>
          <div class="alert-content">
            <div class="alert-title">Sucesso</div>
            <div class="alert-message">${logoutMessage}</div>
          </div>
        </div>
      </c:if>

      <form action="/processar-entrar" method="post">
        <div class="form-group">
          <label for="email" class="form-label">E-mail</label>
          <input
            type="email"
            id="email"
            name="email"
            class="form-input"
            placeholder="exemplo@dominio.com"
            required
          />
        </div>

        <div class="form-group">
          <label for="password" class="form-label">Senha</label>
          <input
            type="password"
            id="password"
            name="password"
            class="form-input"
            placeholder="Digite sua senha"
            required
          />
        </div>

        <button type="submit" class="btn-primary w-full">
          <i class="fas fa-sign-in-alt mr-2"></i> Entrar
        </button>
      </form>
      <div class="text-center">
        <a href="/criar-conta" class="back-link">
          <i class="fas fa-arrow-left mr-1"></i> Criar conta
        </a>
      </div>
    </div>
  </div>
</div>
