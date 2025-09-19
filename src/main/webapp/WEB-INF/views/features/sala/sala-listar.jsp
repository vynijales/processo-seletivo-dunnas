<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="static/css/main.css" rel="stylesheet" />
<link href="static/css/datalist.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Salas</h1>
    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
      <a href="/salas/criar" class="btn btn-primary btn-new">
        <i class="fas fa-plus"></i> Nova Sala
      </a>
    </c:if>
  </div>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>

  <div class="data-table-container">
    <c:choose>
      <c:when test="${not empty salas.content && !salas.content.isEmpty()}">
        <table class="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Capacidade</th>
              <th>Aluguel (R$)</th>
              <th>Setor</th>
              <th>Ações</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="s" items="${salas.content}">
              <tr>
                <td>${s.id}</td>
                <td>${s.nome}</td>
                <td>${s.capacidade}</td>
                <td>${s.valorAluguel}</td>
                <td>
                  ${s.setor != null ? Capitalizar.capitalizar(s.setor.nome) :
                  'N/A'}
                </td>
                <td>
                  <div class="action-buttons">
                    <a
                      href="/salas/${s.id}"
                      class="btn btn-primary btn-sm btn-action"
                    >
                      <i class="fas fa-eye"></i>
                      <span>Ver</span>
                    </a>

                    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a
                        href="/salas/${s.id}/editar"
                        class="btn btn-warning btn-sm btn-action"
                      >
                        <i class="fas fa-edit"></i>
                        <span>Editar</span>
                      </a>
                    </c:if>

                    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                      <a
                        href="/salas/${s.id}/excluir"
                        class="btn btn-error btn-sm btn-action"
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
            <i class="fas fa-door-open"></i>
          </div>
          <h3 class="empty-state-text">Nenhuma sala encontrada</h3>
          <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
            <a href="/salas/criar" class="btn btn-primary btn-new">
              <i class="fas fa-plus"></i> Criar Primeira Sala
            </a>
          </c:if>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <c:if
    test="${not empty salas.content && !salas.content.isEmpty() && (salas.totalPages > 1)}"
  >
    <div class="pagination">
      <c:if test="${salas.hasPrevious()}">
        <a href="/salas?page=${salas.number - 1}" class="pagination-item">
          <i class="fas fa-chevron-left"></i>
        </a>
      </c:if>

      <c:forEach begin="0" end="${salas.totalPages - 1}" var="i">
        <a
          href="/salas?page=${i}"
          class="pagination-item ${i == salas.number ? 'active' : ''}"
        >
          ${i + 1}
        </a>
      </c:forEach>

      <c:if test="${salas.hasNext()}">
        <a href="/salas?page=${salas.number + 1}" class="pagination-item">
          <i class="fas fa-chevron-right"></i>
        </a>
      </c:if>
    </div>
  </c:if>
</div>
