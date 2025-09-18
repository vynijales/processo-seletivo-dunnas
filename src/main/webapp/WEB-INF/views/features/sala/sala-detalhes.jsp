<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Detalhes da sala</h1>
  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>
  <div class="space-y-2 text-gray-700 mb-6">
    <p><span class="font-semibold">ID:</span> ${sala.id}</p>
    <p><span class="font-semibold">Nome:</span> ${sala.nome}</p>
    <p>
      <span class="font-semibold">Valor aluguel (R$):</span>
      ${sala.valorAluguel}
    </p>
    <p>
      <span class="font-semibold">Capacidade máxima:</span> ${sala.capacidade}
    </p>
    <p><span class="font-semibold">Setor:</span> ${sala.setor.nome}</p>
    <p>
      <span class="font-semibold">Ativo:</span> ${sala.ativo ? "Sim" : "Não"}
    </p>
  </div>
  <div class="flex gap-3 mt-6">
    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR' && sala!= null}">
      <a
        href="/salas/${sala.id}/editar"
        class="px-4 py-2 rounded font-semibold bg-yellow-500 text-white hover:bg-yellow-600 transition focus:outline-none"
        >Editar</a
      >
      <a
        href="/salas/${sala.id}/excluir"
        class="px-4 py-2 rounded font-semibold bg-red-600 text-white hover:bg-red-700 transition focus:outline-none"
        >Excluir</a
      >
    </c:if>
  </div>
  <a
    href="/salas"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
    >Voltar</a
  >
</div>
