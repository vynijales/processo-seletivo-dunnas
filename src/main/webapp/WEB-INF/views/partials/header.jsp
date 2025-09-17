<%@ page contentType="text/html;charset=UTF-8" language="java"
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>
<header class="main-header bg-blue-700 text-white shadow-md">
  <div class="container mx-auto flex items-center justify-between py-4 px-4">
    <div class="flex items-center gap-4">
      <img
        src="/static/images/logo.png"
        alt="Logo Reserva de Salas"
        class="h-12 w-auto"
      />
    </div>
    <nav class="main-nav flex gap-6">
      <a href="/" class="hover:text-blue-200 transition">Início</a>
      <a href="/salas" class="hover:text-blue-200 transition">Salas</a>
      <a href="/reservas" class="hover:text-blue-200 transition">Reservas</a>
      <a href="/usuarios" class="hover:text-blue-200 transition">Usuários</a>
    </nav>
    <div class="flex items-center gap-4">
      <!-- Badge de Nível de Acesso -->
      <div
        class="role-container bg-blue-50 border-l-4 border-blue-500 rounded-lg p-2 shadow-md transition-all duration-300 hover:shadow-lg"
      >
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="bg-blue-100 p-2 rounded-full mr-3">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 text-blue-600"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                />
              </svg>
            </div>
            <div>
              <p class="text-xs text-blue-500 font-semibold">${usuario_role}</p>
              <p class="text-blue-800 font-medium">${usuario_nome}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Botão de Logout -->
      <a
        href="/logout"
        class="logout-btn flex items-center gap-2 bg-white text-red-600 hover:bg-red-50 hover:text-red-700 px-4 py-2 rounded-lg transition-all duration-300 border border-red-200 shadow-sm hover:shadow-md"
        title="Sair do sistema"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
          />
        </svg>
        <span class="font-medium">Sair</span>
      </a>
    </div>
  </div>
</header>
