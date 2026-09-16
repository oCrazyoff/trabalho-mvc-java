<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout titulo="Catálogo de Livros - Lumina">
    <div class="max-w-6xl mx-auto py-8 px-4">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Todos os Livros</h1>

        <c:choose>
            <c:when test="${not empty livros}">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <c:forEach items="${livros}" var="livro">
                        <div class="bg-white rounded-lg shadow border border-gray-100 overflow-hidden flex flex-col hover:shadow-lg transition">
                            <div class="h-56 bg-gray-100 flex items-center justify-center overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty livro.capaUrl}">
                                        <img src="${livro.capaUrl}" alt="${livro.titulo}" class="w-full h-full object-cover">
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-400 text-sm">Sem capa</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="p-4 flex-1 flex flex-col justify-between">
                                <div>
                                    <h3 class="font-bold text-gray-900 line-clamp-1" title="${livro.titulo}">${livro.titulo}</h3>
                                    <p class="text-xs text-gray-600 mb-2">Por: <span class="font-medium">${livro.autor}</span></p>
                                    <p class="text-xs text-gray-500 line-clamp-3">${livro.sinopse}</p>
                                </div>
                                <div class="mt-4 pt-3 border-t border-gray-100 text-xs text-gray-400 flex justify-between">
                                    <span>${livro.editora}</span>
                                    <span>${livro.anoPublicacao}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-gray-500">Nenhum livro cadastrado no sistema.</p>
            </c:otherwise>
        </c:choose>
    </div>
</t:layout>