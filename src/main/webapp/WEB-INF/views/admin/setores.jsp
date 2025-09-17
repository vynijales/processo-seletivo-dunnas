<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Setores</title></head>
<body>
<h1>Setores</h1>
<table>
    <tr><th>ID</th><th>Nome</th><th>Recepcionista</th><th>Caixa</th></tr>
    <c:forEach var="setor" items="${setores}">
        <tr>
            <td>${setor.id}</td>
            <td>${setor.nome}</td>
            <td>${setor.recepcionista.nome}</td>
            <td>${setor.caixa}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
