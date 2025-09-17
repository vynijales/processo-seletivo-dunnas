<%-- Input reutilizável com Tailwind --%>
<%
    String type = request.getParameter("type") != null ? request.getParameter("type") : "text";
    String id = request.getParameter("id") != null ? request.getParameter("id") : null;
    String name = request.getParameter("name") != null ? request.getParameter("name") : null;
    String value = request.getParameter("value") != null ? request.getParameter("value") : "";
    String label = request.getParameter("label") != null ? request.getParameter("label") : null;
    String required = request.getParameter("required") != null ? request.getParameter("required") : null;
    String placeholder = request.getParameter("placeholder") != null ? request.getParameter("placeholder") : null;
    String extraClass = request.getParameter("class") != null ? request.getParameter("class") : "";
    String baseClass = "w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500 ";
    String allClass = baseClass + extraClass;
%>
<% if (label != null && id != null) { %>
    <label for="<%= id %>" class="block font-semibold mb-1"><%= label %></label>
<% } %>
<input 
    type="<%= type %>" 
    <%= id != null ? "id='" + id + "'" : "" %>
    <%= name != null ? "name='" + name + "'" : "" %>
    value="<%= value %>"
    <%= required != null ? "required" : "" %>
    <%= placeholder != null ? "placeholder='" + placeholder + "'" : "" %>
    class="<%= allClass %>"
/>
