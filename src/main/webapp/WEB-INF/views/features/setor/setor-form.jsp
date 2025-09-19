<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${setor != null}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Setor' : 'Novo Setor'}" />
<c:set var="actionUrl" value="${isEdicao ? '/setores/' += setorRequest.id += '/editar' : '/setores'}" />
<c:set var="textoBotao" value="${isEdicao ? 'Salvar' : 'Criar'}" />

<div class="form-container fade-in">
    <div class="form-header">
        <h1 class="text-2xl font-bold">${titulo}</h1>
    </div>
    
    <div class="form-body">
        <!-- Componente de alerta reutilizável -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <div class="alert-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <div class="alert-content">
                    <div class="alert-title">Erro</div>
                    <div class="alert-message">${errorMessage}</div>
                </div>
            </div>
        </c:if>
        
        <form action="${actionUrl}" method="post">
            <input type="hidden" name="id" value="${not empty setor.id ? setor.id : setorRequest.id}" />
            
            <div class="form-group">
                <label for="nome" class="form-label">Nome do Setor</label>
                <input
                    type="text"
                    id="nome"
                    name="nome"
                    value="${not empty setor.nome ? setor.nome : setorRequest.nome}"
                    minlength="1"
                    maxlength="100"
                    placeholder="Digite o nome do setor"
                    class="form-input"
                    required
                />
            </div>
            
            <div class="form-group">
                <label for="valorCaixa" class="form-label">Valor do Caixa (R$)</label>
                <input
                    type="number"
                    id="valorCaixa"
                    name="valorCaixa"
                    value="${not empty setor.valorCaixa ? setor.valorCaixa : setorRequest.valorCaixa}"
                    min="0"
                    step="0.01"
                    placeholder="0,00"
                    class="form-input"
                    required
                />
                <p class="password-info">Utilize ponto (.) como separador decimal</p>
            </div>
            
            <div class="form-group">
                <label for="recepcionistaId" class="form-label">Recepcionista Responsável</label>
                <select
                    class="form-input"
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
                            ${u.nome} - ${u.email}
                        </option>
                    </c:forEach>
                </select>
                <p class="password-info">Selecione o recepcionista responsável por este setor</p>
            </div>
            
            <input type="hidden" name="ativo" value="true" />
            
            <button type="submit" class="btn-primary">
                <i class="fas ${isEdicao ? 'fa-save' : 'fa-plus'} mr-2"></i> ${textoBotao}
            </button>
        </form>
        
        <a href="/setores" class="back-link">
            <i class="fas fa-arrow-left mr-1"></i> Voltar à lista de setores
        </a>
    </div>
</div>
