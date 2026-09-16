
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Catálogo de Livros - Lumina">

    <main class="min-h-screen bg-gray-50/70">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 md:py-12">

            <%-- Cabeçalho --%>
            <header class="mb-10">

                <span class="text-sm font-semibold text-principal
                             uppercase tracking-widest">
                    Explore a biblioteca
                </span>

                <div class="flex flex-wrap items-end justify-between gap-4 mt-2">

                    <div>
                        <h1 class="text-3xl md:text-4xl font-bold text-gray-900">
                            Catálogo de Gêneros
                        </h1>

                        <p class="text-gray-500 mt-3 max-w-2xl leading-relaxed">
                            Explore diferentes gêneros de histórias, categorias de livros e etc.
                        </p>
                    </div>

                    <div class="flex items-center gap-2 bg-white
                                border border-gray-100 rounded-xl px-4 py-3">

                        <svg xmlns="http://www.w3.org/2000/svg"
                             width="20" height="20"
                             viewBox="0 0 24 24"
                             fill="none" stroke="currentColor"
                             stroke-width="1.7" stroke-linecap="round"
                             stroke-linejoin="round"
                             class="text-principal">

                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                        </svg>

                        <span class="text-sm font-semibold text-gray-700">
                            <c:out value="${empty generos ? 0 : generos.size()}"/>
                            gêneros
                        </span>

                    </div>

                </div>

            </header>


            <%-- Catálogo --%>
            <section aria-labelledby="catalogo-titulo">

                <div class="flex items-center justify-between gap-3 mb-6">

                    <h2 id="catalogo-titulo"
                        class="text-xl font-bold text-gray-900">
                        Todos os gêneros
                    </h2>

                    <span class="text-xs text-gray-400">
                        Biblioteca Lumina
                    </span>

                </div>


                <c:choose>

                    <c:when test="${not empty generos}">

                        <div class="grid grid-cols-2 sm:grid-cols-3
                                    lg:grid-cols-4 xl:grid-cols-5
                                    gap-4 md:gap-6">

                            <c:forEach items="${generos}" var="genero">

                                <c:set var="estaSalvo" value="${generosSalvosIds != null and generosSalvosIds.contains(genero.id)}" />

                                <article class="group relative bg-white border ${estaSalvo ? 'border-principal ring-2 ring-principal/20 bg-principal/5' : 'border-gray-100'}
                                                rounded-2xl p-5 md:p-6 hover:shadow-md transition-all duration-300">

                                    <div class="flex items-start justify-between gap-3">
                                        <div class="min-w-0">
                                            <h3 class="text-lg font-bold text-gray-900 group-hover:text-principal transition-colors">
                                                <c:out value="${genero.nome}"/>
                                            </h3>
                                        </div>

                                        <%-- Botão de Marcar / Desmarcar --%>
                                        <form action="${pageContext.request.contextPath}/generos" method="post" class="shrink-0">
                                            <input type="hidden" name="generoId" value="${genero.id}"/>
                                            <button type="submit"
                                                    title="${estaSalvo ? 'Remover dos favoritos' : 'Salvar gênero'}"
                                                    class="flex items-center justify-center w-9 h-9 rounded-xl transition-colors
                                                        ${estaSalvo 
                                                            ? 'bg-principal text-white shadow-sm hover:bg-principal/90' 
                                                            : 'bg-gray-100 text-gray-400 hover:text-principal hover:bg-principal/10'}">
                                                <c:choose>
                                                    <c:when test="${estaSalvo}">
                                                        <%-- Ícone de Check / Marcado --%>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="20 6 9 17 4 12"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- Ícone de Adicionar (+) / Desmarcado --%>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <line x1="12" y1="5" x2="12" y2="19"/>
                                                            <line x1="5" y1="12" x2="19" y2="12"/>
                                                        </svg>
                                                    </c:otherwise>
                                                </c:choose>
                                            </button>
                                        </form>
                                    </div>

                                    <p class="text-sm text-gray-500 mt-3 leading-relaxed line-clamp-2">
                                        <c:out value="${genero.descricao}"/>
                                    </p>

                                    <div class="mt-4 pt-3 border-t border-gray-100 flex items-center justify-between text-xs font-medium">
                                        <span class="${estaSalvo ? 'text-principal font-semibold' : 'text-gray-400'}">
                                            ${estaSalvo ? '● Salvo na sua biblioteca' : 'Não salvo'}
                                        </span>
                                    </div>
                                </article>

                            </c:forEach>

                        </div>

                    </c:when>


                    <%-- Catálogo vazio --%>
                    <c:otherwise>

                        <div class="bg-white border border-dashed
                                    border-gray-300 rounded-2xl
                                    px-6 py-12 md:py-16 text-center">

                            <div class="w-16 h-16 rounded-2xl
                                        bg-principal/10 text-principal
                                        flex items-center justify-center
                                        mx-auto mb-5">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="32" height="32"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="1.5"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">

                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                                </svg>

                            </div>

                            <h3 class="text-xl font-bold text-gray-900">
                                Sua biblioteca está começando
                            </h3>

                            <p class="text-sm text-gray-500 mt-3
                                      max-w-md mx-auto leading-relaxed">
                                Ainda não temos gêneros cadastrados.
                                Em breve, novas histórias estarão disponíveis
                                para você explorar.
                            </p>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>

        </div>
    </main>

</t:layout>