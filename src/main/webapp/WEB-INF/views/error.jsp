<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
isErrorPage="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Erro ${status} | Sistema de Reservas</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap");

      body {
        font-family: "Inter", sans-serif;
        background: linear-gradient(135deg, #fef2f2 0%, #fffbeb 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 1rem;
      }

      .error-card {
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: 1px solid #e5e7eb;
        border-radius: 0.75rem;
        overflow: hidden;
        max-width: 42rem;
        width: 100%;
        background: white;
      }

      .error-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 35px 60px -12px rgba(0, 0, 0, 0.15);
      }

      .error-header {
        background: linear-gradient(to right, #dc2626, #b91c1c);
        padding: 1.5rem;
        color: white;
      }

      .error-content {
        padding: 1.5rem;
      }

      .error-info {
        background-color: #fef2f2;
        border: 1px solid #fecaca;
        border-radius: 0.5rem;
        padding: 1rem;
        margin-bottom: 1.5rem;
      }

      .info-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 0.75rem;
      }

      .info-item {
        display: flex;
        flex-direction: column;
      }

      .info-label {
        font-weight: 500;
        color: #dc2626;
        font-size: 0.875rem;
      }

      .info-value {
        color: #374151;
        font-size: 0.875rem;
        word-break: break-all;
      }

      .message-box {
        background-color: #fecaca;
        color: #7f1d1d;
        border-radius: 0.375rem;
        padding: 0.5rem 0.75rem;
        font-size: 0.875rem;
        display: inline-block;
        margin-top: 0.5rem;
      }

      .action-buttons {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
        margin-top: 1.5rem;
      }

      .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        font-weight: 500;
        transition: all 0.2s ease;
      }

      .btn-primary {
        background-color: #dc2626;
        color: white;
      }

      .btn-primary:hover {
        background-color: #b91c1c;
      }

      .btn-secondary {
        border: 1px solid #d1d5db;
        color: #374151;
      }

      .btn-secondary:hover {
        background-color: #f9fafb;
      }

      .support-section {
        border-top: 1px solid #e5e7eb;
        padding-top: 1.5rem;
        margin-top: 1.5rem;
        display: flex;
        align-items: center;
      }

      .support-icon {
        color: #9ca3af;
        margin-right: 0.75rem;
      }

      .support-text {
        font-size: 0.875rem;
        color: #6b7280;
      }

      .support-contact {
        font-size: 0.875rem;
        font-weight: 500;
        color: #374151;
      }

      .fade-in {
        animation: fadeIn 0.5s ease-in;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @media (max-width: 640px) {
        .info-grid {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <div class="error-card fade-in">
      <!-- Cabeçalho -->
      <div class="error-header">
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="bg-white bg-opacity-20 p-2 rounded-full mr-3">
              <i class="fas fa-exclamation-triangle text-xl"></i>
            </div>
            <div>
              <h1 class="text-xl font-bold">Erro ${status}</h1>
              <p class="opacity-90 text-sm">Ocorreu um problema inesperado</p>
            </div>
          </div>
          <div class="text-4xl font-bold opacity-20">${status}</div>
        </div>
      </div>

      <div class="error-content">
        <!-- Mensagem principal -->
        <div class="flex items-start mb-5">
          <div class="flex-shrink-0">
            <i class="fas fa-info-circle text-red-500 text-lg mt-0.5"></i>
          </div>
          <div class="ml-3">
            <h2 class="text-lg font-semibold text-gray-800">Algo deu errado</h2>
            <p class="text-gray-600">
              Desculpe pelo inconveniente. O sistema encontrou um erro ao
              processar sua solicitação.
            </p>
          </div>
        </div>

        <!-- Informações do erro -->
        <div class="error-info">
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Status:</span>
              <span class="info-value">${status}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Tipo:</span>
              <span class="info-value">${error}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Caminho:</span>
              <span class="info-value">${path}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Horário:</span>
              <span class="info-value" id="timestamp"></span>
            </div>
          </div>

          <div class="mt-4">
            <span class="info-label">Mensagem:</span>
            <div class="message-box">
              ${not empty message ? message : 'Nenhuma mensagem adicional
              disponível'}
            </div>
          </div>
        </div>

        <!-- Ações -->
        <div class="action-buttons">
          <a href="/" class="btn btn-primary">
            <i class="fas fa-home mr-2"></i> Voltar ao Início
          </a>
          <a href="javascript:history.back()" class="btn btn-secondary">
            <i class="fas fa-arrow-left mr-2"></i> Voltar à Página Anterior
          </a>
        </div>

        <!-- Suporte -->
        <div class="support-section">
          <div class="support-icon">
            <i class="fas fa-life-ring"></i>
          </div>
          <div>
            <p class="support-text">
              Precisa de ajuda? Entre em contato com o suporte técnico.
            </p>
            <p class="support-contact">
              suporte@reservasalas.com • (11) 3456-7890
            </p>
          </div>
        </div>
      </div>
    </div>

    <script>
      // Formatar timestamp
      document.addEventListener("DOMContentLoaded", function () {
        const now = new Date();
        const timestampEl = document.getElementById("timestamp");
        timestampEl.textContent = now.toLocaleString("pt-BR");
      });
    </script>
  </body>
</html>
