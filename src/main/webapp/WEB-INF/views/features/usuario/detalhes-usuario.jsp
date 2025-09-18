<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Detalhes do Usuário</h1>
  <div class="space-y-2 text-gray-700 mb-6">
    <p><span class="font-semibold">ID:</span> ${usuario.id}</p>
    <p><span class="font-semibold">Nome:</span> ${usuario.nome}</p>
    <p><span class="font-semibold">Email:</span> ${usuario.email}</p>
    <p><span class="font-semibold">Role:</span> ${usuario.role}</p>
    <p>
      <span class="font-semibold">Ativo:</span> ${usuario.ativo ? "Sim" : "Não"}
    </p>
  </div>
  <div class="flex gap-3 mt-6">
    <a
      href="/usuarios/${usuario.id}/editar"
      class="px-4 py-2 rounded font-semibold bg-yellow-500 text-white hover:bg-yellow-600 transition focus:outline-none"
      >Editar</a
    >
    <a
      href="/usuarios/${usuario.id}/excluir"
      class="px-4 py-2 rounded font-semibold bg-red-600 text-white hover:bg-red-700 transition focus:outline-none"
      >Excluir</a
    >
  </div>
  <a
    href="/usuarios"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
    >Voltar</a
  >
</div>
