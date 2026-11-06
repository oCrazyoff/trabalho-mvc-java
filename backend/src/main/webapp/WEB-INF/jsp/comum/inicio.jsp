
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Início - Lumina">

    <main class="min-h-screen bg-gray-50/70">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 md:py-12">

            <%-- Cabeçalho da página --%>
            <header class="mb-10 md:mb-12">
                <span class="text-sm font-semibold text-principal uppercase tracking-widest">
                    Sua biblioteca pessoal
                </span>

                <h1 class="text-3xl md:text-4xl font-bold text-gray-900 mt-2">
                    Bem-vindo ao Lumina
                </h1>

                <p class="text-gray-500 mt-3 max-w-2xl leading-relaxed">
                    Descubra novas histórias, explore seus gêneros favoritos
                    e encontre sua próxima leitura.
                </p>
            </header>


            <%-- Gêneros de interesse --%>
            <section aria-labelledby="generos-titulo" class="mb-12">

                <div class="flex flex-wrap items-end justify-between gap-3 mb-5">
                    <div>
                        <h2 id="generos-titulo"
                            class="text-xl md:text-2xl font-bold text-gray-900">
                            Seus gêneros favoritos
                        </h2>

                        <p class="text-sm text-gray-500 mt-1">
                            Histórias selecionadas de acordo com seus interesses.
                        </p>
                    </div>

                    <span class="text-sm font-medium text-principal">
                        <c:out value="${empty generos ? 0 : generos.size()}"/>
                        gêneros
                    </span>
                </div>

                <c:choose>
                    <c:when test="${not empty generos}">

                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">

                            <c:forEach items="${generos}" var="genero">

                                <article
                                    class="group relative bg-white border border-gray-100
                                           rounded-2xl p-5 md:p-6
                                           hover:border-principal/30 hover:shadow-md
                                           transition-all duration-300">

                                    <div class="flex items-start justify-between gap-3">

                                        <div class="min-w-0">
                                            <h3 class="text-lg font-bold text-gray-900
                                                       group-hover:text-principal
                                                       transition-colors">
                                                <c:out value="${genero.nome}"/>
                                            </h3>
                                        </div>

                                        <span class="shrink-0 flex items-center justify-center
                                                     w-9 h-9 rounded-xl
                                                     bg-principal/10 text-principal
                                                     text-sm font-bold">
                                            <c:out value="${genero.nome.substring(0, 1).toUpperCase()}"/>
                                        </span>

                                    </div>

                                    <p class="text-sm text-gray-500 mt-3 leading-relaxed
                                              line-clamp-2">
                                        <c:out value="${genero.descricao}"/>
                                    </p>

                                </article>

                            </c:forEach>

                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="bg-white border border-dashed border-gray-300
                                    rounded-2xl p-8 text-center">

                            <div class="w-12 h-12 rounded-2xl bg-gray-100
                                        flex items-center justify-center mx-auto mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="1.7" stroke-linecap="round"
                                     stroke-linejoin="round"
                                     class="text-gray-400">
                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2Z"/>
                                </svg>
                            </div>

                            <h3 class="font-semibold text-gray-900">
                                Sua biblioteca começa aqui
                            </h3>

                            <p class="text-sm text-gray-500 mt-2 max-w-md mx-auto">
                                Você ainda não selecionou seus gêneros favoritos.
                                Escolha os assuntos que mais despertam sua curiosidade.
                            </p>

                        </div>

                    </c:otherwise>
                </c:choose>

            </section>


            <%-- Livros recomendados --%>
            <section aria-labelledby="livros-titulo">

                <div class="mb-6">
                    <span class="text-xs font-bold text-principal uppercase tracking-widest">
                        Feitos para você
                    </span>

                    <h2 id="livros-titulo"
                        class="text-2xl md:text-3xl font-bold text-gray-900 mt-2">
                        Livros recomendados
                    </h2>

                    <p class="text-sm text-gray-500 mt-2">
                        Novas histórias para sua próxima aventura literária.
                    </p>
                </div>


                <c:choose>
                    <c:when test="${not empty livrosRecomendados}">

                        <div class="grid grid-cols-2 sm:grid-cols-3
                                    lg:grid-cols-4 xl:grid-cols-5 gap-4 md:gap-6">

                            <c:forEach items="${livrosRecomendados}" var="livro">

                                <article
                                    class="group min-w-0 bg-white rounded-2xl
                                           border border-gray-100 overflow-hidden
                                           hover:shadow-xl hover:-translate-y-1
                                           transition-all duration-300">

                                    <%-- Capa do livro --%>
                                    <div class="relative aspect-[2/3] bg-gray-100
                                                overflow-hidden">

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

                                                <div class="w-full h-full flex flex-col
                                                            items-center justify-center
                                                            text-gray-400 p-4">

                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                         width="36" height="36"
                                                         viewBox="0 0 24 24"
                                                         fill="none" stroke="currentColor"
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

                                        <%-- Ano da publicação --%>
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


                                    <%-- Informações do livro --%>
                                    <div class="p-3 md:p-4 flex flex-col">

                                        <h3 class="font-bold text-gray-900
                                                   text-sm md:text-base leading-snug
                                                   line-clamp-2 min-h-[2.5rem]"
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

                                        <div class="mt-4 pt-3 border-t border-gray-100
                                                    flex flex-col gap-1">

                                            <c:if test="${not empty livro.editora}">
                                                <span class="text-xs text-gray-400
                                                             line-clamp-1">
                                                    <c:out value="${livro.editora}"/>
                                                </span>
                                            </c:if>

                                        </div>

                                    </div>

                                </article>

                            </c:forEach>

                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="bg-white border border-gray-100
                                    rounded-2xl p-8 md:p-12 text-center">

                            <div class="w-14 h-14 rounded-2xl bg-principal/10
                                        flex items-center justify-center
                                        mx-auto mb-5 text-principal">

                                <svg xmlns="http://www.w3.org/2000/svg"
                                     width="28" height="28"
                                     viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor"
                                     stroke-width="1.7"
                                     stroke-linecap="round"
                                     stroke-linejoin="round">
                                    <path d="M12 7v14"/>
                                    <path d="M3 18V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v13"/>
                                    <path d="M3 18a3 3 0 0 0 3 3h15"/>
                                    <path d="M3 18a3 3 0 0 1 3-3h15"/>
                                </svg>

                            </div>

                            <h3 class="text-lg font-bold text-gray-900">
                                Ainda não há recomendações
                            </h3>

                            <p class="text-sm text-gray-500 mt-2 max-w-md mx-auto">
                                Estamos esperando novos livros para recomendar.
                                Volte em breve para descobrir novas leituras!
                            </p>

                        </div>

                    </c:otherwise>
                </c:choose>

            </section>

        </div>
    </main>

</t:layout>