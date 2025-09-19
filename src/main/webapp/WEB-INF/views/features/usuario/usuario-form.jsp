<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link href="/static/css/main.css" rel="stylesheet" />
<link href="/static/css/form.css" rel="stylesheet" />

<c:set var="isEdicao" value="${not empty usuarioRequest and not empty usuarioRequest.id}" />
<c:set var="titulo" value="${isEdicao ? 'Editar Usuário' : 'Novo Usuário'}" />
<c:set var="actionUrl" value="${isEdicao ? '/usuarios/' += usuarioRequest.id += '/editar' : '/usuarios/criar'}" />
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
            <c:if test="${isEdicao}">
                <input type="hidden" name="id" value="${usuarioRequest.id}" />
            </c:if>
            
            <div class="form-group">
                <label for="nome" class="form-label">Nome</label>
                <input
                    type="text"
                    id="nome"
                    name="nome"
                    value="${usuarioRequest.nome}"
                    minlength="1"
                    maxlength="100"
                    placeholder="Digite o nome completo"
                    class="form-input ${not empty errors['nome'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['nome']}">
                    <p class="text-red-500 text-sm mt-1">${errors['nome']}</p>
                </c:if>
            </div>
            
            <div class="form-group">
                <label for="email" class="form-label">E-mail</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    value="${usuarioRequest.email}"
                    minlength="5"
                    maxlength="255"
                    placeholder="exemplo@dominio.com"
                    class="form-input ${not empty errors['email'] ? 'border-red-500' : ''}"
                    required
                />
                <c:if test="${not empty errors['email']}">
                    <p class="text-red-500 text-sm mt-1">${errors['email']}</p>
                </c:if>
            </div>
            
            <div class="form-group">
                <label for="senha" class="form-label">
                    <c:choose>
                        <c:when test="${isEdicao}">Nova Senha</c:when>
                        <c:otherwise>Senha</c:otherwise>
                    </c:choose>
                </label>
                <input 
                    type="password" 
                    id="senha" 
                    name="senha" 
                    placeholder="Digite a senha"
                    class="form-input ${not empty errors['senha'] ? 'border-red-500' : ''}" 
                    <c:if test="${not isEdicao}">minlength="8" required</c:if>
                    maxlength="255"
                />
                <c:if test="${not empty errors['senha']}">
                    <p class="text-red-500 text-sm mt-1">${errors['senha']}</p>
                </c:if>
                <c:if test="${isEdicao}">
                    <p class="password-info">Deixe em branco para manter a senha atual</p>
                </c:if>
                <c:if test="${not isEdicao}">
                    <p class="password-info">Mínimo de 8 caracteres</p>
                </c:if>
            </div>
            <c:if test="${usuarioLogado != null}">
                <div class="form-group">
                    <label for="role" class="form-label">Nível de Acesso</label>
                    <select 
                        class="form-input ${not empty errors['role'] ? 'border-red-500' : ''}" 
                        id="role" 
                        name="role"
                        ${usuarioLogado.role != 'ADMINISTRADOR' ? 'disabled' : ''}
                        required
                    >
                        <option value="">Selecione o nível de acesso</option>
                        <option value="CLIENTE" ${usuarioRequest.role == 'CLIENTE' ? 'selected' : ''}>Cliente</option>
                        <option value="RECEPCIONISTA" ${usuarioRequest.role == 'RECEPCIONISTA' ? 'selected' : ''}>Recepcionista</option>
                        <option value="ADMINISTRADOR" ${usuarioRequest.role == 'ADMINISTRADOR' ? 'selected' : ''}>Administrador</option>
                    </select>
                    <c:if test="${not empty errors['role']}">
                        <p class="text-red-500 text-sm mt-1">${errors['role']}</p>
                    </c:if>
                    <c:if test="${usuarioLogado.role != 'ADMINISTRADOR'}">
                        <p class="password-info">Apenas administradores podem alterar o nível de acesso</p>
                    </c:if>
                </div>
            </c:if>
            
            <input type="hidden" name="ativo" value="true" />
            
            <button type="submit" class="btn-primary">
                <i class="fas ${isEdicao ? 'fa-save' : 'fa-plus'} mr-2"></i> ${textoBotao}
            </button>
        </form>
        <a href="javascript:history.back()" class="back-link">
            <i class="fas fa-arrow-left mr-1"></i> Voltar
        </a>
    </div>
</div>
