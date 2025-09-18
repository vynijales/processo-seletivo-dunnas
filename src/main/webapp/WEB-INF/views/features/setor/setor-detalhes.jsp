<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<div class="max-w-lg mx-auto bg-white rounded shadow-md p-8 mt-8">
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Detalhes do Setor</h1>
  <div class="space-y-2 text-gray-700 mb-6">
    <p><span class="font-semibold">ID:</span> ${setor.id}</p>
    <p><span class="font-semibold">Nome:</span> ${setor.nome}</p>
    <p><span class="font-semibold">Valor caixa:</span> ${setor.valorCaixa}</p>
    <p>
      <span class="font-semibold">Recepcionista:</span>
      ${setor.recepcionista.nome}
    </p>
    <p>
      <span class="font-semibold">Ativo:</span> ${setor.ativo ? "Sim" : "Não"}
    </p>
  </div>
  <div class="flex gap-3 mt-6">
    <c:if test="${usuarioLogado.role == 'ADMINISTRADOR'}">
      <a
        href="/setores/${setor.id}/editar"
        class="px-4 py-2 rounded font-semibold bg-yellow-500 text-white hover:bg-yellow-600 transition focus:outline-none"
        >Editar</a
      >
      <a
        href="/setores/${setor.id}/excluir"
        class="px-4 py-2 rounded font-semibold bg-red-600 text-white hover:bg-red-700 transition focus:outline-none"
        >Excluir</a
      >
    </c:if>
  </div>
  <a
    href="/setores"
    class="block text-center text-md text-gray-500 mt-4 hover:underline"
    >Voltar</a
  >
</div>
