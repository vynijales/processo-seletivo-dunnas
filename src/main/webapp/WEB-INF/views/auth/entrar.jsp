<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@
tagliburi="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Login - Reserva de Salas</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-50 min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full mx-auto bg-white rounded shadow-md p-8">
      <h1 class="text-2xl font-bold text-blue-700 mb-6 text-center">Login</h1>
<c:if test="${not empty errorMessage}">
  <jsp:include page="/WEB-INF/views/partials/alert.jsp">
    <jsp:param name="message" value="${errorMessage}"/>
    <jsp:param name="type" value="error"/>
  </jsp:include>
</c:if>
<c:if test="${not empty logoutMessage}">
  <jsp:include page="/WEB-INF/views/partials/alert.jsp">
    <jsp:param name="message" value="${logoutMessage}"/>
    <jsp:param name="type" value="success"/>
  </jsp:include>
</c:if>
      <form
        class="space-y-4"
        action="<c:url value='/processing-login' />"
        method="post"
      >
        <div>
          <jsp:include page="/WEB-INF/views/partials/input.jsp">
            <jsp:param name="type" value="email" />
            <jsp:param name="id" value="email" />
            <jsp:param name="name" value="email" />
            <jsp:param name="label" value="Email:" />
            <jsp:param name="required" value="true" />
            <jsp:param name="placeholder" value="Digite seu email" />
          </jsp:include>
        </div>
        <div>
          <jsp:include page="/WEB-INF/views/partials/input.jsp">
            <jsp:param name="type" value="password" />
            <jsp:param name="id" value="password" />
            <jsp:param name="name" value="password" />
            <jsp:param name="label" value="Senha:" />
            <jsp:param name="required" value="true" />
            <jsp:param name="placeholder" value="Digite sua senha" />
          </jsp:include>
        </div>
        <jsp:include page="/WEB-INF/views/partials/button.jsp">
          <jsp:param name="type" value="submit" />
          <jsp:param name="text" value="Entrar" />
          <jsp:param name="color" value="blue" />
          <jsp:param name="class" value="w-full" />
        </jsp:include>
      </form>
    </div>
  </body>
</html>
