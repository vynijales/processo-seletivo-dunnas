<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reserva de Salas - Sistema de Gerenciamento</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome Icons -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/static/images/fav.ico" />

    <!-- Estilização -->
    <link href="/static/css/main.css" rel="stylesheet" />

    <!-- Configuração customizada do Tailwind -->
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: {
                50: "#eff6ff",
                100: "#dbeafe",
                200: "#bfdbfe",
                300: "#93c5fd",
                400: "#60a5fa",
                500: "#3b82f6",
                600: "#2563eb",
                700: "#1d4ed8",
                800: "#1e40af",
                900: "#1e3a8a",
              },
            },
            fontFamily: {
              sans: ["Inter", "ui-sans-serif", "system-ui"],
            },
          },
        },
      };
    </script>
  </head>
  <body class="min-h-screen flex flex-col">
    <!-- Header -->
    <%@ include file="/WEB-INF/views/partials/header.jsp" %>

    <!-- Conteúdo Principal -->
    <main class="main-content flex-1 container mx-auto page-transition">
      <jsp:include page="${contentPage}" />
    </main>

    <!-- Footer -->
    <%@ include file="/WEB-INF/views/partials/footer.jsp" %>

    <!-- Scripts Adicionais -->
    <script>
      // Adiciona classe de transição para todos os links
      document.addEventListener("DOMContentLoaded", function () {
        // Melhora a acessibilidade
        const mainContent = document.querySelector(".main-content");
        if (mainContent) {
          mainContent.setAttribute("role", "main");
        }

        // Adiciona loading state para links
        const links = document.querySelectorAll("a");
        links.forEach((link) => {
          link.addEventListener("click", function (e) {
            if (
              this.getAttribute("href") &&
              !this.getAttribute("href").startsWith("#")
            ) {
              // Adiciona efeito de loading se necessário
              const spinner = document.createElement("i");
              spinner.className = "fas fa-spinner fa-spin ml-2";
              this.appendChild(spinner);
            }
          });
        });
      });

      // Função para exibir notificações (pode ser utilizada pelas páginas internas)
      window.showNotification = function (message, type = "info") {
        // Implementação básica de notificação
        console.log(`${type.toUpperCase()}: ${message}`);
        // Aqui poderia ser implementado um sistema de notificações toast
      };
    </script>
  </body>
</html>
