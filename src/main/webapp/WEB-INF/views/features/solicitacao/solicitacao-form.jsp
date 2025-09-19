<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${not empty solicitacao and not empty solicitacao.id}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Solicitação' : 'Nova Solicitação'}" />
<c:set var="actionUrl" value="${isEdicao ? '/solicitacoes/' += solicitacao.id += '/editar' : '/solicitacoes'}" />
<c:set var="textoBotao" value="${isEdicao ? 'Salvar' : 'Criar'}" />

<%
// Configurar formatter e datas
DateTimeFormatter html5Formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
LocalDateTime agora = LocalDateTime.now().plusMinutes(1);
LocalDateTime umaHoraDepois = agora.plusHours(1).plusMinutes(1);

pageContext.setAttribute("dataInicioPadrao", agora.format(html5Formatter));
pageContext.setAttribute("dataFimPadrao", umaHoraDepois.format(html5Formatter));
%>

<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">${titulo}</h1>

  <c:if test="${not empty errorMessage}">
    <jsp:include page="/WEB-INF/views/partials/alert.jsp">
      <jsp:param name="message" value="${errorMessage}" />
      <jsp:param name="type" value="error" />
    </jsp:include>
  </c:if>
  
  <!-- Exibir erros de validação específicos -->
  <c:if test="${not empty errors}">
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
      <ul>
        <c:forEach var="error" items="${errors}">
          <li>${error.defaultMessage}</li>
        </c:forEach>
      </ul>
    </div>
  </c:if>
  
  <form class="space-y-4" action="${actionUrl}" method="post">
    <input type="hidden" name="id" value="${not empty solicitacao.id ? solicitacao.id : ''}" />
    
    <div class="flex flex-col gap-2">
      <div>
        <label for="clienteId" class="block font-semibold mb-1">Cliente:</label>
        <select class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" 
                id="clienteId" name="clienteId" required>
          <option value="">Selecione o cliente</option>
          <c:forEach var="c" items="${clientes}">
            <option value="${c.id}" 
              <c:choose>
                <c:when test="${not empty solicitacao.cliente and solicitacao.cliente.id eq c.id}">selected</c:when>
                <c:when test="${not empty solicitacaoRequest.clienteId and solicitacaoRequest.clienteId eq c.id}">selected</c:when>
              </c:choose>>
              ${c.id} - ${c.nome}
            </option>
          </c:forEach>
        </select> 
      </div>
      
      <div>
        <label for="salaId" class="block font-semibold mb-1">Sala:</label>
        <select class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" 
                id="salaId" name="salaId" required>
          <option value="">Selecione a sala</option>
          <c:forEach var="s" items="${salas}">
            <option value="${s.id}" 
              <c:choose>
                <c:when test="${not empty solicitacao.sala and solicitacao.sala.id eq s.id}">selected</c:when>
                <c:when test="${not empty solicitacaoRequest.salaId and solicitacaoRequest.salaId eq s.id}">selected</c:when>
              </c:choose>>
              ${s.id} - ${s.nome}
            </option>
          </c:forEach>
        </select> 
      </div>
      
      <div>
        <label for="status" class="block font-semibold mb-1">Status:</label>
        <select class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50" 
                id="status" name="status" ${usuarioLogado.role == 'CLIENTE' ? 'disabled' : ''}>
          <option value="SOLICITADO" 
            <c:if test="${(not empty solicitacao.status and solicitacao.status == 'SOLICITADO') or (not empty solicitacaoRequest.status and solicitacaoRequest.status == 'SOLICITADO')}">selected</c:if>>
            Solicitado
          </option>
          <option value="CONFIRMADO" 
            <c:if test="${(not empty solicitacao.status and solicitacao.status == 'CONFIRMADO') or (not empty solicitacaoRequest.status and solicitacaoRequest.status == 'CONFIRMADO')}">selected</c:if>>
            Confirmado
          </option>
          <option value="CANCELADO" 
            <c:if test="${(not empty solicitacao.status and solicitacao.status == 'CANCELADO') or (not empty solicitacaoRequest.status and solicitacaoRequest.status == 'CANCELADO')}">selected</c:if>>
            Cancelado
          </option>
          <option value="FINALIZADO" 
            <c:if test="${(not empty solicitacao.status and solicitacao.status == 'FINALIZADO') or (not empty solicitacaoRequest.status and solicitacaoRequest.status == 'FINALIZADO')}">selected</c:if>>
            Finalizado
          </option>
        </select>
      </div>

      <div class="flex flex-row justify-between w-full gap-2">
        <div class="w-full">
          <label for="dataInicio" class="block font-semibold mb-1">Data inicial:</label>
          <input type="datetime-local" id="dataInicio" name="dataInicio"
                 value="${not empty solicitacao.dataInicio ? solicitacao.dataInicio : dataInicioPadrao}"
                 class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" required />
        </div>
        <div class="w-full">
          <label for="dataFim" class="block font-semibold mb-1">Data final:</label>
          <input type="datetime-local" id="dataFim" name="dataFim"
                 value="${not empty solicitacao.dataFim ? solicitacao.dataFim : dataFimPadrao}"
                 class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" required />
        </div>    
      </div>
    </div>
    
    <input type="hidden" name="sinalPago" value="
        <c:choose>
            <c:when test="${not empty solicitacao}">${solicitacao.sinalPago}</c:when>
            <c:otherwise>false</c:otherwise>
        </c:choose>
    " />

    <input type="number" name="valorPago" style="display: none;" value="${solicitacao.valorPago}"/>

    <input type="hidden" name="ativo" value="true" />
    
    <button type="submit" class="w-full px-4 py-2 rounded font-semibold bg-blue-700 text-white hover:bg-blue-800 transition focus:outline-none">
      ${textoBotao}
    </button>
  </form>
  
  <a href="/solicitacoes" class="block text-center text-md text-gray-500 mt-4 hover:underline">
    Voltar à lista
  </a>
</div>
