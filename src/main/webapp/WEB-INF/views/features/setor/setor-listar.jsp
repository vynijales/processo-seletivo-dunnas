<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="static/css/main.css" rel="stylesheet" />
<link href="static/css/datalist.css" rel="stylesheet" />

<div class="container space-y-4 p-4">
  <div class="page-header">
    <h1 class="page-title">Setores</h1>
    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
      <a href="/setores/criar" class="btn btn-primary btn-new">
        <i class="fas fa-plus"></i> Novo Setor
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
          <h3 class="empty-state-text">Nenhum setor encontrado</h3>
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
        <a href="/setores?page=${setores.number - 1}" class="pagination-item">
          <i class="fas fa-chevron-left"></i>
        </a>
      </c:if>

      <c:forEach begin="0" end="${setores.totalPages - 1}" var="i">
        <a
          href="/setores?page=${i}"
          class="pagination-item ${i == setores.number ? 'active' : ''}"
        >
          ${i + 1}
        </a>
      </c:forEach>

      <c:if test="${setores.hasNext()}">
        <a href="/setores?page=${setores.number + 1}" class="pagination-item">
          <i class="fas fa-chevron-right"></i>
        </a>
      </c:if>
    </div>
  </c:if>
</div>
