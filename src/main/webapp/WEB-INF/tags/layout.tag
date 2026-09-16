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
            
            <header class="bg-principal text-white shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

                    <div class="flex flex-wrap items-center justify-between gap-4 py-4">

                        <%-- Logo --%>
                        <a href="${pageContext.request.contextPath}/inicio"
                        class="flex items-center gap-3 shrink-0 group">

                            <img
                                src="${pageContext.request.contextPath}/images/logo.png"
                                alt="Logo Lumina"
                                class="w-11 h-11 rounded-xl bg-white p-1 object-contain
                                    group-hover:scale-105 transition-transform">

                            <div>
                                <h1 class="text-2xl font-bold tracking-tight leading-none">
                                    Lumina
                                </h1>

                                <span class="text-xs text-white/70">
                                    Sua próxima leitura
                                </span>
                            </div>

                        </a>


                        <%-- Navegação --%>
                        <nav aria-label="Navegação principal"
                            class="flex items-center gap-1 sm:gap-2
                                    order-3 w-full sm:order-2 sm:w-auto">

                            <a href="${pageContext.request.contextPath}/inicio"
                            class="px-3 py-2 rounded-lg text-sm font-medium
                                    hover:bg-white/15 transition-colors">
                                Início
                            </a>

                            <a href="${pageContext.request.contextPath}/livros"
                            class="px-3 py-2 rounded-lg text-sm font-medium
                                    hover:bg-white/15 transition-colors">
                                Livros
                            </a>

                            <a href="${pageContext.request.contextPath}/generos"
                            class="px-3 py-2 rounded-lg text-sm font-medium
                                    hover:bg-white/15 transition-colors">
                                Gêneros
                            </a>

                        </nav>


                        <%-- Usuário e logout --%>
                        <div class="flex items-center gap-3 sm:gap-4
                                    order-2 sm:order-3 ml-auto sm:ml-0">

                            <div class="hidden sm:flex items-center gap-2">

                                <div class="w-9 h-9 rounded-full bg-white/15
                                            flex items-center justify-center
                                            text-sm font-bold uppercase">

                                    <c:out value="${usuarioLogado.nome.substring(0, 1)}"/>

                                </div>

                                <div class="flex items-center gap-1">
                                    <span class="text-xs text-white/70">
                                        Olá,
                                    </span>

                                    <span class="text-sm font-semibold max-w-32 truncate">
                                        <c:out value="${usuarioLogado.nome}"/>
                                    </span>
                                </div>

                            </div>

                            <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center gap-2
                                    bg-white text-principal
                                    hover:bg-white/90
                                    px-4 py-2 rounded-xl
                                    text-sm font-semibold
                                    transition-colors">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                    width="16" height="16"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    aria-hidden="true">

                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                    <path d="M16 17l5-5-5-5"/>
                                    <path d="M21 12H9"/>

                                </svg>

                                Sair
                            </a>

                        </div>

                    </div>

                </div>
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