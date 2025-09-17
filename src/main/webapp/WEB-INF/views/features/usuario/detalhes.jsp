<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Detalhes do Usuário</title>
  </head>
  <body>
    <h1>Detalhes do Usuário</h1>
    <p>ID: ${usuario.id}</p>
    <p>Nome: ${usuario.nome}</p>
    <p>Email: ${usuario.email}</p>
    <p>Role: ${usuario.role}</p>
    <p>Ativo: ${usuario.ativo}</p>
    <a href="/usuarios/${usuario.id}/editar">Editar</a>
    <a
      href="/usuarios/${usuario.id}/excluir"
      onclick="return confirm('Excluir?');"
      >Excluir</a
    >
    <a href="/usuarios">Voltar à lista</a>
  </body>
</html>
