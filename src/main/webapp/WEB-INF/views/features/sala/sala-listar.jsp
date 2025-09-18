<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>

<div class="container mx-auto px-4 py-8 space-y-4">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Salas</h1>
  <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
    <jsp:include page="/WEB-INF/views/partials/button.jsp">
      <jsp:param name="href" value="/salas/criar" />
      <jsp:param name="text" value="Nova sala" />
      <jsp:param name="color" value="blue" />
      <jsp:param name="class" value="mb-4" />
    </jsp:include>
  </c:if>
  <div class="overflow-x-auto">
    <table class="min-w-full bg-white rounded shadow-md">
      <thead>
        <tr class="bg-blue-100 text-blue-700">
          <th class="px-4 py-2 text-left">ID</th>
          <th class="px-4 py-2 text-left">Nome</th>
          <th class="px-4 py-2 text-left">Capacidade</th>
          <th class="px-4 py-2 text-left">Alguel (R$)</th>

          <th class="px-4 py-2 text-left">Setor</th>
          <th class="px-4 py-2 text-left">Ações</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="s" items="${salas.content}">
          <tr class="border-b hover:bg-blue-50">
            <td class="px-4 py-2">${s.id}</td>
            <td class="px-4 py-2">${s.nome}</td>
            <td class="px-4 py-2">${s.capacidade}</td>
            <td class="px-4 py-2">${s.valorAluguel}</td>

            <td class="px-4 py-2">
              ${s.setor != null ? Capitalizar.capitalizar(s.setor.nome) : 'N/A'}
            </td>
            <td class="px-4 py-2 flex gap-2">
              <jsp:include page="/WEB-INF/views/partials/button.jsp">
                <jsp:param name="href" value="/salas/${s.id}" />
                <jsp:param name="text" value="Ver" />
                <jsp:param name="color" value="blue" />
                <jsp:param name="class" value="px-3 py-1 text-sm" />
              </jsp:include>

              <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                <jsp:include page="/WEB-INF/views/partials/button.jsp">
                  <jsp:param name="href" value="/salas/${s.id}/editar" />
                  <jsp:param name="text" value="Editar" />
                  <jsp:param name="color" value="yellow" />
                  <jsp:param name="class" value="px-3 py-1 text-sm" />
                </jsp:include>
              </c:if>

              <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
                <jsp:include page="/WEB-INF/views/partials/button.jsp">
                  <jsp:param name="href" value="/salas/${s.id}/excluir" />
                  <jsp:param name="text" value="Excluir" />
                  <jsp:param name="color" value="red" />
                  <jsp:param name="class" value="px-3 py-1 text-sm" />
                  <jsp:param name="alt" value="Excluir setor" />
                </jsp:include>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
