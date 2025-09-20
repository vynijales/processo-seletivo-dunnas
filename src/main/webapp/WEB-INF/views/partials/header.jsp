<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="com.dunnas.reservasalas.core.utils.Capitalizar" %>

<!-- Importar CSS do header -->
<link rel="stylesheet" href="/static/css/header.css" />

<header
  class="main-header bg-gradient-to-r from-blue-700 to-blue-800 text-white shadow-lg"
>
  <div class="container mx-auto flex items-center justify-between py-3 px-6">
    <!-- Logo -->
    <a href="/" class="flex items-center gap-3 focus:outline-none">
      <img
        src="/static/images/logo.png"
        alt="Logo Reserva de Salas"
        class="h-10 w-auto transition-transform duration-300 hover:scale-105 logo"
      />
    </a>

    <!-- Navegação Principal -->
    <nav class="main-nav hidden md:flex items-center gap-1">
      <!-- <a
        href="/"
        class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
      >
        <i class="fas fa-home text-sm"></i>
        Início
      </a> -->
      <a
        href="/agendamentos"
        class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
      >
        <i class="fas fa-calendar-alt text-sm"></i>
        Agendamentos
      </a>
      <a
        href="/solicitacoes"
        class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
      >
        <i class="fas fa-clipboard-list text-sm"></i>
        Solicitações
      </a>
      <c:if test="${usuarioLogado.role != 'CLIENTE'}">
        <a
          href="/salas"
          class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
        >
          <i class="fas fa-door-open text-sm"></i>
          Salas
        </a>
      </c:if>
      <a
        href="/setores"
        class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
      >
        <i class="fas fa-building text-sm"></i>
        Setores
      </a>
      <c:if test="${usuarioLogado.role != 'CLIENTE'}">
        <a
          href="/usuarios"
          class="nav-link px-4 py-2 rounded-lg transition-all flex items-center gap-1"
        >
          <i class="fas fa-users text-sm"></i>
          Usuários
        </a>
      </c:if>
    </nav>

    <!-- Área do Usuário -->
    <div class="flex items-center gap-3 relative">
      <!-- Badge de Nível de Acesso com Menu Dropdown -->
      <div class="user-menu-container relative">
        <button
          id="user-menu-button"
          class="user-profile-btn flex items-center gap-2 bg-white bg-opacity-10 backdrop-blur-sm rounded-xl p-2 transition-all duration-300 hover:bg-opacity-20 border border-white border-opacity-20"
          aria-expanded="false"
          aria-haspopup="true"
        >
          <div class="bg-white bg-opacity-20 p-2 rounded-full">
            <i class="fas fa-user text-white"></i>
          </div>
          <div class="text-left hidden sm:block">
            <p
              class="text-xs text-blue-100 font-semibold uppercase tracking-wide"
            >
              ${Capitalizar.capitalizar(usuarioLogado.role)}
            </p>
            <p class="text-sm font-medium truncate max-w-xs">
              ${usuarioLogado.nome}
            </p>
          </div>
          <i
            class="fas fa-chevron-down text-xs transition-transform duration-200 ml-1 hidden sm:block"
          ></i>
        </button>

        <!-- Menu Dropdown -->
        <div
          id="user-dropdown-menu"
          class="user-dropdown absolute right-0 z-50 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none hidden transition-all duration-200 transform opacity-0 scale-95"
          role="menu"
          aria-orientation="vertical"
          tabindex="-1"
        >
          <div class="py-1 px-4 border-b border-gray-100">
            <p class="text-sm text-gray-500">Logado como</p>
            <p class="text-sm font-medium text-gray-900 truncate">
              ${usuarioLogado.nome}
            </p>
            <p class="text-xs text-blue-600 font-semibold mt-1">
              ${Capitalizar.capitalizar(usuarioLogado.role)}
            </p>
          </div>

          <div class="py-1">
            <a
              href="/usuarios/${usuarioLogado.id}/editar"
              class="dropdown-item flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-600"
              role="menuitem"
            >
              <i class="fas fa-user-edit w-5 mr-3"></i>
              Editar Perfil
            </a>
            <!-- <a
              href="/minhas-solicitacoes"
              class="dropdown-item flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-600"
              role="menuitem"
            >
              <i class="fas fa-clipboard-list w-5 mr-3"></i>
              Minhas Solicitações
            </a>
            <a
              href="/alterar-senha"
              class="dropdown-item flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-600"
              role="menuitem"
            >
              <i class="fas fa-lock w-5 mr-3"></i>
              Alterar Senha
            </a> -->
          </div>

          <div class="py-1 border-t border-gray-100">
            <a
              href="/logout"
              class="dropdown-item flex items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50"
              role="menuitem"
            >
              <i class="fas fa-sign-out-alt w-5 mr-3"></i>
              Sair do Sistema
            </a>
          </div>
        </div>
      </div>

      <!-- Botão de Logout (apenas para mobile) -->
      <a
        href="/logout"
        class="logout-btn flex items-center gap-2 bg-white bg-opacity-0 hover:bg-opacity-10 text-white px-3 py-2 rounded-lg transition-all duration-300 border border-white border-opacity-20 hover:border-opacity-30 sm:hidden"
        title="Sair do sistema"
      >
        <i class="fas fa-sign-out-alt"></i>
      </a>
    </div>
  </div>

  <!-- Menu Mobile (Expandido) -->
  <div id="mobile-menu" class="hidden mobile-menu px-6 py-4">
    <div class="flex flex-col gap-3">
      <!-- <a
        href="/"
        class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
      >
        <i class="fas fa-home"></i>
        Início
      </a> -->
      <a
        href="/solicitacoes"
        class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
      >
        <i class="fas fa-calendar-alt"></i>
        Agendamentos
      </a>
      <a
        href="/solicitacoes"
        class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
      >
        <i class="fas fa-clipboard-list"></i>
        Solicitações
      </a>

      <c:if test="${usuarioLogado.role != 'CLIENTE'}">
        <a
          href="/salas"
          class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
        >
          <i class="fas fa-door-open"></i>
          Salas
        </a>
      </c:if>
      <a
        href="/setores"
        class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
      >
        <i class="fas fa-building"></i>
        Setores
      </a>
      <a
        href="/usuarios"
        class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
      >
        <i class="fas fa-users"></i>
        Usuários
      </a>

      <!-- Seção do usuário no menu mobile -->
      <div class="pt-4 mt-4 border-t border-white border-opacity-20">
        <div class="flex items-center gap-3 mb-3 px-4">
          <div class="bg-white bg-opacity-20 p-2 rounded-full">
            <i class="fas fa-user text-white"></i>
          </div>
          <div>
            <p
              class="text-xs text-blue-100 font-semibold uppercase tracking-wide"
            >
              ${Capitalizar.capitalizar(usuarioLogado.role)}
            </p>
            <p class="text-sm font-medium">${usuarioLogado.nome}</p>
          </div>
        </div>

        <a
          href="/usuarios/${usuarioLogado.id}/editar"
          class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
        >
          <i class="fas fa-user-edit"></i>
          Editar Perfil
        </a>
        <a
          href="/minhas-solicitacoes"
          class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
        >
          <i class="fas fa-clipboard-list"></i>
          Minhas Solicitações
        </a>
        <a
          href="/alterar-senha"
          class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3"
        >
          <i class="fas fa-lock"></i>
          Alterar Senha
        </a>
        <a
          href="/logout"
          class="mobile-nav-link py-2 px-4 rounded-lg transition-all flex items-center gap-3 text-red-100 hover:bg-red-500 hover:bg-opacity-20"
        >
          <i class="fas fa-sign-out-alt"></i>
          Sair do Sistema
        </a>
      </div>
    </div>
  </div>
