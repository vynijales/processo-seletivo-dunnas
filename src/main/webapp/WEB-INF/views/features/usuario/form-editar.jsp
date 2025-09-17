<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <script src="https://cdn.tailwindcss.com"></script>

<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Editar Usuário</h1>
  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}"/>
      <jsp:param name="type" value="error"/>
    </jsp:include>
  </c:if>
  <form class="space-y-4" action="/usuarios/${usuarioRequest.id}/editar" method="post">
    <input type="hidden" name="id" value="${usuarioRequest.id}" />
    <div>
      <jsp:include page="/WEB-INF/views/partials/input.jsp">
        <jsp:param name="type" value="text"/>
        <jsp:param name="id" value="nome"/>
        <jsp:param name="name" value="nome"/>
        <jsp:param name="value" value="${usuarioRequest.nome}"/>
        <jsp:param name="label" value="Nome:"/>
        <jsp:param name="required" value="true"/>
      </jsp:include>
    </div>
    <div>
      <jsp:include page="/WEB-INF/views/partials/input.jsp">
        <jsp:param name="type" value="email"/>
        <jsp:param name="id" value="email"/>
        <jsp:param name="name" value="email"/>
        <jsp:param name="value" value="${usuarioRequest.email}"/>
        <jsp:param name="label" value="Email:"/>
        <jsp:param name="required" value="true"/>
      </jsp:include>
    </div>
    <div>
      <jsp:include page="/WEB-INF/views/partials/input.jsp">
        <jsp:param name="type" value="password"/>
        <jsp:param name="id" value="senha"/>
        <jsp:param name="name" value="senha"/>
        <jsp:param name="label" value="Senha (deixe em branco para não alterar):"/>
      </jsp:include>
    </div>
    <div>
      <label for="role" class="block font-semibold mb-1">Role:</label>
      <select class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50" id="role" name="role"
             ${usuario_role != 'Administrador' ? 'disabled' : ''}>
      <option value="CLIENTE" ${usuarioRequest.role == 'CLIENTE' ? 'selected' : ''}>Cliente</option>
      <option value="RECEPCIONISTA" ${usuarioRequest.role == 'RECEPCIONISTA' ? 'selected' : ''}>Recepcionista</option>
      <option value="ADMINISTRADOR" ${usuarioRequest.role == 'ADMINISTRADOR' ? 'selected' : ''}>Administrador</option>
    </select>
  </div>
    <input type="hidden" name="ativo" value="true" />
    <jsp:include page="/WEB-INF/views/partials/button.jsp">
      <jsp:param name="type" value="submit"/>
      <jsp:param name="text" value="Salvar"/>
      <jsp:param name="color" value="blue"/>
      <jsp:param name="class" value="w-full"/>
    </jsp:include>
  </form>
  <jsp:include page="/WEB-INF/views/partials/button.jsp">
    <jsp:param name="href" value="/usuarios"/>
    <jsp:param name="text" value="Voltar à lista"/>
    <jsp:param name="color" value="gray"/>
    <jsp:param name="class" value="mt-6 w-full"/>
  </jsp:include>
</div>
