
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
                            Catálogo de livros
                        </h1>

                        <p class="text-gray-500 mt-3 max-w-2xl leading-relaxed">
                            Explore diferentes histórias, descubra novos autores
                            e encontre sua próxima leitura.
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
                            <c:out value="${empty livros ? 0 : livros.size()}"/>
                            livros
                        </span>

                    </div>

                </div>

            </header>


            <%-- Catálogo --%>
            <section aria-labelledby="catalogo-titulo">

                <div class="flex items-center justify-between gap-3 mb-6">

                    <h2 id="catalogo-titulo"
                        class="text-xl font-bold text-gray-900">
                        Todos os livros
                    </h2>

                    <span class="text-xs text-gray-400">
                        Biblioteca Lumina
                    </span>

                </div>


                <c:choose>

                    <c:when test="${not empty livros}">

                        <div class="grid grid-cols-2 sm:grid-cols-3
                                    lg:grid-cols-4 xl:grid-cols-5
                                    gap-4 md:gap-6">

                            <c:forEach items="${livros}" var="livro">

                                <article
                                    class="group min-w-0 bg-white rounded-2xl
                                           border border-gray-100 overflow-hidden
                                           hover:shadow-xl hover:-translate-y-1
                                           transition-all duration-300">

                                    <%-- Capa --%>
                                    <div class="relative aspect-[2/3]
                                                bg-gray-100 overflow-hidden">

                                        <c:choose>

                                            <c:when test="${not empty livro.capaUrl}">

                                                <img
                                                    src="<c:out value='${livro.capaUrl}'/>"
                                                    alt="Capa de <c:out value='${livro.titulo}'/>"
                                                    loading="lazy"
                                                    class="w-full h-full object-cover
                                                           group-hover:scale-105
                                                           transition-transform duration-500">

                                            </c:when>

                                            <c:otherwise>

                                                <div class="w-full h-full flex
                                                            flex-col items-center
                                                            justify-center p-4
                                                            text-gray-400">

                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                         width="40" height="40"
                                                         viewBox="0 0 24 24"
                                                         fill="none"
                                                         stroke="currentColor"
                                                         stroke-width="1.5"
                                                         stroke-linecap="round"
                                                         stroke-linejoin="round">

                                                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                                        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>

                                                    </svg>

                                                    <span class="text-xs mt-3 text-center">
                                                        Capa indisponível
                                                    </span>

                                                </div>

                                            </c:otherwise>

                                        </c:choose>

                                        <%-- Ano --%>
                                        <c:if test="${not empty livro.anoPublicacao}">

                                            <span class="absolute top-3 right-3
                                                         bg-white/95 text-gray-700
                                                         text-xs font-semibold
                                                         px-2.5 py-1 rounded-full
                                                         shadow-sm">

                                                <c:out value="${livro.anoPublicacao}"/>

                                            </span>

                                        </c:if>

                                    </div>


                                    <%-- Informações --%>
                                    <div class="p-3 md:p-4">

                                        <h3
                                            class="font-bold text-gray-900
                                                   text-sm md:text-base
                                                   leading-snug line-clamp-2
                                                   min-h-[2.5rem]"
                                            title="<c:out value='${livro.titulo}'/>">

                                            <c:out value="${livro.titulo}"/>

                                        </h3>

                                        <p class="text-xs md:text-sm text-gray-500
                                                  mt-2 line-clamp-1">

                                            <c:out value="${livro.autor}"/>

                                        </p>

                                        <p class="text-xs text-gray-500 mt-3
                                                  leading-relaxed line-clamp-3">

                                            <c:out value="${livro.sinopse}"/>

                                        </p>

                                        <div class="mt-4 pt-3 border-t border-gray-100">

                                            <c:choose>

                                                <c:when test="${not empty livro.editora}">

                                                    <p class="text-xs text-gray-400
                                                              line-clamp-1"
                                                       title="<c:out value='${livro.editora}'/>">

                                                        <c:out value="${livro.editora}"/>

                                                    </p>

                                                </c:when>

                                                <c:otherwise>

                                                    <p class="text-xs text-gray-400">
                                                        Editora não informada
                                                    </p>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>

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
                                Ainda não temos livros cadastrados.
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