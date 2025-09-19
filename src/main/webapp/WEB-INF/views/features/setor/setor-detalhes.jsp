<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %> <%@ page
import="com.dunnas.reservasalas.core.utils.FormatarData" %>
<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/datalist.css" rel="stylesheet" />
<link href="/static/css/details.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Detalhes do Setor</h1>
    <a href="/setores" class="btn btn-secondary">
      <i class="fas fa-arrow-left"></i> Voltar
    </a>
  </div>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>

  <div class="user-profile-card space-y-4">
    <div class="user-profile-header">
      <div class="user-avatar">
        <i class="fas fa-building"></i>
      </div>
      <div class="user-info">
        <h2>${setor.nome}</h2>
        <p class="user-email">ID: ${setor.id}</p>
      </div>
    </div>

    <div class="user-details">
      <div class="detail-row">
        <span class="detail-label">ID:</span>
        <span class="detail-value">${setor.id}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Nome:</span>
        <span class="detail-value">${setor.nome}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Valor caixa:</span>
        <span class="detail-value">R$ ${setor.valorCaixa}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Recepcionista:</span>
        <span class="detail-value"
          >${setor.recepcionista != null ?
          Capitalizar.capitalizar(setor.recepcionista.nome) : 'Não
          atribuído'}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Status:</span>
        <span class="user-status ${setor.ativo ? 'active' : 'inactive'}">
          ${setor.ativo ? "Ativo" : "Inativo"}
        </span>
      </div>
    </div>

    <div class="user-actions">
      <a
        href="/salas?setorId=${setor.id}"
        alt="Verificar salas"
        class="btn btn-primary btn-action"
      >
        <i class="fas fa-door-open text-sm"></i>
        Salas
      </a>
    </div>

    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR' && setor != null}">
      <div class="user-actions">
        <a
          href="/setores/${setor.id}/editar"
          class="btn btn-warning btn-action"
        >
          <i class="fas fa-edit"></i> Editar Setor
        </a>
        <a href="/setores/${setor.id}/excluir" class="btn btn-error btn-action">
          <i class="fas fa-trash"></i> Excluir Setor
        </a>
      </div>
    </c:if>
  </div>
</div>
