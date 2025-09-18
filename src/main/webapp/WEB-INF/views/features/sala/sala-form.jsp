<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Definir se é criação ou edição
boolean isEdicao = request.getAttribute("sala") != null;
String titulo = isEdicao ? "Editar sala" : "Novo sala";
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

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>
  
  <form class="space-y-4" action="${isEdicao ? '/salas/' += sala.id += '/editar' : '/salas'}" method="post">
    <div>
      <input type="hidden" name="id" value="${not empty sala.id ? sala.id : salaRequest.id}" />
      <label for="nome" class="block font-semibold mb-1">Nome:</label>
      <input
        type="text"
        id="nome"
        name="nome"
        value="${not empty sala.nome ? sala.nome : salaRequest.nome}"
        minlength="1"
        maxlength="100"
        placeholder="Digite o nome"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        required
      />
    </div>
    <div>
      <label for="capacidade" class="block font-semibold mb-1">Capacidade:</label>
      <input
        id="capacidade"
        name="capacidade"
        type="number"
        value="${not empty sala.capacidade ? sala.capacidade : salaRequest.capacidade}"
        min="1"
        step="1"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        placeholder="Digite a capacidade"
        required
      />
    </div>

      <div>
      <label for="valorAluguel" class="block font-semibold mb-1">Valor do aluguel (R$):</label>
      <input
        id="valorAluguel"
        name="valorAluguel"
        type="number"
        value="${not empty sala.valorAluguel ? sala.valorAluguel : salaRequest.valorAluguel}"
        min="0"
        step="0.1"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        placeholder="Digite a valor do aluguel"
        required
      />
    </div>
    
    <label for="setorId" class="block font-semibold mb-1">Setor:</label>
    <select
      class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
      id="setorId"
      name="setorId"
      required
    >
      <option value="">Selecione um recepcionista</option>
      <c:forEach var="s" items="${setores}">
        <option value="${s.id}" 
          <c:choose>
            <c:when test="${not empty sala.setor and sala.setor.id eq s.id}">
              selected
            </c:when>
            <c:when test="${not empty salaRequest.setorId and salaRequest.setorId eq s.id}">
              selected
            </c:when>
          </c:choose>
        >
          ${s.id} - ${s.nome}
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
    href="/salas"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
  >
    Voltar à lista
  </a>
</div>
