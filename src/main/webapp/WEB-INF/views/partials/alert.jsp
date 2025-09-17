<%-- Alerta reutilizável com Tailwind --%>
<%
    String message = request.getParameter("message") != null ? request.getParameter("message") : "";
    String type = request.getParameter("type") != null ? request.getParameter("type") : "info";
    String extraClass = request.getParameter("class") != null ? request.getParameter("class") : "";
    String baseClass = "mb-4 px-4 py-2 rounded border ";
    String colorClass = "";
    switch (type) {
        case "error": colorClass = "bg-red-100 text-red-700 border-red-300"; break;
        case "success": colorClass = "bg-green-100 text-green-700 border-green-300"; break;
        default: colorClass = "bg-blue-100 text-blue-700 border-blue-300";
    }
    String allClass = baseClass + colorClass + " " + extraClass;
%>
<% if (!message.isEmpty()) { %>
    <div class="<%= allClass %>"><%= message %></div>
<% } %>
