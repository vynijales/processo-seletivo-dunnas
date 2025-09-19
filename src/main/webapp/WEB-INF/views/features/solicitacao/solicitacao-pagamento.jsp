<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %> <%@ page
import="java.time.LocalDateTime" %> <%@ page
import="java.time.format.DateTimeFormatter" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="titulo" value="Registrar Pagamento" />
<c:set var="valorAluguel" value="${solicitacao.sala.valorAluguel}" />
<c:set
  var="actionUrl"
  value="/solicitacoes/${solicitacao.id}/efetuarPagamento"
/>
<c:set var="textoBotao" value="Efetuar pagamento" />

<div class="main-content page-transition">
  <div class="form-container">
    <div class="form-header">
      <h1>${titulo}</h1>
      <p>Solicitação #${solicitacao.id}</p>
    </div>

    <div class="form-body">
      <!-- Componente de alerta para mensagens de erro -->
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

      <div class="info-section">
        <h2>Informações da Solicitação</h2>
        <div class="info-box">
          <p><strong>Cliente:</strong> ${solicitacao.cliente.nome}</p>
          <p>
            <strong>Sala:</strong> ${solicitacao.sala.nome}
            (${solicitacao.sala.setor.nome})
          </p>
          <p>
            <strong>Valor do Aluguel:</strong> R$
            ${solicitacao.sala.valorAluguel}
          </p>
          <p><strong>Status:</strong> ${solicitacao.status}</p>
          <p><strong>Data Inicial:</strong> ${solicitacao.dataInicio}</p>
          <p><strong>Data Final:</strong> ${solicitacao.dataFim}</p>
        </div>
      </div>

      <form action="${actionUrl}" method="post">
        <input type="hidden" name="solicitacaoId" value="${solicitacao.id}" />

        <div class="form-group">
          <label for="valor">Valor do Pagamento (R$)</label>
          <input
            type="number"
            id="valor"
            name="valor"
            min="${valorAluguel / 2}"
            max="${valorAluguel}"
            step="0.01"
            placeholder="0,00"
            class="form-input ${not empty errors['valor'] ? 'input-error' : ''}"
            required
          />
          <c:if test="${not empty errors['valor']}">
            <p class="error-message">${errors['valor']}</p>
          </c:if>
          <p class="input-info">
            Valor mínimo: R$ ${valorAluguel / 2} | Valor máximo: R$
            ${valorAluguel}
          </p>
          <p class="input-info">Utilize ponto (.) como separador decimal</p>
        </div>

        <button type="submit" class="btn-primary">
          <i class="fas fa-money-bill-wave"></i> ${textoBotao}
        </button>
      </form>

      <a href="/solicitacoes" class="back-link">
        <i class="fas fa-arrow-left"></i> Voltar à lista de solicitações
      </a>
    </div>
  </div>
</div>
