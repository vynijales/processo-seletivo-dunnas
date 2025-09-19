<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="confirmationDialog" class="dialog-overlay" style="display: none">
  <div class="dialog-container">
    <div class="dialog-header">
      <h3 class="dialog-title" id="dialogTitle">Confirmação</h3>
      <button type="button" class="dialog-close" onclick="closeDialog()">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <div class="dialog-body">
      <div class="dialog-icon">
        <i class="fas fa-exclamation-triangle"></i>
      </div>
      <p class="dialog-message" id="dialogMessage">
        Tem certeza que deseja executar esta ação?
      </p>
    </div>
    <div class="dialog-footer">
      <button type="button" class="btn btn-secondary" onclick="closeDialog()">
        Cancelar
      </button>
      <button type="button" class="btn btn-error" id="confirmActionBtn">
        Confirmar
      </button>
    </div>
  </div>
</div>

<script>
  // Variáveis para armazenar a ação de confirmação
  let confirmCallback = null;

  // Função para abrir o diálogo de confirmação
  function showConfirmationDialog(message, title, callback) {
    const dialog = document.getElementById("confirmationDialog");
    const titleElement = document.getElementById("dialogTitle");
    const messageElement = document.getElementById("dialogMessage");
    const confirmBtn = document.getElementById("confirmActionBtn");

    // Configurar título e mensagem
    if (title) titleElement.textContent = title;
    messageElement.textContent = message;

    // Configurar callback
    confirmCallback = callback;

    // Configurar evento do botão de confirmação
    confirmBtn.onclick = function () {
      if (typeof confirmCallback === "function") {
        confirmCallback();
      }
      closeDialog();
    };

    // Exibir diálogo
    dialog.style.display = "flex";
    document.body.style.overflow = "hidden";
  }

  // Função para fechar o diálogo
  function closeDialog() {
    const dialog = document.getElementById("confirmationDialog");
    dialog.style.display = "none";
    document.body.style.overflow = "auto";
    confirmCallback = null;
  }

  // Fechar diálogo ao clicar fora do conteúdo
  document.addEventListener("DOMContentLoaded", function () {
    const dialog = document.getElementById("confirmationDialog");
    dialog.addEventListener("click", function (e) {
      if (e.target === dialog) {
        closeDialog();
      }
    });
  });

  // Substituir confirm() nativo pelo diálogo personalizado
  function setupCustomConfirms() {
    const destructiveLinks = document.querySelectorAll('a[onclick*="confirm"]');

    destructiveLinks.forEach((link) => {
      const originalOnclick = link.getAttribute("onclick");

      if (originalOnclick && originalOnclick.includes("confirm")) {
        // Extrair a mensagem de confirmação
        const messageMatch = originalOnclick.match(/confirm\('([^']+)'\)/);
        if (messageMatch && messageMatch[1]) {
          const message = messageMatch[1];

          // Substituir o onclick original
          link.onclick = function (e) {
            e.preventDefault();
            const targetUrl = link.getAttribute("href");

            showConfirmationDialog(message, "Confirmação", function () {
              window.location.href = targetUrl;
            });
          };

          // Remover o atributo onclick original para evitar duplicação
          link.removeAttribute("onclick");
        }
      }
    });
  }

  // Inicializar quando o DOM estiver carregado
  document.addEventListener("DOMContentLoaded", setupCustomConfirms);
</script>

<style>
  .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .dialog-container {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    width: 90%;
    max-width: 450px;
    overflow: hidden;
  }

  .dialog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 20px;
    border-bottom: 1px solid #eaeaea;
  }

  .dialog-title {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
  }

  .dialog-close {
    background: none;
    border: none;
    font-size: 1.2rem;
    cursor: pointer;
    color: #999;
    padding: 4px;
  }

  .dialog-close:hover {
    color: #666;
  }

  .dialog-body {
    padding: 24px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .dialog-icon {
    color: #e53e3e;
    font-size: 3rem;
    margin-bottom: 16px;
  }

  .dialog-message {
    margin: 0;
    color: #4a5568;
    line-height: 1.5;
  }

  .dialog-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    padding: 16px 20px;
    border-top: 1px solid #eaeaea;
  }

  .btn {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
  }

  .btn-secondary {
    background-color: #e2e8f0;
    color: #4a5568;
  }

  .btn-secondary:hover {
    background-color: #cbd5e0;
  }

  .btn-error {
    background-color: #e53e3e;
    color: white;
  }

  .btn-error:hover {
    background-color: #c53030;
  }
</style>
