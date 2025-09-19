<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="static/css/main.css" rel="stylesheet" />
<link href="static/css/datalist.css" rel="stylesheet" />

<div class="container space-y-4 p-4">
  <div class="page-header">
    <div class="header-content">
      <h1 class="page-title">Usuários</h1>
      
      <!-- Botão para alternar o painel de filtros -->
      <button class="btn btn-secondary btn-filter" onclick="toggleFilter()">
        <i class="fas fa-filter"></i>
      </button>
    </div>
    
    <a href="/usuarios/criar" class="btn btn-primary btn-new">
      <i class="fas fa-plus"></i> Novo Usuário
    </a>
  </div>
  
  <!-- Painel de filtros - inicialmente colapsado -->
  <div id="filter-panel" class="collapsible-content">
    <div>
      <form id="q" action="/usuarios" method="get" class="search-form">
        <div class="input-group with-icon">
          <i class="fas fa-search input-icon"></i>
          <input
            type="text"
            name="q"
            id="searchInput"
            class="form-control search-input"
            placeholder="Pesquisar por nome ou e-mail..."
            value="${param.q}"
            list="usuariosList" 
          />
          <datalist id="usuariosList">  
            <c:forEach var="u" items="${usuarios.content}">
              <option value="${u.nome}"> 
            </c:forEach>
          </datalist>

          <div class="input-group-actions">
            <c:if test="${not empty param.q}">
              <button
                type="button"
                class="btn btn-icon clear-input"
                onclick="clearSearch('/usuarios')"
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
  
  <div class="data-table-container">
    <c:choose>
      <c:when test="${not empty usuarios.content && !usuarios.content.isEmpty()}">
        <table class="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Email</th>
              <th>Nível de Acesso</th>
              <th>Ações</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="u" items="${usuarios.content}">
              <tr>
                <td>${u.id}</td>
                <td>${u.nome}</td>
                <td>${u.email}</td>
                <td>
                  <c:choose>
                    <c:when test="${u.role == 'CLIENTE'}">
                      <span class="badge badge-client">
                        ${Capitalizar.capitalizar(u.role)}
                      </span>
                    </c:when>
                    <c:when test="${u.role == 'RECEPCIONISTA'}">
                      <span class="badge badge-receptionist">
                        ${Capitalizar.capitalizar(u.role)}
                      </span>
                    </c:when>
                    <c:when test="${u.role == 'ADMINISTRADOR'}">
                      <span class="badge badge-admin">
                        ${Capitalizar.capitalizar(u.role)}
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge">
                        ${Capitalizar.capitalizar(u.role)}
                      </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div class="action-buttons">
                    <a href="/usuarios/${u.id}" class="btn btn-primary btn-sm btn-action">
                      <i class="fas fa-eye"></i>
                      <span>Ver</span>
                    </a>

                    <c:if test="${u.id == usuarioLogado.id || usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a href="/usuarios/${u.id}/editar" class="btn btn-warning btn-sm btn-action">
                        <i class="fas fa-edit"></i>
                        <span>Editar</span>
                      </a>
                    </c:if>

                    <c:if test="${u.id != usuarioLogado.id && usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a href="/usuarios/${u.id}/excluir" class="btn btn-error btn-sm btn-action" onclick="return confirm('Tem certeza que deseja excluir este usuário?')">
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
            <i class="fas fa-users"></i>
          </div>
          <h3 class="empty-state-text">
            <c:choose>
              <c:when test="${not empty param.q}">
                Nenhum usuário encontrado para "${param.q}"
              </c:when>
              <c:otherwise>
                Nenhum usuário encontrado
              </c:otherwise>
            </c:choose>
          </h3>
          <a href="/usuarios/criar" class="btn btn-primary btn-new">
            <i class="fas fa-plus"></i> Criar Primeiro Usuário
          </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
  
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

