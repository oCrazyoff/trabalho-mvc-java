<%@ tag description="Layout Base" pageEncoding="UTF-8"%>
<%@ attribute name="titulo" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
        <title>${not empty titulo ? titulo : 'Lumina'}</title>
        <!-- CSS do Tailwind compilado -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">
    </head>
    <body>

        <!-- Topbar / Navbar -->
        <c:if test="${not empty usuarioLogado}">
            <header class="flex items-center justify-between bg-principal px-10 py-4 text-white shadow">
                <h1 class="flex gap-2 items-center text-xl font-bold"><img class="bg-white rounded-lg h-10 w-10" src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"> Lumina</h1>

                <nav class="flex gap-4">
                    <a href="${pageContext.request.contextPath}/inicio" class="hover:underline">Início</a>
                    <a href="${pageContext.request.contextPath}/livros" class="hover:underline">Livros</a>
                    <a href="${pageContext.request.contextPath}/recomendacoes" class="hover:underline">Recomendações</a>
                </nav>

                <nav class="flex items-center gap-4">
                    <span>Olá, <strong>${usuarioLogado.nome}</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="bg-indigo-700 hover:bg-indigo-800 px-3 py-1 rounded text-sm transition">Sair</a>
                </nav>
            </header>
        </c:if>

        <!-- Conteúdo Principal -->
        <main>
            <!-- AQUI ENTRA O CONTEÚDO DE CADA PÁGINA -->
            <jsp:doBody/>
        </main>

        <!-- Rodapé -->
        <footer class="bg-white border-t border-gray-200 py-4 text-center text-sm text-gray-500">
            &copy; 2026 Sistema de Recomendação de Livros Lumina - Trabalho Acadêmico
        </footer>

        <script src="https://unpkg.com/lucide@latest"></script>

        <script>
            lucide.createIcons();
        </script>
    </body>
</html>