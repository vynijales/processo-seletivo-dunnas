<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${not empty solicitacao and not empty solicitacao.id}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Solicitação' : 'Novo Solicitação'}" />
<c:set var="actionUrl" value="${isEdicao ? '/solicitacoes/' += solicitacao.id += '/editar' : '/solicitacoes'}" />
<c:set var="textoBotao" value="${isEdicao ? 'Salvar' : 'Criar'}" />

${actionUrl}
<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">${titulo}</h1>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>
  
  <form class="space-y-4" action="${actionUrl}" method="post">
    <div class="flex flex-col gap-2">
      <input type="hidden" name="id" value="${not empty solicitacao.id ? solicitacao.id : solicitacaoRequest.id}" />
      <div>
        <label for="clienteId" class="block font-semibold mb-1">Cliente:</label>
        <select
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        id="clienteId"
        name="clienteId"
        required
      >
        <option value="">Selecione o cliente</option>
        <c:forEach var="c" items="${clientes}">
          <option value="${c.id}" 
            <c:choose>
              <c:when test="${not empty solicitacao.cliente and solicitacao.cliente.id eq c.id}">
                selected
              </c:when>
              <c:when test="${not empty solicitacaoRequest.clienteId and solicitacaoRequest.clienteId eq c.id}">
                selected
              </c:when>
            </c:choose>
          >
            ${c.id} - ${c.nome}
          </option>
        </c:forEach>
      </select> 
    </div>
    <div>
        <label for="salaId" class="block font-semibold mb-1">Sala:</label>
        <select
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        id="salaId"
        name="salaId"
        required
      >
        <option value="">Selecione a sala</option>
        <c:forEach var="s" items="${salas}">
          <option value="${s.id}" 
            <c:choose>
              <c:when test="${not empty solicitacao.sala and solicitacao.sala.id eq s.id}">
                selected
              </c:when>
              <c:when test="${not empty solicitacaoRequest.salaId and solicitacaoRequest.salaId eq s.id}">
                selected
              </c:when>
            </c:choose>
          >
            ${s.id} - ${s.nome}
          </option>
        </c:forEach>
      </select> 
    </div>
        <div>
      <label for="status" class="block font-semibold mb-1">Status:</label>
      <select 
        class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50" 
        id="status" 
        name="status"
        ${usuarioLogado.role != 'ADMINISTRADOR' ? 'disabled' : ''}
      >
        <option value="SOLICITADO" ${solicitacaoRequest.status == 'SOLICITADO' ? 'selected' : ''}>Solicitado</option>
        <option value="CONFIRMADO" ${solicitacaoRequest.status == 'CONFIRMADO' ? 'selected' : ''}>Confirmado</option>
        <option value="CANCELADO" ${solicitacaoRequest.status == 'CANCELADO' ? 'selected' : ''}>Cancelado</option>
        <option value="FINALIZADO" ${solicitacaoRequest.status == 'FINALIZADO' ? 'selected' : ''}>Finalizado</option>
      </select>
    </div>

    <div class="flex flex-row justify-between w-full gap-2">
        <div class="w-full">
            <label for="dataInicio" class="block font-semibold mb-1">Data inicial:</label>
            <input 
                type="datetime-local"
                id="dataInicio"
                name="dataInicio"
                value="${not empty solicitacao.dataInicio ? solicitacao.dataInicio : solicitacaoRequest.dataInicio}"
                placeholder="Informe a data inicial"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
             />
        </div>
        <div class="w-full">
            <label for="dataFim" class="block font-semibold mb-1">Data final:</label>
            <input 
                type="datetime-local"
                id="dataFim"
                name="dataFim"
                value="${not empty solicitacao.dataFim ? solicitacao.dataFim : solicitacaoRequest.dataFim}"
                placeholder="Informe a data final"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
             />
        </div>    
    </div>

<spring:bind path="dataFim">
     <form:input path="dataFim" />
     <form:errors path="dataFim" cssClass="error" />
     ${status.error ? 'has error' : ''}
</spring:bind>

    </div>
    <input type="hidden" name="sinalPago" value="true" />
    <input type="hidden" name="ativo" value="true" />
   <button
      type="submit"
      class="w-full px-4 py-2 rounded font-semibold bg-blue-700 text-white hover:bg-blue-800 transition focus:outline-none"
    >
      ${textoBotao}
    </button>
  </form>
  
  </form>
  
  <a
    href="/solicitacoes"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
  >
    Voltar à lista
  </a>
</div>
