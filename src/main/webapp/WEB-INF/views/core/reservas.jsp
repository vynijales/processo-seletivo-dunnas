<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Reservas</title></head>
<body>
<h1>Reservas</h1>
<table>
    <tr><th>ID</th><th>Sala</th><th>Cliente</th><th>Status</th><th>Início</th><th>Fim</th></tr>
    <c:forEach var="reserva" items="${reservas}">
        <tr>
            <td>${reserva.id}</td>
            <td>${reserva.sala.nome}</td>
            <td>${reserva.cliente.nome}</td>
            <td>${reserva.status}</td>
            <td>${reserva.dataInicio}</td>
            <td>${reserva.dataFim}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
