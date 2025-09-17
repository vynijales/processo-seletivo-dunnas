<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Detalhes do Usuário</h1>
  <div class="space-y-2 text-gray-700 mb-6">
    <p><span class="font-semibold">ID:</span> ${usuario.id}</p>
    <p><span class="font-semibold">Nome:</span> ${usuario.nome}</p>
    <p><span class="font-semibold">Email:</span> ${usuario.email}</p>
    <p><span class="font-semibold">Role:</span> ${usuario.role}</p>
    <p><span class="font-semibold">Ativo:</span> ${usuario.ativo}</p>
  </div>
  <div class="flex gap-3 mt-6">
    <jsp:include page="/WEB-INF/views/partials/button.jsp">
      <jsp:param name="href" value="/usuarios/${usuario.id}/editar" />
      <jsp:param name="text" value="Editar" />
      <jsp:param name="color" value="yellow" />
      <jsp:param name="class" value="px-4 py-2 font-semibold" />
    </jsp:include>
    <jsp:include page="/WEB-INF/views/partials/button.jsp">
      <jsp:param name="href" value="/usuarios/${usuario.id}/excluir" />
      <jsp:param name="text" value="Excluir" />
      <jsp:param name="color" value="red" />
      <jsp:param name="class" value="px-4 py-2 font-semibold" />
      <jsp:param name="alt" value="Excluir usuário" />
    </jsp:include>
    <jsp:include page="/WEB-INF/views/partials/button.jsp">
      <jsp:param name="href" value="/usuarios" />
      <jsp:param name="text" value="Voltar à lista" />
      <jsp:param name="color" value="blue" />
      <jsp:param name="class" value="px-4 py-2 font-semibold" />
    </jsp:include>
  </div>
</div>
