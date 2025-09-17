<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
isErrorPage="true" %>
<html>
  <head>
    <title>Error</title>
  </head>
  <body>
    <h1>Error Page</h1>
    <p>Status: ${status}</p>
    <p>Error: ${error}</p>
    <p>Message: ${message}</p>
    <p>Path: ${path}</p>
  </body>
</html>
