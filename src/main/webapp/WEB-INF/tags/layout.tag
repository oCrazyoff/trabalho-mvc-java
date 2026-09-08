<%@ tag description="Layout Base" pageEncoding="UTF-8"%>
<%@ attribute name="titulo" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${not empty titulo ? titulo : 'Lumina'}</title>
    <!-- CSS do Tailwind compilado -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">
</head>
<body>

    <!-- Topbar / Navbar -->
    <header class="flex items-center justify-between bg-principal px-5 py-2 text-white shadow">
        <h1 class="text-xl font-bold">Lumina</h1>

        <div>
            <nav class="flex gap-4">
                <a href="${pageContext.request.contextPath}/home" class="hover:underline">Início</a>
                <a href="${pageContext.request.contextPath}/livros" class="hover:underline">Livros</a>
                <a href="${pageContext.request.contextPath}/recomendacoes" class="hover:underline">Recomendações</a>
            </nav>
            <c:if test="${not empty usuarioLogado}">
                <nav class="flex items-center gap-4">
                    <span>Olá, <strong>${usuarioLogado.nome}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-indigo-700 hover:bg-indigo-800 px-3 py-1 rounded text-sm transition">Sair</a>
                </nav>
            </c:if>
        </div>
    </header>

    <!-- Conteúdo Principal -->
    <main class="flex-1 max-w-7xl w-full mx-auto p-6">
        <!-- AQUI ENTRA O CONTEÚDO DE CADA PÁGINA -->
        <jsp:doBody/>
    </main>

    <!-- Rodapé -->
    <footer class="bg-white border-t border-gray-200 py-4 text-center text-sm text-gray-500">
        &copy; 2026 Sistema de Recomendação de Livros - Trabalho Acadêmico
    </footer>

</body>
</html>