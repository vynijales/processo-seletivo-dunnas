<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${not empty setorRequest and not empty setorRequest.id}" />
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
        
        <form action="${actionUrl}" method="post">
            <input type="hidden" name="id" value="${setorRequest.id}" />
            
            <div class="form-group">
                <label for="nome" class="form-label">Nome do Setor</label>
                <input
                    type="text"
                    id="nome"
                    name="nome"
                    value="${setorRequest.nome}"
                    minlength="1"
                    maxlength="100"
                    placeholder="Digite o nome do setor"
                    class="form-input ${not empty errors['nome'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['nome']}">
                    <p class="text-red-500 text-sm mt-1">${errors['nome']}</p>
                </c:if>
            </div>
            
            <div class="form-group">
                <label for="valorCaixa" class="form-label">Valor do Caixa (R$)</label>
                <input
                    type="number"
                    id="valorCaixa"
                    name="valorCaixa"
                    value="${setorRequest.valorCaixa}"
                    min="0"
                    step="0.01"
                    placeholder="0,00"
                    class="form-input ${not empty errors['valorCaixa'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['valorCaixa']}">
                    <p class="text-red-500 text-sm mt-1">${errors['valorCaixa']}</p>
                </c:if>
                <p class="password-info">Utilize ponto (.) como separador decimal</p>
            </div>
            
            <div class="form-group">
                <label for="recepcionistaId" class="form-label">Recepcionista Responsável</label>
                <select
                    class="form-input ${not empty errors['recepcionistaId'] ? 'border-red-500' : ''}"
                    id="recepcionistaId"
                    name="recepcionistaId"
                    required
                >
                    <option value="">Selecione um recepcionista</option>
                    <c:forEach var="u" items="${usuarios}">
                        <option value="${u.id}" ${setorRequest.recepcionistaId eq u.id ? 'selected' : ''}>
                            ${u.nome} - ${u.email}
                        </option>
                    </c:forEach>
                </select>
                <c:if test="${not empty errors['recepcionistaId']}">
                    <p class="text-red-500 text-sm mt-1">${errors['recepcionistaId']}</p>
                </c:if>
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
