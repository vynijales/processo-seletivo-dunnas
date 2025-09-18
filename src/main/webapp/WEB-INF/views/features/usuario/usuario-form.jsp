<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="isEdicao" value="${not empty usuarioRequest and not empty usuarioRequest.id}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Usuário' : 'Novo Usuário'}" />
<c:set var="actionUrl" value="${isEdicao ? '/usuarios/' += usuarioRequest.id += '/editar' : '/usuarios/criar'}" />
<c:set var="textoBotao" value="${isEdicao ? 'Salvar' : 'Criar'}" />

<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">${titulo}</h1>
  
  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}"/>
      <jsp:param name="type" value="error"/>
    </jsp:include>
  </c:if>
  
  <form class="space-y-4" action="${actionUrl}" method="post">
    <c:if test="${isEdicao}">
      <input type="hidden" name="id" value="${usuarioRequest.id}" />
    </c:if>
    
    <div>
      <label for="nome" class="block font-semibold mb-1">Nome:</label>
      <input
        type="text"
        id="nome"
        name="nome"
        value="${usuarioRequest.nome}"
        minlength="1"
        maxlength="100"
        placeholder="Digite o nome"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        required
      />
    </div>
    
    <div>
      <label for="email" class="block font-semibold mb-1">Email:</label>
      <input
        type="email"
        id="email"
        name="email"
        value="${usuarioRequest.email}"
        minlength="5"
        maxlength="255"
        placeholder="Digite o e-mail"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        required
      />
    </div>
    
    <div>
      <label for="senha" class="block font-semibold mb-1">
        <c:choose>
          <c:when test="${isEdicao}">Senha (deixe em branco para não alterar):</c:when>
          <c:otherwise>Senha:</c:otherwise>
        </c:choose>
      </label>
      <input 
        type="password" 
        id="senha" 
        name="senha" 
        placeholder="Digite a senha"
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" 
        <c:if test="${not isEdicao}">minlength="8" required</c:if>
        maxlength="255"
      />
    </div>
    
    <div>
      <label for="role" class="block font-semibold mb-1">Role:</label>
      <select 
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50" 
        id="role" 
        name="role"
        ${usuarioLogado.role != 'ADMINISTRADOR' ? 'disabled' : ''}
      >
        <option value="CLIENTE" ${usuarioRequest.role == 'CLIENTE' ? 'selected' : ''}>Cliente</option>
        <option value="RECEPCIONISTA" ${usuarioRequest.role == 'RECEPCIONISTA' ? 'selected' : ''}>Recepcionista</option>
        <option value="ADMINISTRADOR" ${usuarioRequest.role == 'ADMINISTRADOR' ? 'selected' : ''}>Administrador</option>
      </select>
    </div>
    
    <input type="hidden" name="ativo" value="true" />
    
    <button 
      type="submit" 
      class="w-full px-4 py-2 rounded font-semibold bg-blue-700 text-white hover:bg-blue-800 transition focus:outline-none"
    >
      ${textoBotao}
    </button>
  </form>
  
  <a href="/usuarios" class="block text-center text-md text-gray-500 mt-4 hover:underline">
    Voltar à lista
  </a>
</div>
