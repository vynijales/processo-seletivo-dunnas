<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Salas</title></head>
<body>
<h1>Salas</h1>
<table>
    <tr><th>ID</th><th>Nome</th><th>Setor</th><th>Valor</th><th>Capacidade</th></tr>
    <c:forEach var="sala" items="${salas}">
        <tr>
            <td>${sala.id}</td>
            <td>${sala.nome}</td>
            <td>${sala.setor.nome}</td>
            <td>${sala.valor}</td>
            <td>${sala.capacidade}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
