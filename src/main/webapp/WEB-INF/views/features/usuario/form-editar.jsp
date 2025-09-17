<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Editar Usuário</title></head>
<body>
<h1>Editar Usuário</h1>
<c:if test="${not empty errorMessage}">
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
        ${errorMessage}
    </div>
</c:if>
<form action="/usuarios/${usuarioRequest.id}/editar" method="post">
    <input type="hidden" name="id" value="${usuarioRequest.id}" />
    <label>Nome:</label>
    <input type="text" name="nome" value="${usuarioRequest.nome}" required /><br/>
    <label>Email:</label>
    <input type="email" name="email" value="${usuarioRequest.email}" required /><br/>
    <label>Senha (deixe em branco para não alterar):</label>
    <input type="password" name="senha" /><br/>
    <label>Role:</label>
    <select name="role">
        <option value="ADMINISTRADOR" ${usuarioRequest.role == 'ADMINISTRADOR' ? 'selected' : ''}>Administrador</option>
        <option value="RECEPCIONISTA" ${usuarioRequest.role == 'RECEPCIONISTA' ? 'selected' : ''}>Recepcionista</option>
        <option value="CLIENTE" ${usuarioRequest.role == 'CLIENTE' ? 'selected' : ''}>Cliente</option>
    </select><br/>
    <button type="submit">Salvar</button>
</form>
<a href="/usuarios">Voltar à lista</a>
</body>
</html>