</header>

<script>
  // Controle do menu mobile
  document.addEventListener("DOMContentLoaded", function () {
    const mobileMenuButton = document.getElementById("mobile-menu-button");
    if (mobileMenuButton) {
      mobileMenuButton.addEventListener("click", function () {
        const mobileMenu = document.getElementById("mobile-menu");
        mobileMenu.classList.toggle("hidden");
      });
    }

    // Fechar menu mobile ao clicar fora dele
    document.addEventListener("click", function (event) {
      const mobileMenu = document.getElementById("mobile-menu");
      const mobileMenuButton = document.getElementById("mobile-menu-button");

      if (
        mobileMenu &&
        !mobileMenu.classList.contains("hidden") &&
        !mobileMenu.contains(event.target) &&
        event.target !== mobileMenuButton &&
        !mobileMenuButton.contains(event.target)
      ) {
        mobileMenu.classList.add("hidden");
      }
    });

    // Controle do menu dropdown do usuário
    const userMenuButton = document.getElementById("user-menu-button");
    const userDropdown = document.getElementById("user-dropdown-menu");

    if (userMenuButton && userDropdown) {
      let isMenuOpen = false;

      userMenuButton.addEventListener("click", function (e) {
        e.stopPropagation();
        isMenuOpen = !isMenuOpen;

        if (isMenuOpen) {
          userDropdown.classList.remove("hidden");
          setTimeout(() => {
            userDropdown.classList.remove("opacity-0");
            userDropdown.classList.remove("scale-95");
            userDropdown.classList.add("opacity-100");
            userDropdown.classList.add("scale-100");
          }, 10);

          // Atualizar atributo aria-expanded
          userMenuButton.setAttribute("aria-expanded", "true");

          // Rotacionar ícone de seta
          const arrowIcon = userMenuButton.querySelector(".fa-chevron-down");
          if (arrowIcon) {
            arrowIcon.classList.add("rotate-180");
          }
        } else {
          userDropdown.classList.add("opacity-0");
          userDropdown.classList.add("scale-95");
          userDropdown.classList.remove("opacity-100");
          userDropdown.classList.remove("scale-100");

          setTimeout(() => {
            userDropdown.classList.add("hidden");
          }, 200);

          // Atualizar atributo aria-expanded
          userMenuButton.setAttribute("aria-expanded", "false");

          // Rotacionar ícone de seta
          const arrowIcon = userMenuButton.querySelector(".fa-chevron-down");
          if (arrowIcon) {
            arrowIcon.classList.remove("rotate-180");
          }
        }
      });

      // Fechar menu ao clicar fora
      document.addEventListener("click", function (e) {
        if (
          isMenuOpen &&
          !userMenuButton.contains(e.target) &&
          !userDropdown.contains(e.target)
        ) {
          userDropdown.classList.add("opacity-0");
          userDropdown.classList.add("scale-95");
          userDropdown.classList.remove("opacity-100");
          userDropdown.classList.remove("scale-100");

          setTimeout(() => {
            userDropdown.classList.add("hidden");
          }, 200);

          isMenuOpen = false;
          userMenuButton.setAttribute("aria-expanded", "false");

          const arrowIcon = userMenuButton.querySelector(".fa-chevron-down");
          if (arrowIcon) {
            arrowIcon.classList.remove("rotate-180");
          }
        }
      });

      // Prevenir que cliques dentro do menu fechem ele
      userDropdown.addEventListener("click", function (e) {
        e.stopPropagation();
      });
    }
  });
</script>

<style>
  /* Estilos para a área do usuário melhorada */
  .user-dropdown {
    transform-origin: top right;
  }

  .dropdown-item {
    transition: all 0.2s ease;
  }

  .rotate-180 {
    transform: rotate(180deg);
  }

  /* Melhorias de acessibilidade para foco */
  .user-profile-btn:focus,
  .dropdown-item:focus {
    outline: 2px solid white;
    outline-offset: 2px;
  }
</style>
