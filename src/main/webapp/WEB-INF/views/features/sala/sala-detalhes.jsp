<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/datalist.css" rel="stylesheet" />
<link href="/static/css/details.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Detalhes da Sala</h1>
    <a href="/salas" class="btn btn-secondary">
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
        <i class="fas fa-door-open"></i>
      </div>
      <div class="user-info">
        <h2>${sala.nome}</h2>
        <p class="user-email">ID: ${sala.id}</p>
      </div>
    </div>

    <div class="user-details">
      <div class="detail-row">
        <span class="detail-label">ID:</span>
        <span class="detail-value">${sala.id}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Nome:</span>
        <span class="detail-value">${sala.nome}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Valor aluguel:</span>
        <span class="detail-value">R$ ${sala.valorAluguel}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Capacidade máxima:</span>
        <span class="detail-value">${sala.capacidade} pessoas</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Setor:</span>
        <span class="detail-value"
          >${sala.setor != null ? Capitalizar.capitalizar(sala.setor.nome) :
          'Não atribuído'}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Status:</span>
        <span class="user-status ${sala.ativo ? 'active' : 'inactive'}">
          ${sala.ativo ? "Ativo" : "Inativo"}
        </span>
      </div>
    </div>

    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR' && sala != null}">
      <div class="user-actions">
        <a href="/salas/${sala.id}/editar" class="btn btn-warning btn-action">
          <i class="fas fa-edit"></i> Editar Sala
        </a>
        <a href="/salas/${sala.id}/excluir" class="btn btn-error btn-action">
          <i class="fas fa-trash"></i> Excluir Sala
        </a>
      </div>
    </c:if>
  </div>
</div>
