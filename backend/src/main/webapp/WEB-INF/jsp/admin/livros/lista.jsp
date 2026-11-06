
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Livros - Lumina">
    <div class="container mx-auto max-w-7xl p-4 sm:p-6 lg:p-8">

        <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <span class="text-sm font-semibold uppercase tracking-wider text-principal">
                    Administração
                </span>
                <h1 class="mt-2 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
                    Livros
                </h1>
                <p class="mt-2 text-gray-500">
                    Consulte, cadastre e gerencie os livros do acervo.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/livros?acao=novo"
               class="inline-flex items-center justify-center gap-2 rounded-xl bg-principal px-5 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-principal-hover focus:outline-none focus:ring-2 focus:ring-principal focus:ring-offset-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M12 5v14m-7-7h14"/>
                </svg>
                Novo Livro
            </a>
        </div>

        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
            <div class="border-b border-gray-100 px-5 py-4 sm:px-6">
                <h2 class="font-semibold text-gray-900">Acervo cadastrado</h2>
                <p class="mt-1 text-sm text-gray-500">
                    Lista de livros disponíveis no sistema.
                </p>
            </div>

            <c:choose>
                <c:when test="${not empty livros}">
                    <div class="overflow-x-auto">
                        <table class="w-full min-w-[760px] divide-y divide-gray-100 text-left">
                            <thead class="bg-gray-50">
                                <tr class="text-xs font-semibold uppercase tracking-wider text-gray-500">
                                    <th scope="col" class="px-5 py-4">Capa</th>
                                    <th scope="col" class="px-5 py-4">Título</th>
                                    <th scope="col" class="px-5 py-4">Autor</th>
                                    <th scope="col" class="px-5 py-4">Editora</th>
                                    <th scope="col" class="px-5 py-4">Ano</th>
                                    <th scope="col" class="px-5 py-4 text-right">Ações</th>
                                </tr>
                            </thead>

                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="livro" items="${livros}">
                                    <tr class="transition hover:bg-gray-50/70">
                                        <td class="px-5 py-4">
                                            <c:choose>
                                                <c:when test="${not empty livro.capaUrl}">
                                                    <img src="<c:out value='${livro.capaUrl}'/>"
                                                         alt="Capa de <c:out value='${livro.titulo}'/>"
                                                         class="h-16 w-12 rounded-lg object-cover shadow-sm ring-1 ring-gray-200"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="flex h-16 w-12 items-center justify-center rounded-lg bg-principal/10 text-principal"
                                                         aria-label="Sem capa">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6"
                                                             fill="none" viewBox="0 0 24 24"
                                                             stroke="currentColor" stroke-width="1.6">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                  d="M5 4.75A1.75 1.75 0 0 1 6.75 3H20v16H6.75A1.75 1.75 0 0 0 5 20.75V4.75Z"/>
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                  d="M5 5v15.75M9 7h7m-7 4h7"/>
                                                        </svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="px-5 py-4">
                                            <span class="block max-w-xs font-semibold text-gray-900">
                                                <c:out value="${livro.titulo}"/>
                                            </span>
                                        </td>

                                        <td class="px-5 py-4 text-sm text-gray-600">
                                            <c:out value="${livro.autor}"/>
                                        </td>

                                        <td class="px-5 py-4 text-sm text-gray-600">
                                            <c:out value="${livro.editora}"/>
                                        </td>

                                        <td class="px-5 py-4 text-sm text-gray-600">
                                            <c:out value="${livro.anoPublicacao}"/>
                                        </td>

                                        <td class="px-5 py-4">
                                            <div class="flex items-center justify-end gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/livros?acao=editar&id=${livro.id}"
                                                   class="inline-flex items-center gap-1.5 rounded-lg border border-principal/20 px-3 py-2 text-sm font-medium text-principal transition hover:bg-principal/10 focus:outline-none focus:ring-2 focus:ring-principal"
                                                   aria-label="Editar livro">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4"
                                                         fill="none" viewBox="0 0 24 24"
                                                         stroke="currentColor" stroke-width="1.8">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                              d="m16.862 4.487 2.651 2.651M4 20l4.5-1 11.013-11.013a1.875 1.875 0 0 0-2.652-2.652L5.848 16.348 4 20Z"/>
                                                    </svg>
                                                    Editar
                                                </a>

                                                <a href="${pageContext.request.contextPath}/admin/livros?acao=excluir&id=${livro.id}"
                                                   onclick="return confirm('Deseja excluir este livro?')"
                                                   class="inline-flex items-center gap-1.5 rounded-lg border border-red-200 px-3 py-2 text-sm font-medium text-red-600 transition hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-red-400"
                                                   aria-label="Excluir livro">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4"
                                                         fill="none" viewBox="0 0 24 24"
                                                         stroke="currentColor" stroke-width="1.8">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                              d="M6 7h12m-10 0 .7 13h6.6L16 7M9 7V4h6v3m-5 3v6m4-6v6"/>
                                                    </svg>
                                                    Excluir
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="flex flex-col items-center px-6 py-16 text-center">
                        <div class="flex h-14 w-14 items-center justify-center rounded-2xl bg-principal/10 text-principal">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7"
                                 fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor" stroke-width="1.7">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M5 4.75A1.75 1.75 0 0 1 6.75 3H20v16H6.75A1.75 1.75 0 0 0 5 20.75V4.75Z"/>
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M5 5v15.75M9 7h7m-7 4h7"/>
                            </svg>
                        </div>
                        <h3 class="mt-4 text-lg font-semibold text-gray-900">
                            Nenhum livro cadastrado
                        </h3>
                        <p class="mt-2 max-w-sm text-sm text-gray-500">
                            Cadastre o primeiro livro para começar a montar o acervo.
                        </p>
                        <a href="${pageContext.request.contextPath}/admin/livros?acao=novo"
                           class="mt-5 rounded-xl bg-principal px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-principal-hover">
                            Cadastrar primeiro livro
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</t:layout>