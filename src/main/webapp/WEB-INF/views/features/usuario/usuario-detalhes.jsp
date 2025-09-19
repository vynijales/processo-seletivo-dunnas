<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/datalist.css" rel="stylesheet" />
<link href="/static/css/details.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Detalhes do Usuário</h1>
    <a href="/usuarios" class="btn btn-secondary">
      <i class="fas fa-arrow-left"></i> Voltar
    </a>
  </div>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>

  <div class="user-profile-card">
    <div class="user-profile-header">
      <div class="user-avatar">
        <i class="fas fa-user-circle"></i>
      </div>
      <div class="user-info">
        <h2>${usuario.nome}</h2>
        <p class="user-email">${usuario.email}</p>
      </div>
    </div>

    <div class="user-details">
      <div class="detail-row">
        <span class="detail-label">ID:</span>
        <span class="detail-value">${usuario.id}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Tipo de usuário:</span>
        <span class="user-role ${usuario.role.toString().toLowerCase()}"
          >${usuario.role}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Status:</span>
        <span class="user-status ${usuario.ativo ? 'active' : 'inactive'}">
          ${usuario.ativo ? "Ativo" : "Inativo"}
        </span>
      </div>
    </div>

    <c:if
      test="${usuario != null && (usuario.id == usuarioLogado.id || (usuarioLogado != null && usuarioLogado.role == 'ADMINISTRADOR'))}"
    >
      <div class="user-actions">
        <a
          href="/usuarios/${usuario.id}/editar"
          class="btn btn-warning btn-action"
        >
          <i class="fas fa-edit"></i> Editar Perfil
        </a>
        <a
          href="/usuarios/${usuario.id}/excluir"
          class="btn btn-error btn-action"
        >
          <i class="fas fa-trash"></i> Excluir Usuário
        </a>
      </div>
    </c:if>
  </div>
</div>
