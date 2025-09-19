<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<link href="static/css/main.css" rel="stylesheet" />
<link href="static/css/datalist.css" rel="stylesheet" />

<div class="container p-4">
  <div class="page-header">
    <h1 class="page-title">Usuários</h1>
    <a href="/usuarios/criar" class="btn btn-primary btn-new">
      <i class="fas fa-plus"></i> Novo Usuário
    </a>
  </div>

  <div class="data-table-container">
    <c:choose>
      <c:when
        test="${not empty usuarios.content && !usuarios.content.isEmpty()}"
      >
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
                      <span class="badge badge-client"
                        >${Capitalizar.capitalizar(u.role)}</span
                      >
                    </c:when>
                    <c:when test="${u.role == 'RECEPCIONISTA'}">
                      <span class="badge badge-receptionist"
                        >${Capitalizar.capitalizar(u.role)}</span
                      >
                    </c:when>
                    <c:when test="${u.role == 'ADMINISTRADOR'}">
                      <span class="badge badge-admin"
                        >${Capitalizar.capitalizar(u.role)}</span
                      >
                    </c:when>
                    <c:otherwise>
                      <span class="badge"
                        >${Capitalizar.capitalizar(u.role)}</span
                      >
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div class="action-buttons">
                    <a
                      href="/usuarios/${u.id}"
                      class="btn btn-primary btn-sm btn-action"
                    >
                      <i class="fas fa-eye"></i>
                      <span>Ver</span>
                    </a>

                    <c:if
                      test="${u.id == usuarioLogado.id || usuarioLogado.role == 'ADMINISTRADOR'}"
                    >
                      <a
                        href="/usuarios/${u.id}/editar"
                        class="btn btn-warning btn-sm btn-action"
                      >
                        <i class="fas fa-edit"></i>
                        <span>Editar</span>
                      </a>
                    </c:if>

                    <c:if
                      test="${u.id != usuarioLogado.id && usuarioLogado.role == 'ADMINISTRADOR'}"
                    >
                      <a
                        href="/usuarios/${u.id}/excluir"
                        class="btn btn-error btn-sm btn-action"
                        onclick="return confirm('Tem certeza que deseja excluir este usuário?')"
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
            <i class="fas fa-users"></i>
          </div>
          <h3 class="empty-state-text">Nenhum usuário encontrado</h3>
          <a href="/usuarios/criar" class="btn btn-primary btn-new">
            <i class="fas fa-plus"></i> Criar Primeiro Usuário
          </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <c:if
    test="${not empty usuarios.content && !usuarios.content.isEmpty() && (usuarios.totalPages > 1)}"
  >
    <div class="pagination">
      <c:if test="${usuarios.hasPrevious()}">
        <a href="/usuarios?page=${usuarios.number - 1}" class="pagination-item">
          <i class="fas fa-chevron-left"></i>
        </a>
      </c:if>

      <c:forEach begin="0" end="${usuarios.totalPages - 1}" var="i">
        <a
          href="/usuarios?page=${i}"
          class="pagination-item ${i == usuarios.number ? 'active' : ''}"
        >
          ${i + 1}
        </a>
      </c:forEach>

      <c:if test="${usuarios.hasNext()}">
        <a href="/usuarios?page=${usuarios.number + 1}" class="pagination-item">
          <i class="fas fa-chevron-right"></i>
        </a>
      </c:if>
    </div>
  </c:if>
</div>
