<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div
  class="welcome-container min-h-[70vh] flex items-center justify-center py-12 px-4"
>
  <div class="text-center max-w-4xl mx-auto">
    <!-- Título principal -->
    <h1
      class="text-4xl md:text-5xl lg:text-6xl font-bold text-blue-800 mb-6 leading-tight"
    >
      Bem-vindo ao Sistema de
      <span
        class="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-blue-800"
      >
        Reserva de Salas!
      </span>
    </h1>

    <!-- Subtítulo -->
    <p
      class="text-xl md:text-2xl text-gray-600 mb-10 max-w-3xl mx-auto leading-relaxed"
    >
      Gerencie reservas, usuários e salas de forma simples, rápida e eficiente.
    </p>

    <!-- Estatísticas ou informações rápidas -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
      <div class="bg-blue-50 p-4 rounded-lg border border-blue-100">
        <div class="text-3xl font-bold text-blue-700 mb-1">${totalSalas}</div>
        <div class="text-sm text-blue-600">Salas Disponíveis</div>
      </div>
      <div class="bg-green-50 p-4 rounded-lg border border-green-100">
        <div class="text-3xl font-bold text-green-700 mb-1">
          ${reservasHoje}
        </div>
        <div class="text-sm text-green-600">Reservas Hoje</div>
      </div>
      <div class="bg-purple-50 p-4 rounded-lg border border-purple-100">
        <div class="text-3xl font-bold text-purple-700 mb-1">
          ${totalSetores}
        </div>
        <div class="text-sm text-purple-600">Setores</div>
      </div>
      <div class="bg-orange-50 p-4 rounded-lg border border-orange-100">
        <div class="text-3xl font-bold text-orange-700 mb-1">
          ${usuariosAtivos}
        </div>
        <div class="text-sm text-orange-600">Usuários Ativos</div>
      </div>
    </div>

    <!-- Cards de ação -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5 mb-12">
      <a href="/solicitacoes" class="action-card group">
        <div class="icon-container bg-blue-100 group-hover:bg-blue-200">
          <i class="fas fa-clipboard-list text-blue-600 text-xl"></i>
        </div>
        <h3 class="action-title">Solicitações</h3>
        <p class="action-description">Gerencie pedidos de reserva</p>
        <div class="action-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>
      </a>

      <a href="/salas" class="action-card group">
        <div class="icon-container bg-green-100 group-hover:bg-green-200">
          <i class="fas fa-door-open text-green-600 text-xl"></i>
        </div>
        <h3 class="action-title">Salas</h3>
        <p class="action-description">Visualize todas as salas</p>
        <div class="action-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>
      </a>

      <a href="/setores" class="action-card group">
        <div class="icon-container bg-purple-100 group-hover:bg-purple-200">
          <i class="fas fa-building text-purple-600 text-xl"></i>
        </div>
        <h3 class="action-title">Setores</h3>
        <p class="action-description">Organize por departamentos</p>
        <div class="action-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>
      </a>

      <a href="/usuarios" class="action-card group">
        <div class="icon-container bg-orange-100 group-hover:bg-orange-200">
          <i class="fas fa-users text-orange-600 text-xl"></i>
        </div>
        <h3 class="action-title">Usuários</h3>
        <p class="action-description">Administre usuários do sistema</p>
        <div class="action-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>
      </a>
    </div>

    <!-- Chamada adicional -->
    <div class="bg-gray-50 rounded-xl p-6 border border-gray-200">
      <h2 class="text-2xl font-semibold text-gray-800 mb-3">
        Precisa de ajuda?
      </h2>
      <p class="text-gray-600 mb-4">
        Consulte nosso guia rápido ou entre em contato com o suporte
      </p>
      <div class="flex justify-center gap-4">
        <a
          href="/ajuda"
          class="px-5 py-2.5 rounded-lg bg-gray-200 text-gray-700 font-medium hover:bg-gray-300 transition"
        >
          <i class="fas fa-question-circle mr-2"></i> Guia Rápido
        </a>
        <a
          href="/contato"
          class="px-5 py-2.5 rounded-lg bg-blue-600 text-white font-medium hover:bg-blue-700 transition"
        >
          <i class="fas fa-headset mr-2"></i> Suporte
        </a>
      </div>
    </div>
  </div>
</div>

<style>
  .welcome-container {
    background: white;
  }

  .action-card {
    background: white;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    position: relative;
    overflow: hidden;
    outline-offset: 0px;
  }

  .action-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    border-color: #3b82f6;
  }

  .action-card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #3b82f6, #2563eb);
    transform: scaleX(0);
    transition: transform 0.3s ease;
  }

  .action-card:hover::before {
    transform: scaleX(1);
  }

  .icon-container {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1rem;
    transition: all 0.3s ease;
  }

  .action-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 0.5rem;
  }

  .action-description {
    color: #64748b;
    font-size: 0.9rem;
    margin-bottom: 1rem;
  }

  .action-arrow {
    color: #3b82f6;
    opacity: 0;
    transform: translateX(-10px);
    transition: all 0.3s ease;
  }

  .action-card:hover .action-arrow {
    opacity: 1;
    transform: translateX(0);
  }

  /* Responsividade */
  @media (max-width: 768px) {
    .welcome-container {
      padding: 2rem 1rem;
    }

    h1 {
      font-size: 2rem;
    }

    p {
      font-size: 1.1rem;
    }

    .grid-cols-2 {
      grid-template-columns: 1fr 1fr;
    }
  }
</style>

<!-- Adicione isso ao seu arquivo main.js se quiser animações extras -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // Animação de entrada para os elementos
    const animateOnScroll = function () {
      const elements = document.querySelectorAll(
        ".action-card, .bg-blue-50, .bg-green-50, .bg-purple-50, .bg-orange-50"
      );

      elements.forEach((element) => {
        const elementPosition = element.getBoundingClientRect().top;
        const screenPosition = window.innerHeight / 1.3;

        if (elementPosition < screenPosition) {
          element.style.opacity = 1;
          element.style.transform = "translateY(0)";
        }
      });
    };

    // Inicializa elementos com opacidade 0 para animação
    const cards = document.querySelectorAll(".action-card");
    const stats = document.querySelectorAll(
      ".bg-blue-50, .bg-green-50, .bg-purple-50, .bg-orange-50"
    );

    cards.forEach((card) => {
      card.style.opacity = 0;
      card.style.transform = "translateY(20px)";
      card.style.transition = "opacity 0.5s ease, transform 0.5s ease";
    });

    stats.forEach((stat) => {
      stat.style.opacity = 0;
      stat.style.transform = "scale(0.95)";
      stat.style.transition = "opacity 0.5s ease, transform 0.5s ease";
    });

    // Dispara a animação quando a página carrega
    setTimeout(animateOnScroll, 100);

    // E também no scroll
    window.addEventListener("scroll", animateOnScroll);
  });
</script>
