<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Botão/Link reutilizável com Tailwind --%>
<%
    String text = request.getParameter("text") != null ? request.getParameter("text") : "Botão";
    if (text == null || text.trim().isEmpty()) {
        text = "Botão";
    }
    String color = request.getParameter("color") != null ? request.getParameter("color") : "blue";
    String type = request.getParameter("type") != null ? request.getParameter("type") : "button";
    String href = request.getParameter("href") != null ? request.getParameter("href") : null;
    String alt = request.getParameter("alt") != null ? request.getParameter("alt") : null;
    String extraClass = request.getParameter("class") != null ? request.getParameter("class") : "";
    String variant = request.getParameter("variant") != null ? request.getParameter("variant") : "";
    String baseClass = "px-4 py-2 rounded font-semibold transition focus:outline-none ";
    String colorClass = "";
    if ("ghost".equals(variant)) {
        switch (color) {
            case "yellow": colorClass = "border border-yellow-500 text-yellow-700 bg-transparent hover:bg-yellow-50"; break;
            case "red": colorClass = "border border-red-500 text-red-700 bg-transparent hover:bg-red-50"; break;
            case "gray": colorClass = "border border-gray-400 text-gray-700 bg-transparent hover:bg-gray-100"; break;
            case "green": colorClass = "border border-green-500 text-green-700 bg-transparent hover:bg-green-50"; break;
            default: colorClass = "border border-blue-700 text-blue-700 bg-transparent hover:bg-blue-50";
        }
    } else if ("ghost-destructive".equals(variant)) {
        colorClass = "text-red-600 bg-transparent hover:text-white";
    } else {
        switch (color) {
            case "yellow": colorClass = "bg-yellow-500 text-white hover:bg-yellow-600"; break;
            case "red": colorClass = "bg-red-600 text-white hover:bg-red-700"; break;
            case "gray": colorClass = "bg-gray-200 text-gray-700 hover:bg-gray-300"; break;
            case "green": colorClass = "bg-green-600 text-white hover:bg-green-700"; break;
            default: colorClass = "bg-blue-700 text-white hover:bg-blue-800";
        }
    }
    String allClass = baseClass + colorClass + " " + extraClass;
%>
<!-- DEBUG: text param = <%= text %> -->
<% if (href != null) { %>
    <a href="<%= href %>" <%= alt != null ? "alt='" + alt + "'" : "" %> class="<%= allClass %>"><%= text %></a>
<% } else { %>
    <button type="<%= type %>" class="<%= allClass %>"><%= text %></button>
<% } %>
