<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %> <%@ page
import="com.dunnas.reservasalas.core.utils.FormatarData" %>
<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/datalist.css" rel="stylesheet" />
<link href="/static/css/details.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Detalhes da Solicitação</h1>
    <a href="/solicitacoes" class="btn btn-secondary">
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
        <i class="fas fa-calendar-check"></i>
      </div>
      <div class="user-info">
        <h2>Solicitação #${solicitacao.id}</h2>
        <p class="user-email">
          Status: ${Capitalizar.capitalizar(solicitacao.status.toString())}
        </p>
      </div>
    </div>

    <div class="user-details">
      <div class="detail-row">
        <span class="detail-label">ID:</span>
        <span class="detail-value">${solicitacao.id}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Cliente:</span>
        <span class="detail-value"
          >${Capitalizar.capitalizar(solicitacao.cliente.nome)}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Sala:</span>
        <span class="detail-value">${solicitacao.sala.nome}</span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Data de início:</span>
        <span class="detail-value"
          >${FormatarData.toStringAmigavel(solicitacao.dataInicio)}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Data de fim:</span>
        <span class="detail-value"
          >${FormatarData.toStringAmigavel(solicitacao.dataFim)}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Status:</span>
        <span
          class="user-status ${solicitacao.status.toString().toLowerCase()}"
        >
          ${Capitalizar.capitalizar(solicitacao.status.toString())}
        </span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Sinal pago:</span>
        <span class="detail-value"
          >${solicitacao.sinalPago ? "Sim" : "Não"}</span
        >
      </div>
      <div class="detail-row">
        <span class="detail-label">Data de criação:</span>
        <span class="detail-value"
          >${FormatarData.toStringAmigavel(solicitacao.dataCriacao)}</span
        >
      </div>
      <c:if test="${solicitacao.dataAtualizacao != null}">
        <div class="detail-row">
          <span class="detail-label">Última atualização:</span>
          <span class="detail-value"
            >${FormatarData.toStringAmigavel(solicitacao.dataAtualizacao)}</span
          >
        </div>
      </c:if>
    </div>

    <c:if
      test="${usuarioLogado.role == 'ADMINISTRADOR' && solicitacao != null}"
    >
      <div class="user-actions">
        <a
          href="/solicitacoes/${solicitacao.id}/editar"
          class="btn btn-warning btn-action"
        >
          <i class="fas fa-edit"></i> Editar Solicitação
        </a>
        <a
          href="/solicitacoes/${solicitacao.id}/excluir"
          class="btn btn-error btn-action"
        >
          <i class="fas fa-trash"></i> Excluir Solicitação
        </a>
      </div>
    </c:if>
  </div>
</div>

<style>
  .user-status.solicitado {
    background-color: #3b82f6;
    color: white;
  }

  .user-status.aprovado {
    background-color: #10b981;
    color: white;
  }

  .user-status.negado {
    background-color: #ef4444;
    color: white;
  }

  .user-status.cancelado {
    background-color: #6b7280;
    color: white;
  }

  .user-status.finalizado {
    background-color: #8b5cf6;
    color: white;
  }

  .user-status.em_andamento {
    background-color: #f59e0b;
    color: white;
  }
</style>
