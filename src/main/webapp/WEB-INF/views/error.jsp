<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page isErrorPage="true" %>
<html>
  <head>
    <title>Error</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-red-50 min-h-screen flex items-center justify-center">
    <div class="max-w-lg w-full bg-white rounded shadow-lg p-8 border border-red-200">
      <h1 class="text-2xl font-bold text-red-700 mb-4">Ocorreu um erro</h1>
      <div class="space-y-2 text-gray-700">
        <p><span class="font-semibold">Status:</span> ${status}</p>
        <p><span class="font-semibold">Erro:</span> ${error}</p>
        <p><span class="font-semibold">Mensagem:</span> ${message}</p>
        <p><span class="font-semibold">Path:</span> ${path}</p>
      </div>
      <a href="/" class="mt-6 inline-block px-4 py-2 rounded bg-red-700 text-white font-semibold hover:bg-red-800 transition">Voltar ao início</a>
    </div>
  </body>
</html>
