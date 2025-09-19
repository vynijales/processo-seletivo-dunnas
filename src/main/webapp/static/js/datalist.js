// Função para alternar a exibição do painel de filtros
function toggleFilter() {
    const filterPanel = document.getElementById("filter-panel");
    filterPanel.classList.toggle("collapsed");

    // Opcional: Alterar o ícone do botão
    const filterButton = document.querySelector(".btn-filter i");
    if (filterPanel.classList.contains("collapsed")) {
        filterButton.className = "fas fa-filter";
    } else {
        filterButton.className = "fas fa-times";
    }
}

// Ex.: /usuarios
function clearSearch(path) {
    window.location.href = path;
}
