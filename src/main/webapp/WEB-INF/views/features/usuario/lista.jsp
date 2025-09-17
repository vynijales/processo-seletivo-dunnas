<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<html>
  <head>
    <title>Lista de Usuários</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8 space-y-4">
      <h1 class="text-2xl font-bold text-blue-700 mb-6">Usuários</h1>
      <jsp:include page="/WEB-INF/views/partials/button.jsp">
        <jsp:param name="href" value="/usuarios/criar" />
        <jsp:param name="text" value="Novo Usuário" />
        <jsp:param name="color" value="blue" />
        <jsp:param name="class" value="mb-4" />
      </jsp:include>
      <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded shadow-md">
          <thead>
            <tr class="bg-blue-100 text-blue-700">
              <th class="px-4 py-2 text-left">ID</th>
              <th class="px-4 py-2 text-left">Nome</th>
              <th class="px-4 py-2 text-left">Email</th>
              <th class="px-4 py-2 text-left">Role</th>
              <th class="px-4 py-2 text-left">Ações</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="usuario" items="${usuarios.content}">
              <tr class="border-b hover:bg-blue-50">
                <td class="px-4 py-2">${usuario.id}</td>
                <td class="px-4 py-2">${usuario.nome}</td>
                <td class="px-4 py-2">${usuario.email}</td>
                <td class="px-4 py-2">
                  ${Capitalizar.capitalizar(usuario.role)}
                </td>
                <td class="px-4 py-2 flex gap-2">
                  <jsp:include page="/WEB-INF/views/partials/button.jsp">
                    <jsp:param name="href" value="/usuarios/${usuario.id}" />
                    <jsp:param name="text" value="Ver" />
                    <jsp:param name="color" value="blue" />
                    <jsp:param name="class" value="px-3 py-1 text-sm" />
                  </jsp:include>

                  <c:if
                    test="${usuario.id == usuario_id || usuario_role == 'Administrador'}"
                  >
                    <jsp:include page="/WEB-INF/views/partials/button.jsp">
                      <jsp:param
                        name="href"
                        value="/usuarios/${usuario.id}/editar"
                      />
                      <jsp:param name="text" value="Editar" />
                      <jsp:param name="color" value="yellow" />
                      <jsp:param name="class" value="px-3 py-1 text-sm" />
                    </jsp:include>
                  </c:if>

                  <!-- Se for o mesmo usuário, não exibir o botão de excluir  -->
                  <c:if
                    test="${usuario.id != usuario_id && usuario_role == 'Administrador'}"
                  >
                    <jsp:include page="/WEB-INF/views/partials/button.jsp">
                      <jsp:param
                        name="href"
                        value="/usuarios/${usuario.id}/excluir"
                      />
                      <jsp:param name="text" value="Excluir" />
                      <jsp:param name="color" value="red" />
                      <jsp:param name="class" value="px-3 py-1 text-sm" />
                      <jsp:param name="alt" value="Excluir usuário" />
                    </jsp:include>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
