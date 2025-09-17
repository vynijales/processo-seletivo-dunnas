<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Reserva de Salas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">
    <%@ include file="/WEB-INF/views/partials/header.jsp" %>
    <main class="main-content flex-1 container mx-auto px-4 py-8 bg-white rounded shadow-md">
        <jsp:include page="${contentPage}" />
    </main>
    <%@ include file="/WEB-INF/views/partials/footer.jsp" %>
</body>
