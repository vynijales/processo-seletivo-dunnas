<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${not empty salaRequest and not empty salaRequest.id}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Sala' : 'Nova Sala'}" />
<c:set var="actionUrl" value="${isEdicao ? '/salas/' += salaRequest.id += '/editar' : '/salas'}" />
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
            <input type="hidden" name="id" value="${salaRequest.id}" />
            
            <div class="form-group">
                <label for="nome" class="form-label">Nome da Sala</label>
                <input
                    type="text"
                    id="nome"
                    name="nome"
                    value="${salaRequest.nome}"
                    minlength="1"
                    maxlength="100"
                    placeholder="Digite o nome da sala"
                    class="form-input ${not empty errors['nome'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['nome']}">
                    <p class="text-red-500 text-sm mt-1">${errors['nome']}</p>
                </c:if>
            </div>
            
            <div class="form-group">
                <label for="capacidade" class="form-label">Capacidade</label>
                <input
                    type="number"
                    id="capacidade"
                    name="capacidade"
                    value="${salaRequest.capacidade}"
                    min="1"
                    step="1"
                    placeholder="Ex: 10"
                    class="form-input ${not empty errors['capacidade'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['capacidade']}">
                    <p class="text-red-500 text-sm mt-1">${errors['capacidade']}</p>
                </c:if>
                <p class="password-info">Número máximo de pessoas que a sala comporta</p>
            </div>
            
            <div class="form-group">
                <label for="valorAluguel" class="form-label">Valor do Aluguel (R$)</label>
                <input
                    type="number"
                    id="valorAluguel"
                    name="valorAluguel"
                    value="${salaRequest.valorAluguel}"
                    min="0"
                    step="0.01"
                    placeholder="0,00"
                    class="form-input ${not empty errors['valorAluguel'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['valorAluguel']}">
                    <p class="text-red-500 text-sm mt-1">${errors['valorAluguel']}</p>
                </c:if>
                <p class="password-info">Valor por período de aluguel</p>
            </div>
            
            <div class="form-group">
                <label for="setorId" class="form-label">Setor Responsável</label>
                <select
                    class="form-input ${not empty errors['setorId'] ? 'border-red-500' : ''}"
                    id="setorId"
                    name="setorId"
                    required
                >
                    <option value="">Selecione um setor</option>
                    <c:forEach var="s" items="${setores}">
                        <option value="${s.id}" ${salaRequest.setorId eq s.id ? 'selected' : ''}>
                            ${s.nome}
                        </option>
                    </c:forEach>
                </select>
                <c:if test="${not empty errors['setorId']}">
                    <p class="text-red-500 text-sm mt-1">${errors['setorId']}</p>
                </c:if>
                <p class="password-info">Setor responsável pela administração desta sala</p>
            </div>
            
            <input type="hidden" name="ativo" value="true" />
            
            <button type="submit" class="btn-primary">
                <i class="fas ${isEdicao ? 'fa-save' : 'fa-plus'} mr-2"></i> ${textoBotao}
            </button>
        </form>
        
        <a href="/salas" class="back-link">
            <i class="fas fa-arrow-left mr-1"></i> Voltar à lista de salas
        </a>
    </div>
</div>
