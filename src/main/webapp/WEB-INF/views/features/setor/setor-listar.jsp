<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="static/css/main.css" rel="stylesheet" />
<link href="static/css/datalist.css" rel="stylesheet" />

<div class="container space-y-4 p-4">
  <div class="page-header">
    <div class="header-content">
      <h1 class="page-title">Setores</h1>
      
      <!-- Botão para alternar o painel de filtros -->
      <button class="btn btn-secondary btn-filter" onclick="toggleFilter()">
        <i class="fas fa-filter"></i>
      </button>
    </div>
    
    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
      <a href="/setores/criar" class="btn btn-primary btn-new">
        <i class="fas fa-plus"></i> Novo Setor
      </a>
    </c:if>
  </div>
  
  <!-- Painel de filtros - inicialmente colapsado -->
  <div id="filter-panel" class="collapsible-content">
    <div>
      <form id="q" action="/setores" method="get" class="search-form">
        <div class="input-group with-icon">
          <i class="fas fa-search input-icon"></i>
          <input
            type="text"
            name="q"
            id="searchInput"
            class="form-control search-input"
            placeholder="Pesquisar por nome do setor..."
            value="${param.q}"
            list="setoresList" 
          />
          <datalist id="setoresList">  
            <c:forEach var="s" items="${setores.content}">
              <option value="${s.nome}"> 
            </c:forEach>
          </datalist>

          <div class="input-group-actions">
            <c:if test="${not empty param.q}">
              <button
                type="button"
                class="btn btn-icon clear-input"
                onclick="clearSearch('/setores')"
              >
                <i class="fas fa-times"></i>
              </button>
            </c:if>
            <button type="submit" class="btn btn-primary search-button">
              <i class="fas fa-search"></i>
              <span class="btn-text">Pesquisar</span>
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>

  <div class="data-table-container">
    <c:choose>
      <c:when test="${not empty setores.content && !setores.content.isEmpty()}">
        <table class="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Valor caixa (R$)</th>
              <th>Recepcionista</th>
              <th>Ações</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="s" items="${setores.content}">
              <tr>
                <td>${s.id}</td>
                <td>${s.nome}</td>
                <td>${s.valorCaixa}</td>
                <td>
                  ${s.recepcionista != null ?
                  Capitalizar.capitalizar(s.recepcionista.nome) : 'N/A'}
                </td>
                <td>
                  <div class="action-buttons">
                    <a
                      href="/setores/${s.id}"
                      class="btn btn-primary btn-sm btn-action"
                    >
                      <i class="fas fa-eye"></i>
                      <span>Ver</span>
                    </a>

                    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a
                        href="/setores/${s.id}/editar"
                        class="btn btn-warning btn-sm btn-action"
                      >
                        <i class="fas fa-edit"></i>
                        <span>Editar</span>
                      </a>
                    </c:if>

                    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a
                        href="/setores/${s.id}/excluir"
                        class="btn btn-error btn-sm btn-action"
                        onclick="return confirm('Tem certeza que deseja excluir este setor?')"
                      >
                        <i class="fas fa-trash"></i>
                        <span>Excluir</span>
                      </a>
                    </c:if>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <div class="empty-state">
          <div class="empty-state-icon">
            <i class="fas fa-building"></i>
          </div>
          <h3 class="empty-state-text">
            <c:choose>
              <c:when test="${not empty param.q}">
                Nenhum setor encontrado para "${param.q}"
              </c:when>
              <c:otherwise>
                Nenhum setor encontrado
              </c:otherwise>
            </c:choose>
          </h3>
          <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
            <a href="/setores/criar" class="btn btn-primary btn-new">
              <i class="fas fa-plus"></i> Criar Primeiro Setor
            </a>
          </c:if>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <c:if
    test="${not empty setores.content && !setores.content.isEmpty() && (setores.totalPages > 1)}"
  >
    <div class="pagination">
      <c:if test="${setores.hasPrevious()}">
        <a href="/setores?page=${setores.number - 1}<c:if test="${not empty param.q}">&q=${param.q}</c:if>" class="pagination-item">
          <i class="fas fa-chevron-left"></i>
        </a>
      </c:if>

      <c:forEach begin="0" end="${setores.totalPages - 1}" var="i">
        <a
          href="/setores?page=${i}<c:if test="${not empty param.q}">&q=${param.q}</c:if>"
          class="pagination-item ${i == setores.number ? 'active' : ''}"
        >
          ${i + 1}
        </a>
      </c:forEach>

      <c:if test="${setores.hasNext()}">
        <a href="/setores?page=${setores.number + 1}<c:if test="${not empty param.q}">&q=${param.q}</c:if>" class="pagination-item">
          <i class="fas fa-chevron-right"></i>
        </a>
      </c:if>
    </div>
  </c:if>
</div>

<script src="/static/js/datalist.js"></script>
<script>
  // Script para remover o parâmetro 'page' ao enviar o formulário de pesquisa
  document.getElementById("q").addEventListener("submit", function (e) {
    const url = new URL(window.location.href);
    url.searchParams.delete("page");
    const formData = new FormData(this);
    for (const [key, value] of formData.entries()) {
      if (value) {
        url.searchParams.set(key, value);
      } else {
        url.searchParams.delete(key);
      }
    }
    window.location.href = url.toString();
    e.preventDefault();
  });
</script>
