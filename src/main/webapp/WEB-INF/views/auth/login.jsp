<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Login - Reserva de Salas</title>
  </head>
  <body>
    <h1>Login</h1>
    <%@ page
    import="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" %>
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div style="color: red"><%= request.getAttribute("errorMessage") %></div>
    <% } %> <% if (request.getAttribute("logoutMessage") != null) { %>
    <div style="color: green"><%= request.getAttribute("logoutMessage") %></div>
    <% } %>
    <form action="<c:url value='/processing-login' />" method="post">
      <%= new BCryptPasswordEncoder().encode("admin123") %>

      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required />
      <br />
      <label for="password">Senha:</label>
      <input type="password" id="password" name="password" required />
      <br />

      <%= new BCryptPasswordEncoder().matches("admin123",
      "$2a$10$$2a$10$rIuZBdnqr4SVVNbXl3yuhuEHWyLnFDYvhjQZflknJ9vnqqN1bWp3O") %>
      <button type="submit">Entrar</button>
    </form>
  </body>
</html>
