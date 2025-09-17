<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>Lista de Usuários</title>
  </head>
  <body>
    <h1>Usuários</h1>
    <a href="/usuarios/criar">Novo Usuário</a>
    <table border="1">
      <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Email</th>
        <th>Role</th>
        <th>Ativo</th>
        <th>Ações</th>
      </tr>
      <c:forEach var="usuario" items="${usuarios.content}">
        <tr>
          <td>${usuario.id}</td>
          <td>${usuario.nome}</td>
          <td>${usuario.email}</td>
          <td>${usuario.role}</td>
          <td>${usuario.ativo}</td>
          <td>
            <a href="/usuarios/${usuario.id}">Ver</a>
            <a href="/usuarios/${usuario.id}/editar">Editar</a>
            <a
              href="/usuarios/${usuario.id}/excluir"
              onclick="return confirm('Excluir?');"
              >Excluir</a
            >
          </td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
