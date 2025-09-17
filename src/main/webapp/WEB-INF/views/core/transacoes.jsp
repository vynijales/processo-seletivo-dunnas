<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Transações</title></head>
<body>
<h1>Transações</h1>
<table>
    <tr><th>ID</th><th>Reserva</th><th>Tipo</th><th>Valor</th><th>Usuário</th><th>Data</th></tr>
    <c:forEach var="transacao" items="${transacoes}">
        <tr>
            <td>${transacao.id}</td>
            <td>${transacao.reserva.id}</td>
            <td>${transacao.tipo}</td>
            <td>${transacao.valor}</td>
            <td>${transacao.usuario.nome}</td>
            <td>${transacao.data}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
