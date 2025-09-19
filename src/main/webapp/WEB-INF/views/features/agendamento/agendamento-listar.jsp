<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %> <%@ page
import="com.dunnas.reservasalas.core.utils.FormatarData" %>
<span%@ page import="com.dunnas.reservasalas.core.utils.FormatarData" %>
  <link href="static/css/main.css" rel="stylesheet" />
  <link href="static/css/datalist.css" rel="stylesheet" />

  <div class="container space-y-4 p-4">
    <div class="page-header">
      <h1 class="page-title">Agendamentos</h1>
      <a href="/agendamentos/criar" class="btn btn-primary btn-new">
        <i class="fas fa-plus"></i> Nova Agendamento
      </a>
    </div>

    <c:if test="${not empty errorMessage}">
      <jsp:include page="/WEB-INF/views/partials/alert.jsp">
        <jsp:param name="message" value="${errorMessage}" />
        <jsp:param name="type" value="error" />
      </jsp:include>
    </c:if>

    <div class="data-table-container">
      <c:choose>
        <c:when
          test="${not empty agendamentos.content && !agendamentos.content.isEmpty()}"
        >
          <table class="data-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Status</th>
                <th>Sala</th>
                <th>Data início</th>
                <th>Data final</th>
                <th>Ações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="s" items="${agendamentos.content}">
                <tr>
                  <td>${s.id}</td>
                  <td>${Capitalizar.capitalizar(s.cliente.nome)}</td>
                  <td>
                    <c:choose>
                      <c:when test="${s.status == 'SOLICITADO'}">
                        <span class="badge badge-client">
                          ${Capitalizar.capitalizar(s.status)}
                        </span>
                      </c:when>
                      <c:when test="${s.status == 'CANCELADO'}">
                        <span class="badge badge-admin">
                          ${Capitalizar.capitalizar(s.status)}
                        </span>
                      </c:when>
                      <c:when test="${s.status == 'CONFIRMADO'}">
                        <span class="badge badge-receptionist">
                          ${Capitalizar.capitalizar(s.status)}
                        </span>
                      </c:when>
                      <c:when test="${s.status == 'FINALIZADO'}">
                        <span class="badge badge-success">
                          ${Capitalizar.capitalizar(s.status)}
                        </span>
                      </c:when>
                    </c:choose>
                  </td>
                  <td>${Capitalizar.capitalizar(s.sala.nome)}</td>
                  <td>${FormatarData.toStringAmigavel(s.dataInicio)}</td>
                  <td>${FormatarData.toStringAmigavel(s.dataFim)}</td>
                  <td>
                    <div class="action-buttons">
                      <a
                        href="/agendamentos/${s.id}"
                        class="btn btn-primary btn-sm btn-action"
                      >
                        <i class="fas fa-eye"></i>
                        <span>Ver</span>
                      </a>

                      <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                        <a
                          href="/agendamentos/${s.id}/editar"
                          class="btn btn-warning btn-sm btn-action"
                        >
                          <i class="fas fa-edit"></i>
                          <span>Editar</span>
                        </a>
                      </c:if>

                      <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                        <a
                          href="/agendamentos/${s.id}/excluir"
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
              <i class="fas fa-calendar-check"></i>
            </div>
            <h3 class="empty-state-text">Nenhum agendamento encontrada</h3>
            <a href="/agendamentos/criar" class="btn btn-primary btn-new">
              <i class="fas fa-plus"></i> Criar Primeiro Agendamento
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <c:if
      test="${not empty agendamentos.content && !agendamentos.content.isEmpty() && (agendamentos.totalPages > 1)}"
    >
      <div class="pagination">
        <c:if test="${agendamentos.hasPrevious()}">
          <a
            href="/agendamentos?page=${agendamentos.number - 1}"
            class="pagination-item"
          >
            <i class="fas fa-chevron-left"></i>
          </a>
        </c:if>

        <c:forEach begin="0" end="${agendamentos.totalPages - 1}" var="i">
          <a
            href="/agendamentos?page=${i}"
            class="pagination-item ${i == agendamentos.number ? 'active' : ''}"
          >
            ${i + 1}
          </a>
        </c:forEach>

        <c:if test="${agendamentos.hasNext()}">
          <a
            href="/agendamentos?page=${agendamentos.number + 1}"
            class="pagination-item"
          >
            <i class="fas fa-chevron-right"></i>
          </a>
        </c:if>
      </div>
    </c:if>
  </div>
</span%@>
