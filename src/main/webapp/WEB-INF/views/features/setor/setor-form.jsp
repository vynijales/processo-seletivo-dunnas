<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Definir se é criação ou edição
boolean isEdicao = request.getAttribute("setor") != null;
String titulo = isEdicao ? "Editar setor" : "Novo setor";
String textoBotao = isEdicao ? "Editar" : "Criar";
%>

<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6"><%= titulo %></h1>
  
  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>
  
  <form class="space-y-4" action="${isEdicao ? '/setores/' += setor.id += '/editar' : '/setores'}" method="post">
    <div>
      <input type="hidden" name="id" value="${not empty setor.id ? setor.id : setorRequest.id}" />
      <label for="nome" class="block font-semibold mb-1">Nome:</label>
      <input
        type="text"
        id="nome"
        name="nome"
        value="${not empty setor.nome ? setor.nome : setorRequest.nome}"
        minlength="1"
        maxlength="100"
        placeholder="Digite o nome"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        required
      />
    </div>
    <div>
      <label for="valorCaixa" class="block font-semibold mb-1">Valor caixa (R$):</label>
      <input
        id="valorCaixa"
        name="valorCaixa"
        type="number"
        value="${not empty setor.valorCaixa ? setor.valorCaixa : setorRequest.valorCaixa}"
        min="0"
        step="0.01"
        placeholder="Digite o valor do caixa"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        required
      />
    </div>
    
    <label for="recepcionistaId" class="block font-semibold mb-1">Recepcionista:</label>
    <select
      class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
      id="recepcionistaId"
      name="recepcionistaId"
      required
    >
      <option value="">Selecione um recepcionista</option>
      <c:forEach var="u" items="${usuarios}">
        <option value="${u.id}" 
          <c:choose>
            <c:when test="${not empty setor.recepcionista and setor.recepcionista.id eq u.id}">
              selected
            </c:when>
            <c:when test="${not empty setorRequest.recepcionistaId and setorRequest.recepcionistaId eq u.id}">
              selected
            </c:when>
          </c:choose>
        >
          ${u.id} - ${u.nome}
        </option>
      </c:forEach>
    </select>

    <input type="hidden" name="ativo" value="true" />
    <button
      type="submit"
      class="w-full px-4 py-2 rounded font-semibold bg-blue-700 text-white hover:bg-blue-800 transition focus:outline-none"
    >
      <%= textoBotao %>
    </button>
  </form>
  
  <a
    href="/setores"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
  >
    Voltar à lista
  </a>
</div>
