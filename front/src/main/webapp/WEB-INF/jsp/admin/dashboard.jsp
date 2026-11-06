<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Dashboard - Lumina">
    <div class="container mx-auto max-w-7xl p-4 sm:p-6 lg:p-8">

        <!-- Header / Visão Geral -->
        <div class="mb-8">
            <span class="text-sm font-semibold uppercase tracking-wider text-principal">
                Visão geral
            </span>
            <h1 class="mt-2 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
                Painel do Administrador
            </h1>
            <p class="mt-2 text-gray-500">
                Acompanhe os dados e gerencie o sistema Lumina.
            </p>
        </div>

        <!-- Grid de Cards -->
        <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 xl:grid-cols-4">

            <!-- Card: Livros -->
            <div class="group rounded-2xl border border-gray-100 bg-white p-5 shadow-sm transition duration-200 hover:-translate-y-1 hover:border-principal/30 hover:shadow-lg">
                <div class="flex items-start justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-principal/10 text-principal">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 7v14m0-14C10.5 5.5 8.5 5 5 5v14c3.5 0 5.5.5 7 2m0-14c1.5-1.5 3.5-2 7-2v14c-3.5 0-5.5.5-7 2"/>
                        </svg>
                    </div>
                    <span class="rounded-full bg-gray-50 px-2.5 py-1 text-xs font-medium text-gray-500">
                        Acervo
                    </span>
                </div>

                <p class="mt-5 text-sm font-medium text-gray-500">Livros cadastrados</p>
                <p class="mt-1 text-3xl font-bold tracking-tight text-gray-900">
                    <c:out value="${totalLivros}" default="0"/>
                </p>
                <p class="mt-2 text-sm text-gray-400">Total de livros no sistema</p>
            </div>

            <!-- Card: Gêneros -->
            <div class="group rounded-2xl border border-gray-100 bg-white p-5 shadow-sm transition duration-200 hover:-translate-y-1 hover:border-principal/30 hover:shadow-lg">
                <div class="flex items-start justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-principal/10 text-principal">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v16H6.5A2.5 2.5 0 0 0 4 21.5v-16Z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" d="M4 5.5v16M8 7h8m-8 4h6"/>
                        </svg>
                    </div>
                    <span class="rounded-full bg-gray-50 px-2.5 py-1 text-xs font-medium text-gray-500">
                        Categorias
                    </span>
                </div>

                <p class="mt-5 text-sm font-medium text-gray-500">Gêneros cadastrados</p>
                <p class="mt-1 text-3xl font-bold tracking-tight text-gray-900">
                    <c:out value="${totalGeneros}" default="0"/>
                </p>
                <p class="mt-2 text-sm text-gray-400">Gêneros disponíveis para classificação</p>
            </div>

            <!-- Card: Usuários -->
            <div class="group rounded-2xl border border-gray-100 bg-white p-5 shadow-sm transition duration-200 hover:-translate-y-1 hover:border-principal/30 hover:shadow-lg">
                <div class="flex items-start justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-principal/10 text-principal">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2m6-10a4 4 0 1 0 0-8 4 4 0 0 0 0 8Zm7-3a4 4 0 0 1 0 8m3 5v-2a4 4 0 0 0-3-3.87"/>
                        </svg>
                    </div>
                    <span class="rounded-full bg-gray-50 px-2.5 py-1 text-xs font-medium text-gray-500">
                        Comunidade
                    </span>
                </div>

                <p class="mt-5 text-sm font-medium text-gray-500">Usuários cadastrados</p>
                <p class="mt-1 text-3xl font-bold tracking-tight text-gray-900">
                    <c:out value="${totalUsuarios}" default="0"/>
                </p>
                <p class="mt-2 text-sm text-gray-400">Pessoas com acesso ao sistema</p>
            </div>

            <!-- Card: Livro mais recomendado -->
            <div class="relative overflow-hidden rounded-2xl border border-principal/20 bg-gradient-to-br from-principal/10 via-white to-white p-5 shadow-sm transition duration-200 hover:-translate-y-1 hover:shadow-lg">
                <div class="absolute -right-8 -top-8 h-28 w-28 rounded-full bg-principal/10"></div>

                <div class="relative flex items-start justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-white text-principal shadow-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="m12 3 2.7 5.5 6.1.9-4.4 4.3 1 6.1-5.4-2.9-5.4 2.9 1-6.1-4.4-4.3 6.1-.9L12 3Z"/>
                        </svg>
                    </div>
                    <span class="rounded-full bg-white/80 px-2.5 py-1 text-xs font-semibold text-principal">
                        Destaque
                    </span>
                </div>

                <p class="relative mt-5 text-sm font-medium text-gray-500">
                    Livro mais recomendado
                </p>

                <c:choose>
                    <c:when test="${not empty livroMaisRecomendado}">
                        <h2 class="relative mt-2 line-clamp-2 break-words text-xl font-bold leading-snug text-gray-900">
                            <c:out value="${livroMaisRecomendado.titulo}"/>
                        </h2>
                        <p class="relative mt-2 text-sm text-gray-500">
                            Livro com maior número de recomendações
                        </p>
                    </c:when>
                    <c:otherwise>
                        <h2 class="relative mt-2 text-xl font-bold text-gray-900">
                            Nenhum destaque
                        </h2>
                        <p class="relative mt-2 text-sm text-gray-500">
                            Ainda não há recomendações registradas.
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <!-- Container dos gráficos -->
        <div class="mt-6 grid grid-cols-1 gap-5 md:grid-cols-2">

            <!-- Gráfico: gêneros mais populares -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm">
                <h2 class="text-lg font-semibold text-gray-800">
                    Gêneros mais populares
                </h2>
                <p class="mb-5 mt-1 text-sm text-gray-500">
                    Quantidade de usuários por gênero favorito
                </p>

                <div class="relative h-72">
                    <canvas id="graficoGenerosPopulares"></canvas>
                </div>
            </div>

            <!-- Gráfico: livros por gênero -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm">
                <h2 class="text-lg font-semibold text-gray-800">
                    Livros por gênero
                </h2>
                <p class="mb-5 mt-1 text-sm text-gray-500">
                    Distribuição de livros no catálogo
                </p>

                <div class="relative h-72">
                    <canvas id="graficoLivrosPorGenero"></canvas>
                </div>
            </div>

        </div>

        <!-- Dados dos gêneros mais populares -->
        <div id="dadosGenerosPopulares" class="hidden">
            <c:forEach items="${generosMaisPopulares}" var="e">
                <span data-label="<c:out value='${e.key}'/>" data-value="<c:out value='${e.value}'/>"></span>
            </c:forEach>
        </div>

        <!-- Dados dos livros por gênero -->
        <div id="dadosLivrosPorGenero" class="hidden">
            <c:forEach items="${livrosPorGenero}" var="e">
                <span data-label="<c:out value='${e.key}'/>" data-value="<c:out value='${e.value}'/>"></span>
            </c:forEach>
        </div>

    </div>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        // Recupera os dados gerados pelo JSP
        function obterDados(id) {
            const container = document.getElementById(id);
            if (!container) return { labels: [], valores: [] };
            
            const elementos = container.querySelectorAll("span");
            
            return {
                labels: Array.from(elementos, e => e.dataset.label),
                valores: Array.from(elementos, e => Number(e.dataset.value))
            };
        }
        
        const dadosGeneros = obterDados("dadosGenerosPopulares");
        const dadosLivros = obterDados("dadosLivrosPorGenero");
        
        // Configurações compartilhadas
        Chart.defaults.font.family = "inherit";
        Chart.defaults.color = "#6B7280";
        
        // Gráfico 1: gêneros mais populares
        new Chart(
        document.getElementById("graficoGenerosPopulares"),
        {
            type: "bar",
            data: {
                labels: dadosGeneros.labels,
                datasets: [{
                    label: "Usuários",
                    data: dadosGeneros.valores,
                    backgroundColor: "#6366F1",
                    borderRadius: 6,
                    maxBarThickness: 32
                }]
            },
            options: {
                indexAxis: "y",
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: { precision: 0 },
                        grid: { color: "#F3F4F6" }
                    },
                    y: {
                        grid: { display: false }
                    }
                }
            }
        }
        );
        
        // Gráfico 2: livros por gênero
        new Chart(
        document.getElementById("graficoLivrosPorGenero"),
        {
            type: "bar",
            data: {
                labels: dadosLivros.labels,
                datasets: [{
                    label: "Livros",
                    data: dadosLivros.valores,
                    backgroundColor: "#6366F1",
                    borderRadius: 6,
                    maxBarThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { precision: 0 },
                        grid: { color: "#F3F4F6" }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        }
        );
    </script>
</t:layout>