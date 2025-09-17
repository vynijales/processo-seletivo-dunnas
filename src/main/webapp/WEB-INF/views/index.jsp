<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="flex flex-col items-center justify-center h-full py-16">
  <h1 class="text-3xl md:text-4xl font-bold text-blue-700 mb-4">
    Bem-vindo ao Sistema de Reserva de Salas!
  </h1>
  <p class="text-lg text-gray-700 mb-8">
    Gerencie reservas, usuários e salas de forma simples e eficiente.
  </p>

  <div class="flex gap-4">
    <a
      href="/salas"
      class="px-6 py-2 rounded bg-blue-700 text-white font-semibold hover:bg-blue-800 transition"
      >Ver Salas</a
    >
    <a
      href="/reservas"
      class="px-6 py-2 rounded bg-blue-600 text-white font-semibold hover:bg-blue-700 transition"
      >Ver Reservas</a
    >
    <a
      href="/usuarios"
      class="px-6 py-2 rounded bg-blue-500 text-white font-semibold hover:bg-blue-600 transition"
      >Ver Usuários</a
    >
  </div>
</div>
